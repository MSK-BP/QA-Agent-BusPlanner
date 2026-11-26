---
id: PRO-REG-007
title: BP Pro (over RDP) - Reports
module: bp-pro
flow: regression
ticket:
priority: P1
spec: [sheet:BP Pro!22-24]
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
1. In Student Manager, add student QA-AUTO-<initials>-P007-01 with one address. Save.
2. In Run Editor, create runs QA-AUTO-<initials>-P007-RUN1 (stops QA-AUTO-<initials>-P007-STOP1, QA-AUTO-<initials>-P007-STOP2, QA-AUTO-<initials>-P007-STOP3) and QA-AUTO-<initials>-P007-RUN2 (stop QA-AUTO-<initials>-P007-STOP4). Assign QA-AUTO-<initials>-P007-01 to QA-AUTO-<initials>-P007-STOP2. Click Calculate on both runs.
3. In Route Manager, create route QA-AUTO-<initials>-P007-ROUTE and add QA-AUTO-<initials>-P007-RUN1 and QA-AUTO-<initials>-P007-RUN2 to it.
4. In Reports, run Route Summary for QA-AUTO-<initials>-P007-ROUTE.
5. In Reports, run Route Details for QA-AUTO-<initials>-P007-RUN1.
6. In Reports, run Route Directions with stops for QA-AUTO-<initials>-P007-RUN1.

## Expected (each line must be checkable)
- E1 (step 4, desktop): The report lists both runs of the route, and each run lists its stops with name, time and order matching Run Editor. (ASSUMPTION)
- E2 (step 5, desktop): QA-AUTO-<initials>-P007-01 shows under QA-AUTO-<initials>-P007-STOP2, and no other stop lists the student.
- E3 (step 6, desktop): The report lists every stop of the run in order, and each direction step follows the calculated path drawn in Run Editor. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 22 to 24. Converted 2026-11-26.
- Row 22: last manual result pass on 13.3.0.195.
- Row 23: last manual result pass on 13.3.0.195.
- Row 24: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: the case builds its own student, runs and route, so depends-on stays empty. Clean-up: delete the QA-AUTO route, runs, stops and student. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
