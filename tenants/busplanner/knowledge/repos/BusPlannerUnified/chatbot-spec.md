# BusPlannerUnified — Agentic chatbot: specification vs code (QA reference)

Written 2026-11-10 from the converted Word documents and static reading of the repo snapshot (no build, no test run). Companion to `chatbot.md` (the code map).
Sources and shorthand (all under `repos/BusPlannerUnified/`):
- `SPEC` = `_docx_text/specs/Agentic-Chatbot-Spec-v2.2.txt` (file name says v2.2; content is **v2.5, revised 2026-10-07** — SPEC:2)
- `BL` = `_docx_text/chatbot/Agentic-Chatbot-Story-Backlog-v1.1.txt` (content **v1.6, 2026-10-07** — BL:2)
- `TRI` = `_docx_text/chatbot/Chatbot-Question-Triage.txt` (August 2026; "where the two differ, the specification governs" — TRI:4)
- `_docx_text/chatbot/Adding a simple chatbot tool.txt` — 8 lines, headings only ("Claude code prompt:", "Testing the new tool:"); the body did not survive conversion (probably images). No requirement can be taken from it.
- `MOD` = `BusPlannerUnified/Modules/Chatbot`; `MOD/CLAUDE.md` read in full (2,110 lines). `API` = `BusPlannerUnified/BusPlannerAPI/Modules/Chatbot`. `CC` = `BusPlannerUnified/BusPlanner.Application/Classification/ClassificationConstants.cs`.
- Numbers after a colon are line numbers in the named file. UNVERIFIED = inferred, not read.
- Precedence stated by the repo: backlog wins over `MOD/CLAUDE.md` on the E2 design preamble; SPEC §5/§7 rows naming `draw_map` are stale (MOD/CLAUDE.md:20-23).

## 1. Product intent, scope, versions

**Intent.** An agentic assistant inside BusPlanner Unified that answers transportation-operations questions by orchestrating tool calls and presenting markdown, tables, charts, maps, report cards, or a deep link into a GPS+ page (SPEC:4).
- The model does as little as possible: every answer is a translation into tool calls; all computation lives in tools; no free-form SQL or GraphQL (SPEC:5).
- Computation boundary: the model may compare "a handful" of pre-aggregated numbers already in context; anything over a few buckets or row-level math (time series, trend direction, averages, deltas across rows) must come from an endpoint (SPEC:6).
- No reuse of old-chatbot (PR 569) services; GPS comparison logic only from the GPS+ model; PR 701 stop-classification endpoints are accepted logic (SPEC:7; TRI:28-32).
- Existing chat persistence and sidebar UI are retained (SPEC:8).

**Method.** 77 collected questions, deduplicated into categories, each given a tier: T1 logic exists; T2 data exists, logic to write; T3 data missing (schema/ETL); T4 blocked on a dependency project (SPEC:9). Tally: 57 fully in, 5 partial, 15 out (SPEC:592).

**In scope (v1).** All Tier 1 and Tier 2 questions; two Tier 3 ETL pulls (walk distance, student equipment); expansions: dataset aggregates, data quality and readiness, GPS freshness/latency, trends and period comparison (SPEC:10).
**Cut for the timeline (deferred fast-follows).** Snapshot evolution, device inventory, operator rollups, fleet retrospective, token-cost / rate-limit enforcement (SPEC:10, 790-814).
**Out of scope.** Remaining Tier 3, Tier 4, T&A questions (a TA flag is reserved), the operator-outreach agent (SPEC:10, 872). All are declined in v1 naming the gap or blocking project (SPEC:789).
**Future, not scoped.** Cross-conversation memory, per-client custom skills, per-user flag granularity (SPEC:873-876).

**Feature flags** (per customer, `chatbot.flags.*`; a disabled flag removes tools and the prompt adapts — SPEC:12): PLANNED (needs ETL), GPS (needs GPS reading + stop classification), GPSPLUS ("the whole epic ships dark behind this flag" — SPEC:106), ADMIN.

**Versions.** The spec has no section defining "v1.0". The only version split is an unformatted list after the epic table (SPEC:967-984):
| Block (as written) | Content | Days |
|---|---|---|
| "Shikhar list" (SPEC:967-971) | ETL additions (4), Deployment (1-2), Settings & model config (1-2) | 6-8 |
| "Version 1.5" (SPEC:973-977) | Entity-scoped permissions (6-7), UI Charts (2-3), Chatbot testing & evals (7-11) | 15-21 |
| "Version 2" (SPEC:979-984) | Substitution tools (1?), deep links — "just need to be able to answer questions about the GPS+ dashboard" (3-5), spatial endpoint (3-4), ADMIN feature (1-2) | 8-12 |
- Reading: v1.0 = the epic table minus the v1.5 and v2 items. UNVERIFIED — the document never says so.
- This list conflicts with §1/§9, where entity scope (E0) is a prerequisite that "blocks everything" (BL:6) and spatial / substitution / ADMIN are in v1 scope (SPEC:10, 205-207, 276-279, 375-378). Treat the list as a later re-plan; ask the product owner which governs.
- Code agrees with the list for "Version 2": none of `live_fleet`, `substitution_history`, `spatial_query`, `user_activity`, `route_summary` exists (section 7).
- `MOD/CLAUDE.md:2096` refers to a "v1.5 UI Display Tools epic ENG-2117".

## 2. Epic and story catalogue (backlog v1.6, 44 stories — BL:415)

Shared definition of done for every story: reviewed and merged; build and tests green; new behaviour covered by eval cases; entity scoping verified for any story reading planning data; tool descriptions and admin docs updated (BL:5).
Sequencing: E0 blocks everything; E2-2 blocks all tool stories; E6-2/E6-3 start after GPS+ lateness semantics freeze; E6-4 after the Live Viewer front end; E8 runs from E2 on; E9 is outside the dev window (BL:6).
The backlog states **no status** for any story. The Status column is what the repo says: "shipped" = named as shipped in `MOD/CLAUDE.md` (line given); "not built" = no code found; "?" = not determined.
QA script = file in `docs/qa/` (all prefixed `Chatbot-`, suffix `.md` omitted).

