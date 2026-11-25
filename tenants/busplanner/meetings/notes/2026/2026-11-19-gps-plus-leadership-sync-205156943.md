# GPS+ - Projects/Engineering Leadership Sync (2026-11-19)

- **Recording:** https://fathom.video/calls/906690756
- **Class:** qa-core
- **Source read:** summary only
- **Areas:** GPS readers, ETL, Environments and access

## Decisions

- Geotab change that broke stop events: clients correct their own Geotab configuration; faster than an internal fix — owner: not named (summary only) — stated — [00:13](https://fathom.video/calls/906690756?timestamp=13), [00:27](https://fathom.video/calls/906690756?timestamp=27)
- Performance review meeting on Monday (2026-11-23) on scaling to 10 clients — owner: not named — decided — [04:07](https://fathom.video/calls/906690756?timestamp=247)

## Positions and concerns

- **Scaling:** Shikhar Patel is concerned about bottlenecks at 10 clients: an extra SQL server, and an extra GPS reader pod, which needs new development — stated (summary only) — [04:07](https://fathom.video/calls/906690756?timestamp=247)

## Rules and facts

- Stop-event processing matches Geotab names by string, not by a stable identifier, so a vendor naming change breaks it — stated (summary only) — [00:49](https://fathom.video/calls/906690756?timestamp=49)
- The same day, a separate thread reported Geotab changing an AUX input (mentioned at the start of the branching meeting; resolution unknown) — stated — see [branching note](2026-11-19-new-world-branching-strategy-205123949.md)
- Migration "Skill 1" is in use for new clients; "Skill 2" validates that data loads correctly into the New World from the ETL extract and fails today on staff ID issues; the next migration phase waits for Skill 2 — stated (summary only) — [03:02](https://fathom.video/calls/906690756?timestamp=182), [03:31](https://fathom.video/calls/906690756?timestamp=211)

## Plans

- PLANNED: Skill 2 finished before the next sync (Tuesday), update posted in the channel — owner Andy Tompkins — tentative — [05:20](https://fathom.video/calls/906690756?timestamp=320)

## Defects and risks

- Geotab naming change broke stop events for affected clients; fix relies on each client's own configuration — [00:13](https://fathom.video/calls/906690756?timestamp=13)
- Risk: SQL server and single GPS reader pod may not scale to 10 clients — [04:07](https://fathom.video/calls/906690756?timestamp=247)

## Terms

- **Migration skill**: Claude skill used to onboard a client's data into the New World (Skill 1: migrate; Skill 2: validate the load).

## Open questions

- Which Geotab field changed, and which clients were affected?
- Will the string match be replaced by a stable identifier?

## Differs from knowledge base

- Stop events rely on Geotab names by string; a Geotab change broke them vs `knowledge/repos/BusPlannerUnified/data-services.md`: Geotab vehicle match by serial number; no string-name dependency recorded — absent (summary only)
- Migration skills (load and validation) for new clients — absent from `knowledge/`

## Confirms

- GPS readers run as one pod with no multi-pod logic — meeting 2026-11-16; `knowledge/repos/BusPlannerUnified/data-services.md` (vendors)

## Action items

- [ ] Finish Skill 2 (staff ID issue); post an update — owner: Andy Tompkins — [05:20](https://fathom.video/calls/906690756?timestamp=320)
- [ ] Attend the scaling meeting on Monday — owner: all — [04:07](https://fathom.video/calls/906690756?timestamp=247)
