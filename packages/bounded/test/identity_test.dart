import 'package:bounded/bounded.dart';
import 'package:test/test.dart';

// Test identity implementations
class UserId extends TypedIdentity<String> {
  const UserId(super.value);
}

class OrderId extends TypedIdentity<String> {
  const OrderId(super.value);
}

void main() {
  group('Identity', () {
    test('two identities with same value are equal', () {
      final id1 = const UserId('user-123');
      final id2 = const UserId('user-123');

      expect(id1, equals(id2));
      expect(id1.hashCode, equals(id2.hashCode));
    });

    test('two identities with different values are not equal', () {
      final id1 = const UserId('user-123');
      final id2 = const UserId('user-456');

      expect(id1, isNot(equals(id2)));
    });

    test('identities of different types are not equal even with same value', () {
      final userId = const UserId('123');
      final orderId = const OrderId('123');

      expect(userId, isNot(equals(orderId)));
    });

    test('identity has stable string representation', () {
      final id = const UserId('user-123');

      expect(id.toString(), equals('UserId(user-123)'));
    });

    test('identity exposes underlying value', () {
      final id = const UserId('user-123');

      expect(id.value, equals('user-123'));
    });
  });
}
