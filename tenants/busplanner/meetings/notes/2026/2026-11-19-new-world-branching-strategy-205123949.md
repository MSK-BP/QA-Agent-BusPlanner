# New World Branching Strategy (2026-11-19)

- **Recording:** https://fathom.video/calls/907244205
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Release and branching, QA process and priorities, Environments and access

## Decisions

- A client-facing feature branch is merged into `dev` only after it passed QA on that feature branch, deployed to its own environment. QA happens before the PR, not as part of approving it. `dev` stays releasable; no reverts or cherry-picks to prepare a release — owner: Andy Tompkins (agreed by Shikhar Patel, Jon Borromeo, Sharaiz Khan) — decided (in principle; strategy doc still being finalised) — [27:15](https://fathom.video/calls/907244205?timestamp=1635), [44:42](https://fathom.video/calls/907244205?timestamp=2682), [52:30](https://fathom.video/calls/907244205?timestamp=3150)
- Keep the `dev` → `stage` → `main` model with tags; no release branch per version, because BusPlanner does not support customers on old versions by choice — owner: Andy Tompkins, Shikhar Patel — decided — [32:00](https://fathom.video/calls/907244205?timestamp=1920), [35:23](https://fathom.video/calls/907244205?timestamp=2123)
- Skip lane (urgent changes that skip feature-branch QA) stays, but each use is decided case by case by a group, never by one developer alone — owner: Andy Tompkins — decided — [11:12](https://fathom.video/calls/907244205?timestamp=672)
- Dependent tickets of one epic: test each ticket branch, then the developers merge the QA-passed branches into an epic (integration) branch, deploy it for integration testing, then merge to `dev`. Developers create these branches and tell QA — owner: Andy Tompkins (proposed by Sharaiz Khan, Jon Borromeo) — decided — [36:13](https://fathom.video/calls/907244205?timestamp=2173), [38:48](https://fathom.video/calls/907244205?timestamp=2328)

## Positions and concerns

- **Skip lane examples:** Shikhar Patel's "orange" lane included the session timeout change (60 min → 12 h) and ENG-3124 (index on GPS event history), to stop PRs piling up. Andy Tompkins holds that the timeout change is client-facing and that an index on a large live table must be tested before prod; he prefers faster code review and more agentic QA over a wider skip lane. Outcome: examples rejected, lane kept with group approval — [01:53](https://fathom.video/calls/907244205?timestamp=113), [03:27](https://fathom.video/calls/907244205?timestamp=207), [06:20](https://fathom.video/calls/907244205?timestamp=380)
- **Skip lane mitigation:** Jon Borromeo proposes that every skip carries a rollback plan (for example a backup ready for an index change). Outcome: not decided — [05:15](https://fathom.video/calls/907244205?timestamp=315)
- **Divergence:** Jon Borromeo is concerned that gated feature branches will diverge and need careful dependency planning (stacked branches). Shikhar Patel holds that branches cut from `dev` with stacked PRs for coupled work keep divergence small. Outcome: accepted as merge-conflict work, which is easier than reverts — [19:18](https://fathom.video/calls/907244205?timestamp=1158), [21:35](https://fathom.video/calls/907244205?timestamp=1295)
- **QA environments:** Jon Borromeo proposes QA run the whole system locally from Docker Compose at any commit; for now one feature-branch environment per tester, so a tester works on one ticket at a time. Andy Tompkins wants more discussion of local containers. Outcome: open — [30:20](https://fathom.video/calls/907244205?timestamp=1820), [31:27](https://fathom.video/calls/907244205?timestamp=1887)
- **Integration timing:** Andy Tompkins does not want the first end-to-end integration test to happen in regression a few days before prod. Sharaiz Khan and Jon Borromeo answer that epic branches and `dev` give integration testing before `stage`. Outcome: agreed — [43:20](https://fathom.video/calls/907244205?timestamp=2600), [44:35](https://fathom.video/calls/907244205?timestamp=2675)
- **Code freeze:** Sharaiz Khan asks whether `dev` can have a code freeze; Jon Borromeo calls it a feature freeze: stakeholders choose which features enter `dev` for a release. Sharaiz Khan adds that named owners approve PRs into `dev`. Outcome: tentative — [45:47](https://fathom.video/calls/907244205?timestamp=2747), [52:39](https://fathom.video/calls/907244205?timestamp=3159)

## Rules and facts

- Today, feature branches merge into `dev`; functional QA runs on the dev environment from `dev`; regression runs on stage from the stage branch — stated (Andy Tompkins) — [15:32](https://fathom.video/calls/907244205?timestamp=932)
- Today QA can test only on `dev`; feature-branch testing is the prerequisite of the new flow and must be built — stated (Jon Borromeo, Andy Tompkins) — [28:32](https://fathom.video/calls/907244205?timestamp=1712), [30:16](https://fathom.video/calls/907244205?timestamp=1816)
- Modules without a broad customer base (Chatbot, Dispatch, Discipline) fall in the low-risk ("green/yellow") lanes — stated (Shikhar Patel) — [09:53](https://fathom.video/calls/907244205?timestamp=593)
- Self-hosted and SaaS clients run a mix of versions because upgrades are not done, not because clients refuse them — stated (Andy Tompkins) — [34:33](https://fathom.video/calls/907244205?timestamp=2073)
- Old World pipelines only build; New World pipelines build and some deploy, so pipelines are the main GitHub migration work — stated (Andy Tompkins), to confirm with Shikhar Patel — [50:43](https://fathom.video/calls/907244205?timestamp=3043)

## Plans

- PLANNED: Jon Borromeo updates the "New World Branching Strategy" document with these decisions, including epic/integration branching — decided — [47:24](https://fathom.video/calls/907244205?timestamp=2844)
- PLANNED: follow-up session (2026-11-20 or 2026-11-23) on naming, environments and tiers — owner Andy Tompkins — decided — [51:01](https://fathom.video/calls/907244205?timestamp=3061)
- PLANNED: GitHub migration doc compares Azure DevOps and GitHub features; little to migrate except pipelines — owner Jon Borromeo — tentative — [47:39](https://fathom.video/calls/907244205?timestamp=2859)

## Environments, access, release

- Feature-branch environments for QA do not exist yet; number of environments and deploy method are not decided — [27:15](https://fathom.video/calls/907244205?timestamp=1635)

## Defects and risks

- Risk: untested PRs on `dev` force reverts; a revert can break a QA-passed ticket that depends on it — [15:50](https://fathom.video/calls/907244205?timestamp=950), [16:15](https://fathom.video/calls/907244205?timestamp=975)
- Risk: until feature-branch environments exist, the QA-gated flow cannot start; QA becomes the bottleneck if environments are fewer than testers — [30:20](https://fathom.video/calls/907244205?timestamp=1820)

## Terms

- **Skip lane**: path for urgent, low-risk changes that skips feature-branch QA; colour lanes green/yellow/orange by risk.
- **Epic branch**: temporary branch that joins the QA-passed branches of one epic for integration testing before `dev`.

## Open questions

- How many feature-branch QA environments, where (IBM Cloud or local Docker), and who deploys a branch to them?
- Who are the named approvers of PRs into `dev`, and who decides a skip-lane use?
- What are the final branch names (`stage` vs `staging`)?

## Differs from knowledge base

- QA passes a feature branch in its own environment before merge to `dev` vs `knowledge/confluence.md`: the `dev` gate is the PR-APPROVERS group, "typically QA", and `process.md`: functional QA on `dev`, whole `dev` promoted weekly — updates (decided in principle; not in effect until feature-branch environments exist). Also replaces the 2026-11-16 meeting statement "all functional QA on `dev`".
- No release branch per version; `dev` → `stage` → `main` with tags vs `knowledge/architecture.md`: "Branching proposal for the GitHub move: `reports/2026-11-12-branching-strategy.md`" — updates (that proposal must be checked against these decisions)

## Confirms

- Branches `dev` → `staging` → `main` for BP Unified — `knowledge/architecture.md`
- Whole-branch promote, no cherry-picks — `knowledge/confluence.md` 3.4

## Action items

- [ ] Update the branching strategy doc with epic/integration branching — owner: Jon Borromeo — [38:37](https://fathom.video/calls/907244205?timestamp=2317)
- [ ] Review the New World branching strategy doc — owner: Andy Tompkins — [50:04](https://fathom.video/calls/907244205?timestamp=3004)
- [ ] Schedule a 30-minute follow-up — owner: Andy Tompkins — [51:01](https://fathom.video/calls/907244205?timestamp=3061)
- [ ] All: read the GitHub migration doc for the scope of work (pipelines) — [47:39](https://fathom.video/calls/907244205?timestamp=2859)
