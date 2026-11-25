# Engineering Deep Dive (2026-11-20)

- **Recording:** https://fathom.video/calls/907223000
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** GPS+ Path & Stop Compare, Environments and access, Database migrations, QA process and priorities, ETL, Ride Support (Discipline)
- **Duplicates skipped:** 205363105, 205361917, 205357646, 205357894, 205357511 (same meeting, other recorders)

## Decisions

- GPS+ Compare: when a stop has several passes, the displayed pass is picked by rank, then time, then distance (was rank, then distance). Vladislav Derbenev documents the rule in the ticket and fixes the visited-to-outcome mapping — owner: Vladislav Derbenev — decided (Vladislav said he must recheck the old rule) — [16:18](https://fathom.video/calls/907223000?timestamp=978), [16:54](https://fathom.video/calls/907223000?timestamp=1014)
- "Visited" is an internal classification rank, not an outcome shown to users — owner: Vladislav Derbenev — stated (summary only) — [13:54](https://fathom.video/calls/907223000?timestamp=834)
- Large-client data loading: keep the HRCE plan; choose one of two redesign options for clients stood up before Dispatch is done; decision at the Monday 2026-11-23 deep dive after Old World effort is scoped with Michel Walther — owner: Andy Tompkins — tentative — [00:19](https://fathom.video/calls/907223000?timestamp=19), [05:02](https://fathom.video/calls/907223000?timestamp=302)

## Positions and concerns

- **Front-end-only data loading:** Michel Walther holds that loading, chips, sorting and paging done only in the front end work for HRCE (about 6,000 rows) but fail for NSTS, so it is not a long-term design. Andy Tompkins agrees and expects large clients on the New World before Dispatch is done, so the team cannot wait. Outcome: deferred to 2026-11-23 — [00:19](https://fathom.video/calls/907223000?timestamp=19)
- **Compare pass selection:** Vladislav Derbenev holds that no single rule gives the right result in every case: rank-then-distance showed a late drive-by instead of the timely service, the earlier rule showed an early drive-by instead of the late service. A full fix needs run attribution. Outcome: rank, time, distance adopted — [06:56](https://fathom.video/calls/907223000?timestamp=416), [16:54](https://fathom.video/calls/907223000?timestamp=1014)
- **Customer data on dev and in agent prompts:** Jon Borromeo holds that live data copied to dev must be scrubbed, and that sensitive data must not reach agent prompts. Andy Tompkins holds that it is client-dependent today: some clients forbid it, some depend on data residency (client country and developer country), some gave explicit permission for development use. Vladislav Derbenev saw no restriction on agents reading data in the compliance documents he signed. Outcome: left open, no scrub process exists — [33:32](https://fathom.video/calls/907223000?timestamp=2012), [34:46](https://fathom.video/calls/907223000?timestamp=2086), [36:06](https://fathom.video/calls/907223000?timestamp=2166)
- **Shared dev database and migrations:** Jon Borromeo and Michel Walther hold that feature-branch migrations applied to the shared dev database can break other developers, and only the local branch has the down script. Vladislav Derbenev has not hit it in four months; he has his agent create per-ticket databases from fixtures for migration tests. Andy Tompkins agrees it needs a fix (communication or process) as more developers join. Outcome: open — [45:22](https://fathom.video/calls/907223000?timestamp=2722), [45:56](https://fathom.video/calls/907223000?timestamp=2756), [47:49](https://fathom.video/calls/907223000?timestamp=2869), [50:15](https://fathom.video/calls/907223000?timestamp=3015)
- **Playwright vs Chrome MCP for front-end checks:** Jon Borromeo holds that headless Playwright gives repeatable, deterministic regression tests and should run in CI with Jest and back-end tests. Vladislav Derbenev uses Chrome DevTools MCP, saw almost no front-end bugs in GPS+, and prefers API and integration tests and deterministic code over agent memory files. Outcome: left open ("under review" in summary) — [1:12:46](https://fathom.video/calls/907223000?timestamp=4366), [1:15:00](https://fathom.video/calls/907223000?timestamp=4500), [1:16:15](https://fathom.video/calls/907223000?timestamp=4575), [1:22:14](https://fathom.video/calls/907223000?timestamp=4934), [1:44:38](https://fathom.video/calls/907223000?timestamp=6278)

## Rules and facts

- A stop can have several stored passes; Compare shows one and a "+1" control expands the others — stated (summary only) — [12:01](https://fathom.video/calls/907223000?timestamp=721)
- There is no scheduled copy of staging or prod into the dev database; dev lives on its own — stated — [50:15](https://fathom.video/calls/907223000?timestamp=3015)
- Developers run the API and client locally and connect over VPN to the remote dev or staging databases; a local client registry with synthetic local databases also works — stated — [1:01:54](https://fathom.video/calls/907223000?timestamp=3714), [1:04:24](https://fathom.video/calls/907223000?timestamp=3864)
- The API uses Entity Framework; background services use plain parameterised SQL; there are no stored procedures — stated — [50:15](https://fathom.video/calls/907223000?timestamp=3015)
- A nightly ETL brings Old World data to the New World; Discipline will get its updates from it, possibly with HTTP calls to the Old World too — stated — [1:27:42](https://fathom.video/calls/907223000?timestamp=5262)
- Most GPS+ code (about 90%) was generated with Claude Code and then corrected by hand — stated (summary only) — [1:11:00](https://fathom.video/calls/907223000?timestamp=4260)

## Plans

- PLANNED: Confluence page from Vladislav Derbenev's knowledge-transfer notes (architecture, local setup), owner Vladislav Derbenev — tentative — [1:26:55](https://fathom.video/calls/907223000?timestamp=5215)
- PLANNED: Discipline follow-up with Jon Borromeo, Stephen Hu, Drew Weeks and QA, owner Drew Weeks (held the same day as the Discipline Module V1 kickoff) — decided — [1:49:25](https://fathom.video/calls/907223000?timestamp=6565)

## Defects and risks

- Risk: front-end-only loading fails for large clients (NSTS named) — [00:19](https://fathom.video/calls/907223000?timestamp=19)
- Risk: migrations from feature branches on the shared dev database can leave other developers on a changed schema — [45:22](https://fathom.video/calls/907223000?timestamp=2722)
- Risk: Compare can show a late drive-by or an early drive-by instead of the real service until run attribution exists — [16:54](https://fathom.video/calls/907223000?timestamp=1014)

## Open questions

- Which large-client loading redesign, and is it needed before Dispatch? (2026-11-23)
- May agents and developers read a given client's data on dev, and where is that recorded per client?
- How will migrations on the shared dev database be coordinated?
- Will Playwright run in the Unified CI pipelines?

## Differs from knowledge base

- Compare pick rule rank → time → distance vs `knowledge/jira/eng-2801-latest.md`: "GPS+ stop visit pick rule stays higher rank then shorter distance … (ENG-2849)" — updates
- Customer-data use on dev is client-dependent (residency, explicit permission), no scrub process vs `knowledge/environments.md`: "**Dev also holds real customer data** … Hard rule 5 applies to them as it does on staging." — absent (adds a per-client permission dimension)
- Front-end-only loading fails for large clients (NSTS) — absent
- Shared dev database migration conflicts; no dev refresh from staging — absent

## Confirms

- Client registry routes each client to its own database — `knowledge/architecture.md`
- Dev and staging databases reached over VPN — `knowledge/environments.md`

## Action items

- [ ] Brief on API change vs redesign for large clients, for 2026-11-23 — owner: Vladislav Derbenev / Andy Tompkins — [04:39](https://fathom.video/calls/907223000?timestamp=279)
- [ ] Update Compare ticket with rank → time → distance and outcome mapping — owner: Vladislav Derbenev — [14:52](https://fathom.video/calls/907223000?timestamp=892)
- [ ] Confluence page from knowledge-transfer notes — owner: Vladislav Derbenev — [1:26:55](https://fathom.video/calls/907223000?timestamp=5215)
- [ ] Discipline follow-up meeting including QA — owner: Drew Weeks — [1:49:25](https://fathom.video/calls/907223000?timestamp=6565)