| ID | Title | Acceptance criteria (condensed) | Status (source) | QA script |
|---|---|---|---|---|
| E0-1 | Entity-scope semantics spike | Decision doc covers composition, empty-route rule, 4x grant matrix; PO sign-off recorded (BL:12-14) | doc exists: `docs/specs/Chatbot-EntityScope-Semantics.md`; sign-off ? | NONE |
| E0-2 | Customer + direct-FK scopes | No-scope user sees only own customer; operator/district/depot users see only linked rows; T&A filters unaffected; performance within "an agreed bound" (BL:20-23) | ? (filters exist — MOD/CLAUDE.md:246-251) | NONE |
| E0-3 | Join-based school scope | School-scoped user sees only that school's students, stops, runs, routes; empty-route rule as specified; cursor paging correct; query time bounded (BL:30-33) | shipped (MOD/CLAUDE.md:1756-1763, migration 51) | NONE |
| E0-4 | Scope-composition test matrix | Every matrix cell has a test; admin bypass and cross-customer isolation verified; runs in CI every build (BL:40-42) | ? | NONE |
| E0-5 | Decommission PR 569 analytics | Listed services, endpoints, pages removed; no references; no old route reachable (BL:49-51) | shipped (MOD/CLAUDE.md:1063, 1783-1785) | E0-5-Analytics-Decommission-Test-Script |
| E0-6 | Dev baseline + migration renumbering | Chain applies to a fresh DB; old-numbered environment reconciled; catalog/probes match; re-check documented (BL:57-60) | ? | NONE |
| E1-1 | Walk distance (ETL) | `walk_distance` populated where Pro has a value, null otherwise; idempotent; exposed and filterable in GraphQL (BL:67-69) | column migration 56 exists; no chatbot operation (section 7) | NONE |
| E1-2 | Student equipment (ETL) | Columns populated and stable; wheelchair matching answerable by join to `veh_vehicle.vehicle_wheelchair`; GraphQL exposure (BL:76-78) | migration 62 exists; no chatbot operation | NONE |
| E2-1a | Agent loop + full logging | Single-turn demo question answers end to end; every message carries reasoning, ordered tool trace, prompt version, model id; parallel tools without DbContext faults; max-iteration guard with a clean message; history-ready message assembly (BL:87-91) | shipped (MOD/CLAUDE.md:11-12) | AgentLoop-E2-1a-Test-Script (echo_probe steps superseded — MOD/CLAUDE.md:2088-2090) |
| E2-1b | Follow-up context + streaming | Follow-up chains resolve; answer streams; streamed deltas == persisted answer; single-turn unchanged (BL:99-102) | shipped | FollowUpStreaming-E2-1b-Test-Script (protocol steps superseded by E2-8) |
| E2-2 | Tool contract, registry, envelope | New tool = class + DI + eval with zero contract changes; legacy per-tool fields removed; client renders by payloadType with text fallback; reference tool works; CLAUDE.md recipe merged; cold-run validation (BL:110-115) | shipped (MOD/CLAUDE.md:4) | ToolContract-E2-2-Test-Script |
| E2-3 | Feature-flag framework | Disabled flag removes tools (logged list); disabled domain gets "not enabled", not an error or guess; per customer, no redeploy; new flag = three touchpoints (BL:122-125) | shipped | FeatureFlags-E2-3-Test-Script, FeatureFlags-E2-3-QA-Guide |
| E2-4 | Permissions + scoping in tools | Scoped user's chat rows == direct GraphQL rows; tool absent without its permission; denied downstream call gives a graceful explanation; scope parity automated in CI (BL:131-134) | shipped | Permissions-E2-4-Test-Script |
| E2-5 | Decline behaviour | A passing decline eval per excluded domain; caveats appear in answers where limits apply (BL:141-142) | shipped | Decline-E2-5-Test-Script (counts stale) |
| E2-6 | Settings, model config, admin | Model change effective next message, model recorded; admin pages render reasoning/trace; token usage per conversation visible (BL:148-150) | shipped | Settings-Admin-E2-6-Test-Script |
| E2-7 | Deployment + telemetry | Deploys to dev and staging with no secrets in repo; tokens, tool-call counts, latency per conversation recorded and visible (BL:156-157) | ? (eval pipeline exists — MOD/CLAUDE.md:2109) | NONE |
| E2-8 | Thinking stream | Thinking and tool events live before the answer; region expanded by default, user collapse holds for the turn (revised 2026-09-22); no thinking in answer or copy/export; thinking never exceeds the user's scope (BL:163-166) | shipped; persistence added by ENG-2524 | ThinkingStream-E2-8-Test-Script |
| E3-1 | Tier 1 planning tools | Each question type correct on the pilot vs hand-run SQL; one scope eval per query; sortable tables (BL:175-177) | shipped | PlanningTools-E3-1-Test-Script, -UI-Test-Script |
| E3-2 | Dataset-wide aggregates | Aggregates match hand SQL; school-scoped user gets school-only aggregates; math in SQL never the model (BL:185-187) | shipped | DataAggregates-E3-2-Test-Script, -UI-Test-Script |
| E3-3 | Data quality + readiness | Each of four checks correct on a defect fixture; snapshot load date matches `pln_snapshot`; answers note the consequence (BL:194-196) | shipped (MOD/CLAUDE.md:2101) | DataChecks-E3-3-Test-Script, -UI-Test-Script |
| E3-4 | Capacity + fleet utilization | Values match hand-computed; thresholds work both directions; answers state the planning definition (BL:202-204) | shipped | PlanningTools-E3-4-Test-Script, -UI-Test-Script |
| E3-5 | Spatial query endpoint | Three operations correct on spatial fixtures; scope verified for a school user; query time bounded (BL:210-212) | not built | NONE |
| E3-6 | Assigned-driver attribution | Correct driver for a fixture, date-specific; every answer carries the planned caveat; never presented as actual (BL:220-222) | shipped | AssignedDriver-E3-6-Test-Script, -UI-Test-Script (+ DriverChange-ENG-2593-Test-Script) |
| E4-1 | Markdown + tables renderer | Any table sortable; large sets truncated with "showing N of M"; clean fallback for unknown types (BL:229-231) | shipped | TablesRenderer-E4-1-Test-Script |
| E4-2 | Chart renderer | Bar, line, pie render from tool series; legible in light and dark themes; any tool can feed it (BL:237-239) | shipped (MOD/CLAUDE.md:2097) | ChartRenderer-E4-2-Test-Script, -UI-Test-Script |
| E4-3 | Map renderer | Demo planned-vs-actual renders (path, track, classified stops, lateness popups); layers toggle, flag-disabled layers absent; payload from allow-listed endpoints only (BL:246-248) | shipped | MapRenderer-E4-3-Test-Script |
| E4-4 | Report cards + CSV | Three report shapes render (route summary matrix, OTP summary, coverage report); CSV equals rendered data; wide matrices scroll in the card (BL:256-258) | shipped; only OTP emits a report (MOD/CLAUDE.md:1033) | ReportCards-E4-4-Test-Script (+ ReportCards-E4-4-Seed.sql) |
| E5-1 | Tier 1 GPS tools | Each demo GPS question passes on the pilot; arrival-only and one-visit-per-day caveats appear; one eval per tool incl. a scope eval (BL:265-267) | shipped | GpsTools-E5-1-Test-Script |
| E5-2 | Ride-time endpoint | Values match hand-checked runs; threshold and consistency filters both directions; missing-stop-time runs listed with a reason (BL:274-276) | shipped | RideTime-E5-2-QA-Guide, -UI-Test-Script |
| E5-3 | Path deviation endpoint | Seeded deviating route detected, conforming one not; single-route per-day series; `corridorMeters` respected and fleet ranked; entity scope and GPS flag respected (BL:283-286) | shipped | PathDeviation-E5-3-Test-Script, -UI-Test-Script |
| E5-4 | GPS freshness + latency | Latency matches hand SQL; lagging list correct for a seeded laggard; no service/host/devops details (BL:293-295) | shipped (MOD/CLAUDE.md:680) | GpsFreshness-E5-4-Test-Script, -UI-Test-Script |
| E5-5 | Trend period comparison | Deltas server-side and match hand SQL; renders as comparison table and chart; model never computes deltas (trace-verified) (BL:302-304) | shipped | TrendComparison-E5-5-QA-Guide, -UI-Test-Script |
| E6-1 | Live fleet + substitution tools | Live questions answer within the view's freshness; substitution answers match import output; both absent when GPSPLUS off (BL:312-314) | not built | NONE |
| E6-2 | On-time performance endpoint | Parity test vs Live Viewer classification; four groupings correct vs hand SQL; no-GPS days excluded with a count, never late (BL:321-323) | shipped | OnTimePerformance-E6-2-Test-Script, -UI-Test-Script |
| E6-3 | GPS route summary endpoint | Matrix matches hand-checked data; run and AM/PM filters server-side; report card with CSV; 14-day cap (BL:328-332) | not built | NONE |
| E6-4 | GPS+ deep links | "GPS+ dashboard with routes 30 minutes late" opens the Live Viewer with the filter applied; unsupported intent answers in chat, no broken link; parameter names agreed (BL:339-341) | partly: `open_page` shipped under ENG-2533 without Live Viewer filters (section 7) | NONE |
| E7-1 | User activity, roles, audit tool | Inactive-user, permission-holder, audit questions correct on fixtures; gated by ADMIN flag and admin-read permission; `last_login_date` stamped (BL:349-351) | not built | NONE |
| E8-1 | Eval harness + seed cases | Runs locally and in CI on the pilot snapshot; coverage floor met; not flaky across 3 consecutive runs (BL:358-360) | shipped | EvalHarness-E8-1-Test-Script, -QA-Guide |
| E8-2 | Prompt-change regression gate (local) | Regressing prompt fails with a readable per-case diff; one command refreshes the baseline; prompt version changes with prompt or tool description, not with the date (BL:367-369) | shipped (MOD/CLAUDE.md:2107) | RegressionGate-E8-2-Test-Script |
| E8-3 | Full eval pass + feedback loop | Full suite passes on the release candidate or each failure triaged in writing; flagged message converts in one admin action; converted case runs from Test Suite and can be promoted (BL:376-378) | loop shipped (MOD/CLAUDE.md:2108); full pass ? | FeedbackLoop-E8-3-Test-Script |
| E8-4 | Eval regression gate in CI | Regressing PR blocked with a diff; CI compares against the target branch's baseline; promoted case runs next cycle (BL:385-387) | not built (ENG-2509 — MOD/CLAUDE.md:2109) | NONE |
| E9-1 | Security + prompt-injection review | Checklist executed and archived; blockers fixed and re-tested before pilot; injection eval cases added (BL:396-398) | ? | NONE |
| E9-2 | QA test plan + UAT | QA plan across all flag and scope combinations executed; UAT held and triaged; pilot sign-off (BL:404-406) | ? | NONE |
| E9-3 | User documentation | Covers every enabled capability and every caveat; reviewed and published (BL:412-413) | ? | NONE |

