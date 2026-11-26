---
id: DLY-REG-006
title: Delays - Re-select / Change subscription
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!49-54]
channels: [device]
roles: []
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36, data:qa1-delays-notices, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- Setup is completed with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes; the Notifications screen is open.
- The quick code of the second approved test client (1221/1230) is available (ASSUMPTION).
- One QA-AUTO- notice dated today exists on each client (needs: one QA-AUTO- notice today on each client).

## Steps
1. On the Notifications screen, tap the tools (wrench) icon.
2. Tap Next on each Setup screen without changing anything.
3. Go back to the Schools screen and add a school, then tap Next.
4. Navigate back from the Routes screen to the Schools screen.
5. Remove every chosen school.
6. Try to finish Setup.
7. Relaunch the app.
8. Change to a different transportation authority by typing the quick code of the second test client.
9. Complete the changed Setup.

## Expected (each line must be checkable)
- E1 (step 1, device): Setup opens.
- E2 (step 1, device): The current authority is already selected.
- E3 (step 2, device): The Schools screen shows the existing schools.
- E4 (step 2, device): The Routes screen shows the existing routes.
- E5 (step 4, device): The added school is still chosen.
- E6 (step 6, device): Setup does not complete with no school chosen: it is blocked, or a message is shown.
- E7 (step 6, device): The app does not crash.
- E8 (step 6, device): No empty subscription is saved.
- E9 (step 7, device): The app opens Setup or the previous subscription, not an empty Notifications list.
- E10 (step 8, device): The old schools and routes are cleared.
- E11 (step 8, device): The lists of the new authority load.
- E12 (step 9, device): The Notifications screen shows only notifications for the new subscription (needs: one QA-AUTO- notice today on each client).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 49 to 54. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: split compound Expected lines, split the add-a-school row into the add and the back navigation, split the remove-all row into remove and try-to-finish, added the QA-test-client precondition and the second-authority precondition (ASSUMPTION).
- Refined 2026-11-26 (after review): Review fixes: removed the dependency on DLY-REG-001, step 3 now adds a school and taps Next, second client quick code precondition, relaunch step and check after the blocked finish, needs marker for the notices, start state, resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
