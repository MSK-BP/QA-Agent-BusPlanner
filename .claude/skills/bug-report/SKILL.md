---
name: bug-report
description: Turn a finding into a complete, reproducible bug report and, on approval, file it in Jira. Use when a product defect has been found by a test, by exploration, or described by the user.
argument-hint: <finding, triage report, or description>
---

Write a bug report for `$ARGUMENTS`.

1. Reproduce it on an allowed environment if you have not already. If you cannot, say so in the report and give the evidence you do have.
2. Reduce it to the shortest steps that still fail.
3. Search Jira for an existing issue with the same symptom. If one exists, propose a comment on it, not a new issue. Grep `<tenant>/meetings/` for the symptom and area: a meeting may have already named the defect, decided the behaviour is intended, or assigned a fix owner. Cite what you find.
4. Draft:
   - **Title**: what is wrong, where, under what condition
   - **Environment**: name, build or commit, browser or client, account role
   - **Steps to reproduce**: numbered, starting from a known state
   - **Expected**, with the requirement or rule it comes from
   - **Actual**, with the exact error text
   - **Evidence**: screenshot, request and response, log excerpt, failing test name
   - **Impact and severity**, with the reasoning
   - **Suspected cause**, only if code evidence supports it, as `file:line`
5. Remove personal or customer data and any secret from the evidence.
6. Show the draft. Create the Jira issue only after the user approves it, in the project and with the fields they confirm. Then give the issue link.
