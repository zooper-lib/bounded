# Capability: Domain Events

## ADDED Requirements

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
