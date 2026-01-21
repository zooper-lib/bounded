# Change: Add core domain kernel

## Why
`bounded` is intended to be a small, framework-agnostic common kernel for Domain-Driven Design (DDD). Today, the repository has no published specs and the public Dart entrypoint is empty, so downstream packages (event sourcing, event publishing, orchestration layers) have nothing stable to build on.

This change defines the minimal, explicit domain modeling contracts and helpers needed to implement DDD-style architectures without coupling domain models to infrastructure.

## What Changes
- Add initial OpenSpec capabilities for foundational DDD building blocks:
  - Identity
  - Value Objects
  - Entities and Aggregates
  - Domain Events
- Define requirements for contracts, semantics (equality, immutability), and event collection on aggregates.
- Define a minimal public API surface intended to remain stable and small.

## Non-Goals
- Event sourcing, persistence, repositories
- Event dispatching / transport
- Framework integrations (Flutter, Riverpod, etc.)
- A prescribed architecture (CQRS/ES/microservices)

## Impact
- Affected specs: new capabilities under `openspec/specs/` after implementation/approval.
- Affected code: will introduce a first implementation in `lib/` and export surface via `lib/bounded.dart`.

## Assumptions
- Consumers want infrastructure-free primitives that are easy to unit test.
- Public APIs should prefer explicitness over “magic” code-gen.

## Open Questions
- Should `bounded` remain a Flutter package, or become a pure Dart package (remove the Flutter SDK dependency) so it can be used on server/CLI as well?
- Should identity types be strongly typed per aggregate (recommended), or generic string/int wrappers only?
- Do we want optional ergonomic helpers (e.g., `Result`, `Either`, `Guard`) in this package, or keep strictly to DDD primitives?
