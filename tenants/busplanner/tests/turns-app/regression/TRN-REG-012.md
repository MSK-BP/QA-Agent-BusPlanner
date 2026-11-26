---
id: TRN-REG-012
title: Turns - Navigation - Ridership - Run History and Scan off (if enabled)
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!100-108]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [data:qa1-turns-route]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- The feature named in the title is enabled for the test client.
- A run is in progress in Turns Navigation. Scan confirmation is enabled. The run has a school drop-off stop with one student scanned once and one student not scanned. The run has an unknown student with one scan.
- Scans write through BPInfo (`SubmitScan`). Dev and staging may point at production BPInfo, so run the scan steps only with a named go-ahead for BPInfo scan writes.

## Steps
1. Scan a student card on the Bus Stop page, with a good card read, then open Route Review.
2. On the Bus Stop page, tap Scan on a student row (if scan confirmation is enabled).
3. In the scan confirmation, tap Confirm.
4. On the Bus Stop page, tap Scan on another student row, then tap Cancel.
5. Present a bad card read: send an unreadable or malformed card string to the card reader input (ASSUMPTION: a damaged card on a real reader, or a malformed string on the emulator).
6. With the device offline, scan a student.
7. Put the device back online.
8. On the Bus Stop page, type the manual ID of a student who is not on the run.
9. On the Bus Stop page, type the same ID again.
10. Open the Bus Stop page of a stop.
11. Open the Bus Stop page of a school drop-off stop.
12. On the school drop-off Bus Stop page, tap Scan Off ALL.
13. On the Bus Stop page of the last stop, with unknown or unplanned students who have only one scan, tap Scan Off ALL.
14. On the Bus Stop page, tap Review Route.
15. On the Route Review page, wait for the page to load.
16. On the Route Review page, turn on the show all expected students switch.

## Expected (each line must be checkable)
- E1 (step 1, device): Route Review shows the student with a scan at the current time (needs: card reader, or `adb shell input text` + Enter, UNVERIFIED; needs: named go-ahead for BPInfo scan writes).
- E2 (step 2, device): The confirmation shows the student's photo.
- E3 (step 2, device): The confirmation shows the student's name.
- E4 (step 2, device): The confirmation shows the student's grade.
- E5 (step 2, device): The confirmation shows Met at Bus.
- E6 (step 3, device): The student row shows the scanned status (needs: named go-ahead for BPInfo scan writes).
- E7 (step 4, device): The app does not scan the student.
- E8 (step 5, device): The app plays a sound (needs: card reader, or `adb shell input text` + Enter, UNVERIFIED; needs: named go-ahead for BPInfo scan writes).
- E9 (step 5, device): The app saves no scan (needs: card reader, or `adb shell input text` + Enter, UNVERIFIED; needs: named go-ahead for BPInfo scan writes).
- E10 (step 6, device): The scan that cannot be sent shows as pending in the student row (ASSUMPTION) (needs: named go-ahead for BPInfo scan writes).
- E11 (step 7, device): The app sends the pending scan within 60 s (Apps.md, SyncService) (needs: named go-ahead for BPInfo scan writes).
- E12 (step 8, device): The app shows No Match.
- E13 (step 8, device): The app adds nothing to the run.
- E14 (step 9, device): The Bus Stop page accepts the same ID again (known issue ENG-2692: may fail; classify as known).
- E15 (step 10, device): The Bus Stop page shows a Review Route button.
- E16 (step 11, device): The Bus Stop page shows a Scan Off ALL button.
- E17 (step 12, device): The app scans off the students that belong to this stop and scanned at least once before (needs: named go-ahead for BPInfo scan writes).
- E18 (step 12, device): A student of this stop with no earlier scan is not scanned off.
- E19 (step 13, device): The app scans off the unknown and unplanned students who have only one scan (needs: named go-ahead for BPInfo scan writes).
- E20 (step 14, device): The Route Review page opens.
- E21 (step 15, device): The Route Review page shows the status of the run.
- E22 (step 15, device): The Route Review page shows only the scanned students.
- E23 (step 15, device): Each student shows a name.
- E24 (step 15, device): Each student shows a grade.
- E25 (step 15, device): Each student shows a pick up location.
- E26 (step 15, device): Each student shows a drop off location.
- E27 (step 15, device): A student who does not belong to the route shows an unknown location.
- E28 (step 15, device): Each student shows the school the student belongs to.
- E29 (step 15, device): Each student shows a status.
- E30 (step 15, device): Each student shows a list of scans with time and location.
- E31 (step 16, device): The Route Review page shows the status of the run.
- E32 (step 16, device): The Route Review page shows all expected students and the scanned students.
- E33 (step 16, device): Each student shows a name.
- E34 (step 16, device): Each student shows a grade.
- E35 (step 16, device): Each student shows a pick up location.
- E36 (step 16, device): Each student shows a drop off location.
- E37 (step 16, device): A student who does not belong to the route shows an unknown location.
- E38 (step 16, device): Each student shows the school the student belongs to.
- E39 (step 16, device): Each student shows a status.
- E40 (step 16, device): Each student shows a list of scans with time and location.

## Clean-up
- Scans are recorded by student ID and cannot carry QA-AUTO-. Write the scanned student IDs, the run and the time in the run report. Ask the BPInfo owner to remove those test scans, because the app cannot delete them.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 100 to 108. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- The good and bad card read steps need a physical card reader; manual ID entry works on the emulator.
- Refined 2026-11-26: Ridership: steps split to one action (confirm, cancel, offline, restore), E lines split per field, card reader steps marked, typos fixed.
- Row 99 refers to an unnamed Ridership test file; ask the sheet owner for it.
- Naming: the sheet calls the page "Review Route page" in rows 106 to 108; the app calls it Route Review (row 75). This case uses Route Review for the page and keeps the sheet label "Review Route" for the button.
- Refined 2026-11-26 (review fixes): BPInfo write markers, preconditions, resources, card reader marker, bad read how-to, extra E (no earlier scan not scanned off), E1/E6/E10/E11 wording, ENG-2692 wording, cleanup, one term Route Review.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
