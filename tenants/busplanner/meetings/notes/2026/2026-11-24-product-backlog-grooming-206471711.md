# Product backlog grooming (2026-11-24)

- **Recording:** https://fathom.video/calls/911670994
- **Class:** qa-core
- **Source read:** summary only
- **Duplicates skipped:** 206468689
- **Areas:** Release and branching, Stop boundaries, Auth, GPS+ Live Viewer, Chatbot

## Decisions

- 13.5.2 is the last Old World release of the year, 2026-12-15, to lower upgrade risk over the holiday; code freeze 2026-12-04; QA complete and promote to staging 2026-12-09 — owner: Murtaza Khalil — decided — [03:00](https://fathom.video/calls/911670994?timestamp=180), [05:14](https://fathom.video/calls/911670994?timestamp=314)
- PGCPS top priorities: Aerial Map (OpenStreetMap), then parent notification letters — owner: not named — stated — [00:45](https://fathom.video/calls/911670994?timestamp=45)

## Positions and concerns

- **Aerial Map timing:** a 2-week effort, tight for 2026-12-15; proposal: delay ENG-3023 and ENG-3025 so Ibrahim can start it, if Gaston ENG-2866 is done by Thursday — tentative — [08:08](https://fathom.video/calls/911670994?timestamp=488), [09:13](https://fathom.video/calls/911670994?timestamp=553), [10:16](https://fathom.video/calls/911670994?timestamp=616)
- **New World user management (PROD-997):** the current UI is unusable for customers; fixing it now would delay other projects such as Chatbot. Proposed phases: (1) a separate "customer admin" role without feature-flag access and the current UI moved to Settings; (2) a simpler role-based UI (Admin, Standard). Not decided; Tommy Zwirblia and Andy Tompkins review the prototype and PRD — tentative — [18:11](https://fathom.video/calls/911670994?timestamp=1091), [18:53](https://fathom.video/calls/911670994?timestamp=1133), [24:43](https://fathom.video/calls/911670994?timestamp=1483)
- **New GPS+ viewer for Chipmunk clients:** asked for a Chipmunk client; risk: the new viewer has no vehicle management page, which Chipmunk substitutions and alerts need; a deep dive follows — [12:35](https://fathom.video/calls/911670994?timestamp=755), [12:48](https://fathom.video/calls/911670994?timestamp=768)

## Defects and risks

- PROD-623 sprint/start-date mismatch in Jira (from a duplicate recording's action items) — [12:12](https://fathom.video/calls/911392186?timestamp=732)

## Open questions

- Is PROD-997 phase 1 prioritised now?
- Can Chipmunk clients use the new GPS+ viewer before the vehicle management page exists?

## Differs from knowledge base

- Code freeze 2026-12-04, QA complete and staging 2026-12-09, release 2026-12-15 — updates `process.md` (no freeze; `confluence.md`: "A calendar freeze was rejected")
- PROD-997 customer admin role and phased user management — absent (`domain.md` Users and Access PRD row, final 2026-10-26)
- PGCPS Aerial Map priority — absent (`jira/other-projects.md` has only PROD-159 GeoTIFF aerial imagery for another client)

## Confirms

- ENG-2866 Gaston boundary map print, deadline 2026-12-15 — `jira/eng-2801-latest.md`

## Action items

- [ ] Update the PGCPS schedule page; confirm 12-15 scope with Ahnaf Rahman — owner: Murtaza Khalil — [01:59](https://fathom.video/calls/911670994?timestamp=119)
- [ ] Confirm Ibrahim can start Aerial Map after ENG-2866 — owner: Murtaza Khalil — [10:05](https://fathom.video/calls/911670994?timestamp=605)
- [ ] Send PROD-997 PRD and prototype to Tommy Zwirblia and Andy Tompkins — owner: Ahnaf Rahman — [23:29](https://fathom.video/calls/911670994?timestamp=1409)
- [ ] PROD-997 priority with Umar Mir — owner: Ahnaf Rahman, Tommy Zwirblia — [27:19](https://fathom.video/calls/911670994?timestamp=1639)
- [ ] Review chatbot filter; reprioritise — owner: Ahnaf Rahman, Awais Akram — [02:17](https://fathom.video/calls/911670994?timestamp=137)
