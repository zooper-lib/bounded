# bounded

## Purpose

**bounded** is a core Domain-Driven Design (DDD) package that provides the foundational building blocks for modeling domains in a clear, explicit, and framework-agnostic way.

It defines the *contracts, abstractions, and helpers* that domain models, event sourcing systems, and event publishing mechanisms build upon.

`bounded` is intentionally small, opinionated about boundaries, and agnostic about infrastructure.

---

## What this project is

`bounded` provides:

- Core domain modeling abstractions
- Explicit boundaries for domain logic
- Shared contracts used by higher-level DDD tooling
- Helpers that reduce boilerplate without hiding intent

It acts as the **common kernel** for the ecosystem, allowing other packages
to integrate without coupling domain models to technical concerns.

---

## What this project is NOT

`bounded` does **not**:

- Implement event sourcing
- Dispatch or transport events
- Provide persistence or repositories
- Depend on frameworks or runtimes
- Contain business logic
- Enforce a specific architecture (CQRS, ES, microservices, etc.)

Those concerns belong in separate, opt-in packages.

---

## Core concepts

`bounded` focuses on modeling fundamentals such as:

- Aggregates and Aggregate Roots
- Entities and identity
- Value Objects
- Domain Events (definition, not dispatch)
- Domain invariants and rules
- Explicit boundaries between domain, application, and infrastructure

All concepts are designed to be:

- Explicit
- Testable
- Composable
- Infrastructure-free

---

## Position in the ecosystem

`bounded` is designed to be used as a dependency by other libraries, such as:

- **Event sourcing systems** (e.g. `continuum`)
- **Domain event publishing systems** (e.g. `raiser`)
- Application-level orchestration layers
- Testing and simulation tooling

Higher-level packages depend on `bounded`;  
`bounded` depends on nothing domain-external.

---

## Design principles

- **Domain first**  
  The domain model is the primary artifact.

- **Explicit boundaries**  
  Illegal states should be unrepresentable.

- **No hidden magic**  
  Behavior is visible and intentional.

- **Opt-in complexity**  
  Advanced patterns are layered on top, not forced.

- **Long-term maintainability**  
  Favor clarity over convenience.

---

## Intended audience

`bounded` is intended for developers who:

- Practice Domain-Driven Design seriously
- Want to keep domain models pure
- Prefer explicit abstractions over frameworks
- Build systems that evolve over time

---

## Status

This project is under active development.

Public APIs aim to be small, stable, and intentional.
Breaking changes are expected early and documented clearly.

---

## License

See `LICENSE` for details.
