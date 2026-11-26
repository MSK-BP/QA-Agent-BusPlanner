---
id: DLY-REG-009
title: Delays - Push notifications - setup
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!67]
channels: [device]
roles: []
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: []
resources: [device:real-device-1, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on a real device, from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- A real device (not an emulator) with a TestFlight build or a release APK is available, with push notifications.
- Setup is open on a fresh install.

## Steps
1. On a real device (TestFlight build or release APK), complete Setup and allow notifications.

## Expected (each line must be checkable)
- E1 (step 1, device): Setup completes with the notification permission allowed (needs: a real device with a TestFlight build or release APK).
- E2 (step 1, device): The device is ready to receive pushes for the chosen schools and routes (needs: a real device with a TestFlight build or release APK).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 67 to 68. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Row 68 (no real parent emails in the database) moved to DLY-REG-014, which DLY-REG-005 and DLY-REG-010 now depend on.
- Refined 2026-11-26: split the two checks of step 1, added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: real device precondition, removed the adb clean-up line, moved the database check to DLY-REG-014, removed the dependency on DLY-REG-001, resources (device name is an ASSUMPTION).
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
