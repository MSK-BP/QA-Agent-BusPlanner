---
id: FLT-REG-011
title: BP Fleet - Add Reminder
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!12]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VEH1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-reminders]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- Record the client setting "Reminders Anchored Scheduling Mode" (ENG-675) of client 1230 before the run. It is a client setting, not a per reminder choice. This case does not change it (see FLT-REG-012).
- Reminder notifications go to test addresses only (needs: confirmation that no real address is on client 1230's reminder notification list).

## Steps
1. In BP Fleet, open the Reminders list.
2. On the Reminders list, click the button that adds a reminder (ASSUMPTION: button label).
3. On the new reminder, select vehicle `QA-AUTO-<initials>-VEH1`.
4. On the new reminder, enter the name `QA-AUTO-<initials>-REM11` and an interval of 30 days.
5. On the new reminder, click Save.
6. Open the Reminders list and search for `QA-AUTO-<initials>-REM11`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 5, ui): The save completes with no error message.
- E2 (step 6, ui): The Reminders list shows `QA-AUTO-<initials>-REM11` for vehicle `QA-AUTO-<initials>-VEH1`.
- E3 (step 6, ui): The reminder shows an interval of 30 days.

## Clean-up
- Delete reminder `QA-AUTO-<initials>-REM11`. Keep the seed vehicle.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 12. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: Anchored is a client setting (ENG-675), removed from the reminder steps and E lines; this case covers the create form fields only, scheduling is in FLT-REG-012; test-address precondition added.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
