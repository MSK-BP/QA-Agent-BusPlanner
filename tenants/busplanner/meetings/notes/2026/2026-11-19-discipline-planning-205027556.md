# Discipline Planning (2026-11-19)

- **Recording:** https://fathom.video/calls/908449104 (also recorded as 205027680, 205027431, 205027079, 205026408)
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Ride Support (Discipline), Mobile apps, Agentic development, QA process and priorities

## Decisions

- V1 starts from features: Drew Weeks's feature list is the base for V1 scope — owner: Tommy Zwirblia — decided — [02:26](https://fathom.video/calls/908449104?timestamp=146)
- Referrals can be started from Turns, the Unified website and the desktop site; the website can do everything (a driver may ask the office to create one) — owner: Tommy Zwirblia — decided — [06:54](https://fathom.video/calls/908449104?timestamp=414)
- Out of V1: letters/messages to the family (needs two-way Chipmunk messaging), any Chipmunk change ("not even one-way messaging"), push-back to an SIS, incident reports for emergency services — owner: Tommy Zwirblia — decided — [07:24](https://fathom.video/calls/908449104?timestamp=444), [11:30](https://fathom.video/calls/908449104?timestamp=690)
- V1 tracks manual family contact only as a checkbox and date on the website ("I did send an email") — owner: Tommy Zwirblia — decided — [08:34](https://fathom.video/calls/908449104?timestamp=514)
- First build step is mobile: a "Referrals" button on the Turns menu; it opens a referral-only page with a New referral button and the driver's own referrals with status; quick 2–3 click start, finish later, flag incomplete ones — owner: Tommy Zwirblia; UI Matthew Hayes — decided — [14:14](https://fathom.video/calls/908449104?timestamp=854), [19:00](https://fathom.video/calls/908449104?timestamp=1140)
- Referrals button follows the Navigation and Pre/Post Inspection pattern: username/password sign-in if not signed in; not the PIN pattern of Clock in/out — owner: Stephen Hu, Tommy Zwirblia — decided — [22:00](https://fathom.video/calls/908449104?timestamp=1320), [23:28](https://fathom.video/calls/908449104?timestamp=1408)
- Referral forms are stored as JSON in the database; Turns pulls the referral JSON templates and sends the completed JSON back; API writes it into the current schema — owner: Drew Weeks (coordinates Emran Moradian, Stephen Hu) — decided — [14:14](https://fathom.video/calls/908449104?timestamp=854), [27:25](https://fathom.video/calls/908449104?timestamp=1645)
- Development process: Tommy Zwirblia writes a Claude-built PRD as epics and stories; check for gaps with Claude before coding; requirements and decisions live as markdown in the repo — owner: Tommy Zwirblia — decided — [27:25](https://fathom.video/calls/908449104?timestamp=1645), [38:00](https://fathom.video/calls/908449104?timestamp=2280)

## Positions and concerns

- **Name:** Matthew Hayes avoids a negative word ("discipline") and used "Ride Support". Tommy Zwirblia: Ride Support may later be the container (referrals, seating chart) in the new driver experience; the praise/discipline/concern piece needs its own name now. Outcome: Matthew Hayes asks Josh — [25:25](https://fathom.video/calls/908449104?timestamp=1525), [26:10](https://fathom.video/calls/908449104?timestamp=1570)
- **Concern path:** a concern is a confidential form seen only by district and school counsellors, with its own workflow — stated (Tommy Zwirblia) — [08:34](https://fathom.video/calls/908449104?timestamp=514)
- **PRD priorities:** Stephen Hu holds that Claude stalls on corner cases unless the PRD states priorities. Matthew Hayes uses prototype-plus-PRD loops so Claude finds gaps. Jon Borromeo holds that business and functional requirements and past decisions (also superseded ones) must be markdown in the code base, not Word/CSV hand-offs — [34:00](https://fathom.video/calls/908449104?timestamp=2040), [36:39](https://fathom.video/calls/908449104?timestamp=2199), [43:04](https://fathom.video/calls/908449104?timestamp=2584)
- **Source of truth:** Tommy Zwirblia asks how the PRD as source of truth relates to repo markdown. Jon Borromeo proposes syncing Confluence and repo markdown through the Atlassian connector, latest change wins. Outcome: open — [40:30](https://fathom.video/calls/908449104?timestamp=2430), [41:10](https://fathom.video/calls/908449104?timestamp=2470)
- **Small pieces:** Stephen Hu notes a small chunk is also a small chunk to QA; Tommy Zwirblia wants the module to leave a reusable template for PRD, build and QA — [32:34](https://fathom.video/calls/908449104?timestamp=1954), [32:51](https://fathom.video/calls/908449104?timestamp=1971)

## Rules and facts

- Turns menu today: Navigation, Pre/Post Inspection, Clock in/out; the client is chosen once on first start — stated — [21:09](https://fathom.video/calls/908449104?timestamp=1269), [21:18](https://fathom.video/calls/908449104?timestamp=1278)
- Chipmunk to Web messaging is one-way today — stated (Stephen Hu) — [07:24](https://fathom.video/calls/908449104?timestamp=444)
- Matthew Hayes's mobile mock-ups do not match today's Turns — stated — [11:30](https://fathom.video/calls/908449104?timestamp=690)

## Plans

- PLANNED: lightweight Turns prototype of the Referrals page — owner Matthew Hayes — decided — [45:44](https://fathom.video/calls/908449104?timestamp=2744)
- PLANNED: then the same function on the website, starting with "create a referral" — owner Tommy Zwirblia — tentative — [27:25](https://fathom.video/calls/908449104?timestamp=1645)
- PLANNED: form builder built beside the mobile piece (Claude rated it standalone) — tentative — [27:25](https://fathom.video/calls/908449104?timestamp=1645)
- PLANNED: Tommy Zwirblia packages the PRD, schema and JSON template into a repo and hands off — decided — [44:48](https://fathom.video/calls/908449104?timestamp=2688)

## Terms

- **PDC / "PDFC"**: joke working name for the praise/discipline/concern function.

## Open questions

- Final name of the praise/discipline/concern function?
- Is the concern form in V1, and who sees it?
- Is reporting (feature 10) in V1? (SIS push-back, 9, is out)

## Differs from knowledge base

- V1 has no family letters or messages and no Chipmunk change; family contact is a manual checkbox and date vs `knowledge/domain.md`: Discipline users include "families (letters only)", and `knowledge/confluence-prd.md` V1 spec — updates (V1 scope narrowed)
- Requirements source of truth moves to repo markdown with Claude-built epics vs `knowledge/domain.md`: spec is the Confluence "PRD · Ride Support V1" v0.7 — updates (tentative on sync rules)

## Confirms

- Turns sign-in as a person (username/password), T&A PIN kept for the clock — `knowledge/confluence-prd.md` (TU-R sign-in)
- Turns is a .NET MAUI app — `knowledge/repos/Apps.md`

## Action items

- [ ] Add Referrals button to the Turns menu with sign-in; build the referral page — owner: Matthew Hayes — [12:24](https://fathom.video/calls/908449104?timestamp=744)
- [ ] Referral JSON schema, sample forms, API to save JSON, wire mobile — owner: Drew Weeks — [15:49](https://fathom.video/calls/908449104?timestamp=949)
- [ ] Agree the module name with Josh — owner: Matthew Hayes — [25:59](https://fathom.video/calls/908449104?timestamp=1559)
- [ ] Draft the Claude PRD (mobile first), then repo markdown, review with Jon Borromeo — owner: Tommy Zwirblia — [29:41](https://fathom.video/calls/908449104?timestamp=1781)
- [ ] Package and hand off materials to the repo — owner: Tommy Zwirblia — [44:37](https://fathom.video/calls/908449104?timestamp=2677)
