---
id: QCK-REG-001
title: BP Quick - Simple Checks
module: bp-quick
flow: regression
ticket:
priority: P1
spec: [sheet:BP Quick!2-4]
channels: [ui]
roles: [quick-no-2fa, quick-2fa, quick-sso]
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
- The tester has the three test users named in roles, taken from the secret store.
- Data the case creates starts with `QA-AUTO-<initials>-Q001-` (this case creates none).

## Steps
1. Open the BP Quick sign-in page. Sign in as quick-no-2fa, sign out, then sign in as quick-2fa and enter the 2FA code.
2. Open the BP Quick sign-in page and click Sign in with SSO. Sign in as quick-sso.
3. After sign-in, open Route Manager from the main menu.

## Expected (each line must be checkable)
- E1 (step 1, ui): The quick-no-2fa user reaches the BP Quick home page with no 2FA prompt. (ASSUMPTION)
- E2 (step 1, ui): The quick-2fa user gets a code prompt and reaches the home page after a valid code. (needs: how the tester gets the 2FA code for the quick-2fa user)
- E3 (step 2, ui): The quick-sso user reaches the BP Quick home page. The sheet notes SSO is 'Not Setup'; if no SSO option shows, record this line as Blocked, not Pass.
- E4 (step 3, ui): Route Manager opens and lists the existing client 1221 routes with no error message. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 2 to 4. Converted 2026-11-26.
- Row 2: last manual result pass on 13.1.12.153.
- Row 3 note: Not Setup.
- Row 4: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: SSO is not set up on the test environment (sheet note). Test users come from the secret store, never from this file. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
