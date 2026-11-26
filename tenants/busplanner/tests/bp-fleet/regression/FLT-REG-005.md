---
id: FLT-REG-005
title: BP Fleet - Work Order List search
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!6]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VEH1, seed:QA-AUTO-VEH2]
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
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH2` exists (second vehicle, for WO5B). No case deletes it.

## Steps
1. In BP Fleet, create work order `QA-AUTO-<initials>-WO5` for vehicle `QA-AUTO-<initials>-VEH1`. Save.
2. In BP Fleet, create work order `QA-AUTO-<initials>-WO5B` for vehicle `QA-AUTO-<initials>-VEH2`. Save.
3. Open the Work Orders list.
4. On the Work Orders list, type `QA-AUTO-<initials>-WO5` in the search box and run the search.
5. On the Work Orders list, clear the search, filter by vehicle `QA-AUTO-<initials>-VEH1` and run the search.
6. On the Work Orders list, search for the text `QA-AUTO-NO-SUCH-WO`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 4, ui): The list shows `QA-AUTO-<initials>-WO5`.
- E2 (step 4, ui): The list does not show `QA-AUTO-<initials>-WO5B` (ASSUMPTION: the search matches the full reference, not a prefix; confirm with the team how the search matches).
- E3 (step 5, ui): Every row in the list has vehicle `QA-AUTO-<initials>-VEH1`.
- E4 (step 5, ui): The list shows `QA-AUTO-<initials>-WO5` and not `QA-AUTO-<initials>-WO5B`.
- E5 (step 6, ui): The list shows no rows or a "no results" message, and no error.

## Clean-up
- Delete or void `QA-AUTO-<initials>-WO5` and `QA-AUTO-<initials>-WO5B`. Keep the seed vehicles VEH1 and VEH2.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 6. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49.
- Refined 2026-11-26: concrete search steps and E lines; reviewer fixes: case creates WO5 and WO5B and deletes both; negative check that WO5B is not listed.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
