---
id: CHP-REG-001
title: Chipmunk - Initial checks
module: chipmunk-app
flow: regression
ticket:
priority: P1
spec: [sheet:Chipmunk!3-9]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact.
- Steps 1 to 4 need a fresh install (app uninstalled).

## Steps
1. Uninstall any copy of the app, install the current build and start the app for the first time.
2. On the first start, read the disclaimer screen.
3. On the first start, continue to the Terms of use page and tap the help button.
4. Accept the terms and continue.
5. Uninstall. Install the earlier build (needs: earlier APK), set it up, then install the current build over it and start it.

## Expected (each line must be checkable)
- E1 (step 1, device): A permission prompt for notifications appears.
- E2 (step 1, device): The Welcome to Chipmunk page opens on the first start.
- E3 (step 2, device): The disclaimer states that times are estimates.
- E4 (step 2, device): The disclaimer asks the user to adhere to the district's policies.
- E5 (step 3, device): The Terms of use page opens.
- E6 (step 3, device): The help button on the Terms of use page opens the Help page.
- E7 (step 3, device): The Help page shows the help context of the Terms of use page.
- E8 (step 4, device): After Welcome, Disclaimer and Terms of use, the Setup page opens.
- E9 (step 5, device): The app starts without an error after the update.
- E10 (step 5, device): The app keeps the district and quick code from before the update.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 3 to 9. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten as single imperative actions; compound expected lines split; fresh-install precondition for steps 4 to 6 and QA-client precondition added; iOS 13 and Android 5 lines marked needs.
- Review fixes 2026-11-26: permission prompt moved to the fresh install; Setup page checked after Welcome, Disclaimer and Terms of use; update step uses an earlier APK; oldest OS step moved to CHP-REG-018; steps renumbered (fresh install first, update last); device resource added.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
