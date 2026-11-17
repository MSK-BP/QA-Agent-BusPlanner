# BusPlannerUnified — Time & Attendance requirements vs code

Built from the converted Word documents under `repos/BusPlannerUnified/_docx_text/` and compared with code snapshot commit 0137276 (same snapshot as `backend-core.md`). Static reading only; nothing was run.

**Sources and how they are cited**

| Short | Document | Notes |
|---|---|---|
| PRD | `_docx_text/specs/BusPlanner-Time-and-Attendance-PRD-v1_9.txt` (v1.9, July 2026, status "Development") | Cited as `PRD §section (Lnnn)`; L = line of the .txt |
| KB | `_docx_text/knowledgebase/TimeAndAttendance-Knowledgebase.txt` (June 2026, schema v7.22) | Developer reference "as built" at that time; **partly stale against current code** (see 6.3) |
| GUS | `_docx_text/meeting-notes/Time-and-Attendance-Gus-Notes.txt` | Undated sales/prospect requirement list for the first customer |
| ADM | `_docx_text/meeting-notes/Time-Attendance-Admin-Screens.txt` | Undated meeting transcript; cited by transcript timestamp `ADM mm:ss` |
| Code | paths use the shorthand of `backend-core.md` (`API-TA/`, `TA-APP/`, `TA-INF/`, `TA-DOM/`, `API/`) | `file:line` |

The PRD has **no requirement IDs**. IDs below (`TA-xx`) are assigned here for traceability; the PRD section is the real reference. Anything marked **UNVERIFIED** is inferred.

---

## 1. Scope of T&A v1

- **Product**: workforce module inside the unified platform: track hours, manage absences/holidays, export payroll, give dispatch live awareness (PRD §1, L33).
- **First customer**: Yankton School District; uses BusPlanner GPS+ for route tracking and Software Unlimited for payroll (PRD header L19-20, §1 L35; GUS L26, L60).
- **Platforms**: React web for admin/dispatch/payroll; mobile/tablet app for drivers (PRD §2.2, L191).
- **Hours only**: the system tracks hours, never pay rates or dollar amounts (PRD §3.4 L410-411; §4.29 L1951; ADM 35:17).

**Personas (PRD §3)**

| Persona | Core jobs | PRD |
|---|---|---|
| Driver | Clock in/out (Employee ID + optional PIN) at geofenced locations, change job code, view own time card on mobile | §3.1 L204-224 |
| Dispatcher | Watch expected vs actual clock-ins, coverage/substitutions, live map | §3.2 L250-271 |
| T&A Manager (depot manager) | Review/correct time cards, add punches/absences, manage holidays, approve time cards, maintain employee-vehicle links | §3.3 L333-362 |
| Payroll Manager | Monitor approval across depots, manage pay periods, run consolidated export | §3.4 L383-392 |

**In scope for V1 (PRD §7.1, L1313-1402)** — P0: clock in/out with geofence; time card view/edit/add; single-level bulk approval; manager-driven absences; position-based holidays; employee CSV import + employee-vehicle linking; configurable CSV payroll export; payable-time rules (rounding, floor, cap); derived route-to-shift linkage. P1: dispatcher unified view; group shift templates; mobile job-code change; expected clock-in alerts; substitution UI; driver mobile time card; deadhead microservice; trip credits; approval delegation; PTO balance display; pay-period configuration UI; overtime monitoring microapp.

**Out of scope / deferred** — driver absence requests, multi-level approval, manual-scan clock-in, API payroll integration, union rules, messaging (PRD §7.2 L1403-1411); offline clock-in, ignition auto clock-in, custom rule engine (§7.3 L1412-1417); union rules (§4.13 L860-872); notification system (§4.27 L1927-1933, although §5.3 L896-903 still lists triggers); driver correction requests (§4.8 L798-799); full-day/half-day absence auto-credit (§3.5 L536); in-product change of work-week start (§4.28 L1943-1945); unmatched-punch surface, time-window matching, overlap validation (§3.5 L575-611); audit of configuration changes, audit export templates, real-time audit feed (§10.10 L1769-1779).

---

## 2. Requirements catalogue

Priority is the PRD §7.1 value where the feature is listed there; "-" = not stated.

### 2.1 Clocking (web, mobile, PIN)

