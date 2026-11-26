---
id: DLY-REG-001
title: Delays - Initial checks
module: delays-app
flow: regression
ticket:
priority: P1
spec: [sheet:Delays!3-7]
channels: [device]
roles: []
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- Steps 1, 5 and 8 start with no app data (uninstall, or clear the app data).
- The previous release APK is available for step 2 (needs: previous release APK).

## Steps
1. Uninstall any set-up install, then install the app fresh and launch it.
2. Install the previous release APK (needs: previous release APK) and complete Setup with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes.
3. Install the test build over the installed version and launch it.
4. Tap the tools (wrench) icon.
5. Clear app data and launch the app.
6. Tap Allow at the notification permission prompt.
7. Relaunch the app.
8. Clear app data and launch the app.
9. Tap Deny at the notification permission prompt.
10. Complete Setup with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes.
11. Turn the emulator network off and launch the app.
12. Turn the emulator network on.

## Expected (each line must be checkable)
- E1 (step 1, device): The Splash screen appears.
- E2 (step 1, device): The Welcome screen appears after the Splash screen.
- E3 (step 1, device): The Setup screen appears after the Welcome screen.
- E4 (step 1, device): The app shows no state from a previous install.
- E5 (step 3, device): The app launches straight to the Notifications screen.
- E6 (step 4, device): The wrench Setup shows the same authority, schools and routes as before the update.
- E7 (step 5, device): The notification permission prompt appears once.
- E8 (step 7, device): No notification permission prompt appears.
- E9 (step 9, device): The app stays usable after the permission is denied.
- E10 (step 9, device): The app does not crash.
- E11 (step 10, device): The notification list loads.
- E12 (step 11, device): The app shows a clear message that the network is unavailable.
- E13 (step 11, device): The app does not crash.
- E14 (step 11, device): The app shows no indefinite spinner.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 3 to 8. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: split the compound Expected lines (Splash, Welcome, Setup; offline message, crash, spinner), split the oldest-OS row into an iOS 13 step and an Android 5 step with (needs:) markers, added the QA-test-client precondition and the fresh-install and saved-subscription preconditions (ASSUMPTION).
- Refined 2026-11-26 (after review): Review fixes: removed iOS 13 and Android 5 steps (now DLY-REG-013), added uninstall, previous-release install and wrench check, clear-data steps before Allow and Deny, a relaunch with no second prompt, and network on at the end; set resources; set no dependency.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
