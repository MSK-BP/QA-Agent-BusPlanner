---
id: TRN-REG-015
title: Turns - Location permission
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!129-132]
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
1. On first use of Navigation, grant the location permission when the app asks.
2. Revoke the permission: `adb shell pm revoke com.GeorefSystems_TRPT android.permission.ACCESS_FINE_LOCATION`.
3. On first use of Navigation, deny the location permission when the app asks.
4. Revoke the permission: `adb shell pm revoke com.GeorefSystems_TRPT android.permission.ACCESS_FINE_LOCATION`.
5. On first use of Navigation, choose Only this time (Android 16) and not Always.
6. During a run, revoke the location permission in the system settings.
7. Restore the location permission in the system settings, then return to the app.

## Expected (each line must be checkable)
- E1 (step 1, device): Navigation proceeds.
- E2 (step 1, device): The map shows the emulator's set location.
- E3 (step 3, device): A message says location is needed (ASSUMPTION).
- E4 (step 3, device): The app does not crash.
- E5 (step 5, device): The app works normally in the foreground.
- E6 (step 6, device): The app handles the loss of the permission without a crash.
- E7 (step 7, device): Turns Navigation shows the current location again (ASSUMPTION).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 129 to 132. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Location permission: restore step added so the recovery check has an action, E lines split.
- Revoking a runtime permission kills the app process. A restart after a revoke is not a crash.
- Refined 2026-11-26 (review fixes): revoke steps added, Only this time (Android 16), E2/E3/E7 wording, precondition, note on process kill.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
