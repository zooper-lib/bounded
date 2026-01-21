# Capability: Entities and Aggregates

## ADDED Requirements

### Requirement: Invariant guard helpers
The system SHALL provide small helper APIs to enforce invariants explicitly without infrastructure coupling.

#### Scenario: Preventing illegal state with a guard
- **WHEN** a state transition would violate an invariant
- **THEN** the consumer can fail the transition explicitly using a guard helper (e.g., by throwing a domain error or `StateError`)

#### Scenario: Guard passes when invariant holds
- **WHEN** the invariant condition holds
- **THEN** the guard helper does not throw
