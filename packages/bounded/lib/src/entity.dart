import 'identity.dart';

/// Mixin for entities in a domain model.
///
/// Entities are objects that have a distinct identity that runs through
/// time and different representations. Two entities are equal if they
/// have the same identity, regardless of their other attributes.
///
/// Classes using this mixin must provide an [id] getter.
///
/// Example:
/// ```dart
/// class User with Entity<UserId> {
///   User(this.id, this.name);
///
///   @override
///   final UserId id;
///   final String name;
/// }
/// ```
mixin Entity<ID extends Identity> {
  /// The unique identifier of this entity.
  ID get id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Entity<ID> && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() => '$runtimeType($id)';
}
