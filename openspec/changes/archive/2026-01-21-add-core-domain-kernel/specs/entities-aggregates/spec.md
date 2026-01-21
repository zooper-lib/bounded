# Capability: Entities and Aggregates

## ADDED Requirements

### Requirement: Entity identity
The system SHALL provide an entity abstraction whose identity is represented by an identity type.

#### Scenario: Entities compare by identity
- **WHEN** a consumer compares two entities with the same identity
- **THEN** they compare equal regardless of other state

### Requirement: Aggregate root boundary
The system SHALL provide an aggregate root abstraction to model transactional consistency boundaries.

#### Scenario: Aggregate root owns invariants
- **WHEN** a consumer models an aggregate root
- **THEN** state transitions SHOULD be implemented on the aggregate root
- **AND** invariants SHOULD be enforced within those transitions

### Requirement: Explicit invariant enforcement
The system SHALL enable modeling invariants without infrastructure coupling.

#### Scenario: Preventing illegal state
- **WHEN** a state transition would violate an invariant
- **THEN** the transition fails explicitly (e.g., by throwing a domain error or returning a failure type)
