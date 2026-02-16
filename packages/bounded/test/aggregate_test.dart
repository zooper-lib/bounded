import 'package:bounded/bounded.dart';
import 'package:test/test.dart';

// Test implementations
class OrderId extends TypedIdentity<String> {
  const OrderId(super.value);
}

class OrderPlaced with ValueObject implements DomainEvent {
  const OrderPlaced(this.orderId, this.placedAt);

  final OrderId orderId;
  final DateTime placedAt;

  @override
  List<Object?> get props => [orderId, placedAt];
}

class OrderShipped with ValueObject implements DomainEvent {
  const OrderShipped(this.orderId);

  final OrderId orderId;

  @override
  List<Object?> get props => [orderId];
}

enum OrderStatus { pending, placed, shipped }

class Order extends AggregateRoot<OrderId> {
  Order(super.id);

  OrderStatus status = OrderStatus.pending;

  void place(DateTime at) {
    if (status != OrderStatus.pending) {
      throw StateError('Order can only be placed when pending');
    }
    status = OrderStatus.placed;
  }

  void ship() {
    if (status != OrderStatus.placed) {
      throw StateError('Order can only be shipped when placed');
    }
    status = OrderStatus.shipped;
  }
}

void main() {
  group('AggregateRoot', () {
    test('aggregate can perform state transitions', () {
      final order = Order(const OrderId('order-123'));
      final placedAt = DateTime(2026, 1, 21);

      order.place(placedAt);

      expect(order.status, equals(OrderStatus.placed));
    });

    test('aggregate can perform multiple transitions', () {
      final order = Order(const OrderId('order-123'));

      order.place(DateTime.now());
      order.ship();

      expect(order.status, equals(OrderStatus.shipped));
    });

    test('aggregate enforces invariants', () {
      final order = Order(const OrderId('order-123'));

      // Cannot ship without placing first
      expect(() => order.ship(), throwsStateError);
    });

    test('aggregate identity-based equality inherited from Entity', () {
      final id = const OrderId('order-123');
      final order1 = Order(id);
      final order2 = Order(id);

      order1.place(DateTime.now());
      // order2 has different state but same identity

      expect(order1, equals(order2));
    });
  });

  group('DomainEvent', () {
    test('domain events are value objects with structural equality', () {
      final orderId = const OrderId('order-123');
      final timestamp = DateTime(2026, 1, 21);

      final event1 = OrderPlaced(orderId, timestamp);
      final event2 = OrderPlaced(orderId, timestamp);

      expect(event1, equals(event2));
      expect(event1.hashCode, equals(event2.hashCode));
    });

    test('domain events with different values are not equal', () {
      final event1 = OrderPlaced(const OrderId('order-123'), DateTime(2026, 1, 21));
      final event2 = OrderPlaced(const OrderId('order-123'), DateTime(2026, 1, 22));

      expect(event1, isNot(equals(event2)));
    });
  });
}
