import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

enum ShipmentStatus {
  created,
  pickupScheduled,
  pickedUp,
  arrivedAtHub,
  inTransit,
  outForDelivery,
  delivered,
  deliveryFailed,
  returned,
  cancelled;

  String get translationKey {
    switch (this) {
      case ShipmentStatus.created:
        return 'status_created';
      case ShipmentStatus.pickupScheduled:
        return 'status_pickup_scheduled';
      case ShipmentStatus.pickedUp:
        return 'status_picked_up';
      case ShipmentStatus.arrivedAtHub:
        return 'status_arrived_at_hub';
      case ShipmentStatus.inTransit:
        return 'status_in_transit';
      case ShipmentStatus.outForDelivery:
        return 'status_out_for_delivery';
      case ShipmentStatus.delivered:
        return 'status_delivered';
      case ShipmentStatus.deliveryFailed:
        return 'status_delivery_failed';
      case ShipmentStatus.returned:
        return 'status_returned';
      case ShipmentStatus.cancelled:
        return 'status_cancelled';
    }
  }

  String get displayName {
    switch (this) {
      case ShipmentStatus.created:
        return 'Created';
      case ShipmentStatus.pickupScheduled:
        return 'Pickup Scheduled';
      case ShipmentStatus.pickedUp:
        return 'Picked Up';
      case ShipmentStatus.arrivedAtHub:
        return 'Arrived at Hub';
      case ShipmentStatus.inTransit:
        return 'In Transit';
      case ShipmentStatus.outForDelivery:
        return 'Out for Delivery';
      case ShipmentStatus.delivered:
        return 'Delivered';
      case ShipmentStatus.deliveryFailed:
        return 'Delivery Failed';
      case ShipmentStatus.returned:
        return 'Returned';
      case ShipmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case ShipmentStatus.created:
        return AppColors.statusCreated;
      case ShipmentStatus.pickupScheduled:
        return AppColors.statusPickupScheduled;
      case ShipmentStatus.pickedUp:
        return AppColors.statusPickedUp;
      case ShipmentStatus.arrivedAtHub:
        return AppColors.statusArrivedAtHub;
      case ShipmentStatus.inTransit:
        return AppColors.statusInTransit;
      case ShipmentStatus.outForDelivery:
        return AppColors.statusOutForDelivery;
      case ShipmentStatus.delivered:
        return AppColors.statusDelivered;
      case ShipmentStatus.deliveryFailed:
        return AppColors.statusDeliveryFailed;
      case ShipmentStatus.returned:
        return AppColors.statusReturned;
      case ShipmentStatus.cancelled:
        return AppColors.statusCancelled;
    }
  }

