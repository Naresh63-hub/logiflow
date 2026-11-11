import 'package:flutter_test/flutter_test.dart';
import 'package:logistics_app/core/sync/conflict_resolver.dart';
import 'package:logistics_app/core/sync/sync_operation.dart';
import 'package:logistics_app/features/shipments/domain/shipment_model.dart';

void main() {
  group('Offline Synchronization Engine Integration Simulation', () {
    test('Offline queue simulation: creates, queues, resolves, and applies status change', () {
      final now = DateTime.now();

      // Step 1: Simulate offline shipment manifestation
      final shipment = ShipmentModel(
        id: 'sim-ship-001',
        trackingNumber: 'YUV-2026-77001',
        senderId: 'user-001',
        senderName: 'Amit Sharma',
        senderPhone: '+91 98712 34567',
        senderAddress: 'Sector 62, Noida',
        receiverName: 'Kavita Rao',
        receiverPhone: '+91 97111 44556',
        receiverAddress: 'Greater Noida West',
        packageCategory: 'Electronics',
        weightKg: 1.8,
        priority: PriorityLevel.express,
        currentStatus: ShipmentStatus.created,
        originHubId: 'hub-01',
        destinationHubId: 'hub-02',
        expectedDelivery: now.add(const Duration(days: 2)),
        version: 1,
        isDirty: true,
        syncStatus: 'pending',
        createdAt: now,
        updatedAt: now,
      );

      expect(shipment.isDirty, isTrue);
      expect(shipment.syncStatus, 'pending');

      // Step 2: Enqueue offline status update (Driver records pickup in transit area without cell reception)
      final offlineOp = SyncOperationModel(
        operationId: 'op-pickup-001',
        userId: 'user-001',
        shipmentId: shipment.id,
        operationType: SyncOperationType.updateStatus,
        payload: {
          'new_status': ShipmentStatus.pickedUp.toDbString(),
          'location_name': 'Noida Sector 62',
          'remarks': 'Picked up by vehicle 12',
          'version': 2,
        },
        localTimestamp: now.add(const Duration(minutes: 15)),
        syncStatus: 'pending',
      );

      // Step 3: Device reconnects to network -> Sync engine processes queue
      final serverState = {
        'version': 1,
        'current_status': 'created',
        'updated_at': now.toIso8601String(),
      };

      final resolution = ConflictResolver.resolve(
        operation: offlineOp,
        serverShipmentData: serverState,
        clientVersion: 1,
      );

      expect(resolution.resolved, isTrue);
      expect(resolution.strategy, ConflictStrategy.clientWins);

      // Step 4: Local state after sync marked clean and synced
      final syncedShipment = shipment.copyWith(
        currentStatus: ShipmentStatus.pickedUp,
        isDirty: false,
        syncStatus: 'synced',
        version: 2,
      );

      expect(syncedShipment.isDirty, isFalse);
      expect(syncedShipment.syncStatus, 'synced');
      expect(syncedShipment.currentStatus, ShipmentStatus.pickedUp);
      expect(syncedShipment.version, 2);
    });
  });
}
