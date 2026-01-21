# workspace (Delta) Specification

## ADDED Requirements

### Requirement: Melos workspace layout
The system SHALL organize this repository as a Melos-managed workspace with all packages located under a `packages/` directory.

#### Scenario: Adding a new ecosystem package
- **GIVEN** the repository is a Melos-managed workspace
- **WHEN** a maintainer adds a new related package
- **THEN** it is created under `packages/<package-name>/`
- **AND** Melos discovers it via the workspace configuration

### Requirement: `bounded` package remains publishable
The system SHALL keep `bounded` as a publishable package with the same public API and package name, even if its source is moved under `packages/bounded/`.

#### Scenario: Consumer depends on bounded
- **WHEN** a consumer adds `bounded` as a dependency
- **THEN** they import `package:bounded/bounded.dart`
- **AND** the public API behaves consistently with the existing specs

### Requirement: Workspace bootstrap commands
The system SHALL provide a consistent bootstrap and test workflow via Melos.

#### Scenario: Developer sets up the repo
- **WHEN** a developer runs the workspace bootstrap command
- **THEN** all workspace packages have their dependencies resolved
- **AND** tests can be run for all packages with a single command
