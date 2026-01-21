/// Represents something that happened in the domain.
///
/// Domain events capture state changes and significant occurrences
/// within the domain model. They are immutable records of facts
/// and should be named in past tense (e.g., OrderPlaced, PaymentReceived).
///
/// Domain events should be value objects with structural equality
/// based on their properties.
///
/// This is an interface - you can implement it directly or use it
/// as a marker for your event hierarchy.
abstract interface class DomainEvent {
  /// Creates a domain event.
  const DomainEvent();
}

/// A domain event that can be uniquely identified.
///
/// Most domain events are immutable value objects. This interface captures the
/// common requirement that an event instance can be correlated across logs,
/// message buses, or storage using a stable identifier.
abstract interface class IdentifiedDomainEvent<TId> {
  /// The stable identifier for this event.
  ///
  /// The identifier type is intentionally generic so consumers can use a UUID,
  /// ULID, database ID type, or other identifier primitive.
  TId get id;
}

/// A domain event that carries a timestamp describing when it occurred.
///
/// Prefer representing [occurredOn] as an absolute point in time.
/// The producer of the event defines whether it uses UTC, local time, or
/// another convention.
abstract interface class TimestampedDomainEvent {
  /// The point in time at which the event occurred.
  ///
  /// This value is used for ordering, auditing, and idempotency.
  DateTime get occurredOn;
}

/// A domain event that includes arbitrary metadata.
///
/// Metadata is intended for cross-cutting concerns like correlation IDs,
/// request context, environment info, or source identifiers.
abstract interface class MetadataDomainEvent {
  /// Additional, non-domain data associated with this event.
  ///
  /// Use simple JSON-compatible values where possible.
  ///
  /// `Object?` is used instead of `dynamic` to keep typing explicit while still
  /// allowing `null` and heterogeneous values.
  Map<String, Object?> get metadata;
}

/// A convenience domain event contract.
///
/// This combines identification, timestamping, and metadata into a single
/// interface to keep event handling code consistent.
abstract interface class BoundedDomainEvent<TId> implements DomainEvent, IdentifiedDomainEvent<TId>, TimestampedDomainEvent, MetadataDomainEvent {}
