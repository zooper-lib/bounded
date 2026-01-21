# Change: Add `pullEvents` and invariant guards

## Why
Working with aggregate domain events often requires a “read then clear” sequence that is easy to forget or implement inconsistently.
Likewise, invariant enforcement is encouraged by the library but currently requires ad-hoc `if`/`throw` code everywhere.

## What Changes
- Add an aggregate helper to atomically drain recorded domain events (`AggregateRoot.pullEvents()`).
- Add small, infrastructure-free guard helpers to make invariant enforcement explicit and consistent.

## Impact
- Affected specs: `domain-events`, `entities-aggregates`
- Affected code: `lib/src/aggregate_root.dart`, new guard helper module exported from `lib/bounded.dart`

## Non-Goals
- No event dispatching/publishing/transport.
- No persistence or repository abstractions.
- No framework dependencies.
