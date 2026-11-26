---
id: PRO-REG-005
title: BP Pro (over RDP) - Student update process
module: bp-pro
flow: regression
ticket:
priority: P1
spec: [sheet:BP Pro!15-17]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-eligibility-addresses]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: none
---
## Preconditions
- Signed in to BP Pro (over RDP) on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`.

## Steps
1. In Student Manager, add student QA-AUTO-<initials>-P005-01 with one address and one enrollment. Save. Then change the address and change the enrollment end date. Save.
2. In Student Manager, add new student QA-AUTO-<initials>-P005-02 with name, one address and one enrollment. Save.
3. In Student Manager, add student QA-AUTO-<initials>-P005-03 with the Bussed address from client-1221-eligibility-addresses. Save. Check the eligibility, then use Auto Assign Transportation.
4. In Student Manager, add student QA-AUTO-<initials>-P005-04 with the Hazard address from client-1221-eligibility-addresses. Save. Check the eligibility, then use Auto Assign Transportation.

## Expected (each line must be checkable)
- E1 (step 1, desktop): The changed address and the changed enrollment end date show in the student record after save and after reopening the student.
- E2 (step 2, desktop): The new student saves with no error and shows in the student list and in Find Student.
- E3 (step 3, desktop): QA-AUTO-<initials>-P005-03 shows eligibility Bussed before Auto Assign. (needs: Bussed address in client-1221-eligibility-addresses)
- E4 (step 3, desktop): Auto Assign gives QA-AUTO-<initials>-P005-03 a run and stop assignment on the Transportation tab, with no error dialog. (ASSUMPTION)
- E5 (step 3, desktop): The assigned stop is within the client's walk-to-stop distance. (ASSUMPTION)
- E6 (step 4, desktop): QA-AUTO-<initials>-P005-04 shows eligibility Hazard before Auto Assign. (needs: Hazard address in client-1221-eligibility-addresses)
- E7 (step 4, desktop): Auto Assign gives QA-AUTO-<initials>-P005-04 a run and stop assignment on the Transportation tab, with no error dialog. (ASSUMPTION)
- E8 (step 4, desktop): The assigned stop is within the client's walk-to-stop distance. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 15 to 17. Converted 2026-11-26.
- Row 15: last manual result pass on 13.3.0.195.
- Row 16: last manual result pass on 13.3.0.195.
- Row 17: last manual result pass on 13.3.0.195; other results: 12.2.1.336: pass-checked with bussed.
- Refined 2026-11-26: addresses for Bussed and Hazard come from the data entry; Auto Assign needs existing client 1221 runs near those addresses (needs: confirm they exist). The sheet says 'address or enrollment'; both are changed in one pass (ASSUMPTION). Bussed eligibility was checked on 12.2.1.336. Clean-up: remove assignments and delete the four QA-AUTO students. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
