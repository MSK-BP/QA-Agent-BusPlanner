---
id: WEB-REG-003
title: BP Web - Parent Portal
module: bp-web
flow: regression
ticket:
priority: P1
spec: [sheet:BP Web!18-20]
channels: [ui]
roles: [parent, professional, new-subscriber]
env: qa1
data: [client-1221, data:1221-test-student, data:1221-contact-matching, data:1221-test-subscriber]
tags: [regression, from-sheet]
depends-on: []
resources: [data:1221-contact-matching, data:1221-alerts]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- BP Web on QA1 (client 1221) is open. Roles: parent (existing parent account), professional (admin who sets Contact Matching), new-subscriber (created in step 7).
- Data the case creates starts with `QA-AUTO-<initials>-`.
- SAFETY: use QA test client 1221 only. Use a test email and phone you own for the new subscriber. Never use a real parent's details. Confirm client 1221 has no real subscribers (needs: confirmation that client 1221 has no real subscribers).
- An existing parent account with students exists on client 1221 (ASSUMPTION).
- Student number and date of birth of a test student on client 1221 (`data:1221-test-student`) (ASSUMPTION; needs: the values named in the tests README). That student has a contact whose email matches the new subscriber's test email (`data:1221-contact-matching`) (ASSUMPTION).
- Record the start value of the Contact Matching setting of client 1221 and restore it in Clean-up.
- 2FA and SSO are not configured on QA1 (sheet note), so steps 3 and 4 may be Blocked.

## Steps
1. As the parent user, open the Parent Sign In page of client 1221.
2. As the parent user, sign in with BP Web credentials of the existing parent account.
3. As the parent user, sign in with a parent account that has 2FA on (ASSUMPTION: needs a 2FA test account).
4. As the parent user, sign in through SSO (ASSUMPTION: needs SSO configured on client 1221).
5. As the parent user, open the student list of the existing parent account.
6. As the parent user, on the student list, open the transportation information of one student.
7. As the new subscriber, open the Subscriber sign-up page and create subscriber `QA-AUTO-<initials>-Parent` (needs: confirmation that client 1221 has no real subscribers).
8. As the new subscriber, add the test student by student number and date of birth.
9. As the new subscriber, open the student list.
10. As the new subscriber, open the transportation information of the added student.
11. As the professional/admin user, turn Contact Matching on for client 1221 (ASSUMPTION: the setting is in the client configuration).
12. As the new subscriber, remove the added student, then open the student list.
13. As the professional/admin user, turn Contact Matching off for client 1221.
14. As the new subscriber, open the student list.

## Expected (each line must be checkable)
- E1 (step 2, ui): Sign-in with BP Web credentials succeeds and the parent portal opens.
- E2 (step 2, ui): The Home page loads for the parent user.
- E3 (step 3, ui): After the 2FA code, sign-in succeeds. If 2FA is not configured, mark Blocked.
- E4 (step 4, ui): SSO sign-in succeeds. If SSO is not configured, mark Blocked.
- E5 (step 5, ui): The student list shows the students linked to the parent.
- E6 (step 6, ui): The transportation information of the student displays.
- E7 (step 7, ui): The new subscriber is created with no error.
- E8 (step 9, ui): The student list of the new subscriber shows the added student.
- E9 (step 10, ui): The transportation information displays.
- E10 (step 12, ui): With Contact Matching on, the subscriber whose email matches a student contact sees that student without adding it (ASSUMPTION).
- E11 (step 14, ui): With Contact Matching off, the list shows only manually added students (ASSUMPTION).

## Clean-up
- Restore the Contact Matching setting of client 1221 to its start value.
- Delete subscriber `QA-AUTO-<initials>-Parent`.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Web, rows 18 to 20. Converted 2026-11-26; expected results come from the sheet's observed result column.
- Row 18: last manual status Passed; note: Couldn't test 2FA & SSO as its not configured.
- Row 19: last manual status Passed.
- Row 20: last manual status Passed.
- Refined 2026-11-26: sign-in split into BP Web credentials, 2FA and SSO steps (the last two Blocked while not configured); existing parent and new subscriber paths separated; client-1221-only safety precondition. Reviewer fixes: Home page E line (parent), transportation information of the new subscriber's student (row 20), Contact Matching on and off as two E lines, run as the professional/admin user, named test-student data, resources, Clean-up restores the setting and deletes the subscriber.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
