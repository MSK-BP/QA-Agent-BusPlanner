# Domain

> Status: SOURCED 2026-11-10 from Confluence (space PE) and Jira (project ENG). Slack was not readable until 2026-11-20 (see "Open questions"). Every fact carries a source. Anything marked UNVERIFIED is an inference, not a statement found in a source.
>
> Source shorthand: `PE/<id>` = `https://busplanner.atlassian.net/wiki/spaces/PE/pages/<id>`; `ENG-n` = `https://busplanner.atlassian.net/browse/ENG-n`.
>
> Updated 2026-11-10 after a full read of every non-PRD page in space PE (76 pages + 1 database; see `confluence.md` for the inventory and the complete rule lists). Rows added or corrected by that read cite the page they come from.
>
> Caution on the "Connected PRD" pages (PE/239140866 and siblings, titled "PRD · ..."): they are machine-generated from one PRD file (v0.100, pushed 2026-11-05; twelve pages moved to v0.101/v0.102 on 2026-11-09, see `confluence-prd.md`), and mix "Today [verified]" statements with "To-be [proposed]" ones. Only the "Today" parts describe shipped behaviour. Rules below say which kind they are.

## Products and modules

Two generations exist side by side. Sources call them **Old World** (the 13.x "BusPlanner Main" suite and 12.4.x Fleet) and **New World** (BusPlanner Unified).

### New World: BusPlanner Unified ("BP Unified")

