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
3. Design in parallel:
   - **Split** the source into parts that can be designed alone: one part per flow, or per group of about 5 requirements or acceptance criteria. A small ticket (about 8 cases or fewer) is one part.
   - **Fan out:** start one `test-designer` per part, all in one message. Give each its part, the whole source for context, the case template, the tenant's tests README, and its own ID range (part 1: `-01` to `-19`, part 2: `-20` to `-39`, ...) so IDs never collide.
   - **Ask each for** full case files, not a table: front matter, Preconditions, Steps, Expected with one checkable line per result and its channel, Clean-up. Expected results trace to the source; anything else is marked ASSUMPTION. Choose the lowest channel that proves each result. Set `status: draft`.
   - **Parallel fields:** ask each designer to set `depends-on` when a case needs another case's result (a build, created data, an end state), and `resources` for anything two cases must not use at the same time (a build folder, a device, a test-data record, an account whose state the case changes).
   - **Merge:** collect the parts. Remove duplicates across parts, and keep a dependency that crosses parts.
4. Save each case to `<tenant>/tests/<module>/<flow>/<ID>.md`. Use the tenant's ID prefix for the module (tests README); otherwise `<MODULE>-<nnn>`. Put the ticket key in `ticket:` when there is one.
5. Run `harness\cases.ps1 -Action validate`. Fix every error in the new files, including unknown or circular `depends-on` and badly formed `resources`.
6. Review in parallel. Give reviewers the case files and the source, never your reasoning.
   - **Per case, in batches:** split the new cases into batches of about 5. Start one `test-reviewer` per batch, all in one message. Ask: would each expected line fail if the feature were broken; is each line checkable from one observation; are the steps runnable as written (check commands, names and numbers against the code); are `depends-on` and `resources` complete and right.
   - **Whole set, once:** one more `test-reviewer` gets every case's ID, title, spec, depends-on and Expected lines, plus the source. It answers only: which requirement has no case; which cases duplicate each other.
   - Apply the fixes, then set `status: reviewed` on the cases that passed. Leave the rest `draft` with a `## Review notes` section that says what is open.
7. Validate again. If the user named a suite, or the cases belong together, create or update `<tenant>/tests/suites/<name>.md` from `templates/cases/SUITE.md`.

Reply with: the cases written (ID, priority, title, status), the open questions and ASSUMPTION lines, and the review findings you could not fix. End with the next step: a person approves with `/review-cases approve <selector>` (or edits `status` and `approved-by`), then `/run-cases`.

Never set `status: approved`. Only a person approves a case.
