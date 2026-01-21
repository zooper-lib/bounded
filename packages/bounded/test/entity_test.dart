import 'package:bounded/bounded.dart';
import 'package:test/test.dart';

// Test implementations
class UserId extends TypedIdentity<String> {
  const UserId(super.value);
}

class User with Entity<UserId> {
  User(this.id, this.name);

  @override
  final UserId id;
  final String name;
}

void main() {
  group('Entity', () {
    test('two entities with same identity are equal', () {
      final id = const UserId('user-123');
      final user1 = User(id, 'Alice');
      final user2 = User(id, 'Bob'); // Different name, same identity

      expect(user1, equals(user2));
      expect(user1.hashCode, equals(user2.hashCode));
    });

    test('two entities with different identities are not equal', () {
      final user1 = User(const UserId('user-123'), 'Alice');
      final user2 = User(const UserId('user-456'), 'Alice'); // Same name, different identity

      expect(user1, isNot(equals(user2)));
    });

    test('entity exposes its identity', () {
      final id = const UserId('user-123');
      final user = User(id, 'Alice');

      expect(user.id, equals(id));
    });

    test('entity has string representation with identity', () {
      final user = User(const UserId('user-123'), 'Alice');

      expect(user.toString(), contains('User'));
      expect(user.toString(), contains('UserId(user-123)'));
    });
  });
}
