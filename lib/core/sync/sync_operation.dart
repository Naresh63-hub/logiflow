import 'dart:convert';

enum SyncOperationType {
  createShipment,
  updateStatus,
  submitPOD,
  assignDriver;

  String get dbValue {
    switch (this) {
      case SyncOperationType.createShipment:
        return 'CREATE_SHIPMENT';
      case SyncOperationType.updateStatus:
        return 'UPDATE_STATUS';
      case SyncOperationType.submitPOD:
        return 'SUBMIT_POD';
      case SyncOperationType.assignDriver:
        return 'ASSIGN_DRIVER';
    }
  }

  static SyncOperationType fromString(String val) {
    switch (val.toUpperCase()) {
      case 'CREATE_SHIPMENT':
        return SyncOperationType.createShipment;
      case 'UPDATE_STATUS':
        return SyncOperationType.updateStatus;
      case 'SUBMIT_POD':
        return SyncOperationType.submitPOD;
      case 'ASSIGN_DRIVER':
        return SyncOperationType.assignDriver;
      default:
        return SyncOperationType.updateStatus;
    }
  }
}

class SyncOperationModel {
  final String operationId;
  final String userId;
  final String shipmentId;
  final SyncOperationType operationType;
  final Map<String, dynamic> payload;
  final DateTime localTimestamp;
  final String syncStatus; // pending, syncing, synced, failed, conflict
  final int retryCount;
  final String? lastError;

  const SyncOperationModel({
    required this.operationId,
    required this.userId,
    required this.shipmentId,
    required this.operationType,
    required this.payload,
    required this.localTimestamp,
    this.syncStatus = 'pending',
    this.retryCount = 0,
    this.lastError,
  });

  SyncOperationModel copyWith({
    String? operationId,
    String? userId,
    String? shipmentId,
    SyncOperationType? operationType,
    Map<String, dynamic>? payload,
    DateTime? localTimestamp,
    String? syncStatus,
    int? retryCount,
    String? lastError,
  }) {
    return SyncOperationModel(
      operationId: operationId ?? this.operationId,
      userId: userId ?? this.userId,
      shipmentId: shipmentId ?? this.shipmentId,
      operationType: operationType ?? this.operationType,
      payload: payload ?? this.payload,
      localTimestamp: localTimestamp ?? this.localTimestamp,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
    );
  }

  String get payloadJson => jsonEncode(payload);

  Map<String, dynamic> toJson() => {
        'operation_id': operationId,
        'user_id': userId,
        'shipment_id': shipmentId,
        'operation_type': operationType.dbValue,
        'payload': payload,
        'local_timestamp': localTimestamp.toIso8601String(),
        'sync_status': syncStatus,
        'retry_count': retryCount,
        'last_error': lastError,
      };

  factory SyncOperationModel.fromJson(Map<String, dynamic> json) {
    return SyncOperationModel(
      operationId: json['operation_id'] as String,
      userId: json['user_id'] as String,
      shipmentId: json['shipment_id'] as String,
      operationType: SyncOperationType.fromString(json['operation_type'] as String),
      payload: json['payload'] is String
          ? jsonDecode(json['payload'] as String) as Map<String, dynamic>
          : json['payload'] as Map<String, dynamic>,
      localTimestamp: DateTime.parse(json['local_timestamp'] as String),
      syncStatus: json['sync_status'] as String? ?? 'pending',
      retryCount: json['retry_count'] as int? ?? 0,
      lastError: json['last_error'] as String?,
    );
  }
}
