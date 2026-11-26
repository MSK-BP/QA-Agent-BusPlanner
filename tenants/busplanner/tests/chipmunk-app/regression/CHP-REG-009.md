---
id: CHP-REG-009
title: Chipmunk - Alerts
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!76-79]
channels: [device]
roles: [chipmunk-parent]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [data:QA1-chipmunk-parent]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Signed in with the QA parent account (credentials file).
- The QA parent account has a student linked to a route, school, district or bus stop that has at least one alert (ASSUMPTION).

## Steps
1. Open the Alerts page.
2. Tap the refresh button on the Alerts page.
3. Stay on the Alerts page up to N minutes (ASSUMPTION: refresh interval) until the automatic refresh runs.
4. Tap an alert in the list.

## Expected (each line must be checkable)
- E1 (step 1, device): The Alerts page shows a loading sign, then the list (ASSUMPTION).
- E2 (step 1, device): The list shows all alerts for any route, school, district or bus stop linked to a student and matches the alerts for the QA client in BP Web (ASSUMPTION).
- E3 (step 1, device): The refresh button shows on the Alerts page.
- E4 (step 2, device): The Alerts page shows a reload sign, such as a spinner or a changed update time (ASSUMPTION).
- E5 (step 2, device): The alerts list shows the current data after the reload.
- E6 (step 3, device): The Alerts page shows a reload sign, such as a spinner or a changed update time (ASSUMPTION).
- E7 (step 3, device): The alerts list shows the current data after the reload.
- E8 (step 4, device): More information about the alert shows.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 76 to 79. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; test data precondition added (ASSUMPTION).
- Review fixes 2026-11-26: list compared with BP Web (ASSUMPTION); 'requests' lines replaced by a visible reload sign; automatic refresh wait has a maximum (ASSUMPTION); resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
