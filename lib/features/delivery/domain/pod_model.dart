class ProofOfDeliveryModel {
  final String id;
  final String shipmentId;
  final String receiverName;
  final String? signaturePath;
  final String? photoPath;
  final double deliveryLatitude;
  final double deliveryLongitude;
  final DateTime deliveryTimestamp;
  final String? notes;
  final String submittedBy;
  final String syncStatus;
  final bool isVerified;
  final DateTime createdAt;

  const ProofOfDeliveryModel({
    required this.id,
    required this.shipmentId,
    required this.receiverName,
    this.signaturePath,
    this.photoPath,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    required this.deliveryTimestamp,
    this.notes,
    required this.submittedBy,
    this.syncStatus = 'synced',
    this.isVerified = true,
    required this.createdAt,
  });

  ProofOfDeliveryModel copyWith({
    String? id,
    String? shipmentId,
    String? receiverName,
    String? signaturePath,
    String? photoPath,
    double? deliveryLatitude,
    double? deliveryLongitude,
    DateTime? deliveryTimestamp,
    String? notes,
    String? submittedBy,
    String? syncStatus,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return ProofOfDeliveryModel(
      id: id ?? this.id,
      shipmentId: shipmentId ?? this.shipmentId,
      receiverName: receiverName ?? this.receiverName,
      signaturePath: signaturePath ?? this.signaturePath,
      photoPath: photoPath ?? this.photoPath,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      deliveryTimestamp: deliveryTimestamp ?? this.deliveryTimestamp,
      notes: notes ?? this.notes,
      submittedBy: submittedBy ?? this.submittedBy,
      syncStatus: syncStatus ?? this.syncStatus,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'shipment_id': shipmentId,
        'receiver_name': receiverName,
        'signature_url': signaturePath,
        'photo_url': photoPath,
        'delivery_latitude': deliveryLatitude,
        'delivery_longitude': deliveryLongitude,
        'delivery_timestamp': deliveryTimestamp.toIso8601String(),
        'notes': notes,
        'submitted_by': submittedBy,
        'sync_status': syncStatus,
        'is_verified': isVerified,
        'created_at': createdAt.toIso8601String(),
      };

  factory ProofOfDeliveryModel.fromJson(Map<String, dynamic> json) {
    return ProofOfDeliveryModel(
      id: json['id'] as String,
      shipmentId: json['shipment_id'] as String,
      receiverName: json['receiver_name'] as String,
      signaturePath: json['signature_url'] as String?,
      photoPath: json['photo_url'] as String?,
      deliveryLatitude: (json['delivery_latitude'] as num).toDouble(),
      deliveryLongitude: (json['delivery_longitude'] as num).toDouble(),
      deliveryTimestamp: DateTime.parse(json['delivery_timestamp'] as String),
      notes: json['notes'] as String?,
      submittedBy: json['submitted_by'] as String,
      syncStatus: json['sync_status'] as String? ?? 'synced',
      isVerified: json['is_verified'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
