---
name: run-suite
description: Run a test suite (smoke, regression, API, UI or a named suite) against an allowed environment and summarise the result. Use when the user asks to run tests or check whether a build is healthy.
argument-hint: <suite> [environment]
---

Run `$ARGUMENTS`.

1. Look the suite up in `<tenant>/knowledge/test-strategy.md` for its repo and exact command. If it is not listed, find it in the repo, confirm with the user, then add it to the table.
2. Check the environment against `<tenant>/knowledge/environments.md`. Default to the lowest allowed one. Refuse production.
3. Record the commit or build under test.
4. Run the command. Use the background for anything likely to exceed two minutes. Keep the raw output and reports under `runs/<date>-<suite>/` in the tenant's run folder (`RunRoot` from `harness/tenant.ps1`; default `<tenant>/reports/`).
5. If anything failed, pass the failures to `failure-triager`.
6. Save `<tenant>/reports/YYYY-MM-DD-run-<suite>.md` and reply with:
   - verdict: green, red, or could not run
   - totals: passed, failed, skipped, duration
   - failures grouped by root cause and class
   - new failures versus known flaky ones

Report exactly what ran. A suite that did not start is "could not run", not "no failures".