Scripts with no backlog story id: `BellTimes-ENG-2333-UI-Test-Script`, `DriverChange-ENG-2593-Test-Script`.
Shipped work with no `Chatbot-*` script found: attachments (ENG-2609), `open_page` (ENG-2533), `school_directory`, `stop_compare`, the client CHATBOT entitlement flag (ENG-2491), persisted thinking and conversation delete (ENG-2524). Other `docs/qa` files without the `Chatbot-` prefix were not listed — UNVERIFIED.

## 3. Question triage

Tier counts in TRI (39 / 17 / 16 / 4 questions, 32 capabilities — TRI:6-25) sum to 76 plus the outreach agent (TRI:28). SPEC counts by outcome instead (57 / 5 / 15 — SPEC:592).

### Supported (In) — by flag
| Flag | Category | Example | Source |
|---|---|---|---|
| PLANNED | Plan lookups and rosters | "How many students are assigned to Route 42?" | SPEC:18-23 |
| PLANNED | Plan hygiene | "Show me zero-load stops that aren't waypoints." | SPEC:25-28 |
| PLANNED | Walk distance (ETL pull; null where Pro has no value) | "Which students on Route ABC have a walk distance over 1.5 km?" | SPEC:30-32 |
| PLANNED | Equipment matching | "Which routes serving wheelchair students are using wheelchair-capable buses?" | SPEC:34-35 |
| PLANNED | Capacity and utilization (planning definition) | "Which routes have capacity over 90%?" | SPEC:37-41 |
| PLANNED | Dataset-wide aggregates | "What's the average number of stops per run?" | SPEC:43-46 |
| PLANNED | Data quality and readiness | "When did the last snapshot load?" | SPEC:48-51 |
| PLANNED | Zones and spatial | "How many unassigned students do I have in the ABC zone?" | SPEC:53-55 |
| GPS | Historical actuals | "What time did B-739-R service Ste Marguerite on April 8?" | SPEC:63-66 |
| GPS | Skipped and unused stops | "Which planned stops were skipped this week?" | SPEC:68-70 |
| GPS | Student pickup and ride times | "What time was Suzy Busrider picked up on April 7?" | SPEC:72-75 |
| GPS | Ride-time comparison | "Which routes ran more than 15% over planned time this week?" | SPEC:77-79 |
| GPS | Path deviation and sequence | "Did any buses deviate from their planned route today?" | SPEC:81-83 |
| GPS | Coverage and health | "Which Zonar routes had no GPS data at all for April 7-10?" | SPEC:85-87 |
| GPS | Freshness and latency | "Is GPS data current right now?" | SPEC:89-91 |
| GPS | Trends and period comparison | "Compare ride times before and after the May 1 route change." | SPEC:93-95 |
| GPS | Vehicle mismatch | "Find buses that are covering other runs." | SPEC:97-98 |
| GPS | Assigned drivers (planned only) | "Who is assigned to drive run 42A?" | SPEC:100-102 |
| GPSPLUS | Live fleet | "Which buses are running late this morning?" | SPEC:110-114 |
| GPSPLUS | On-time performance and delay statistics | "Which routes consistently run more than 10 minutes late?" | SPEC:116-120 |
| GPSPLUS | GPS route summary (report card, CSV) | "Show me a GPS route summary for B-739-R for April 7-10." | SPEC:122-124 |
| GPSPLUS | Substitution history | "Show me our GPS substitution history for the last 30 days." | SPEC:126-127 |
| GPSPLUS | Deep links | "Show me the GPS+ dashboard with all the routes that are 30 minutes late." | SPEC:129-131 |
| ADMIN | User activity, roles, audit | "Which schools haven't used Web in a while?" | SPEC:138-146 |
| all | Ranking, composite, self-knowledge, display | "Top 5 worst routes this week."; "What can you answer?" | SPEC:153-168 |

