---
id: FLT-REG-008
title: BP Fleet - Update Inventory Count
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!9]
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
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- The case creates its own part `QA-AUTO-<initials>-PART8` with count 10 (step 1).

## Steps
1. In BP Fleet, open the Parts list and add part `QA-AUTO-<initials>-PART8` with count 10. Save.
2. In BP Fleet, open the Inventory list.
3. On the Inventory list, open the count screen for part `QA-AUTO-<initials>-PART8` (ASSUMPTION: screen name).
4. On the count screen, enter a new count of 15.
5. On the count screen, click Save.
6. Open the Inventory list and search for `QA-AUTO-<initials>-PART8`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 5, ui): The save completes with no error message.
- E2 (step 6, ui): The Inventory list shows `QA-AUTO-<initials>-PART8` with a count of 15.

## Clean-up
- Delete part `QA-AUTO-<initials>-PART8`.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 9. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49; related bugs 44305 , 44306, 44314, 44495.
- Refined 2026-11-26: concrete steps and E lines; reviewer fixes: case creates PART8 with a known count and deletes it; inventory lock in resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
