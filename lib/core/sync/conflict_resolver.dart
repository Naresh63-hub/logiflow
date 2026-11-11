import 'package:flutter/foundation.dart';
import '../../features/shipments/domain/shipment_model.dart';
import 'sync_operation.dart';

enum ConflictStrategy {
  serverWins,
  clientWins,
  evidencePreserved,
  manualResolutionRequired,
}

class ConflictResolutionResult {
  final bool resolved;
  final ConflictStrategy strategy;
  final String explanation;
  final Map<String, dynamic> resolvedData;
  final bool createsAuditEvent;

  const ConflictResolutionResult({
    required this.resolved,
    required this.strategy,
    required this.explanation,
    required this.resolvedData,
    this.createsAuditEvent = true,
  });
}

class ConflictResolver {
  /// Evaluates an incoming offline operation against current server state.
  static ConflictResolutionResult resolve({
    required SyncOperationModel operation,
    required Map<String, dynamic> serverShipmentData,
    required int clientVersion,
  }) {
    final int serverVersion = serverShipmentData['version'] as int? ?? 1;
    final DateTime serverUpdatedAt = DateTime.parse(
        serverShipmentData['updated_at'] as String? ?? DateTime.now().toIso8601String());
    final DateTime clientTimestamp = operation.localTimestamp;

    debugPrint(
        '[ConflictResolver] Resolving op ${operation.operationType.dbValue} for shipment ${operation.shipmentId}. Client v$clientVersion vs Server v$serverVersion');

    // 1. If versions match, no conflict exists
    if (clientVersion == serverVersion) {
      return ConflictResolutionResult(
        resolved: true,
        strategy: ConflictStrategy.clientWins,
        explanation: 'Version match (v$serverVersion). Normal optimistic concurrency pass.',
        resolvedData: operation.payload,
        createsAuditEvent: false,
      );
    }

    // 2. Proof of Delivery Rule: NEVER discard delivery evidence!
    if (operation.operationType == SyncOperationType.submitPOD) {
      debugPrint('[ConflictResolver] POD Evidence Preservation Rule triggered.');
      return ConflictResolutionResult(
        resolved: true,
        strategy: ConflictStrategy.evidencePreserved,
        explanation:
            'Critical delivery evidence (receiver signature, photo, GPS coordinates) preserved. Shipment status marked Delivered.',
        resolvedData: {
          ...operation.payload,
          'current_status': ShipmentStatus.delivered.toDbString(),
          'conflict_resolution_note':
              'POD applied despite server version divergence (Client v$clientVersion, Server v$serverVersion). Evidence guaranteed.',
        },
        createsAuditEvent: true,
      );
    }

    // 3. For status transitions, evaluate timestamp precedence
    if (operation.operationType == SyncOperationType.updateStatus) {
      final incomingStatus = operation.payload['new_status'] as String? ?? '';
      final currentServerStatus = serverShipmentData['current_status'] as String? ?? '';

      // If server is already marked delivered, cancel non-delivered regression
      if (currentServerStatus == ShipmentStatus.delivered.toDbString()) {
        return ConflictResolutionResult(
          resolved: true,
          strategy: ConflictStrategy.serverWins,
          explanation:
              'Shipment is already DELIVERED on server. Discarding offline regression to "$incomingStatus".',
          resolvedData: serverShipmentData,
          createsAuditEvent: true,
        );
      }

      // Latest timestamp wins for transit steps
      if (clientTimestamp.isAfter(serverUpdatedAt)) {
        return ConflictResolutionResult(
          resolved: true,
          strategy: ConflictStrategy.clientWins,
          explanation:
              'Client timestamp ($clientTimestamp) is newer than server ($serverUpdatedAt). Applying client update "$incomingStatus".',
          resolvedData: operation.payload,
          createsAuditEvent: true,
        );
      } else {
        return ConflictResolutionResult(
          resolved: true,
          strategy: ConflictStrategy.serverWins,
          explanation:
              'Server state is newer than offline event. Preserving server status "$currentServerStatus".',
          resolvedData: serverShipmentData,
          createsAuditEvent: true,
        );
      }
    }

    // Default fallback
    return ConflictResolutionResult(
      resolved: true,
      strategy: ConflictStrategy.serverWins,
      explanation: 'Server state preferred for non-evidence operation.',
      resolvedData: serverShipmentData,
      createsAuditEvent: false,
    );
  }
}
