---
id: TRN-REG-009
title: Turns - Navigation - Route Review (if enabled)
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!75-79]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- The feature named in the title is enabled for the test client.
- The device has saved runs from the last 2 days and from more than 2 days ago (needs: a way to make old runs, for example a device date change). One student on the run also rides another run.
- Do not capture student names in screenshots: mask them or do not capture.

## Steps
1. On the Route Selection page, select a run, then tap Run History.
2. On the Route Review page, turn on the Include older runs switch.
3. On the Route Review page, tap a past run.
4. On the run details page, open a student who also rides other runs.
5. On the run details page, tap Mark as Finished.

## Expected (each line must be checkable)
- E1 (step 1, device): The Route Review page loads the right information for the selected run.
- E2 (step 1, device): The Route Review page lists the runs of the past 2 days.
- E3 (step 1, device): Each past run shows the date and time when it started.
- E4 (step 1, device): Each past run shows its current status.
- E5 (step 1, device): Each past run shows the number of students scanned.
- E6 (step 2, device): The Route Review page loads the right information for the selected run.
- E7 (step 2, device): The Route Review page lists all saved runs.
- E8 (step 2, device): The list has no date limit.
- E9 (step 3, device): The page loads the details of the selected run.
- E10 (step 3, device): The details show the right date and time.
- E11 (step 3, device): The details list the students of the run.
- E12 (step 3, device): Each student shows a name.
- E13 (step 3, device): Each student shows a grade.
- E14 (step 3, device): Each student shows a pick up location.
- E15 (step 3, device): Each student shows a drop off location.
- E16 (step 3, device): A student who does not belong to the route shows an unknown location.
- E17 (step 3, device): Each student shows the school the student belongs to.
- E18 (step 3, device): Each student shows a status.
- E19 (step 3, device): Each student shows a list of scans with time and location.
- E20 (step 4, device): The page shows only this run's pick up and drop off (known issue ENG-2687).
- E21 (step 5, device): The run is marked as finished.
- E22 (step 5, device): The run shows a finish timestamp.

## Clean-up
- Mark as Finished changes the run on the device only. Reset the app data (`adb shell pm clear <package>`) and undo any device date change.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 75 to 79. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Route Review: steps name the screen, E lines split per field, typo fixed (Incluse), known issue kept.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Refined 2026-11-26 (second review): preconditions (old and recent runs, student on two runs), no student names in screenshots, cleanup.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
