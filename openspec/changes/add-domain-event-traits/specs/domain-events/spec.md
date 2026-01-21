# domain-events Specification (Delta)

## ADDED Requirements

### Requirement: Optional domain event traits
The system SHALL provide optional domain event interfaces for common cross-cutting concerns:
- stable identification
- occurrence timestamp
- arbitrary metadata

These traits MUST be infrastructure-free and SHOULD be usable independently or in combination.

#### Scenario: Defining an identified domain event
- **WHEN** a consumer defines a domain event that needs correlation across logs, buses, or storage
- **THEN** it can implement an interface that exposes a stable `id` property

#### Scenario: Defining a timestamped domain event
- **WHEN** a consumer defines a domain event that needs ordering or auditing
- **THEN** it can implement an interface that exposes an `occurredOn` property

#### Scenario: Defining a metadata-carrying domain event
- **WHEN** a consumer defines a domain event that needs non-domain metadata (e.g., correlation IDs)
- **THEN** it can implement an interface that exposes a `metadata` map

### Requirement: Composed domain event contract
The system SHALL provide a convenience interface that combines the optional traits into a single contract.

#### Scenario: Using a combined interface
- **GIVEN** a consumer prefers a single, consistent contract for events
- **WHEN** it defines an event
- **THEN** it can implement a composed interface that includes identification, timestamping, and metadata
