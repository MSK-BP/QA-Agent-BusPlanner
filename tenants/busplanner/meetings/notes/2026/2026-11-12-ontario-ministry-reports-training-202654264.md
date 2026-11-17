# Ontario Ministry reports training (2026-11-12)

- **Recording:** https://fathom.video/calls/897489720
- **Class:** qa-context
- **Source read:** summary
- **Areas:** Ontario Ministry reports

Team-readiness and engagement sections of the Fathom summary were dropped.

## Positions and concerns

- **How clients bulk-fill `Number of Days per Year`:** the trainer (Support) holds that clients must use `Admin > Route in Vehicle Update`, not route-by-route edits or direct SQL, and only after a database backup, because there is no importer and the tool does not highlight required fields. No other view was recorded. Outcome: decided as Support practice — [18:54](https://fathom.video/calls/897489720?timestamp=1134)

## Rules and facts

- BP Pro has four Ontario Ministry reports under `Government > Ontario`, fed by three importers and by extended properties on schools, routes and operators — stated — [01:15](https://fathom.video/calls/897489720?timestamp=75)
- The property names in the report settings must exactly match the extended property names in `Admin > Setup > Extended Properties` — stated — [01:50](https://fathom.video/calls/897489720?timestamp=110)
- School Importer fills School ID, School BSID, Board ID and School Zone; Route Importer fills Route ID and Paid Vehicle Size — stated — [03:38](https://fathom.video/calls/897489720?timestamp=218)
- The operator's Ontario business number (BIN) is stored as an operator contact of type `Operator Business`, with the BIN in the `First Name` field; it is not an extended property — stated — [06:00](https://fathom.video/calls/897489720?timestamp=360)
- `Number of Days per Year` has no importer; bulk updates go through `Admin > Route in Vehicle Update`, with a database backup first — stated — [07:40](https://fathom.video/calls/897489720?timestamp=460)
- Reports fail with "please set up district school years" when no active school year in `Admin > Setup > School Years` covers today's date — stated — [11:05](https://fathom.video/calls/897489720?timestamp=665)
- Some extended properties accept only exact ministry values, for example "mini-van" with a hyphen, and "taxi" — stated — [14:02](https://fathom.video/calls/897489720?timestamp=842)
- Report errors name the missing data (for example a school without Board ID, an operator without BIN, a route without paid vehicle size) — stated — [10:13](https://fathom.video/calls/897489720?timestamp=613)
- BP Web Cancellation and Delay report exports posted alerts to Excel; errors go to `SiteAdmin > Log Viewer` — stated — [15:02](https://fathom.video/calls/897489720?timestamp=902)
- The Cancellation and Delay report shows for all clients; a non-Ontario client gets an error saying it is Ontario-only — stated — [18:20](https://fathom.video/calls/897489720?timestamp=1100)

## Defects and risks

- `Route in Vehicle Update` does not highlight required fields, so bulk updates need care — stated — [18:54](https://fathom.video/calls/897489720?timestamp=1134)
- The `Number of Days per Year` setting wording is misleading (see PROD-792 in the knowledge base) — [07:40](https://fathom.video/calls/897489720?timestamp=460)

## Terms

- **BIN**: Ontario business number of an operator.
- **Extended properties**: user-defined fields on schools, routes and operators in BP Pro.

## Confirms

- Ontario Ministry reports are a regulatory report family in BP Pro — `knowledge/domain.md`
- `Number of Days Per Year` wording problem (PROD-792, Ready for Development) — `knowledge/jira/other-projects.md`
- Ontario Operator Importer exists under `Government > Ontario` (SPT-784) — `knowledge/jira/other-projects.md`
- A 13.4.1 hotfix touched the Ontario Ministry report — `knowledge/confluence.md`

## Action items

- [ ] Locate and share the Ontario Ministry reports documentation with the required extended property values — owner: the trainer (Support) — [13:36](https://fathom.video/calls/897489720?timestamp=816)
- [ ] Follow-up session on posted alerts in BP Web — owner: the trainer (Support) — [15:40](https://fathom.video/calls/897489720?timestamp=940)
