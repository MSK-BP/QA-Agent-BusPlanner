---
id: TRN-REG-011
title: Turns - Navigation - Ridership
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!99-99]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: []
status: retired
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).

## Steps
1. Open the file that the sheet row refers to for Ridership testing.

## Expected (each line must be checkable)
- E1 (step 1, device): The Ridership checks follow the referred file (ASSUMPTION: the sheet names no file and gives no expected result; the Ridership checks are in TRN-REG-012 and TRN-REG-013).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 99 to 99. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- The sheet row has no expected result and the referred file is not named.
- Refined 2026-11-26: Ridership pointer row: kept as one step; the sheet gives no expected result, so the E line is an ASSUMPTION.
- Refined 2026-11-26 (review fixes): status set to retired (pointer row; the Ridership checks are in TRN-REG-012 and TRN-REG-013).
