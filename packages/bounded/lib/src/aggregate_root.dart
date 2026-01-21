import 'domain_event.dart';
import 'entity.dart';
import 'identity.dart';

/// Base class for aggregate roots in a domain model.
///
/// Aggregate roots are the entry points to aggregates—clusters of domain
/// objects that can be treated as a single unit for data changes. An
/// aggregate root is responsible for ensuring all invariants within the
/// aggregate are maintained.
///
/// Aggregate roots can record domain events during state transitions.
/// These events represent facts that have occurred within the domain
/// and can be published or persisted by application layer code.
///
/// An aggregate root is an [Entity] with event collection capabilities.
///
/// Example:
/// ```dart
/// class Order extends AggregateRoot<OrderId> {
///   Order(super.id, this.customerId);
///
///   final CustomerId customerId;
///   OrderStatus status = OrderStatus.pending;
///
///   void place() {
///     if (status != OrderStatus.pending) {
///       throw StateError('Order can only be placed when pending');
///     }
///     status = OrderStatus.placed;
///     recordEvent(OrderPlaced(id, DateTime.now()));
///   }
/// }
/// ```
abstract class AggregateRoot<ID extends Identity> with Entity<ID> {
  /// Creates an aggregate root with the given [id].
  AggregateRoot(this._id);

  final ID _id;

  @override
  ID get id => _id;

  final List<DomainEvent> _events = [];

  /// Records a domain event that occurred during a state transition.
  ///
  /// Events are stored internally and can be retrieved via [events]
  /// for publishing or persistence by application layer code.
  void recordEvent(DomainEvent event) {
    _events.add(event);
  }

  /// Returns a read-only view of domain events recorded by this aggregate.
  ///
  /// This list contains events that have been recorded but not yet cleared.
  List<DomainEvent> get events => List.unmodifiable(_events);

  /// Clears all recorded domain events.
  ///
  /// This should be called after events have been published or persisted
  /// to prevent them from being processed multiple times.
  void clearEvents() {
    _events.clear();
  }

  /// Returns all recorded domain events and clears them in a single operation.
  ///
  /// This is a convenience for the common application-layer flow:
  /// 1) perform a domain operation
  /// 2) publish/persist the resulting events
  /// 3) clear the pending event buffer
  ///
  /// Events are returned in the order they were recorded.
  List<DomainEvent> pullEvents() {
    if (_events.isEmpty) {
      return const <DomainEvent>[];
    }

    final drained = List<DomainEvent>.unmodifiable(_events);
    _events.clear();
    return drained;
  }
}
