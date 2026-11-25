# Ontario Ministry reports, customer issues (2026-11-20)

- **Recording:** https://fathom.video/calls/910216576
- **Class:** qa-context
- **Source read:** summary
- **Areas:** Ontario Ministry reports

Customer: an Ontario transportation consortium (code not used in the knowledge base). Customer staff are not named here.

## Rules and facts

- The Routes report leaves monitor data empty on purpose (Ministry directive: monitor weight is a placeholder for manual entry) — stated (summary only) — [03:56](https://fathom.video/calls/910216576?timestamp=236)
- The consortium enters monitors as students with special grades (for example EA, EM) so they hold a seat; they show in Student Validation but count as zero monitors in Routes — stated (summary only) — [00:46](https://fathom.video/calls/910216576?timestamp=46), [03:04](https://fathom.video/calls/910216576?timestamp=184)
- The Ministry split the old "Courtesy" catch-all into CTY (Courtesy), TFN (Tuition Agreement – First Nation) and TIN (Tuition Agreement – International); BusPlanner tracks them in extended properties, not the eligibility tab. A student without them shows as "Other" — stated (summary only) — [09:00](https://fathom.video/calls/910216576?timestamp=540), [10:51](https://fathom.video/calls/910216576?timestamp=651), [11:52](https://fathom.video/calls/910216576?timestamp=712)
- Grade codes must match Ministry values to pass validation (for example J → JK); the consortium does this by hand — stated (summary only) — [17:39](https://fathom.video/calls/910216576?timestamp=1059)

## Positions and concerns

- **Manual monitor entry:** the consortium holds it is unworkable for large consortiums with hundreds of monitors (Toronto, Niagara named). The Ministry told the consortium to raise issues with BusPlanner, while BusPlanner was told consortiums fill monitors by hand. Outcome: left open — [04:36](https://fathom.video/calls/910216576?timestamp=276)
- **Release communication:** the consortium did not get BusPlanner's instructions PDF for the new reports and finds release notes hard to find — stated — [12:48](https://fathom.video/calls/910216576?timestamp=768), [14:49](https://fathom.video/calls/910216576?timestamp=889)

## Defects and risks

- Risk: students silently become "Other" when the courtesy extended properties are not set (also raised in the support huddle the same day) — [09:00](https://fathom.video/calls/910216576?timestamp=540)

## Differs from knowledge base

- Courtesy split into CTY / TFN / TIN extended-property types vs `knowledge/jira/eng-2401-2800.md`: "courtesy flag comes from the extended property named in "Ontario Reports Courtesy" (ENG-2536)" — updates (three types, summary only)

## Confirms

- Routes Report monitor columns are placeholders — `knowledge/jira/eng-2401-2800.md` (ENG-2536)

## Action items

- [ ] Resend the report instructions PDF and check why it was not received — owner: Andy Tompkins — [13:49](https://fathom.video/calls/910216576?timestamp=829)
- [ ] Forward the Ministry validation form to the BusPlanner team — owner: Andy Tompkins — [16:01](https://fathom.video/calls/910216576?timestamp=961)
