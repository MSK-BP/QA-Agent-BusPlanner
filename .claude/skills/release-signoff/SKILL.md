---
name: release-signoff
description: Assemble the evidence for a release go/no-go - scope, test results, open defects, risks - and give a recommendation. Use before a release or when the user asks whether a version is ready to ship.
argument-hint: <release or fix version>
---

Prepare the QA sign-off for `$ARGUMENTS`.

1. Scope: from Jira, list the issues in the release and their status.
2. Per issue: is there a test plan, were its cases run, on which build, with what result. Mark "no evidence" where there is none.
3. Regression: latest result of each suite named in the release gate in `<tenant>/knowledge/test-strategy.md`, with the build it ran on. Run `/run-suite` for any that are missing or older than the release build, after confirming with the user.
4. Defects: open bugs against the release by severity, and known issues being shipped.
5. Risks: untested areas, skipped or quarantined tests, environment differences from production.
6. Save `<tenant>/reports/YYYY-MM-DD-signoff-<version>.md` and reply with:
   - recommendation: go, go with conditions, or no-go
   - the blocking items, if any
   - evidence table
   - risks accepted and who needs to accept them

The recommendation is advice. The release decision belongs to the people named in the release gate. Never mark anything released or transition issues yourself.
