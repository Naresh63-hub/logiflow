import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Logistics Input Validation Logic Tests', () {
    bool isValidEmail(String email) {
      if (email.trim().isEmpty) return false;
      return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim());
    }

    bool isValidPhone(String phone) {
      final cleaned = phone.replaceAll(RegExp(r'[\s\-\+\(\)]'), '');
      return RegExp(r'^\d{10,13}$').hasMatch(cleaned);
    }

    bool isValidWeight(String weightStr) {
      final w = double.tryParse(weightStr);
      return w != null && w > 0 && w <= 2000.0;
    }

    bool isValidTrackingId(String trackingId) {
      return RegExp(r'^YUV-\d{4}-\d{5}$').hasMatch(trackingId.trim());
    }

    test('Email format validation accepts standard enterprise formats and rejects malformed', () {
      expect(isValidEmail('shipper@yuvaintern.com'), isTrue);
      expect(isValidEmail('manager.rajesh@noida.logistics.in'), isTrue);
      expect(isValidEmail('invalid-email'), isFalse);
      expect(isValidEmail('@domain.com'), isFalse);
      expect(isValidEmail('user@'), isFalse);
      expect(isValidEmail(''), isFalse);
    });

    test('Indian contact phone validation accepts standard mobile & STD numbers', () {
      expect(isValidPhone('+91 98712 34567'), isTrue);
      expect(isValidPhone('9871234567'), isTrue);
      expect(isValidPhone('+91 120 4567890'), isTrue);
      expect(isValidPhone('123'), isFalse);
      expect(isValidPhone('abcdefghijk'), isFalse);
    });

    test('Weight validation enforces positive range under logistics vehicle limit', () {
      expect(isValidWeight('2.5'), isTrue);
      expect(isValidWeight('0.5'), isTrue);
      expect(isValidWeight('150.0'), isTrue);
      expect(isValidWeight('0'), isFalse);
      expect(isValidWeight('-5.0'), isFalse);
      expect(isValidWeight('not_a_number'), isFalse);
      expect(isValidWeight('25000'), isFalse);
    });

    test('Tracking identifier format validation strictly matches YUV-YYYY-XXXXX standard', () {
      expect(isValidTrackingId('YUV-2026-88401'), isTrue);
      expect(isValidTrackingId('YUV-2026-10023'), isTrue);
      expect(isValidTrackingId('ABC-2026-88401'), isFalse);
      expect(isValidTrackingId('YUV-26-88401'), isFalse);
      expect(isValidTrackingId('YUV-2026-884'), isFalse);
    });
  });
}
