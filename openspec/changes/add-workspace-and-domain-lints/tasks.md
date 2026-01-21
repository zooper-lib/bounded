## 1. Workspace conversion (Melos + packages/)
- [x] 1.1 Add Melos configuration (`melos.yaml`) defining packages under `packages/**` and standard scripts.
- [x] 1.2 Create a non-published workspace root `pubspec.yaml` (or adjust existing) to support workspace tooling.
- [x] 1.3 Move the existing `bounded` package into `packages/bounded/`.
- [x] 1.4 Update README and contributor workflow docs for the new workspace layout.
- [x] 1.5 Ensure `dart test` still passes for the `bounded` package (via Melos scripts).

## 2. Add `bounded_lints` package (published)
- [x] 2.1 Create `packages/bounded_lints/` as a `custom_lint` plugin package.
- [x] 2.2 Implement initial lint rules:
  - Value objects SHOULD be immutable (no setters / no non-final fields) when mixing `ValueObject`.
  - Domain events SHOULD be immutable (no setters / no non-final fields) when implementing `DomainEvent`/`BoundedDomainEvent`.
  - Domain events SHOULD prefer `const` constructors when possible.
  - Code SHOULD NOT call `recordEvent(...)` from outside aggregate root instance methods (discourage external/event-service recording).
- [x] 2.3 Add configuration surface (enable/disable rules; allow excludes) consistent with `custom_lint` conventions.
- [x] 2.4 Add lint tests using the recommended `custom_lint_builder` testing approach.
- [x] 2.5 Add end-user documentation for installation and usage (README snippet + example `analysis_options.yaml`).

## 3. Validation
- [x] 3.1 Run `melos bootstrap` to resolve workspace dependencies.
- [x] 3.2 Run `melos run test` (or equivalent) to validate behavior.
- [x] 3.3 Run `dart run custom_lint` against a small example package to verify warnings appear as intended.
