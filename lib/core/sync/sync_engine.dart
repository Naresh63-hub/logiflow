import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../network/connectivity_service.dart';
import '../network/supabase_config.dart';
import 'conflict_resolver.dart';
import 'sync_operation.dart';

class SyncState {
  final int pendingCount;
  final bool isSyncing;
  final DateTime? lastSyncTime;
  final String? lastError;

  const SyncState({
    this.pendingCount = 0,
    this.isSyncing = false,
    this.lastSyncTime,
    this.lastError,
  });

  SyncState copyWith({
    int? pendingCount,
    bool? isSyncing,
    DateTime? lastSyncTime,
    String? lastError,
  }) {
    return SyncState(
      pendingCount: pendingCount ?? this.pendingCount,
      isSyncing: isSyncing ?? this.isSyncing,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      lastError: lastError,
    );
  }
}

class SyncEngine extends StateNotifier<SyncState> {
  final AppDatabase _db;
  final ConnectivityService _connectivity;
  StreamSubscription? _connectivitySub;
  bool _isProcessing = false;

  SyncEngine(this._db, this._connectivity) : super(const SyncState()) {
    _init();
  }

  void _init() {
    _updatePendingCount();

    _connectivitySub = _connectivity.statusStream.listen((status) {
      if (status == NetworkStatus.online) {
        debugPrint('[SyncEngine] Connectivity restored. Initiating automatic sync.');
        syncNow();
      }
    });
  }

  Future<void> _updatePendingCount() async {
    final pendingOps = await (_db.select(_db.syncQueue)
          ..where((tbl) => tbl.syncStatus.equals('pending') | tbl.syncStatus.equals('failed')))
        .get();
    state = state.copyWith(pendingCount: pendingOps.length);
  }

  Future<void> enqueueOperation(SyncOperationModel op) async {
    await _db.into(_db.syncQueue).insertOnConflictUpdate(
          SyncQueueCompanion.insert(
            operationId: op.operationId,
            userId: op.userId,
            shipmentId: op.shipmentId,
            operationType: op.operationType.dbValue,
            payloadJson: op.payloadJson,
            localTimestamp: op.localTimestamp,
            syncStatus: const Value('pending'),
            retryCount: const Value(0),
          ),
        );

    await _updatePendingCount();

    final online = await _connectivity.isConnected();
    if (online) {
      syncNow();
    }
  }

