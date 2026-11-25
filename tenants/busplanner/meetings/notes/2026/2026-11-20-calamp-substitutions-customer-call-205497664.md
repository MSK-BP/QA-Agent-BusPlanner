# CalAmp vehicle substitutions, customer call (2026-11-20)

- **Recording:** https://fathom.video/calls/908095434
- **Class:** qa-context
- **Source read:** summary
- **Areas:** GPS readers, GPS+ Route Management

Customer: an operator customer (name not used in the knowledge base). Customer staff are not named here.

## Rules and facts

- BusPlanner pulls substitution data from CalAmp on an interval; CalAmp does not push. Lag is about 10 minutes for Toronto and is adjustable — stated (summary only) — [00:39](https://fathom.video/calls/908095434?timestamp=39), [00:54](https://fathom.video/calls/908095434?timestamp=54)
- Temporary (day-of) substitution: record it in CalAmp only; it reaches BusPlanner through the API — stated (summary only) — [06:49](https://fathom.video/calls/908095434?timestamp=409)
- Permanent substitution: record it in both CalAmp and BusPlanner, because CalAmp "entity mapping" is not supported for the customer's "drop-down model" account — stated (summary only) — [07:37](https://fathom.video/calls/908095434?timestamp=457), [08:00](https://fathom.video/calls/908095434?timestamp=480)
- The customer's wrong GPS/tracking data (BusPlanner and parent portal) was a process gap in handling substitutions, not a product failure — stated (summary only) — [03:06](https://fathom.video/calls/908095434?timestamp=186)

## Defects and risks

- Francobus: vehicle history missing in the BusPlanner portal for some vehicles since the week of 2026-11-09; an API data-flow issue from CalAmp; needs the Synovia API contact — [13:48](https://fathom.video/calls/908095434?timestamp=828)

## Open questions

- Is the Francobus vehicle-history gap on the vendor side or in the BusPlanner reader?

## Differs from knowledge base

- CalAmp pull interval and the temporary-vs-permanent substitution rule — absent (`knowledge/architecture.md` lists GPS vendors as UNVERIFIED)
- Francobus missing vehicle history — absent

## Action items

- [ ] Send the clarified substitution workflow to the customer — owner: Andy Tompkins, Chris MacLeod — [10:24](https://fathom.video/calls/908095434?timestamp=624)
- [ ] Follow up with Synovia on the Francobus vehicle history — owner: Andy Tompkins — [15:48](https://fathom.video/calls/908095434?timestamp=948)
