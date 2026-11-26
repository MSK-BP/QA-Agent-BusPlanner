---
id: FLT-REG-001
title: BP Fleet - Create a Work Order
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!2]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VEH1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-workorders]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.

## Steps
1. In BP Fleet, open the Work Orders list.
2. On the Work Orders list, click the button that creates a new work order (ASSUMPTION: button label).
3. On the new work order, select vehicle `QA-AUTO-<initials>-VEH1`.
4. On the new work order, enter the description `QA-AUTO-<initials>-WO1`.
5. On the new work order, click Save.
6. Open the Work Orders list and search for `QA-AUTO-<initials>-WO1`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 5, ui): The save completes with no error message.
- E2 (step 5, ui): The work order shows a work order number.
- E3 (step 6, ui): The Work Orders list shows `QA-AUTO-<initials>-WO1` with vehicle `QA-AUTO-<initials>-VEH1`.

## Clean-up
- Delete or void work order `QA-AUTO-<initials>-WO1` (ASSUMPTION: Fleet allows it; closed work orders cannot be reopened, so do not close it). Keep the seed vehicle.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 2. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: seed vehicle used (no create-if-missing), case owns and deletes WO1, ASSUMPTION line under the Expected heading. Field and button names are ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
