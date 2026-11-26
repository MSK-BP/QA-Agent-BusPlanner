---
id: CHP-REG-017
title: Chipmunk - Localization
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!125-125]
channels: [device]
roles: [chipmunk-parent]
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
- Signed in with the QA parent account (credentials file).

## Steps
1. Switch the device language to French, then start the app and open each of these pages: Setup, Login, Create account, Password reset, Set password, Map, ETA, My Students, Alerts, Settings, Help, Feedback, Student info, Radius edit, Add student and Message Transportation.

## Expected (each line must be checkable)
- E1 (step 1, device): The UI text shows in French on each page.
- E2 (step 1, device): No text is clipped on any page.

## Clean-up
- Switch the device language back to English.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 125 to 125. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: step names the pages to open; compound expected line split.
- Review fixes 2026-11-26: pages listed; clean-up switches the language back to English.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
