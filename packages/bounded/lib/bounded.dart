/// A minimal, framework-agnostic common kernel for Domain-Driven Design (DDD).
///
/// This library provides fundamental building blocks for modeling domains:
/// - **Identity**: Strongly-typed identifiers for entities and aggregates
/// - **Value Objects**: Immutable objects with structural equality
/// - **Entities**: Objects with distinct identity
/// - **Aggregate Roots**: Consistency boundaries that enforce invariants
/// - **Domain Events**: Records of significant domain occurrences
///
/// These primitives are infrastructure-free and can be unit tested without
/// external dependencies.
library;

export 'src/aggregate_root.dart';
export 'src/domain_event.dart';
export 'src/entity.dart';
export 'src/guards.dart';
export 'src/identity.dart';
export 'src/value_object.dart';
