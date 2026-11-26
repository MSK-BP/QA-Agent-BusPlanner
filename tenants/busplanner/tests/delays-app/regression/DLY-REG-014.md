---
id: DLY-REG-014
title: Delays - No real parent emails on the QA test client
module: delays-app
flow: regression
ticket:
priority: P1
spec: [sheet:Delays!68]
channels: [sql]
roles: []
env: qa1
data: [qa1-delays-quick-code]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: none
---
## Preconditions
- The QA1 Delays test client is the only client queried.
- Read access to the QA1 database is available (needs: read access to the QA1 database; harness/sql.ps1 covers only Unified dev and staging).
- <approved test domain/list> is named by the team before the run (ASSUMPTION).

## Steps
1. Run the query below on the QA1 database, read-only: `SELECT COUNT(*) AS non_test_emails FROM <contact table> WHERE <client column> = <QA test client> AND <email column> IS NOT NULL AND <email column> NOT LIKE '%@<approved test domain>'` (table and column names are placeholders, ASSUMPTION).

## Expected (each line must be checkable)
- E1 (step 1, sql): The query returns 0 contact emails outside <approved test domain/list> for the QA test client (needs: read access to the QA1 database; harness/sql.ps1 covers only Unified dev and staging) (ASSUMPTION).

## Clean-up
- None. The case only reads.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, row 68. Moved 2026-11-26 from DLY-REG-009 step 2.
- Priority set by the conversion (the sheet has none): P1, because a failure means real parents can get test alerts.
- Why: Delays test mode may not stop emails, so real parents could get them. DLY-REG-005 and DLY-REG-010 depend on this case and need it passed on the day they run.
- Table and column names are not known from the sheet or Apps.md; fill them in before approval (ASSUMPTION).
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
