---
id: CHP-REG-004
title: Chipmunk - Help
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!42-44]
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

## Steps
1. From Home, tap the help button.
2. On Help, tap Send feedback.
3. Open the Help page again from Home, then tap Close.

## Expected (each line must be checkable)
- E1 (step 1, device): The Help page shows a list of questions and answers.
- E2 (step 1, device): The Q&A list is the Home help list (ASSUMPTION: no reference text).
- E3 (step 1, device): The Send feedback button shows on the Help page.
- E4 (step 1, device): The Close button shows on the Help page.
- E5 (step 2, device): The Send feedback page opens.
- E6 (step 3, device): The Home page shows.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 42 to 44. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; no data is sent in this case so no extra precondition.
- Review fixes 2026-11-26: step 1 starts from Home; context line names the Home help list (ASSUMPTION); Close returns to Home; roles, resources and depends-on updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
