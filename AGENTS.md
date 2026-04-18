# AGENTS.md – FormBuildable

## Overview
`form_buildable` is a Rails gem (Ruby 3.4.7) that provides a DSL for declaratively building `FormBuilder` subclasses with CSS class management. The gem wraps Rails' native `ActionView::Helpers::FormBuilder` and integrates via `Railtie`.

## Quick Commands
```bash
# Run all tests (requires test/dummy db setup; CI runs setup automatically)
bin/test

# Console for manual testing
bin/console

# Lint
rubocop
```

## Architecture & Entrypoints

**Gem structure:**
- `lib/form_buildable/base.rb` – Core `Base` class extending `ActionView::Helpers::FormBuilder`
- `lib/form_buildable/factory.rb` – DSL for defining form builders via `define_form_builder`
- `lib/form_buildable/options/` – Configuration helpers (HTML class management)
- `lib/form_buildable/railtie.rb` – Rails integration

**Test structure:**
- `test/form_buildable_test.rb` – Basic smoke tests
- `test/form_buildable/` – Feature-specific tests (e.g., `basic_field_test.rb`)
- `test/dummy/` – Minimal Rails app (models, views, config) used for integration testing
- Test database: SQLite (via `test/dummy/db`)
- Guard watches `test/**/*_test.rb` and reruns matching test when `lib/**/*.rb` changes

## Test Quirks
- Tests require `test/dummy` Rails environment initialized and database migrated
- CI explicitly runs `cd test/dummy && bin/rails db:drop db:create db:migrate`
- Use `bundle exec guard` for watch mode (not `guard` alone)
- Minitest is the test runner; fixtures are auto-loaded from `test/fixtures/`

## Code Style & Conventions
- **Ruby:** 3.4.7 (see `.ruby-version`)
- **Frozen strings:** Required by `rubocop` (see `.rubocop.yml`); add `# frozen_string_literal: true` to all new files
- **Linting:** Custom RuboCop config with minimal rules enabled (disabled by default, must explicitly opt-in). Most rules are in `Layout`, `Naming`, `Security`, `Style`, and `Rails` categories.
- **Method parameters:** Minimum name length is 2 chars; snake_case required for variables
- **DSL pattern:** `define_form_builder :name do ... end` registers form builders via factory

## Git & Development
- No special merge strategy; standard Rails gem conventions
- Always run `bin/test` and `rubocop` before pushing (CI enforces both)
- Database state in `test/dummy` can be reset via `cd test/dummy && bin/rails db:drop db:create db:migrate`
