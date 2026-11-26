---
id: CHP-REG-002
title: Chipmunk - Setup
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!11-31]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Feedback, messages, account emails and notifications use the QA test client and QA-AUTO- test accounts only. Never use a real parent, student or district contact. The case creates its own account QA-AUTO-<initials>-parent2 with an email in the QA mailbox (needs: QA mailbox). It resets the password of that account only.
- The QA parent account (credentials file) is the second account in step 16.

## Steps
1. Start the app so that the Setup page opens.
2. On Setup, enter an invalid quick code and tap Verify.
3. On Setup, enter the QA quick code and tap Verify.
4. On Setup, open the district picker and select a district.
5. On Setup, tap Feedback.
6. On Setup, tap the help button.
7. Open the Login page.
8. On Login, tap Create account.
9. Look at the Create account page.
10. On Create account, tap Cancel.
11. On Login, tap Create account again.
12. On Create account, tap Create account with empty or invalid fields.
13. On Create account, fill all fields with the values of QA-AUTO-<initials>-parent2 and an email in the QA mailbox (needs: QA mailbox), then tap Create account.
14. On Login, tap Login with empty fields.
15. On Login, enter the credentials of QA-AUTO-<initials>-parent2 and tap Login.
16. Log out, then log in with the QA parent account (credentials file).
17. Log out, then log in again with the QA parent account.
18. Log out, then on Login tap Password reset.
19. Look at the Password reset page.
20. On Password reset, enter an invalid email and tap Send verification code.
21. On Password reset, enter the email of QA-AUTO-<initials>-parent2 and tap Send verification code.
22. Look at the Set password page.
23. On Set password, tap Resend verification email.
24. On Set password, tap Set password with an invalid code.
25. On Set password, tap Set password with a password and confirmation that differ.
26. On Set password, tap Cancel.
27. On Password reset, tap Send verification code again for the same email.
28. On Set password, enter the verification code and a matching password and confirmation, then tap Set password.
29. Reopen the app after the password of QA-AUTO-<initials>-parent2 was reset.

## Expected (each line must be checkable)
- E1 (step 1, device): The district picker shows on the Setup page.
- E2 (step 1, device): The quick code input shows on the Setup page.
- E3 (step 1, device): The Feedback button shows on the Setup toolbar.
- E4 (step 1, device): The help button shows on the Setup toolbar.
- E5 (step 2, device): The app rejects the invalid quick code and shows a message (ASSUMPTION).
- E6 (step 3, device): The app accepts the valid quick code.
- E7 (step 4, device): The selected district stays selected and no error shows.
- E8 (step 5, device): The Feedback page opens.
- E9 (step 6, device): The Help page opens.
- E10 (step 6, device): The Help page shows the context of the Setup page.
- E11 (step 7, device): The email input shows on the Login page.
- E12 (step 7, device): The password input shows on the Login page.
- E13 (step 7, device): The Login, Create account and Password reset buttons show on the Login page.
- E14 (step 8, device): The Create account page opens.
- E15 (step 9, device): The email input shows on the Create account page.
- E16 (step 9, device): The password input shows on the Create account page.
- E17 (step 9, device): The password confirmation input shows on the Create account page.
- E18 (step 9, device): The Create account and Cancel buttons show on the Create account page.
- E19 (step 10, device): The Login page opens.
- E20 (step 12, device): The app rejects the empty or invalid fields and shows a message (ASSUMPTION).
- E21 (step 13, device): A terms agreement prompt appears.
- E22 (step 13, device): A message confirms that the account was created (ASSUMPTION).
- E23 (step 13, device): The Login page opens.
- E24 (step 14, device): The app rejects the empty fields and shows a message (ASSUMPTION).
- E25 (step 15, device): No login error shows (ASSUMPTION).
- E26 (step 15, device): The Home page opens.
- E27 (step 16, device): Settings shows the second account's email and its settings.
- E28 (step 17, device): Push notifications keep arriving after the same account logs in again (known issue ENG-2648; needs: push delivery from production).
- E29 (step 18, device): The Password reset page opens.
- E30 (step 19, device): The email input shows on the Password reset page.
- E31 (step 19, device): The Send verification code and Cancel buttons show on the Password reset page.
- E32 (step 20, device): The app rejects the invalid email and shows a message (ASSUMPTION).
- E33 (step 21, device): A message says that a verification code was sent (ASSUMPTION).
- E34 (step 21, device): The Set password page opens.
- E35 (step 22, device): The verification code, password and confirm password inputs show on the Set password page.
- E36 (step 22, device): The Resend verification email, Set password and Cancel buttons show on the Set password page.
- E37 (step 23, device): The app validates the email field (ASSUMPTION: sheet text, confirm).
- E38 (step 23, device): A message says that a verification code was sent again (ASSUMPTION; known issue ENG-2716: a second request fails once).
- E39 (step 24, device): The app rejects the invalid code and shows a message (ASSUMPTION).
- E40 (step 25, device): The app rejects the password fields that differ and shows a message (ASSUMPTION).
- E41 (step 26, device): The Password reset page opens.
- E42 (step 27, device): The Set password page opens.
- E43 (step 28, device): A message confirms that the password changed (ASSUMPTION).
- E44 (step 28, device): The Login page opens.
- E45 (step 29, device): The app asks the user to log in again.
- E46 (step 29, device): The app does not lock the account (known issue ENG-2719).

## Clean-up
- Delete the account QA-AUTO-<initials>-parent2 (Settings > Delete account, or BP Web) (needs: confirm the BP Web path).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 11 to 31. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps expanded so each action is one step (invalid-then-valid input split, screens named); compound expected lines split; validation-message checks marked ASSUMPTION; QA mailbox and QA test client precondition added; known issues kept inside their lines.
- Review fixes 2026-11-26: Create account moved before the login steps so that the case uses its own account; reset and reopen moved after Set password; step 24 split at its 'or'; second-account and district lines reworded; known-issue request line deleted and its text moved to the resend line; unobservable 'sends' lines replaced by visible results marked ASSUMPTION; depends-on cleared.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
