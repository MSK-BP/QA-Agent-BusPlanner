---
name: onboard-repo
description: Learn a product repository and write its map into <tenant>/knowledge/repos/. Use when the user points at a repo the QA agent has not seen, or says a repo map is stale.
argument-hint: <path-to-repo>
---

Build the QA map for the repo at `$ARGUMENTS`.

1. Confirm the path exists and record the current commit hash.
2. Read the top-level docs, build files, CI pipeline files and the test folders yourself, to learn the stack and how tests run.
3. Fan out `code-mapper` sub-agents in parallel, one per major module or service, each asked for: responsibility, entry points, business rules found, tests covering it, untested branches.
4. Write `<tenant>/knowledge/repos/<repo-name>.md` with the eight sections listed in `<tenant>/knowledge/repos/README.md`.
5. Update the shared files with what this repo taught you:
   - `<tenant>/knowledge/architecture.md`: systems table, data stores, integrations, CI
   - `<tenant>/knowledge/test-strategy.md`: suites table with exact commands, coverage gaps
   - `<tenant>/knowledge/conventions.md`: a per-repo section derived from existing tests
   - `<tenant>/knowledge/INDEX.md`: status column
6. Try the cheapest test command once to prove the documented command works. Record the result, or why you could not run it.

Finish with: what you now know, what stayed unknown, and the three highest-risk untested areas.

Only write facts you read in the repo. Mark anything inferred as UNVERIFIED.
