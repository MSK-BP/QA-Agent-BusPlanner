---
id: WEB-REG-001
title: BP Web - Anonymous
module: bp-web
flow: regression
ticket:
priority: P1
spec: [sheet:BP Web!2-5]
channels: [ui]
roles: [anonymous]
env: qa1
data: [client-1221]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- BP Web on QA1 (client 1221) is open with no sign-in.
- Data the case creates starts with `QA-AUTO-<initials>-`.
- Client 1221 has at least one public image, one public PDF and one public video in the Media Library (ASSUMPTION).

## Steps
1. As the anonymous user, open the BP Web Home page of client 1221.
2. As the anonymous user, open the page `Sitestatus.ashx`.
3. As the anonymous user, on the Home page, open School Information.
4. As the anonymous user, on School Information, pick a school.
5. As the anonymous user, open the Media Library page.
6. As the anonymous user, on the Media Library page, open one public image item.
7. As the anonymous user, on the Media Library page, open one public PDF item.
8. As the anonymous user, on the Media Library page, open one public video item.

## Expected (each line must be checkable)
- E1 (step 1, ui): The Home page loads with no error page.
- E2 (step 2, ui): The page shows status "OK" with code 200.
- E3 (step 4, ui): The school address is visible.
- E4 (step 4, ui): The available grades for the school boundaries are visible.
- E5 (step 4, ui): The map is displayed.
- E6 (step 6, ui): The image opens and displays.
- E7 (step 7, ui): The PDF opens.
- E8 (step 8, ui): The video plays.

## Clean-up
- None. The case creates nothing.

## Notes
- Refined 2026-11-26 (reviewer fixes: Clean-up is None, the case creates nothing): steps split to one action each; observed results turned into checkable E lines; signed-in user views of the Home page and media (sheet E1, E4) are covered by WEB-REG-002 and WEB-REG-003, not here. Media upload (ENG-803, ENG-804) is not in this anonymous case.
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Web, rows 2 to 5. Converted 2026-11-26; expected results come from the sheet's observed result column.
- Row 2: last manual status Passed; related bugs ENG-467.
- Row 3: last manual status Passed.
- Row 4: last manual status Passed.
- Row 5: last manual status Passed; related bugs ENG-803, ENG-804; note: Faced issues for media upload and incorrect format upon editing.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