| ID | Requirement (one testable sentence) | PRD | Pri |
|---|---|---|---|
| TA-01 | Tablet/mobile authentication uses Employee ID plus PIN, and the PIN is optional per customer. | §4.1 L616; §3.1 L209; §6.13 L1296 | P0 |
| TA-02 | An employee can clock in only when their GPS coordinates fall inside the geofence of a location they are associated with (via employee, department or position). | §4.1 L618-620; §3.1 L219 | P0 |
| TA-03 | Geofence radius comes from `ta_location.geofence_radius_feet`, default 500 ft. | §4.1 L618 | P0 |
| TA-04 | Clock-in and clock-out geofence checks are configurable independently. | §4.1 L618, L621 | P0 |
| TA-05 | A failed geofence check shows a clear error and GPS coordinates are stored on every clock event. | §4.1 L619, L622 | P0 |
| TA-06 | One shared device supports consecutive clock events by different employees and returns to a ready state after each. | §4.1 L624 | P0 |
| TA-07 | A driver changes job code by clocking out of one code and into another; only job codes linked to the employee's position(s) are selectable; a shift has exactly one job code. | §4.1 L626; ADM 43:54-44:39 | P1 |
| TA-08 | A manager can add a missed punch (day, job code, optional vehicle, in time, out time) from the "Add clock-in" modal; it is stored with `is_manual_entry = 1` and audited with a `manual_addition` tag. | §3.5 L496-530 | P0 |
| TA-09 | In the Add clock-in modal the clock-out must be after the clock-in. | §3.5 L518-520, L524 | P0 |
| TA-10 | A manually added punch attaches to the planned shift with the same employee + day + job code, sorted chronologically; with no match it is saved as unmatched and flagged for review. | §3.5 L483-486, L527-529 | P0 |
| TA-11 | V1 performs no time-overlap validation between punches of one shift and no time-window matching heuristic. | §3.5 L582-596 | - |

### 2.2 Shifts and the three tiers

| ID | Requirement | PRD | Pri |
|---|---|---|---|
| TA-12 | Each shift carries Actual (raw punch, immutable), Adjusted/Edited (manager correction) and Payable (system-calculated, never typed) start/end times. | §4.2 L632-653; §2.5 L197 | P0 |
| TA-13 | A planned shift may be matched by N punch pairs; the tiers apply per punch and shift hours are the sum across its punches. | §4.2 L630; §3.5 L495 | P0 |
| TA-14 | If any punch lacks a clock-out, the shift total shows "—", the delta shows "unresolved" and the status shows missing clock-out. | §3.5 L494, L548 | P0 |
| TA-15 | Shifts are never deleted; an erroneous shift is corrected by editing its times to zero, preserved in the audit trail. | §3.3 L342; changelog 1.6 L173; §4.26 L1926 | P0 |
| TA-16 | A manager can remove an individual punch from a multi-punch shift. | §3.5 L491; §10.5 L1644-1646 | - |
| TA-17 | All shifts of one employee in one work week form one time card. | §4.2 L630; §4.28 L1935 | P0 |
| TA-18 | Delta = total actual hours − planned hours, coloured neutral / amber / red against a backend-configured tolerance per position or job code. | §3.5 L466, L543-548 | - |

### 2.3 Payable time: rounding, floor, cap

| ID | Requirement | PRD | Pri |
|---|---|---|---|
| TA-19 | Payable is computed in order: use Adjusted if present else Actual; round start and end to the interval; raise start to planned component start (floor); lower end to planned component end + buffer (cap). | §4.3 L669-673 | P0 |
| TA-20 | Rounding rule = interval (`round_to_minutes`) and type NEAREST / UP / DOWN, configured per customer and optionally scoped per position or job code. | §4.3 L658, L660, L667 | P0 |
| TA-21 | V1 defaults: 15-minute rounding interval, +30-minute cap buffer, manual override of payable not allowed. | §4.3 L676-700 | P0 |
| TA-22 | The raw scan always keeps seconds; the rounded value is stored separately; minimum rounding granularity is one minute. | §4.3 L664 | P0 |
| TA-23 | The system supports both punch-level rounding (round each punch, then subtract) and total-level rounding (subtract, then round the total), selected per client. | §4.3 L663-667; changelog 1.9 L157 | - |
| TA-24 | Rounding is re-applied to the edited value on save. | §4.3 L703 | P0 |

### 2.4 Schedules, absences, holidays, trip credits

