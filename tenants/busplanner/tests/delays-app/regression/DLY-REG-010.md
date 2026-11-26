---
id: DLY-REG-010
title: Delays - Push notifications - delivery
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!69-84]
channels: [device, ui]
roles: [professional]
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: [DLY-REG-014]
resources: [device:real-device-1, browser, data:qa1-delays-notices, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- DLY-REG-014 passed today.
- Setup is completed on a real device with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes; the Notifications screen is open. The subscription holds two schools.
- Notices are posted in BP Web for the QA test client only, and each comment starts with QA-AUTO-<initials>- (ASSUMPTION). Steps that post in BP Web need a browser session signed in as professional.
- A real device with push notifications is available for the push checks.

## Steps
1. Post a bus notification in BP Web for a subscribed route.
2. Post a school notification in BP Web for a subscribed school.
3. Post a general notice in BP Web.
4. Post a notification in BP Web for a school or route you are NOT subscribed to.
5. Post a notification in BP Web with Perform a test only ticked.
6. Tap the refresh button in the app.
7. Post an alert in BP Web whose time frame starts later (for example a PM alert in the morning).
8. Wait until the time frame starts.
9. With the app in the foreground, post a notification in BP Web for a subscribed route.
10. With the app in the background, post a notification in BP Web for a subscribed route.
11. With the app closed, post a notification in BP Web for a subscribed route.
12. Tap the push notification.
13. Post two notifications in BP Web in quick succession.
14. Edit a posted notification in BP Web and post it again.
15. Bring the app to the foreground with unread pushes.
16. Deny the notification permission for the app in the device settings.
17. Post a notice in BP Web for a subscribed school.
18. Tap the refresh button in the app.
19. Allow the notification permission for the app again in the device settings (ASSUMPTION).
20. Unsubscribe from a school through the wrench icon.
21. Post a notice in BP Web for the school you unsubscribed from.
22. Change the subscription to a new school through the wrench icon.
23. Post a notice in BP Web for the new school.
24. Post a notice in BP Web for the old school.

## Expected (each line must be checkable)
- E1 (step 1, device): A push arrives within 2 minutes (needs: real push notifications on a real device) (ASSUMPTION).
- E2 (step 2, device): A push arrives on the device (needs: real push notifications on a real device).
- E3 (step 3, device): A push arrives on a subscribed device whatever its school or route (needs: real push notifications on a real device).
- E4 (step 4, ui): BP Web shows the QA-AUTO- notice saved for the unsubscribed school or route.
- E5 (step 4, device): No push arrives within 5 minutes (needs: real push notifications on a real device) (ASSUMPTION).
- E6 (step 5, ui): BP Web shows the QA-AUTO- test-only notice saved.
- E7 (step 5, device): No push arrives within 5 minutes (needs: real push notifications on a real device) (ASSUMPTION).
- E8 (step 6, device): The test-only alert still shows in the in-app list after a refresh (by design).
- E9 (step 7, device): No push arrives at posting time (needs: real push notifications on a real device).
- E10 (step 8, device): The push arrives when the time frame starts (needs: real push notifications on a real device).
- E11 (step 9, device): The app handles the push in-app (needs: real push notifications on a real device).
- E12 (step 9, device): The app does not crash (needs: real push notifications on a real device).
- E13 (step 9, device): The list or the badge shows the new notification (needs: real push notifications on a real device).
- E14 (step 10, device): A system notification appears (needs: real push notifications on a real device).
- E15 (step 10, device): The system notification title is correct (needs: real push notifications on a real device).
- E16 (step 10, device): The system notification body is correct (needs: real push notifications on a real device).
- E17 (step 11, device): A system notification appears (needs: real push notifications on a real device).
- E18 (step 12, device): The app opens (needs: real push notifications on a real device).
- E19 (step 12, device): The app opens the relevant notification, not only the list (needs: real push notifications on a real device).
- E20 (step 13, device): Both pushes arrive (needs: real push notifications on a real device).
- E21 (step 13, device): The pushes arrive in the order posted (needs: real push notifications on a real device).
- E22 (step 13, device): No push is duplicated (needs: real push notifications on a real device).
- E23 (step 14, device): Only one push arrives per notice (needs: real push notifications on a real device).
- E24 (step 15, device): The notification badge or count clears (needs: real push notifications on a real device).
- E25 (step 17, ui): BP Web shows the QA-AUTO- notice saved.
- E26 (step 17, device): No push arrives within 5 minutes (needs: real push notifications on a real device) (ASSUMPTION).
- E27 (step 18, device): The notice appears in the in-app list.
- E28 (step 21, ui): BP Web shows the QA-AUTO- notice saved for the unsubscribed school.
- E29 (step 21, device): No push arrives within 5 minutes (needs: real push notifications on a real device) (ASSUMPTION).
- E30 (step 23, device): A push arrives for the new school (needs: real push notifications on a real device).
- E31 (step 24, ui): BP Web shows the QA-AUTO- notice saved for the old school.
- E32 (step 24, device): No push arrives within 5 minutes (needs: real push notifications on a real device) (ASSUMPTION).

## Clean-up
- Delete every QA-AUTO- notice in BP Web (also the delayed alert, before it fires).
- Restore the notification permission.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 69 to 84. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Rules by design: a Perform a test only alert sends no push but still shows in the list (row 73). An alert with a later time frame pushes when the time frame starts, not when posted (row 74).
- Known gap: row 79 (two notices in quick succession) gives no timing; the run posts both within the same minute (ASSUMPTION).
- Refined 2026-11-26: split compound Expected lines, added a step to tap the push after the closed-app check, split the deny-permission row into deny, post and refresh, added a step to allow the permission again (ASSUMPTION), added a step to post for the old school so that the no-push-for-old-school check is observable, marked every push check with (needs:), added the real-parent-email and QA-test-client preconditions.
- Row 71: the general notice is proved for one subscription only (one device, one subscription).
- Refined 2026-11-26 (after review): Review fixes: ui channel, professional role and ui 'notice saved' lines before every no-push check, dependency on DLY-REG-014, push timings 2 and 5 minutes (ASSUMPTION), refresh step after the test-only post, wait step for the delayed alert, split handled-in-app and no-crash, two-school subscription, resources (device name is an ASSUMPTION), clean-up.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
