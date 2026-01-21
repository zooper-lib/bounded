# Tasks: add-domain-event-traits

## 1. Specification
- [x] Add requirements to `domain-events` for optional event traits (id/timestamp/metadata) and a composed interface.

## 2. Implementation
- [x] Add `IdentifiedDomainEvent<TId>`, `TimestampedDomainEvent`, `MetadataDomainEvent`, and `BoundedDomainEvent<TId>` to `lib/src/domain_event.dart`.
- [x] Ensure all new types are exported via `package:bounded/bounded.dart` (should be automatic since it exports `src/domain_event.dart`).

## 3. Tests
- [x] Add a new test file that validates the new interfaces compose correctly and are implementable.

## 4. Docs
- [x] Update README event examples to show `BoundedDomainEvent<TId>` usage.

## 5. Validation
- [x] Run unit tests.
