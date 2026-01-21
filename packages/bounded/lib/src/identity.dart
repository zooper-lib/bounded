/// Base interface for domain identities.
///
/// Identities uniquely identify entities and aggregates in a domain model.
/// They provide value equality based on their underlying representation.
abstract class Identity<T> {
  /// The underlying value of this identity.
  T get value;

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;

  @override
  String toString();
}

/// A strongly-typed identity implementation.
///
/// This class provides a simple, type-safe way to create identities
/// for domain entities and aggregates. Each concrete identity type
/// should extend this class with a specific type parameter to prevent
/// accidental mixing of identities across different domain types.
///
/// Example:
/// ```dart
/// class UserId extends TypedIdentity<String> {
///   const UserId(super.value);
/// }
///
/// class OrderId extends TypedIdentity<String> {
///   const OrderId(super.value);
/// }
/// ```
abstract class TypedIdentity<T> implements Identity<T> {
  /// Creates a typed identity with the given [value].
  const TypedIdentity(this.value);

  @override
  final T value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TypedIdentity<T> && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() => '$runtimeType($value)';
}
