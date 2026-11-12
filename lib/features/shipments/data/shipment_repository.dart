import 'dart:math';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/network/supabase_config.dart';
import '../../../core/sync/sync_engine.dart';
import '../../../core/sync/sync_operation.dart';
import '../../delivery/domain/pod_model.dart';
import '../domain/shipment_model.dart';

class ShipmentRepository {
  final AppDatabase _db;
  final SyncEngine _syncEngine;
  final _uuid = const Uuid();

  ShipmentRepository(this._db, this._syncEngine);

  /// Seeds realistic initial Noida logistics shipments if SQLite is empty in demo mode
  Future<void> seedIfEmpty() async {
    if (SupabaseConfig.isRealBackendConfigured) {
      await pullFromRemote();
      return;
    }
    final count = await _db.select(_db.shipments).get();
    if (count.isNotEmpty) return;

    final now = DateTime.now();

    final seedShipments = [
      ShipmentModel(
        id: '00000001-0000-0000-0000-000000000001',
        trackingNumber: 'LGF-2026-88401',
        senderId: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        senderName: 'Amit Sharma',
        senderPhone: '+91 98712 34567',
        senderAddress: 'Tower 4, ATS One Hamlet, Sector 104, Noida, UP 201304',
        receiverName: 'Sunil Mehra',
        receiverPhone: '+91 98188 23456',
        receiverAddress: 'Office 402, Wave Silver Tower, Sector 18, Noida, UP 201301',
        packageCategory: 'Electronics / IT Hardware',
        weightKg: 3.50,
        priority: PriorityLevel.express,
        currentStatus: ShipmentStatus.delivered,
        originHubId: '11111111-1111-1111-1111-111111111111',
        destinationHubId: '11111111-1111-1111-1111-111111111111',
        assignedDriverId: 'cccccccc-cccc-cccc-cccc-cccccccccccc',
        expectedDelivery: now.subtract(const Duration(hours: 4)),
        version: 4,
        createdAt: now.subtract(const Duration(hours: 26)),
        updatedAt: now.subtract(const Duration(hours: 4)),
      ),
      ShipmentModel(
        id: '00000002-0000-0000-0000-000000000002',
        trackingNumber: 'LGF-2026-88402',
        senderId: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        senderName: 'Amit Sharma',
        senderPhone: '+91 98712 34567',
        senderAddress: 'C-24, Sector 65, Noida, UP 201301',
        receiverName: 'Neha Gupta',
        receiverPhone: '+91 99100 87654',
        receiverAddress: 'Flat 1204, Gaur City 2, Greater Noida West, UP 201306',
        packageCategory: 'Healthcare & Diagnostics',
        weightKg: 1.20,
        priority: PriorityLevel.overnight,
        currentStatus: ShipmentStatus.outForDelivery,
        originHubId: '11111111-1111-1111-1111-111111111111',
        destinationHubId: '22222222-2222-2222-2222-222222222222',
        assignedDriverId: 'cccccccc-cccc-cccc-cccc-cccccccccccc',
        expectedDelivery: now.add(const Duration(hours: 3)),
        version: 3,
        createdAt: now.subtract(const Duration(hours: 16)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      ShipmentModel(
        id: '00000003-0000-0000-0000-000000000003',
        trackingNumber: 'LGF-2026-88403',
        senderId: 'dddddddd-dddd-dddd-dddd-dddddddddddd',
        senderName: 'Priya Verma',
        senderPhone: '+91 98111 87654',
        senderAddress: 'B-12, Sector 83, Phase 2, Noida, UP 201305',
        receiverName: 'Rahul Malhotra',
        receiverPhone: '+91 98200 12345',
        receiverAddress: 'F-82, Okhla Phase 1, New Delhi 110020',
        packageCategory: 'Apparel & Textiles',
        weightKg: 12.40,
        priority: PriorityLevel.standard,
        currentStatus: ShipmentStatus.inTransit,
        originHubId: '11111111-1111-1111-1111-111111111111',
        destinationHubId: '33333333-3333-3333-3333-333333333333',
        expectedDelivery: now.add(const Duration(days: 1)),
        version: 2,
        createdAt: now.subtract(const Duration(hours: 20)),
        updatedAt: now.subtract(const Duration(hours: 5)),
      ),
      ShipmentModel(
        id: '00000004-0000-0000-0000-000000000004',
        trackingNumber: 'LGF-2026-88404',
        senderId: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        senderName: 'Amit Sharma',
        senderPhone: '+91 98712 34567',
        senderAddress: 'D-102, Sector 128, Noida, UP 201304',
        receiverName: 'Kavita Rao',
        receiverPhone: '+91 97111 44556',
        receiverAddress: 'Villa 15, Jaypee Greens, Greater Noida, UP 201310',
        packageCategory: 'Automotive Spare Parts',
        weightKg: 8.75,
        priority: PriorityLevel.express,
        currentStatus: ShipmentStatus.arrivedAtHub,
        originHubId: '11111111-1111-1111-1111-111111111111',
        destinationHubId: '22222222-2222-2222-2222-222222222222',
        expectedDelivery: now.add(const Duration(hours: 18)),
        version: 2,
        createdAt: now.subtract(const Duration(hours: 12)),
        updatedAt: now.subtract(const Duration(hours: 3)),
      ),
      ShipmentModel(
        id: '00000005-0000-0000-0000-000000000005',
        trackingNumber: 'LGF-2026-88405',
        senderId: 'dddddddd-dddd-dddd-dddd-dddddddddddd',
        senderName: 'Priya Verma',
        senderPhone: '+91 98111 87654',
        senderAddress: 'Logistics Park, Ecotech 3, Greater Noida, UP 201306',
        receiverName: 'Deepak Chopra',
        receiverPhone: '+91 98109 99887',
        receiverAddress: 'Sector 50, Noida, UP 201301',
        packageCategory: 'Industrial Hardware',
        weightKg: 24.00,
        priority: PriorityLevel.standard,
        currentStatus: ShipmentStatus.pickedUp,
        originHubId: '22222222-2222-2222-2222-222222222222',
        destinationHubId: '11111111-1111-1111-1111-111111111111',
        expectedDelivery: now.add(const Duration(days: 2)),
        version: 1,
        createdAt: now.subtract(const Duration(hours: 8)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      ShipmentModel(
        id: '00000006-0000-0000-0000-000000000006',
        trackingNumber: 'LGF-2026-88406',
        senderId: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        senderName: 'Amit Sharma',
        senderPhone: '+91 98712 34567',
        senderAddress: 'Sector 62, Noida, UP 201309',
        receiverName: 'Ananya Sen',
        receiverPhone: '+91 98300 55443',
        receiverAddress: 'Sector 137, Expressway, Noida, UP 201305',
        packageCategory: 'Documents & Legal Briefs',
        weightKg: 0.50,
        priority: PriorityLevel.express,
        currentStatus: ShipmentStatus.pickupScheduled,
        originHubId: '11111111-1111-1111-1111-111111111111',
        destinationHubId: '11111111-1111-1111-1111-111111111111',
        expectedDelivery: now.add(const Duration(days: 1)),
        version: 1,
        createdAt: now.subtract(const Duration(hours: 4)),
        updatedAt: now.subtract(const Duration(hours: 4)),
      ),
      ShipmentModel(
        id: '00000007-0000-0000-0000-000000000007',
        trackingNumber: 'LGF-2026-88407',
        senderId: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        senderName: 'Amit Sharma',
        senderPhone: '+91 98712 34567',
        senderAddress: 'Sector 15A, Noida, UP 201301',
        receiverName: 'Manish Taneja',
        receiverPhone: '+91 98112 00011',
        receiverAddress: 'Shop 14, Atta Market, Sector 27, Noida, UP 201301',
        packageCategory: 'High-Value Consumer Electronics',
        weightKg: 2.10,
        priority: PriorityLevel.express,
        currentStatus: ShipmentStatus.deliveryFailed,
        originHubId: '11111111-1111-1111-1111-111111111111',
        destinationHubId: '11111111-1111-1111-1111-111111111111',
        assignedDriverId: 'cccccccc-cccc-cccc-cccc-cccccccccccc',
        expectedDelivery: now.subtract(const Duration(hours: 2)),
        version: 4,
        createdAt: now.subtract(const Duration(hours: 18)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
    ];

    for (final s in seedShipments) {
      await _insertShipmentIntoLocalDb(s);
    }

    // Seed events for LGF-2026-88401
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: '10000001-0000-0000-0000-000000000001',
            shipmentId: '00000001-0000-0000-0000-000000000001',
            newStatus: ShipmentStatus.created.toDbString(),
            locationName: 'ATS One Hamlet, Sector 104, Noida',
            remarks: const Value('Shipment order booked via Mobile App'),
            updatedBy: 'Amit Sharma',
            createdAt: now.subtract(const Duration(hours: 26)),
          ),
        );
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: '10000001-0000-0000-0000-000000000002',
            shipmentId: '00000001-0000-0000-0000-000000000001',
            previousStatus: Value(ShipmentStatus.created.toDbString()),
            newStatus: ShipmentStatus.pickedUp.toDbString(),
            locationName: 'Sector 104, Noida',
            remarks: const Value('Package picked up by courier van 14'),
            updatedBy: 'Vikas Singh',
            createdAt: now.subtract(const Duration(hours: 20)),
          ),
        );
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: '10000001-0000-0000-0000-000000000003',
            shipmentId: '00000001-0000-0000-0000-000000000001',
            previousStatus: Value(ShipmentStatus.pickedUp.toDbString()),
            newStatus: ShipmentStatus.arrivedAtHub.toDbString(),
            locationName: 'Noida Sector 62 Central Hub',
            remarks: const Value('Sorted at Sector 62 Central Conveyor'),
            updatedBy: 'Rajesh Kumar',
            createdAt: now.subtract(const Duration(hours: 14)),
          ),
        );
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: '10000001-0000-0000-0000-000000000004',
            shipmentId: '00000001-0000-0000-0000-000000000001',
            previousStatus: Value(ShipmentStatus.arrivedAtHub.toDbString()),
            newStatus: ShipmentStatus.outForDelivery.toDbString(),
            locationName: 'Wave Silver Tower, Sector 18',
            remarks: const Value('Assigned to driver Vikas Singh for final mile'),
            updatedBy: 'Vikas Singh',
            createdAt: now.subtract(const Duration(hours: 6)),
          ),
        );
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: '10000001-0000-0000-0000-000000000005',
            shipmentId: '00000001-0000-0000-0000-000000000001',
            previousStatus: Value(ShipmentStatus.outForDelivery.toDbString()),
            newStatus: ShipmentStatus.delivered.toDbString(),
            locationName: 'Wave Silver Tower, Sector 18, Noida',
            remarks: const Value('Delivered to Sunil Mehra with digital signature & photo'),
            updatedBy: 'Vikas Singh',
            createdAt: now.subtract(const Duration(hours: 4)),
          ),
        );

    // Seed Proof of Delivery for LGF-2026-88401
    await _db.into(_db.proofOfDeliveries).insert(
          ProofOfDeliveriesCompanion.insert(
            id: '55555555-5555-5555-5555-555555555555',
            shipmentId: '00000001-0000-0000-0000-000000000001',
            receiverName: 'Sunil Mehra',
            signaturePath: const Value('local_verified_signature'),
            photoPath: const Value('https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=500'),
            deliveryLatitude: 28.5708,
            deliveryLongitude: 77.3259,
            deliveryTimestamp: now.subtract(const Duration(hours: 4)),
            notes: const Value('Received by receiver Sunil Mehra personally at 4th floor reception. Package seal intact.'),
            submittedBy: 'Vikas Singh',
            syncStatus: const Value('synced'),
            createdAt: now.subtract(const Duration(hours: 4)),
          ),
        );
  }

  Future<void> _insertShipmentIntoLocalDb(ShipmentModel s) async {
    await _db.into(_db.shipments).insertOnConflictUpdate(
          ShipmentsCompanion.insert(
            id: s.id,
            trackingNumber: s.trackingNumber,
            senderId: s.senderId,
            senderName: s.senderName,
            senderPhone: s.senderPhone,
            senderAddress: s.senderAddress,
            receiverName: s.receiverName,
            receiverPhone: s.receiverPhone,
            receiverAddress: s.receiverAddress,
            packageCategory: s.packageCategory,
            weightKg: s.weightKg,
            priority: s.priority.toDbString(),
            currentStatus: s.currentStatus.toDbString(),
            originHubId: s.originHubId,
            destinationHubId: s.destinationHubId,
            assignedDriverId: Value(s.assignedDriverId),
            expectedDelivery: s.expectedDelivery,
            version: Value(s.version),
            isDirty: Value(s.isDirty),
            syncStatus: Value(s.syncStatus),
            createdAt: s.createdAt,
            updatedAt: s.updatedAt,
          ),
        );
  }

  /// Pulls live shipments, events, and PODs from Supabase into local Drift SQLite
  Future<void> pullFromRemote() async {
    final supabase = SupabaseConfig.client;
    if (supabase == null || !SupabaseConfig.isRealBackendConfigured) return;

    try {
      final remoteRows = await supabase
          .from('shipments')
          .select()
          .order('created_at', ascending: false)
          .limit(100);

      for (final row in remoteRows) {
        final remoteShipment = ShipmentModel.fromJson(row);
        final localExisting = await (_db.select(_db.shipments)
              ..where((tbl) => tbl.id.equals(remoteShipment.id)))
            .getSingleOrNull();

        // Do not overwrite local unsynced mutations before SyncEngine reconciles them
        if (localExisting == null || !localExisting.isDirty) {
          await _insertShipmentIntoLocalDb(remoteShipment);
        }
      }

      final remoteEvents = await supabase
          .from('shipment_events')
          .select()
          .order('created_at', ascending: false)
          .limit(200);

      for (final ev in remoteEvents) {
        await _db.into(_db.shipmentEvents).insertOnConflictUpdate(
              ShipmentEventsCompanion.insert(
                id: ev['id'] as String,
                shipmentId: ev['shipment_id'] as String,
                previousStatus: Value(ev['previous_status'] as String?),
                newStatus: ev['new_status'] as String,
                locationName: ev['location_name'] as String,
                latitude: Value((ev['latitude'] as num?)?.toDouble()),
                longitude: Value((ev['longitude'] as num?)?.toDouble()),
                remarks: Value(ev['remarks'] as String?),
                updatedBy: ev['updated_by'] as String,
                createdAt: DateTime.parse(ev['created_at'] as String),
              ),
            );
      }

      final remotePods = await supabase
          .from('proof_of_deliveries')
          .select()
          .order('created_at', ascending: false)
          .limit(100);

      for (final p in remotePods) {
        await _db.into(_db.proofOfDeliveries).insertOnConflictUpdate(
              ProofOfDeliveriesCompanion.insert(
                id: p['id'] as String,
                shipmentId: p['shipment_id'] as String,
                receiverName: p['receiver_name'] as String,
                signaturePath: Value(p['signature_url'] as String?),
                photoPath: Value(p['photo_url'] as String?),
                deliveryLatitude: (p['delivery_latitude'] as num).toDouble(),
                deliveryLongitude: (p['delivery_longitude'] as num).toDouble(),
                deliveryTimestamp: DateTime.parse(p['delivery_timestamp'] as String),
                notes: Value(p['notes'] as String?),
                submittedBy: p['submitted_by'] as String,
                syncStatus: Value(p['sync_status'] as String? ?? 'synced'),
                createdAt: DateTime.parse(p['created_at'] as String),
              ),
            );
      }
    } catch (e) {
      debugPrint('[ShipmentRepository] pullFromRemote warning: $e');
    }
  }

  Stream<List<ShipmentModel>> watchShipments({
    String? searchQuery,
    ShipmentStatus? statusFilter,
    String? userId,
    bool isHubManager = false,
  }) {
    final query = _db.select(_db.shipments);

    query.orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);

    return query.watch().map((rows) {
      var list = rows.map((r) => _mapRowToModel(r)).toList();

      // Role filter: shippers only see their own; hub managers see all
      if (!isHubManager && userId != null) {
        list = list.where((s) => s.senderId == userId).toList();
      }

      // Status filter
      if (statusFilter != null) {
        list = list.where((s) => s.currentStatus == statusFilter).toList();
      }

      // Search filter
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final q = searchQuery.trim().toLowerCase();
        list = list.where((s) =>
            s.trackingNumber.toLowerCase().contains(q) ||
            s.receiverName.toLowerCase().contains(q) ||
            s.receiverAddress.toLowerCase().contains(q) ||
            s.packageCategory.toLowerCase().contains(q)).toList();
      }

      return list;
    });
  }

  Future<ShipmentModel?> getShipmentById(String id) async {
    final row = await (_db.select(_db.shipments)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (row != null) {
      return _mapRowToModel(row);
    }
    return null;
  }

  Future<ShipmentModel?> getShipmentByTrackingNumber(String trackingNumber) async {
    final row = await (_db.select(_db.shipments)
          ..where((tbl) => tbl.trackingNumber.equals(trackingNumber.trim())))
        .getSingleOrNull();
    if (row != null) {
      return _mapRowToModel(row);
    }
    return null;
  }

  Future<List<ShipmentEventModel>> getEventsForShipment(String shipmentId) async {
    final rows = await (_db.select(_db.shipmentEvents)
          ..where((tbl) => tbl.shipmentId.equals(shipmentId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .get();

    return rows.map((r) => ShipmentEventModel(
          id: r.id,
          shipmentId: r.shipmentId,
          previousStatus: r.previousStatus != null
              ? ShipmentStatus.fromString(r.previousStatus!)
              : null,
          newStatus: ShipmentStatus.fromString(r.newStatus),
          locationName: r.locationName,
          latitude: r.latitude,
          longitude: r.longitude,
          remarks: r.remarks,
          updatedBy: r.updatedBy,
          createdAt: r.createdAt,
        )).toList();
  }

  Future<ProofOfDeliveryModel?> getPODForShipment(String shipmentId) async {
    final row = await (_db.select(_db.proofOfDeliveries)
          ..where((tbl) => tbl.shipmentId.equals(shipmentId)))
        .getSingleOrNull();

    if (row != null) {
      return ProofOfDeliveryModel(
        id: row.id,
        shipmentId: row.shipmentId,
        receiverName: row.receiverName,
        signaturePath: row.signaturePath,
        photoPath: row.photoPath,
        deliveryLatitude: row.deliveryLatitude,
        deliveryLongitude: row.deliveryLongitude,
        deliveryTimestamp: row.deliveryTimestamp,
        notes: row.notes,
        submittedBy: row.submittedBy,
        syncStatus: row.syncStatus,
        createdAt: row.createdAt,
      );
    }
    return null;
  }

  Future<ShipmentModel> createShipment({
    required String senderId,
    required String senderName,
    required String senderPhone,
    required String senderAddress,
    required String receiverName,
    required String receiverPhone,
    required String receiverAddress,
    required String packageCategory,
    required double weightKg,
    required PriorityLevel priority,
    String? originHubId,
    String? destinationHubId,
  }) async {
    final id = _uuid.v4();
    final randomDigits = 10000 + Random().nextInt(90000);
    final trackingNumber = 'LGF-2026-$randomDigits';
    final now = DateTime.now();

    final shipment = ShipmentModel(
      id: id,
      trackingNumber: trackingNumber,
      senderId: senderId,
      senderName: senderName,
      senderPhone: senderPhone,
      senderAddress: senderAddress,
      receiverName: receiverName,
      receiverPhone: receiverPhone,
      receiverAddress: receiverAddress,
      packageCategory: packageCategory,
      weightKg: weightKg,
      priority: priority,
      currentStatus: ShipmentStatus.created,
      originHubId: originHubId ?? '11111111-1111-1111-1111-111111111111',
      destinationHubId: destinationHubId ?? '11111111-1111-1111-1111-111111111111',
      expectedDelivery: now.add(priority == PriorityLevel.overnight
          ? const Duration(hours: 24)
          : priority == PriorityLevel.express
              ? const Duration(days: 2)
              : const Duration(days: 4)),
      version: 1,
      isDirty: true,
      syncStatus: 'pending',
      createdAt: now,
      updatedAt: now,
    );

    // Save locally to Drift SQLite (0ms UI latency!)
    await _insertShipmentIntoLocalDb(shipment);

    // Add initial event
    final eventId = _uuid.v4();
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: eventId,
            shipmentId: id,
            newStatus: ShipmentStatus.created.toDbString(),
            locationName: senderAddress,
            remarks: const Value('Consignment manifested and registered.'),
            updatedBy: senderName,
            createdAt: now,
          ),
        );

    // Enqueue offline-first sync operation
    final op = SyncOperationModel(
      operationId: _uuid.v4(),
      userId: senderId,
      shipmentId: id,
      operationType: SyncOperationType.createShipment,
      payload: shipment.toJson(),
      localTimestamp: now,
    );
    await _syncEngine.enqueueOperation(op);

    return shipment;
  }

  Future<void> updateShipmentStatus({
    required String shipmentId,
    required ShipmentStatus newStatus,
    required String locationName,
    String? remarks,
    required String updatedBy,
    required String userId,
    double? latitude,
    double? longitude,
  }) async {
    final current = await getShipmentById(shipmentId);
    if (current == null) return;

    final now = DateTime.now();

    // 1. Update Drift DB locally
    await (_db.update(_db.shipments)..where((tbl) => tbl.id.equals(shipmentId))).write(
      ShipmentsCompanion(
        currentStatus: Value(newStatus.toDbString()),
        updatedAt: Value(now),
        isDirty: const Value(true),
        syncStatus: const Value('pending'),
        version: Value(current.version + 1),
      ),
    );

    // 2. Add event to timeline
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: _uuid.v4(),
            shipmentId: shipmentId,
            previousStatus: Value(current.currentStatus.toDbString()),
            newStatus: newStatus.toDbString(),
            locationName: locationName,
            latitude: Value(latitude),
            longitude: Value(longitude),
            remarks: Value(remarks),
            updatedBy: updatedBy,
            createdAt: now,
          ),
        );

    // 3. Enqueue operation in SyncQueue
    final op = SyncOperationModel(
      operationId: _uuid.v4(),
      userId: userId,
      shipmentId: shipmentId,
      operationType: SyncOperationType.updateStatus,
      payload: {
        'new_status': newStatus.toDbString(),
        'previous_status': current.currentStatus.toDbString(),
        'location_name': locationName,
        'remarks': remarks,
        'updated_by': updatedBy,
        'version': current.version + 1,
        'updated_at': now.toIso8601String(),
      },
      localTimestamp: now,
    );
    await _syncEngine.enqueueOperation(op);
  }

  Future<void> assignDeliveryDriver({
    required String shipmentId,
    required String driverId,
    required String driverName,
    required String assignedBy,
    required String userId,
  }) async {
    final current = await getShipmentById(shipmentId);
    if (current == null) return;

    final now = DateTime.now();

    await (_db.update(_db.shipments)..where((tbl) => tbl.id.equals(shipmentId))).write(
      ShipmentsCompanion(
        assignedDriverId: Value(driverId),
        updatedAt: Value(now),
        isDirty: const Value(true),
        syncStatus: const Value('pending'),
        version: Value(current.version + 1),
      ),
    );

    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: _uuid.v4(),
            shipmentId: shipmentId,
            previousStatus: Value(current.currentStatus.toDbString()),
            newStatus: current.currentStatus.toDbString(),
            locationName: 'Noida Sector 62 Central Hub',
            remarks: Value('Delivery agent assigned: $driverName'),
            updatedBy: assignedBy,
            createdAt: now,
          ),
        );

    final op = SyncOperationModel(
      operationId: _uuid.v4(),
      userId: userId,
      shipmentId: shipmentId,
      operationType: SyncOperationType.assignDriver,
      payload: {
        'assigned_driver_id': driverId,
        'driver_name': driverName,
        'assigned_by': assignedBy,
        'version': current.version + 1,
      },
      localTimestamp: now,
    );
    await _syncEngine.enqueueOperation(op);
  }

  Future<void> submitProofOfDelivery(ProofOfDeliveryModel pod) async {
    final now = DateTime.now();

    // 1. Mark shipment delivered locally in Drift SQLite
    await (_db.update(_db.shipments)..where((tbl) => tbl.id.equals(pod.shipmentId))).write(
      ShipmentsCompanion(
        currentStatus: Value(ShipmentStatus.delivered.toDbString()),
        updatedAt: Value(now),
        isDirty: const Value(true),
        syncStatus: const Value('pending'),
      ),
    );

    // 2. Insert POD into local DB
    await _db.into(_db.proofOfDeliveries).insertOnConflictUpdate(
          ProofOfDeliveriesCompanion.insert(
            id: pod.id,
            shipmentId: pod.shipmentId,
            receiverName: pod.receiverName,
            signaturePath: Value(pod.signaturePath),
            photoPath: Value(pod.photoPath),
            deliveryLatitude: pod.deliveryLatitude,
            deliveryLongitude: pod.deliveryLongitude,
            deliveryTimestamp: pod.deliveryTimestamp,
            notes: Value(pod.notes),
            submittedBy: pod.submittedBy,
            syncStatus: const Value('pending'),
            createdAt: pod.createdAt,
          ),
        );

    // 3. Add delivery event
    await _db.into(_db.shipmentEvents).insert(
          ShipmentEventsCompanion.insert(
            id: _uuid.v4(),
            shipmentId: pod.shipmentId,
            previousStatus: Value(ShipmentStatus.outForDelivery.toDbString()),
            newStatus: ShipmentStatus.delivered.toDbString(),
            locationName: 'Delivered at ${pod.receiverName}',
            latitude: Value(pod.deliveryLatitude),
            longitude: Value(pod.deliveryLongitude),
            remarks: Value('Delivered with digital signature and photo. Notes: ${pod.notes ?? "None"}'),
            updatedBy: pod.submittedBy,
            createdAt: now,
          ),
        );

    // 4. Enqueue in SyncQueue
    final op = SyncOperationModel(
      operationId: _uuid.v4(),
      userId: pod.submittedBy,
      shipmentId: pod.shipmentId,
      operationType: SyncOperationType.submitPOD,
      payload: pod.toJson(),
      localTimestamp: now,
    );
    await _syncEngine.enqueueOperation(op);
  }

  ShipmentModel _mapRowToModel(Shipment row) {
    return ShipmentModel(
      id: row.id,
      trackingNumber: row.trackingNumber,
      senderId: row.senderId,
      senderName: row.senderName,
      senderPhone: row.senderPhone,
      senderAddress: row.senderAddress,
      receiverName: row.receiverName,
      receiverPhone: row.receiverPhone,
      receiverAddress: row.receiverAddress,
      packageCategory: row.packageCategory,
      weightKg: row.weightKg,
      priority: PriorityLevel.fromString(row.priority),
      currentStatus: ShipmentStatus.fromString(row.currentStatus),
      originHubId: row.originHubId,
      destinationHubId: row.destinationHubId,
      assignedDriverId: row.assignedDriverId,
      expectedDelivery: row.expectedDelivery,
      version: row.version,
      isDirty: row.isDirty,
      syncStatus: row.syncStatus,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
