---
id: DLY-REG-011
title: Delays - Localization
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!85-87]
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
- The QA test client's district language is French or Spanish (ASSUMPTION).
- Setup is completed with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes; the Notifications screen is open.
- One QA-AUTO- notice dated today exists (needs: one QA-AUTO- notice today).

## Steps
1. Switch the device language to French or Spanish (whichever the district has).
2. Open each page of the app in that language and look for raw resource keys or clipped text (ASSUMPTION).
3. Switch the device language back to English.
4. Open each page of the app in English and look for raw resource keys or clipped text.

## Expected (each line must be checkable)
- E1 (step 1, device): The app UI text shows in the chosen language.
- E2 (step 1, device): The notification text shows in the chosen language (needs: one QA-AUTO- notice today).
- E3 (step 2, device): No page shows a raw resource key or clipped text. English text is acceptable where no translation exists.
- E4 (step 3, device): The app UI text returns to English.
- E5 (step 4, device): No page shows a raw resource key or clipped text.
- E6 (step 4, device): No string is missing.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.
- Set the device language to English.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 85 to 87. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: split compound Expected lines, split the raw-key check into the translated and the English language because the sheet note about missing translations implies the translated language is checked (ASSUMPTION), added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: removed the dependency on DLY-REG-001, start state, notice needs marker, the missing-string check moved to step 4, clean-up resets the language, resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
