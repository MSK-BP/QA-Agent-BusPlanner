---
id: FLT-REG-009
title: BP Fleet - Change user permissions
module: bp-fleet
flow: regression
ticket:
priority: P1
spec: [sheet:BP Fleet!10]
channels: [ui]
roles: [qa-admin, qa-auto-user1]
env: qa1
data: [client-1230, data:client-1230-qa-auto-user1]
tags: [regression, from-sheet]
depends-on: []
resources: [data:client-1230-permissions]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Fleet on QA1 (client 1230, Miami), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`. The case deletes its own records in Clean-up.
- The long-lived seed vehicle `QA-AUTO-<initials>-VEH1` and seed vendor `QA-AUTO-<initials>-VENDOR1` exist (listed in the tests README). No case deletes them.
- Test user `QA-AUTO-<initials>-USER1` exists on client 1230 (data: `data:client-1230-qa-auto-user1`; long-lived, no case deletes it). It uses the tester's own email address. The password comes from the secret store and is never written in this case (needs: the user created and its secret-store entry named in the tests README).
- The signed-in admin can change user permissions (role qa-admin) (ASSUMPTION).
- Note the start value of the Create Work Order permission of USER1 and restore it in Clean-up.

## Steps
1. As qa-admin, in BP Fleet, open the user administration screen (ASSUMPTION: menu name).
2. As qa-admin, open user `QA-AUTO-<initials>-USER1`.
3. As qa-admin, turn the Create Work Order permission off and click Save.
4. As qa-auto-user1, sign in to BP Fleet and open the Work Orders list.
5. As qa-admin, open user `QA-AUTO-<initials>-USER1`, turn the Create Work Order permission on and click Save.
6. As qa-admin, open user `QA-AUTO-<initials>-USER1` again.
7. As qa-auto-user1, sign in again and open the Work Orders list.

## Expected (each line must be checkable)
All E lines are ASSUMPTION (the sheet row names the process only).
- E1 (step 3, ui): The save completes with no error message.
- E2 (step 4, ui): The create work order button is not shown.
- E3 (step 5, ui): The save completes with no error message.
- E4 (step 6, ui): The Create Work Order permission shows as on.
- E5 (step 7, ui): The create work order button is shown.

## Clean-up
- Set the Create Work Order permission of USER1 back to its start value. Do not delete USER1.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Fleet, row 10. Converted 2026-11-26. The sheet names the process only, so the steps and expected result are an ASSUMPTION until refined.
- Last manual result: Passed on 12.4.11.29; related bugs 44886, 44891.
- Refined 2026-11-26: concrete steps and checkable E lines; reviewer fixes: permission set off first, negative check as USER1, then on and positive check; roles qa-admin and qa-auto-user1; USER1 is a named data entry with the secret-store rule. Permission name and screen names are ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
