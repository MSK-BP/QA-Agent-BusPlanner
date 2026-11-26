---
id: CHP-REG-019
title: Chipmunk - Delete account
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!107-108]
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
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact. Create the account QA-AUTO-<initials>-parent4 with an email in the QA mailbox (needs: QA mailbox). Never delete the shared QA parent account.

## Steps
1. Create the account QA-AUTO-<initials>-parent4 and log in with it.
2. On Settings, tap Delete account and confirm.
3. Log in with the account that was just deleted.

## Expected (each line must be checkable)
- E1 (step 2, device): A confirmation prompt appears.
- E2 (step 2, device): A message confirms that the account was deleted (ASSUMPTION).
- E3 (step 2, device): The account no longer shows in BP Web (needs: BP Web access).
- E4 (step 3, device): The login fails (known issue ENG-2645: the login still works for hours).

## Clean-up
- The case deletes its own account. If step 2 failed, delete QA-AUTO-<initials>-parent4 in BP Web (needs: confirm the BP Web path).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 107 to 108. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- The case was split out of CHP-REG-013 on 2026-11-26 so that it deletes its own QA-AUTO- account and never the shared QA parent account.
- Review fixes 2026-11-26: new case.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