| ID | Requirement | PRD | Pri |
|---|---|---|---|
| TA-25 | Planned side of the time card is read-only and comes from the schedule (`ta_schedule` / plan tables). | §3.5 L456-458 | P0 |
| TA-26 | Expected clock-in time is either the `ta_schedule` start or first run start minus a configurable buffer, selectable per customer. | §3.2 L290-293 | P1 |
| TA-27 | Add absence takes an absence type, manual hours, a date or date range and optional notes; V1 offers manual hours only. | §3.5 L531-539 | P0 |
| TA-28 | A date-range absence creates one `ta_absence` row per covered day with the same hours, and skips non-scheduled days and holidays unless policy credits them. | §3.5 L540 | P0 |
| TA-29 | An absence (whole span, one day of a span, or a reduction of hours) can be removed; removal is a soft delete recorded in the audit log. | §3.5 L541-542 | P0 |
| TA-30 | Absence types carry a paid/unpaid designation; "sick paid" and "sick unpaid" are separate types. | §3.5 L534; ADM 36:10-37:11 | P0 |
| TA-31 | A holiday is a single date; consecutive days are separate rows; holidays are assigned to positions; a paid/unpaid flag exists. | ADM 30:16-33:18; §3.3 L352-355 | P0 |
| TA-32 | A holiday decorates the day and never hides or blocks shifts worked that day; credited holiday hours are independent of worked hours. | §3.5 L556-563 | P0 |
| TA-33 | Holiday hours can be credited by manual, standard-day (FTE × 8 h) or schedule-based method. | §3.3 L354; glossary L1545-1546 | P0 |
| TA-34 | A trip credit grants `credited_hours` without start/end times, source MANUAL or SCHEDULE, appears on the week's time card, is approved with the time card and is exported as credited hours. | §4.7 L768-788 | P1 |
| TA-35 | Field trips are a job code clocked through the normal flow. | §4.6 L759-765 | - |

### 2.5 Overtime and work week

| ID | Requirement | PRD | Pri |
|---|---|---|---|
| TA-36 | Overtime is every payable hour beyond 40 in one work week, summed across all job codes; never per day, never per pay period; threshold fixed at 40 in V1. | §4.25 L1904-1906, L1917; §4.12 L853 | P0 |
| TA-37 | Overtime applies to the last hours worked in the week ("last-in"); when a week spans two pay periods the OT lands in the period containing the day those hours were worked. | §4.25 L1906-1911 | P0 |
| TA-38 | When OT is broken out by job code, each OT hour takes the job code of the hours that crossed 40, computed from punches in chronological order. | §4.25 L1912-1915 | - |
| TA-39 | The work week is a fixed 7-day window whose start day is a global client-level setting: Monday, Sunday or Saturday; default Monday. | §4.28 L1935-1937 | - |
| TA-40 | Administration → Work Week is read-only in V1 and tells the user to contact support to change it. | §4.28 L1938-1943 | - |
| TA-41 | Time card weekly total shows a visual indicator when approaching or exceeding 40 h; an overtime microapp lists such employees. | §4.12 L854-859 | P1 |

### 2.6 Approval, pay periods, export

| ID | Requirement | PRD | Pri |
|---|---|---|---|
| TA-42 | Approve acts on the whole time card (all shifts of the employee for the selected work week), never on single shifts, and never spans pay periods. | §4.26 L1922-1924 | P0 |
| TA-43 | Bulk approval of several employees' time cards is available; "Approve & next" approves one card and advances to the next outstanding driver. | §4.26 L1925; §3.5 L549-555 | P0 |
| TA-44 | A time card is Pending or Approved only; there is no reject action. | §4.26 L1926; changelog 1.8/1.9 | P0 |
| TA-45 | Editing an approved shift's times resets it to PENDING and voids its approvals, recorded as a System event. | §4.9 L811; §10.4.5 L1622 | P0 |
| TA-46 | Once the pay period is EXPORTED a shift's approval state cannot change. | §3.5 L429; §4.9 L811 | P0 |
| TA-47 | Every approval records the acting user; a delegate's approval shows the delegate. | §4.9 L809-810 | P1 |
| TA-48 | Delegation = associating the covering manager with the department in `usr_user_entity_scope`; removing it ends the cover. | §4.9 L805-808 | P1 |
| TA-49 | Pay period status is OPEN → CLOSED → EXPORTED: Open allows clocking and edits; Closed allows no edits and requires all cards approved; Exported means the file was generated. | §4.11 L838-842 | P1 |
| TA-50 | Pay periods can be auto-generated from first start date + cycle (Weekly / Biweekly / Semi-Monthly / Monthly) + count; semi-monthly always splits on the 1st and 16th. | §4.23 L1879-1883 | P1 |
| TA-51 | Different departments may be assigned different pay-period schedules. | §4.11 L832-836 | P1 |
| TA-52 | Export step 1 offers only Open and Closed pay periods and warns when selected departments contain unapproved shifts. | §4.24 L1889-1893 | P0 |
| TA-53 | Export step 2 shows per employee: regular, overtime, total, absence, holiday and trip-credit hours and approval status, with OT broken down per work week and a toggle for OT by job code. | §4.24 L1894-1898 | P0 |
| TA-54 | Export step 3 produces a CSV using `external_paycode` (falling back to the internal job code when null) and sets the pay period to Exported after successful generation. | §4.24 L1899-1902; §4.17 L1836 | P0 |
| TA-55 | Only approved time cards are eligible for payroll export. | §3.3 L360; §3.4 L389; ADM 49:35 | P0 |
| TA-56 | Export content is hours from Payable time, absence hours by type and holiday hours; delivery by manual download or SFTP. | §3.4 L398-409; GUS L59-60 | P0 |
| TA-57 | Pay Cycle Summary report shows hours and OT per work week inside the selected pay period, with the OT-by-job-code toggle and no Total Pay column. | §4.29 L1946-1952 | - |

