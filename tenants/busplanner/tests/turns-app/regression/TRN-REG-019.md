---
id: TRN-REG-019
title: Turns - Offline
module: turns-app
flow: regression
ticket:
priority: P1
spec: [sheet:Turns!147-149]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [data:qa1-turns-route]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- A run is in progress. The run has a student with a known ID.

## Steps
1. During a run in Turns Navigation, turn off the network of the device.
2. On the Turns Navigation page, tap Skip Stop while offline.
3. While offline, enter the manual ID of a student on the run, and submit one inspection form (needs: named go-ahead for BPInfo writes).
4. Turn the network of the device back on.

## Expected (each line must be checkable)
- E1 (step 1, device): Offline mode engages without an error.
- E2 (step 1, device): Navigation continues from cached data.
- E3 (step 2, device): The app skips the stop.
- E4 (step 2, device): The app does not crash (known issue ENG-2649).
- E5 (step 4, device): Within 60 s of reconnect, the scan shows as sent (Apps.md: only scans start the 60 s retry timer).
- E6 (step 4, device): Route Review shows one scan for the student.
- E7 (step 4, device): The serviced stops stay grey after the sync.
- E8 (step 4, device): The form uploads on reconnect (ASSUMPTION: forms retry only on reconnect or restart, no timer).

## Clean-up
- The scan and the inspection form cannot carry QA-AUTO-. Write the student ID, the form name, the run and the time in the run report. Ask the BPInfo owner to remove them, because the app cannot delete them.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 147 to 149. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Apps.md: the offline queue holds scans and form results. Only scans start the 60 s retry timer; a failed form waits for reconnect or restart (`SyncService.cs`).
- Refined 2026-11-26: Offline: steps name the action, E lines split, known issue ENG-2649 kept.
- Refined 2026-11-26 (review fixes): offline scan and form step added, E5 to E7 reworded, form upload E added, resources, precondition, clean-up.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
