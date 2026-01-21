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
    recordEvent(OrderPlaced(id, at));
  }

  void ship() {
    if (status != OrderStatus.placed) {
      throw StateError('Order can only be shipped when placed');
    }
    status = OrderStatus.shipped;
    recordEvent(OrderShipped(id));
  }
}

void main() {
  group('AggregateRoot', () {
    test('aggregate can record domain events during transitions', () {
      final order = Order(const OrderId('order-123'));
      final placedAt = DateTime(2026, 1, 21);

      order.place(placedAt);

      expect(order.events, hasLength(1));
      expect(order.events.first, isA<OrderPlaced>());
      final event = order.events.first as OrderPlaced;
      expect(event.orderId, equals(order.id));
      expect(event.placedAt, equals(placedAt));
    });

    test('aggregate records multiple events', () {
      final order = Order(const OrderId('order-123'));

      order.place(DateTime.now());
      order.ship();

      expect(order.events, hasLength(2));
      expect(order.events[0], isA<OrderPlaced>());
      expect(order.events[1], isA<OrderShipped>());
    });

    test('events property returns read-only view', () {
      final order = Order(const OrderId('order-123'));
      order.place(DateTime.now());

      final events = order.events;
      expect(() => (events as List).add(OrderShipped(order.id)), throwsUnsupportedError);
    });

    test('clearEvents removes all recorded events', () {
      final order = Order(const OrderId('order-123'));
      order.place(DateTime.now());

      expect(order.events, hasLength(1));

      order.clearEvents();

      expect(order.events, isEmpty);
    });

    test('pullEvents drains events in order and clears', () {
      final order = Order(const OrderId('order-123'));

      order.place(DateTime(2026, 1, 21));
      order.ship();

      final drained = order.pullEvents();

      expect(drained, hasLength(2));
      expect(drained[0], isA<OrderPlaced>());
      expect(drained[1], isA<OrderShipped>());
      expect(order.events, isEmpty);
    });

    test('pullEvents returns empty list when no events are recorded', () {
      final order = Order(const OrderId('order-123'));

      final drained = order.pullEvents();

      expect(drained, isEmpty);
      expect(order.events, isEmpty);
    });

    test('aggregate starts with no events', () {
      final order = Order(const OrderId('order-123'));

      expect(order.events, isEmpty);
    });

    test('aggregate enforces invariants without infrastructure', () {
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
