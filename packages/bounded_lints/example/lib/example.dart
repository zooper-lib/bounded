import 'package:bounded/bounded.dart';

class Price with ValueObject {
  Price(this.amount);

  num amount; // expect: Value objects should be immutable

  @override
  List<Object?> get props => [amount];
}

class OrderId extends TypedIdentity<String> {
  const OrderId(super.value);
}

class OrderPlaced implements BoundedDomainEvent<OrderId> {
  OrderPlaced(this._id, this.occurredOn);

  final OrderId _id;

  @override
  final DateTime occurredOn;

  String? note; // expect: bounded_domain_event_immutable

  @override
  OrderId get id => _id;

  @override
  Map<String, Object?> get metadata => const {};
}

class PaymentReceived implements DomainEvent {
  // expect: Prefer const constructors for domain events when possible
  PaymentReceived(this.orderId, this.amount);

  final OrderId orderId;
  final int amount;
}

enum Status { pending, placed }

class Order extends AggregateRoot<OrderId> {
  Order(super.id);

  Status status = Status.pending;

  void place() {
    recordEvent(OrderPlaced(id, DateTime.now()));
  }
}

class OrderService {
  void recordFromOutside(Order order) {
    order.recordEvent(OrderPlaced(order.id, DateTime.now())); // expect: Record domain events inside aggregate root instance methods
  }
}
