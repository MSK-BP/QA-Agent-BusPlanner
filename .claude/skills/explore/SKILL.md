---
name: explore
description: Run a charter-based exploratory testing session against the running application on an allowed test environment. Use when the user wants hands-on testing of a feature, a bug reproduced in the real app, or a change checked beyond automated tests.
argument-hint: <feature or charter> [environment]
---

Explore `$ARGUMENTS`.

1. Check the environment in `<tenant>/knowledge/environments.md`. It must be listed and allowed. If its base URL or test account is missing, ask; do not guess a URL.
2. Open the app in the Playwright browser (`mcp__playwright__browser_navigate`) and, if it shows a sign-in page, ask the user to sign in there. Record the build or version, using the method `environments.md` gives for it.
3. Write the charter and a time box (default 20 minutes of activity) and state them.
4. Read the domain rules for this area so you know what correct looks like.
5. Hand the charter, the rules and the environment details to `exploratory-tester`. For a large area, run several with different charters (roles, data, error paths); they share one browser, so run them one after another.
6. Verify each finding yourself once before reporting it.
7. Save session notes to `<tenant>/reports/YYYY-MM-DD-explore-<topic>.md`: charter, coverage, findings, questions, automation ideas.

Offer `/bug-report` for each confirmed finding.
