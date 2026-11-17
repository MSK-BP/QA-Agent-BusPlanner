# STEO SaaS implementation meeting (2026-11-16)

- **Recording:** https://fathom.video/calls/901564309
- **Class:** qa-context
- **Source read:** summary
- **Areas:** Old World SaaS migration (STEO)

## Decisions

- STEO's move to SaaS moves from 2026-11-21 to a cutover target in the week of 2026-12-07, with a week of live use before the holiday break — owner: the STEO transportation lead with BusPlanner — tentative (depends on the script developer's availability) — [22:23](https://fathom.video/calls/901564309?timestamp=1343)
- The custom "File Checker" script is migrated as-is, not rewritten; it keeps running on its existing server and feeds the SaaS environment — owner: BusPlanner implementation — decided — [15:38](https://fathom.video/calls/901564309?timestamp=938)

## Positions and concerns

- **Timing of the move:** the new STEO transportation lead wants more time to understand the system so staff get a stable transition and can be supported after the move. BusPlanner accepted the delay. Outcome: decided (2026-11-21 dropped) — [02:11](https://fathom.video/calls/901564309?timestamp=131), [03:48](https://fathom.video/calls/901564309?timestamp=228)
- **Rewrite or migrate the File Checker script:** the script is a black box to both teams. The meeting chose migration as-is to avoid the risk of a rewrite, on condition that the script's original developer takes part in migration and QA. No one argued for a rewrite in the summary. Outcome: decided — [13:55](https://fathom.video/calls/901564309?timestamp=835), [15:38](https://fathom.video/calls/901564309?timestamp=938)
- **Safety of the cutover:** the customer wants its planners to validate daily tasks in a parallel SaaS environment before cutover, with the old server kept as rollback. Outcome: decided — [11:44](https://fathom.video/calls/901564309?timestamp=704)
- **Schedule constraints:** the customer holds that nothing may change during its routing simulation (the next two weeks) and wants a full week of live SaaS use before the holiday break (from 2026-12-14). Outcome: drives the week-of-2026-12-07 target — [20:47](https://fathom.video/calls/901564309?timestamp=1247), [22:23](https://fathom.video/calls/901564309?timestamp=1343)

## Plans

- PLANNED: SaaS environment ready for cutover mid-week of 2026-12-07, owner BusPlanner implementation; build starts once the week is confirmed — tentative — [22:23](https://fathom.video/calls/901564309?timestamp=1343), [25:34](https://fathom.video/calls/901564309?timestamp=1534)

## Environments, access, release

- A SaaS environment is built in parallel with the on-prem system; customer planners validate daily tasks (editing runs, moving students) before cutover — decided — [11:44](https://fathom.video/calls/901564309?timestamp=704)
- At cutover the latest customer production database is copied to the SaaS server; the old server stays online for a time as rollback — stated — [13:19](https://fathom.video/calls/901564309?timestamp=799)
- No changes during the customer's routing simulation (the two weeks after this meeting) — stated — [20:47](https://fathom.video/calls/901564309?timestamp=1247)

## Defects and risks

- The File Checker script is a black box to both teams; its original developer is needed for the migration and its QA — [17:44](https://fathom.video/calls/901564309?timestamp=1064)
- The schedule depends on the script developer's availability — [24:27](https://fathom.video/calls/901564309?timestamp=1467)

## Differs from knowledge base

- STEO SaaS cutover target moved to the week of 2026-12-07 vs `knowledge/jira/other-projects.md`: "IN-203 | Bug | Backlog | STEO: server downsized, must be resized for SaaS move" — updates (adds the new date; IN-203 still open there)

## Confirms

- STEO is a known customer moving to SaaS (IN-203) — `knowledge/jira/other-projects.md`

## Action items

- None for QA. The customer validates the parallel environment.
- [ ] Confirm the script developer's availability for the week of 2026-12-07 — owner: the STEO transportation lead — [24:27](https://fathom.video/calls/901564309?timestamp=1467)
- [ ] Build the SaaS environment once the week is confirmed — owner: BusPlanner implementation — [25:34](https://fathom.video/calls/901564309?timestamp=1534)