  IconData get icon {
    switch (this) {
      case ShipmentStatus.created:
        return Icons.add_box_outlined;
      case ShipmentStatus.pickupScheduled:
        return Icons.event_available_outlined;
      case ShipmentStatus.pickedUp:
        return Icons.local_shipping_outlined;
      case ShipmentStatus.arrivedAtHub:
        return Icons.warehouse_outlined;
      case ShipmentStatus.inTransit:
        return Icons.moving_outlined;
      case ShipmentStatus.outForDelivery:
        return Icons.delivery_dining_outlined;
      case ShipmentStatus.delivered:
        return Icons.check_circle_outline;
      case ShipmentStatus.deliveryFailed:
        return Icons.error_outline;
      case ShipmentStatus.returned:
        return Icons.replay;
      case ShipmentStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  static ShipmentStatus fromString(String val) {
    switch (val.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_')) {
      case 'pickup_scheduled':
        return ShipmentStatus.pickupScheduled;
      case 'picked_up':
        return ShipmentStatus.pickedUp;
      case 'arrived_at_hub':
        return ShipmentStatus.arrivedAtHub;
      case 'in_transit':
        return ShipmentStatus.inTransit;
      case 'out_for_delivery':
        return ShipmentStatus.outForDelivery;
      case 'delivered':
        return ShipmentStatus.delivered;
      case 'delivery_failed':
        return ShipmentStatus.deliveryFailed;
      case 'returned':
        return ShipmentStatus.returned;
      case 'cancelled':
        return ShipmentStatus.cancelled;
      case 'created':
      default:
        return ShipmentStatus.created;
    }
  }

  String toDbString() {
    switch (this) {
      case ShipmentStatus.created:
        return 'created';
      case ShipmentStatus.pickupScheduled:
        return 'pickup_scheduled';
      case ShipmentStatus.pickedUp:
        return 'picked_up';
      case ShipmentStatus.arrivedAtHub:
        return 'arrived_at_hub';
      case ShipmentStatus.inTransit:
        return 'in_transit';
      case ShipmentStatus.outForDelivery:
        return 'out_for_delivery';
      case ShipmentStatus.delivered:
        return 'delivered';
      case ShipmentStatus.deliveryFailed:
        return 'delivery_failed';
      case ShipmentStatus.returned:
        return 'returned';
      case ShipmentStatus.cancelled:
        return 'cancelled';
    }
  }
}

enum PriorityLevel {
  standard,
  express,
  overnight;

  String get displayName {
    switch (this) {
      case PriorityLevel.standard:
        return 'Standard (3-5 Days)';
      case PriorityLevel.express:
        return 'Express (1-2 Days)';
      case PriorityLevel.overnight:
        return 'Overnight Urgent';
    }
  }

  Color get color {
    switch (this) {
      case PriorityLevel.standard:
        return Colors.blueGrey;
      case PriorityLevel.express:
        return AppColors.secondary;
      case PriorityLevel.overnight:
        return AppColors.accent;
    }
  }

  static PriorityLevel fromString(String val) {
    switch (val.toLowerCase()) {
      case 'express':
        return PriorityLevel.express;
      case 'overnight':
        return PriorityLevel.overnight;
      case 'standard':
      default:
        return PriorityLevel.standard;
    }
  }

  String toDbString() => name;
}

class ShipmentModel {
  final String id;
  final String trackingNumber;
  final String senderId;
  final String senderName;
  final String senderPhone;
  final String senderAddress;
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
  final String packageCategory;
  final double weightKg;
  final PriorityLevel priority;
  final ShipmentStatus currentStatus;
  final String originHubId;
  final String destinationHubId;
  final String? assignedDriverId;
  final DateTime expectedDelivery;
  final int version;
  final bool isDirty;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ShipmentModel({
    required this.id,
    required this.trackingNumber,
    required this.senderId,
    required this.senderName,
    required this.senderPhone,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.packageCategory,
    required this.weightKg,
    required this.priority,
    required this.currentStatus,
    required this.originHubId,
    required this.destinationHubId,
    this.assignedDriverId,
    required this.expectedDelivery,
    this.version = 1,
    this.isDirty = false,
    this.syncStatus = 'synced',
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isDelivered => currentStatus == ShipmentStatus.delivered;
  bool get isInTransit => currentStatus == ShipmentStatus.inTransit || currentStatus == ShipmentStatus.outForDelivery;
  bool get isPending => currentStatus == ShipmentStatus.created || currentStatus == ShipmentStatus.pickupScheduled;
  bool get isDelayed => currentStatus == ShipmentStatus.deliveryFailed;

  ShipmentModel copyWith({
    String? id,
    String? trackingNumber,
    String? senderId,
    String? senderName,
    String? senderPhone,
    String? senderAddress,
    String? receiverName,
    String? receiverPhone,
    String? receiverAddress,
    String? packageCategory,
    double? weightKg,
    PriorityLevel? priority,
    ShipmentStatus? currentStatus,
    String? originHubId,
    String? destinationHubId,
    String? assignedDriverId,
    DateTime? expectedDelivery,
    int? version,
    bool? isDirty,
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShipmentModel(
      id: id ?? this.id,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      senderAddress: senderAddress ?? this.senderAddress,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      packageCategory: packageCategory ?? this.packageCategory,
      weightKg: weightKg ?? this.weightKg,
      priority: priority ?? this.priority,
      currentStatus: currentStatus ?? this.currentStatus,
      originHubId: originHubId ?? this.originHubId,
      destinationHubId: destinationHubId ?? this.destinationHubId,
      assignedDriverId: assignedDriverId ?? this.assignedDriverId,
      expectedDelivery: expectedDelivery ?? this.expectedDelivery,
      version: version ?? this.version,
      isDirty: isDirty ?? this.isDirty,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tracking_number': trackingNumber,
        'sender_id': senderId,
        'sender_name': senderName,
        'sender_phone': senderPhone,
        'sender_address': senderAddress,
        'receiver_name': receiverName,
        'receiver_phone': receiverPhone,
        'receiver_address': receiverAddress,
        'package_category': packageCategory,
        'weight_kg': weightKg,
        'priority': priority.toDbString(),
        'current_status': currentStatus.toDbString(),
        'origin_hub_id': originHubId,
        'destination_hub_id': destinationHubId,
        'assigned_driver_id': assignedDriverId,
        'expected_delivery': expectedDelivery.toIso8601String(),
        'version': version,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'] as String,
      trackingNumber: json['tracking_number'] as String,
      senderId: json['sender_id'] as String,
      senderName: json['sender_name'] as String,
      senderPhone: json['sender_phone'] as String,
      senderAddress: json['sender_address'] as String,
      receiverName: json['receiver_name'] as String,
      receiverPhone: json['receiver_phone'] as String,
      receiverAddress: json['receiver_address'] as String,
      packageCategory: json['package_category'] as String,
      weightKg: (json['weight_kg'] as num).toDouble(),
      priority: PriorityLevel.fromString(json['priority'] as String? ?? 'standard'),
      currentStatus: ShipmentStatus.fromString(json['current_status'] as String? ?? 'created'),
      originHubId: json['origin_hub_id'] as String,
      destinationHubId: json['destination_hub_id'] as String,
      assignedDriverId: json['assigned_driver_id'] as String?,
      expectedDelivery: DateTime.parse(json['expected_delivery'] as String),
      version: json['version'] as int? ?? 1,
      isDirty: false,
      syncStatus: 'synced',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class ShipmentEventModel {
  final String id;
  final String shipmentId;
  final ShipmentStatus? previousStatus;
  final ShipmentStatus newStatus;
  final String locationName;
  final double? latitude;
  final double? longitude;
  final String? remarks;
  final String updatedBy;
  final DateTime createdAt;

  const ShipmentEventModel({
    required this.id,
    required this.shipmentId,
    this.previousStatus,
    required this.newStatus,
    required this.locationName,
    this.latitude,
    this.longitude,
    this.remarks,
    required this.updatedBy,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'shipment_id': shipmentId,
        'previous_status': previousStatus?.toDbString(),
        'new_status': newStatus.toDbString(),
        'location_name': locationName,
        'latitude': latitude,
        'longitude': longitude,
        'remarks': remarks,
        'updated_by': updatedBy,
        'created_at': createdAt.toIso8601String(),
      };

  factory ShipmentEventModel.fromJson(Map<String, dynamic> json) {
    return ShipmentEventModel(
      id: json['id'] as String,
      shipmentId: json['shipment_id'] as String,
      previousStatus: json['previous_status'] != null
          ? ShipmentStatus.fromString(json['previous_status'] as String)
          : null,
      newStatus: ShipmentStatus.fromString(json['new_status'] as String),
      locationName: json['location_name'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      remarks: json['remarks'] as String?,
      updatedBy: json['updated_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
