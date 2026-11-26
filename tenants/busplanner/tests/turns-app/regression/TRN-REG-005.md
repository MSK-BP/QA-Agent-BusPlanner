---
id: TRN-REG-005
title: Turns - Time & Attendance (if enabled)
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!41-41]
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

## Steps
1. On the Menu page, tap Time & Attendance.

## Expected (each line must be checkable)
- E1 (step 1, device): The Time & Attendance page shows the Pin authentication.
- E2 (step 1, device): The Pin authentication shows one field for the employee id.
- E3 (step 1, device): The Pin authentication shows 4 fields for the 4 digit PIN.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 41 to 41. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: T&A: step names the screen, compound E split.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
