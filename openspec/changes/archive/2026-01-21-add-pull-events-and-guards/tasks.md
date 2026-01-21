## 1. Implementation
- [x] Add `pullEvents()` (drain + clear) to `AggregateRoot`.
- [x] Add guard helpers for invariant enforcement (throwing).
- [x] Export guard helpers from `bounded.dart`.

## 2. Tests
- [x] Add unit tests covering `pullEvents()` drains in order and clears.
- [x] Add unit tests for guard helpers (throws when violated, no-op when satisfied).

## 3. Documentation
- [x] Update README with short examples for `pullEvents()` and guards.

## 4. Quality
- [x] Run `dart test`.
