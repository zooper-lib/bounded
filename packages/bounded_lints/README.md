# bounded_lints

Analyzer lints for Domain-Driven Design (DDD) principles aligned with `bounded`.

These lints are intentionally opinionated and focused on common domain modeling mistakes:
- Mutability in value objects and domain events
- Recording events from outside aggregate transitions

## Install

Add the following to your project:

```yaml
dev_dependencies:
  custom_lint: ^0.8.1
  bounded_lints: <latest_version>
```

Enable the analyzer plugin in your `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint
```

Then run:

- `dart run custom_lint`

## Lints

- `bounded_value_object_immutable`: warns when a `ValueObject` has setters or non-final instance fields.
- `bounded_domain_event_immutable`: warns when a `DomainEvent`/`BoundedDomainEvent` has setters or non-final instance fields.
- `bounded_prefer_const_domain_events`: warns when a domain event could be `const` but isn’t.
- `bounded_record_event_outside_aggregate`: warns when `recordEvent(...)` is called outside aggregate instance methods.

## Ignoring

Use standard ignore mechanisms:

- File-wide: `// ignore_for_file: <lint-name>`
- Line: `// ignore: <lint-name>`
