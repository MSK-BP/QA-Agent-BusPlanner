---
id: FLT-REG-012
title: BP Fleet - Reminder List (Anchored & Rolling Mode)
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!13]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VEH1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-reminders, data:client-1230-fleet-settings]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- Record the start values of the client settings "Reminders Anchored Scheduling Mode" (ENG-675), Skip Weekends and Skip Blackout on client 1230. Skip Weekends and Skip Blackout must be off during the run (ENG-2979). Restore all three in Clean-up.
- Reminder notifications go to test addresses only (needs: confirmation that no real address is on client 1230's reminder notification list).
- The signed-in user can change the client settings (ASSUMPTION).

## Steps
1. In BP Fleet, open the client settings and turn "Reminders Anchored Scheduling Mode" on.
2. Create reminder `QA-AUTO-<initials>-REM12A` for vehicle `QA-AUTO-<initials>-VEH1`: interval 30 days, last done date 40 days ago (call it L).
3. Open the Reminders list and read the due date of `QA-AUTO-<initials>-REM12A`.
4. On the reminder, mark it done today.
5. Open the Reminders list and read the next due date of `QA-AUTO-<initials>-REM12A`.
6. In the client settings, turn "Reminders Anchored Scheduling Mode" off.
7. Create reminder `QA-AUTO-<initials>-REM12R` for vehicle `QA-AUTO-<initials>-VEH1`: interval 30 days, last done date 40 days ago (the same L).
8. On the reminder, mark it done today.
9. Open the Reminders list and read the next due date of `QA-AUTO-<initials>-REM12R`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 3, ui): The due date of `QA-AUTO-<initials>-REM12A` is L + 30 days, so it is overdue by 10 days.
- E2 (step 5, ui): With the setting on (Anchored), the next due date is L + 60 days, that is 20 days from today (ASSUMPTION: Anchored keeps the original schedule).
- E3 (step 9, ui): With the setting off (Rolling), the next due date is today + 30 days (ASSUMPTION: Rolling counts from the done date).

## Clean-up
- Delete reminders `QA-AUTO-<initials>-REM12A` and `QA-AUTO-<initials>-REM12R`. Restore "Reminders Anchored Scheduling Mode", Skip Weekends and Skip Blackout to the recorded start values.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 13. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: scenario run twice with the client setting toggled between runs, concrete due dates, settings lock in resources, Skip Weekends and Skip Blackout off (ENG-2979), settings restored in Clean-up. The meaning of Anchored and Rolling is ASSUMPTION; confirm with the team.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