### Partial — one half answered, the other declined (SPEC:328-368, 479-482)
| Question | Answered | Declined |
|---|---|---|
| PA8 drivers consistently under planned time | Run-level ride time + assigned-driver label | Actual-driver attribution |
| SP1 riders beyond a ride-time threshold + alternatives | Detection | Recommendations |
| SP2 / C1 under-utilized routes + pairing / cheaper vehicle | Detection (capacity) | Pairing; cost reasoning |
| Comm1 routes with many/long delays | OTP query | Standing alert triggers |
| K-19 students with geocode errors / without addresses | Missing-address subset | Error causes |

### Declined — the answer must name the gap or blocking project (SPEC:789)
| Group | Items | Source |
|---|---|---|
| Deferred fast-follow | Snapshot evolution ("what changed"), device inventory, operator rollups, fleet retrospective, token budgets and rate limits | SPEC:790-814 |
| Tier 3, data missing | Run contact list, courtesy riders / eligibility, geocode error detection, substitute drivers, cost analysis, optimization and recommendations (bell optimization, slack, road closures), ridership uptake | SPEC:816-848 |
| Tier 4, blocked project | Stops near an address (geocoding), speeding (street network), road-speed learning, eligibility by address | SPEC:850-870 |
| Out entirely | Time & Attendance; operator outreach agent | SPEC:872 |
Code catalogue: 19 entries = 5 + 7 + 4 + 3; the third "separate product" entry, `change_bus_or_driver`, is not in the spec (`MOD/BusPlanner.Chatbot.Domain/Tools/ChatLimits.cs:264-399`; MOD/CLAUDE.md:1705-1707).

## 4. Non-functional requirements

