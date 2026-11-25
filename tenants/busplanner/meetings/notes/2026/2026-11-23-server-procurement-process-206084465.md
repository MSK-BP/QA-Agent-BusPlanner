# Server Procurement Process and Next Steps (2026-11-23)

- **Recording:** https://fathom.video/calls/909167348
- **Class:** qa-context
- **Source read:** summary only
- **Areas:** Environments and access, Release and branching

The AI summary sections that rate the team ("Engagement", "Adoption Confidence", "Team Readiness") and cost figures are left out.

## Decisions

- Every server action (create, resize, decommission) is logged in a Jira ticket for SOC, not only in IBM Cloud logs — owner: Ahnaf Rahman — decided (summary only) — [03:16](https://fathom.video/calls/909167348?tab=summary&timestamp=196)
- A daily automated report compares IBM Cloud changes with Jira tickets to catch unlogged changes; Umar gets daily visibility, not a blocking approval — owner: Ahnaf Rahman — decided (summary only) — [06:12](https://fathom.video/calls/909167348?tab=summary&timestamp=372), [17:07](https://fathom.video/calls/909167348?tab=summary&timestamp=1027)
- Routine resizes of one notch up or down need no leadership approval; decommissioning and new servers need approval (Andy Tompkins / Tommy Zwirblia) — owner: Andy Tompkins — decided (summary only) — [18:17](https://fathom.video/calls/909167348?tab=summary&timestamp=1097)
- Selected Support staff do routine resizes in IBM Cloud after training and permissions — owner: Andy Tompkins — decided (summary only) — [35:22](https://fathom.video/calls/909167348?tab=summary&timestamp=2122)
- Weekly review of under-used servers keeps at least a 40% capacity buffer; large reductions are staged step by step — owner: Ahnaf Rahman — decided (summary only) — [37:15](https://fathom.video/calls/909167348?tab=summary&timestamp=2235), [38:49](https://fathom.video/calls/909167348?tab=summary&timestamp=2329)
- Customer communication for a resize says "scheduled server maintenance" only — owner: Ahnaf Rahman — decided (summary only) — [40:46](https://fathom.video/calls/909167348?tab=summary&timestamp=2446)

## Rules and facts

- A resize takes 5–10 minutes and reboots the server — stated (summary only) — [42:25](https://fathom.video/calls/909167348?tab=summary&timestamp=2545)
- Server sizing so far was by judgement, not benchmarks tied to customer size and module mix — stated (summary only) — [11:10](https://fathom.video/calls/909167348?tab=summary&timestamp=670)
- Weekly resize recommendations become Zendesk tickets linked to Jira, routed to Support — stated (summary only) — [42:25](https://fathom.video/calls/909167348?tab=summary&timestamp=2545)

## Defects and risks

- Risk for QA: a resize reboots a customer server; a test or a customer job running then fails. Not discussed in the meeting; noted for test planning — inference, not said

## Differs from knowledge base

- Server change logging in Jira, approval gates, resize rules, 40% buffer — absent (`environments.md`, `architecture.md`; `process.md` names project SOC only)

## Confirms

- Hosting is IBM Cloud — `environments.md` (k8-dev resources)

## Action items

- [ ] SOC-compliant Jira ticket requirements, including root-cause data — owner: Ahnaf Rahman — [05:29](https://fathom.video/calls/909167348?timestamp=329)
- [ ] Daily change report with Jira-gap checks — owner: Ahnaf Rahman — [06:01](https://fathom.video/calls/909167348?timestamp=361)
- [ ] Publish CX resize guidelines — owner: Ahnaf Rahman — [30:37](https://fathom.video/calls/909167348?timestamp=1837)
- [ ] Verify IBM permissions for Support staff; live resize training — owner: Andy Tompkins — [36:26](https://fathom.video/calls/909167348?timestamp=2186)
- [ ] Revise the server procurement SOP — owner: Ahnaf Rahman — [43:38](https://fathom.video/calls/909167348?timestamp=2618)
