---
id: TRN-REG-021
title: Turns - Settings - Developer Mode
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!123-127]
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
- Developer Mode is switched on under More in Settings.
- The Ridership Test saves real scans for card 1751: use a test database only (needs: named go-ahead for BPInfo scan writes).

## Steps
1. Under More, turn the Developer Mode switch on.
2. On the Route Selection page, tap Start Driving with Spoofer.
3. In the Start Driving with Spoofer run, pick a different run in its picker.
4. On an Android device, finish a real drive with Developer Mode on.
5. On the Route Selection page, tap Start Driving with Spoofer for that run.
6. On the Settings page under More, set seconds between tests to 20, then tap Start Ridership Test.
7. Stop the Ridership Test.
8. Under More, turn the Mock Offline Mode switch on, then open the Route Selection page.

## Expected (each line must be checkable)
- E1 (step 1, device): The Route Selection page shows Start Driving with Spoofer.
- E2 (step 1, device): The Settings page shows Start Ridership Test.
- E3 (step 2, device): The app drives the run without moving the device.
- E4 (step 2, device): In builds without ENG-2040, the app marks the stops as it drives past them, because it does not stop at stops.
- E5 (step 2, device): From the next release (ENG-2040), the spoofer waits about 10 seconds at each stop so arrivals register (needs: a build with ENG-2040).
- E6 (step 3, device): The app tests rerouting.
- E7 (step 3, device): The route trace changes to the picked run (ASSUMPTION).
- E8 (step 4, device): The app saves a replay file to the Downloads folder of the device when the drive ends (needs: emulator route playback or GPS spoofer).
- E9 (step 5, device): The app offers to replay the saved drive (needs: emulator route playback or GPS spoofer).
- E10 (step 6, device): The app looks up a test card.
- E11 (step 6, device): The app sends a test scan every 20 seconds (set in seconds between tests).
- E12 (step 6, device): The page shows the last result.
- E13 (step 7, device): The app stops sending test scans (ASSUMPTION).
- E14 (step 8, device): The app acts as if there is no connection.
- E15 (step 8, device): The toolbar shows the offline icon (row 65, ASSUMPTION).

## Clean-up
- Turn Mock Offline Mode and Developer Mode off.
- The Ridership Test scans for card 1751 cannot carry QA-AUTO-. Write the number of scans and the time window in the run report. Ask the BPInfo owner to remove them.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 123 to 127. Split out of TRN-REG-014 on 2026-11-26.
- Priority set by the conversion (the sheet has none): P2.
- Row 124: once a stop page has been opened, the spoofer stops updating the blackout and the map lock (real GPS is fine).
- Refined 2026-11-26: created from the Developer Mode steps of TRN-REG-014; stop page check moved to this note; Ridership Test warning made a precondition; stop-the-test step added.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
