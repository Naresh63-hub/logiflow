import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    // Listen to network changes and auto-sync when online
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

    // If online, immediately trigger sync
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
        // Live Supabase integration with Conflict Detection
        final serverShipmentResponse = await supabase
            .from('shipments')
            .select()
            .eq('id', op.shipmentId)
            .maybeSingle();

        if (serverShipmentResponse != null) {
          final serverShipment = serverShipmentResponse;
          final clientShipment = await (_db.select(_db.shipments)
                ..where((tbl) => tbl.id.equals(op.shipmentId)))
              .getSingleOrNull();

          final clientVersion = clientShipment?.version ?? 1;

          final conflictResult = ConflictResolver.resolve(
            operation: op,
            serverShipmentData: serverShipment,
            clientVersion: clientVersion,
          );

          if (conflictResult.resolved) {
            // Apply resolved update
            await supabase
                .from('shipments')
                .update(conflictResult.resolvedData)
                .eq('id', op.shipmentId);
          }
        }
      }

      // Mark operation as synced in local Drift SQLite
      await (_db.update(_db.syncQueue)..where((tbl) => tbl.operationId.equals(op.operationId))).write(
        SyncQueueCompanion(
          syncStatus: const Value('synced'),
          retryCount: Value(op.retryCount + 1),
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
