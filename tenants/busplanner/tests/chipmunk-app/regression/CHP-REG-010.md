---
id: CHP-REG-010
title: Chipmunk - Student Information
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!81-85]
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
- The QA parent account has a student with a route (ASSUMPTION).

## Steps
1. From My Students, tap the student.
2. On Student information, tap Student.
3. On Student information, tap Transportation.

## Expected (each line must be checkable)
- E1 (step 1, device): The page shows a frame to navigate between Student and Transportation.
- E2 (step 1, device): The help button shows on the toolbar.
- E3 (step 2, device): The view changes to Student info.
- E4 (step 2, device): The Student tab shows the student name.
- E5 (step 2, device): The Student tab shows the school.
- E6 (step 2, device): The Student tab shows the grade.
- E7 (step 2, device): The Student tab shows the home address.
- E8 (step 3, device): The view changes to Transportation info.
- E9 (step 3, device): The Transportation tab shows a route from school and a route to school (ASSUMPTION: reading of the sheet text).
- E10 (step 3, device): Each route shows the pick up time and location.
- E11 (step 3, device): Each route shows the route number.
- E12 (step 3, device): Each route shows the drop off time and location.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 81 to 85. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; typo Transpoartation fixed; 'From school, to School' read as a route from school and a route to school (check with the app).
- Review fixes 2026-11-26: the two 'on load' steps were deleted and their lines re-pointed to steps 2 and 3; step 1 starts from My Students; route line marked ASSUMPTION; resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
