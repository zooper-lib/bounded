# domain-lints (Delta) Specification

## ADDED Requirements

### Requirement: Published custom lints package
The system SHALL provide a published package named `bounded_lints` that surfaces domain design principle violations as analyzer warnings.

#### Scenario: Consumer installs bounded_lints
- **WHEN** a consumer adds `bounded_lints` and `custom_lint` as dev dependencies
- **AND** they enable custom_lint in their analysis workflow
- **THEN** domain principle violations are reported as warnings in IDEs and CI

### Requirement: Value object immutability lint
The system SHALL warn when a class that mixes in `ValueObject` appears to be mutable.

#### Scenario: Value object declares a mutable field
- **GIVEN** a class mixes in `ValueObject`
- **WHEN** it declares a non-final instance field or a setter
- **THEN** the analyzer reports a warning identifying the mutable member

### Requirement: Domain event immutability lint
The system SHALL warn when a class implementing `DomainEvent` or `BoundedDomainEvent` appears to be mutable.

#### Scenario: Domain event declares a setter
- **GIVEN** a class implements `DomainEvent` (directly or via `BoundedDomainEvent`)
- **WHEN** it declares a setter or a non-final instance field
- **THEN** the analyzer reports a warning identifying the mutable member

### Requirement: Prefer const domain events
The system SHALL warn when a domain event type could reasonably be `const` but is not.

#### Scenario: Domain event has only final fields but no const ctor
- **GIVEN** a domain event type with only final instance fields
- **WHEN** it has a non-const generative constructor
- **THEN** the analyzer reports a warning recommending a `const` constructor

### Requirement: Discourage recording events outside aggregate transitions
The system SHALL warn when `recordEvent(...)` is invoked from outside an aggregate root’s own instance methods.

#### Scenario: External service records an event on an aggregate
- **GIVEN** application-layer code calls `someAggregate.recordEvent(...)`
- **WHEN** the call occurs outside the declaring aggregate root type’s instance methods
- **THEN** the analyzer reports a warning recommending recording the event inside the aggregate transition

### Requirement: Configuration and opt-out
The system SHALL allow consumers to disable individual rules and/or exclude files or paths from lint reporting.

#### Scenario: Consumer disables a rule
- **WHEN** a consumer disables a specific `bounded_lints` rule in configuration
- **THEN** that rule no longer reports warnings in the consumer project
