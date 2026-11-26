---
id: WEB-REG-002
title: BP Web - Professional Portal
module: bp-web
flow: regression
ticket:
priority: P1
spec: [sheet:BP Web!6-17]
channels: [ui]
roles: [professional]
env: qa1
data: [client-1221, data:1221-bussed-address, data:1221-test-student, data:1221-test-subscriber]
tags: [regression, from-sheet]
depends-on: []
resources: [data:1221-alerts, data:1221-vehicle-mapping]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- BP Web on QA1 (client 1221) is open, signed in with a professional portal account.
- Data the case creates starts with `QA-AUTO-<initials>-`.
- SAFETY: post alerts and notices on QA test client 1221 only. Confirm that client 1221 has no Twitter or social auto-post, or that it links to a test account (needs: confirmation that client 1221 has no social auto-post or links to a test account). Never publish to a real social account. Confirm client 1221 has no real subscribers before steps 1 to 4, 7 and 12 (needs: confirmation that client 1221 has no real subscribers).
- Named data: a bussed address (`data:1221-bussed-address`) and a test student with a route and run (`data:1221-test-student`) (needs: the address and student named in the tests README). A test subscriber with a test email, phone and push device (`data:1221-test-subscriber`) (needs: push device).
- At least one cancellation alert and one delay alert exist on client 1221 in the report date range (ASSUMPTION).

## Steps
1. As the professional user, open the Post Alert page of client 1221 (needs: confirmation that client 1221 has no real subscribers).
2. As the professional user, post a School Alert titled `QA-AUTO-<initials>-School` (needs: confirmation that client 1221 has no real subscribers and no social auto-post).
3. As the professional user, post a General Notice titled `QA-AUTO-<initials>-General` (needs: confirmation that client 1221 has no real subscribers and no social auto-post).
4. As the professional user, post a Transportation Alert titled `QA-AUTO-<initials>-Transport` (needs: confirmation that client 1221 has no real subscribers and no social auto-post).
5. As the professional user, open the Alerts page.
6. As the professional user, click the Twitter icon at the bottom of the Alerts page. Do not post anything.
7. As the tester, check the test subscriber's inbox, phone and push device for the Transportation Alert (needs: confirmation that client 1221 has no real subscribers). The push check is Blocked (needs: push device).
8. As the professional user, open the Address Eligibility page and enter the bussed address.
9. As the professional user, on the Address Eligibility result, create a temporary Bus Pass.
10. As the professional user, open the Student Search page and search for the test student.
11. As the professional user, open the student record, then its summary and its transportation details.
12. As the professional user, on the student record, post a Targeted Notice titled `QA-AUTO-<initials>-Targeted` (needs: confirmation that client 1221 has no real subscribers and no social auto-post).
13. As the professional user, open the Vehicle Mapping page.
14. As the professional user, on Vehicle Mapping, add an assignment (needs: confirmation that Vehicle Mapping on QA1 does not write to BPInfo).
15. As the professional user, open the Route Changes report.
16. As the professional user, on the Route Changes report, generate the PDF.
17. As the professional user, open the Route Details page and select by Route, then by Run.
18. As the professional user, on Route Details, generate the CSV, then the PDF.
19. As the professional user, open the Route Directions page and view Directions and Map by Run, Directions by Route and Directions by Run.
20. As the professional user, open the Route Listing page and view by Route, then by Run.
21. As the professional user, open the Route Summary page and view by Route, then by Run.
22. As the professional user, on the student transportation details, generate a Bus Pass.
23. As the professional user, open the Bus Pass report and generate it.
24. As the professional user, open the Cancellation & Delay report and generate it.
25. As the professional user, open the Alerts page and compare the cancellation and delay alerts with the report.
26. As the professional user, open the email notification manager and find the notification of step 4 (optional; bug 44587; ASSUMPTION: page name).
27. As the professional user, open the BP Web Home page.
28. As the professional user, open the Media Library page.
29. As the professional user, on the Media Library page, open one user-only image, one user-only PDF and one user-only video (needs: user-only media on client 1221).

