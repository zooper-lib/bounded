# Change: Add Melos workspace and domain lints package

## Why
This repository currently contains a single package (`bounded`). As the ecosystem grows (tooling, analysis, and integrations), the repo needs a workspace layout that supports multiple related packages without diluting the core.

In addition, consumers need fast feedback when their domain model violates key DDD design principles (immutability, explicit boundaries, and event recording discipline).

## What Changes
- Convert the repository into a Melos-managed workspace with a `packages/` directory.
- Move the existing `bounded` package into `packages/bounded/`.
- Add a new published package `bounded_lints` that provides custom lints to warn about common domain design principle violations.

## Impact
- Affected specs:
  - New capability: `workspace` (tooling + repository layout)
  - New capability: `domain-lints` (static analysis rules)
  - Existing runtime capabilities remain unchanged: `identity`, `value-objects`, `entities-aggregates`, `domain-events`
- Affected code:
  - Repository structure changes (source + tests move under `packages/bounded/`)
  - New package added under `packages/bounded_lints/`
- **BREAKING (repository structure)**: paths for contributors and tooling change, but the published package name `bounded` and its public API remain the same.

## Non-Goals
- Auto-fix support (quick fixes) for lint violations.
- Enforcing a specific architecture (CQRS, ES, hexagonal, etc.).
- Runtime enforcement; lints are advisory warnings.

## Notes
- The lints are intended to be opt-in and consumer-facing (installed as a dev dependency).
- Default severity is warnings; projects may elevate to errors if desired.
