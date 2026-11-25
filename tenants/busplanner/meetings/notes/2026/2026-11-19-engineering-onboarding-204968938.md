# On-boarding (2026-11-19)

- **Recording:** https://fathom.video/calls/905702127 (also recorded as 204977863)
- **Class:** qa-core
- **Source read:** summary only
- **Areas:** QA process and priorities, Release and branching, ETL, Agentic development

## Decisions

- Fathom becomes the only meeting note-taker across BusPlanner, by end of week — owner: Tommy Zwirblia — stated — [03:29](https://fathom.video/calls/905702127?timestamp=209)
- Move from individual or private repositories and Azure DevOps to an official BusPlanner GitHub organisation; ownership to be settled in the branching meeting — owner: team — tentative — [14:07](https://fathom.video/calls/905702127?timestamp=847), [16:17](https://fathom.video/calls/905702127?timestamp=977)
- Agentic work targets the main bottlenecks, PR reviews and QA, ahead of March deadlines (summary only) — owner: Tommy Zwirblia — stated — [24:05](https://fathom.video/calls/905702127?timestamp=1445)
- Agents focus on the New World; legacy MSI dependencies are not modelled now — owner: Tommy Zwirblia, Andy Tompkins — stated — [27:26](https://fathom.video/calls/905702127?timestamp=1646)

## Positions and concerns

- **Bottom-up context:** Jon Borromeo holds that agents need bottom-up knowledge of system parts (for example legacy MSIs). Tommy Zwirblia and Andy Tompkins: the top-down vision is set at the on-site — [27:26](https://fathom.video/calls/905702127?timestamp=1646)
- **Missing docs:** Jon Borromeo notes no documentation on the tenant deployment model (on-prem/hosted moving to multi-tenant Kubernetes) or on QA test environments (per-branch vs static) — [08:17](https://fathom.video/calls/905702127?timestamp=497)

## Rules and facts

- QA scaffolding for the Discipline module is in a private repository until the GitHub organisation exists — stated — [11:43](https://fathom.video/calls/905702127?timestamp=703)
- ETL test design is paused until Shikhar Patel provides an ETL workflow diagram — stated — [12:15](https://fathom.video/calls/905702127?timestamp=735)
- Official QA documentation goes to the QA Confluence space after team approval — stated — [13:02](https://fathom.video/calls/905702127?timestamp=782)
- Claude converts training videos (for example BP Pro) into Confluence pages with Mermaid diagrams — stated — [07:20](https://fathom.video/calls/905702127?timestamp=440)

## Plans

- PLANNED: agentic workflow material for the on-site — owner Tommy Zwirblia, Jon Borromeo — tentative — [16:45](https://fathom.video/calls/905702127?timestamp=1005)

## Open questions

- What are the "March deadlines" (which products)?

## Differs from knowledge base

- ETL QA design blocked on a workflow diagram — absent from `knowledge/test-strategy.md`
- Move to a BusPlanner GitHub organisation vs `knowledge/architecture.md`: Azure DevOps org `busplanner`, repo `BusPlannerUnified` — updates (planned; same direction as the 2026-11-16 meeting)

## Confirms

- Agentic QA for the Discipline module — meeting 2026-11-13; `knowledge/test-strategy.md` Track 1

## Action items

- [ ] Clean up and share the copied Teams notes — owner: Sharaiz Khan — [02:30](https://fathom.video/calls/905702127?timestamp=150)
- [ ] Move the GitHub migration doc to Confluence; share the link — owner: Jon Borromeo — [05:49](https://fathom.video/calls/905702127?timestamp=349)
- [ ] Share Discipline QA repo access with Yusra Abbasi and Ibrahim Usman; walkthrough with Yusra Abbasi — owner: Sharaiz Khan — [11:32](https://fathom.video/calls/905702127?timestamp=692)
- [ ] Add Jon Borromeo to the Discipline session — owner: Tommy Zwirblia — [04:12](https://fathom.video/calls/905702127?timestamp=252)
