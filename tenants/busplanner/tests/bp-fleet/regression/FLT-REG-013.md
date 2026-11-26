---
id: FLT-REG-013
title: BP Fleet - My Daily Work
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!14]
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
- The case creates its own work order `QA-AUTO-<initials>-WO13` (steps 1 to 3) and deletes it in Clean-up.

## Steps
1. In BP Fleet, create work order `QA-AUTO-<initials>-WO13` for vehicle `QA-AUTO-<initials>-VEH1`.
2. On the work order, assign it to the signed-in user (ASSUMPTION: an Assigned To field).
3. On the work order, click Save.
4. In BP Fleet, open the My Daily Work screen (ASSUMPTION: menu name).
5. On My Daily Work, read the list of assigned work.
6. On My Daily Work, open `QA-AUTO-<initials>-WO13` from the list.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 3, ui): The save completes with no error message.
- E2 (step 4, ui): My Daily Work opens with no error message.
- E3 (step 5, ui): The list shows `QA-AUTO-<initials>-WO13`.
- E4 (step 6, ui): The work order opens and shows vehicle `QA-AUTO-<initials>-VEH1`.

## Clean-up
- Delete or void work order `QA-AUTO-<initials>-WO13`. Keep the seed vehicle.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 14. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: passed on 12.4.11.49.
- Refined 2026-11-26: concrete steps and E lines; reviewer fixes: case creates WO13 on the seed vehicle, assigned to the signed-in user, deletes it; workorders lock in resources. What My Daily Work lists is ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
