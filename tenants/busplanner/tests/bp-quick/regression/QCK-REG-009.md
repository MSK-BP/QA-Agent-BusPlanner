---
id: QCK-REG-009
title: BP Quick - Route Change logging
module: bp-quick
flow: regression
ticket:
priority: P1
spec: [sheet:BP Quick!22-22]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1221]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Quick on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`.

## Steps
1. In Add a new student, create student QA-AUTO-<initials>-Q009-01. In Run Console, create run QA-AUTO-<initials>-Q009-RUN1 with stop QA-AUTO-<initials>-Q009-STOP1. In Route Console, create route QA-AUTO-<initials>-Q009-ROUTE.
2. Assign QA-AUTO-<initials>-Q009-01 to QA-AUTO-<initials>-Q009-STOP1. Change the start time of QA-AUTO-<initials>-Q009-RUN1. Add QA-AUTO-<initials>-Q009-RUN1 to QA-AUTO-<initials>-Q009-ROUTE.
3. Open the route change log.
4. In the route change log, search by today's date, then by yesterday's date.

## Expected (each line must be checkable)
- E1 (step 3, ui): The log has an entry for the student assigned to the stop, with the student, the stop, the user and the time. (ASSUMPTION)
- E2 (step 3, ui): The log has an entry for the changed run time, with the run, the old time and the new time. (ASSUMPTION)
- E3 (step 3, ui): The log has an entry for the run added to the route, with the run and the route. (ASSUMPTION)
- E4 (step 4, ui): A search by today's date lists the three step-2 entries, and a search by yesterday's date lists none of them. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 22 to 22. Converted 2026-11-26.
- Row 22: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: the sheet group 'Tracking and search' implies a search; the date-search line is an ASSUMPTION. The case builds its own student, run and route. Clean-up: delete the QA-AUTO records. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
