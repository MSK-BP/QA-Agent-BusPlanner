---
id: CHP-REG-013
title: Chipmunk - Settings
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!97-109]
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
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact.
- Record the original value of every setting on the Settings page before step 2.
- Steps 7 to 9 need alerts from bus movement; the other steps run on any emulator.

## Steps
1. Open the Settings page.
2. On Settings, switch ETA auto refresh ON, then OFF.
3. On Settings, select a Home page.
4. Close and reopen the app.
5. On Settings, select a number of minutes for the ETA notification.
6. On Settings, select a Distance Unit.
7. On Settings, switch Radius notifications ON, then OFF.
8. On Settings, switch Ridership notifications ON, then OFF.
9. On Settings, switch Alert notifications ON, then OFF.
10. On Settings, tap Edit Notification Circle.
11. On Settings, tap Send Feedback.
12. On Settings, tap Terms of use.

## Expected (each line must be checkable)
- E1 (step 1, device): The page loads the user's settings from the district settings and the personal settings.
- E2 (step 1, device): The page shows the account email.
- E3 (step 1, device): The page shows the system information: app version, build number, subscriber GUID, appID, OneSignal Subscription ID and Endpoint.
- E4 (step 1, device): The switch locked by the district settings is disabled (needs: name of the locked switch from the QA client settings).
- E5 (step 1, device): The page shows the ETA auto refresh switch.
- E6 (step 1, device): The page shows the Home page picker.
- E7 (step 1, device): The page shows the Distance Unit picker.
- E8 (step 1, device): The page shows the Radius, Ridership, Alert, School Departure and School Arrival notification switches.
- E9 (step 1, device): The page shows the Edit Notification Circle, Send Feedback, Delete account and Terms of use buttons.
- E10 (step 1, device): The help button shows on the toolbar.
- E11 (step 2, device): With the switch ON, the auto refresh works on the pages that use it.
- E12 (step 2, device): With the switch OFF, the auto refresh does not run on the pages that use it.
- E13 (step 3, device): The Home page shows the selected page.
- E14 (step 4, device): The selected page is the main page after the app reopens.
- E15 (step 5, device): The app uses the selected number of minutes before the bus reaches the pick up location (needs: bus movement and push delivery).
- E16 (step 6, device): The Map, ETA and Alerts pages show imperial or metric units as selected.
- E17 (step 6, device): The notification texts use the selected unit (needs: bus movement and push delivery).
- E18 (step 7, device): With the switch ON, the app receives notifications for alerts from buses close to the stops of students (needs: bus movement and push delivery).
- E19 (step 7, device): With the switch OFF, the app does not receive these notifications (needs: bus movement and push delivery).
- E20 (step 8, device): With the switch ON, the app receives notifications for alerts from Ridership scans of students (needs: Ridership scans and push delivery).
- E21 (step 8, device): With the switch OFF, the app does not receive these notifications (needs: Ridership scans and push delivery).
- E22 (step 9, device): With the switch ON, the app alerts the driver who drives through a stop and does not comply with the stop radius, time and speed (needs: real bus movement) (ASSUMPTION: sheet may be wrong, confirm with Apps).
- E23 (step 9, device): With the switch OFF, the app does not prompt the driver who misses a stop (needs: real bus movement) (ASSUMPTION: sheet may be wrong, confirm with Apps).
- E24 (step 10, device): The Radius edit page opens.
- E25 (step 11, device): The Feedback form page opens.
- E26 (step 12, device): The Terms of use page opens.
- E27 (step 12, device): The page loads the terms of use text for the Chipmunk app.

## Clean-up
- Set every changed setting (ETA auto refresh, Home page, ETA notification minutes, Distance Unit, Radius, Ridership and Alert notifications) back to the values recorded in the preconditions.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 97 to 109. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten as single actions with ON then OFF made explicit; compound expected lines split; push and bus movement lines marked needs; QA account precondition added; sheet wording kept for the Alert notifications driver lines (they read like Turns behaviour, check with the Apps team); typos fixed.
- Review fixes 2026-11-26: Delete account and the deleted-login check moved to CHP-REG-019 (it creates its own account); Terms of use no longer follows account deletion; 'close and reopen the app' step added for the Home page line; locked switch named (needs); notification lines marked needs; driver lines marked ASSUMPTION; clean-up restores every setting; resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
