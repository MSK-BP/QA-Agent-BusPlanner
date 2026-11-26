---
id: CHP-REG-005
title: Chipmunk - Home page
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!46-57]
channels: [device]
roles: [chipmunk-parent]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [data:QA1-chipmunk-parent, data:QA1-chipmunk-client-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Signed in with the QA parent account (credentials file).

## Steps
1. Open the Home page.
2. On Home, tap the help button on the toolbar.
3. Go back to Home and tap the burger menu.
4. In the burger menu, tap Settings.
5. Go back to Home and open the burger menu.
6. In the burger menu, tap Help.
7. Go back to Home and open the burger menu.
8. In the burger menu, tap Send feedback.
9. Go back to Home and open the burger menu.
10. In the burger menu, tap Close.
11. On Home, tap Map.
12. On Home, tap ETA.
13. On Home, tap My Students.
14. On Home, tap Alerts.
15. Open the burger menu and tap Logout.

## Expected (each line must be checkable)
- E1 (step 1, device): The Home page shows a frame to navigate between Map, ETA, My Students and Alerts.
- E2 (step 1, device): The burger menu button shows.
- E3 (step 1, device): The help button shows on the toolbar.
- E4 (step 2, device): The Help page opens.
- E5 (step 2, device): The Help page shows the context of the Home page.
- E6 (step 3, device): A drawer opens on the left side.
- E7 (step 3, device): The drawer shows buttons for Settings, Help, Send feedback and Logout.
- E8 (step 4, device): The Settings page opens.
- E9 (step 6, device): The Help page opens.
- E10 (step 6, device): The Help page shows the context of the Home page.
- E11 (step 8, device): The Send feedback page opens.
- E12 (step 10, device): The drawer closes.
- E13 (step 11, device): The Map page shows.
- E14 (step 12, device): The ETA page shows.
- E15 (step 13, device): The My Students page shows.
- E16 (step 14, device): The Alerts page shows.
- E17 (step 15, device): The Setup page opens.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 46 to 57. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten as single actions; compound expected lines split; typo burget fixed.
- Review fixes 2026-11-26: Logout moved to the last step; 'go back to Home and open the burger menu' added before the Help, Send feedback and Close steps; resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
