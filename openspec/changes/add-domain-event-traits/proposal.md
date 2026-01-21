# Change: Add domain event traits

## Why
Consumers frequently need to attach *cross-cutting* information to domain events (a stable identifier, an occurrence timestamp, and optional metadata). Today, each package re-implements these small contracts.

Adding a small set of optional interfaces keeps event handling code consistent across the ecosystem while keeping `bounded` infrastructure-free.

## What Changes
- Add optional domain-event traits:
  - `IdentifiedDomainEvent<TId>`
  - `TimestampedDomainEvent`
  - `MetadataDomainEvent`
- Add a convenience combined interface `BoundedDomainEvent<TId>` that composes the above traits.

## Impact
- Affected specs: `domain-events`
- Affected code: `lib/src/domain_event.dart`, tests under `test/`
- Compatibility: additive only (no breaking API changes)
