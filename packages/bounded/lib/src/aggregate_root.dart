import 'entity.dart';
import 'identity.dart';

/// Base class for aggregate roots in a domain model.
///
/// Aggregate roots are the entry points to aggregates—clusters of domain
/// objects that can be treated as a single unit for data changes. An
/// aggregate root is responsible for ensuring all invariants within the
/// aggregate are maintained.
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
///   }
/// }
/// ```
abstract class AggregateRoot<ID extends Identity> with Entity<ID> {
  /// Creates an aggregate root with the given [id].
  AggregateRoot(this._id);

  final ID _id;

  @override
  ID get id => _id;
}
