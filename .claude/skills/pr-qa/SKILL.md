---
name: pr-qa
description: Assess a pull request or branch from a QA angle - risk, test coverage of the change, and what must be tested before merge. Use when the user asks to QA, review or sign off a PR.
argument-hint: <PR number/URL or branch> [repo]
---

QA review of `$ARGUMENTS`.

1. Get the diff, the PR description and the linked ticket with its acceptance criteria.
2. In parallel:
   - `code-mapper`: what behaviour the diff changes, what else calls the changed code, which changed branches have no test
   - `test-reviewer`: whether the tests in the PR would catch a regression in the changed behaviour
   - `meeting-researcher`: what meetings decided or worried about for this change, and any conflict with the acceptance criteria
3. Run the tests that cover the changed area and record the result. If you could not run them, say why.
4. Compare the change against each acceptance criterion: met, not met, or not verifiable from code.
5. Reply with:
   - verdict: ready, ready with conditions, or not ready
   - risk level and the reason
   - missing tests, as concrete cases
   - what needs manual or exploratory checking, and on which environment
   - regression areas to rerun

Post nothing to the PR or ticket unless the user asks. Offer `/write-tests` for the missing cases.