### 2.7 Permissions, scoping, audit, settings, admin data

| ID | Requirement | PRD | Pri |
|---|---|---|---|
| TA-58 | Roles are Admin, Manager, Dispatcher, Driver, Payroll, Viewer; scope levels are District (all), Department (own departments) and Individual (own data). | §6.13 L1293-1295; §6.4 L1034-1037 | - |
| TA-59 | Every user-facing read is filtered by the user's entity scope at one authorization boundary; the chatbot has no extra privileges. | §6.2 L984; §6.4 L1027; §6.9 L1193-1194 | - |
| TA-60 | The Audit Log shows one event per database transaction for time edits, approvals, manual punches, punch/absence deletions, reassignments, job-code changes, absences, trip credits, adjustments, pay-period transitions and system events. | §10.4-10.5 L1598-1675 | - |
| TA-61 | Bulk approval of N drivers writes N audit events, each marked as part of the bulk action. | §10.4.2 L1607-1609 | - |
| TA-62 | A time-edit event shows four values per field (original actual, original payable, edited actual, edited payable) and a net payable change in minutes. | §10.6 L1677-1701 | - |
| TA-63 | Audit Log access uses the same permission as editing time cards (no separate permission) and is limited to drivers the user may view. | §10.9.2 L1765-1766 | - |
| TA-64 | Audit filters (driver, actor incl. System, date range, event type, pay period) combine with AND; the feed pages 50 events at a time; events are retained indefinitely. | §10.7.2 L1705-1732; §10.9.3 L1767-1768 | - |
| TA-65 | Pay periods auto-close on their scheduled close date and auto-export on their scheduled date, each as a System audit event. | §10.4.5 L1623-1624 | - |
| TA-66 | Once shifts reference a job code, its code, title, description, hourly rate and external paycode are read-only; only active status and position assignments stay editable; delete is unavailable. | §4.18 L1839-1845; ADM 21:02-22:11 | - |
| TA-67 | An employee belongs to exactly one department at a time; transfers retire the old link and create a new one with an effective date. | §4.19 L1846-1851; ADM 39:40 | - |
| TA-68 | Employees can be added manually before the first payroll import, keyed by the payroll/employee ID. | ADM 09:37-10:17 | P0 |
| TA-69 | PTO/leave balance is imported nightly from payroll and shown as imported remaining + leave taken since last export, with an out-of-sync disclaimer. | §4.10 L813-826 | P1 |
| TA-70 | Customer-level `ta_settings` hold rounding overrides, tolerance thresholds and geofence defaults. | PRD L83-84; §3.5 L433 | - |

---

## 3. Calculation rules and worked examples

Examples are from the documents unless labelled otherwise.

**3.1 Payable pipeline (PRD §4.3 L669-673)** — `source = edited ?? actual` → round start and end → floor (`start = max(roundedStart, plannedStart)`) → cap (`end = min(roundedEnd, plannedEnd + buffer)`).

**3.2 Rounding**
- Punch-level (Janssen export example): in 6:30, out 8:15 → 1 h 45 m = **1.75 h** (PRD L665).
- Total-level: a shift of 1 h 54 m actual → rounds up to **2.00 h** (PRD L666). The two methods can give different totals, which is why the method is per client (L667).
- 15-minute NEAREST, from the audit example (PRD §10.6 L1683-1700): actual 05:47 → payable 05:45; edited 06:00 → payable 06:00; actual 15:47 → payable 15:45; edited 16:00 → 16:00; **net payable change +30 min**.
- An edit of 05:47 → 05:48 keeps payable at 05:45, so net payable change is **0** (PRD L1700).
- Half-interval direction for NEAREST is not stated in the documents (code rounds half up: `TA-INF/Services/RoundingService.cs:20-26` per `backend-core.md` §5.1).

**3.3 Multi-punch sum (PRD §3.5 L482, L493)** — planned 06:00-10:00 (4.00 h); punches 05:45-08:00 (2.25 h) and 09:00-11:00 (2.00 h); actual = **4.25 h**; delta = **+15 m**. The unlogged gap 08:00-09:00 is not paid.

**3.4 Floor and cap** — the documents give the rule and defaults (+30 min buffer) but **no numeric example**; edge cases are an open item with the customer (PRD L702, L1430-1433). Derived illustration (not from the documents): planned 06:00-10:00, buffer 30, 15-min NEAREST; punch 05:40-10:50 → rounded 05:45-10:45 → floor 06:00 → cap 10:30 → payable 4.50 h.

**3.5 Weekly overtime (PRD §4.25 L1909-1915)**

