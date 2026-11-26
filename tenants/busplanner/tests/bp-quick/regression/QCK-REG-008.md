---
id: QCK-REG-008
title: BP Quick - User Permissions
module: bp-quick
flow: regression
ticket:
priority: P2
spec: [sheet:BP Quick!21-21]
channels: [ui]
roles: [quick-scope-operator, quick-scope-school, quick-scope-driver, quick-scope-district]
env: qa1
data: [client-1221, client-1221-scope-users]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Uses existing test accounts for the four roles, or the user approves creating them.
- The tester takes the four users from the secret store; the operator, school, driver and district of each user are in data entry client-1221-scope-users.

## Steps
1. Sign in as quick-scope-operator and open the student and run lists. Sign out.
2. Sign in as quick-scope-school and open the student and run lists. Sign out.
3. Sign in as quick-scope-driver and open the student and run lists. Sign out.
4. Sign in as quick-scope-district and open the student and run lists.

## Expected (each line must be checkable)
- E1 (step 1, ui): The operator user sees only data of its own operator. (needs: operator assigned to quick-scope-operator)
- E2 (step 2, ui): The school user sees only data of its own school. (needs: school assigned to quick-scope-school)
- E3 (step 3, ui): The driver user sees only data of its own runs. (needs: driver assigned to quick-scope-driver)
- E4 (step 4, ui): The district user sees data of the whole district. (needs: district assigned to quick-scope-district)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 21 to 21. Converted 2026-11-26.
- Row 21: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: the sheet names the four scope types but not what each may see; the expected access is assumed and must be confirmed against the permission rules. No data created; no clean-up. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