| Module | What it is | Who uses it | Source |
|---|---|---|---|
| Time & Attendance (T&A) | Employee and payroll setup, time records, pay periods (OPEN -> CLOSED -> EXPORTED), absences, overtime monitoring; PIN clock-in from the Turns tablet (`/api/ta/timescan/auth/pin`) | Drivers (via Turns), payroll/office | Epics ENG-3, ENG-763, ENG-12; ENG-773; PE/238485608 |
| GPS+ Live Viewer | Auto-refreshing fleet list + map, one row per bus, status On Time / Late / No GPS Events / No Route | Dispatchers | PE/138313730; PE/225050641 |
| GPS+ Event Viewer | Historical signal timeline (ignition, doors, stop arm, amber lights) for one route's runs, up to 14 days, CSV export. Permission `gpsplus:events:read` | Dispatch / office | PE/137822221 |
| GPS+ Path & Stop Compare | Planned stops vs what GPS recorded, one route, up to two weeks, outcomes Serviced / Probable / Skipped / Not Seen. Permission `gpsplus:compare:read` | Dispatch / office | PE/139231233 |
| GPS+ Route Management | Dialog opened from a Live Viewer row: change a route's bus (written through BP Info, visible after the next substitution import) or driver (visible on next refresh) | Dispatchers with route-management permission | PE/225050641; Epic ENG-2581; ENG-2861, ENG-2808 |
| GPS+ Device Mapping, Smart Mappings | Menu entries only: Device Mapping is a "coming soon" placeholder page, Smart Mappings is greyed out | - | PE/225050641 |
| Chatbot ("Ask AI", "AI Assistant", "Ask BusPlanner") | Agentic assistant answering questions over plan, GPS and GPS+ data. Not the same as "Assistant (AS)" in the PRD, which is an Old World staff mobile app (PE/239534102). Scope is a fixed list of 42 questions: v1.0 = 26, v1.5 = 6, v2.0 = 10; feature flags `GPS`, `GPSPLUS`, `ADMIN` | Office users, operator-scoped users | Epics ENG-296, ENG-1870, ENG-1871, ENG-1873, ENG-2117, ENG-2133, ENG-2917; PE/137232386 |
| ETL ("New World ETL") | Extract (an exe on the customer's Windows server, nightly, usually 02:00 local) uploads JSON + a manifest; Load (one Kubernetes CronJob per client per environment) writes plan snapshots into `BP_Unified_<CODE>` | Internal | ENG-2747..ENG-2752, ENG-2903; PE/251756545; PE/157450256 |
| GPS services | GPS Reader (polls providers about every 20 s), Stop Classification, GPS Substitution Import (pulls from BP Info about every 5 min). Each is a single pod for all customers. The Unified reader supports Geotab, Zonar, Synovia, GTS and Samsara only | Internal | PE/174227457, PE/156794883, PE/251756545 |
| Client_Registry | Per-environment database that routes a login to the client database and holds feature flags (`GLOBAL_LOGIN`, `GPS`, `CHATBOT`) | Internal | PE/251756545 |
| Dispatch (New World Dispatch) | **Not shipped.** V1 is a draft proposal (v0.14, 2026-11-04) under engineering review; on the platform today Dispatch is a disabled "coming soon" tile. Jira has components "Wave 1..8" and a merge/split tool, which may be work in progress (PE/238157830, 238583811, 239304705) | Dispatchers | ENG components "BP Unified Dispatch - Wave 1..8"; Epic ENG-1625 |
| Planned vs Actual (PvA) | Data layer + algorithm/validation | Internal / Dashboard | Epics ENG-351, ENG-352 |
| Users and Access | User management PRD, final 2026-10-26 | District admins | PE/237043713 |
| Discipline Module = Ride Support (code name `conduct`) | **Designed, not built** (2026-11-20): schema, decisions D1–D55, API v1 design and wave-1 stories exist; no product code yet. Built on a generic **Forms Engine** (`frm_` tables) with Ride Support tables (`cnd_`). Rules, scope, waves and Jira keys: section "Ride Support and the Forms Engine" below. Earlier status (user, 2026-11-13): not started. Core flows must be built and pass QA by **2026-12-18**. Spec: Confluence folder PE/238616600 "PRD · Ride Support"; V1 scope is "Ride Support V1" v0.7 of 2026-11-11 (PE/239108122, PE/241500162); test plan `reports/2026-11-14-testplan-ride-support-v1.md`. Reference behaviour: the connected prototype (`connected-prototype.html`, user's Work Docs folder, about 97 MB, one file, in-browser SQLite); not shipped, the spec wins. Walkthrough: `reports/2026-11-13-ride-support-prototype.md`. Digest: `confluence-prd.md` (grep "Ride Support", "Conduct_", "cnd:") | Drivers, monitors, transportation and school reviewers, families (letters only) | Jira product and v1 epics 847, 848, 849 in the PROD project (Backlog); PE/238616600 |

BP Unified has its own repo and pipeline (`dev` / `staging` / `main`) and does not follow the Old World QA1/QA2 flow (PE/235175938).

### Old World: BusPlanner Main (13.x) and others

| Product | What it is | Source |
|---|---|---|
| BP Pro | Desktop routing product; "source of truth" for routes, runs, stops, students, staff | PE/239173635 (system map); PE/239271938 |
| BP Web | Web portal: Parent Portal, alerts/notices, settings, reports, Workflow | PE/238485587; ENG-2486, ENG-2982 |
| BP Quick (code name Goldilox) | Web app hosting Dispatch, old-world GPS+, staff manager, dashboards, reports | PE/239271938 section 9.4 |
| BP Fleet | Maintenance: work orders, inventory, purchase orders, reminders. "New Fleet" is 12.4.x on `fleet-*` branches (Miami train); older Fleet ships in 13.x | PE/239271938 section 9.4; PE/235175938 |
| BP Trips (SE = StandardEdition, CE = BidEdition) | Field trip requests and driver trip sheets | PE/239271938; Epic ENG-2974 |
| Turns | Android driver tablet app: navigation, student scanning, pre/post-trip inspection, T&A clock-in | PE/239173635 (SY-26); ENG-2646 children |
| Subs | Substitute-driver app | PE/239173635 |
| Chipmunk | Parent app (bus location, ETAs, alerts), iOS + Android | PE/239173635 (SY-19, SY-26) |
| Delays | Public delays / closures app | PE/238026775; fix version "2.4.9 - Delays" |
| Trackers (`BPTrackerService`) | One Chipmunk tracker and one Dispatch tracker per district; compute ETAs and live views | PE/239271938 section 9.4; PE/239173635 (SY-15) |
| GPS readers | Old World: 9 vendor reader services (Geotab, Samsara, Synovia, Zonar, CTS, GTS, Where's The Bus, TRBOnet, DataRemote); one spec lists 8. New World: one reader service covering Geotab, Zonar, Synovia, GTS, Samsara | PE/239173635 (SY-15); PE/238551066, 237993990, 238518317 |
| BPInfo REST ("the door") | REST API (99 controllers) used by apps and by BP Unified to read/write Old World data. That is its target role; today it is not the only route: Chipmunk also uses its tracker, Fleet and Workflow write through GEDI/GeoIMS, and BP Web's Where's My Bus calls the GPS vendor directly. No global authorization filter; 29 anonymous actions | PE/239173635 (SY-10), PE/239173656 |
| Subscription Service | Sends parent emails for changes | PE/239173635 (SY-14) |
| Path Server | Shortest-path service used by eligibility calculation in BP Pro | ENG-3043 |
| Workflow | Forms and approvals in BP Web | PE/239075373 |

Which repo owns each Old World product: no list exists outside the PRD family (branch names: `dev`/`stage`/`main`, `fleet-dev`/`fleet-stage`/`fleet-main`; PRs are in Azure Repos per the Development field on ENG-3043). Fragments found: Azure DevOps has a "managed" section and an "unmanaged" (native C++ BP Pro) solution; repo `BPFinanceContracts` holds per-client finance contracts (PE/177668097); code units `BPInfo.Rest.Service` (PE/136347650), `TripsStandardEdition`, `Georef.Web.Trips.StandardEdition`, `Georef.Web.Users` (PE/214695940); infrastructure repo `iks-gitops` (PE/195297284); New World repo `BusPlannerUnified` (PE/251756545).

Old World facts added by the full read:
- BP Pro API (`BPInfo.Rest.Service`) is effectively read-only; its only real write is the GPS route-to-vehicle mapping; login issues 1-hour bearer tokens (PE/136347650).
- Staff reach a route through the vehicle (route -> vehicle -> vehicle staff), so changing a route's driver changes it on every route that vehicle serves (PE/136347650).
- Trips has no API; it has no depot or deadhead data; each Trips database serves one district; editions are Standard and Bid (PE/136118274, PE/214695940).
- A finance contract is an XML file with Lua logic stored in the BP Pro database; it computes a route's cost per day (PE/177668097).
- Old World hosting: per-client Windows servers (`ca-*`, `wwwNN`), reached by per-client RDP (PE/195297284, PE/256081921).

## Users and roles

| Role | Uses | Source |
|---|---|---|
| Dispatcher / office | Quick Dispatch, GPS+ Live Viewer, BP Web | PE/138313730; PE/239173635 |
| Router / planner | BP Pro | PE/239173635 (SY-24 "the router") |
| Driver, monitor/aide | Turns, T&A clock-in | PE/239173635; PE/238485608 |
| Parent / family | Chipmunk, Parent Portal, Delays | PE/239173635 |
| Mechanic | Fleet | PE/239173635 |
| Trip requester | Trips | PE/239173635 |
| Payroll | T&A | PE/238485608 |
| School staff ("School Viewer") | See own schools' buses | PE/239271938 |
| Operator-scoped user | A user restricted to one bus operator's data (Chatbot, GPS+) | ENG-2711, ENG-2931 |

BP Unified access model: a per-page permission, plus two independent grants, **operator access** and **depot access**, each restricted to a list or unrestricted. Visible data is the intersection of both (PE/138313730 section 7). Chatbot has its own permission `chatbot:read` (ENG-2906). Event Viewer (`gpsplus:events:read`) and Path & Stop Compare (`gpsplus:compare:read`) are gated by one permission each and apply **no** operator or depot scoping (PE/137822221, PE/139231233). A new client database has only the `Admin` role (PE/251756545).

Auth as built (PE/162430977): one JWT per login, 60 minutes plus 5 minutes clock skew (about 65 minutes effective); all permissions and scopes are baked into the token, so a permission change needs a re-login; no revocation; any 401 wipes local storage and redirects to `/login?expired=1`; Timesheet and Overtime polling stop at expiry but the Live Viewer poll is not gated. Refresh tokens are a proposal.

Sign-in flow (PE/225050641): work email, then "Choose your organization" if the email belongs to several, then password. A user lands on the first product they can use. Login works through a central URL and a client-slug URL (PE/251756545).

Customers are school districts, school boards and consortia in Canada and the US; the two countries run in separate cloud accounts (PE/251756545). Jira summaries prefix a customer code such as `[CA-ON-xxxx]` or `[US-FL-xxxx]` (country-province/state-customer).

## Core concepts and glossary

Source for all rows unless noted: PE/239271938 (PRD glossary; section 9.3 "say / not / means", section 9.4 code names).

| Term | Meaning |
|---|---|
| route | A bus's whole day: its runs in order |
| run | One pass that picks up or drops off riders |
| run version (RunV) | A run's plan for a date range and days of week |
| stop | A place a run picks up or drops off |
| component | Pro's run type: AM, PM, Noon or Other |
| deadhead | Driving with no riders (to first run, between runs, back to yard) |
| yard / depot | Where a bus is kept; Pro says depot |
| operator | The bus company operating a vehicle; also an access scope |
| the plan | Pro's routes, runs, stops, students and crew as loaded for a day |
| snapshot | The platform's copy of the plan for one service day, with Dispatch's changes for that day. Code keeps a rolling window of 10 weekdays (ENG-2903, data-services map); the PRD is inconsistent on retention (PE/239271938, 239304705) |
| plan vs actual (PvA) | What happened (GPS, scans) measured against the day's plan |
| substitution / swap | Another bus or driver on a run; "just today" (temporary) vs "from now on" (permanent) |
| ESE / Reg Ed | Special education / regular education program of a run. Cards show "ESE" per the glossary, "SPED" per the Dispatch V1 page (unresolved) |
| Delta (GPS+) | Minutes early (negative) or late at the bus's last stop (PE/138313730 section 8) |
| ETA (GPS+) | Next stop's scheduled time shifted by current Delta; not a prediction (PE/138313730) |
| No Route / No GPS Events | GPS+ statuses: bus has no route today / tracker has not reported recently (PE/138313730) |
| page-scope vs grid-only filter | Depot/operator filters narrow list and summary cards; search, minutes-late, status card and pins narrow the list only (PE/138313730) |
| eligibility | Whether a student qualifies for transport; in BP Pro computed from student-to-school distance, optionally by driving path via the Path Server (ENG-3043) |
| cluster stop | A stop marked as a cluster stop, shown with a distinct icon (Epic ENG-2458) |
| the door | BPInfo REST |
| Goldilox | Code name of Quick |
| "BusPlanner" GPS provider | Geotab |
| Old World / New World | Legacy 13.x suite / BusPlanner Unified (PE folders "Old World Documentation & PRD", "New World PRD's and Documentation") |
| ZD / [nnnnn] in a summary | Zendesk ticket number (PE/174850052) |
| SPT | Support Queue Jira project; origin of client-reported bugs (PE/174850052) |
| QA1 / QA2 | Test environments built from `dev` / `stage` (PE/235175938) |
| MSDE, TDTIMS, Ontario Ministry reports | State/provincial regulatory reports (Maryland, North Carolina, Ontario) (Epics ENG-2597..2599, ENG-2457; ENG-2893) |
| Serviced / Probable | Path & Stop Compare outcomes meaning the stop was covered; Serviced has stronger evidence (stopped and door-open recorded), Probable weaker (speed about 0, no door signal) (PE/139231233, PE/225050641) |
| Skipped / Not Seen | Skipped = recorded passing the stop without stopping. Not Seen = nothing recorded near the stop although the day and tracker were working (PE/139231233) |
| Not due yet / Unconfirmed | Not outcomes. Not due yet = too early to judge. Unconfirmed = tracker went quiet around the scheduled time (PE/139231233) |
| On-path compliance | Share of a bus's driving that stayed on the planned path, measured over its whole day including depot time and other routes (PE/139231233) |
| GPS gap | A stretch where the tracker did not report; a line break caused only by run selection is not called a gap (PE/137822221, PE/139231233) |
| run-day | One run on one service date (PE/225050641) |
| event types (GPS+) | Ignition, Door, Stop Arm, Amber Lights (PE/137822221) |
| Late / Very Late / stale thresholds | Per-customer settings; defaults Late 5 min, Severe-Late 15 min, Stale 120 min, Early 5 min (PE/251756545) |
| substitution import | The service that brings old-world bus changes into GPS+; polls BP Info (PE/225050641, PE/156794883) |
| intent table / importer / resolver | PROPOSED design for dated vehicle assignments: old world -> intent table -> snapshots (PE/226918402) |
| pre-projection window | Number of future days of snapshots prepared; 10 today, 20 proposed (PE/226918402) |
| Client_Registry | Per-environment routing and feature-flag database of BP Unified (PE/251756545) |
| devteam | Shared developer account seeded into every Unified client database; flagged as a security concern; not for testing (PE/251756545) |
| Live / Dispatch database | Old World: Dispatch works on a copy rebuilt from the Live database every night at 2 AM (PE/185204738) |
| Send Run Changes | Old World Dispatch action that notifies parents and the tracker of run changes (PE/185204738) |
| Double Back / Double Up | Coverage types: one driver runs two runs back to back / a run is folded into another driver's run (PE/68255745) |
| callout | A driver or monitor absence logged in Dispatch (PE/68255745) |
| cluster stop | Large stop (50-150+ students), formerly "pool stop"; a checkbox on stop properties behind a client setting (PE/167837697) |
| DOR | District of record (PE/136249345) |
| VRO, WO, PO | Fleet document types: VRO (outside-repair order; expansion not given on the page), WO = work order, PO = purchase order (PE/210960386) |
| CTA | "Call to action" in the retrospective (PE/158662658) |
| central URL / client-slug URL | The two ways to reach the BP Unified login (PE/251756545) |

## Business rules that tests must protect

"Covered by" is UNKNOWN for every row: no test inventory was available to this pass.

### GPS+ Live Viewer (shipped behaviour, PE/138313730 section 5)

| Rule | Source | Covered by |
|---|---|---|
| Status precedence: No Route > No GPS Events > Late > On Time; each bus counted once | PE/138313730 BR1 | UNKNOWN |
| On Time is the default, including early buses and buses with no lateness info, if routed and reporting | BR2 | UNKNOWN |
| A bus with a route but not on a run is On Time with Run "No run" | BR3 | UNKNOWN |
| Only active vehicles with a linked tracker appear; others are absent with no error | BR4 | UNKNOWN |
| ETA = next stop scheduled time + current Delta; cleared once in the past; blank when not on a run | BR5 | UNKNOWN |
| Active run choice: in-progress > overrunning > not started. Window is start - 30 min to end + up to 90 min (hardcoded) | BR6 and Q&A section | UNKNOWN |
| A run crossing midnight is never the active run | BR8 | UNKNOWN |
| Pins follow the vehicle, max 20, survive reload within the session | BR9, UC-6 | UNKNOWN |
| Depot/operator filters narrow list and cards; search, minutes-late, status card, pins narrow the list only | BR10 | UNKNOWN |
| Default refresh every 15 s; interval and pause state are per session | BR11 | UNKNOWN |
| Late / Severe-Late / Stale thresholds are per customer | BR12 | UNKNOWN |
| "Later than N minutes" matches only Late buses strictly greater than N | BR16 | UNKNOWN |
| "Clear" resets depot, operator, minutes-late only; not search or status card | BR17 | UNKNOWN |
| Implausible delay (more than a day) is hidden, not shown | Limitation 11 | UNKNOWN |
| Visibility = intersection of operator grant and depot grant; "Unassigned" filter only for fully unrestricted users; needs four test accounts | section 7 | UNKNOWN |
| Multi-route warning icon shows only when the bus is idle and has more than one assigned route | Q&A section | UNKNOWN |

Note: BR14 says the Live Viewer "has no concept of substitution" and the page calls it "entirely read-only". Both are stale. The GPS Plus User Manual of 2026-10-30 documents the Route Management dialog on the Live Viewer and a working Compare row action (PE/225050641). The handoff page's content dates from 2026-09-14.

More Live Viewer rules from the full read:

| Rule | Source | Covered by |
|---|---|---|
| Late means at or above the customer's Late threshold; the badge is yellow from the Late threshold and red from the Very Late threshold; there is no separate Very Late status, card or filter | PE/225050641; PE/138313730 limitation 8 | UNKNOWN |
| Sorting by status orders On Time, Late, No GPS Events, No Route; within Late, most-late first in both sort directions; other groups by bus name (supersedes BR15 "alphabetical within Late") | ENG-2880; PE/138313730 BR15 | UNKNOWN |
| Resume after a pause refreshes at once; returning from a background tab refreshes at once only if the data went stale | BR13 | UNKNOWN |
| A 21st pin is refused with "Pin limit reached (20) - unpin a bus to add another"; a pinned bus that is not out is kept and shown as missing | PE/138313730 scenarios; PE/225050641 | UNKNOWN |
| A user with no operator or depot access sees "No buses fall within your access. Ask an administrator to grant your account an operating company and depot." | PE/225050641 | UNKNOWN |
| Refresh interval options are 5, 10, 15, 30, 45, 60 s; on failure the old data is kept and a retry banner shows | PE/225050641 | UNKNOWN |
| A bus that never reported a position never appears on the map | PE/138313730 UC-8 | UNKNOWN |
| A cancelled run cannot be recorded; it looks like a tracker that stopped reporting | Limitation 1 | UNKNOWN |

### GPS+ Route Management (shipped behaviour, PE/225050641)

| Rule | Source | Covered by |
|---|---|---|
| The "Change this route's bus or driver" action shows only for users with route-management permission and only for buses with a route | PE/225050641 | UNKNOWN |
| A bus change shows only after the next substitution import; a driver change shows on the next refresh | PE/225050641 | UNKNOWN |
| A driver change applies to the bus today, on all its routes | PE/225050641 | UNKNOWN |
| On failure nothing is changed and one of three messages shows: could not be sent / BusPlanner Info couldn't be reached / no permission | PE/225050641 | UNKNOWN |
| Cancel changes nothing | PE/225050641 | UNKNOWN |
| OBSOLETE: "a blank BP Info `DatabaseGuid` refuses driver changes". The `DatabaseGuid` and `ReadBackDryRun` settings were removed; the only gate is now the route-management permission | ENG-2765; was PE/251756545 E11.1 | n/a |
| BP Info writes are always disabled on staging | PE/251756545 | UNKNOWN |
| Known defect: a driver reassign moves the planned bus but the old-world row stays, so after the nightly ETL the route moves back | ENG-2650; PE/226918402 | UNKNOWN |
| Fixed (ENG-2738 Resolved): an unresolvable mapping used to be dropped and the planned bus silently restored. Design rule: a route is what a vehicle does in a day; a run-level substitution moves that run onto the vehicle's route. Regression-test it | ENG-2738; PE/226918402 | UNKNOWN |

### GPS+ Event Viewer (shipped behaviour, PE/137822221; all 17 rules in `confluence.md` 5.2)

| Rule | Source | Covered by |
|---|---|---|
| Exactly one route at a time; picking another route clears the selected runs | BR1 | UNKNOWN |
| Date range capped at 14 days; a wider range shows a message and loads nothing; it is never silently shortened | BR2 | UNKNOWN |
| Days when the route was not in the plan, and days with no plan at all, are each named in a note | BR3, BR4 | UNKNOWN |
| Only changing dates or route/run selection calls the server | BR5 | UNKNOWN |
| An event claimed by several runs shows once grouped by Date and once per run grouped by Run | BR7 | UNKNOWN |
| The CSV export always has one row per event and only the currently filtered rows; Export is disabled when nothing shows | BR8, BR9 | UNKNOWN |
| Event-type toggles change map markers, never the path lines | BR13 | UNKNOWN |
| A substituted route or run is silently missing from the picker | BR16 | UNKNOWN |
| A run with a specific data problem makes the whole date range be rejected with a message naming the run | BR17 | UNKNOWN |

### GPS+ Path & Stop Compare (shipped behaviour, PE/139231233; all 32 rules in `confluence.md` 5.3)

| Rule | Source | Covered by |
|---|---|---|
| Every judgeable stop gets exactly one of Serviced, Probable, Skipped, Not Seen; an unjudgeable stop shows no outcome | BR1, BR2 | UNKNOWN |
| A missing measurement is never shown as a missed stop: whole-day-unmeasured rows show a dash | BR3, scenarios | UNKNOWN |
| Stops Serviced leaves out stops that are Not due yet, Unconfirmed or Not Seen, and unmeasured days | BR10 | UNKNOWN |
| On-path compliance covers the bus's whole day; it shows a percentage, "No route path" or "No tracking", and 0% only for a measured zero | BR15, BR16 | UNKNOWN |
| A fleet without the sensor never gets Serviced; stops top out at Probable | Limitation 9 | UNKNOWN |
| Date range at most two weeks, refused before loading; default is the last 7 days | BR22, UC-1 | UNKNOWN |
| A route with no bus assigned stays selectable and the page explains why nothing can be assessed | BR23 | UNKNOWN |
| A route or run affected by GPS+ substitution is silently left out of the picker | BR24, BR25 | UNKNOWN |
| One run with an unresolved data problem makes the whole date range be refused, even for unrelated routes | BR26 | UNKNOWN |
| The export always carries Date, Route, Run and a Reason column, writes early/late in words, and includes a line for dates with nothing to report | BR29, BR30 | UNKNOWN |
| Nothing is conveyed by colour alone; every resize handle works from the keyboard | BR14, UC-7 | UNKNOWN |

### Chatbot answers (scope page PE/137232386)

| Rule | Source | Covered by |
|---|---|---|
| A question is answerable only if it is one of the 42 scoped questions and its feature flag (`GPS`, `GPSPLUS`, `ADMIN`) is on; Time & Attendance questions are out of scope | PE/137232386 | UNKNOWN |
| Every answer defaults to a sortable table with a "showing N of M" note when truncated | ENG-1900 | UNKNOWN |
| Driver answers must state that the driver is the planned assignment and substitutions are not visible | PE/137232386 | UNKNOWN |
| Runs missing scheduled stop times are excluded from ride-time answers and listed with the reason | PE/137232386 | UNKNOWN |
| Days with no GPS data are excluded from on-time performance with an explicit exclusion count, never counted as late | PE/137232386 | UNKNOWN |
| GPS stop times are arrival-only, one visit per stop per day, and the answer says so | PE/137232386 | UNKNOWN |

### Data scope and privacy

| Rule | Source | Covered by |
|---|---|---|
| Operator-scoped users must not see student names outside their scope (was violated on GPS-substituted plan days) | ENG-2711 | UNKNOWN |
| A user without access must get an access message, not a "nothing found" answer | ENG-2927 | UNKNOWN |
| A user with only `chatbot:read` must see the Ask AI module; chatbot must not require a T&A permission | ENG-2906, ENG-2925 | UNKNOWN |
| Read-only access level must be enforced in Quick/Pro | ENG-2800 | UNKNOWN |
| Revoking a delete permission must hide/disable Delete controls in T&A | ENG-1597 | UNKNOWN |
| FIXED (FV 2.8.10.2026): Event Viewer and Path & Stop Compare now apply operator and depot grants like Live Viewer, and show GPS-substituted routes (spare stand-ins carry a grey label with the substitute vehicle). The Confluence pages still describe the old gap | ENG-2157, ENG-2158, ENG-2062, ENG-2398; was PE/137822221 s7, PE/139231233 lim. 1 | UNKNOWN |
| A filter can never reveal a bus outside the user's grant; list and summary cards agree on which buses are in scope | PE/138313730 section 7 | UNKNOWN |
| Old World Trips SE, as built: opening a trip by ID has no access check (list and calendar are filtered by school only) | PE/214695940 | UNKNOWN |
| ETL extracts hold student and staff personal data and are deleted from storage after 14 days | PE/251756545 C2.1 | UNKNOWN |
| A permission or scope change takes effect only after the user logs in again (claims are baked into a 60-minute token) | PE/162430977 | UNKNOWN |

### ETL / plan data

| Rule | Source | Covered by |
|---|---|---|
| One failed plan load must not deactivate the other snapshots | ENG-2903 | UNKNOWN |
| Students assigned to stops in Pro appear on those stops with the right program | ENG-2747 | UNKNOWN |
| Students removed from a stop in Pro leave it in upcoming plans | ENG-2752 | UNKNOWN |
| Bus capacity and wheelchair flag import correctly | ENG-2748 | UNKNOWN |
| All staff per bus and their phone numbers are kept | ENG-2749 | UNKNOWN |
| Address types and second addresses are preserved | ENG-2686 | UNKNOWN |
| Nightly ETL reload must not reset live substitution overlays | ENG-2620 | UNKNOWN |
| Duplicate StaffIDs in BP Pro stop the ETL Load; the Load job reports Completed even when it failed (check the log) | PE/251756545 Known issues | UNKNOWN |
| A successful Load logs "1/1 manifests loaded, 0 failed" and "completed successfully" and sets the `_manifest_loaded` watermark; an already-loaded extract is skipped, and re-running is safe | PE/251756545 E12.6, E12.7 | UNKNOWN |
| The Extract's scheduled task reports success even when the extract failed; the manifest `status` is what counts | PE/251756545 C3.6 | UNKNOWN |
| Customer and school-year GUIDs are identical in every environment; wrong GUIDs file one client's students under another client | PE/251756545 C1, C3.3 | UNKNOWN |
| GPS events processed before a device is linked to a vehicle are never matched later | PE/251756545 E15 | UNKNOWN |
| Only buses on an active old-world route get a device link; spares, parked and unassigned buses stay unlinked | PE/251756545 E14 | UNKNOWN |
| A new client has no GPS+ thresholds until they are seeded (defaults 5 / 15 / 120 / 5) | PE/251756545 E11.2 | UNKNOWN |
| The substitution import's `Enabled` setting defaults to true when the key is absent | PE/156794883 | UNKNOWN |
| A new customer's GPS is read within 15 minutes, but stop classification and substitution import see it only after a restart | PE/157450256 step 5; PE/251756545 E13 | UNKNOWN |

### Time & Attendance

| Rule | Source | Covered by |
|---|---|---|
| Pay period lifecycle OPEN -> CLOSED -> EXPORTED, auto-generation, department overrides | ENG-773 (cites PROD-282, PRD section 4.11) | UNKNOWN |
| Multi-day absence booking skips paid holidays | ENG-2879 | UNKNOWN |
| Paid holiday hours follow the employee's FTE, not a flat 8 h | ENG-2876 | UNKNOWN |
| Records page read latency target p95 under 1 s | ENG-2894 | UNKNOWN |
| SHIPPED in BP Unified: 5 wrong PINs lock the employee for 15 minutes; Turns must show a lockout message, not "Couldn't reach the server" (ENG-2712). Still PROPOSED: offline clock events queue with device time; retired person's PIN fails within 15 min; off-site clock-out accepted and flagged | PE/238485608 TA-R4..R7 | UNKNOWN |

### Time zones and GPS time

| Rule | Source | Covered by |
|---|---|---|
| GPS event times must be stored correctly across time-zone rule changes (Alberta events were 60 min behind) | ENG-2971; PE/256081921 | UNKNOWN |
| GPS+ timing must not be offset by an hour for a customer | ENG-2695 | UNKNOWN |
| Stop-classification visits must attach to the right run (ENG-2849 adds a 15-minute threshold to tell stop passes apart) | ENG-2849; PE/87031810 | UNKNOWN |
| The Old World Geotab reader converts UTC to local time itself from the vehicle's zone; Zonar and Samsara readers use the server clock. A regional time-rule change is a code risk, not only a server task | PE/256081921 | UNKNOWN |
| BP Web pages `~/Subscriptions/WheresMyBus` and `~/School/VehicleLocator` use the same conversion; "not yet validated or QA'd" after ENG-2971 | PE/256081921 action 5 | UNKNOWN |
| All GPS+ times display in the district's local time | PE/225050641 | UNKNOWN |
| ETL Extract config takes the Windows time-zone id; the Load CronJob takes the IANA name; swapping them fails | PE/251756545 troubleshooting | UNKNOWN |

### Ride Support and the Forms Engine (designed, not built)

Source: Tommy Zwirblia's handoff, posted in Slack `#dev-unified-discipline` (private, C0CKYB5K28G) on 2026-11-20. "FE" below = the repo package `docs/forms-engine/`. It will go into `BusPlannerUnified` at `docs/forms-engine/`; until then a local copy is at `C:\Users\skhan\Repos\discipline-forms-engine\repo-package\repo-package\docs\forms-engine\` (outside the tenant). Owner Tommy Zwirblia; API and Turns coordination Drew Weeks. In FE, the SQL in `db/` wins over every document, and `decisions/decisions.md` holds D1–D55 with superseded ones kept.

**Jira** (handoff doc): product PROD-847; features PROD-848 V1, PROD-993 V1.5, PROD-994 V2; epics ENG-3249..ENG-3305 (57); wave-1 stories ENG-3306..ENG-3318 (13, ready to start); labels `discipline`, `forms-engine`, `platform`, `turns`, `wave-1`..`wave-8`, `v1.5`, `v2`. Full key list: FE `planning/jira-keys.md`. UNVERIFIED: the earlier row cites PROD-849 as a v1 epic; the handoff does not name it.

**Database** (FE README, handoff): install order on a database that already has Unified schema v7.21: `frm-forms-engine-draft-06.sql` (40 `frm_` tables + platform changes), `frm-discipline-domain-draft-02.sql` (11 `cnd_` tables), `frm-seed-discipline-draft-04.sql` (set `@customer_guid`; one transaction). Older databases upgrade through `db/deltas/`. Today only the HRCE test database has it (`HRCE_TommyZ` up to date, Slack 2026-11-20); **dev and QA do not**. The handoff names a combined `db/frm-install-fresh-draft-01.sql`, but it is not in the package (2026-11-20). Existing `ins_*` tables stay for now and are dropped later (O7, D1).

**V1 scope** (FE `requirements/v1-scope.md`, set in Discipline Planning 2026-11-19):

| In V1 | Not in V1 |
|---|---|
| Turns: Referrals button and screen (My Referrals, New Referral); start, save unfinished, finish, submit | Letters generated and sent by the system (V2; needs two-way Chipmunk messaging) |
| Web: everything Turns does, plus review and decide | Any Chipmunk change, including one-way messaging |
| Form types Problem (referral), Praise, Incident (as seeded, D34), Concern | Incident report for emergency services (feature #11) |
| Review workflow: transportation, then school, as the customer sets it | Seating chart on the platform or tablet (V2; stays in BP Pro, D39) |
| Family contact recorded by hand per guardian (checkbox + date, or "no letter needed"); this lets a referral close (D35) | Automated notifications (Slack 2026-11-19: email by hand until a notification service exists) |
| Withdraw from Turns while unopened; once opened, approver with `cnd:referral:approve-withdraw` (D53, D54) | |
| SIS CSV export, suspension log export (D38), reports (V1-5 open), service-day calendar (D40) | |
| V1.5 lane, built alongside: form builder (D42), district edit screens for reasons, actions, letters (D43) | |

**Build order** (FE `planning/build-order.md`): V1 = 182 stories in 8 waves. Wave 1 = forms work end to end, **API only, no screens**; QA tests through the API collection of story A3-6 (ENG-3318). Wave 2 ends with the **first slice**, the first thing QA can test end to end: a referral written on Turns reaches review. Concern (wave 6) comes after access and confidentiality (wave 3). Bus suspensions and the door alert are wave 7.

**Test data** (FE story A1-2, ENG-3309): one idempotent script `db/test/frm-test-district.sql` loads the PRD's made-up test district (schools Oak Elementary, Pine Middle, Elm Center; buses 42, 51, 60, 64, 1951, 88; students with SIS IDs 100101–100108; users such as Lee, Pat, Transportation 1, Oak AP 1/2, Viewer 1) and a second customer "Other District" for isolation tests. It must refuse a database with a real customer. QA logins are kept out of the repository.

**API v1** (FE `design/api-v1.md`): base `/api/frm`. Manifest, definition download (ETag = `definition_hash`, `304`), attachments URL, media reserve and complete, `PUT` draft, `POST` submit, my results, one result. Errors: `400` lists every error at once; `404` when the caller cannot see the object; `409` for stale `row_version` or a draft held by another editor. The customer comes from the token, never from the request.

| Rule tests must protect | Source | Covered by |
|---|---|---|
| A published form version never changes; a draft keeps its version, and submit accepts it after a newer version is published | FE handoff, D47 | UNKNOWN |
| An unanswered question never matches a condition | FE handoff, `design/condition-grammar.md` | UNKNOWN |
| Every condition evaluator (.NET, TypeScript) passes the 57 shared cases in `tests/frm-condition-tests-draft-01.json`; `tests/frm_condition_reference.py` breaks ties | FE `design/api-v1.md`, handoff | UNKNOWN |
| Confidential answers are left out of responses for callers without a grant, not masked | FE `design/api-v1.md` | UNKNOWN |
| Saves are idempotent: a `client_revision` lower than or equal to the stored one returns `200` and changes nothing | FE `design/api-v1.md` call 6 | UNKNOWN |
| Drafts may be partial; submit checks everything and returns every error at once; a failed submit writes nothing | FE `design/api-v1.md` calls 6–7 | UNKNOWN |
| The server checks every workflow step | FE handoff | UNKNOWN |
| The writer sees only `author_text`, never the internal status, queue or holder; a Concern always shows "Sent" | FE `design/api-v1.md` call 8 | UNKNOWN |
| Concern goes only to concern contacts and school well-being contacts, never to transportation | FE `requirements/v1-scope.md`, handoff | UNKNOWN |
| The manifest lists only form types the user may create, assigned to their scope and channel; DECISION never on the tablet | FE `design/api-v1.md` call 1 | UNKNOWN |
| Turns sends no media in V1. Web media limits: photo 20 MB, file 25 MB, video 2 GB (resumable), up to `max_files` per answer | FE `design/api-v1.md`, D48–D50 | UNKNOWN |

Open items that affect QA (FE `open-items.md`, 2026-11-20): O5 schema review with Drew and Mitchell, before A2/A3 code; V1-4 area name; V1-5 which reports; V1-8 translations; P1 Turns offline rider data; J1 who may amend after submit.

### Old World rules that show up repeatedly

| Rule | Source | Covered by |
|---|---|---|
| Dispatch parent notifications are held until the dispatcher sends them (Send Run Changes), not sent on every intermediate save | ENG-1616 (release 13.2.6, PE/152109057) | UNKNOWN |
| Eligibility calculation completes for all schools under concurrent runs | ENG-2967, ENG-3043 | UNKNOWN |
| Path Server "copies" setting accepts 1-8, default 1 | ENG-3043 QA Testing Notes | UNKNOWN |
| A duplicate Workflow submission must not delete the original open workflow | ENG-2822 | UNKNOWN |
| Fleet: closed work orders cannot be restarted and re-sent to the customer's ERP | ENG-2703 | UNKNOWN |
| The Dispatch database is rebuilt from Live every night at 2 AM; changes made in Dispatch do not survive the night | PE/185204738 | UNKNOWN |
| Merging or splitting runs in Dispatch must still notify the right parents with the right stop times, keep Turns rosters scannable and sync the tracker (the page's highest-value regression area) | PE/185204738; ENG-2096, ENG-2043, ENG-2082, ENG-2326, SPT-697 | UNKNOWN |
| A zone alert with "Only Bus Stops within Zone" notifies only subscribers at cancelled stops; "All Bus Stops Affected by Zone Closure" cancels any run passing through the zone | PE/163545089 | UNKNOWN |
| Fleet "Transfer Receive Cutoff Date" blocks receiving or reopening transfers created before the date; empty by default. Known defect: cannot be cleared once set | ENG-2221, ENG-2340; PE/210960386 | UNKNOWN |
| Fleet: saving a purchase order totals all pages of lines; print/PDF includes all lines and a grand total | ENG-1930, ENG-1380 | UNKNOWN |
| Trips blackout-hours check, as built: only start and return times are tested, so a trip spanning the blackout is not caught | PE/214695940 | UNKNOWN |
| After a 13.x upgrade, components sharing a GeoIMS protocol version must be upgraded together (BP Web, GeoIMS, Quick); Path Server with BP Pro; a mismatched Path Server client "silently calculates locally" | PE/178683906, PE/232685569, PE/256868354 | UNKNOWN |
| `StudentRouteChange_ShowWhatChanged` is ON by default for all clients after upgrading to 13.3.0 | ENG-404; PE/178683906 | UNKNOWN |

## High-risk areas / recurring bug themes

Basis: 1,216 issues of type Bug or Bug - ENG created in ENG in the last 180 days (JQL count, 2026-11-10). 322 of them were sampled (most recent 100, two older windows of 100, and a Unified keyword search) and bucketed by summary keyword. Counts are of the sample, overlap between buckets is possible, and they are indicative only.

| Theme | Sample count | Example keys | Why it matters |
|---|---|---|---|
| Chatbot wrong or missing answers, timeouts, scope leaks | 39 | ENG-3045, ENG-3047, ENG-2932, ENG-2711, ENG-3011 | Confident wrong answers about students/stops; timeouts under concurrency; one privacy leak |
| GPS+ (Unified): substitutions, status, stop classification, timing | 36 | ENG-2861, ENG-2808, ENG-2650, ENG-2849, ENG-2695 | Vehicle/driver changes not applied or reverting; hour offsets |
| ETL data fidelity (New World) | 13 | ENG-2747, ENG-2748, ENG-2749, ENG-2686, ENG-2903 | Everything downstream (GPS+, Chatbot) reads the ETL output |
| Fleet (Miami train): work orders, inventory, PO, reminders, deadlocks | 43 | ENG-2697, ENG-2700, ENG-2703, ENG-2726, ENG-2980 | Largest single bucket; has its own release train |
| Chipmunk / trackers / GPS readers | 31 + 12 | ENG-2986, ENG-2804, ENG-2730, ENG-2863, ENG-2971 | Parent-facing outages, wrong bus tracked, duplicate students |
| Reports (regulatory and route reports) | 29 | ENG-2893, ENG-2907, ENG-2858, ENG-2891 | Empty/out-of-memory regulatory reports force hotfixes |
| Performance, timeouts, memory | 19 | ENG-2894, ENG-2967, ENG-2823, ENG-1922 | Path Server memory exhaustion; slow T&A reads |
| Mobile apps (Turns, Delays, Chipmunk) after platform upgrade | 19 Turns | ENG-2649, ENG-2709, ENG-3014, ENG-2645 | Batch found testing the 2026 Android/iOS compliance epic ENG-2646 |
| Time zone / hour-offset | 11 | ENG-2971, ENG-2695, ENG-2849 | Recurs across readers and New World |
| Permissions / access enforcement | 9 | ENG-2800, ENG-1597, ENG-2705, ENG-2906 | Read-only and scoped roles not enforced |
| Parent notifications (duplicates, wrong audience, missed) | 11 | ENG-2833, ENG-2829, ENG-2826, ENG-1616 | Messages reach families |

Other signals:
- Hotfix rate is high: of the 13.x "BusPlanner Main" versions released since June, roughly half are labelled Hotfix (Jira ENG versions list).
- 106 of the 322 sampled bugs carry `jira_escalated` and 24 carry `jira_auto_reopened`.
- Labels and components are sparsely used on bugs, so theme analysis has to go by summary text.

Signals added from Confluence (release notes, retro, RCA):
- 13 Main hotfixes against 8 regular Main releases between Jul 23 and Nov 6; four hotfixes were about wrong or duplicate parent notifications from Dispatch (PE/92864513, PE/138543106, PE/152109057, PE/130547713).
- "Silent failure" is the defect pattern the release notes name most often (ENG-969, ENG-1038, ENG-1372, ENG-1375, ENG-547, ENG-684, ENG-2222, ENG-565, ENG-2700, ENG-2699).
- Upgrade and packaging defects reached customers: Verify DB Schema removed all foreign keys (ENG-2232, PE/178683906); a stale DLL crashed every custom report (ENG-1038, PE/88571905); an unpackaged partial view broke two Fleet screens (ENG-1968, PE/138706945).
- Recurrences are recorded: ENG-1008 (PE/88571905), ENG-2967 "recurrence of IN-111" (PE/262406145).
- About 4 QA staff were a bottleneck during school opening; hotfixes consumed QA cycles; some issues can only be validated at production scale once school starts (PE/158662658).
- Per-client configuration is large and poorly known ("100 different settings and nobody knows half of them"), which makes behaviour hard to verify (PE/158662658).
- Tracker and dispatch knowledge sits with two people (PE/158662658).
- Old World Dispatch merge/split is the named highest-risk regression area (PE/185204738).

## Open questions

### Spec conflicts found in the full Jira read (2026-11-10): confirm with the team before testing

| Topic | Source A | Source B | Code |
|---|---|---|---|
| Payroll export and unapproved time | ENG-1073: export blocked until every time card is approved | ENG-2241 (newer): unapproved time exported, only rejected shifts left out | exports unapproved shifts (ta-requirements.md) |
| Filtered payroll export locks the period? | ENG-1533: no, by design | T&A PRD: export sets EXPORTED | does not lock (backend-core.md flagged it) |
| GPS+ early cap (ENG-2849) | developer proposal: 45 min | QA note: 30 min | not checked |
| Chatbot needs a T&A permission? | ENG-1889: scoped users needed `ta:shift:read` | ENG-2925: chatbot must not require a T&A permission | not checked |

1. **Slack was not usable until 2026-11-20 (now fixed).** On 2026-11-20 the user reconnected the Slack connector to the main workspace; it now reaches 16 channels, including `#qa-env-updates`, `#qa-bpweb`, `#qa-fleet` and `#dev-unified-discipline`. Only the Ride Support section uses Slack so far. Before that, the connected Slack account is a member of only `#all-busplanner` and `#social`; channel search and message search returned nothing for every query tried (eng, qa, release, dev, bug, date-only). The QA channels named in PE/235175938 (`#qa-env-updates`, `#qa-bppro`, `#qa-unified-gpsplus`, `#dev-general`, ...) could not be found or read. Nothing in this file comes from Slack.
2. **Where is BP Unified tested?** Partly answered. Three environments exist per country: dev ("ca-dev"), staging and prod (PE/157450256, PE/195297284, PE/9699329). The GPS+ user manual was written against "HRCE staging data" (PE/225050641), and the one written QA rule says "fix in dev, run a full regression in stage, then promote to prod" (PE/157450256). Still missing: the URLs of dev and staging, and which of them QA is expected to use day to day.
3. **Acceptance criteria location.** There is no dedicated Jira field; they sit in the Description ("Acceptance criteria:" or "Done when") and, for New World features, in the PRD pages. Is that the intended convention?
4. **Status names conflict.** PE/235175938 describes Ready for QA -> QA Review -> Approved for Release. Jira also has `Resolved`, `RELEASED`, and epic-only `In QA` / `QA Approved`. When `Resolved` is used instead of `Approved for Release` is not documented.
5. **Live Viewer BR14 vs Route Management**: confirmed stale by the user manual (PE/225050641). The handoff page still needs updating by its owner. Related open point: Event Viewer and Path & Stop Compare silently hide substituted routes and runs (PE/137822221 BR16, PE/139231233 BR24-25), so a route changed through Route Management may vanish from those pickers. Worth confirming.
6. **Live Viewer unknowns** flagged by the page itself: empty-fleet state, loading/error states, search case sensitivity, whether a driver on a no-route bus is intended (BR18).
7. **Connected PRD "Today" claims** are tagged verified against code by the PRD's author, not by QA. T&A's PRD section says the BP Unified repository was not available to its author, so its T&A "today" statements are thin.
8. **Bug type guidance conflicts slightly.** PE/235470851 says QA must always use "Bug - ENG"; PE/174850052 says client-reported bugs use "Bug" via SPT. Read together: QA-found = Bug - ENG, client-reported = Bug.
9. No definition-of-done page, no test-strategy page and no engineering onboarding page exist outside the PRD family. Confirmed by reading every non-PRD page and all 54 personal spaces (which hold only default pages). The "QA Training Documents" folder (PE folder 203554817) holds only "How to Write a Proper Bug" and "Build, Deployment and QA Testing Process". The space home page is a placeholder (PE/9535653).
10. **Is the missing depot/operator scoping on Event Viewer and Path & Stop Compare a defect or accepted?** Both handoff pages say it is "not a confirmed, deliberate decision".
11. **Event Viewer duration wording**: the handoff page says "Ongoing", the user manual says "Open at end" (PE/137822221 BR10, PE/225050641). Which is current?
12. **Status tiles**: the handoff page describes one status card at a time; the user manual says tiles can be combined (PE/138313730 UC-2, PE/225050641). The manual is newer.
13. **Is "Mike" on the stand-up pages Michel Walther or another person?** (PE/193462274, PE/87031810).
14. Six PRD-titled pages sit outside the Combined PRD folder and look hand-written (237043713, 58851500, 250740737, 233144322, 247824423, 238518274). They were left to the PRD pass by the title rule; confirm they were read.
15. Which automated tests exist for any rule above: unknown from these sources.
