---
name: test-plan
description: Produce a risk-based test plan and test cases for a Jira ticket, feature or change. Use when the user asks what to test, asks for test cases, or starts QA on a story.
argument-hint: <JIRA-KEY or feature description>
---

Write a test plan for `$ARGUMENTS`.

1. If it is a Jira key, fetch the issue, its acceptance criteria, linked issues and comments. Otherwise use the description given.
2. Read `<tenant>/knowledge/INDEX.md`, then the domain and repo files it names for this area. In parallel, ask `meeting-researcher` what meetings said about the feature: decisions, positions, plans, concerns, conflicts with the knowledge base. Put its conflicts and unresolved positions under "open questions" in the plan, and give its decisions and concerns to `test-designer` as extra inputs.
3. If a linked PR or branch exists, have `code-mapper` trace the changed code and report untested branches.
4. Give the requirement and that context to `test-designer` and get the case table.
5. Have `test-reviewer` check the cases against the requirement for gaps and duplicates. Apply its fixes.
6. Save to `<tenant>/reports/YYYY-MM-DD-testplan-<key>.md`:
   - scope and out of scope
   - risks
   - open questions for the product owner or developer
   - case table
   - what to automate, at which level, in which repo
   - test data and environment needed

Lead your reply with the open questions and the P1 cases. Offer `/write-tests` for the cases marked for automation. Do not post the plan to Jira unless the user says to.