| Area | Requirement (source) | What the code does (source) |
|---|---|---|
| Latency | **No response-time target is stated anywhere in SPEC or BL.** Only: list-query performance "within an agreed bound" (BL:23, 33 — bound not given); spatial query time bounded (BL:212); live answers "within the view's freshness" (BL:312) | Tool deadline 60 s, engine command timeout 50 s (`CC:358`; MOD/CLAUDE.md:321-322, 1564-1566); 15 s SSE keepalive against a 60 s ingress timeout (MOD/CLAUDE.md:1661-1663); loop cap 50 model calls (MOD/CLAUDE.md:1564) |
| Cost | Token-cost ceiling and per-user rate limits are **deferred** (SPEC:811-813). Token usage per conversation visible to admins (BL:150); tokens, tool-call counts, latency recorded (BL:157) | Usage on the admin conversations page (MOD/CLAUDE.md:1488-1510). The CHATBOT client flag exists because the chat spends the company's API key (MOD/CLAUDE.md:197-200). Eval pipeline is manual because a run is billable (MOD/CLAUDE.md:1951-1953) |
| Safety | Tool results treated as data, not instructions; injection via student/route names reviewed (BL:394); injection eval cases added (BL:398) | `[TOOL DATA …]` prefix on results; error text outside the boundary must be fixed tool text (MOD/CLAUDE.md:259-261, 1574-1577); attached text files inside a twin boundary (MOD/CLAUDE.md:1427-1436). No injection eval case found in `MOD/EvalCases/` (key list read) |
| Privacy | Contact data needs a PII permission gate (deferred, SPEC:822); promoted eval cases must have personal data removed (SPEC:711; BL:374); thinking never beyond the user's scope (BL:166) | Reasoning is admin-only (MOD/CLAUDE.md:1503-1505); attachments never stored (MOD/CLAUDE.md:1410-1413); eval result files hold real student names and must not be committed (MOD/CLAUDE.md:1964-1967); results never name host, table, setting key (MOD/CLAUDE.md:718-720) |
| Logging | Every message persists reasoning, each tool call with inputs and results, prompt and model version (SPEC:681; BL:88) | `chat_message` reasoning, `tool_attempts_json`, prompt version, `model_id` (MOD/CLAUDE.md:148-153, 1797-1798); persisted trace field capped at 10,000 chars (MOD/CLAUDE.md:141-147) |
| Permissions | Every tool runs as the asking user; catalog filtered by permission claims; graceful denial (SPEC:685; BL:131-134) | Three gates: flag, permission, entity scope; no Admin shortcut; a permission drop is silent (MOD/CLAUDE.md:222-245) |
| Tenant isolation | A school-scoped user sees only that school's students, stops, runs, routes; same for operator, district, depot; purpose-built endpoints apply the same scope manually in SQL (SPEC:878) | EF filters for planning data. **Engine analytics figures are organization-wide by decision** (MOD/CLAUDE.md:487-496) — see section 7. One database per customer (MOD/CLAUDE.md:1508-1509) |
| Change control | Prompts and tool descriptions in source control, versioned, gated in CI on every change (SPEC:704-708) | Version = template tag + hash of prompt and every tool definition (MOD/CLAUDE.md:1788-1794); gate is local only (section 7) |
| Availability of capability | Disabled flag gives a "not enabled" explanation, not a failure (SPEC:12; BL:123) | `UnavailableText` section in the prompt (MOD/CLAUDE.md:177-179) |

## 5. Answer-quality rules as testable sentences

From the spec and backlog (R = requirement):
1. R: A bell-time answer mentions that bell times are program-scoped (BL:142; SPEC:885). **Superseded in code:** the answer gives every bell-time variant with what it applies to, or only the one the question names (MOD/CLAUDE.md:1189-1193).
2. R: "Dropped off" is stated as the bus's arrival at the school stop; no departure time exists (SPEC:75; TRI:87).
3. R: A stop has one visit per day, arrival only, and the answer says so where relevant (BL:266; SPEC:885).
4. R: A capacity or utilization answer states the planning definition (assigned vs not), not ridership (BL:204; SPEC:41).
5. R: Every assigned-driver answer carries the planned-assignment caveat; no driver is presented as the one who drove (BL:221-222).
6. R: No-GPS days are excluded from on-time performance with an explicit exclusion count and are never counted late (BL:323).
7. R: A run with missing scheduled stop times is listed with a reason, not silently dropped (BL:276).
8. R: A data-quality answer notes the consequence (for example: runs without stop times are excluded from ride-time answers) (BL:196).
9. R: Period deltas come from the tool; the model never computes them (BL:302-304; SPEC:6).
10. R: Aggregation math happens in SQL, never in the model (BL:187).
11. R: A decline names the missing data or the blocking project (SPEC:165, 789).
12. R: A question in a disabled domain gets "not enabled", not an error or a guess (BL:123).
13. R: A freshness answer contains no service, host or devops detail (BL:295).
14. R: No thinking content appears in the answer text or a copied/exported answer (BL:165).
15. R: A route with no assigned students has no school linkage, and plan-hygiene answers reflect it (SPEC:885; BL:13).
16. R: Timestamps are stored UTC with wall-clock plan times (SPEC:885). **Superseded for GPS tools:** times are shown in the customer's local time and the UTC caveat was removed (MOD/CLAUDE.md:838-840).
17. R: An unsupported deep-link intent is answered in chat, never with a broken link (BL:340).

From `MOD/CLAUDE.md` (C = implemented rule, with the QA finding that produced it):
18. C: A route-day with no bus, no active device or no GPS is reported "not measured", never missed or skipped (MOD/CLAUDE.md:409-419).
19. C: A date range with no operated day returns "nothing was checked" — never zero, never all-clear (MOD/CLAUDE.md:435-438).
20. C: Planned dates not operated are listed, each with a reason class (weekend, holiday/outage, below the bar with its visit count) (MOD/CLAUDE.md:438-443).
21. C: For today, stops not yet due are neither serviced nor missed (MOD/CLAUDE.md:450-457).
22. C: A weekday is named only when a tool result gave it (MOD/CLAUDE.md:433-435).
23. C: Every `query_plan` table carries the plan date and the answer states which plan date it used (MOD/CLAUDE.md:1125-1126; `API/Tools/QueryPlanTool.cs:168-170`).
24. C: A date with no plan returns the nearest available dates and the model asks, it does not guess (MOD/CLAUDE.md:1118-1119).
25. C: A name that matches nothing or several things makes the assistant ask which one (MOD/CLAUDE.md:1166-1168).
26. C: A scoped user's totals are qualified ("within your access") and no permission is named (MOD/CLAUDE.md:1169-1172).
27. C: "Organization-wide" is said only when the result's `accountScoped` is true (MOD/CLAUDE.md:493-496).
28. C: Stops outside a scoped user's access are reported as a count only, never by name (MOD/CLAUDE.md:517-520).
29. C: A hidden roster is an access limit for a scoped user and a data gap for a full-visibility user; an empty roster never reads as "no students" (MOD/CLAUDE.md:1133-1136, 1173-1175).
30. C: Rows of a rendered table are not repeated in the answer; a one-row result is "the details below", never "the table" (MOD/CLAUDE.md:379-383).
31. C: A `text` result is never promised as a table (MOD/CLAUDE.md:78-80).
32. C: A map is referred to once and coordinates are never listed (MOD/CLAUDE.md:616-618); a map tool is called once per answer for exactly the scope asked (MOD/CLAUDE.md:853-856).
33. C: The answer is one or two sentences plus at most one breakdown table; every number, name and date is traceable to a result; a code such as FBJ is never expanded into a name (MOD/CLAUDE.md:1918-1921).
34. C: Each caveat is said once per conversation (MOD/CLAUDE.md:840).
35. C: Path deviation is a share of GPS points, not a distance, duration or number of detours; not measured is never 0%; no stop visit on the route-day means wrong bus, not a deviation (MOD/CLAUDE.md:918-927, 936-937).
36. C: On-time performance is per stop arrival, not run or bell-time punctuality (MOD/CLAUDE.md:1028-1031).
37. C: With GPS+ off, on-time performance is "not enabled" and is not substituted from the stop-coverage average (`MOD/EvalCases/flags.json:66-78`).
38. C: A vehicle mismatch is described as inference from GPS, never a confirmed swap (MOD/CLAUDE.md:794).
39. C: A ride-time run not listed "did not meet the filters", never "ran to plan"; the model never recomputes a figure (MOD/CLAUDE.md:1088-1093).
40. C: A ratio the plan summary does not list is "not available"; the model does not divide two results (MOD/CLAUDE.md:1341-1342).
41. C: A request to change a bus or driver is declined and pointed at Route Management in the GPS+ Live Viewer (MOD/CLAUDE.md:1705-1707).
42. C: Suggested questions use placeholders, not the tool descriptions' made-up examples (`MOD/EvalCases/core.json:12, 18`).
43. C: An earlier turn's attachment is said to be no longer visible and is asked for again (MOD/CLAUDE.md:1433-1436).

