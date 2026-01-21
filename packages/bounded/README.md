# bounded

A minimal, framework-agnostic common kernel for Domain-Driven Design (DDD).

`bounded` provides fundamental building blocks for modeling domains without coupling to infrastructure concerns. It focuses on core DDD primitives that help you implement clean, testable domain models.

## Features

- **Strongly-typed Identities**: Type-safe identifiers that prevent accidental mixing across domain types
- **Value Objects**: Immutable objects with structural equality based on their components
- **Entities**: Objects with distinct identity that persists through different states
- **Aggregate Roots**: Consistency boundaries that enforce domain invariants
- **Domain Events**: Immutable records of significant domain occurrences

All primitives are infrastructure-free and can be unit tested without external dependencies.

## Getting started

Add `bounded` to your `pubspec.yaml`:

```yaml
dependencies:
  bounded: ^1.0.0
```

## Usage

### Identities

Create strongly-typed identities to uniquely identify entities:

```dart
import 'package:bounded/bounded.dart';

class UserId extends TypedIdentity<String> {
  const UserId(super.value);
}

class OrderId extends TypedIdentity<String> {
  const OrderId(super.value);
}

void main() {
  final userId = UserId('user-123');
  final orderId = OrderId('order-456');

  // Type system prevents mixing different identity types
  // userId == orderId; // Compile error!
}
```

### Value Objects

Model immutable value objects with structural equality:

```dart
import 'package:bounded/bounded.dart';

class Money with ValueObject {
  const Money(this.amount, this.currency);

  final num amount;
  final String currency;

  @override
  List<Object?> get props => [amount, currency];
}

void main() {
  final price1 = Money(100, 'USD');
  final price2 = Money(100, 'USD');

  print(price1 == price2); // true - structural equality
}
```

### Entities and Aggregates

Create entities with identity-based equality and aggregates that enforce invariants:

```dart
import 'package:bounded/bounded.dart';

class OrderId extends TypedIdentity<String> {
  const OrderId(super.value);
}

class OrderPlaced with ValueObject implements BoundedDomainEvent<OrderId> {
  const OrderPlaced(this.orderId, this.placedAt);

  final OrderId orderId;
  final DateTime placedAt;

  @override
  OrderId get id => orderId;

  @override
  DateTime get occurredOn => placedAt;

  @override
  Map<String, Object?> get metadata => const {};

  @override
  List<Object?> get props => [orderId, placedAt];
}

enum OrderStatus { pending, placed, shipped }

class Order extends AggregateRoot<OrderId> {
  Order(super.id);

  OrderStatus status = OrderStatus.pending;

  void place() {
    Guard.invariant(status == OrderStatus.pending, 'Order can only be placed when pending');
    status = OrderStatus.placed;
    recordEvent(OrderPlaced(id, DateTime.now()));
  }
}

void main() {
  final order = Order(OrderId('order-123'));
  order.place();

  // Events are recorded but not dispatched
  print(order.events); // [OrderPlaced(...)]

  // Application layer can publish events
  final events = order.pullEvents();
  // ... publish to event bus, store in event stream, etc.
}
```

## Design Principles

- **No Infrastructure**: Domain models remain pure and testable
- **Explicit over Magic**: No code generation or reflection required
- **Small API Surface**: Minimal primitives that compose well
- **Type Safety**: Leverage Dart's type system to prevent errors

## Lints (optional)

This project also ships a companion package, `bounded_lints`, which provides `custom_lint` rules that warn when code violates the domain design principles encouraged by `bounded` (for example: domain event/value object immutability).

To use it:

```yaml
dev_dependencies:
  custom_lint: ^0.8.1
  bounded_lints: ^1.0.0
```

And enable the plugin:

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Additional information

This package is the foundation of a DDD ecosystem. It intentionally excludes:
- Event sourcing and persistence
- Event dispatching and transport
- Repository patterns
- Framework integrations

These concerns are handled by higher-level packages that build on `bounded`.
