---
id: TRN-REG-004
title: Turns - Alias - Form Module
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!16-39]
channels: [device, ui]
roles: [professional]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [device, data:qa1-turns-inspection-forms]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Pre & Post Inspections is enabled. A form template has Information, Number, Text and Picklist items, mandatory and optional items, groups, vehicle selection, and minor and major fault items. Some submissions are older than 5 days.
- The Quick - Forms checks use BP Web or Quick on QA1, signed in as a professional.

## Steps
1. On the Pre & Post Inspections page, start a form.
2. Complete a form, then return to the Pre & Post Inspections page (needs: named go-ahead for this run, writes through BP Info).
3. With the device offline, complete a form, then return to the Pre & Post Inspections page (needs: named go-ahead for this run, writes through BP Info).
4. On the Pre & Post Inspections page, tap the History button.
5. On the Form History page, wait for the page to load.
6. On the Form History page, tap Show all submissions.
7. On the Pre & Post Inspections page, tap Review last completed (or Review on a form in the Form History page).
8. Start a form for which the vehicle selection is enabled. On the Vehicle selection page, select one vehicle and tap Done.
9. On the Question page, wait for the page to load.
10. On the Question page, open an Information type question.
11. On the Question page, open a Number type question, tap the input and type a value.
12. On the Question page, open a Text type question, tap the input and type a value.
13. On the Question page, open a Picklist type question, tap the input and select a value.
14. On the Question page, tap Back.
15. On the Question page, open the question list.
16. In the question list, tap an item, then go back and forth between items.
17. On the Question page, rotate the device.
18. On the Question page, leave a mandatory question empty.
19. On the Question page, fill all mandatory questions.
20. On the Question page, tap Submit (needs: named go-ahead for this run, writes through BP Info).
21. On the Result page, wait for the page to load.
22. On the Result page, tap Close.
23. With the device offline, submit a form, then tap Try again on the Result page (needs: named go-ahead for this run, writes through BP Info).
24. Restore the network, then tap Try again (needs: named go-ahead for this run, writes through BP Info).
25. Submit a form with a minor fault reported (if enabled) (needs: named go-ahead for this run, writes through BP Info).
26. Submit a form with a major fault reported (needs: named go-ahead for this run, writes through BP Info).

## Expected (each line must be checkable)
- E1 (step 1, device): The Question page opens.
- E2 (step 1, device): The Question page loads the form that was started.
- E3 (step 2, device): The Pre & Post Inspections page shows the latest completed form (needs: named go-ahead for this run, writes through BP Info).
- E4 (step 2, device): The Pre & Post Inspections page shows the status of the latest completed form (needs: named go-ahead for this run, writes through BP Info).
- E5 (step 3, device): The Pre & Post Inspections page shows the pending forms to upload (needs: named go-ahead for this run, writes through BP Info).
- E6 (step 3, device): The Pre & Post Inspections page shows a button to upload the pending forms manually (needs: named go-ahead for this run, writes through BP Info).
- E7 (step 4, device): The Form History page opens.
- E8 (step 5, device): The Form History page lists the forms submitted in the past 5 days.
- E9 (step 6, device): The Form History page lists all completed forms.
- E10 (step 6, device): The Form History page orders the forms by date.
- E11 (step 7, device): The Question page opens.
- E12 (step 7, device): The Question page loads the right form.
- E13 (step 7, device): The Question page shows the form prefilled.
- E14 (step 7, device): The form cannot be submitted.
- E15 (step 8, device): The Vehicle selection page shows the right title.
- E16 (step 8, device): The Vehicle selection page shows a vehicle picker.
- E17 (step 8, device): The vehicle picker allows one vehicle to be selected.
- E18 (step 8, device): The Question page loads after Done is tapped.
- E19 (step 9, device): The Question page shows the right title.
- E20 (step 9, device): The Question page shows the description of the form.
- E21 (step 9, device): The Question page loads the first question of the form.
- E22 (step 10, device): The Question page shows a description.
- E23 (step 10, device): The Question page allows the user to continue with the next question.
- E24 (step 11, device): The Question page shows a numeric keyboard.
- E25 (step 11, device): After the input is filled, the Question page allows the user to continue with the next item.
- E26 (step 12, device): The Question page shows a full keyboard.
- E27 (step 12, device): After the input is filled, the Question page allows the user to continue with the next item.
- E28 (step 13, device): The Question page shows a drop-down list to select a value.
- E29 (step 13, device): After a value is selected, the Question page allows the user to continue with the next question.
- E30 (step 14, device): The Question page goes one step back in the question list.
- E31 (step 14, device): The Question page shows the value that was filled before (if one was filled).
- E32 (step 15, device): The question list shows all groups of items.
- E33 (step 15, device): The question list shows an indicator on the expanded groups.
- E34 (step 15, device): The question list marks unfilled mandatory items in red (ASSUMPTION: unfilled means not yet answered).
- E35 (step 15, device): The question list shows filled items in green.
- E36 (step 15, device): The question list shows unfilled optional items in grey.
- E37 (step 16, device): The Question page shows the item that was tapped.
- E38 (step 16, device): The Question page moves to the right item when going back and forth between items.
- E39 (step 17, device): The Question page redraws for the new orientation.
- E40 (step 17, device): The Question page shows only one menu open (known issue ENG-2713).
- E41 (step 18, device): The Submit button is disabled (ASSUMPTION).
- E42 (step 19, device): The Submit button is enabled.
- E43 (step 20, device): The Result page opens (needs: named go-ahead for this run, writes through BP Info).
- E44 (step 21, device): The Result page shows a message that says the form passed or failed.
- E45 (step 21, device): The Result page shows the upload status of the completed form.
- E46 (step 21, device): The Result page shows a Close button.
- E47 (step 22, device): The main Templates page opens.
- E48 (step 23, device): The Result page shows a Try again button if there is no internet connection or an error (needs: named go-ahead for this run, writes through BP Info).
- E49 (step 23, device): The Try again button stays visible after a failed upload (needs: named go-ahead for this run, writes through BP Info).
- E50 (step 24, device): The app tries to upload the current form again (needs: named go-ahead for this run, writes through BP Info).
- E51 (step 24, device): The upload status clears after a successful upload (needs: named go-ahead for this run, writes through BP Info).
- E52 (step 25, device): The Result page shows a success message (needs: named go-ahead for this run, writes through BP Info).
- E53 (step 25, ui): Quick - Forms shows the form as a minor failure (needs: named go-ahead for this run, writes through BP Info).
- E54 (step 26, device): The Result page shows a non-operable message (needs: named go-ahead for this run, writes through BP Info).
- E55 (step 26, ui): Quick - Forms shows the form as a major failure (needs: named go-ahead for this run, writes through BP Info).

## Clean-up
- Remove the form results from the submissions in this case in Quick - Forms (no QA-AUTO- prefix; find them by driver name and time).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 16 to 39. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Forms: steps name each screen and action, E lines split to one observation, typos fixed.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Refined 2026-11-26 (second review): BP Info write markers, Quick - Forms E lines moved to ui with role professional, resources, step 22 split (offline Try again, restore and Try again), steps 11 to 13 type or select a value, Submit disabled check added, E43 deleted, E34 ASSUMPTION, preconditions, cleanup.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
