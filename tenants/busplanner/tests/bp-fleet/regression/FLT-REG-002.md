---
id: FLT-REG-002
title: BP Fleet - Add parts and labor to a Work Order
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!3]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VEH1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-workorders, data:client-1230-inventory]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- The case creates its own part `QA-AUTO-<initials>-PART2` (stock 5) and work order `QA-AUTO-<initials>-WO2` (steps 1 and 2). Fleet uses a default part location (ASSUMPTION; part creation is in FLT-REG-010).

## Steps
1. In BP Fleet, open the Parts list and add part `QA-AUTO-<initials>-PART2` with stock 5 and unit cost 10.00. Save.
2. In BP Fleet, open the Work Orders list and create work order `QA-AUTO-<initials>-WO2` for vehicle `QA-AUTO-<initials>-VEH1`. Save.
3. On work order `QA-AUTO-<initials>-WO2`, open the Parts section and add part `QA-AUTO-<initials>-PART2`, quantity 2.
4. On the work order, open the Labor section and add a labor line: 1.5 hours, description `QA-AUTO-<initials>-LABOR1`.
5. On the work order, click Save.
6. Open work order `QA-AUTO-<initials>-WO2` again.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 5, ui): The save completes with no error message.
- E2 (step 6, ui): The Parts section shows `QA-AUTO-<initials>-PART2` with quantity 2.
- E3 (step 6, ui): The Labor section shows `QA-AUTO-<initials>-LABOR1` with 1.5 hours.
- E4 (step 6, ui): The work order total equals the part cost plus the labor cost (ASSUMPTION: the labor rate is set on the test client).

## Clean-up
- Remove the part and labor lines, delete or void `QA-AUTO-<initials>-WO2`, then delete part `QA-AUTO-<initials>-PART2`. Keep the seed vehicle.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 3. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: case creates PART2 and WO2 itself and deletes them; seed vehicle named in data. Inventory lock in resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
