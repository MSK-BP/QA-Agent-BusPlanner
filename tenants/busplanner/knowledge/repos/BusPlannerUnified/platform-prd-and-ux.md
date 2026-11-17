# BusPlannerUnified — Platform PRD, UI/UX decisions and design-system rules (QA view)

Written 2026-11-10 from static reading only (Read/Grep/Glob; nothing executed). Companion to `frontend.md` (what the client code actually does). Where this file and the code disagree, the code wins — this file records *intent*.

## 0. Sources, citation keys and three caveats

All paths are under `repos\BusPlannerUnified\`. `KEY:n-m` = line range in that file.

| Key | File | Lines read |
|---|---|---|
| PRD | `_docx_text\archive\prd\PRD-v1.2.txt` | 1-1335 (all) |
| KO | `_docx_text\meeting-notes\UI-UX-Kickoff.txt` | 1-678 (all) |
| c06c | `...\Unified-UI-UX-c06cb5bb.txt` | 1-1386 (all) |
| ead2 | `...\Unified-UI-UX-ead2ed8b.txt` | 1-990 (all) |
| c810 | `...\Unified-UI-UX-c810456a.txt` | 1-642 (all) |
| e52a | `...\Unified-UI-UX-e52aba9b.txt` | 1-1498 (all) |
| 0fa8 | `...\Unified-UI-UX-0fa89e30.txt` | 1-1134 (all) |
| 67de | `...\Unified-UI-UX-67de46db.txt` | 1-1454 (all) |
| dc59 | `...\Unified-UI-UX-dc592a74.txt` | 1-1446 (all) |
| 0312 | `...\2026-03-12-Unified-UI-UX.txt` | 1-2074 (all) |
| DS | `docs\design\DESIGN-SYSTEM.md` | all |
| DW | `docs\design\DESIGNER-WORKFLOW.md` | all |
| EI | `docs\design\ENGINEERING-INTEGRATION.md` | all |
| CF | `docs\design\gpsplus-contrast-findings.md` | all |
| WN-sum | `docs\working-notes\session-summary-for-slides.md` | all |
| WN-q / WN-st / WN-wd | `docs\working-notes\2026-08-10-eng-1191-open-questions-for-team.md` / `...-subtask-breakdown.md` / `2026-08-11-eng-1191-writer-design.md` | all |
| FE | `knowledge\repos\BusPlannerUnified\frontend.md` (hub, not repo) | all |

**Caveat 1 — there is no platform PRD.** `PRD-v1.2.txt` is the **Time and Attendance (T&A) PRD**, v1.2, March 2026 (PRD:3-5, 10-11). It contains platform-wide sections (notification service, GraphQL read layer, entity scoping, microapp dashboard, multi-tenancy, i18n) but **no** platform requirements for navigation, login, browser support, WCAG level or performance budgets. Sections 1-2 below say "NOT SPECIFIED" where the sources are silent rather than inventing a requirement.

**Caveat 2 — v1.2 is archived and superseded.** It sits under `archive\prd\`; `docs\README.md:38` still calls v1.2 current, but `_docx_text\specs\BusPlanner-Time-and-Attendance-PRD-v1_9.txt:3` is **v1.9, July 2026** ("full removal of time-card rejection"). v1.9 was only sampled (lines 1-40 and greps), not read. Known contradiction: v1.2 requires rejection with notes (PRD:1327); v1.9 says two states only, no Reject action (v1_9:1926). **Treat every T&A-specific sentence below as v1.2 intent and re-check against v1.9 before using it as an oracle.**

**Caveat 3 — the design system is a proposal.** "Status: proposal — nothing below is implemented yet" (DS:4; `docs\design\README.md:3`). Section 4 rules are assertable only where FE or the code confirms them.

Meeting order is **inferred (UNVERIFIED)** from hand-offs between transcripts; only 0312 is dated: KO → c06c → ead2 → c810 → e52a → 0fa8 → 67de → dc59 → (unread `Time-Attendance-Admin-Screens.txt`, likely here) → 0312. PRD v1.2 was produced **after** 0312 and resolves 20 gaps from it (PRD:1221-1222; WN-sum:30-73), so PRD v1.2 supersedes all nine meetings where they conflict. e52a's transcript attributes every line to one speaker (transcription artefact), so no owner can be assigned from it.

---

## 1. PRD summary (T&A PRD v1.2, platform-relevant parts)

### 1.1 Vision
- T&A is a module of the unified platform; principle is a **single pane of glass** — one interface per user regardless of source product (PRD:36-37, 42-43).
- **Persona-centric, not product-centric**: a dispatcher sees T&A + route plan + GPS in one view (PRD:40-41; KO:44-48).
- **Intuitive without documentation**; large buttons, clear labels; validate with real drivers (PRD:44-45; KO:240-256).
- Unified site is intended to hold BP Web, Dispatch, T&A, Workflow, Trips, Fleet (KO:36-44).

### 1.2 Modules / capabilities named
| Module or capability | Scope in v1.2 | Source |
|---|---|---|
| Clock in/out (mobile/tablet), geofence, job codes | P0/P1 | PRD:268-280, 959-962, 1003-1006 |
| Time card view/edit/add/delete, approval (single-level, bulk) | P0 | PRD:963-970, 1322-1327 |
| Absences, holidays (position-based) | P0 | PRD:196-207, 971-978 |
| Employee CSV import, employee-vehicle linking, custom fields | P0 | PRD:979-982, 1223-1231 |
| Payroll export (3-step, CSV) | P0 | PRD:983-986, 1300-1314 |
| Dispatcher unified view, substitutions, expected clock-in alerts | P1 | PRD:995-1014 |
| Pay periods, auto-generate, year-start wizard | P1 / MVP | PRD:1035-1038, 1285-1299 |
| Overtime monitoring microapp, unassigned-employees microapp | P1 | PRD:487-495, 1272-1277 |
| Microapp dashboard framework (react-grid-layout) | build phase 6 | PRD:728-819, 857-860 |
| Notification service (email/SMS/push pub-sub) | platform capability; T&A notifications **deferred to V2** | PRD:514-538, 1328-1334 |
| AI chatbot microapp | build phase 8 | PRD:820-834, 866-869 |
| GraphQL universal read layer + REST writes (CQRS) | architecture | PRD:577-628 |

### 1.3 Personas
| Persona | Primary surface | Key needs | Source |
|---|---|---|---|
| Driver | Mobile/tablet app | Clock in/out, change job code, view own time card; minimal steps, large targets | PRD:56-76 |
| Dispatcher | Web | Coverage management, live map, on-time status, substitutions at run/stop/vehicle level | PRD:102-141 |
| T&A Manager (depot manager) | Web | Review/correct/approve time cards, absences, holidays, employee-vehicle assignment | PRD:185-214 |
| Payroll Manager | Web | Cross-depot approval status, payroll export, pay periods | PRD:234-243 |
| Wider platform personas discussed (not in PRD): router, school administrator, transportation director, mechanic, parent/guardian, communications role | — | — | KO:64-112 |

RBAC roles listed: Admin, Manager, Dispatcher, Driver, Payroll, Viewer; associations at District, Depot/Area, Individual level (PRD:933-936).

### 1.4 Release phases
- **V1 (MVP)**: P0 and P1 lists (PRD:953-1042). First customer named in PRD:22-23.
- **V2**: driver absence requests with approval, multi-level approvals, manual scan clock-in, advanced reporting, API payroll integration, messaging, union rules (PRD:1043-1051), correction requests from drivers (PRD:441-442), notification system (PRD:1328-1334).
- **Future**: AI coverage agent, ignition auto clock-in, offline clock-in with sync, rule engine, cost analytics (PRD:1052-1057).
- Engineering build order, 8 phases: schema → GraphQL → authorization → write path → real-time → dashboard framework → microapps → chatbot (PRD:835-869).

### 1.5 Non-functional requirements (what is and is not stated)
| Area | Stated | Source | Not stated |
|---|---|---|---|
| Performance | GraphQL subscriptions to be tested at **100+ concurrent subscribers per deployment** (open item, not a pass/fail target). Example resolver default page size 20. Overtime indicators refresh "every few minutes", no real-time alerting in V1 | PRD:1142-1145, 644, 494-495 | Page-load, API latency, map or grid row-count budgets: NOT SPECIFIED |
| Accessibility | "Large buttons and fonts"; landscape and portrait tablet; "mobile-first design for tablet users with responsive scaling to desktop" | PRD:46-47 | **No WCAG version/level in the PRD.** WCAG 1.4.3 (4.5:1) and AODA appear only in design docs (CF:10; DS:72; EI:483-484) |
| Browsers | — | — | NOT SPECIFIED anywhere read |
| Devices | Web for admins/dispatch/payroll; tablets and phones for drivers, same React codebase, responsive (PRD:43, 547-548). Design system says **desktop-first, ~1440px**, narrow may be declared out of scope (DS:369-370) | PRD:43, 547-548; DS:369-370 | Minimum supported width, tablet OS versions |
| Localisation | Distance miles/km; language US English / UK English / French; time 12h/24h; date MM/DD/YYYY or DD/MM/YYYY — all configurable | PRD:937-951 | Who sets it (customer vs user), translation coverage. Units must also reach parent emails/app (KO:320-332, discussion only) |
| Security | Entity-scoping middleware injects WHERE clauses on every GraphQL read; scope cached in claims; **scope changes take effect on next login** (PRD:660-682). Chatbot has no special privileges (PRD:833-834). Multi-tenant by `customer_guid` (PRD:930-931). Tablet auth = Employee ID + PIN, separate from web login; PIN optional per customer (PRD:270, 936). Audit trail records the acting user on approval (PRD:452-453). Read-only views must reject mutation with a clear error (PRD:727) | as cited | Password policy, session timeout, MFA: discussed only (c06c:52, 1208-1220) |
| Time storage | UTC storage, GUID keys, soft deletes, temporal associations | PRD:871 | Display time-zone rules (see FE section 9 for implemented behaviour) |

---

## 2. Platform-level requirements as testable sentences

Tag legend: **[PRD]** written requirement (v1.2); **[MTG]** meeting decision, not confirmed in a spec; **[DS]** design-system proposal; **[IMPL]** behaviour recorded in `frontend.md` from code. Anything else is UNVERIFIED.

### 2.1 Navigation and shell
1. [PRD] A user sees a menu and workspace tailored to their role (PRD:43).
2. [MTG] Menu items are driven by **permissions**, not by product licences or fixed roles; a user with permissions in two areas sees both sets of items (ead2:492-516). [IMPL] Sidebar items carry the same permission strings as routes (FE §3).
3. [MTG] T&A left menu: Time Card is one item; Administration is a section containing holiday, job code, position, department and employee administration; Add Holiday is reached from Administration, not from the time card (dc59:64-72, 224). As designed at 0312: Home, Timesheet, Administration, Report, Payroll Export, with Home inactive until a dashboard exists (0312:168).
4. [DS] The frame is an 80px navy product rail plus a 290px nav panel (72px collapsed); chrome is code-owned (`AppShell`/`Sidebar`) and never redesigned per screen (DS:198-201, 359-361).
5. [PRD] The dashboard arranges microapps on a grid; the user can drag to reposition and resize, items snap without overlap, and the layout persists per user (`usr_workspace_layout`) (PRD:776-781, 801-807).
6. [PRD] On first login with no saved layout, the role's default layout loads; after customising, the user's own layout loads on next login (PRD:812-819).
7. [PRD] A microapp is offered only to users holding one of its `requiredRoles` (PRD:753). A slow microapp does not block others (PRD:783-786).
8. [IMPL] The microapp grid shell is **not built**; one microapp is mounted directly on the T&A dashboard (FE §2 `microapps/`). Items 5-7 are not testable yet.

### 2.2 Login and organisation picker
9. [MTG] There is no self sign-up for professional users; accounts are created by an administrator and the user sets their own password from an invitation email (c06c:16, 1004-1028).
10. [MTG] The login page shows **only** the sign-in mechanisms configured for that customer (email/password, or that customer's SSO button(s)); no generic "sign in with Google/Facebook" buttons (ead2:76-80, 136-152).
11. [MTG] A customer with several boards may have a distinct login page per board, each showing one mechanism (ead2:176-212, 276).
12. [MTG] The customer is identified by URL (subdomain or path); a global entry page helps users who do not know their URL (ead2:96-124; c06c:336-344, 532-540). A drop-down of all clients is rejected as confusing (c06c:544). Student names must never be shown before authentication (c06c:580-596).
13. [MTG] The login page shows the customer's logo or image so users can confirm they are in the right place (ead2:252-288; c06c:216-228).
14. [MTG] Forgot password: enter registered email → verification code sent by email → reset → return to login (c06c:16-36); code preferred over link (c06c:52).
15. [MTG] One account can hold both a professional role and the parent role; a "switch to parent / switch to professional" control sits near the user menu, and the current mode is visibly indicated (c06c:732-852; ead2:296).
16. [MTG] SSO and MFA/2FA flows are required for parity with the existing product (c06c:1208-1220); protocols currently supported are OpenID Connect and SAML, up to three providers (ead2:224-240).
17. [IMPL — differs from 12 and 16] The shipped login is **email-first**: resolve email → 0 clients = not-found copy, 1 = password step, more than 1 = organisation picker; `?client=<code>` deep link skips lookup; SSO, forgot-password and keep-me-signed-in are not in V1 (FE §1 "Login flow" items 1-2, 8). Test the implemented flow; raise the gap, do not assert items 10-16 as defects without a current spec.

### 2.3 Users, roles and permissions administration
18. [MTG] Users are assigned **roles only**; a role is a collection of permissions; there is no per-user permission override (ead2:388-412; c06c:1344-1364).
19. [MTG] System default roles exist and customers can modify roles and create new ones (ead2:420; c06c:924). A system-admin role with every permission exists (ead2:472).
20. [MTG] A role is "what you can do"; an association (entity scope) is "who you can do it for" (KO:112-116). [PRD] Two-dimensional authorisation: roles control capabilities, entity scope controls data visibility (PRD:933).
21. [MTG] Creating a user is three steps: personal information → roles → entity associations; which association types are offered depends on the permissions granted (ead2:312-384).
22. [MTG] Role management (role ↔ permissions) is a separate screen from user ↔ role assignment (ead2:532-548). Permissions are presented grouped by product area (c06c:1284-1312).
23. [PRD] District scope sees everything; Department scope sees only their departments; Individual scope sees only own data (PRD:669-672).
24. [PRD] Approval delegation is done by adding/removing a department association; no special delegation flag (PRD:446-451). The approval record shows the delegate, not the original manager (PRD:452-453).
25. [MTG] A control the user lacks permission for is shown disabled with a hover tooltip saying so (payroll export "Approve": 0312:1664-1688).
26. [MTG] Deactivating a user in one place removes access everywhere, including the driver app (c06c:1188-1196).
27. [MTG] Bulk user creation is required for enterprise customers (drivers, school administrators) (ead2:616-664; c06c:1052-1072).
28. [IMPL] `/admin/roles` needs `admin:roles`, `/admin/users` needs `admin:users:read`; permissions are read from localStorage at load, so a role change needs re-login; neither page has tests (FE §3, §8, §9).

### 2.4 Customers and time zones
29. [PRD] Every entity is scoped by `customer_guid`; operators are assigned temporally (PRD:930-931).
30. [PRD] Week start day is a customer setting (PRD:283). Rounding interval and max-cap buffer are configurable at customer setup (PRD:326-339). PIN requirement is per customer (PRD:270).
31. [PRD] Times are stored in UTC (PRD:871). **Display time-zone behaviour is NOT SPECIFIED in any source read here.**
32. [IMPL] Customer CRUD including time zone is at `/customers` (`customer:read`); instants render in the district zone from `GET /api/session/time-zone`, falling back silently to UTC (FE §3, §9). Use FE as the oracle.
33. Terminology risk: "district" means the customer in one usage and a board/area inside a customer in another; an "area" entity grouping schools was proposed (ead2:732-896). UNRESOLVED — do not assume one meaning in test data.

### 2.5 Grids
34. [PRD] All major admin list screens use one reusable configurable grid (PRD:1232-1233). [MTG] Build it once so every screen gets it (0312:256-260).
35. [PRD] A user can show/hide columns from a configuration panel (PRD:1235).
36. [PRD] A user can reorder columns by dragging grip handles in the panel (PRD:1236).
37. [PRD] A user can resize a column by dragging the right edge of its header (PRD:1237).
38. [PRD] The primary identifier column is locked as the first column (PRD:1238).
39. [PRD] The grid scrolls horizontally with a sticky Actions column on the right (PRD:1239).
40. [PRD] "Show inactive" is unchecked by default and, when unchecked, only active records are listed (PRD:1240; decision at 0312:504-560).
41. [PRD] Clicking a header sorts, toggling ascending/descending (PRD:1241). [IMPL] headers expose `aria-sort` in GPS Plus tables (FE §10).
42. [PRD] Column configuration auto-saves per user (`usr_user_preference`, category GRID, key = screen id) and is restored on page load, else screen defaults apply (PRD:1242-1244). [MTG] A user's saved view must never silently revert to the default (0312:256-260).
43. [PRD] Customer-defined employee custom fields appear as available grid columns and in the employee form with a type-appropriate control (TEXT, DATE, NUMBER, BOOLEAN, LIST) (PRD:1226-1229).
44. [PRD] Pay-period grid: sortable columns Name, Start Date, End Date, Cycle, Status, Departments, Employees, Actions; status badges Open (green), Closed (blue), Exported (purple); search bar; status filter buttons All/Open/Closed/Exported (PRD:1288-1291).
45. [PRD] Payroll-export review grid is filterable and sortable (PRD:1307-1310); [MTG] it must scale to ~1,400 employees with search (0312:1744-1780).
46. **Paging**: UI paging behaviour is NOT SPECIFIED. The API offers cursor paging (first/after/last/before) (PRD:656). [IMPL] list pages fetch every page via `useAllNodes`; missing that causes silent truncation (FE §9).
47. **Export**: no general "export grid" requirement. Stated exports: employee CSV import/export with custom-field keys as headers (PRD:1230); payroll CSV (PRD:1313).
48. **Saved views / filters**: only column configuration is specified. FILTER and SORT preference categories exist in the preference design but have no UI requirement (WN-sum:68). Named, shareable saved views: NOT SPECIFIED.
49. [IMPL] `ConfigurableGrid` has tests for cell formatting only — no sort, search, column-config or persistence tests (FE §8).

### 2.6 Maps
50. [PRD] Dispatcher sees all buses on a live map, current run per bus, visited stops/schools, on-time/early/late per stop, and ETAs that account for today's substitutions (PRD:113-118).
51. [DS] Map markers use a saturated `dot` colour per status, because pale pill tints vanish on map tiles; status is always also spelled out in text (DS:217-232, 256-259).
52. [DS] Live fleet statuses are `ontime`, `late`, `nogps_events`, `no_route`; `late` splits into late/critical by the client's red threshold; "no events" and "no route" are deliberately different greys and must not be merged (DS:217-232).
53. [WN] After a vehicle substitution is imported (ENG-1191), the Live Viewer must resolve runs/stops by walking the `original_*_guid` chain; without that read-layer change, substituted runs/stops render with **no markers or path** (WN-wd:51-57; WN-st:95). This is a cross-team dependency — a prime regression target.
54. Map performance, clustering, tile provider, offline behaviour: NOT SPECIFIED in sources read.

### 2.7 Notifications
55. [PRD] All products publish to one notification service; channels are email, SMS and push (PRD:515-530).
56. [PRD] T&A triggers listed (late clock-in, substitutions, approval needed, rejection, pay period closing) (PRD:531-538) — but [PRD] the notification system is **deferred to V2** (PRD:1328-1334; WN-sum:72). Do not test for them in V1.
57. [MTG] A notification-style badge for unassigned employees was floated (0312:1064-1112); delivered instead as a microapp requirement (PRD:1272-1277).
58. [DS] `action.notification #FF4130` is reserved for the unread dot and rail badge (DS:213).
59. [MTG] Driver-app confirmations should be full-screen rather than an easy-to-miss toast (e52a:48-52).

