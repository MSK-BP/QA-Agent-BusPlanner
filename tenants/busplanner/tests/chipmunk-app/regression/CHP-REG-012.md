---
id: CHP-REG-012
title: Chipmunk - Add Student
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!92-94]
channels: [device]
roles: [chipmunk-parent]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [data:QA1-chipmunk-parent]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Signed in with the QA parent account (credentials file).
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact. The student used is a QA-AUTO- test student of the QA test client.
- The Student ID, birth date, school and home street number of that test student are known.

## Steps
1. From My Students, tap add student.
2. On Add student, tap Add student with empty or invalid fields.
3. On Add student, enter valid values for the test student and tap Add student.
4. Open Add student again, then tap Cancel.

## Expected (each line must be checkable)
- E1 (step 1, device): The page shows inputs for Student ID, Birth date, School and Home street number.
- E2 (step 1, device): The Add student and Cancel buttons show.
- E3 (step 1, device): The help button shows on the toolbar.
- E4 (step 2, device): The app rejects the empty or invalid fields and shows a message (ASSUMPTION).
- E5 (step 3, device): The new student shows on My Students (ASSUMPTION).
- E6 (step 3, device): My Students shows.
- E7 (step 4, device): My Students shows.

## Clean-up
- Remove the test student's link to the QA parent account in BP Web (needs: confirm where to unlink).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 92 to 94. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; invalid then valid input split (invalid case marked ASSUMPTION); QA test client and test student precondition added; typo previus fixed.
- Review fixes 2026-11-26: steps start from My Students; the 'sends request' line was replaced by the new student showing on My Students (ASSUMPTION); return lines name My Students; Cancel step opens Add student again; clean-up unlinks the student; resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
