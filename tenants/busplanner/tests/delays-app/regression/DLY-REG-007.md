---
id: DLY-REG-007
title: Delays - Subscription reset
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!55-61]
channels: [device, ui]
roles: [professional]
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36, browser, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- Setup is completed with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes; the Notifications screen is open.
- The tester can change the QA test client settings in BP Web (needs a browser session signed in as professional). Each reset needs a fresh state (see Notes).

## Steps
1. In BP Web settings, set DelaysApp_SubscriptionResetDate to today (yyyy-MM-dd).
2. Relaunch the app.
3. On the Pick Notification Type screen, pick For my child's bus.
4. Fresh state (clear app data, complete Setup with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes, set DelaysApp_SubscriptionResetDate to today in BP Web, relaunch the app (ASSUMPTION)), then pick For my schools.
5. Fresh state (clear app data, complete Setup with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes, set DelaysApp_SubscriptionResetDate to today in BP Web, relaunch the app (ASSUMPTION)), then pick All alerts.
6. Complete the reset, then tap the wrench icon.
7. Relaunch the app again.
8. In BP Web settings, set DelaysApp_SubscriptionResetDate to a future date.
9. Relaunch the app.
10. In BP Web settings, clear DelaysApp_SubscriptionResetDate.
11. Relaunch the app.
12. Fresh state (clear app data, complete Setup with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes, set DelaysApp_SubscriptionResetDate to today in BP Web, relaunch the app (ASSUMPTION)), pick For my child's bus, choose a school, then force close the app on the Routes screen.
13. Relaunch the app.
14. Pick All alerts to complete the reset, then tap the wrench icon (ASSUMPTION).
15. In BP Web settings, clear DelaysApp_SubscriptionResetDate.
16. Relaunch the app.

## Expected (each line must be checkable)
- E1 (step 1, ui): BP Web settings show today's date in DelaysApp_SubscriptionResetDate.
- E2 (step 2, device): The subscription is cleared.
- E3 (step 2, device): The Pick Notification Type screen appears.
- E4 (step 3, device): For my child's bus leads to the Schools screen and then the Routes screen.
- E5 (step 4, device): For my schools leads to the Schools screen only.
- E6 (step 5, device): Setup finishes without the Schools screen (ASSUMPTION).
- E7 (step 6, device): The Notifications screen reflects only the new choice.
- E8 (step 6, device): The old schools and routes are gone.
- E9 (step 6, device): The wrench Setup shows all alerts on (ASSUMPTION).
- E10 (step 7, device): The app does not reset a second time.
- E11 (step 7, device): The app goes straight to the Notifications screen.
- E12 (step 8, ui): BP Web settings show the future date in DelaysApp_SubscriptionResetDate.
- E13 (step 9, device): The app does not reset with a future reset date.
- E14 (step 10, ui): BP Web settings show DelaysApp_SubscriptionResetDate empty.
- E15 (step 11, device): The app does not reset with no reset date.
- E16 (step 13, device): The Pick Notification Type screen appears again.
- E17 (step 14, device): The wrench Setup shows no school from the interrupted reset (ASSUMPTION).
- E18 (step 15, ui): BP Web settings show DelaysApp_SubscriptionResetDate empty.
- E19 (step 16, device): The app does not reset on launch.

## Clean-up
- In BP Web, clear DelaysApp_SubscriptionResetDate (always, also after a failed run).
- Remove any QA-AUTO- data the case created on the server.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 55 to 61. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- The reset runs once per reset date. To test the reset again, reinstall the app or clear its app data (sheet row 58). The exact fresh-state routine for steps 4, 5 and 12 is not in the sheet.
- Refined 2026-11-26: split compound Expected lines, split each BP Web setting change from the relaunch, split the future-date and cleared-date rows into two checks, put the three pick options in three steps with their own Expected lines, made the final clean-up row a step with a check, added the QA-test-client precondition.
- Date risk: 'today' is compared at launch; a run that crosses midnight, or a time-zone difference between the app and BP Web, can break the date checks (ASSUMPTION).
- Refined 2026-11-26 (after review): Review fixes: ui channel, professional role and ui Expected lines for the setting, fresh-state steps for the picks and the interrupted reset (ASSUMPTION), force close on the Routes screen, wrench checks, date risk note, clean-up always clears the setting, resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
