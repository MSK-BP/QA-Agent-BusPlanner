---
id: CHP-REG-008
title: Chipmunk - My Students
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!72-74]
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
- The QA client has Add student enabled (needs: confirm).
- The QA parent account has linked students (needs: student names from the test data entry).

## Steps
1. Open the My Students page.
2. Tap a student on the My Students page.
3. Tap the add student button.

## Expected (each line must be checkable)
- E1 (step 1, device): The page lists all students linked to the QA parent (needs: student names from the test data entry).
- E2 (step 1, device): Each student shows name and grade.
- E3 (step 1, device): The add student button shows.
- E4 (step 2, device): The student information page opens.
- E5 (step 3, device): The Add student page opens.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 72 to 74. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; precondition added about the district switch for add student.
- Review fixes 2026-11-26: Add student precondition for the QA client; expected add student button line no longer conditional; student names tied to the test data entry.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
