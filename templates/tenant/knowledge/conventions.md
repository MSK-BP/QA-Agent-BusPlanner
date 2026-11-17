# Test conventions

> Status: empty. `/onboard-repo` adds a section per repo, derived from its existing tests.

## Defaults (any repo)

- Follow the repo's existing framework, folder layout and naming; do not introduce a new one.
- One behaviour per test; the name states the behaviour and the expected outcome.
- Locators: role and accessible name first, then label, then text; test ids only if the app has them.
- Test data the tests create is prefixed `QA-AUTO-` and cleaned up.
