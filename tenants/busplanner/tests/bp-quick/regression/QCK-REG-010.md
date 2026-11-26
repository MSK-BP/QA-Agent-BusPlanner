---
id: QCK-REG-010
title: BP Quick - GPS Vehicle Assignment
module: bp-quick
flow: regression
ticket:
priority: P2
spec: [sheet:BP Quick!23-23]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1221, client-1221-gps-vehicle]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Quick on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-Q010-`.

## Steps
1. Open GPS Vehicle Assignment and open the vehicle list for client 1221.
2. Create run QA-AUTO-<initials>-Q010-RUN1 in Run Console. Assign the vehicle named in data entry client-1221-gps-vehicle (needs: a spare client 1221 vehicle and its current assignment) to QA-AUTO-<initials>-Q010-RUN1, then change the assignment to another vehicle from the same data entry.  (needs: named go-ahead: a bus change may write through BPInfo to real systems)

## Expected (each line must be checkable)
- E1 (step 1, ui): The vehicle list opens with no error and shows the vehicles and their current assignments. (ASSUMPTION)
- E2 (step 2, ui): After the assignment, QA-AUTO-<initials>-Q010-RUN1 shows the first vehicle and the vehicle list shows it assigned to QA-AUTO-<initials>-Q010-RUN1. (ASSUMPTION)
- E3 (step 2, ui): After the change, QA-AUTO-<initials>-Q010-RUN1 shows the second vehicle and still shows it after reloading the page. (ASSUMPTION)

## Clean-up
- Restore the vehicle assignment to its earlier value. Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, row 23. Converted 2026-11-26.
- Row 23: last manual result pass on 13.1.12.153; other results: 13.1.9.116: pass; 13.1.8.155: pass.
- Refined 2026-11-26: sheet row 23 has a group name and priority only, no action text, so the steps and checks are assumed. Manual results: pass on 13.1.8.155, 13.1.9.116 and 13.1.12.153. Do not run step 2 without the named go-ahead. Clean-up: restore the vehicle assignment to its earlier value; delete the QA-AUTO run. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
