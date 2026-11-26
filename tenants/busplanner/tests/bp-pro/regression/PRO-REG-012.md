---
id: PRO-REG-012
title: BP Pro (over RDP) - Route Change logging
module: bp-pro
flow: regression
ticket:
priority: P1
spec: [sheet:BP Pro!29-30]
channels: [desktop]
roles: []
env: qa1
data: [client-1221]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: none
---
## Preconditions
- Signed in to BP Pro (over RDP) on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`.

## Steps
1. In Student Manager, add student QA-AUTO-<initials>-P012-01. In Run Editor, create run QA-AUTO-<initials>-P012-RUN1 with stop QA-AUTO-<initials>-P012-STOP1. In Route Manager, create route QA-AUTO-<initials>-P012-ROUTE.
2. Assign QA-AUTO-<initials>-P012-01 to QA-AUTO-<initials>-P012-STOP1. In Run Editor, change the start time of QA-AUTO-<initials>-P012-RUN1. In Route Manager, add QA-AUTO-<initials>-P012-RUN1 to QA-AUTO-<initials>-P012-ROUTE.
3. Open the Route Change log and search by a date range that covers today only.
4. In the Route Change log, search by a date range that covers only yesterday.

## Expected (each line must be checkable)
- E1 (step 3, desktop): The log has an entry for the student assignment with the student, the stop, the user and the time. (ASSUMPTION)
- E2 (step 3, desktop): The log has an entry for the changed run time with the run, the old time and the new time. (ASSUMPTION)
- E3 (step 3, desktop): The log has an entry for the run added to the route with the run and the route. (ASSUMPTION)
- E4 (step 3, desktop): The search for today lists the three entries from step 2 and no entry dated outside the range.
- E5 (step 4, desktop): A search for yesterday lists none of the three step-2 entries.

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 29 to 30. Converted 2026-11-26.
- Row 29: last manual result pass on 13.3.0.195.
- Row 30: last manual result pass on 13.3.0.195; other results: 13.0.2.68: pass-confirm chkbox issue with ibrahim.
- Refined 2026-11-26: log columns (user, time, old and new values) are assumed. The case builds its own student, route and run. Row 30 on 13.0.2.68: pass, with a confirm-checkbox issue raised with a developer. Clean-up: delete the QA-AUTO records; log entries stay as audit data. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
