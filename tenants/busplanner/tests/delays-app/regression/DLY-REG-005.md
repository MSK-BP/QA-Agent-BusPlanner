---
id: DLY-REG-005
title: Delays - Notifications
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!33-48]
channels: [device, ui]
roles: [professional]
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: [DLY-REG-014]
resources: [device:QA-Phone-Pixel8-API36, browser, data:qa1-delays-notices, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- DLY-REG-014 passed today.
- Setup is completed with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes; the Notifications screen is open.
- Notices are posted in BP Web for the QA test client only, as the steps say. Each comment starts with QA-AUTO-<initials>- (ASSUMPTION). Steps that post or delete in BP Web need a browser session signed in as professional.

## Steps
1. Complete setup and land on the Notifications screen.
2. Open the Notifications screen when no notification exists for the subscription.
3. After a bus notification is posted in BP Web for a subscribed route, open the Notifications screen.
4. After a school notification is posted in BP Web for a subscribed school, open the Notifications screen.
5. After a general notice is posted in BP Web, open the Notifications screen.
6. After a notification is posted in BP Web for a route you are NOT subscribed to, open the Notifications screen.
7. With a notification dated yesterday in BP Web (needs: a QA-AUTO- notice dated yesterday; BP Web back-dating unconfirmed), open the Notifications screen.
8. After a notification flagged as Test is posted in BP Web, open the Notifications screen.
9. Tap the refresh button.
10. Turn the emulator network off and tap the refresh button.
11. Turn the emulator network on.
12. Pull the list down to refresh (if the app supports it).
13. Scroll a long notification list (needs: at least 20 notices today) (ASSUMPTION).
14. Tap a notification in the list.
15. Dismiss the notification detail.
16. Send the app to the background, then bring it to the foreground.
17. With the app open, post a new notification in BP Web.
18. Tap the refresh button.
19. In BP Web, clear or delete a notification.
20. Tap the refresh button.

## Expected (each line must be checkable)
- E1 (step 1, device): The header shows the app name.
- E2 (step 1, device): The header shows the authority.
- E3 (step 1, device): The header shows Last Updated with a time.
- E4 (step 2, device): The screen shows 'No notifications available.'
- E5 (step 2, device): The screen shows no spinner.
- E6 (step 2, device): The screen shows no error.
- E7 (step 3, ui): BP Web lists the QA-AUTO- notice for the subscribed route.
- E8 (step 3, device): The notification appears in the list.
- E9 (step 3, device): The notification shows the route.
- E10 (step 3, device): The notification shows the message type.
- E11 (step 3, device): The notification shows the reason.
- E12 (step 3, device): The notification shows the comment.
- E13 (step 4, ui): BP Web lists the QA-AUTO- notice for the subscribed school.
- E14 (step 4, device): The school notification appears in the list.
- E15 (step 5, ui): BP Web lists the QA-AUTO- general notice.
- E16 (step 5, device): The general notice appears, whatever the school or route of the subscription.
- E17 (step 6, ui): BP Web lists the QA-AUTO- notice for the unsubscribed route.
- E18 (step 6, device): The notification for the unsubscribed route does not appear.
- E19 (step 7, ui): BP Web lists the QA-AUTO- notice dated yesterday (needs: a QA-AUTO- notice dated yesterday; BP Web back-dating unconfirmed).
- E20 (step 7, device): The notification dated yesterday does not appear (today-only filter) (needs: a QA-AUTO- notice dated yesterday; BP Web back-dating unconfirmed).
- E21 (step 8, ui): BP Web lists the QA-AUTO- notice flagged as Test.
- E22 (step 8, device): The notification flagged as Test appears in the list.
- E23 (step 9, device): The list refreshes.
- E24 (step 9, device): Last Updated is within 1 minute of the device clock (ASSUMPTION).
- E25 (step 10, device): A clear offline message is shown.
- E26 (step 10, device): The previously loaded list stays visible.
- E27 (step 10, device): The app does not crash.
- E28 (step 12, device): Pull to refresh refreshes the list and advances Last Updated, like the refresh button.
- E29 (step 13, device): Scrolling is smooth (needs: a person's judgement) (needs: at least 20 notices today) (ASSUMPTION).
- E30 (step 13, device): The list shows no blank rows (needs: at least 20 notices today) (ASSUMPTION).
- E31 (step 13, device): The list shows no duplicated entries (needs: at least 20 notices today) (ASSUMPTION).
- E32 (step 14, device): The full notification detail is readable.
- E33 (step 15, device): The detail closes and the list is shown.
- E34 (step 16, device): The app shows the Notifications list again, kept or refreshed.
- E35 (step 16, device): The app does not crash.
- E36 (step 16, device): The list shows no duplicate rows.
- E37 (step 17, ui): BP Web lists the new QA-AUTO- notice.
- E38 (step 18, device): The new notification appears in the list.
- E39 (step 19, ui): BP Web no longer lists the deleted notice.
- E40 (step 20, device): The deleted notification disappears from the list.

## Clean-up
- In BP Web, delete every QA-AUTO- notice the case posted.
- Turn the network on.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 33 to 48. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Known gap: steps 3 to 8, 16 and 18 act in BP Web, which needs a browser session. The front matter channel list (device only) does not show it.
- Refined 2026-11-26: split compound Expected lines, split the post-then-refresh and delete-then-refresh rows into a BP Web step and a refresh step, added a step to dismiss the detail, made each data row an open-the-screen step with its data state, added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: added ui channel, professional role and ui Expected lines for BP Web, dependency on DLY-REG-014, network-on step, needs markers for yesterday and long-list rows, 1-minute Last Updated check (ASSUMPTION), start state, resources. Rows 37 and 71: the general notice is proved for one subscription only.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
