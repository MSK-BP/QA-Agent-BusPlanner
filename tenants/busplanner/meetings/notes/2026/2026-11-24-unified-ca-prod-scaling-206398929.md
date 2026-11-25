# Unified Canadian production scaling (2026-11-24)

- **Recording:** https://fathom.video/calls/911670974
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Environments and access, GPS readers, Notifications and two-way sync, ETL

## Decisions

- Canadian prod onboarding: bring up the next five clients (two around 2026-11-30 / 12-01, three on 2026-12-07), then pause until scaling is in place; otherwise HRCE is at risk from overload — owner: Shikhar Patel, Andy Tompkins — decided — [32:40](https://fathom.video/calls/911670974?timestamp=1960), [33:02](https://fathom.video/calls/911670974?timestamp=1982)
- API pods get CPU-based auto-scaling (example: add a pod at 60% average CPU, remove below 30%) — owner: Daniel Sukhram — decided — [18:05](https://fathom.video/calls/911670974?timestamp=1085)
- Daniel Sukhram checks the SQL Server resources and recommends scale-up (more cores/RAM) or scale-out (second server) — owner: Daniel Sukhram — decided — [21:49](https://fathom.video/calls/911670974?timestamp=1309)
- Shikhar Patel designs GPS Reader auto-scaling and compares it with manual pod assignment; the GPS Reader goes first; Stop Classification may need another approach; Substitution Service scaling moves into the two-way sync work — owner: Shikhar Patel — decided — [21:49](https://fathom.video/calls/911670974?timestamp=1309), [22:34](https://fathom.video/calls/911670974?timestamp=1354)
- US and Canadian environments keep the same architecture and configuration; rollout of changes may be staggered — owner: Andy Tompkins — decided — [24:23](https://fathom.video/calls/911670974?timestamp=1463)
- Aligning Canada's dev/stage namespaces with the US separate clusters is done with the work to build QA environments — owner: Andy Tompkins — decided — [25:29](https://fathom.video/calls/911670974?timestamp=1529)

## Positions and concerns

- **Capacity numbers:** Shikhar Patel, from peak ETL-load usage reviewed with Claude: Canadian prod supports "three more clients" before scaling is a must; later in the meeting the group agreed the next five planned clients are acceptable; Tommy Zwirblia: there are six today. Michel Walther: "we are so close to reach the limits" — [01:39](https://fathom.video/calls/911670974?timestamp=99), [33:02](https://fathom.video/calls/911670974?timestamp=1982), [33:45](https://fathom.video/calls/911670974?timestamp=2025), [34:00](https://fathom.video/calls/911670974?timestamp=2040)
- **GPS Reader unit of work:** Shikhar Patel: the unit must be a client-provider pair with stickiness, since each pod authenticates with the GPS provider; with fixed clients per pod the pods do not scale up or down. Andy Tompkins: consider time-boxed chunks (for example hours) so load can move between pods and scale down at night; he wants auto-scaling "sooner rather than later". Both agreed one client's provider is never split across pods — [12:00](https://fathom.video/calls/911670974?timestamp=720), [12:48](https://fathom.video/calls/911670974?timestamp=768), [14:20](https://fathom.video/calls/911670974?timestamp=860), [15:49](https://fathom.video/calls/911670974?timestamp=949), [27:49](https://fathom.video/calls/911670974?timestamp=1669)
- **SQL Server:** Shikhar Patel: add a second SQL Server soon. Andy Tompkins: fewer servers is simpler; if the server is small, add cores first. Daniel Sukhram: the clusters were sized for testing and need review — [05:26](https://fathom.video/calls/911670974?timestamp=326), [20:19](https://fathom.video/calls/911670974?timestamp=1219), [20:51](https://fathom.video/calls/911670974?timestamp=1251)
- **Stop Classification:** Michel Walther: its single-pod cache and its pull of all BP Info assignments block horizontal scaling without queues — [07:53](https://fathom.video/calls/911670974?timestamp=473), [23:10](https://fathom.video/calls/911670974?timestamp=1390)
- **Environment drift:** Daniel Sukhram dislikes Canada using namespaces for dev and stage; it makes troubleshooting differ from the US — [24:42](https://fathom.video/calls/911670974?timestamp=1482)

## Rules and facts

- GPS Reader, GPS Substitution Service and Stop Classification cannot split work: a second pod repeats all of the first pod's work — stated (Shikhar Patel, Andy Tompkins) — [05:39](https://fathom.video/calls/911670974?timestamp=339), [06:16](https://fathom.video/calls/911670974?timestamp=376)
- The GPS Reader is the busiest of the three services — stated — [07:01](https://fathom.video/calls/911670974?timestamp=421)
- The ETL load is the busiest daily action on the SQL Server; loads are staggered and must finish before buses start — stated — [04:50](https://fathom.video/calls/911670974?timestamp=290)
- Canada: dev and stage share one Kubernetes cluster; prod is a separate cluster. US: one cluster per environment — stated — [18:05](https://fathom.video/calls/911670974?timestamp=1085), [25:02](https://fathom.video/calls/911670974?timestamp=1502)
- Canada API pods: dev 1, stage 2, prod 3 — stated — [18:05](https://fathom.video/calls/911670974?timestamp=1085)
- ETL Extract runs on Old World SaaS machines, so it is not limited by New World capacity — stated — [32:25](https://fathom.video/calls/911670974?timestamp=1945)
- Proposed design: one leader SQL Server holds the Client Registry; client databases on other servers; each GPS pod leases a client for 60 s and renews; an expired lease is picked up by a new pod — tentative — [01:39](https://fathom.video/calls/911670974?timestamp=99)

## Plans

- PLANNED: a channel for scaling updates and SQL usage; a follow-up meeting in about a week — decided — [34:28](https://fathom.video/calls/911670974?timestamp=2068), [35:00](https://fathom.video/calls/911670974?timestamp=2100)
- PLANNED: onboarding schedule — Tri-County nearly done, Attridge started, South Shore ETL Extract next — stated — [31:10](https://fathom.video/calls/911670974?timestamp=1870)

## Defects and risks

- Risk: Canadian prod near capacity; overload could affect HRCE — [33:02](https://fathom.video/calls/911670974?timestamp=1982)
- Risk for QA: auto-scaling and multi-pod GPS services change behaviour after deploys and under load; test lease expiry and pod restart when built

## Open questions

- Is GPS Reader auto-scaling needed now, or is manual pod assignment enough at first?
- Scale the SQL Server up or out?

## Differs from knowledge base

- Capacity limit and onboarding pause after five more clients; API auto-scaling planned — absent (`architecture.md`, `environments.md`)
- Canada API pod counts and US one-cluster-per-environment — absent (`confluence.md` has only the CA staging namespace)

## Confirms

- GPS services run as a single pod with no leader election or sharding; per-customer lease proposed, not built — `confluence.md` (line on single pod and lease)
- Canada staging runs in namespace `busplanner-staging` on the dev cluster — `confluence.md`

## Action items

- [ ] API auto-scaling rules for Canadian prod — owner: Daniel Sukhram — [17:35](https://fathom.video/calls/911670974?timestamp=1055)
- [ ] SQL Server scale-up vs scale-out recommendation — owner: Daniel Sukhram — [21:49](https://fathom.video/calls/911670974?timestamp=1309)
- [ ] GPS Reader auto-scaling design vs manual — owner: Shikhar Patel — [21:49](https://fathom.video/calls/911670974?timestamp=1309)
- [ ] Create the scaling channel — owner: Daniel Sukhram — [34:50](https://fathom.video/calls/911670974?timestamp=2090)
- [ ] Follow-up meeting in about a week — owner: Andy Tompkins — [35:00](https://fathom.video/calls/911670974?timestamp=2100)
- [ ] Jira items for each task — owner: all — [27:49](https://fathom.video/calls/911670974?timestamp=1669)
