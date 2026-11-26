---
id: FLT-REG-007
title: BP Fleet - Import Vehicle Fuel records
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!8]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VEH1, data:fuel-import-format]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-fuel]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- An import file `QA-AUTO-<initials>-fuel.csv` with two rows for `QA-AUTO-<initials>-VEH1` (date, gallons, cost) is prepared in the format the import screen shows (data: `data:fuel-import-format`) (needs: the import file format; it is not in the knowledge base).

## Steps
1. In BP Fleet, open the Vehicle Fuel import screen (ASSUMPTION: menu name).
2. On the import screen, choose the file `QA-AUTO-<initials>-fuel.csv`.
3. On the import screen, click Import.
4. Open the fuel records list of vehicle `QA-AUTO-<initials>-VEH1`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 3, ui): The import completes with no error message.
- E2 (step 3, ui): The import result reports 2 records imported and 0 rejected.
- E3 (step 4, ui): The fuel list shows two new records with the dates, gallons and cost from the file.

## Clean-up
- Delete the two imported fuel records of `QA-AUTO-<initials>-VEH1` (ASSUMPTION: Fleet allows it). Keep the seed vehicle.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 8. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49; related bugs 44487,44496,44489 etc.
- Refined 2026-11-26: concrete steps and E lines; reviewer fixes: seed vehicle, import format named as a needed data entry. Add a bad-row case (bugs 44487, 44496, 44489) once the format is known.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
