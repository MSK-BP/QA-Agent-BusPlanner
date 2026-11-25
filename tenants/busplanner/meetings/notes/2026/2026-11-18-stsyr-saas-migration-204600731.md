# STSYR SaaS migration and driver tablets (2026-11-18)

- **Recording:** https://fathom.video/calls/905012200
- **Class:** qa-context
- **Source read:** summary
- **Areas:** Old World SaaS migration, Mobile apps

Commercial terms (quote, pricing, billing) were discussed and are left out.

## Decisions

- None final. STSYR is exploring the move from its on-premise server to BusPlanner SaaS; it will review a migration plan internally — stated — [01:15](https://fathom.video/calls/905012200?tab=summary&timestamp=75)

## Rules and facts

- The SaaS migration process: build a new SaaS environment in parallel from data snapshots (2–3 weeks, no disruption), the customer tests it, then a scheduled cutover of 0.5–2 hours downtime moves production data — stated (summary only) — [09:03](https://fathom.video/calls/905012200?tab=summary&timestamp=543), [09:50](https://fathom.video/calls/905012200?tab=summary&timestamp=590), [10:35](https://fathom.video/calls/905012200?tab=summary&timestamp=635)
- BusPlanner needs access to the current server to analyse and migrate the data — stated (summary only) — [11:51](https://fathom.video/calls/905012200?tab=summary&timestamp=711)
- After the move, the member boards must send SIS data uploads to the SaaS SFTP site — stated (summary only) — [07:19](https://fathom.video/calls/905012200?tab=summary&timestamp=439)
- To keep its current custom URL, the customer updates DNS and provides an SSL certificate — stated (summary only) — [12:47](https://fathom.video/calls/905012200?tab=summary&timestamp=767)
- Driver tablets: the customer plans to require tablets through operator contract addenda; operators buy and own the hardware and software; about 800 routes — stated (summary only) — [18:39](https://fathom.video/calls/905012200?tab=summary&timestamp=1119), [19:03](https://fathom.video/calls/905012200?tab=summary&timestamp=1143)
- BusPlanner gives tablet specs so operator purchases are compatible with its driver app (the AI summary names the app "Fathom app"; the real app name is not confirmed) — stated (summary only) — [23:30](https://fathom.video/calls/905012200?tab=summary&timestamp=1410)

## Plans

- PLANNED: STSYR SaaS implementation in the summer — tentative — [28:37](https://fathom.video/calls/905012200?tab=summary&timestamp=1717)
- PLANNED: confirm the Samsara GPS integration scope for the apps — owner Brian Moroz — tentative — [25:37](https://fathom.video/calls/905012200?timestamp=1537)

## Defects and risks

- Risk: SIS uploads that keep going to the old server after cutover would leave SaaS data stale — [07:19](https://fathom.video/calls/905012200?tab=summary&timestamp=439)

## Open questions

- Does the Samsara integration cover the driver apps (Turns) or only GPS+?
- Which tablet hardware specs will be published, and does QA have a matching device?

## Differs from knowledge base

- STSYR plans a move from on-premise to SaaS vs `knowledge/jira/eng-1601-2000.md`: ENG-1997 describes STSYR on its own Hyper-V and SQL 2022 server — updates (tentative, summer)
- A customer production URL was named in this meeting. It is not written here; it must go in `blocked-patterns.txt` — absent
- Samsara for STSYR apps vs `knowledge/jira/eng-0401-0800.md`: ENG-518 names Zonar/Landmark units for STSYR — updates (unconfirmed)

## Confirms

- Same SaaS migration pattern as STEO: parallel build, customer validation, short cutover — `meetings/notes/2026/2026-11-16-steo-saas-implementation-203613006.md` (meeting base, not `knowledge/`)
- Unified GPS reader supports Samsara — `knowledge/domain.md` (via `confluence-prd.md`)

## Action items

- [ ] Send the migration plan and call summary — owner: Brian Moroz — [03:32](https://fathom.video/calls/905012200?timestamp=212)
- [ ] Send the security and privacy FAQ — owner: Brian Moroz — [15:37](https://fathom.video/calls/905012200?timestamp=937)
- [ ] Send tablet specs — owner: Brian Moroz — [19:33](https://fathom.video/calls/905012200?timestamp=1173)
- [ ] Confirm Samsara GPS integration scope for the apps — owner: Brian Moroz — [25:37](https://fathom.video/calls/905012200?timestamp=1537)
