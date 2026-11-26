---
id: TRN-REG-003
title: Turns - Pre & Post Inspections (if enabled)
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!15-15]
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
- The feature named in the title is enabled for the test client.
- An outdated form exists on the device: edit a form template in Quick - Forms after the device last downloaded it (needs: a server write in Quick - Forms; named go-ahead for this run).
- A pending form exists on the device: submit a form while the device is offline (needs: offline submission; the upload writes through BP Info).

## Steps
1. On the Menu page, tap Pre & Post Inspections, with one form missing, one form outdated, and one completed form pending upload (needs: named go-ahead for this run, writes through BP Info).

## Expected (each line must be checkable)
- E1 (step 1, device): The Pre & Post Inspections page downloads the missing forms (needs: named go-ahead for this run, writes through BP Info).
- E2 (step 1, device): The Pre & Post Inspections page downloads the outdated forms (needs: named go-ahead for this run, writes through BP Info).
- E3 (step 1, device): The Pre & Post Inspections page shows the forms by group (needs: named go-ahead for this run, writes through BP Info).
- E4 (step 1, device): The pending-upload indicator for the form clears (needs: named go-ahead, writes through BP Info).

## Clean-up
- Remove the uploaded form result and the template edit in Quick - Forms (no QA-AUTO- prefix; find them by driver name and time).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 15 to 15. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Inspections: one step with context, compound E split into four lines.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Refined 2026-11-26 (second review): step 1 names the three form states, preconditions for outdated and pending forms, BP Info write marker on step and E lines.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