## 6. Eval suite facts

**Case counts** (JSON files in `MOD/EvalCases/`, counted from the `key` and `status` lines; a case with no `status` is active — `MOD/BusPlanner.Chatbot.Application/Eval/ChatEvalSuiteLoader.cs:201-202`):
| File | Total | active | awaiting_tool | awaiting_snapshot |
|---|---|---|---|---|
| `core.json` | 14 | 13 | 0 | 1 (`core.open_page.path_compare_route_period`) |
| `flags.json` | 6 | 6 | 0 | 0 |
| `planned.json` | 32 | 19 | 12 | 1 (`planned.assigned_driver_changed_today`) |
| `gps.json` | 24 | 16 | 8 | 0 |
| `gpsplus.json` | 11 | 3 | 8 | 0 |
| `admin.json` | 4 | 0 | 4 | 0 |
| **JSON total** | **91** | **57** | **32** | **2** |
| Generated decline cases (one per `ChatExclusions.All` entry — `ChatLimits.cs:264-399`) | 19 | 19 | | |
| **Suite total** | **110** | **76** | 32 | 2 |

**Active cases by capability** (`capability` field): `query_plan` 14 (13 in planned + `core.open_page.no_link_for_a_data_question`); `get_current_user` 3; `get_capabilities` 2; `open_page` 1; `school_directory` 3; `plan_map` 1; `gps_health` 2; `trend_comparison` 2; `ride_time` 2; `stop_service` 1; `stop_sequence` 1; `student_actuals` 1; `path_deviation` 1; `vehicle_mismatch` 1; `planned_vs_actual_map` 1; `stop_compare` 1; `on_time_performance` 3; `follow_up` 5; `composite` 1; `self_knowledge` 2; `flag_off:*` 7 (PLANNED 2, GPS 1, GPSPLUS 3, ADMIN 1); `permission_drop:analytics:read` 2.
**Awaiting cases by tool:** `query_plan` 9, `spatial_query` 2, `stop_service` 3, `gps_health` 1, `vehicle_mismatch` 1, `trend_comparison` 1, `live_fleet` 4, `route_summary` 1, `substitution_history` 1, `open_page` 1 (+1 awaiting_snapshot), `user_activity` 4, follow-up chains 3, composite 1.
- "awaiting_tool" does not always mean the tool is missing: many wait for a snapshot-verified value on a shipped tool (`MOD/EvalCases/README.md:15`). Shipped-but-inactive examples: `planned.students_on_route`, `planned.routes_serving_school`, `planned.zero_load_stops`, `planned.retiring_students`, `planned.capacity_over_90`, `planned.bell_time_program_scoped`, `gps.stop_service_time`, `gps.run_completed_yesterday`, `gps.first_bus_at_loading_zone`, `gps.vehicles_not_reporting`, `gps.buses_covering_other_runs`, `gps.follow_up.pickup_dropoff_pm`, `gps.follow_up.avg_ride_time_am_then_pm`.
- Several active cases assert routing + groundedness only; hand-verified `expect` values are still owed for `ride_time`, `trend_comparison`, `on_time_performance` and six of the eight aggregates (MOD/CLAUDE.md:1008-1009, 1044-1045, 1104-1106; README.md:15).

**Grading.** `ChatTestEvaluator`: expected text (all), any-of groups, forbidden text, must-call, must-not-call, exact tools, optional groundedness judge on the pinned `Anthropic:JudgeModel` (MOD/CLAUDE.md:1926-1932). Nondeterminism by repeat-and-threshold, CI 3 runs / 2 passes; temperature cannot be set (MOD/CLAUDE.md:1949-1951, 1572).
**Gate thresholds.** Blocks on a decline case newly failing, a new decline case failing, or a pass-rate drop over shared cases of more than 5 points (`--max-drop`, default 5); exit 2 when it cannot judge (MOD/CLAUDE.md:1957-1963).

**Baseline** (`MOD/EvalBaseline/chatbot-eval-baseline.json`):
- `updatedAtUtc` 2026-10-13T18:48Z (:3); 65 cases; **all 65 `pass`** = 100%. Every entry is `passes 1 / runs 1 / required 1` — a single-run baseline, not 2-of-3.
- By area: core 9, decline 18, flags 5, gps 14, planned 19, gpsplus 0.
- Model `claude-opus-5`; judge `claude-opus-5` where a judge ran; prompt versions all `uni-v1:*` (for example :13).
- 11 currently active cases have no baseline entry: `core.open_page.stop_classification`, `core.open_page.no_link_for_a_data_question`, `core.open_page.page_without_permission`, `core.open_page.gpsplus_page_flag_off`, `flags.gpsplus_off_on_time_performance`, `gps.runs_over_60_minutes`, `gps.routes_15pct_over_planned`, `gpsplus.otp_week_vs_plan`, `gpsplus.routes_consistently_late`, `gpsplus.average_delay`, `decline.change_bus_or_driver`.
- Older live-eval family (tool doubles), last recorded run 2026-09-29: 47 of 48; the one failure was a flaky case fixed 2026-09-30 (MOD/CLAUDE.md:1985-1990).

