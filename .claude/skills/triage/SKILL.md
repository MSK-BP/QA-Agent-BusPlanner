---
name: triage
description: Diagnose failing or flaky tests from a CI run, a local run, a report file or pasted output. Use when a pipeline is red, a test is intermittent, or the user asks why something failed.
argument-hint: <CI run URL, report path, or test name>
---

Triage `$ARGUMENTS`.

1. Get the evidence: the report or log files, the pipeline output, or the pasted text. If only a test name was given, run it to get a real failure.
2. Split the failures into groups that look related and give each group to a `failure-triager` sub-agent in parallel.
3. Merge their findings into one table: test, class, root cause, evidence, confidence, next action.
4. For a suspected flaky test, rerun it several times in isolation and report the pass rate before calling it flaky.
5. Update the flaky table in `<tenant>/knowledge/test-strategy.md` for anything newly confirmed.
6. Save to `<tenant>/reports/YYYY-MM-DD-triage-<topic>.md`.

Then offer the follow-ups, without doing them unasked: `/bug-report` for each product bug, a fix for each test bug.
