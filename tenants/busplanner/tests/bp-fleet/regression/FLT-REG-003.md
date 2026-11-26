---
id: FLT-REG-003
title: BP Fleet - Create Purchase Order
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!4]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VENDOR1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-purchaseorders]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.

## Steps
1. In BP Fleet, open the Purchase Orders list.
2. On the Purchase Orders list, click the button that creates a new purchase order (ASSUMPTION: button label).
3. On the new purchase order, select vendor `QA-AUTO-<initials>-VENDOR1`.
4. On the new purchase order, enter the reference `QA-AUTO-<initials>-PO3`.
5. On the new purchase order, click Save.
6. Open the Purchase Orders list and search for `QA-AUTO-<initials>-PO3`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 5, ui): The save completes with no error message.
- E2 (step 5, ui): The purchase order shows a PO number.
- E3 (step 6, ui): The Purchase Orders list shows `QA-AUTO-<initials>-PO3` with vendor `QA-AUTO-<initials>-VENDOR1`.

## Clean-up
- Delete or void purchase order `QA-AUTO-<initials>-PO3` (ASSUMPTION: Fleet allows it). Do NOT delete the seed vendor `QA-AUTO-<initials>-VENDOR1`.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 4. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49; related bugs 44870.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: seed vendor used and never deleted, case owns PO3.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