### 2.8 Error handling, warnings and confirmations
60. [PRD] A failed geofence validation shows a clear error message (PRD:276).
61. [PRD] Write controllers roll back on validation failure (PRD:851). Mutating a read-only view fails with a clear error (PRD:727).
62. [MTG] Every delete asks for confirmation (0312:840-852). [PRD] Bulk operations use multi-select + action confirmation (PRD:1284).
63. [PRD] If employee import is configured for the customer, a banner on Employee list and detail reads exactly: "Employee data is imported from an external system. Manual changes may be overwritten by the next import." It is informational and does not block edits (PRD:1268-1271).
64. [PRD] Locked job-code fields show a tooltip explaining why (PRD:1255-1257); [MTG] shown on hover rather than as a permanent banner (0312:376-400).
65. [PRD] Payroll export step 1 shows a warning when selected departments contain unapproved shifts (PRD:1306).
66. [PRD] Leave-balance disclaimer text: "Leave balances from payroll may be out of sync. If you see discrepancies, reconcile with the payroll system." (PRD:466).
67. [DS] Every list has four states — loading, empty, error, populated (DS:362-363).
68. [IMPL] Any 401 clears the session and redirects to `/login?expired=1&redirect=...`; missing permission shows inline "Access Denied" with a link to the user's landing module (FE §1 item 7, §3). A generic platform error-message standard is NOT SPECIFIED.

