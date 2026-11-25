---
name: review-cases
description: Review existing markdown test cases with an independent agent, or record a person's approval of them. Use when the user asks to review, check or approve test cases, or after someone edited cases by hand.
argument-hint: [approve] <suite name, case IDs, or filters like module=x flow=F2 priority=P1>
---

`$ARGUMENTS`

Resolve the cases with `harness\cases.ps1` and the selector (`-Suite`, `-Id`, `-Module`, `-Flow`, `-Priority`, `-Tag`, `-Ticket`). Show the list before acting.

## Review (no "approve" in the arguments)
1. Run `harness\cases.ps1 -Action validate` and fix format errors in the selected files.
2. Give the case files and their source (`spec`, `ticket`, the test plan) to reviewers, not anyone's reasoning, the same way as step 6 of `/write-cases`: one `test-reviewer` per batch of about 5 cases, all started in one message, then one reviewer for the whole set (gaps and duplicates). One batch is enough for 5 cases or fewer.
3. Apply fixes that do not change the meaning of a case. List changes to meaning as proposals and do not apply them.
4. Set `status: reviewed` on cases that pass. A case that was `approved` and whose Steps or Expected changed goes back to `reviewed`, and `approved-by` is cleared.
5. Reply with findings per case and the cases ready for approval.

## Approve ("approve" in the arguments)
Approval is a person's decision. The person who asks is the approver.
1. Only `reviewed` cases can be approved. List any `draft` case and skip it.
2. Ask who approves, unless the user named themself in this request. Set `status: approved` and `approved-by: <name> <YYYY-MM-DD>` on each case.
3. Run `harness\cases.ps1 -Action validate`.
4. Reply with the approved IDs. Remind the user that two testers approve each other's cases, not their own, when the team works that way (see the tenant's tests README).
