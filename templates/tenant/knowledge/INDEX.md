# Knowledge index

Last built: TODO. Anything marked UNVERIFIED, TODO or NOT FOUND in a file is not knowledge.

| File | Covers | Status |
|---|---|---|
| domain.md | Products, users, glossary, business rules, bug themes | empty |
| process.md | Ticket projects, QA workflow, release train, people, channels | empty |
| architecture.md | Systems, request flow, data, integrations, CI/CD | empty |
| environments.md | Environment URLs, what is allowed, hard rules, browser | empty |
| test-strategy.md | Suites and commands, gates, gaps, flaky list | empty |
| conventions.md | House style for tests | empty |
| repos/ | One map per product repo (`/onboard-repo`) | none yet |

## What to read for which task

- **Test plan:** domain.md, then the repo map for the feature's area; test-strategy.md for gaps.
- **Writing tests:** conventions.md, then the repo map.
- **Running or triaging:** environments.md (hard rules first), test-strategy.md (commands, flaky list).
- **Bug report:** domain.md for expected behaviour, process.md for the workflow and ticket conventions.
- **PR review:** the repo map for the changed area; test-strategy.md for what CI gates.
- **Release sign-off:** process.md (release train), test-strategy.md.

## Known holes

- TODO