---

## 3. UI/UX decisions log (deduplicated; order inferred — see section 0)

Status: **Stands** = not contradicted later; **Superseded by X**; **Open** = no decision reached.

| # | Source | Decision | Area | Status | Implication for testing |
|---|---|---|---|---|---|
| 1 | KO:44-48; PRD:40-41 | Design by persona, not product | Shell | Stands | Test journeys per persona across modules, not per module |
| 2 | KO:224-228; 0312:2004-2064 | Build a labelled component library (Tailwind-derived was suggested) plus example pages | Design system | Superseded by DS proposal (no CSS framework; tokens + Storybook, DS:76-92) | Do not expect Tailwind classes; inline styles dominate (FE §1) |
| 3 | KO:216-236 | Style after the marketing website | Visual | Superseded by DS brand tokens from GPS Plus (DS:187-196) | Brand colours are in flux; avoid pixel/colour assertions outside tokens |
| 4 | KO:120-168 | Do not build own authentication; Microsoft Identity favoured | Auth | Stands (PRD:565-566, 933) | — |
| 5 | KO:344-364 → ead2:96-124 → c06c:336-344, 532-544 | Identify customer by URL; global page as fallback; no client drop-down | Login | Stands as intent; **implementation is email-first + org picker** (FE §1) | Test email with 0/1/many organisations and `?client=` deep link |
| 6 | ead2:76-80, 136-152 | Show only the customer's configured sign-in methods | Login | Stands (SSO not in V1 per FE) | When SSO ships: per-customer method visibility |
| 7 | ead2:252-288 | Customer logo/image on login | Login | Stands | Branding per tenant |
| 8 | c06c:16-64 | Forgot password by emailed code | Login | Stands; not in V1 (FE) | — |
| 9 | c06c:124-196 | Parents do not self-register; invitation by matched contact email; help path for "no invite" | Parent accounts | Direction agreed, error path Open; phase 2 (c06c:484-508) | Out of scope until built |
| 10 | KO:540-604 → c06c:732-852 | One site, one login, one account for parent + professional, with a mode switch near the user menu | Shell | Stands (supersedes KO's open "one site or two") | Dual-role account: menu per mode, visible mode indicator |
| 11 | ead2:388-412; c06c:1344-1364 | Users → roles → permissions only | Admin | Stands | No per-user permission UI should exist |
| 12 | ead2:336-384 | Entity association types follow permissions | Admin | Stands as intent | Association step varies with role chosen |
| 13 | ead2:492-516 | Menu from permissions | Shell | Stands; implemented (FE §3) | Permission matrix × nav visibility |
| 14 | ead2:672-708 | Whether SSO claims may set roles/schools | Auth | **Open** (two positions) | — |
| 15 | ead2:912-936; dc59:80-128 | At launch, roles/departments/positions/job codes are seeded by script; customer-managed MVP screens are holidays, employee↔department, employee↔position | Admin scope | Superseded in part: later builds have pages for all of these (FE §3) | Seeded-vs-UI data may differ per environment |
| 16 | c810:352-356; e52a:1252-1256, 1172-1188 | Employee (clocks in) and User (logs in) are separate concepts, fully decoupled in V1 | Model | Stands; long-term linking Open (dc59:1228-1420) | Clock-in must work for an employee with no user account |
| 17 | e52a:1068-1076, 1192-1272 (supersedes c810:152-156 and the earlier "login then menu" flow) | Driver app: quick code → main menu **before** login; Navigation and Pre/Post ask for username/password if not signed in (then remembered); Clock In/Out **always** asks Employee ID + PIN regardless of who is signed in | Mobile auth | Stands; confirmed 0fa8:52-64 | Monitor can clock in on a signed-out tablet; driver signed in still enters ID + PIN |
| 18 | e52a:826-828, 1196 | Optional setting to hide Navigation and Pre/Post buttons (e.g. cafeteria tablet) | Mobile | Proposed | — |
| 19 | e52a:12-20, 124-128; 0fa8:84-136 | Bigger buttons and text, simpler screens; thin bars become large tappable buttons; tablet first, portrait and landscape | Mobile a11y | Stands (PRD:46-47) | Touch-target and orientation checks |
| 20 | e52a:68-96, 116 | "Change job" disabled when not clocked in; clocked-in screen shows current job code | Mobile | Stands | State-dependent enablement |
| 21 | e52a:60; 0fa8:196-200 | After clock in/out the app returns to the main menu showing status | Mobile | Stands (PRD:278 "device returns to ready state") | Shared-device flow |
| 22 | 0fa8:226-288; 67de:52-72 | Home button / unified bottom nav bar across driver apps | Mobile | Proposed, not confirmed | — |
| 23 | e52a:228-284 | No driver time card in the app for V1; point drivers to web | Mobile | **Superseded by PRD:433-440, 1015-1017** (P1 mobile time card view) | Check v1.9 |
| 24 | c810:220-252; 0fa8:472-488 | Time card: left column = planned (blue), right = actual; edit affordance must be a visible icon | Time card | Stands (PRD:190, 215-233) | Colour legend: blue planned, green approved, purple edited, red incomplete |
| 25 | 0fa8:544-552 | Edit icon only on actual shifts, never on planned | Time card | Stands | Planned tiles are read-only |
| 26 | 0fa8:308-372 | Tiles show the final (payable) time; clicking a tile shows actual, adjusted and payable | Time card | Stands | Detail dialog shows all three tiers |
| 27 | 0fa8:560-600 → PRD:48-49; WN-sum:58, 124 | Term "Rounded" replaced by **"Payable"** | Terminology | Superseded → Payable | Flag any UI text still saying "rounded time" |
| 28 | 0fa8:384-400; 67de:1392-1416; dc59:540-544 | Missing clock-out is shown as a partial/half or dotted box that is still clickable | Time card | Stands | Incomplete shift is visible, red, and editable |
| 29 | 0fa8:652-680 | Edit dialog shows original clock times; history tab proposed | Time card | Proposed | — |
| 30 | 0fa8:704-856 | Delete shift = soft delete; deleted shifts are not shown; history kept in audit tables, no UI initially | Time card | Superseded in part: an Audit Log page exists (FE §3; v1_9:1583) | Deleted shift disappears from card but appears in audit log |
| 31 | 0fa8:620-636 | Add/Edit time dialog does not include the run in V1 | Time card | Stands | — |
| 32 | 0fa8:996-1020; dc59:512 | Week view includes Saturday and Sunday, with a show/hide weekend toggle; time card is always 7 days; pay period is independent of the week | Time card | Stands | Weekend toggle; pay period crossing a week |
| 33 | dc59:492-504 | Time axis is dynamic: one hour before first scan to one hour after last | Time card | Proposed | — |
| 34 | c810:448-456 → PRD:1322-1327 | Approval stored per shift; editing a shift un-approves it; the Approve button approves the whole card; bulk approve across employees | Approval | Stands (rejection removed in v1.9) | Edit after approve → card returns to unapproved |
| 35 | c810:456-460; 0fa8:964-988 | A grid view is wanted for approval | Approval | Leaning, no final design in meetings | v1.9 mentions Calendar and Grid views (v1_9:382) |
| 36 | 0312:1696-1712 | Approving from payroll export opens the time card; never a blind approve | Payroll export | Stands | Approve path always shows the card |
| 37 | 0312:1440-1488 → PRD:1302-1303 | Payroll export selects a **defined pay period** from a drop-down (Open and Closed only), not a date range | Payroll export | Stands (Figma was wrong: WN-sum:53) | No free date entry; Exported periods absent from list |
| 38 | 0312:1556, 1656 | Individual employees can be excluded within a department on export | Payroll export | Discussed; not in PRD:1302-1306 | UNVERIFIED |
| 39 | 0312:1792-1820 → PRD:1315-1321 | Overtime, PTO and holiday shown once per employee, not per job code | Payroll export | Stands | Multi-job-code employee: OT not repeated per row |
| 40 | 0312:1836-1848 | Export CSV is a button on the review step, not a separate screen | Payroll export | Superseded by PRD 3-step flow (PRD:1311-1314) | — |
| 41 | 0312:1492-1632 → PRD:1285-1299 | Pay-period management screen, auto-generate from first date + cycle + count, year-start wizard | Admin | Stands; wizard promoted to MVP (WN-sum:71) | Semi-monthly splits on 1st and 16th |
| 42 | 67de:616-964; dc59:52; 0312:1364 | Holiday = name, date, paid/unpaid; one row per day; no holiday type; no hours on the holiday | Admin | Stands (start/end date in dc59:52 superseded by one-row-per-day, 0312:1364) | — |
| 43 | 67de:780-796 → 0312:1392-1432 → PRD:207, 1283 | Holidays are entered in bulk in one dialog and saved once | Admin | Stands | Multi-row add, single save |
| 44 | 67de:804, 844; dc59:86-128 | Associations can be assigned from **both directions** (holiday→positions and position→holidays; same for job codes) | Admin | Stands as principle | Verify both directions stay consistent |
| 45 | 67de:1072-1136; dc59:316-360 | Absence dialog: type, date, radio "employee average day" vs "manual hours"; duration (full / half AM / half PM) is disabled when manual hours is chosen; no "apply to" | Absence | Stands; PRD adds a third method, schedule-based (PRD:199-202) | Mutually exclusive controls |
| 46 | 67de:1144-1184 | Rename "standard day" | Terminology | Not adopted — PRD keeps "Standard Day" (PRD:201, 1209-1210) | — |
| 47 | 67de:92-100, 1388; dc59:588-596 | Driver leave requests and driver self-edits are not V1; managers enter absences and fix missed clock-outs | Scope | Stands (PRD:1044, 441-442) | — |
| 48 | dc59:624-776 | What a driver sees next day after a missed clock-out (prompt, auto cut-off by job code, "forgot to clock out") | Mobile | **Open** | — |
| 49 | 0312:376-432, 688-704 → PRD:1252-1258 | Job code with time scans: one Edit button; only status and position assignments editable; tooltip on locked fields; deactivate instead of delete | Admin | Stands | Create code → scan → fields lock |
| 50 | 0312:504-560 | Hide inactive by default with a "Show inactive" checkbox; no "archive" concept | Grids | Stands (PRD:1240) | — |
| 51 | 0312:856-900, 1064-1112 → PRD:1272-1277 | Unassigned employees are surfaced (top of positions; dashboard microapp) with bulk assign | Admin | Stands | — |
| 52 | 0312:1196-1352 → PRD:1259-1264 | An employee belongs to exactly one department at a time; transfer is temporal | Admin | Stands | Assigning a second department must be prevented or become a transfer |
| 53 | 0312:256-288 → PRD:1232-1244 | Per-user configurable grid everywhere | Grids | Stands | See section 2.5 |
| 54 | 0312:188-196 → PRD:1265-1271 | Import-overwrite warning; tracked per customer, not per employee | Admin | Stands (WN-sum:70) | Exact banner text |
| 55 | 0312:436-496 | Position chips will not scale to 20-100 job codes; alternative control needed | Admin | **Open** | Test with large option lists |
| 56 | 0312:1856-1864 | Celebration animation on successful export | Visual | Light-hearted suggestion, not a requirement | If present, must respect reduced motion (DS:243) |

---

## 4. Design-system rules tests can assert (PROPOSAL — DS:4)

### 4.1 Components
- Inventory target: ~32 components — `ui/` 6, `grid/` 1, `map/` 6, `layout/` 5, `gpsplus/shared/` 6, `chatbot/` 8; **no Storybook stories exist yet** (DS:289-291; EI:120-124).
- `ui/`: Button, Dialog, ConfirmProvider, MultiSelect, SearchInput, StatusBadge; grid: ConfigurableGrid; layout (chrome): AppShell, Sidebar, NavPanel, GpsTopBar, PageHeader (EI:102-105, 117-118, 192-193; FE §1-2).
- Every list component must have Loading, Empty, ErrorState and Populated stories (EI:95-98).
- GPS Plus is the reference implementation; where an older screen disagrees, the older screen changes (DS:336-338).
- Planned CI gates (none exist today — FE §7): no-diff on generated kit, token-file discipline, **contrast pairs**, story coverage + `storybook build`, ESLint ban on raw colour literals (EI:205-246). Baseline: 1,227 hex literals in 80 files (DS:40-43; EI:234-242).

### 4.2 Tokens (seed values, DS:198-244)
| Scale | Values |
|---|---|
| space | 4, 8, 12, 16, 24, 32, 48, 64 (`space.1`…`space.8`) |
| radius | 4, 8, 12, 999 (sm, md, lg, pill) |
| size | icon 16/20/24; control height 32/40; rail 80; nav 290 (72 collapsed) |
| font | Outfit Variable → Inter → system-ui; weights 400/500/600 |
| fontSize | 12, 14, 16, 20, 24, 32 (xs…2xl) |
| elevation | card `3px 4px 5px rgba(0,0,0,.07)`; pop `0 6px 18px rgba(0,0,0,.15)` |
| motion | fast 120ms, base 200ms, ease-out; **all motion off under `prefers-reduced-motion`** |

Key colours: `surface.app #ECECEC`, `surface.card #FFFFFF`, `surface.soft #F5F5F5`, `surface.rail #00274C`; `text.primary #111111`, `text.secondary #464646`, `text.tertiary #6B6B6B`, `text.muted #878787`, `text.faint #AAAAAA`, `text.link #3738ED`; `action.primary #FCBA30` with `text.onAction #00274C`; `action.danger #E35454`; `action.success #009639`; `state.focusRing #3738ED` (DS:198-215). `action.primaryHover` is undecided (DS:210-212).
Reality today: four palettes disagree (three navies, three yellows, four-five page backgrounds) (DS:45-56). Do not assert hex values across modules.

### 4.3 Colour contrast targets (DS:246-265)
- `text.primary` and `text.secondary` on `surface.card`, `surface.app`, `surface.soft`: **≥ 4.5:1**. Large text and icons: **≥ 3:1**.
- `text.onAction` on `action.primary` ≥ 4.5:1 — yellow buttons carry navy text, never white.
- Each status pill `fg` on its own `bg` ≥ 4.5:1 (today: ontime 6.5, late 6.4, critical 5.3, noEvents 6.9, noRoute 8.3).
- Pill `border` and map `dot` are decorative and unasserted; **status must never be colour-only** — always text or icon too (DS:256-259, 368).
- `text.muted` (~3.6:1) and `text.faint` (~2.3:1) fail 4.5:1 by design and are allowed only for placeholders, disabled controls and secondary timestamps (DS:261-265).

### 4.4 Focus and keyboard
- Every interactive element shows hover, focus and disabled states (DS:366).
- Focus indicator is `state.focusRing`, a **2px outline, never removed, never restyled per screen**; `outline: none` without a replacement is a bug (DS:213-215, 260, 366-367).
- No keyboard-shortcut map, tab-order or focus-trap rules are written in the design docs — NOT SPECIFIED. [IMPL] ~300 baselined jsx-a11y findings include click handlers with no keyboard path (FE §9).

### 4.5 Empty / loading / error states
- Four states per list; a mockup with only the populated state is incomplete (DS:362-363; DW:115).
- GPS Live Viewer distinguishes "no buses in your access" from "no buses running" [IMPL] (FE §9).
- PRD example microapp shows a plain "Loading..." (PRD:765) — illustrative only.

### 4.6 Responsive
- Web: desktop-first, ~1440px; each screen states what happens narrow, and "narrow is out of scope" is acceptable if written down (DS:369-370; DW:117-118). **No breakpoint values are defined.**
- Driver app: tablet-first, portrait and landscape, phone second (PRD:47; e52a:128; 0fa8:72-80).
- Tension: PRD says "mobile-first… responsive scaling to desktop" for one React codebase (PRD:47, 547-548) vs DS desktop-first. Unresolved (section 6).

---

## 5. Accessibility commitments and known violations

### Commitments
| Commitment | Strength | Source |
|---|---|---|
| Large buttons and fonts for drivers; portrait + landscape | PRD design principle | PRD:46-47, 58 |
| Text contrast 4.5:1 (WCAG 1.4.3), large text/icons 3:1 | Design proposal + measured audit | DS:250-255; CF:10 |
| Visible 2px focus ring on every interactive element | Design proposal | DS:260, 366-367 |
| Colour never the only carrier of meaning | Design proposal | DS:256-259, 368 |
| Motion disabled under `prefers-reduced-motion` | Design proposal | DS:243 |
| AODA (Ontario) is the compliance frame named; automated coverage acknowledged as missing | Statement of gap, not a target level | DS:72; EI:483-484 |
| `addon-a11y` (axe per story) in Storybook; fail-the-build variant "worth adding later" | Planned | EI:392, 483-484 |
| [IMPL] jsx-a11y lint gate on new code and jest-axe sweeps (GPS Plus, chatbot, NoModules, AskAi) | In CI today | FE §7, §8 |

**No document read states a WCAG version or conformance level (A/AA/AAA).** 4.5:1 and 3:1 are the AA thresholds, so "WCAG 2.x AA" is a reasonable reading — UNVERIFIED; get it confirmed by product before signing off against it.

### Known violations
| Violation | Detail | Source |
|---|---|---|
| Contrast, GPS Plus (all three pages) | `GPS.fgFaint #AAAAAA`: 2.32:1 on white, 2.07:1 on `#EEF2FF` — 11-12px uppercase captions (Event Viewer 5 hits, Compare 8). `GPS.fgMuted #878787`: 3.21-3.59:1 — group row counts, "Unassigned" cells (Live Viewer 6), "No buses pinned yet", day-toggler caption. Measured 2026-09-07, axe-core 4.10 | CF:3-19 |
| Lighthouse a11y scores | Live Viewer 96, Path & Stop Compare 93, Event Viewer 93; contrast is the only remaining WCAG failure there | CF:4-6 |
| Not fixed, by decision | Tokens left unchanged pending the design-system owner; engineering recommends option 2 (keep tokens, stop using them for text; captions use `#6B6B6B`, the lightest grey passing on every surface) | CF:24-29, 41-45, 51-66 |
| Exempt (not a violation) | `fgFaint` on disabled controls | CF:21-22 |
| Same greys carried into the proposed tokens | `text.muted`, `text.faint` knowingly below 4.5:1; "CI cannot catch this one" | DS:261-265 |
| ~300 baselined jsx-a11y findings | Unlabelled inputs, click-only handlers across T&A admin, Users, Roles, Customers, analytics, ConfigurableGrid, Dialog, MultiSelect, ConfirmProvider, NavPanel | FE §9 |
| No a11y sweep on any T&A, admin or analytics page; jsdom cannot see contrast or landmarks | Needs a real-browser audit | FE §8, §9 |
| Chat chart yellow series under 3:1 on white — accepted | — | FE §9 |
| Driver app: small bars hard to tap; operators report drivers struggle to navigate | Field feedback | 0fa8:84-136; e52a:12-20 |

---

## 6. Open questions and unresolved debates

| # | Question | Where | Note |
|---|---|---|---|
| 1 | Which PRD is the oracle — archived v1.2 or `specs` v1.9? README says v1.2 | section 0 | Resolve first |
| 2 | WCAG version/level and whether AODA is contractual | section 5 | Nothing written |
| 3 | Supported browsers, minimum viewport, breakpoints | section 1.5, 4.6 | Nothing written |
| 4 | Mobile-first (PRD) vs desktop-first (DS) | PRD:47; DS:369 | — |
| 5 | Customer identification: URL (meetings) vs email-first picker (code); parents in multiple clients; global lookup database | ead2:96-124; c06c:404-452; FE §1 | Mobile apps cannot use URL (c06c:556-568) |
| 6 | One multi-client database and breach-notification scope | c06c:304-312 | Raised, not answered |
| 7 | May SSO claims drive roles/associations, or auth only? | ead2:672-712 | Two positions |
| 8 | Meaning of "district" vs board vs "area" entity | ead2:732-896 | "Worth a revisit" |
| 9 | Long-term employee ↔ user linkage; who needs a user account; central staff list across products | dc59:1208-1420; e52a:1140-1188 | Deferred |
| 10 | PIN vs password; brute-force and rate limiting on PIN endpoint; how PINs are issued; customers wanting no PIN | e52a:792-816, 1296-1316 | API auth "still has to" exist (e52a:816) |
| 11 | Missed clock-out next-day behaviour; automatic cut-off by job code | dc59:624-776 | — |
| 12 | Holiday hours method (fixed, schedule, FTE) and at which level (customer or position); when absence hours are needed | 67de:948-996, 1216-1232 | "Talk to first customers" |
| 13 | Pay-cycle summary / time-card report content (per job, overtime allocation, per bus) | dc59:836-876, 944-972 | Depends on customer payroll format |
| 14 | Control for assigning many positions/job codes (chips do not scale) | 0312:436-496 | — |
| 15 | Parent "no invitation" recovery path; request form vs resend | c06c:132-196 | Phase 2 |
| 16 | Shared tablet logins vs individual driver accounts | c06c:1076-1196 | Direction: individual |
| 17 | Contrast fix option for GPS Plus greys | CF:47-66 | Awaiting design owner |
| 18 | Is the starter-kit URL public? `action.primaryHover` value; chatbot keeps `Inter Tight`? | EI:456-462; DS:210-212; EI:306-310 | Design-system rollout |
| 19 | PRD-listed open items: materialized-view refresh strategy, subscription scaling, deadhead algorithm, payroll mapping UI; Figma screens "Not Started" | PRD:1126-1156, 1090-1125 | v1.2 status; may be closed in v1.9 |
| 20 | ENG-1191 residual: is BP Info `VehicleID` the device id or serial per provider | WN-wd:35 | Data check |

---

## 7. What this implies for automation — 15 cross-cutting behaviours

Each is worth a shared helper (H) or one end-to-end check (E2E). No E2E framework exists yet and production code has no `data-testid` (FE §6, §10), so use role/name locators.

| # | Behaviour | Type | Basis |
|---|---|---|---|
| 1 | **Login state machine**: email with 0 / 1 / many organisations, org picker, `?client=` deep link, expired-session banner, `?redirect=` | H `loginAs(user, org)` + E2E | FE §1; section 2.2 |
| 2 | **Permission matrix → navigation and route gate**: for each seeded role, assert visible nav items, reachable routes, "Access Denied" on the rest, and a 403 from the API for the same action | H `expectNav(role)` + E2E | ead2:492-516; FE §3, §9 |
| 3 | **Disabled-with-reason pattern**: control lacking permission (or locked field) is disabled and exposes a tooltip/accessible description | H `expectDisabledWithReason(locator, text)` | 0312:1664-1688; PRD:1257 |
| 4 | **Entity scope**: District vs Department vs Individual users see different row sets in the same grid; scope change applies only after re-login | E2E with three users | PRD:669-682 |
| 5 | **Grid contract**: sort toggle (+ `aria-sort`), show/hide column, reorder, resize, locked first column, sticky Actions, "Show inactive" default off | H `GridPage` object reused on every list | PRD:1235-1241 |
| 6 | **Grid preference persistence**: change columns → reload → new session → still applied; second user unaffected | E2E | PRD:1242-1244; 0312:256-260 |
| 7 | **List completeness**: seed more rows than one server page and assert the grid shows all (guards `useAllNodes` omissions) | H `expectRowCount(apiTotal)` | FE §9 |
| 8 | **Four list states**: loading, empty, error (forced API failure), populated — per list page | H `forEachListState(page)` | DS:362-363 |
| 9 | **Destructive-action confirmation**: every delete and every bulk action opens a confirm dialog; cancel leaves data unchanged | H `confirmDialog.accept()/cancel()` | 0312:840-852; PRD:1284 |
| 10 | **Standard banners and warnings**: import-overwrite banner text, unapproved-shifts warning, leave-balance disclaimer — exact strings | H `expectBanner(text)` | PRD:1270, 1306, 466 |
| 11 | **Accessibility sweep in a real browser**: axe with `color-contrast` ON for every route, plus keyboard walk asserting a visible focus indicator on each stop | H `a11yScan(page)` + nightly E2E | DS:246-265, 366-367; CF; FE §9 |
| 12 | **Status never colour-only**: every status pill/badge/map marker has a text or accessible name (pay period Open/Closed/Exported; fleet ontime/late/critical/no events/no route) | H `expectStatus(locator, label)` | DS:256-259; PRD:1289 |
| 13 | **Tenant isolation and switching**: user in two organisations sees only the selected one's data; stale `bp_*` keys after a 401 do not leak zone/format into the next tenant | E2E | PRD:930-931; FE §9 |
| 14 | **Time-zone and locale rendering**: run key screens with browser zone ≠ district zone, across DST and midnight; assert 12h/24h, date order and miles/km follow configuration | H `withBrowserZone(tz)` + E2E | PRD:937-951; FE §9 |
| 15 | **Time-card approval → payroll export chain**: approve card → edit a shift → card un-approved → export step 1 warns → re-approve → export → period status Exported and absent from the period drop-down | E2E (highest business risk; re-check rules against v1.9) | PRD:1300-1327; c810:448-456 |

Secondary candidates once the features exist: dashboard layout persistence (PRD:801-819); Live Viewer markers after a substitution chain (WN-wd:51-57); driver-app clock-in on a signed-out shared tablet (e52a:1192-1272); `prefers-reduced-motion` (DS:243).
