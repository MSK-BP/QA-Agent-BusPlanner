---
id: TRN-REG-008
title: Turns - Navigation - View Directions
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!72-73]
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
- Do not capture student names in screenshots: mask them or do not capture.

## Steps
1. On the Route Selection page, select a route and a run, then tap View Directions.
2. On the Directions page, tap a bus stop.

## Expected (each line must be checkable)
- E1 (step 1, device): The Directions page loads the right information for the route.
- E2 (step 1, device): The Directions page shows a full list of directions for the selected run.
- E3 (step 1, device): The Directions page shows the bus stops for the selected run.
- E4 (step 2, device): The Bus Stop page opens.
- E5 (step 2, device): The Bus Stop page shows the list of students that belong to the bus stop.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 72 to 73. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: View Directions: steps name the screen, compound E split.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Refined 2026-11-26 (second review): precondition: no student names in screenshots.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
