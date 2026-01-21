## Context
`bounded` is the common kernel for a DDD ecosystem. It should be small, explicit, and free of infrastructure concerns. The goal is to define a stable set of primitives used by higher-level packages.

## Goals
- Provide minimal building blocks for modeling domains: identities, value objects, entities/aggregates, domain events.
- Make common semantics explicit: equality, immutability expectations, event collection.
- Keep public APIs small, easy to test, and framework-agnostic.

## Non-Goals
- Implement event sourcing, persistence, repositories, dispatchers, or transports.
- Provide code generation or reflection-based “magic”.

## Decisions
### Decision: Strongly typed identities
Prefer identities tied to a domain type (e.g., per-aggregate) to reduce accidental mixing across bounded contexts. The concrete representation (String/UUID/int) stays an implementation detail.

### Decision: Equality semantics by concept
- Value objects: structural equality based on their components.
- Entities/Aggregates: identity-based equality.

### Decision: Aggregate event collection (not dispatch)
Aggregates record domain events as part of state transitions, but `bounded` does not dispatch them. This keeps the domain pure and allows event sourcing/publishers to integrate later.

## Alternatives considered
- Provide only interfaces (no helpers): rejected because ergonomic helpers reduce boilerplate without adding infrastructure coupling.
- Provide an `Either/Result` and `Guard` library now: deferred; keep scope minimal until core primitives stabilize.

## Risks / Trade-offs
- Too many helpers could bloat the kernel → mitigate by keeping a strict “minimal primitives” scope.
- Strong typing may add generics verbosity → mitigate with ergonomic constructors/typedefs (non-normative).

## Migration plan
None (initial capability set).

## Open questions
- Flutter vs pure Dart package target.
- Whether to include optional guard/result utilities in a follow-up change.
