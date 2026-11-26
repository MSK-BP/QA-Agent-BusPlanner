---
id: CHP-REG-015
title: Chipmunk - Message Transportation
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!116-119]
channels: [device, ui]
roles: [chipmunk-parent, professional]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [data:QA1-chipmunk-parent, data:QA1-chipmunk-client-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Signed in with the QA parent account (credentials file).
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact. The message sent in step 3 is a QA-AUTO- text to the QA test client. It reaches no real transportation staff.
- Confirm that message alerts of the QA client go to QA only (needs: confirmation).
- Signed in to BP Web as role professional (credentials file) on the same QA client, for steps 4 and 5.
- Step 1 needs a test client with ChipmunkParentMessages on. Step 2 needs a client with it off.

## Steps
1. As chipmunk-parent, open the app signed in to a test client with ChipmunkParentMessages on. Open the burger menu and the Message Transportation page.
2. As chipmunk-parent, open the app signed in to a test client with ChipmunkParentMessages off. Open the burger menu.
3. As chipmunk-parent, on Message Transportation, tap send with no student picked, then pick a student, enter a QA-AUTO- message and tap send.
4. As professional, in BP Web, open Subscription Service > Chipmunk Message Manager.
5. As professional, in BP Web, acknowledge the QA-AUTO- message.
6. As chipmunk-parent, in the app, reopen Message Transportation.

## Expected (each line must be checkable)
- E1 (step 1, device): The burger menu shows Message Transportation.
- E2 (step 1, device): The Message Transportation page shows a student picker.
- E3 (step 1, device): The page shows the previous messages.
- E4 (step 1, device): The page shows a message box.
- E5 (step 2, device): The burger menu does not show Message Transportation.
- E6 (step 3, device): The app asks for a student when no student is picked.
- E7 (step 3, device): The message shows in the list with its sent time.
- E8 (step 4, ui): The message shows in Chipmunk Message Manager (needs: BP Web session)
- E9 (step 6, device): The message shows as acknowledged.

## Clean-up
- Delete the QA-AUTO- message in BP Web, or ask the QA client owner to remove it (needs: confirm how).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 116 to 119. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; BP Web check marked needs; QA client and QA-AUTO- message precondition added; clean-up line for the message added.
- Review fixes 2026-11-26: channels and roles now include ui and professional; BP Web lines use ui; step 4 split into open Message Manager, acknowledge in BP Web, and reopen in the app; 'app sends the message' line deleted; QA-only alert precondition; resources updated.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
