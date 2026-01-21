# Capability: Value Objects

## ADDED Requirements

### Requirement: Structural equality
The system SHALL support value object modeling where equality is determined by the value object’s components rather than identity.

#### Scenario: Two value objects with same components
- **WHEN** a consumer creates two value objects with identical component values
- **THEN** they compare equal
- **AND** they produce the same hash code

### Requirement: Immutability by convention
The system SHALL provide guidance and/or base types that encourage value objects to be immutable.

#### Scenario: Modeling an immutable value object
- **WHEN** a consumer defines a value object
- **THEN** typical usage SHOULD encourage final fields and no setters

### Requirement: Explicit decomposition
The system SHALL allow a value object to declare which components participate in equality.

#### Scenario: Equality uses declared components
- **WHEN** a value object declares its equality components
- **THEN** equality and hashing are based only on those components