| Scenario | Input | Expected |
|---|---|---|
| 1 no overlap | Week Mon-Sun inside June; Mon-Fri 8+8+8+9+8 = 41 h | 40 regular + 1 OT, all June |
| 2 week spans periods | Week Mon Jul 28 - Sun Aug 3, monthly periods; Mon 10 + Tue 10 (July); Wed-Fri 8 each (August) = 44 h | July: 20 regular, 0 OT. August: 20 regular + 4 OT |
| 3 OT before boundary | Mon-Fri 10 h/day (July) = 50 h; Sat Aug 1 field trip 8 h | July: 40 regular + 10 OT. August: 0 regular + 8 OT |
| A OT by job code | Mon-Thu driving 10 h/day; Fri 2 h field trip then 10 h driving (52 h) | 40 driving regular; 2 field trip OT; 10 driving OT |
| B order-dependent | Mon-Fri driving 8 h/day plus 2 h field trip Wednesday (42 h) | 2 h OT, job code decided by the chronological order of the punches that crossed hour 40 |

**3.6 Absence / holiday hours** — Standard day = FTE × 8 h (0.75 FTE = 6 h) (PRD §3.3 L349; glossary L1545-1546). Leave balance shown = imported remaining + taken since last export (PRD L824).

**3.7 Crossing midnight** — the PRD does not define overnight shifts. The only related rule is that a manually added clock-out "must be after" clock-in (L518-520). The KB states overnight shifts are unsupported (KB L250, L550); current code partly supports them (see 6.1 D9).

**3.8 DST / time zones** — not mentioned in any of the four documents. Only statement: audit timestamps display in the tenant's time zone (PRD L1736) and storage is UTC (PRD L1231). Code computes hours on local wall-clock times with no DST adjustment (`TA-APP/PayrollExport/PayrollCalculationService.cs:16-17`).

---

## 4. State machines

**4.1 Shift / time-card approval** (PRD §4.26 L1926; §4.9 L811; §10.4.5 L1622)

| From | To | Trigger | Who |
|---|---|---|---|
| (new) | PENDING | Shift created by punch or manual entry | Driver / T&A Manager |
| PENDING | APPROVED | Approve, Approve & next, bulk approve (whole work week) | T&A Manager or delegate in scope; steps in `ta_approval_step` may require a named permission (PRD L811) |
| APPROVED | PENDING | Any edit of the shift's times (approvals voided) | System, caused by the manager's edit |
| any | frozen | Pay period becomes EXPORTED | System |

No REJECTED state in v1.9. Note PRD §4.9 L811 still lists "PENDING / APPROVED / REJECTED" — an internal leftover contradicted by changelog 1.9 (L157) and §4.26.

**4.2 Pay period** (PRD §4.11 L838-842; §10.4.5 L1623-1624; §4.24 L1902)

| From | To | Trigger | Who |
|---|---|---|---|
| (new) | OPEN | Create or auto-generate | Payroll Manager (admin UI) |
| OPEN | CLOSED | Manual status change, or automatic on scheduled close date | Payroll Manager / System |
| CLOSED (or OPEN) | EXPORTED | Successful payroll export, or automatic scheduled export | Payroll Manager / System |

Reverse transitions are not described in the documents. Step 1 of export lists "Open and Closed" periods (L1890), so export straight from OPEN is allowed by the PRD.

**4.3 Other workflows** — Absence: PENDING → APPROVED / REJECTED (PRD L87, L816). Time adjustment: PENDING → APPROVED / REJECTED, types ADD_TIME / SUBTRACT_TIME / CHANGE_JOB_CODE (PRD L428, L658). Trip credit: created → approved with the time card (PRD §4.7 L778-784). Who may reject an absence or adjustment is not stated.

---

## 5. Decisions and open questions

**5.1 Decisions in the admin-screens meeting (ADM, undated transcript)**

| Decision | Ref |
|---|---|
| Top menu: Timesheet, Admin, Reports, Payroll Export; Admin holds Employee, Position, Job Code, Absence Type, Department, Holidays | ADM 01:39-03:12, 56:54-57:16 |
| "Clocked in / on leave" status column removed from the employee admin list; belongs in a real-time report later | ADM 04:21-05:36 |
| Keep a separate Employee concept linked to User where one exists; employee ID = payroll ID | ADM 07:00-10:38 |
| Location assignment skipped for now (its purpose is geofencing) | ADM 11:10-11:49 |
| Absences are added and edited only from the time card in V1; no absence list page or driver request flow yet | ADM 12:13-16:03 |
| Admin "Absence" screen is absence **types** only | ADM 16:10-18:21 |
| Job codes attach to positions (temporal start/end per position row), not departments; no date/time/department columns on the job-code list | ADM 19:59-21:02, 40:12-42:08 |
| Job code with any time scan: no delete, no rename; only position links and active/inactive change; hide delete, explain why | ADM 21:02-24:02 |
| Use active/inactive (not "archive") for job codes | ADM 24:32-25:00 |
| Holiday = single day; multi-day = multiple rows; paid/unpaid flag added to UI | ADM 30:16-33:33 |
| Position only restricts which job codes can be clocked; payroll receives hours per job code | ADM 43:54-45:04 |
| Payroll export is a wizard: choose pay period + departments → validate all cards approved (list unapproved people) → summary by job code/absence/holiday → generate one file | ADM 50:38-57:46 |

