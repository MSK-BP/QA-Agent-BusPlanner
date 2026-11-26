---
id: TRN-REG-013
title: Turns - Navigation - Ridership-Route finished
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!109-109]
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
- Run history is enabled. A run is in progress with all stops except the last serviced.

## Steps
1. On the Turns Navigation page, drive through the last stop of the run so that Turns Navigation services it, then open Route Review.

## Expected (each line must be checkable)
- E1 (step 1, device): Route Review shows the run as finished (ASSUMPTION: shown with a timestamp, as in row 79) (needs: emulator route playback or GPS spoofer).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 109 to 109. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Route finished: step names the action, GPS need marked.
- Refined 2026-11-26 (review fixes): E1 now checked in Route Review, preconditions added.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
