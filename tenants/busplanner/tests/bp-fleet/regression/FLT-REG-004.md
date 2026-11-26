---
id: FLT-REG-004
title: BP Fleet - Add parts and/or fuel to Purchase Order
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!5]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VENDOR1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-purchaseorders, data:client-1230-inventory]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- The case creates its own part `QA-AUTO-<initials>-PART4` and purchase order `QA-AUTO-<initials>-PO4` (steps 1 and 2).

## Steps
1. In BP Fleet, open the Parts list and add part `QA-AUTO-<initials>-PART4` with unit cost 10.00. Save.
2. In BP Fleet, create purchase order `QA-AUTO-<initials>-PO4` for vendor `QA-AUTO-<initials>-VENDOR1`. Save.
3. On the purchase order, add a part line: `QA-AUTO-<initials>-PART4`, quantity 4, unit cost 10.00.
4. On the purchase order, add a fuel line: fuel type Diesel, quantity 20, unit cost 3.00 (ASSUMPTION: fuel lines are offered on a PO).
5. On the purchase order, click Save.
6. Open purchase order `QA-AUTO-<initials>-PO4` again.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 5, ui): The save completes with no error message.
- E2 (step 6, ui): The part line shows `QA-AUTO-<initials>-PART4`, quantity 4, unit cost 10.00.
- E3 (step 6, ui): The fuel line shows Diesel, quantity 20, unit cost 3.00.
- E4 (step 6, ui): The PO total shows 100.00 (4 x 10.00 + 20 x 3.00) (ASSUMPTION: no tax or freight on the test client). The total counts all lines (ENG-1930).

## Clean-up
- Remove both lines, delete or void `QA-AUTO-<initials>-PO4`, then delete part `QA-AUTO-<initials>-PART4`. Keep the seed vendor.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 5. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49; related bugs 44378 , 44473.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: case creates PART4 and PO4 and deletes them; no-tax assumption on E4. Inventory lock because part lines can change stock on receive.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