**5.2 Decisions recorded in the PRD change log (dated)** — July 2026 v1.6: shift delete removed, edit-to-zero only (L173). July 2026 v1.7/1.8: absence flow, then simplified to manual hours (L165-169). July 2026 v1.8: rejection removed; work week separated from pay period (L165). July 2026 v1.9: full OT model and client-specific rounding (L157).

**5.3 Later decisions visible only in code comments** (not in the documents; they explain several discrepancies): shift delete restored by owner decision, "meeting 2026-08" (`TA-APP/Shifts/Commands/DeleteShift/DeleteShiftCommandHandler.cs:12-15`); paid leave counts as payable time and is approved with the week, "owner decision 2026-07-09" (`API-TA/TimesheetController.cs:231-233`); dedicated audit-log permission supersedes the spec (`API/GraphQL/Query.cs:195-198`).

**5.4 Open questions in the documents**

| Question | Status in document | Ref |
|---|---|---|
| Match a punch far outside the planned window? | V1: day + job code only; needs customer input | PRD L583-585 |
| Dedicated unmatched-punch surface | V2 candidate | PRD L587-590 |
| Overlap validation between punches | V2 candidate | PRD L592-595 |
| Coverage vs total-hours semantics for gaps | Pending customer payroll definition | PRD L597-600 |
| Per-punch job code / vehicle within one planned shift | Pending operational confirmation | PRD L607-610 |
| Min floor / max cap edge cases and exceptions | Pending | PRD L702, L1430-1433 |
| Rounding defaults and direction for the first customer | Pending | PRD L1445-1448 |
| Payroll file specification (format, fields, delivery schedule) | Pending | PRD L1440-1443 |
| Driver-to-vehicle mapping UX | Pending | PRD L724, L1425-1428 |
| Union rules affecting T&A | Deferred, collect before V2 | PRD L867-872 |
| In-product change of work-week start + its audit | Future PRD item | PRD L1945 |
| Deadhead algorithm; materialized-view refresh; subscription scaling | Pending engineering | PRD L1497-1510 |
| Whether employee ID and payroll ID can ever differ | Assumed identical | ADM 10:08-10:38 |
| Reports approach (report vs active page) | To be discussed | ADM 14:29-15:21 |

---

## 6. SPEC vs CODE discrepancies

### 6.1 Confirmed (source file opened and read)

