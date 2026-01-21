# Tasks: Add core domain kernel

## 1. Specs
- [x] 1.1 Add/validate capability delta specs under `openspec/changes/add-core-domain-kernel/specs/*/spec.md`
- [x] 1.2 Run `openspec validate add-core-domain-kernel --strict --no-interactive`

## 2. Public API (Dart)
- [x] 2.1 Decide package target (Flutter vs pure Dart) and update `pubspec.yaml` accordingly
- [x] 2.2 Implement identity primitives per spec (typed IDs, equality, display/debug)
- [x] 2.3 Implement value object base/mixin per spec (immutability + structural equality)
- [x] 2.4 Implement entity + aggregate root primitives per spec (identity-based equality)
- [x] 2.5 Implement domain event contract and aggregate event collection per spec
- [x] 2.6 Export stable API from `lib/bounded.dart`

## 3. Documentation
- [x] 3.1 Replace placeholder `README.md` with package purpose and minimal usage examples
- [x] 3.2 Update `CHANGELOG.md` initial release notes

## 4. Tests
- [x] 4.1 Add unit tests for equality semantics (value objects vs entities)
- [x] 4.2 Add unit tests for aggregate domain event collection behavior
- [x] 4.3 Ensure `dart test` / `flutter test` passes (depending on package target)
