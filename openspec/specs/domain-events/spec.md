# domain-events Specification

## Purpose
TBD - created by archiving change add-pull-events-and-guards. Update Purpose after archive.
## Requirements
### Requirement: Drain recorded events
The system SHALL provide an aggregate-level helper that returns all currently recorded domain events and clears them in a single operation.

#### Scenario: Application drains events after handling
- **GIVEN** an aggregate has recorded one or more domain events
- **WHEN** application code drains the pending events
- **THEN** it receives the events in the order they were recorded
- **AND** the aggregate’s pending event collection is cleared

### Requirement: No dispatching remains
The system SHALL NOT dispatch, publish, or transport events.

#### Scenario: Integrating with a dispatcher using drained events
- **WHEN** a consumer needs to publish drained events
- **THEN** they integrate with an external package or application layer code

### Requirement: Domain event contract
The system SHALL provide a domain event abstraction representing something that happened in the domain.

#### Scenario: Defining a domain event
- **WHEN** a consumer defines a domain event
- **THEN** it can be stored, tested, and compared in a deterministic way

### Requirement: Aggregate records events
The system SHALL allow aggregate roots to record domain events as part of successful state transitions.

#### Scenario: Recording an event during a transition
- **WHEN** an aggregate transition succeeds
- **THEN** the aggregate records a domain event in an internal collection

#### Scenario: Reading and clearing events
- **WHEN** application code reads an aggregate’s pending events
- **THEN** it receives a read-only view of the events
- **AND** it can clear the recorded events explicitly

### Requirement: No dispatching
The system SHALL NOT dispatch, publish, or transport events.

#### Scenario: Integrating with a dispatcher
- **WHEN** a consumer needs to publish events
- **THEN** they integrate with an external package or application layer code

