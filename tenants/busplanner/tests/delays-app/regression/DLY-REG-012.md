---
id: DLY-REG-012
title: Delays - Device / layout
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!88-94]
channels: [device]
roles: []
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36, device:QA-Tablet-PixelTablet-API36, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- Setup is completed with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes; the Notifications screen is open.
- The Pick Notification Type screen is reached through the reset in DLY-REG-007 (ASSUMPTION).

## Steps
1. Rotate the device on each page (the authority, Schools, Routes, Notifications, About and Pick Notification Type screens).
2. Open each page on a notched device and check the safe areas.
3. On Android 16, check the top and the bottom of each page.
4. On Android 15, check the top and the bottom of each page.
5. Use the Android back button or the back gesture on each page.
6. Increase the system font size and open each page.
7. Run the app on a tablet form factor.
8. Switch the device to dark mode and open each page (if the app supports dark mode).

## Expected (each line must be checkable)
- E1 (step 1, device): The layout reflows on each page.
- E2 (step 1, device): Nothing is clipped or overlapped.
- E3 (step 1, device): The Chosen schools list stays visible in iPhone landscape (needs: an iPhone).
- E4 (step 2, device): No content sits under the status bar (checked on the Pixel 8 cutout; iPhone needs: an iPhone).
- E5 (step 2, device): No content sits under the home indicator (needs: a notched iPhone).
- E6 (step 3, device): Nothing is hidden under the status bar.
- E7 (step 3, device): Nothing is hidden under the navigation bar.
- E8 (step 4, device): Nothing is hidden under the status bar (needs: an Android 15 image).
- E9 (step 4, device): Nothing is hidden under the navigation bar (needs: an Android 15 image).
- E10 (step 5, device): Back goes back one page each time.
- E11 (step 5, device): Back skips no page.
- E12 (step 5, device): The app does not get stuck on a page.
- E13 (step 6, device): Text scales without clipping.
- E14 (step 6, device): Text scales without overlap.
- E15 (step 7, device): The layout is usable and not a stretched phone layout (needs: a person's judgement).
- E16 (step 8, device): Colours and contrast keep the text and controls legible (needs: a person's judgement).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.
- Reset font scale, dark mode and auto-rotate.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 88 to 94. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Known issue: ENG-2718. On iPhone in landscape the Chosen schools list is hidden. The iPhone landscape E line states the correct behaviour, so it fails until the bug is fixed.
- Refined 2026-11-26: split compound Expected lines, split the Android 15 and 16 row into two steps (the emulators run Android 11 and 16, so Android 15 needs an image), marked the iPhone checks with (needs:), added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: removed the dependency on DLY-REG-001, page list defined, cutout wording, person-judgement markers, phone and tablet resources, clean-up resets the device settings.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
