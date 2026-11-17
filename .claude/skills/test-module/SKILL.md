---
name: test-module
description: Drive the whole agentic test loop for one module, flow or ticket - plan, write cases, review, wait for a person's approval, run, verify, triage, draft bugs, report - stopping at each human gate. Use when the user asks to test a module or ticket end to end, or to continue that loop.
argument-hint: <module, flow or ticket key> [env]
---

Take `$ARGUMENTS` through the test loop. Find where it stands first, and continue from there. Never skip a human gate.

1. **Where are we?** Look for a test plan in `<tenant>/reports/` and cases with `harness\cases.ps1 -Module <module>` or `-Ticket <key>`. Count cases by status and read the latest run in `tests/runs/`.
2. **Plan** (no plan yet): run the `/test-plan` steps. Show the open questions and the P1 cases.
3. **Write** (no cases, or the plan has cases with no file): run the `/write-cases` steps.
4. **Review** (cases in `draft`): run the `/review-cases` steps.
5. **Gate 1: approval.** If no case in scope is `approved`, stop. Show the reviewed cases and ask the user to approve them with `/review-cases approve <selector>`, or to edit and push them for the other tester's review. Offer a rehearsal run (`/run-cases <selector> <env> rehearsal`) if they want to try the cases first.
6. **Run** (approved cases, and the build on the environment changed since their last run, or the user asked): run the `/run-cases` steps.
7. **Gate 2: bugs.** Show the drafted bug reports. File each only after the user's yes, with the `/bug-report` steps.
8. **Report:** reply with the state of the module: cases by status, last verdicts (from `tests/MATRIX.md`), open bugs, open questions, and the next step.

Each run of this skill moves the loop as far as the next gate and stops there.
