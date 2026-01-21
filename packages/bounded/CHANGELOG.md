# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Strongly-typed identity primitives (`Identity` interface, `TypedIdentity` class)
- Value object support with structural equality (`ValueObject` mixin)
- Entity mixin with identity-based equality
- Aggregate root mixin with domain event collection
- Domain event interface (`DomainEvent`)
- Event collection methods on aggregates (record, retrieve, clear)
- Pure Dart package with no infrastructure dependencies