| # | Requirement | What the code does | Evidence | QA severity |
|---|---|---|---|---|
| D1 | Work week start is a client setting, default **Monday** (TA-39) | Export engine is hard-wired to **Sunday**-start weeks with a fixed 40 h threshold; no setting is read | `API-TA/PayrollExportController.cs:374-381`; loader widens to the same weeks `TA-APP/PayrollExport/PayrollDataLoader.cs:23-27` | **High** — any Sunday or Saturday work moves between weeks, changing OT |
| D2 | Shifts are never deleted; correct by edit-to-zero (TA-15) | A delete endpoint exists and soft-deletes shift + punches; a **new** zero-length edit is rejected with 400 ("Delete the shift instead"); yet the bulk-approve error text still tells users to "edit the times to zero" | `API-TA/ShiftsController.cs:89-90`; `TA-APP/Shifts/Commands/DeleteShift/DeleteShiftCommandHandler.cs:12-15,76-83`; `TA-APP/Shifts/Commands/EditShiftTimes/EditShiftTimesCommandHandler.cs:58-75`; `API-TA/TimesheetController.cs:141-145` | **High** — PRD-based tests fail; code comments also disagree with each other on whether edit-to-zero stays legal |
| D3 | Every change affecting payable hours appears in the Audit Log (TA-60) | Deleting an unapproved shift writes no audit event (acknowledged gap) | `DeleteShiftCommandHandler.cs:85-91` | **High** — hours can vanish without a trace in the feed |
| D4 | Only approved cards are eligible for export; Closed period requires all approved (TA-55, TA-49) | `generate` has no approval check; PENDING shifts are loaded, flagged unapproved and written to the file | `PayrollExportController.cs:190-272`; `PayrollDataLoader.cs:31-37,188-193` | **High** — but PRD §4.24 L1893 itself only asks for a warning, so confirm intended behaviour |
| D5 | Closed = all time cards approved (TA-49) | Status change to CLOSED performs no approval check; CLOSED → OPEN is also accepted (only transitions from/to EXPORTED are blocked) | `API-TA/PayPeriodsController.cs:213-261` | Medium |
| D6 | Export sets the period to Exported after successful generation (TA-54) | Only an unfiltered whole-period run sets EXPORTED; a run filtered by department/position or by the caller's department scope leaves the period open and unfrozen | `PayrollExportController.cs:222-237` | Medium — department-scoped payroll users can never freeze a period |
| D7 | Geofence checks the employee's associated locations (TA-02) | Any active location of the customer with coordinates passes; with no such location geofencing is off | `TA-INF/Services/GeofenceService.cs:25-34,42-54` | Medium/High — driver can clock in at another depot |
| D8 | Audit Log uses the edit-time-card permission, no separate one (TA-63) | Dedicated `ta:auditlogs:read` permission gates the audit resolvers | `API/GraphQL/Query.cs:193-198,227,244` | Medium — permission matrix tests |
| D9 | Added clock-out must be after clock-in (TA-09) | Out before in is accepted as an overnight pair (next day); only equal times are refused (409) | `TimesheetController.cs:525-535` | Medium — a typo (16:00 → 06:00) becomes a 14 h shift |
| D10 | V1 does no overlap validation (TA-11) | Overlapping punch on the matched shift → 409 | `TimesheetController.cs:576-589` | Low — code stricter than spec |
| D11 | Manual punch matches a **planned** shift; unmatched is flagged for review (TA-10) | Matches an existing **un-edited worked shift** with same employee + date + job code; otherwise creates a new shift and returns `matched:false`; no persisted "flag" was seen in this method | `TimesheetController.cs:509-515,552-573,645` | Medium — a punch added after a supervisor edit always becomes a separate shift |
| D12 | Trip credits are approved as part of time-card approval (TA-34) | Bulk approve handles shifts and absences only; trip-credit API has only GET and POST; export treats a credit with no approval rows as approved | `TimesheetController.cs:115-122,238-274`; `API-TA/TripCreditsController.cs:12,27-28`; `PayrollDataLoader.cs:201-204` | Medium — credits reach payroll with no approval step |
| D13 | Range absence skips non-scheduled days and holidays (TA-28) | Skips only weekends (when `WeekdaysOnly`), days that already have an absence, and frozen days | `TA-APP/Absences/Commands/CreateAbsence/CreateAbsenceRangeCommandHandler.cs:78-93` | Medium — absence hours booked on holidays |
| D14 | V1 absence entry is manual hours only (TA-27) | API also accepts STANDARD_DAY and SCHEDULE_BASED (fallback 8 h) | `CreateAbsenceRangeCommandHandler.cs:95-102,129-137` | Low — API superset; PRD §3.3 L347-350 still lists the three methods |
| D15 | Holiday hours by manual / standard-day / schedule method (TA-33) | Always the FTE daily hours effective on the date, else 8 h; pay code fixed "HOL"; position check uses current positions, not those held on the holiday | `PayrollDataLoader.cs:133-135,160-161,173-181`; `PayrollExportController.cs:380` | Medium |
| D16 | Total-level rounding must be supported (TA-23) | Only per-endpoint (punch-level) rounding exists | `TA-INF/Services/PayableTimeService.cs:92-97,124-129` | Medium — depends on whether any client needs it |
| D17 | V1 defaults 15-min rounding and +30 cap (TA-21) | No rule ⇒ no rounding, no floor, no cap; cap needs an explicit buffer | `PayableTimeService.cs:117-119,133-134` | Low — defaults must come from seed/setup data; verify per environment |
| D18 | Approve covers exactly one work week (TA-42) | Bulk approve takes any `WeekStart`/`WeekEnd` range with no validation; its comment says Mon-Sun while export uses Sun-Sat | `TimesheetController.cs:104-122,756`; `PayrollExportController.cs:379` | Low/Medium |
| D19 | Approving also signs off absences — not stated in the PRD | Bulk approve sets in-range absences APPROVED | `TimesheetController.cs:231-274` | Info — expected by code, undocumented |
| D20 | Absence, holiday and trip-credit hours vs the 40 h threshold — PRD says "payable hours" without defining | They never count toward overtime | `PayrollCalculationService.cs:47-54,140-151` | Medium — needs a product answer |

### 6.2 Suspected, not confirmed

