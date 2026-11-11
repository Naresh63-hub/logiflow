import 'package:flutter_test/flutter_test.dart';
import 'package:logistics_app/core/sync/conflict_resolver.dart';
import 'package:logistics_app/core/sync/sync_operation.dart';

void main() {
  group('ConflictResolver Unit Tests', () {
    final now = DateTime.now();

    test('Identical version numbers resolve cleanly via normal optimistic concurrency', () {
      final op = SyncOperationModel(
        operationId: 'op-001',
        userId: 'user-001',
        shipmentId: 'ship-001',
        operationType: SyncOperationType.updateStatus,
        payload: {'new_status': 'in_transit'},
        localTimestamp: now,
      );

      final serverData = {
        'version': 2,
        'current_status': 'arrived_at_hub',
        'updated_at': now.subtract(const Duration(minutes: 5)).toIso8601String(),
      };

      final result = ConflictResolver.resolve(
        operation: op,
        serverShipmentData: serverData,
        clientVersion: 2,
      );

      expect(result.resolved, isTrue);
      expect(result.strategy, ConflictStrategy.clientWins);
      expect(result.createsAuditEvent, isFalse);
    });

    test('Proof of Delivery (POD) Evidence Preservation Rule guarantees evidence is NEVER discarded', () {
      final podOp = SyncOperationModel(
        operationId: 'op-pod-001',
        userId: 'driver-001',
        shipmentId: 'ship-001',
        operationType: SyncOperationType.submitPOD,
        payload: {
          'receiver_name': 'Sunil Mehra',
          'signature_url': 'sig_path.png',
          'delivery_latitude': 28.5708,
          'delivery_longitude': 77.3259,
        },
        localTimestamp: now,
      );

      // Server was updated by another manager while driver was in offline basement (version diverged)
      final divergedServerData = {
        'version': 5,
        'current_status': 'out_for_delivery',
        'updated_at': now.subtract(const Duration(minutes: 10)).toIso8601String(),
      };

      final result = ConflictResolver.resolve(
        operation: podOp,
        serverShipmentData: divergedServerData,
        clientVersion: 3, // Stale version
      );

      expect(result.resolved, isTrue);
      expect(result.strategy, ConflictStrategy.evidencePreserved);
      expect(result.resolvedData['current_status'], 'delivered');
      expect(result.createsAuditEvent, isTrue);
      expect(result.explanation, contains('Critical delivery evidence'));
    });

    test('Server already Delivered rejects offline regression to in-transit', () {
      final staleTransitOp = SyncOperationModel(
        operationId: 'op-transit-002',
        userId: 'agent-002',
        shipmentId: 'ship-001',
        operationType: SyncOperationType.updateStatus,
        payload: {'new_status': 'in_transit'},
        localTimestamp: now.subtract(const Duration(hours: 1)),
      );

      final serverDeliveredData = {
        'version': 4,
        'current_status': 'delivered',
        'updated_at': now.toIso8601String(),
      };

      final result = ConflictResolver.resolve(
        operation: staleTransitOp,
        serverShipmentData: serverDeliveredData,
        clientVersion: 2,
      );

      expect(result.resolved, isTrue);
      expect(result.strategy, ConflictStrategy.serverWins);
      expect(result.explanation, contains('already DELIVERED on server'));
    });
  });
}
