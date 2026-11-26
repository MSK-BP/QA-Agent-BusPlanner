---
id: TRN-REG-017
title: Turns - App lifecycle
module: turns-app
flow: regression
ticket:
priority: P1
spec: [sheet:Turns!140-143]
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
- A run is in progress.

## Steps
1. During a run in Turns Navigation, put the app in the background.
2. While the app is in the background, move the emulator location through the next stop.
3. Bring the app back to the foreground.
4. Change the emulator location again.
5. During a run in Turns Navigation, lock the screen.
6. Unlock the screen.
7. Force close the app, then reopen it.
8. On the Route Selection page, tap Start Driving.
9. Leave the app running on the Turns Navigation page and stationary for an extended period (ASSUMPTION: 30 minutes).
10. After the wait, change the emulator location.

## Expected (each line must be checkable)
- E1 (step 3, device): The run state is intact.
- E2 (step 3, device): The current stop is intact.
- E3 (step 3, device): The stop count goes up by one only.
- E4 (step 3, device): The directions list or Route Review shows no duplicate rows.
- E5 (step 4, device): The location marker moves when the emulator location changes (needs: emulator route playback or GPS spoofer).
- E6 (step 6, device): The position is intact.
- E7 (step 6, device): The stop progress is intact.
- E8 (step 6, device): Navigation resumes.
- E9 (step 6, device): The run does not restart.
- E10 (step 8, device): Navigation starts normally.
- E11 (step 8, device): The app does not crash.
- E12 (step 9, device): The screen shows no blackout.
- E13 (step 10, device): The location marker moves when the emulator location changes, so the map is not frozen (needs: emulator route playback or GPS spoofer).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 140 to 143. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- The sheet gives no duration for the stationary check; 30 minutes is an ASSUMPTION.
- Refined 2026-11-26: App lifecycle: steps split (background and foreground, lock and unlock, force close and reopen), E lines split, duration ASSUMPTION added.
- Refined 2026-11-26 (review fixes): background step moves the emulator location, stop count and duplicate rows wording, location marker checks, precondition.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
