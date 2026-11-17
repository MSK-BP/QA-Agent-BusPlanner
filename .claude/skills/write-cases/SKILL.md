---
name: write-cases
description: Turn a test plan, a ticket or a feature into runnable markdown test case files in the tenant's tests/ folder, reviewed by an independent agent and left for a person to approve. Use when the user asks to write, create or add test cases or a test suite.
argument-hint: <test plan file, ticket key or feature> [module=<name>] [flow=<name>]
---

Write test case files for `$ARGUMENTS`.

1. Read `<tenant>/knowledge/INDEX.md`, `<tenant>/tests/README.md` and the case template `templates/cases/CASE.md`. List the existing cases for this area with `harness\cases.ps1 -Module <module>` so you do not duplicate them and you continue the ID numbering.
2. Get the source:
   - a test plan file: read it; its case table is the input.
   - a ticket key: fetch the issue, acceptance criteria, linked issues and comments. If no test plan exists for it, run the `/test-plan` steps first.
   - a feature description: use it, and the domain and repo files INDEX names.
   In parallel, ask `meeting-researcher` for decisions and open positions about the area.
3. Give `test-designer` the source, the case template and the tenant's tests README. Ask for full case files, not a table: front matter, Preconditions, Steps, Expected with one checkable line per result and its channel, Clean-up. Expected results trace to the source; anything else is marked ASSUMPTION. Choose the lowest channel that proves each result. Set `status: draft`.
4. Save each case to `<tenant>/tests/<module>/<flow>/<ID>.md`. Use the tenant's ID prefix for the module (tests README); otherwise `<MODULE>-<nnn>`. Put the ticket key in `ticket:` when there is one.
5. Run `harness\cases.ps1 -Action validate`. Fix every error in the new files.
6. Give `test-reviewer` the new case files and the source, not your reasoning. Ask: would each expected line fail if the feature were broken; is each line checkable from one observation; are the steps runnable as written; which requirement has no case; which cases duplicate each other. Apply its fixes, then set `status: reviewed` on the cases it passed. Leave the rest `draft` with a `## Review notes` section that says what is open.
7. Validate again. If the user named a suite, or the cases belong together, create or update `<tenant>/tests/suites/<name>.md` from `templates/cases/SUITE.md`.

Reply with: the cases written (ID, priority, title, status), the open questions and ASSUMPTION lines, and the review findings you could not fix. End with the next step: a person approves with `/review-cases approve <selector>` (or edits `status` and `approved-by`), then `/run-cases`.

Never set `status: approved`. Only a person approves a case.
