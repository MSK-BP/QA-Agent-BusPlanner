---
id: CHP-REG-007
title: Chipmunk - Map
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!64-70]
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
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact. Never open a real store rating or send real feedback from step 8.
- Step 8 needs a student whose bus completes pickups (ASSUMPTION).

## Steps
1. Open the Map page.
2. Tap the refresh button on the Map page.
3. Stay on the Map page up to N minutes (ASSUMPTION: refresh interval) until the automatic refresh runs.
4. Tap the map.
5. Pan and zoom the map.
6. Tap the Location reset button.
7. Tap the edit circle button.
8. Complete 3 successful pickups for the student. Repeat up to 5 times, or until the user gives a good rating.

## Expected (each line must be checkable)
- E1 (step 1, device): The Map page shows a student picker.
- E2 (step 1, device): The Map page shows an edit circle button.
- E3 (step 1, device): The Map page shows a refresh button.
- E4 (step 1, device): The student picker lists the registered students.
- E5 (step 1, device): The map shows the location of the default selected student.
- E6 (step 2, device): The map shows a reload sign, such as a spinner or a changed update time (ASSUMPTION).
- E7 (step 2, device): The map shows the current location.
- E8 (step 2, device): The map shows the bus position (needs: live bus position).
- E9 (step 3, device): The map shows a reload sign, such as a spinner or a changed update time (ASSUMPTION).
- E10 (step 3, device): The map shows the bus position (needs: live bus position).
- E11 (step 4, device): A Location reset button shows.
- E12 (step 6, device): The map goes back to the original location.
- E13 (step 6, device): The map goes back to the original zoom.
- E14 (step 7, device): The Radius edit page opens.
- E15 (step 8, device): A rating popup appears (needs: 3 completed pickups from real bus movement).
- E16 (step 8, device): The popup lets the user rate from 1 to 5 stars (needs: 3 completed pickups from real bus movement).
- E17 (step 8, device): A rating of less than 3 shows a button to give feedback (needs: 3 completed pickups from real bus movement).
- E18 (step 8, device): A rating of more than 4 opens the app store rating (needs: production build and store; iOS and Android restrict this).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 64 to 70. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten as single actions; compound expected lines split; rating popup lines marked needs; QA client and no-real-store-rating precondition added; sheet comment on store restrictions kept in the needs text.
- Review fixes 2026-11-26: 'Pan and zoom the map' added before Location reset; bus position lines marked needs; 'requests' lines replaced by a visible reload sign; refresh wait has a maximum (ASSUMPTION); resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
