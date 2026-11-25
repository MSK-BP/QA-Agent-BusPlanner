# Product Suite Knowledge Transfer for QA (2026-11-23)

- **Recording:** https://fathom.video/calls/909812875 (second recording: 206034974)
- **Class:** qa-core
- **Source read:** summary only
- **Areas:** GPS readers, Dispatch, QA process and priorities, Notifications and two-way sync

The AI summary sections that rate the attendees ("Team Readiness", "Engagement", "Adoption Confidence", "Knowledge Gaps") are left out.

## Rules and facts

- New World: one web application and one database per client; Old World: separate desktop products (BP Pro, Quick, Trips, Fleet) with separate databases — stated (summary only) — [03:20](https://fathom.video/calls/909812875?tab=summary&timestamp=200)
- New World has daily snapshots, so plans and vehicle assignments can differ by day; Old World holds one plan at a time — stated (summary only) — [05:45](https://fathom.video/calls/909812875?tab=summary&timestamp=345)
- Terms: a **run** goes from the first pickup stop to the last drop-off at a school; a **route** is a vehicle's whole schedule across AM and PM, which can hold several school runs; a **bus stop** is where students board — stated (summary only) — [07:05](https://fathom.video/calls/909812875?tab=summary&timestamp=425), [07:41](https://fathom.video/calls/909812875?tab=summary&timestamp=461)
- New World reconciles planned and GPS vehicles: a physical vehicle (`VEH` table) is linked to its installed GPS device — stated (summary only) — [08:35](https://fathom.video/calls/909812875?tab=summary&timestamp=515)
- The Substitution Service is a multi-tenant back-end service that runs about every five minutes and copies today's Old World GPS route vehicle substitution records into New World snapshot plan tables — stated (summary only) — [11:49](https://fathom.video/calls/909812875?tab=summary&timestamp=709)
- The Substitution Service has no UI; QA checks it by comparing New World tables with the Old World records — stated (summary only) — [28:18](https://fathom.video/calls/909812875?tab=summary&timestamp=1698)
- No Confluence page documents the Substitution Service yet; New World substitution documentation is in progress — stated (summary only) — [15:50](https://fathom.video/calls/909812875?tab=summary&timestamp=950)

## Plans

- PLANNED: Dispatch Reassigned Dashboard (mostly built by Vlad) replaces the Substitution Service: dispatchers record driver absences and reassign runs or whole routes, in Gantt and table views; drag runs to free drivers; merge or split runs at stop level — tentative (summary only) — [15:22](https://fathom.video/calls/909812875?tab=summary&timestamp=922), [19:17](https://fathom.video/calls/909812875?tab=summary&timestamp=1157)
- PLANNED: the dashboard notifies parents of bus and schedule changes through Chipmunk automatically — tentative (summary only) — [22:12](https://fathom.video/calls/909812875?tab=summary&timestamp=1332)
- PLANNED: QA of substitutions moves to the Dispatch UI once built, instead of table checks — tentative (summary only) — [28:18](https://fathom.video/calls/909812875?tab=summary&timestamp=1698)

## Defects and risks

- Risk: automatic parent notification from Dispatch; QA must never trigger it on dev or staging with real data (`environments.md` hard rules) — inference, not said

## Open questions

- Where are the Substitution Service notes, the Dispatch prototype and the PRD? (Drew Weeks to send)

## Differs from knowledge base

- Substitution Service runs about every 5 minutes — absent (`process.md` names the substitution import, PE/156794883, without a period); check against `repos/BusPlannerUnified/data-services.md` before relying on it
- Dispatch dashboard "replaces" the Substitution Service — absent

## Confirms

- Substitutions flow from Old World into New World through the substitution import — `domain.md` (GPS+ Route Management), `process.md` health check Q.4
- New World Dispatch V1: one board (Gantt + Table), absences, cover — `confluence-prd.md` (PRD draft v0.14)

## Action items

- [ ] Email Substitution Service notes, Dispatch prototype link and PRD to Sharaiz Khan and Ibrahim Usman — owner: Drew Weeks — [26:39](https://fathom.video/calls/909812875?timestamp=1599)
- [ ] Follow-up deep-dive sessions after the material is read — owner: Drew Weeks, Sharaiz Khan, Ibrahim Usman — [29:40](https://fathom.video/calls/909812875?tab=summary&timestamp=1780)