## Expected (each line must be checkable)
- E1 (step 2, ui): The School Alert `QA-AUTO-<initials>-School` posts with no error.
- E2 (step 3, ui): The General Notice `QA-AUTO-<initials>-General` posts with no error.
- E3 (step 4, ui): The Transportation Alert `QA-AUTO-<initials>-Transport` posts with no error.
- E4 (step 5, ui): The Alerts page lists the three posted items.
- E5 (step 6, ui): The Twitter icon opens the client's Twitter page. No post appears there.
- E6 (step 7, ui): The test subscriber's inbox holds the Transportation Alert email.
- E7 (step 7, ui): The test subscriber's phone holds the Transportation Alert SMS.
- E8 (step 7, ui): The test subscriber's push device shows the Transportation Alert (Blocked: needs a push device).
- E9 (step 8, ui): School records appear with an eligibility value.
- E10 (step 8, ui): For the bussed address, the eligibility is "Bussed" and route details show.
- E11 (step 9, ui): A temporary Bus Pass is created.
- E12 (step 10, ui): The search returns student records.
- E13 (step 11, ui): The student summary and the transportation details display.
- E14 (step 12, ui): The Targeted Notice posts with no error.
- E15 (step 14, ui): The new assignment is saved and shows on the Vehicle Mapping page.
- E16 (step 15, ui): The Route Changes report lists the route changes.
- E17 (step 16, ui): The Route Changes PDF generates.
- E18 (step 17, ui): Route Details shows the information that matches the selected Route and Run.
- E19 (step 18, ui): The Route Details CSV generates with no error.
- E20 (step 18, ui): The Route Details PDF generates with no error.
- E21 (step 19, ui): The Directions and Map by Run, Directions by Route and Directions by Run views each display.
- E22 (step 20, ui): The Route Listing by Route and by Run views each display.
- E23 (step 21, ui): The Route Summary by Route and by Run views each display.
- E24 (step 22, ui): A Bus Pass generates from the student transportation details.
- E25 (step 23, ui): The Bus Pass report generates.
- E26 (step 24, ui): The Cancellation & Delay report generates.
- E27 (step 25, ui): The report data matches the cancellation and delay alerts on the Alerts page.
- E28 (step 26, ui): The email notification manager shows the notification of step 4 (ASSUMPTION).
- E29 (step 27, ui): The Home page loads for the professional user.
- E30 (step 29, ui): The user-only image, PDF and video each open.

## Clean-up
- Delete the four posted items: `QA-AUTO-<initials>-School`, `QA-AUTO-<initials>-General`, `QA-AUTO-<initials>-Transport` and `QA-AUTO-<initials>-Targeted`.
- Delete the temporary Bus Pass created in step 9 and the Bus Pass generated in step 22. These have no `QA-AUTO-` name: identify them by the test student and today's date.
- Delete the Vehicle Mapping assignment added in step 14. It has no `QA-AUTO-` name: identify it by the time it was created and the test vehicle.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Web, rows 6 to 17. Converted 2026-11-26; expected results come from the sheet's observed result column.
- Row 7: last manual status Passed; related bugs 43402 , 43676; (Enhancement) ; 44587 (Nodata on email notifiation manager ).
- Row 8: last manual status Passed.
- Row 9: last manual status Passed.
- Row 10: last manual status Passed; related bugs ENG-661.
- Row 11: last manual status Passed; related bugs Bug 43907; note: Confirmation regarding the "No routes selected" message when view type is route changes.when there is no route selection option available.
- Row 12: last manual status Passed.
- Row 13: last manual status Passed.
- Row 14: last manual status Passed; related bugs ENG-659.
- Row 15: last manual status Passed.
- Row 16: last manual status Passed.
- Row 17: last manual status Passed.
- Sheet note for this group: 2FA not applicable?
- Refined 2026-11-26: steps split to one action each on a named page; Reason text turned into checkable E lines; client-1221-only safety precondition and "(needs: ...)" marks on every step that posts an alert or notice. Reviewer fixes: social auto-post precondition, Vehicle Mapping BPInfo mark, tester-side email/SMS/push check with push Blocked, split E lines (email/SMS/push, report/PDF, CSV/PDF), Home page and signed-in media steps (sheet row 5 "user base media view"), named data, resources, full Clean-up. The Twitter step only clicks the icon.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
