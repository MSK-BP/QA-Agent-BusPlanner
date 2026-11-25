# New World Branching Strategy (2026-11-23)

- **Recording:** https://fathom.video/calls/910281587
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Release and branching, QA process and priorities, Database migrations, Environments and access

## Decisions

- Keep `main` / `stage` / `dev`. A feature branch comes off `dev`, gets code review, is deployed to a QA environment, and merges to `dev` only after QA passes. `dev` = integration testing, `stage` = regression, `main` = production; `dev` stays releasable — owner: Andy Tompkins, Shikhar Patel — decided — [03:35](https://fathom.video/calls/910281587?timestamp=215), [16:02](https://fathom.video/calls/910281587?timestamp=962), [18:41](https://fathom.video/calls/910281587?timestamp=1121)
- No trunk with release branches: BusPlanner does not support several releases at once; it upgrades customers — owner: Andy Tompkins, Shikhar Patel — decided — [16:28](https://fathom.video/calls/910281587?timestamp=988), [17:31](https://fathom.video/calls/910281587?timestamp=1051)
- Hotfix: either branch from `main` and back-merge, or the current way (fix in `dev`, cherry-pick to stage and main); both are acceptable. A hotfix branch is tested by deploying it to a QA environment — owner: Andy Tompkins — stated — [06:47](https://fathom.video/calls/910281587?timestamp=407), [07:32](https://fathom.video/calls/910281587?timestamp=452)
- The team accepts more merge conflicts (including migration-number clashes) as the cost of a stable `dev` — owner: Mitchell Bland, Shikhar Patel — stated — [29:39](https://fathom.video/calls/910281587?timestamp=1779), [31:15](https://fathom.video/calls/910281587?timestamp=1875)
- New pipelines use GitHub Actions; a GitHub organisation is needed first; it is also needed for QA automation (Playwright) — owner: Andy Tompkins — decided — [36:15](https://fathom.video/calls/910281587?timestamp=2175), [37:16](https://fathom.video/calls/910281587?timestamp=2236)
- QA speed is a separate problem and gets its own discussion — owner: Nikki Tilano, Andy Tompkins — decided — [13:57](https://fathom.video/calls/910281587?timestamp=837)

## Positions and concerns

- **Root cause is QA capacity, not branching:** Mitchell Bland: QA takes 3–4 hours per ticket (from Nikki Tilano); he tests chatbot items in 45 minutes or less; branching does not fix capacity. Andy Tompkins agrees but still wants QA before merge — [08:30](https://fathom.video/calls/910281587?timestamp=510), [14:20](https://fathom.video/calls/910281587?timestamp=860)
- **Why Old World QA is slow (Nikki Tilano):** 50–60% of tester time is setup (1–2 hours or more per item: configurations, databases); QA notes are convoluted; testers depend on developers; they lack context for developer-found bugs. No Old World automation is planned soon — [10:00](https://fathom.video/calls/910281587?timestamp=600)
- **Developer-found bugs:** Shikhar Patel: many bugs are found and fixed by developers, so QA must learn them from Jira. Ibrahim Usman proposes the bug first goes to QA to reproduce while the developer fixes it — [11:44](https://fathom.video/calls/910281587?timestamp=704), [12:14](https://fathom.video/calls/910281587?timestamp=734)
- **Migrations:** Mitchell Bland: a migration number taken by an earlier PR forces renumbering; QA-before-merge makes it worse, and a low-priority migration can block later ones. Andy Tompkins floated a migration coordinator or a review gate on migration files; Shikhar Patel says it is hard to make people follow (Old World version messages get forgotten). Left as accepted risk — [24:49](https://fathom.video/calls/910281587?timestamp=1489), [27:07](https://fathom.video/calls/910281587?timestamp=1627), [27:54](https://fathom.video/calls/910281587?timestamp=1674)
- **Epic branches:** Sharaiz Khan recalls the previous meeting's point: test related tickets of one epic together on one feature branch to reduce conflicts — [33:35](https://fathom.video/calls/910281587?timestamp=2015)
- **QA gate mechanics (Shikhar Patel's picture, not built):** a PR to `dev` passes code review, then the tester named on the Jira ticket presses "deploy" to their own environment (for example one per tester), tests, approves in Jira, then the PR merges. Mitchell Bland asked how testers avoid collisions — tentative — [20:27](https://fathom.video/calls/910281587?timestamp=1227), [20:54](https://fathom.video/calls/910281587?timestamp=1254)

## Rules and facts

- Today Shikhar Patel deploys New World by asking Claude which products changed since the last deploy, then deploys those; SQL migrations are applied by hand on dev, stage and production — stated — [23:17](https://fathom.video/calls/910281587?timestamp=1397)
- New World has no versioning strategy; tags such as v1 cannot be used until one is agreed — stated — [18:06](https://fathom.video/calls/910281587?timestamp=1086)
- New World build and deploy is "much easier" than Old World — stated — [35:28](https://fathom.video/calls/910281587?timestamp=2128)

## Plans

- PLANNED: a few standing QA environments first; automatic per-branch environments later — tentative — [03:35](https://fathom.video/calls/910281587?timestamp=215)
- PLANNED: smarter pipelines: one-click branch deploy, deploy only changed products, SQL schema pipeline — tentative — [23:17](https://fathom.video/calls/910281587?timestamp=1397)
- PLANNED: Shikhar Patel shows Lee and Yusra Abbasi New World build and deploy before his leave — decided — [35:28](https://fathom.video/calls/910281587?timestamp=2128)
- PLANNED: strategy posted in Slack for async objections — decided — [37:16](https://fathom.video/calls/910281587?timestamp=2236)

## Open questions

- New World versioning strategy?
- How many QA environments, and how does a tester claim one without collisions?

## Differs from knowledge base

- QA before merge to `dev`; `dev` = integration, `stage` = regression — contradicts `process.md` Old World flow ("whole `dev` branch promoted to `stage`"; functional QA on QA1) for New World; confirms the 2026-11-19 meeting decision
- 50–60% of Old World QA time is setup — absent (`test-strategy.md`)
- SQL migrations applied by hand in every environment — absent (`architecture.md` CI/CD)
- GitHub Actions for New World pipelines — absent (`architecture.md`)

## Confirms

- Branch names `dev` / `staging` / `main` for BP Unified — `process.md` (the meeting says "stage")
- No release branch per version — meetings INDEX, 2026-11-19

## Action items

- [ ] Train Lee and Yusra Abbasi on New World build and deploy — owner: Shikhar Patel — [34:39](https://fathom.video/calls/910281587?timestamp=2079)
- [ ] Ask Dan for a GitHub organisation; invite the team — owner: Andy Tompkins — [36:27](https://fathom.video/calls/910281587?timestamp=2187)
- [ ] Post the branching strategy in Slack for review — owner: Andy Tompkins — [37:30](https://fathom.video/calls/910281587?timestamp=2250)
