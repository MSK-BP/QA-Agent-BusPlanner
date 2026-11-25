# Support and Engineering daily huddle (2026-11-24)

- **Recording:** https://fathom.video/calls/911670983
- **Class:** qa-core
- **Source read:** summary only
- **Duplicates skipped:** 206427972
- **Areas:** Old World defects, QA process and priorities

## Decisions

- SPT-937 is a hotfix candidate: it affects three clients and one has escalated twice; a developer is assigned today with a time-box; rule out data causes (for example inactive runs) first — owner: Murtaza Khalil — decided (summary only) — [01:55](https://fathom.video/calls/911670983?timestamp=115), [04:21](https://fathom.video/calls/911670983?timestamp=261), [04:48](https://fathom.video/calls/911670983?timestamp=288)

## Positions and concerns

- **SPT-1013 (time shift on a self-hosted client server):** likely a client IT issue, not a BusPlanner defect; Chris MacLeod asks what is affected (GPS data or all system times) and the server OS and time zone — stated (summary only) — [06:19](https://fathom.video/calls/911670983?timestamp=379), [07:05](https://fathom.video/calls/911670983?timestamp=425)

## Rules and facts

- A CSM training deck on the Product/Engineering/CX workflow uses a RACI matrix, bug and feature-request flows, and guidance on Claude for logging feature requests — stated — [13:30](https://fathom.video/calls/911670983?timestamp=810), [17:10](https://fathom.video/calls/911670983?timestamp=1030)

## Defects and risks

- SPT-937: BP Info run data missing for a third party; three clients; hotfix candidate — [01:55](https://fathom.video/calls/911670983?timestamp=115)
- Tri-County ticket spoken as "Engineering 3.1.1.9" (key unclear); Janice investigating — [00:52](https://fathom.video/calls/911670983?timestamp=52)
- SPT-997 (Regina and another client): recurring; planning in progress — [05:32](https://fathom.video/calls/911670983?timestamp=332)
- Toronto: backup failure from low disk space on the database drive (cleanup waits for the client); failed-task and maintenance alert emails not received — Andy Tompkins checks the AWS email logs to see if the fault is ours or the client's mail server — [23:21](https://fathom.video/calls/911670983?timestamp=1401), [21:37](https://fathom.video/calls/911670983?timestamp=1297)
- A bug promised to Annapolis is in the January release (from a duplicate recording's action items) — [04:03](https://fathom.video/calls/911392182?timestamp=243)

## Open questions

- Which ticket is "Engineering 3.1.1.9"?

## Differs from knowledge base

- SPT-937 is a hotfix candidate affecting three clients — updates `jira/other-projects.md` ("SPT-937 | Bug | Backlog | HWSTS: BP Info REST API does not return some 2026-27 runs to a third-party")
- SPT-1013, Toronto backup and alert-email failures — absent (`jira/other-projects.md`)

## Action items

- [ ] Assign a developer to SPT-937; time-box; share an ETA — owner: Murtaza Khalil — [04:10](https://fathom.video/calls/911670983?timestamp=250)
- [ ] Ask the SPT-1013 client for details — owner: Chris MacLeod — [09:13](https://fathom.video/calls/911670983?timestamp=553)
- [ ] Send Andy Tompkins a failed-alert example (date, time, subject) — owner: Chris MacLeod — [23:05](https://fathom.video/calls/911670983?timestamp=1385)
- [ ] Add engineering slides to the CX deck — owner: Nikki Tilano — [20:02](https://fathom.video/calls/911392182?timestamp=1202)
- [ ] Review the CX deck — owner: Andy Tompkins — [18:45](https://fathom.video/calls/911670983?timestamp=1125)
