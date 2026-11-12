import 'package:flutter_test/flutter_test.dart';
import 'package:logistics_app/features/shipments/domain/shipment_model.dart';

void main() {
  group('ShipmentModel Unit Tests', () {
    final now = DateTime.now();

    final testShipment = ShipmentModel(
      id: 'test-uuid-001',
      trackingNumber: 'LGF-2026-99001',
      senderId: 'user-001',
      senderName: 'Amit Sharma',
      senderPhone: '+91 98712 34567',
      senderAddress: 'Sector 62, Noida',
      receiverName: 'Sunil Mehra',
      receiverPhone: '+91 98188 23456',
      receiverAddress: 'Sector 18, Noida',
      packageCategory: 'Electronics',
      weightKg: 2.5,
      priority: PriorityLevel.express,
      currentStatus: ShipmentStatus.inTransit,
      originHubId: 'hub-01',
      destinationHubId: 'hub-02',
      expectedDelivery: now.add(const Duration(days: 1)),
      version: 2,
      createdAt: now,
      updatedAt: now,
    );

    test('ShipmentModel JSON serialization roundtrip maintains field integrity', () {
      final json = testShipment.toJson();
      expect(json['tracking_number'], 'LGF-2026-99001');
      expect(json['weight_kg'], 2.5);
      expect(json['current_status'], 'in_transit');
      expect(json['priority'], 'express');
      expect(json['version'], 2);

      final deserialized = ShipmentModel.fromJson(json);
      expect(deserialized.id, testShipment.id);
      expect(deserialized.trackingNumber, testShipment.trackingNumber);
      expect(deserialized.currentStatus, ShipmentStatus.inTransit);
      expect(deserialized.priority, PriorityLevel.express);
      expect(deserialized.version, 2);
    });

    test('ShipmentStatus enum parsers correctly handle varied casing and delimiters', () {
      expect(ShipmentStatus.fromString('in_transit'), ShipmentStatus.inTransit);
      expect(ShipmentStatus.fromString('IN-TRANSIT'), ShipmentStatus.inTransit);
      expect(ShipmentStatus.fromString('out_for_delivery'), ShipmentStatus.outForDelivery);
      expect(ShipmentStatus.fromString('OUT FOR DELIVERY'), ShipmentStatus.outForDelivery);
      expect(ShipmentStatus.fromString('delivered'), ShipmentStatus.delivered);
      expect(ShipmentStatus.fromString('delivery_failed'), ShipmentStatus.deliveryFailed);
      expect(ShipmentStatus.fromString('unknown_value'), ShipmentStatus.created);
    });

    test('PriorityLevel enum correctly maps delivery expectations and colors', () {
      expect(PriorityLevel.fromString('standard'), PriorityLevel.standard);
      expect(PriorityLevel.fromString('express'), PriorityLevel.express);
      expect(PriorityLevel.fromString('overnight'), PriorityLevel.overnight);
      expect(PriorityLevel.fromString('INVALID'), PriorityLevel.standard);
    });

    test('Status category helper flags evaluate correctly', () {
      expect(testShipment.isInTransit, isTrue);
      expect(testShipment.isDelivered, isFalse);

      final deliveredShipment = testShipment.copyWith(currentStatus: ShipmentStatus.delivered);
      expect(deliveredShipment.isDelivered, isTrue);
      expect(deliveredShipment.isInTransit, isFalse);
    });
  });
}
