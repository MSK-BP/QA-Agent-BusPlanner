---
id: TRN-REG-006
title: Turns - Alias - Clock in & Out
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!42-58]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [device, data:qa1-turns-ta-employee]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Time & Attendance is enabled. A test employee id and PIN exist, and the employee is clocked out. A second test employee exists for the lockout step.

## Steps
1. On the Pin authentication page, type an employee id with a wrong PIN and submit.
2. On the Pin authentication page, submit wrong PINs for a second test employee until that employee is locked out.
3. On the Pin authentication page, type a correct employee id and PIN, then submit.
4. On the Clock In page, wait for the page to load.
5. On the Clock In page, select a job that requires a vehicle.
6. On the Clock In page, select a job that does not require a vehicle.
7. On the Clock In page, select a vehicle.
8. On the Clock In page, tap Clock in.
9. On the Clock In page, tap Main Menu.
10. On the Menu page, tap Time & Attendance and enter the same PIN.
11. On the Clock In page, tap Change Jobs.
12. On the Job Change page, wait for the page to load.
13. On the Job Change page, select a job that requires a vehicle.
14. On the Job Change page, select a job that does not require a vehicle.
15. On the Job Change page, select a vehicle.
16. On the Job Change page, tap Change Jobs.
17. On the Job Change page, tap Clock Out.
18. In the clock out confirmation, tap Cancel.
19. On the Job Change page, tap Clock Out, then confirm.
20. Clock in again, then wait for the token to expire (needs: token lifetime from the BPU backend).

## Expected (each line must be checkable)
- E1 (step 1, device): The Pin authentication page shows an error.
- E2 (step 1, device): The error says that the employee id or PIN does not match the database.
- E3 (step 2, device): The Pin authentication page says the employee is locked out.
- E4 (step 2, device): The message does not say that the server cannot be reached (known issue ENG-2712).
- E5 (step 3, device): The Clock In page opens if the employee is clocked out.
- E6 (step 3, device): The Job Change page opens if the employee is clocked in.
- E7 (step 4, device): The Clock In page shows a job selector.
- E8 (step 4, device): The Clock In page shows a vehicle selector.
- E9 (step 4, device): The Clock In page shows the latest clock in data (if available).
- E10 (step 5, device): The Clock in button stays disabled until a vehicle is selected.
- E11 (step 6, device): The Clock in button is enabled.
- E12 (step 7, device): The Clock in button is enabled if a job is selected.
- E13 (step 8, device): The page shows the current clock in status.
- E14 (step 9, device): The Main Menu page opens.
- E15 (step 11, device): The Job Change page opens.
- E16 (step 12, device): The Job Change page shows the current clock in status.
- E17 (step 12, device): The Job Change page shows a job selection.
- E18 (step 12, device): The Job Change page shows a vehicle selection.
- E19 (step 13, device): The Change Jobs button stays disabled until a vehicle is selected.
- E20 (step 14, device): The Change Jobs button is enabled.
- E21 (step 15, device): The Change Jobs button is enabled if a job is selected.
- E22 (step 16, device): The current clock in status changes to the new job.
- E23 (step 16, device): The employee stays clocked in.
- E24 (step 17, device): The app shows a confirmation to clock out.
- E25 (step 18, device): The app goes back to the same page as before.
- E26 (step 18, device): The page shows the same state as before.
- E27 (step 19, device): The Main Menu page opens.
- E28 (step 20, device): The Pin authentication page opens (needs: token lifetime from the BPU backend).

## Clean-up
- Unlock the second test employee in BP Web (employee lockout). Clock out the first test employee.
- Delete the clock records from this case in BP Web Time & Attendance (no QA-AUTO- prefix; find them by employee and time).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 42 to 58. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Clock in & out: steps name the screen and action, E lines split, typos and the stray bracket fixed.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Refined 2026-11-26 (second review): second employee for the lockout, Main Menu step moved before Change Jobs with re-entry through Time & Attendance, job selection split (needs a vehicle, needs none), token step starts with a new clock in (needs: token lifetime), preconditions, cleanup, resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
