---
name: write-tests
description: Implement automated tests for a feature, ticket or test plan in the product repo that owns it. Use when the user asks to automate cases, add coverage, or write a regression test for a bug.
argument-hint: <test plan file, JIRA-KEY, or feature> [repo]
---

Automate tests for `$ARGUMENTS`.

1. Find the cases: a plan in `<tenant>/reports/`, else run the `/test-plan` steps first and confirm the cases with the user.
2. Identify the owning repo from `<tenant>/knowledge/repos/`. If it has no map, run `/onboard-repo` on it first.
3. Create a branch in that repo named `qa/<key>-<short-topic>`. Never commit to the default branch.
4. Hand the cases, conventions and repo map to `test-automator`. For independent areas, run one automator per area in parallel, each on files the others do not touch.
5. Give the resulting diff and the requirement, without the automator's explanation, to `test-reviewer`. Fix what it finds and re-run.
6. Report: cases automated, cases not automated and why, the command to run them, results, and any product bug found on the way.

Stop and ask before pushing the branch or opening a PR.
