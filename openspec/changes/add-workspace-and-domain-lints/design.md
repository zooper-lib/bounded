## Context
This repository currently ships a single Dart package (`bounded`). Adding ecosystem packages (such as static analysis rules) is easiest when the repo is a workspace with per-package boundaries.

The requested linter capability is best delivered via Dart Analyzer-compatible tooling so violations appear directly in IDEs/CI.

## Goals
- Introduce a `packages/` workspace layout managed by Melos.
- Keep the `bounded` runtime package small and infrastructure-free.
- Deliver a published lints package that warns about violations of domain design principles aligned with `bounded` concepts.

## Non-Goals
- Building a full DDD framework or enforcing a specific architecture.
- Adding runtime checks or reflection.
- Providing auto-fixes.

## Decisions
### Decision: Use `custom_lint` plugin architecture
`bounded_lints` will be implemented as a `custom_lint` plugin so:
- Lints run in editors and CI (`dart run custom_lint`).
- Rules can be authored with the analyzer AST and type system.

### Decision: Workspace structure
The workspace will place all packages under `packages/`:
- `packages/bounded/` (existing package, moved)
- `packages/bounded_lints/` (new published lints plugin)

Melos will manage bootstrap and scripts for consistent dev workflow.

### Decision: Rule semantics (initial set)
Initial rules focus on high-signal, low-surprise DDD guidance:
- Value object immutability
- Domain event immutability (+ prefer `const`)
- Discourage recording events outside aggregate root instance methods

Rules will be warnings by default.

## Risks / Trade-offs
- AST/type analysis can introduce false positives if rules are too broad.
  - Mitigation: scope checks to `bounded`-related types/markers, and provide configuration/exclusions.
- Repository restructuring is disruptive for contributors.
  - Mitigation: keep package names and public APIs stable; document new workflow.

## Migration Plan
- Move existing package content into `packages/bounded/` and update tooling paths.
- Add Melos workspace configuration and bootstrap scripts.
- Add `bounded_lints` package and validate it on a small example package in the workspace.

## Open Questions
- Minimum supported Dart SDK for consumers of `bounded_lints` (align with `bounded` unless constraints require otherwise).
- Whether to add a small `packages/example/` package for documentation and lint verification, or rely purely on tests.