**Code defaults determined in this pass:**
| Setting | Default | Source |
|---|---|---|
| Late threshold (`LateThresholdMinutes`, app_settings category `GPSPlus`) | **5 min**; late when delta >= threshold | `BusPlanner.Application/Interfaces/IGpsSettingsReader.cs:24-25, 45-46` |
| Severe late | 15 min | same :27, :47 |
| Stale / "behind" (`StaleThresholdMinutes`) | 120 min | same :30, :48 |
| Early threshold (`OnTimeDefaultEarlyThresholdMinutes`) | 5 min; early when delta <= -threshold | `CC:269` |
| Implausible delta cut-off | 1440 min | `CC:261` |
| **Operated-day bar** (`OperatedDayMinShareOfTypical`) | **0.10** = 10% of the typical day's stop visits | `CC:136` |
| Typical-day window | 20 most recent planned dates with visits; median of the window's full days | `CC:141` |
| Minimum history for a typical | 3 dates with a visit; below that one stop visit makes a day operated | `CC:147` |
| Today's "not yet due" cut-off (`TodayStopDueAfterMinutes`) | 120 min (max of 120 and 60) | `CC:15-16, 308-311` |
| Serviced rank (`ServicedMinRank`) | 2 | `CC:26` |
| Path corridor | 150 m; run-window buffer 20 min; fleet range 3 days | `CC:81, 233`; `API/Tools/PathDeviationTool.cs:41` |
| Ride-time comparable share | 25% of stops serviced | `CC:213` |
| Mismatch minimum score gain | 10 | `CC:333` |
| Freshness default page | 40 rows | `API/Tools/GpsHealthTool.cs:141` |
| Default prompt template | `uni-v2` | `MOD/BusPlanner.Chatbot.Domain/Settings/ChatRuntimeSettings.cs:44` |

## 7. SPEC vs CODE discrepancies

Severity is this document's QA judgement (High = a user can get a wrong or unauthorised answer, or a promised control is absent).

