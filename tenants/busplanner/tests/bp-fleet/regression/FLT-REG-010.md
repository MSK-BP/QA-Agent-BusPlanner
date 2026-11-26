---
id: FLT-REG-010
title: BP Fleet - Add new parts and part location
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!11]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-inventory]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case creates and deletes its own part `QA-AUTO-<initials>-PART10` and location `QA-AUTO-<initials>-LOC10`. It needs no seed vehicle or vendor.

## Steps
1. In BP Fleet, open the Part Locations screen (ASSUMPTION: menu name).
2. On the Part Locations screen, add a location named `QA-AUTO-<initials>-LOC10` and save.
3. In BP Fleet, open the Parts list.
4. On the Parts list, click the button that adds a new part (ASSUMPTION: button label).
5. On the new part, enter part number `QA-AUTO-<initials>-PART10`, description `QA-AUTO-<initials>-Part ten`, location `QA-AUTO-<initials>-LOC10` and unit cost 10.00.
6. On the new part, click Save.
7. Open the Parts list and search for `QA-AUTO-<initials>-PART10`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 2, ui): The location `QA-AUTO-<initials>-LOC10` saves and shows in the Part Locations list.
- E2 (step 6, ui): The save completes with no error message.
- E3 (step 7, ui): The Parts list shows `QA-AUTO-<initials>-PART10` with description `QA-AUTO-<initials>-Part ten`, location `QA-AUTO-<initials>-LOC10` and unit cost 10.00.

## Clean-up
- Delete part `QA-AUTO-<initials>-PART10`, then location `QA-AUTO-<initials>-LOC10` (ASSUMPTION: Fleet allows it for unused records).

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 11. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49; related bugs 44316.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: case creates and deletes PART10 and LOC10, ASSUMPTION line under the Expected heading. Inventory lock in resources. Field and screen names are ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