- **PIN optional per customer (TA-01)**: no "PIN required/optional" setting found by search in `*.cs`; the PIN endpoint always verifies a PIN per `backend-core.md` §5.3. UNVERIFIED (handler not re-read).
- **Independent clock-in / clock-out geofence configuration (TA-04)**: no such setting found by search; one `GeofenceService` serves both. UNVERIFIED for client-side config.
- **Pay-period auto-close and auto-export (TA-65)**: no scheduler or matching code found by search (`auto.?close`, `auto.?export`) — likely not implemented. UNVERIFIED outside `*.cs`.
- **PTO balance import and display (TA-69)**: no matching code found by search. UNVERIFIED.
- **Time-adjustment workflow (PRD L428)**: entity and EF configuration only; no handler or controller found by search.
- **Delegation through `usr_user_entity_scope` (TA-48)**: repo `CLAUDE.md` ("Auth & permissions") says that table is not wired into query filters; scoping comes from JWT claims fixed at login, so a new delegation needs a new token. Mechanism for granting `department_access` not traced.
- **Single authorization boundary (TA-59)**: `backend-core.md` §2.4 and §8 report GraphQL reads are not permission-gated and `includeDeleted:true` bypasses scope on many lists. Not re-opened here.
- **Export step 1 list (TA-52)**: `backend-core.md` §5.8 says periods with no shifts are hidden in addition to EXPORTED ones. Not re-opened.
- **OT by job code within a day (TA-38)**: the engine splits a day's regular/OT across **shifts** ordered by payable start (`PayrollCalculationService.cs:171-187`), not across individual punches; interleaved punches of two job codes on the threshold day may be attributed differently from the PRD's "ordered punches". Needs a test.
- **OT-by-job-code toggle and per-work-week breakdown in review / Pay Cycle Summary (TA-53, TA-57)**: per-segment regular/OT exists in the engine; the rollup has no per-job-code OT field (`PayrollCalculationService.cs:240-256`). UI and formatters not read.
- **Supervisor clock-in into a closed period**: `backend-core.md` §8 reports `POST api/ta/shifts` has no freeze check, contrary to TA-49. Not re-opened.

### 6.3 Document staleness to keep in mind

- KB describes reject endpoints and a REJECTED state (KB L325-326, L421-422, L471-473, L519); current code never writes REJECTED (`backend-core.md` §5.4) though the export loader still filters it (`PayrollDataLoader.cs:34,44`).
- KB says there is no timescan ingestion, geofence or PIN pipeline (KB L549); current code has all three (`backend-core.md` §5.3).
- KB says overnight shifts are unsupported (KB L250, L550); mobile clock and Add clock-in now allow them (D9).
- KB and repo `CLAUDE.md` point to PRD v1.2; the PRD in force is v1.9.
- PRD internal leftovers: REJECTED at L811; "custom_pay_code" at L875-878 (renamed `external_paycode`); table counts 109 vs 122 (L45, L928); notification triggers in §5.3 vs deferral in §4.27; §4.24 says it "extends section 4.7" (should be the export design).

---

## 7. Suggested test priorities (top 15)

| # | Test case | Level |
|---|---|---|
| 1 | Weekly OT with work on a Sunday and a Saturday: compare Monday-start (PRD) vs Sunday-start (code) results (D1) | Unit + Integration |
| 2 | PRD OT scenarios 1-3: week spanning two pay periods puts regular/OT hours in the right period | Unit |
| 3 | OT by job code, examples A and B, including interleaved punches of two job codes on the threshold day | Unit |
| 4 | Payable pipeline: edited-over-actual, NEAREST/UP/DOWN at the half interval, seconds, floor, cap, and the no-rule case | Unit |
| 5 | Multi-punch shift pays the sum of windows (05:45-08:00 + 09:00-11:00 = 4.25 h), gap unpaid, per-punch edit recomputes | Integration |
| 6 | Edit an APPROVED shift → PENDING, approvals voided, System audit event; same for job-code change | Integration |
| 7 | Pay-period freeze matrix: every write (edit, delete, add punch, absence, clock-in web and mobile, approve) × OPEN / CLOSED / EXPORTED | Integration |
| 8 | Export with unapproved shifts: warning shown, file content, and whether generation should be blocked (D4) | E2E |
| 9 | Export sets EXPORTED only for an unfiltered run; department-scoped user's export leaves the period editable (D6) | Integration |
| 10 | Erroneous shift correction: edit-to-zero rejected, delete works, deleted unapproved shift missing from Audit Log (D2, D3) | Integration + UI |
| 11 | Geofence: inside own depot, inside another depot of the same customer, outside all, no locations configured, radius boundary (D7) | Integration |
| 12 | Add clock-in: match to existing shift, no match, edited shift, out-before-in, overlap, ineligible job code (D9-D11) | Integration + UI |
| 13 | Bulk approve: missing clock-out blocks the whole request; N drivers → N audit events; absences approved; trip credits untouched (D12) | Integration |
| 14 | Range absence over a weekend and a holiday; duplicate day; hours 0, 0.01, 24, 24.01; removal of one day (D13) | Integration |
| 15 | Scope and permission matrix: department-scoped manager vs other department on REST writes, GraphQL reads, Audit Log (`ta:auditlogs:read`), and delegation taking effect only after re-login | Integration + E2E |
