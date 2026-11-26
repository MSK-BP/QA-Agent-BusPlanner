---
id: QCK-REG-006
title: BP Quick - Route Console
module: bp-quick
flow: regression
ticket:
priority: P2
spec: [sheet:BP Quick!15-16]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1221, client-1221-depot]
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
1. In Run Console, create runs QA-AUTO-<initials>-Q006-RUN1, QA-AUTO-<initials>-Q006-RUN2 and QA-AUTO-<initials>-Q006-RUN3 with one stop each and start times 07:00, 07:30 and 08:00. In Route Console, create route QA-AUTO-<initials>-Q006-ROUTE.
2. In Route Console, add the runs to QA-AUTO-<initials>-Q006-ROUTE in the order QA-AUTO-<initials>-Q006-RUN1, QA-AUTO-<initials>-Q006-RUN3, QA-AUTO-<initials>-Q006-RUN2.
3. In Route Console, add the depot named in data entry client-1221-depot between QA-AUTO-<initials>-Q006-RUN2 and QA-AUTO-<initials>-Q006-RUN3 (needs: name of an existing client 1221 depot).

## Expected (each line must be checkable)
- E1 (step 2, ui): The console lists the runs in time order QA-AUTO-<initials>-Q006-RUN1 (07:00), QA-AUTO-<initials>-Q006-RUN2 (07:30), QA-AUTO-<initials>-Q006-RUN3 (08:00), whatever order they were added. (ASSUMPTION)
- E2 (step 3, ui): The depot shows in the route list between QA-AUTO-<initials>-Q006-RUN2 and QA-AUTO-<initials>-Q006-RUN3. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 15 to 16. Converted 2026-11-26.
- Row 15: last manual result pass on 13.1.12.153.
- Row 16: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: 'correct position by time' is taken as ascending start time (ASSUMPTION). Clean-up: delete the QA-AUTO route and runs. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
