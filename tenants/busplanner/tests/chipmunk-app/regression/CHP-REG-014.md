---
id: CHP-REG-014
title: Chipmunk - Chipmunk Assistant
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!111-114]
channels: [device]
roles: [chipmunk-parent]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [data:QA1-chipmunk-client-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Signed in with the QA parent account (credentials file).
- Steps 1 and 3 to 5 need a test client with Chipmunk_ChatbaseURL set. Step 2 needs a test client with Chipmunk_ChatbaseURL empty. The chatbot URL is a QA test URL, not a real district chatbot (ASSUMPTION).
- The chatbot is billable. Do not type in it.

## Steps
1. Open the app signed in to a test client that has Chipmunk_ChatbaseURL set. Look at the burger menu, the Help page and the ETA, Map, My Students and Alerts pages.
2. Open the app signed in to a test client that has Chipmunk_ChatbaseURL empty. Look at the same pages.
3. On the client with the URL set, tap Chipmunk Assistant in the burger menu. Do not type in the chatbot.
4. In the chatbot browser, tap the close button.
5. Repeat steps 3 and 4 for the Ask Chipmunk Assistant card on Help and for the assistant button on a page.

## Expected (each line must be checkable)
- E1 (step 1, device): The burger menu shows a Chipmunk Assistant item.
- E2 (step 1, device): The top of the Help page shows an Ask Chipmunk Assistant card.
- E3 (step 1, device): The ETA page shows an assistant button above the refresh button.
- E4 (step 1, device): The Map page shows an assistant button above the refresh button.
- E5 (step 1, device): The My Students page shows an assistant button above the refresh button.
- E6 (step 1, device): The Alerts page shows an assistant button above the refresh button.
- E7 (step 2, device): The app hides every Chipmunk Assistant entry point.
- E8 (step 3, device): The in-app browser opens the district's chatbot.
- E9 (step 3, device): The URL equals Chipmunk_ChatbaseURL.
- E10 (step 3, device): The in-app browser title is Chipmunk Assistant.
- E11 (step 3, device): The in-app browser shows a close button.
- E12 (step 4, device): The assistant closes.
- E13 (step 4, device): The app returns to the page that opened the assistant.
- E14 (step 5, device): Each entry point opens the chatbot and closes it again on the page that opened it.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 111 to 114. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps now name the pages to check; compound expected lines split; step 3 covers the three entry points (run each one); chatbot test URL precondition added (ASSUMPTION).
- Review fixes 2026-11-26: step 3 says not to type in the chatbot (billable); step 5 repeats for every entry point; URL line added; return line names the page; resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
