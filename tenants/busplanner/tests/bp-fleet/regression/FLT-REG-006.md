---
id: FLT-REG-006
title: BP Fleet - Purchase Order list search
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!7]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1230, seed:QA-AUTO-VENDOR1, seed:QA-AUTO-VENDOR2]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-purchaseorders]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- The long-lived seed vendor `QA-AUTO-<initials>-VENDOR2` exists (second vendor, for PO6B). No case deletes it.

## Steps
1. In BP Fleet, create purchase order `QA-AUTO-<initials>-PO6` for vendor `QA-AUTO-<initials>-VENDOR1`. Save.
2. In BP Fleet, create purchase order `QA-AUTO-<initials>-PO6B` for vendor `QA-AUTO-<initials>-VENDOR2`. Save.
3. Open the Purchase Orders list.
4. On the Purchase Orders list, type `QA-AUTO-<initials>-PO6` in the search box and run the search.
5. On the Purchase Orders list, clear the search, filter by vendor `QA-AUTO-<initials>-VENDOR1` and run the search.
6. On the Purchase Orders list, search for the text `QA-AUTO-NO-SUCH-PO`.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 4, ui): The list shows `QA-AUTO-<initials>-PO6`.
- E2 (step 4, ui): The list does not show `QA-AUTO-<initials>-PO6B` (ASSUMPTION: the search matches the full reference, not a prefix; confirm with the team).
- E3 (step 5, ui): Every row in the list has vendor `QA-AUTO-<initials>-VENDOR1`.
- E4 (step 5, ui): The list shows `QA-AUTO-<initials>-PO6` and not `QA-AUTO-<initials>-PO6B`.
- E5 (step 6, ui): The list shows no rows or a "no results" message, and no error.

## Clean-up
- Delete or void `QA-AUTO-<initials>-PO6` and `QA-AUTO-<initials>-PO6B`. Keep the seed vendors VENDOR1 and VENDOR2.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 7. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.49; related bugs ENG-1049.
- Refined 2026-11-26: concrete search steps and E lines; reviewer fixes: case creates PO6 and PO6B and deletes both; negative check that PO6B is not listed.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
