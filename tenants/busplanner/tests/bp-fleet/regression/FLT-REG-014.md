---
id: FLT-REG-014
title: BP Fleet - TimeCard Manager
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!15]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VEH1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-timecards, data:client-1230-workorders]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- The case creates its own work order `QA-AUTO-<initials>-WO14` (step 1) and deletes it in Clean-up.
- The signed-in user can use TimeCard Manager (ASSUMPTION).

## Steps
1. In BP Fleet, create work order `QA-AUTO-<initials>-WO14` for vehicle `QA-AUTO-<initials>-VEH1`. Save.
2. In BP Fleet, open the TimeCard Manager screen for today and note the day total (ASSUMPTION: menu name; the screen shows a day total). Call it T.
3. On TimeCard Manager, add a time entry for today: work order `QA-AUTO-<initials>-WO14`, 2.0 hours, note `QA-AUTO-<initials>-TC1`.
4. On TimeCard Manager, click Save.
5. Open the TimeCard Manager list for today.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 4, ui): The save completes with no error message.
- E2 (step 5, ui): The list shows an entry for `QA-AUTO-<initials>-WO14` with 2.0 hours and note `QA-AUTO-<initials>-TC1`.
- E3 (step 5, ui): The day total equals T + 2.0.

## Clean-up
- Delete time entry `QA-AUTO-<initials>-TC1`, then delete or void work order `QA-AUTO-<initials>-WO14`. Keep the seed vehicle.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 15. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49.
- Refined 2026-11-26: concrete steps and E lines; reviewer fixes: case creates WO14, start day total noted, E3 uses T + 2.0, workorders lock in resources. TimeCard Manager features are ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
