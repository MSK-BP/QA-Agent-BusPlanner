---
id: CHP-REG-003
title: Chipmunk - Feedback form
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!33-40]
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
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact.
- Confirm that QA client feedback goes to a QA-owned inbox (needs: confirmation).
- The student, time and contact email used in the form are QA-AUTO- values.

## Steps
1. Open Send feedback from the Home burger menu.
2. Select the category Creating/Managing Account, then Password Reset, Crashing Freezing, App Functionality, Rating, and Other, one at a time.
3. Select the category Push Notifications, then ETAs, one at a time.
4. Select the category My Students.
5. Enable the Permission to contact switch.
6. Tap Submit feedback with the form incomplete.
7. Fill the form with QA-AUTO- values and tap Submit feedback.
8. Open the Feedback form again from Home and tap Cancel.

## Expected (each line must be checkable)
- E1 (step 1, device): The Feedback form shows a category picker.
- E2 (step 2, device): The Permission to contact field shows for each of these categories.
- E3 (step 2, device): The feedback text field shows for each of these categories.
- E4 (step 2, device): The Submit feedback and Cancel buttons show for each of these categories.
- E5 (step 3, device): The Student field shows for each of these categories.
- E6 (step 3, device): The Time field shows for each of these categories.
- E7 (step 3, device): The Permission to contact and feedback text fields show for each of these categories.
- E8 (step 3, device): The Submit feedback and Cancel buttons show for each of these categories.
- E9 (step 4, device): The Student field shows.
- E10 (step 4, device): The Permission to contact and feedback text fields show.
- E11 (step 4, device): The Submit feedback and Cancel buttons show.
- E12 (step 5, device): An extra field for the contact email shows.
- E13 (step 6, device): The app rejects the incomplete form and shows a message (ASSUMPTION).
- E14 (step 7, device): A message says that the feedback was sent (ASSUMPTION) (needs: confirmation that the QA inbox is QA-owned).
- E15 (step 8, device): The Home page shows.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 33 to 40. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten as single actions; compound expected lines split; invalid then valid submit split (invalid case marked ASSUMPTION); QA test client and QA-AUTO- data precondition added.
- Review fixes 2026-11-26: the generic category-selection line was deleted (covered by the category lines); steps now start from the Home burger menu; submit result is visible and marked needs; QA inbox precondition added; Cancel now returns to Home; depends-on cleared; role added (case starts from Home).
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