### Confirmed
| # | Requirement | What exists | Evidence | Severity |
|---|---|---|---|---|
| 1 | Purpose-built endpoints apply entity scope in their SQL (SPEC:878); path deviation respects entity scope (BL:286) | Engine analytics FIGURES (`stop_service` summary, `gps_health`, `vehicle_mismatch`, `path_deviation`, `ride_time`, OTP totals) are organization-wide, `ScopeApplied: false`; only stop-level rows and pins are scoped (since 2026-10-06). Recorded as a decision with a caveat in the answer | MOD/CLAUDE.md:487-496, 506-525, 935, 1062 | High |
| 2 | CI runs the suite on every prompt/tool-description change and blocks on regression (SPEC:707-708; BL:385-387) | Pipeline is manual only and does not run the gate; E8-4 / ENG-2509 not built | `pipelines/backend-eval.yml:37-38`; MOD/CLAUDE.md:1951-1953, 2109 | High |
| 3 | Baseline is refreshed and committed with each chatbot change (MOD/CLAUDE.md:1933-1939; BL:368) | Baseline dated 2026-10-13, prompt `uni-v1`, 65 cases; default template is now `uni-v2` and 11 active cases have no entry | baseline :3, :13; `ChatRuntimeSettings.cs:44`; section 6 | High |
| 4 | Walk-distance and wheelchair-matching questions answered in v1 (SPEC:184-187, 524-527) | ETL columns exist (migrations 56, 62) but `query_plan` has no such operation and its description says it does not cover walk distances; cases `awaiting_tool` | `API/Tools/QueryPlanTool.cs:173`; `MOD/EvalCases/planned.json:153-170`; no match for walk/seat fields in `PlanQueries.cs` | Medium |
| 5 | Live fleet, substitution history, GPS route summary, spatial queries, ADMIN user-activity in v1 scope (SPEC:110-127, 53-55, 138-146; BL:308-351) | No tool or endpoint: no `LiveFleetTool`, `SubstitutionHistoryTool`, `RouteSummaryTool`, `SpatialQueryTool`, `UserActivityTool`, no `planning/spatial` or `analytics/route-summary` route. ADMIN flag defaults on with no tool behind it | Grep over `*.cs` returned nothing; MOD/CLAUDE.md:165; `chatbot.md` §3 | Medium (spec's own "Version 2" list defers most — SPEC:979-984) |
| 6 | "GPS+ dashboard with routes 30 minutes late" opens the Live Viewer with the lateness filter applied (BL:339) | `open_page` links to allow-listed pages; only Path & Stop Compare takes parameters. Case `gpsplus.deep_link_late_routes` is `awaiting_tool` | MOD/CLAUDE.md:60-66; `MOD/EvalCases/gpsplus.json:144-146` | Medium |
| 7 | `open_page` is a GPSPLUS tool returning `link { url, label }` (SPEC:775-777; BL:343) | Flag CORE with a per-page flag and permission; payload `{ title, description, page, url, cta }` | MOD/CLAUDE.md:59-66 | Low |
| 8 | Chart legible in light and dark themes (BL:238) | The chat has no dark theme | `client/src/components/chatbot/CLAUDE.md:27` (via `chatbot.md` §6) | Low |
| 9 | Comparison mode for ride time and coverage (BL:300) | Coverage: yes. Ride time: one named student only; fleet or route ride time across two periods is not available | MOD/CLAUDE.md:977-986, 1096-1099 | Medium |
| 10 | Three report shapes render: route summary matrix, OTP summary, coverage report (BL:256) | Only `on_time_performance` emits a `report` | MOD/CLAUDE.md:1033 | Low |
| 11 | Snapshot load date matches `pln_snapshot` (BL:195) | `loaded_at` = MAX(`pln_route.modified_date`), deliberately not the snapshot's `created_date` | MOD/CLAUDE.md:1313-1316 | Low (hand-SQL oracle must use the same definition) |
| 12 | Bell times are program-scoped; answers mention program scope (SPEC:885; BL:142; TRI:56) | Bell times are per school with variants; caveat replaced; eval case still keyed `planned.bell_time_program_scoped` and inactive | MOD/CLAUDE.md:1178-1193; `planned.json:75-77` | Low |
| 13 | Tool names `trends`, `assigned_driver` (GPS flag), `draw_map` (SPEC:739-757, 783) | `trend_comparison`; `assigned_driver` is a `query_plan` operation under PLANNED; `planned_vs_actual_map` + `plan_map` | MOD/CLAUDE.md:20-23, 84, 953-955 | Low (naming) |
| 14 | E2-8: persisted reasoning is the durable record; live view only (BL:161) | What the user saw is persisted in `thinking_json` and replayed (product decision 2026-10-13) | MOD/CLAUDE.md:111-114, 1611-1613 | Low (retest AC4 on reload) |
| 15 | OTP groups `Route|School|Run|Stop`; thresholds from "GpsCustomerSettings" (BL:319, 325) | Adds `total` and an Early class the Live Viewer does not have; thresholds from `app_settings` `GPSPlus` | MOD/CLAUDE.md:1023-1027, 1039 | Low |
| 16 | E5-2 AC1 values match hand-checked runs (BL:274) | No pinned values in the eval cases and no seeded integration test of the SQL | MOD/CLAUDE.md:1104-1107 | Medium (verification gap, not a known defect) |
| 17 | Suite runs in CI (BL:358); temperature 0 or thresholds (SPEC:699) | On demand only; thresholds only | MOD/CLAUDE.md:1951 | Low |
| 18 | Capacity values match hand-computed results (BL:202) | On SDCC `vehicle_capacity` holds a size class (2, 4, NULL), so percentages are arithmetic over the wrong number; ETL story unfiled | MOD/CLAUDE.md:1363-1367, 2104 | Medium (data; HRCE not checked) |

Internal documentation drift found while comparing (not spec vs code): `MOD/CLAUDE.md:1452` says the default template is `uni-v1`, code says `uni-v2`; `MOD/CLAUDE.md:722` says the freshness default page is 50, code says 40; the spec file name says v2.2, content v2.5; the backlog file name says v1.1, content v1.6.

### Suspected (not confirmed)
- E2-7 AC2: tool-call counts and latency per conversation "visible" — the admin log has iterations, tokens, duration; a per-conversation tool-call count was not located.
- E0-2 / E0-3 performance ACs: no "agreed bound" is written down anywhere read.
- E0-4 AC1: whether every cell of the 4-scope matrix has a test (`ChatbotScopeParityTests` covers four grant shapes — MOD/CLAUDE.md:274-277).
- E0-1 AC3 and E9: no record of product-owner sign-off, security checklist, UAT or user documentation in the files read.
- E9-1 AC3: no injection case among the eval keys.
- Whether the eval snapshot has `chatbot.flags.gpsplus` on: `core.json:139` says unset (off) on 2026-10-14, while the three active OTP cases need it on (MOD/CLAUDE.md:1042-1044). If still off, those three cases cannot pass.
- SPEC:6 lets the model compare a handful of numbers; the implemented rules forbid any subtraction or division (rules 9, 39, 40). Stricter, probably intended.
- The "Version 1.5 / Version 2" list vs §1 scope (section 1).

## 8. Coverage holes: no QA script and no active eval case

| Story | What is uncovered | Other coverage that does exist |
|---|---|---|
| E0-1, E0-2, E0-3, E0-4 | Entity scope on planning GraphQL: no manual script; no eval | Unit: `ChatbotScopeParityTests`, `QueryPlanToolScopeTests` (MOD/CLAUDE.md:1846-1848, 1872-1875); chatbot-side script `Permissions-E2-4` |
| E0-6 | Migration renumbering | none found |
| E1-1, E1-2 | Walk distance, student equipment | Eval cases exist but `awaiting_tool` |
| E2-7 | Deployment, telemetry | none found |
| E3-5 | Spatial queries | 2 cases `awaiting_tool` |
| E6-1 | Live fleet, substitution history | 5 cases `awaiting_tool`; flag-off case `flags.gpsplus_off` is active |
| E6-3 | GPS route summary | 1 case `awaiting_tool` |
| E6-4 | Deep links | No script. Active evals cover the analytics page link, permission drop and flag-off only; the Live Viewer filter link and Path Compare parameters are inactive |
| E7-1 | ADMIN tool | 4 cases `awaiting_tool`; `flags.admin_off` active |
| E8-4 | Gate in CI | none |
| E9-1, E9-2, E9-3 | Security review, QA plan/UAT, user docs | none |

Partial holes worth a test plan entry (a script or an eval exists, the other does not, or the active eval is thin):
- Attachments (ENG-2609): no script; the eval harness cannot exercise them (MOD/CLAUDE.md:1437-1438).
- `stop_compare`, `school_directory`, `open_page`: active evals, no manual script.
- Demo-script core flows with no active eval: student pickup then drop-off then PM follow-up; average ride time AM then PM; arrival time at a stop; run completed yesterday; first bus at a stop; routes serving a school; students on a route; zero-load stops; retiring students; capacity over 90%.
- Prompt injection through data fields: no eval case, no script.
- Scope evals in the live suite: only two permission-drop cases; row-level scope is unit-tested, not exercised with a real model in `MOD/EvalCases/`.

## Not determined
- Contents of "Adding a simple chatbot tool" (empty after conversion); `docs/chatbot/Adding-Tools.md` is the working recipe and was not read here.
- Whether any eval run newer than the 2026-10-13 baseline exists outside the repo (pipeline artefacts).
- The HRCE tenant's actual threshold rows (a QA script says HRCE late = 3; code default is 5).
- Story statuses in Jira; this file infers status from `MOD/CLAUDE.md` only.
- Which scope statement governs: SPEC §1 or the trailing version list.
