---
id: CHP-REG-006
title: Chipmunk - ETA
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!59-62]
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
- The QA parent account has registered students with a route (ASSUMPTION: data entry needed, names from the QA1 test data).

## Steps
1. In Settings, set ETA auto refresh ON.
2. Open the ETA page.
3. Stay on the ETA page up to N minutes (ASSUMPTION: refresh interval) until the automatic refresh runs.
4. Tap the refresh button on the ETA page.
5. Tap a student row on the ETA page.

## Expected (each line must be checkable)
- E1 (step 2, device): The ETA page lists the registered students of the QA parent (needs: student names from the test data entry).
- E2 (step 2, device): Each row shows one student and the current status of the student's route (needs: a route running at test time).
- E3 (step 3, device): The ETA list shows a reload sign, such as a spinner or a changed update time (ASSUMPTION).
- E4 (step 3, device): The ETA list shows the current data after the reload.
- E5 (step 4, device): The ETA list shows a reload sign, such as a spinner or a changed update time (ASSUMPTION).
- E6 (step 4, device): The ETA list shows the current data after the reload.
- E7 (step 5, device): The student row expands.
- E8 (step 5, device): The row shows the assigned stop.
- E9 (step 5, device): The row shows the scheduled time.
- E10 (step 5, device): The row shows the route.
- E11 (step 5, device): The row shows the vehicle (needs: a route running at test time).

## Clean-up
- Set ETA auto refresh back to its value before the case.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 59 to 62. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; precondition added for the ETA auto refresh switch (from the Settings rows) and for a student with a route (ASSUMPTION).
- Review fixes 2026-11-26: step for ETA auto refresh ON added; refresh wait has a maximum (ASSUMPTION); 'requests' lines replaced by a visible reload sign; student names tied to the test data entry; route needs added; clean-up restores the switch.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
