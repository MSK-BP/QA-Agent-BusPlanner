# GPS+ projects/engineering leadership sync (2026-11-24)

- **Recording:** https://fathom.video/calls/911670991
- **Class:** qa-core
- **Source read:** summary only
- **Areas:** GPS readers, GPS+ Route Management, GPS+ Live Viewer, ETL, Environments and access

## Decisions

- Whether the new GPS+ can run with the old Chipmunk parent app is decided after internal testing on 2026-11-25; it matters for Parkland and Sturgeon — owner: not named — tentative — [31:25](https://fathom.video/calls/911670991?timestamp=1885), [31:50](https://fathom.video/calls/911670991?timestamp=1910)
- Caroline and Barry learn the full GPS+ setup workflow (steps 1-5) in supervised hands-on sessions: 2026-11-25 SSRCE (ETL skill), 2026-11-26 Attridge / Wellington Dufferin (steps 2-4), 2026-11-30 South Shore (GPS reader skill) — owner: Andy Tompkins — decided (summary only) — [12:21](https://fathom.video/calls/911670991?timestamp=741), [25:21](https://fathom.video/calls/911670991?timestamp=1521)

## Rules and facts

- US clients need the new GPS+ and the new Dispatch migrated together; they depend on each other — stated — [33:07](https://fathom.video/calls/911670991?timestamp=1987)
- The GPS+ reader architecture can take about 5 more clients; horizontal scaling work is in progress — stated — [28:49](https://fathom.video/calls/911670991?timestamp=1729), [30:22](https://fathom.video/calls/911670991?timestamp=1822)
- Halifax is fully migrated; its old GPS+ is decommissioned — stated — [08:32](https://fathom.video/calls/911670991?timestamp=512)
- Niagara has 15 readers in the New World vs 12 in the Old World; data cleanup to confirm which are relevant — stated — [09:30](https://fathom.video/calls/911670991?timestamp=570)
- Landmark waits for the new Vehicle Assignments page — stated — [09:55](https://fathom.video/calls/911670991?timestamp=595)
- Tri-County reader setup nearly complete; data flowing; vehicle mapping can start — stated — [10:04](https://fathom.video/calls/911670991?timestamp=604)
- One client's Voyago operator is ready for go-live; its Attridge and First Student operators wait for reader setup; go live now or all together is open — stated — [05:43](https://fathom.video/calls/911670991?timestamp=343), [06:23](https://fathom.video/calls/911670991?timestamp=383)
- Wellington Dufferin is blocked waiting for reader credentials for 5 operators (Zonar, GTS); a database backup and the credentials are requested instead of a screen-share. South Shore Zonar credentials are copied from the Old World to the New World during a server visit. Credentials handled out of band; none recorded here — stated — [21:44](https://fathom.video/calls/911670991?timestamp=1304), [24:27](https://fathom.video/calls/911670991?timestamp=1467), [19:43](https://fathom.video/calls/911670991?timestamp=1183)

## Defects and risks

- Risk: reader capacity close to its limit (about 5 more clients) — [28:49](https://fathom.video/calls/911670991?timestamp=1729)
- Risk: Chipmunk compatibility with the new GPS+ unknown until tested — [31:25](https://fathom.video/calls/911670991?timestamp=1885)

## Open questions

- Can the new GPS+ run with the old Chipmunk parent app?

## Differs from knowledge base

- Capacity "about 5 more clients" here vs "three more clients" (then "next five") in the scaling meeting the same day — both meeting statements; no knowledge line
- New GPS+ and Dispatch must migrate together for US clients — absent (`domain.md`)
- Halifax old GPS+ decommissioned — absent

## Confirms

- Unified reader replaces Old World readers per client (2026-11-16 meeting); clients named are in `knowledge/`

## Action items

- [ ] Request Wellington Dufferin credentials or database backups — owner: Ahnaf Rahman — [24:54](https://fathom.video/calls/911670991?timestamp=1494)
- [ ] Niagara data cleanup meeting — owner: Ahnaf Rahman — [09:00](https://fathom.video/calls/911670991?timestamp=540)
- [ ] Training sessions; Monday GPS reader training — owner: Andy Tompkins, Jennifer Murphy — [16:14](https://fathom.video/calls/911670991?timestamp=974), [17:56](https://fathom.video/calls/911670991?timestamp=1076)
- [ ] Update the rollout tracker — owner: Ahnaf Rahman — [28:12](https://fathom.video/calls/911670991?timestamp=1692)