  Future<void> syncNow() async {
    if (_isProcessing) return;
    _isProcessing = true;
    state = state.copyWith(isSyncing: true, lastError: null);

    try {
      final pendingOps = await (_db.select(_db.syncQueue)
            ..where((tbl) => tbl.syncStatus.equals('pending') | tbl.syncStatus.equals('failed'))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.localTimestamp)]))
          .get();

      debugPrint('[SyncEngine] Processing ${pendingOps.length} pending operations.');

      for (final rawOp in pendingOps) {
        final payload = jsonDecode(rawOp.payloadJson) as Map<String, dynamic>;
        final op = SyncOperationModel(
          operationId: rawOp.operationId,
          userId: rawOp.userId,
          shipmentId: rawOp.shipmentId,
          operationType: SyncOperationType.fromString(rawOp.operationType),
          payload: payload,
          localTimestamp: rawOp.localTimestamp,
          syncStatus: rawOp.syncStatus,
          retryCount: rawOp.retryCount,
          lastError: rawOp.lastError,
        );

        await _processSingleOperation(op);
      }

      state = state.copyWith(
        isSyncing: false,
        lastSyncTime: DateTime.now(),
      );
    } catch (e) {
      debugPrint('[SyncEngine] Sync cycle encountered error: $e');
      state = state.copyWith(isSyncing: false, lastError: e.toString());
    } finally {
      _isProcessing = false;
      await _updatePendingCount();
    }
  }

  Future<void> _processSingleOperation(SyncOperationModel op) async {
    try {
      final supabase = SupabaseConfig.client;

      if (supabase != null && SupabaseConfig.isRealBackendConfigured) {
        final authUserId = supabase.auth.currentUser?.id ?? op.userId;

        switch (op.operationType) {
          case SyncOperationType.createShipment:
            await _syncCreateShipment(supabase, op, authUserId);
            break;

          case SyncOperationType.updateStatus:
            await _syncUpdateStatus(supabase, op, authUserId);
            break;

          case SyncOperationType.assignDriver:
            await _syncAssignDriver(supabase, op, authUserId);
            break;

          case SyncOperationType.submitPOD:
            await _syncSubmitPOD(supabase, op, authUserId);
            break;
        }
      }

      // Mark operation as synced in local Drift SQLite
      await (_db.update(_db.syncQueue)..where((tbl) => tbl.operationId.equals(op.operationId))).write(
        SyncQueueCompanion(
          syncStatus: const Value('synced'),
          retryCount: Value(op.retryCount + 1),
          lastError: const Value(null),
        ),
      );

      // Clear dirty flag and mark synced on local shipment
      await (_db.update(_db.shipments)..where((tbl) => tbl.id.equals(op.shipmentId))).write(
        ShipmentsCompanion(
          isDirty: const Value(false),
          syncStatus: const Value('synced'),
        ),
      );
    } catch (e) {
      debugPrint('[SyncEngine] Failed to sync op ${op.operationId}: $e');
      await (_db.update(_db.syncQueue)..where((tbl) => tbl.operationId.equals(op.operationId))).write(
        SyncQueueCompanion(
          syncStatus: const Value('failed'),
          retryCount: Value(op.retryCount + 1),
          lastError: Value(e.toString()),
        ),
      );
    }
  }

  Future<void> _syncCreateShipment(
    SupabaseClient supabase,
    SyncOperationModel op,
    String authUserId,
  ) async {
    final payload = Map<String, dynamic>.from(op.payload);
    payload['sender_id'] = authUserId;
    await supabase.from('shipments').upsert(payload);

    final localEvents = await (_db.select(_db.shipmentEvents)
          ..where((tbl) => tbl.shipmentId.equals(op.shipmentId)))
        .get();

    for (final ev in localEvents) {
      await supabase.from('shipment_events').upsert({
        'id': ev.id,
        'shipment_id': ev.shipmentId,
        'previous_status': ev.previousStatus,
        'new_status': ev.newStatus,
        'location_name': ev.locationName,
        'latitude': ev.latitude,
        'longitude': ev.longitude,
        'remarks': ev.remarks,
        'updated_by': authUserId,
        'created_at': ev.createdAt.toIso8601String(),
      });
    }

    await _logSyncOp(supabase, op, authUserId, status: 'synced');
  }

  Future<void> _syncUpdateStatus(
    SupabaseClient supabase,
    SyncOperationModel op,
    String authUserId,
  ) async {
    final serverShipment = await supabase
        .from('shipments')
        .select()
        .eq('id', op.shipmentId)
        .maybeSingle();

    String syncOutcome = 'synced';

    if (serverShipment != null) {
      final clientShipment = await (_db.select(_db.shipments)
            ..where((tbl) => tbl.id.equals(op.shipmentId)))
          .getSingleOrNull();
      final clientVersion = clientShipment?.version ?? 1;

      final conflictResult = ConflictResolver.resolve(
        operation: op,
        serverShipmentData: serverShipment,
        clientVersion: clientVersion,
      );

      if (conflictResult.createsAuditEvent) {
        syncOutcome = 'conflict';
      }

      if (conflictResult.strategy == ConflictStrategy.serverWins) {
        // Server state wins (e.g. shipment already delivered); reconcile local DB
        final serverStatus = serverShipment['current_status'] as String;
        final serverVer = serverShipment['version'] as int? ?? clientVersion;
        await (_db.update(_db.shipments)..where((tbl) => tbl.id.equals(op.shipmentId))).write(
          ShipmentsCompanion(
            currentStatus: Value(serverStatus),
            version: Value(serverVer),
          ),
        );
      } else {
        final newStatus = op.payload['new_status'] as String;
        await supabase.from('shipments').update({
          'current_status': newStatus,
        }).eq('id', op.shipmentId);

        await supabase.from('shipment_events').insert({
          'shipment_id': op.shipmentId,
          'previous_status': serverShipment['current_status'],
          'new_status': newStatus,
          'location_name': op.payload['location_name'] ?? 'Noida Central Hub',
          'remarks': conflictResult.createsAuditEvent
              ? '${op.payload['remarks'] ?? ''} [Conflict Resolved: ${conflictResult.explanation}]'
              : op.payload['remarks'],
          'updated_by': authUserId,
        });
      }
    }

    await _logSyncOp(supabase, op, authUserId, status: syncOutcome);
  }

  Future<void> _syncAssignDriver(
    SupabaseClient supabase,
    SyncOperationModel op,
    String authUserId,
  ) async {
    final driverId = op.payload['assigned_driver_id'] as String?;
    if (driverId != null) {
      await supabase.from('shipments').update({
        'assigned_driver_id': driverId,
      }).eq('id', op.shipmentId);
    }
    await _logSyncOp(supabase, op, authUserId, status: 'synced');
  }

  Future<void> _syncSubmitPOD(
    SupabaseClient supabase,
    SyncOperationModel op,
    String authUserId,
  ) async {
    final payload = Map<String, dynamic>.from(op.payload);

    // 1. Upload local photo & signature images to Supabase Storage when available
    final String? photoPath = payload['photo_url'] as String?;
    final String? sigPath = payload['signature_url'] as String?;

    final uploadedPhotoUrl = await _uploadEvidenceFileIfLocal(
      supabase,
      localPath: photoPath,
      remotePath: 'photos/${op.shipmentId}_${op.operationId}.jpg',
      contentType: 'image/jpeg',
    );

    final uploadedSigUrl = await _uploadEvidenceFileIfLocal(
      supabase,
      localPath: sigPath,
      remotePath: 'signatures/${op.shipmentId}_${op.operationId}.png',
      contentType: 'image/png',
    );

    // 2. Check server version for conflict audit logging (Evidence Preservation Rule)
    final serverShipment = await supabase
        .from('shipments')
        .select()
        .eq('id', op.shipmentId)
        .maybeSingle();

    String syncOutcome = 'synced';
    if (serverShipment != null) {
      final clientShipment = await (_db.select(_db.shipments)
            ..where((tbl) => tbl.id.equals(op.shipmentId)))
          .getSingleOrNull();
      final conflictResult = ConflictResolver.resolve(
        operation: op,
        serverShipmentData: serverShipment,
        clientVersion: clientShipment?.version ?? 1,
      );
      if (conflictResult.createsAuditEvent) {
        syncOutcome = 'conflict';
      }
    }

    // 3. Upsert POD evidence & mark shipment delivered
    await supabase.from('proof_of_deliveries').upsert({
      'id': payload['id'],
      'shipment_id': op.shipmentId,
      'receiver_name': payload['receiver_name'],
      'signature_url': uploadedSigUrl,
      'photo_url': uploadedPhotoUrl,
      'delivery_latitude': payload['delivery_latitude'],
      'delivery_longitude': payload['delivery_longitude'],
      'delivery_timestamp': payload['delivery_timestamp'],
      'notes': payload['notes'],
      'submitted_by': authUserId,
      'sync_status': 'synced',
      'is_verified': true,
    });

    await supabase.from('shipments').update({
      'current_status': 'delivered',
    }).eq('id', op.shipmentId);

    await supabase.from('shipment_events').insert({
      'shipment_id': op.shipmentId,
      'previous_status': serverShipment?['current_status'] ?? 'out_for_delivery',
      'new_status': 'delivered',
      'location_name': 'Delivered to ${payload['receiver_name']}',
      'latitude': payload['delivery_latitude'],
      'longitude': payload['delivery_longitude'],
      'remarks': 'POD synced with digital signature & photo. Notes: ${payload['notes'] ?? "None"}',
      'updated_by': authUserId,
    });

    // Update local POD record with Storage URLs
    await (_db.update(_db.proofOfDeliveries)..where((tbl) => tbl.shipmentId.equals(op.shipmentId))).write(
      ProofOfDeliveriesCompanion(
        photoPath: Value(uploadedPhotoUrl),
        signaturePath: Value(uploadedSigUrl),
        syncStatus: const Value('synced'),
      ),
    );

    await _logSyncOp(supabase, op, authUserId, status: syncOutcome);
  }

  Future<String?> _uploadEvidenceFileIfLocal(
    SupabaseClient supabase, {
    required String? localPath,
    required String remotePath,
    required String contentType,
  }) async {
    if (localPath == null || localPath.isEmpty) return null;
    if (localPath.startsWith('http://') || localPath.startsWith('https://')) {
      return localPath;
    }
    if (kIsWeb) return localPath;

    final file = File(localPath);
    if (!await file.exists()) return localPath;

    final bytes = await file.readAsBytes();
    await supabase.storage.from(SupabaseConfig.podStorageBucket).uploadBinary(
          remotePath,
          bytes,
          fileOptions: FileOptions(contentType: contentType, upsert: true),
        );

    return supabase.storage.from(SupabaseConfig.podStorageBucket).getPublicUrl(remotePath);
  }

  Future<void> _logSyncOp(
    SupabaseClient supabase,
    SyncOperationModel op,
    String authUserId, {
    required String status,
  }) async {
    try {
      await supabase.from('sync_operations').upsert({
        'operation_id': op.operationId,
        'user_id': authUserId,
        'shipment_id': op.shipmentId,
        'operation_type': op.operationType.dbValue,
        'payload': op.payload,
        'local_timestamp': op.localTimestamp.toIso8601String(),
        'status': status,
        'retry_count': op.retryCount,
      });
    } catch (e) {
      debugPrint('[SyncEngine] Audit log warning: $e');
    }
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }
}

final syncEngineProvider = StateNotifierProvider<SyncEngine, SyncState>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final connectivity = ref.watch(connectivityServiceProvider);
  return SyncEngine(db, connectivity);
});
