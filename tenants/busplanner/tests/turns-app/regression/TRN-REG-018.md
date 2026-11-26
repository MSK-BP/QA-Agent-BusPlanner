---
id: TRN-REG-018
title: Turns - Localization
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!144-146]
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
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).

## Steps
1. Set the device language to French, open the app, then open Route Selection and start a run.
2. Open each page and look for untranslated or clipped strings.
3. Set the device language back to English, open the app, then open Route Selection and start a run.

## Expected (each line must be checkable)
- E1 (step 1, device): The UI strings display in French (ASSUMPTION: the app follows the device language).
- E2 (step 1, device): The run labels and the field labels display in French (ASSUMPTION: the app follows the device language).
- E3 (step 1, device): The stop labels and the field labels display in French (ASSUMPTION: the app follows the device language).
- E4 (step 2, device): No page shows raw English where the French resource file in the Apps repo has a translation.
- E5 (step 2, device): No page shows clipped text.
- E6 (step 3, device): The UI returns to English.
- E7 (step 3, device): No string is missing.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 144 to 146. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Localization: steps name the action, E lines split.
- Refined 2026-11-26 (review fixes): step 1 reaches Route Selection and a run, E4 oracle is the French resource file in the Apps repo, field labels and device-language ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
