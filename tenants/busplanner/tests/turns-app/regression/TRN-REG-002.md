---
id: TRN-REG-002
title: Turns - Menu Page (only when PPI or T&A is enabled)
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!10-13]
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
- PPI and T&A are both enabled for the test client.

## Steps
1. Sign in to the app with PPI or T&A enabled, then wait for the Menu page.
2. On the Menu page, tap the Navigation button.
3. Go back to the Menu page. On the Menu page, tap the Pre & Post Inspections button (if enabled).
4. Go back to the Menu page. On the Menu page, tap the Time & Attendance button (if enabled).

## Expected (each line must be checkable)
- E1 (step 1, device): The Menu page shows a Navigation button.
- E2 (step 1, device): The Menu page shows a Pre & Post Inspections button (if enabled).
- E3 (step 1, device): The Menu page shows a Time & Attendance button (if enabled).
- E4 (step 2, device): The Route Selection page opens.
- E5 (step 3, device): The Pre & Post Inspections page opens (if enabled).
- E6 (step 4, device): The Pin authentication page opens (if enabled).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 10 to 13. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Menu page: steps name the screen, one E line per button, per-button navigation split.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Refined 2026-11-26 (second review): precondition PPI and T&A enabled, steps 3 and 4 start from the Menu page, E5/E6 say (if enabled).
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
