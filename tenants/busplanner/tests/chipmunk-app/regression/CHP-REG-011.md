---
id: CHP-REG-011
title: Chipmunk - Radius Edit
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!87-90]
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
- The QA parent account has two students, each with an AM stop and a PM stop (ASSUMPTION). This case changes notification circles on QA test data only.
- Record the original radius of every stop for both students before step 2.

## Steps
1. Open the Radius edit page from the map edit circle button, or from Settings > Edit Notification Circle.
2. Change the student, the stop and the slider, one at a time.
3. Tap Save, then reopen the Radius edit page.
4. Select another stop and read its radius.
5. Tap Save for all.
6. Select another stop and read its radius.
7. Select the second student and read each stop's radius.

## Expected (each line must be checkable)
- E1 (step 1, device): The page shows a student picker.
- E2 (step 1, device): The page shows a stop picker with the AM and PM stops.
- E3 (step 1, device): The page shows a radius slider with the distance.
- E4 (step 1, device): The page shows a map with the circle around the stop.
- E5 (step 1, device): The page shows the Save and Save for all buttons.
- E6 (step 1, device): The toolbar shows the Info and Help buttons.
- E7 (step 2, device): The map moves to the chosen stop.
- E8 (step 2, device): The circle resizes as the slider moves.
- E9 (step 2, device): The distance label updates as the slider moves.
- E10 (step 3, device): The selected stop shows the saved radius after the page reopens (ASSUMPTION).
- E11 (step 4, device): The other stop keeps its original radius.
- E12 (step 6, device): The other stop shows the current size.
- E13 (step 7, device): Each stop of the second student shows the current size.

## Clean-up
- Set the radius of every stop for both students back to the original values recorded in the preconditions.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 87 to 90. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; precondition added for the AM and PM stop test data (ASSUMPTION).
- Review fixes 2026-11-26: steps added to read another stop and the second student; save and save-for-all results are now visible readings; two-students precondition; clean-up restores each original radius; resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
