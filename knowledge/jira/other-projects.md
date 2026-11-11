# Jira: projects other than ENG (PROD, SPT, IN, SOC, MDP)

> Read 2026-11-10 from busplanner.atlassian.net, read-only. Customers appear only as short codes. No personal data recorded.
> Companion to `knowledge/jira.md` (ENG is covered by other files). Analysis sections 3-6 are at the END of this file, after the digests.

## 1. Header

Projects on the site (listJiraProjects, 2026-11-10): six. ENG (2,882) is out of scope here. The other five:

| Project | Issues | Read |
|---|---|---|
| PROD Product Management | 848 (621 Feature Request, 103 Story, 66 Feature, 30 Product, 28 Epic) | All 848: summary, status, type, priority, labels, parent, links and description (first ~200 chars of each body read; longer bodies skimmed). All created 2026-05..2026-11, so nothing was "older than 12 months" |
| SPT Support Queue | 117 (87 Bug, 28 Dev Question, 2 Workflow) | All 117: full description and every comment (65 issues have comments). See "Deep read: SPT" |
| IN Infrastructure | 235 (108 Task, 43 Bug, 40 Sub-task, 38 Story, 6 Epic) | All 235: full description and every comment (108 issues have comments). See "Deep read: IN" |
| SOC BusPlanner SOC2 | 71 (all Done) | All 71; full bodies of SOC-10, 22, 38, 42, 73 |
| MDP My discovery project | 6 | All 6 (template sample ideas) |

Counts differ slightly from jira.md section A (PROD 842 -> 848, SPT 118 -> 117, IN 234 -> 235) because of issues created or moved today.
Skipped: nothing. PROD and SOC comments were not read (out of scope for the deep read). Secrets found in ticket bodies and not copied here (should be redacted in Jira): SPT-884 (third-party API token), SPT-395 and SPT-937 (test-account passwords).
How SPT and IN link to ENG: support (PSS/CX) files SPT tickets from Zendesk (`pss-stamped` = filed by a PSS through automation, 33); triage either answers them, closes them, or moves/clones them into ENG; moved ones carry `jira_escalated` (97 of 117 SPT; 47 IN; 461 PROD). `jira_auto_reopened` (18 SPT) marks tickets reopened by the Zendesk sync. SPT statuses: Backlog 63, Done 45, On Hold 9. IN statuses: Done 120, Backlog 66, In Progress 45, On Hold 4. PROD statuses: Backlog 622, Done 96, In Progress 36, Ready for Development 28, Scheduled 19, Declined 17, To Do 14, Gathering Requirements 9, On Hold 7.
PROD hierarchy: Product (PROD-670..688, 724, 823, 844, 847, 850-854, 862) -> Feature ("<product>: Bugs and General Tasks", "New Features", "Customer Asks", versioned Unified features) -> Feature Requests / Epics; ENG epics hang under PROD Features. Labels: `Sales` (77, prospect asks), `CX` (14), `FeatureRequest` (98), `time-and-attendance` (79). No PROD components or fix versions are used.

## 2. Per-project digests

### SPT digest (page 1)
SPT-24 | Dev Question | Done | placeholder ("na")
SPT-26 | Bug | Done | DataRemote Reader down at a FL customer; BPQuick/Dispatch "connection forcibly closed" DB errors (GPS reader)
SPT-31 | Bug | Done | TSTG: Synovia (WAT) vehicles take over other operators' routes in BP Web because vehicle IDs are not unique across GPS providers
SPT-32 | Dev Question | Done | SDCC: parents cannot add students in Chipmunk although students are linked to parent email in Quick/Pro
SPT-33 | Bug | Done | test ticket for Zendesk-Jira integration (stop colour request)
SPT-34 | Bug | Done | STSTB: ~50-86 buses show "No GPS Events" in Quick while Pro shows events (cloned by ENG-629, ENG-635)
SPT-71 | Bug | Done | STSTB: General Notice not pushed to Chipmunk app nor shown in Alerts tab, though Delays app and email got it
SPT-75 | Bug | Done | test ticket
SPT-82 | Dev Question | Done | OSTA: impact of moving planning-DB start date earlier for a school with an early calendar (finance PO)
SPT-89 | Bug | Done | Workflow "Annulation du transport scolaire": student search button lists ALL students (privacy)
SPT-99 | Dev Question | Done | STSCO: find submittals not loaded after an outage on 2026-06-25
SPT-117 | Dev Question | On Hold | JMCSS: was the workflow "view" page grade/school fix (ADO 42366) actually released?
SPT-119 | Dev Question | Done | BTPS: RAM recommendation after upgrade to BP 13.1.0.14 (memory 80-85% on 16 GB)
SPT-124 | Dev Question | On Hold | PASCO: Extended Property UserFieldGuid differs between summer and school-year DB, breaking a third-party import
SPT-141 | Bug | On Hold | HSTS: "Walking Path to Stop" fails when stop is at an intersection whose cross street disallows crossing
SPT-200 | Bug | On Hold | STSTB: route cancellation alert not pushed to parent apps (relates ENG-1088)
SPT-210 | Bug | Done | Yukon: BP Info errors updating Schools/Grades/Operators (missing tables, injection needed)
SPT-211 | Bug | On Hold | NCSD: Samsara Reader error when switching GPS to next-year DB
SPT-212 | Bug | On Hold | PGCPS: unclear error "Failed to add Bus Stop to graph. No valid vertices" when Right Side Service + one-way streets
SPT-245 | Bug | Done | Yankton: drivers see no students on stops in Turns (duplicated by ENG-1266)
SPT-298 | Bug | Done | GNB: auto-assign assigns students to a stop whose school was removed from the stop
SPT-352 | Bug | Done | KY-MT (INDY): Chipmunk shows "Bus Not Reporting" for a parent's children
SPT-361 | Dev Question | Done | STOPR: changes to Ontario MOE delays report since 12.2.1.266
SPT-370 | Bug | Done | WDSTS: dual-enrolment students at two boards break parent portal contact matching
SPT-395 | Bug | Done | CESD: substitutions not showing vehicles in Turns app
### SPT digest (page 2)
SPT-408 | Bug | Done | STSWR: Web Route Map Report by Route very slow (Hamilton similar); GeoIMS pool size did not help
SPT-410 | Dev Question | Done | CALVERT: Trips - buses already scheduled for a trip date still listed as available in Vehicle ID
SPT-424 | Bug | On Hold | SAPS: GPS Live Viewer shows no GPS events for all vehicles while route events exist
SPT-432 | Bug | Done | PRSD: student appears twice in Turns ridership (old and current school); Pro shows one school
SPT-440 | Bug | Done | NHCS (also CALVERT): Quick "bus pass" button does not create/open the bus pass box
SPT-447 | Bug | Done | NHCS: Chipmunk contact matching - parent cannot add student though email and subscriber are correct
SPT-507 | Bug | Done | WDSTS: Web "Cancellation & Delay Report" for an AM time range includes PM runs and vice versa (relates ENG-2306)
SPT-539 | Bug | Done | STSI: BP Web cache manager error stops newly added runs from appearing (2 live DBs on one site)
SPT-566 | Bug | Backlog | SAPS: Turns card scan "no match found for Given ID" - 7-digit card numbers padded with leading 0 (parent ENG-66)
SPT-585 | Bug | Done | PRSD: pending scans retry with out-of-date vehicle ID and are never recovered (follow-up of ENG-2069)
SPT-586 | Bug | Done | PRSD: Turns scan list does not move to newest scan (follow-up of ENG-2069)
SPT-597 | Dev Question | Done | WDSTS: SSO vs normal login - parents with students in two boards cannot see both with one login
SPT-629 | Bug | Backlog | TSTG: web report takes 25 min; missing index proposed (blocked by ENG-890)
SPT-632 | Bug | Done | SWOSTS: GTS GPS reader logs a recurring error every few seconds; endpoint truncated in console (split from ENG-1600)
SPT-633 | Dev Question | Done | PGCPS: retro-regenerate 4Mativ student report after ride-time fix (relates ENG-2166)
SPT-742 | Bug | Done | TRIBOARD: Finance Route Cost Breakdown Analyzer totals differ from Route Listing for routes with variations (parent ENG-104)
SPT-761 | Dev Question | Done | TSTG: Attridge (Zonar) vehicle mapping wiped / reads incorrectly, parent cannot track bus
SPT-770 | Bug | Backlog | STSTB: bus shown as reporting late when it is not (IR526)
SPT-774 | Bug | Backlog | STSTB: GPS+ Smart Mapping shows a different vehicle on a run than Pro and No GPS report
SPT-784 | Dev Question | Done | OSTA: Government > Ontario > Operator Importer "access violation" error
SPT-787 | Bug | Done | STSTB: GPS+ shows "No GPS Events" while vehicle reports and Path Compare has full path (relates ENG-165)
SPT-788 | Bug | Backlog | STSTB: duplicate of SPT-787
SPT-791 | Dev Question | Backlog | HPSTS: update 5 specialized RFP contracts with same fuel escalator / variable costs by vehicle size (relates ENG-2812)
SPT-794 | Bug | Done | STSI: routes in Routes table missing from BPX_AMPMComponentHistory (planned-time billing report)
SPT-801 | Workflow | Backlog | SJCSD: host a static Dispatch training page at a BusPlanner URL, then BP Academy
SPT-802 | Dev Question | Backlog | TRIBOARD: Additional Cost line items not included in Route Cost Breakdown Analyzer totals
SPT-807 | Bug | Backlog | PRSD: Turns does not restore route state after crash (map resets, re-select bus/route, scans feared lost) (relates SPT-881)
SPT-808 | Bug | Backlog | SWOSTS: GPS stop events for one operator not reporting (Zonar reader); GPS On Time report errors
SPT-809 | Bug | On Hold | HCPSS: Pro Find Eligibility tool extremely slow and resource-heavy
SPT-810 | Bug | Backlog | BCS: home stop not offered when assigning a stop; shown as future-dated though route effective since 2025
SPT-824 | Bug | Done | PRSD: after upgrade, Quick GPS Live shows No GPS Events (Tracker gets data, GeoIMS disconnect)
SPT-825 | Bug | Backlog | STSTB: cancelled bus moved around depot sent late notices to parents in Chipmunk
SPT-829 | Bug | Backlog | FBUS: Web "Can I Ride a Bus?" address auto-suggest misses a municipality when street name is filled
SPT-830 | Bug | Backlog | NHCS: Route Directions by Run with "Include Deadheads" shows a variation the run does not have
SPT-831 | Dev Question | Backlog | FIRST: training request on building SSRS custom reports for Pro Report/Export Wizard
SPT-834 | Dev Question | Done | RVS: cannot delete unused Travel Code - FK error from BPL_StudentEligibility rows
SPT-838 | Bug | Backlog | MDCPS: Workflow Admin > Technicians/Supervisors Groups dialog no longer lists school groups
SPT-841 | Bug | Backlog | New World GPS+: Path Compare should open in a new tab
SPT-844 | Bug | Backlog | New World: remove "Dispatch (Soon)" from the Canadian production site (customers there do not have Dispatch)
SPT-847 | Bug | Backlog | HRCE: Workflow forms reCAPTCHA shows for BP Support but not for client users after 2026-10-19 update (relates ENG-2982)
SPT-848 | Bug | Done | CCSD: BP Web alerts pushed late or not at all to Delays app; alert indicator not red
SPT-849 | Bug | Backlog | TCRCE: same - alerts delayed / not pushed to Delays app
SPT-851 | Workflow | On Hold | TSTG: Web Alert Listing "Save" export splits alerts across two rows since 13.3.1.244
SPT-856 | Bug | Backlog | PSD: Turns students on merged runs (Dispatch merge) scan red/orange at school
SPT-857 | Bug | Backlog | PRSD: multiple stops at one location - Turns scans land on whichever stop opens first; driver cannot pick the right stop
SPT-872 | Bug | Backlog | SAPS: Student Eligibility calculator no longer writes StudEligErrors.txt when errors are found
SPT-875 | Bug | Backlog | CBE: duplicate BPX_Enrollment rows give wrong PU Stop IDs in studentsstops data extract (PowerSchool upload fails)
SPT-876 | Bug | Backlog | STEO: Workflow "upload to BP as student attachment" says success when student does not exist
SPT-878 | Bug | Backlog | WCPS: Trips export Total Cost differs by $0.01 from sum of component costs (rounding)
SPT-879 | Bug | Backlog | TBSTS: Route Changes web report shows future-effective stops; PDF does not
### SPT digest (page 3)
SPT-880 | Dev Question | Done | MCS: does a temporary vehicle substitution in Quick win when the sub bus is also assigned to another route (Chipmunk impact)?
SPT-881 | Bug | Backlog | PRSD: Turns "Object reference not set..." on Submit of vehicle/route (relates ENG-669, ENG-2069, SPT-807)
SPT-883 | Dev Question | Backlog | TSTG: Turns usernames on vehicle mappings; can an individual tablet be disabled (WAT GTS legacy mappings, SPT-870; relates ENG-2883)
SPT-884 | Bug | Backlog | HWSTS: Samsara GPS reader fails to start polling "Failed to get all vehicles" (note: ticket body contains a live API token)
SPT-885 | Dev Question | Done | NCPS: Time and Attendance user cannot log in (credential reset request)
SPT-886 | Bug | Backlog | SJCSD: Zonar buses drop to "No GPS Mapping"/"No GPS Events" mid-run in Dispatch Live Viewer though mapping valid in Pro
SPT-888 | Bug | Backlog | TDCH: Zonar GPS reader silently stops receiving events; restart from last date backfills
SPT-889 | Dev Question | Backlog | MCS: student with two pickup/two drop-off stops (split custody) not linked to school pickup/drop-off
SPT-892 | Bug | Backlog | RVS: Pro Student Report with large "Selected students" (12-13k) fails with SQL Msg 8623 (relates ENG-2042)
SPT-893 | Bug | Backlog | STSCO: Pro Edit Student comment pane disabled (not scrollable) for users without Alter Object permission
SPT-894 | Bug | Backlog | ENROUTE: Web Operator Route Summary by Route PDF prints miles on a metric site; Show/Save print km
SPT-895 | Dev Question | Done | HRCE: hosted BP Pro RDP outage - root cause and mitigation
SPT-897 | Bug | Backlog | CSAP: Web/Workflow severe slowness (15 s to 1.5 min), server CPU 100%
SPT-898 | Bug | Backlog | SJCSD: Dispatch email notifications have wrong times after merging runs with a double-back to the same school
SPT-899 | Bug | Backlog | Creating a new spatial DB fails in 13.2.3.177+ (geotools convert after shapefile import)
SPT-900 | Dev Question | Backlog | TSTG: BP PM operator video upload fails "Upload Failed"; file size limit?
SPT-901 | Bug | Done | TSTG: Pro Student Listing results grid shows blank Effective/Retire Date for students whose trips have retire dates
SPT-902 | Bug | Backlog | TSTG: duplicate of SPT-901 (open)
SPT-904 | Bug | Backlog | SJCSD: Dispatch shows buses late on PM runs (relates ENG-2631, SPT-886)
SPT-906 | Bug | Backlog | SJCSD: Florida FEFP Supplemental Roster prints 36 of 244 routes in a large batch, silently
SPT-907 | Bug | Backlog | WDSTS: Delays app (Android) General Notice popup shows raw HTML; regression of ADO 37310
SPT-909 | Bug | Backlog | ACS (NC): Ontario government report visible in BP Web Reports for a US client
SPT-910 | Bug | Backlog | TSTG: BP Web silently drops a student's PM run when school-pickup assignment is retired/missing while Pro shows it active (relates ENG-2881)
SPT-912 | Bug | Backlog | AUSD: Staff Update import allows contacts without Contact Type, leaving records unsaved; Quick staff open errors
SPT-914 | Bug | Backlog | SAPS: Web Workflow completed bus pass replacement requests show "Untreated" and blank user
SPT-915 | Bug | Backlog | IN-MT (Miller): Chipmunk "Bus not reporting" (map and ETA) though vehicle mapped
SPT-916 | Dev Question | Backlog | ENROUTE: BP Finance operator invoice blank, Outputs list empty (test Finance DB)
SPT-918 | Bug | Backlog | GNB: Web Student Scan Report returns no results for any role except Site Admin
SPT-921 | Bug | Backlog | STSBHN: SaaS migration backup support request for 2026-11-20
SPT-924 | Bug | Backlog | New World GPS+: Path Compare default time range should be today, not 1 week
SPT-925 | Bug | Backlog | MDCPS: BP Fleet re-exported a 2006 legacy work order to SAP (relates ENG-2626)
SPT-927 | Bug | Backlog | CALVERT: Trips SE Trip Listing date range excludes the last day; single-day range returns nothing
SPT-928 | Bug | Backlog | STSTB: "Post a School Alert" menu visible to users without School Closer role (redirects home)
SPT-932 | Dev Question | Backlog | NPSSTS: Student Update pends address changes despite "Don't pend address changes if same Geocode" and address equivalencies
SPT-933 | Bug | Backlog | MDCPS: BP Fleet parts transfer receive keeps receiving shop's cost - stock arrives at $0, work orders charged $0
SPT-935 | Dev Question | Backlog | NHCS: Chipmunk behaviour when a student is on two runs at the same time (shows one bus at random)
SPT-937 | Bug | Backlog | HWSTS: BP Info REST API does not return some 2026-27 runs to a third-party (ByteCurve)
SPT-938 | Dev Question | Done | OSTA: Ontario Ministry Student report (128,759 students) takes 20-40+ h on 13.4.1.231
SPT-939 | Bug | Backlog | SWOSTS: walk-distance eligibility should be able to ignore school location and use only access points
SPT-940 | Bug | Done | PGCPS: Subscription Service will not start after multiple send attempts alert
SPT-941 | Bug | Backlog | SJCSD: Quick Roles page Save returns "Insufficient permissions" even for Administrators
SPT-942 | Dev Question | Backlog | WDSTS: Samsara Reader not appearing in Pro GPS settings after install (Zonar to Samsara migration)

### IN digest (page 1: IN-1..IN-103)
IN-1..IN-8 | Story | mostly Done (IN-7 On Hold) | Stage 1 IBM Cloud VSI resizes (TSTG web/app, LESA, HCS, SJCSD, NHCS, CBE, HRCE) under epic IN-10
IN-9 | Story | Done | SDCC (Clay) server upsize
IN-10 | Epic | Backlog | Stage 1 server resizes
IN-11 | Epic | Done | Stage 1 Datadog agent rollout (infra + SQL metrics, right-sizing, query tuning)
IN-12, IN-13, IN-15, IN-28 | Story | Done | Datadog agent on LESA, HCS, TSTG-App, SJCSD
IN-14 | Story | On Hold | Datadog on TSTG-Web (epic IN-29)
IN-16 | Epic | Backlog | Stage 2 server resizes
IN-17..IN-21, IN-24 | Task | Done | Stage 2 downsizes (LESA, HCS, TSTG web/app, SJCSD, HRCE)
IN-23 | Task | Backlog | Stage 2 resize CBE
IN-25 | Story | Backlog | SOC2: multi-zone whole-machine image backups + SQL point-in-time (today Duplicati per server)
IN-26 | Story | Backlog | SOC2: company-wide password manager + authenticator-app MFA
IN-27 | Story | Backlog | RDP code-signing after April 2026 Windows update changed .rdp file launch warnings
IN-29, IN-30 | Epic | Backlog | Stage 2 / 3 Datadog rollout
IN-31..IN-33 | Story | Backlog | Datadog on CBE, HRCE, NHCS
IN-34 | Story | Backlog | First Student AVD environment: Pro user config persistence and GeoRef directory handling
IN-35 | Story | In Progress | SAPS: BP Pro and Web extremely slow
IN-36 | Task | Backlog | Investigate consolidating clients onto shared SQL Server instances (cost)
IN-37 | Story | Backlog | CCSD: weekly refresh task failed with no logs or notification
IN-38 | Task | In Progress | Fully automated certificate renewal (IIS, RDP, FTP)
IN-39 | Task | Done | Right-size Attridge GPS+ pilot server (32 cores, cost vs revenue)
IN-40 | Story | Done | SDIRC: list of IPs and URLs for customer IT whitelisting
IN-41 | Bug | In Progress | RCJTC: users disconnected from BP Pro (timeouts)
IN-42 | Bug | Done | NHCS: SFTP/WinSCP connection failing - nightly student update stopped since 07-07 unnoticed
IN-43 | Story | Done | BP Unified T&A: deploy US staging and prod Kubernetes clusters on IBM Cloud for Yankton go-live (parent ENG-1025; relates ENG-1021/1022/1024)
IN-44 | Task | Done | Canada-hosted VM so offshore dev can work with large client DBs
IN-45 | Task | In Progress | Server snapshots for new-world environment (had no backups)
IN-46 | Task | Backlog | SQL Server DB backups for new-world environment
IN-47, IN-58 | Bug | Done / In Progress | PASCO: slow server (report >10 min, CPU 66%, memory 82%)
IN-48 | Task | Backlog | T&A: make developer accounts on US/CA prod read-only (parent ENG-1025)
IN-49 | Task | Done | Two restricted RDP logins for offshore Projects team (Chipmunk tracker monitoring)
IN-50 | Story | Done | MDCPS app server clock out of sync
IN-51 | Bug | Done | New Canadian VPC support accounts expired
IN-52..IN-55 | Task | Done | Server resizes (Gaston, Harnett, Miami)
IN-56 | Bug | Done | BRSD: LogDNA agent hogging server resources
IN-57 | Task | Done | Audit/reconfigure Pulseway monitoring on all Chipmunk servers (no alerts on CPU/service failure; St John's, Clay, Niagara near 100% CPU)
IN-59, IN-65 | Bug/Story | In Progress / dup | FBUS: slow server (relates ENG-1553..1556)
IN-60 | Bug | Done | PGCPS: IIS application pool repeatedly stops overnight
IN-61 | Bug | Done | JMCSS: slow server / RDP freezing (relates ENG-2802)
IN-62 | Story | Backlog | CALVERT: lagging performance
IN-63 | Bug | Done | First Student: BP Web emails (Post Alerts / Subscription) stopped after data-centre move, unnoticed
IN-64 | Task | In Progress | Upgrade CrushFTP 11.4.5 -> 11.5.4
IN-66 | Task | In Progress | CTSO: memory pressure 93% causing slowness (relates ENG-1864..1867)
IN-67 | Bug | Done | NCPS: SQL Server max memory stuck at 50 GB of 255 GB, MAXDOP 1 - resizes never reached the engine
IN-68 | Bug | Done | PSPT: Subscription Service and GTS reader services stop running (email downtime)
IN-69 | Story | Backlog | Email distribution list update
IN-70 | Task | Done | OSTA: memory 98% / CPU 78% - increase resources
IN-71, IN-73 | Task | Done | SAPS: server resize (CPU throttled)
IN-72 | Bug | In Progress | SWOSTS: severe long-standing performance - reports 90+ min, group tasks hours; suspected SQL indexing (relates ENG-2202, 2443-2445, 2734)
IN-74 | Task | Done | PGCPS: third SQL Server 2022 VSI
IN-75, IN-77 | Bug | Done | HRCE: Web slowness (GeoIMS restart/pool size); server slow
IN-76 | Task | Done | Expand offshore team RDP access to Pro and SQL
IN-78 | Story | Done | PGCPS: historical OTP report overwhelms server
IN-80 | Task | Done | Office PC RAM upgrade
IN-81 | Task | Done | SDIRC: server resize (CPU/RAM 99%; Chipmunk down)
IN-82 | Bug | Done | CSSBE: user cannot log in to Pro
IN-83 | Bug | In Progress | High memory usage (a customer server)
IN-84 | Bug | Done | TSTG: app server lock-up, RDP "Please wait for Remote Desktop Configuration" (relates IN-164, IN-195)
IN-85 | Bug | Done | MDCPS: RemoteApp logins fail "Element not found" - clock skew corrupted RD Connection Broker timestamps
IN-86 | Bug | Backlog | RDCRS: memory >80%
IN-87 | Task | In Progress | PGCPS: RDP disconnects and BP Pro crashes - diagnosis
IN-88 | Bug | Done | Published RDP files do not work outside office network
IN-89 | Task | Done | CA VPN access to the 3 k8s MSSQL servers (dev, staging, prod)
IN-90 | Bug | In Progress | FBUS: www29 outage 2026-09-24 root cause
IN-91 | Bug | In Progress | PASCO: recurring Pro slowness - resource review
IN-92 | Bug | Backlog | GCS: certificate error on corporate FTP site
IN-94 | Task | Done | Corporate FTP session timeout errors
IN-95 | Task | In Progress | AUSD: RD Gateway Duo enrollment and gateway FQDN misconfiguration
IN-96 | Story | Done | CBVRCE: memory ~95% - increase
IN-97, IN-100 | Task | Done | Staff onboarding / cloud access
IN-98 | Story | Backlog | 2FA code management (codes go to physical phones)
IN-99 | Task | Done | Grant webinar mailer app Mail.Send permission
IN-101 | Task | Done | NWSD: Duplicati SQL backup job "No source folders specified"
IN-102 | Task | Done | Restore a customer LIVE DB to the QA SQL server
IN-103 | Task | Done | PSD: slow BP Pro, high SQL memory (relates ENG-2771..2776)
### IN digest (page 2: IN-104..IN-204)
IN-104 | Task | In Progress | Internal corp VSI unresponsive; reboot fails
IN-105, IN-110, IN-119, IN-124, IN-198 | Task | Done/In Progress | Staff onboarding and cloud access
IN-106 | Bug | In Progress | NS clients: SQL Server and Agent not running on servers (parent ENG-76)
IN-107 | Task | In Progress | Duplicati SQL backups failing - VSS snapshot deleted mid-run
IN-108 | Bug | Done | TSTG: users disconnected ~4 PM 2026-10-06 - root cause
IN-109 | Task | Done | FTP site slow: build uploads and QA environment deployments take an hour+
IN-111 | Bug | In Progress | CCSD: server 100% CPU / 97% memory; Eligibility Calculation tasks running for days (relates IN-213, ENG-2777, ENG-2967, ENG-2968)
IN-112 | Task | Done | Restore a customer LIVE DB to QA1 SQL server
IN-113 | Bug | In Progress | PGCPS: login outage 2026-10-08, Remote Desktop Services hung (relates IN-87)
IN-114 | Task | Backlog | Scoped Mail.Send app registration for Zendesk PSS email automation
IN-115 | Story | Backlog | SDCC: nightly Dispatch DB backups before refresh - indefinite retention, offsite
IN-116, IN-118 | Task | Done | Duplicati "SQL Backups" failing on missing remote files (STSCO, FBUS); FBUS last good backup two weeks old
IN-117 | Task | Done | IBM Container Registry quota exceeded - CI image push blocked
IN-120 | Task | In Progress | IBM and SQL access for Projects team to set up new world (Unified)
IN-121, IN-125, IN-131 | Task | Done | Internal workstation / RDP troubleshooting
IN-122, IN-128 | Bug/Task | Backlog/Done | NSTS: C: drive full
IN-123 | Task | Done | STSCO: stuck RDS session "Remote Desktop Services is currently busy"
IN-126 | Task | Done | Monthly SaaS maintenance: Windows updates on all IBM VSIs via Pulseway (2026-10-16)
IN-127 | Bug | Backlog | Recurring memory issues on several customer servers (AVRCE, CCRCE, CCPS, OCS, HWSTS, CSAP...)
IN-129 | Task | Done | Shared mailbox creation
IN-130 | Bug | In Progress | HPSTS: server went down 2026-10-05, cause unknown
IN-132 | Task | Done | Recover login access to CA k8s staging/prod MSSQL servers (undocumented)
IN-133 | Task | Done | WRSD: update allowed source IP for nightly FTP upload
IN-134 | Task | In Progress | Office move IT tracker
IN-136 | Epic | In Progress | Post-school-opening server downsizes; CTO set 40% headroom at peak CPU and RAM (2026-10-19)
IN-137..IN-152 | Task | mixed | Per-customer resize plans (SDCC, PGCPS, HCS, LESA, NHCS, NCPS, YSD, MISD, NCSD, ACS, HPSD, SPS, SDOC, MDCPS no change, MT, EBRPSS)
IN-153..IN-193 (except IN-164) | Sub-task | mixed | Individual resize steps; "Step 4/4 NOT NEEDED - 40% buffer" sub-tasks closed
IN-164 | Bug | Done | ECSD: BP Pro RemoteApp "couldn't connect in the amount of time allotted" since 2026-10-19 (relates IN-84, IN-195)
IN-194 | Task | Done | PGCPS: ensure 7-day CPU/RAM tracking on PGCPS1/2 (Pulseway)
IN-195 | Task | In Progress | Server audit: September 2026 Windows update causes RDS hang (Microsoft known issue) + Pulseway agent repair
IN-196 | Task | Done | Weekly operations and maintenance catch-all
IN-197 | Story | Done | CCSD: SFTP server prevents deletion/overwrite of nightly student file upload
IN-199 | Task | In Progress | Security audit for reported PHP shell CVEs on Ubuntu hosts / IIS
IN-200 | Task | In Progress | GeoTab GPS reader requests resultsLimit 200,000 on Get:StatusData, above Geotab's new 50,000 limit (Miller)
IN-201 | Task | In Progress | CLASS server performance review (relates ENG-2802, ENG-2772)
IN-202 | Task | In Progress | TSTG: intermittent BP Pro freezes - server review
IN-203 | Bug | Backlog | STEO: server downsized, must be resized for SaaS move
IN-204 | Bug | Done | TSTG: 25 RDS sessions disconnected within 75 s on 2026-10-23
### IN digest (page 3: IN-205..IN-239)
IN-205 | Story | Backlog | WESTS: how many BP Web parent portal accounts have 2FA on? (no report exists)
IN-206, IN-218, IN-238 | Task | Done/In Progress | Weekly operations and maintenance catch-alls
IN-207, IN-234 | Task | In Progress | Onboarding
IN-208 | Task | Done | Pulseway script: server CPU/RAM utilisation over last 3 business days 6am-6pm
IN-209 | Task | Done | Security: MFA SMS sign-in abuse after a staff phone theft - lockdown
IN-210 | Task | In Progress | STOPR: Pro backup task "delete older than X days" fails "backup directory is invalid" on UNC share after NTLMv2-only hardening (parent ENG-1265)
IN-211 | Bug | In Progress | STSBHN: board SFTP (FileZilla) ECONNABORTED
IN-212 | Story | Backlog | Store self-hosted customer credentials in KeePass
IN-213 | Bug | In Progress | CCSD: high memory blocks RDP login (relates IN-111, ENG-2181, 2182, 2773, 2777, 2967)
IN-214 | Bug | Done | NLESD: users cannot log in to BP Pro
IN-215 | Bug | Backlog | Southland: slow server, cannot connect
IN-216 | Story | Backlog | SSRCE: can BP Web accounts with no roles be found and bulk deleted (2,600 accounts vs ~1/10 legitimate) (relates ENG-577)
IN-217 | Task | Done | Alberta servers' time zone fixed after Alberta stayed on UTC-6 (no fall-back) - CBE task did not run
IN-219 | Story | Backlog | SAPS: BP Pro stuck on "Configuring remote session" - Windows update fix
IN-220 | Bug | In Progress | CBE: all scheduled tasks failed on 11-03 after the server time change
IN-221 | Bug | Backlog | PRSD: Geotab reader stores GPS EventTime 60 min behind after Alberta time change (relates ENG-2971, IN-223..229)
IN-222 | Bug | Backlog | AACS: Quick Live GPS "Last update 1 hr ago" and hour-old ETAs after Alberta time change
IN-223..IN-229 | Task | Done | Geotab readers updated to 13.4.1.221 hotfix (ENG-2971) at PRSD, CESD, GSACRD, HPSD, PSD, SAPS, SPS
IN-230 | Task | Done | Client VPN: MSSQL unreachable after VPN server IP change
IN-231 | Bug | Backlog | HERTZ: BP Pro slow, users booted, GPS module disappears
IN-232 | Task | Backlog | Third offshore team RDP
IN-233 | Bug | Backlog | MDCPS: app server date/time randomly changed (3rd time this year)
IN-235 | Task | In Progress | Check Classic hosting servers for Brotli (CVE response; parent ENG-3036)
IN-236 | Task | Backlog | Confirm IBM managed ingress patched for a CVE (Unified; parent ENG-3036)
IN-237 | Task | Done | VPN access to new-world prod SQL for a staff member
IN-239 | Task | Backlog | Runbook for regional time-rule and server time-zone changes (follow-up to IN-221)

### SOC digest (all 71 issues, SOC-1..SOC-73; keys SOC-14, SOC-39 do not exist)
All SOC issues are Done (last resolved 2026-09-15). Audit period for change evidence: 2026-06-06 to 2026-08-30.
SOC-1..SOC-8 | Task | Done | Evidence requests: system/vendor inventory, M365-compliance tool (CEEL) integration, org chart, sample MSA, employment agreement, NDA, job description, visitor logs
SOC-9 | Task | Done | Non-monitoring controls (parent of SOC-10..12, 21, 22, 37, 38, 40-42)
SOC-10 / SOC-37 | Subtask | Done | SCC-350 separate test, developer and production environments (evidence: screenshots)
SOC-11 | Subtask | Done | SCC-25 architecture diagram
SOC-12 | Subtask | Done | SCC-220 log management with alerts
SOC-13, SOC-15, SOC-55, SOC-69 | Task | Done | Policy acknowledgement and review (code of conduct, password, infosec, acceptable use, incident response, change management, network security, logging/monitoring)
SOC-16 | Task | Done | Terms of Use
SOC-17, SOC-51 | Task | Done | Access reviews (initial, Q2)
SOC-18 | Task | Done | Phishing simulation
SOC-19, SOC-71, SOC-72 | Task | Done | On/offboarding checklists and evidence
SOC-20 | Task | Done | Public status page (UptimeRobot)
SOC-21 | Subtask | Done | SCC-55 board meetings
SOC-22, SOC-63 | Subtask/Task | Done | Quarterly vulnerability scanning (Field Effect)
SOC-23 | Task | Done | Monitoring controls (parent of SOC-24..33, 43..50)
SOC-24..SOC-33 | Subtask | Done | IBM Cloud IAM controls: access groups only, MFA, root account unused, unique accounts, removal within 24 h of offboarding, least privilege, API key rotation every 90 days, revoke keys unused 90 days, password min 12 chars, no reuse of last 10
SOC-34..SOC-36 | Task | Done | Vendor SOC 2 reports (accounting, IBM Cloud, project tool)
SOC-38 | Subtask | Done | "Code changes are tested": evidence = Jira ticket or PR showing testing AND approval by someone other than the author before merge/deploy
SOC-40, SOC-66 | Subtask/Task | Done | Intrusion detection (Field Effect)
SOC-41, SOC-56 | Subtask/Task | Done | Multiple availability zones / infrastructure redundancy
SOC-42 | Subtask | Done | "Test data used in test environment" (evidence screenshot)
SOC-43, SOC-65 | Subtask/Task | Done | Network access restrictions
SOC-44, SOC-68 | Subtask/Task | Done | TLS for admin/user sessions
SOC-45, SOC-60 | Subtask/Task | Done | Encryption at rest (IBM block storage)
SOC-46, SOC-62 | Subtask/Task | Done | Daily backup evidence (Duplicati, SQL schedule)
SOC-47, SOC-59, SOC-61 | Subtask/Task | Done | Monitoring and alerting configs (Pulseway, UptimeRobot, IBM Cloud Logs, Entra/Defender)
SOC-48, SOC-64, SOC-67 | Subtask/Task | Done | MFA and unique IDs (IBM Cloud, Azure DevOps/Jira, Microsoft IdP)
SOC-49, SOC-58 | Subtask/Task | Done | Version control evidence; branch protection policies in Azure DevOps
SOC-50 | Subtask | Done | Annual penetration test + remediation plan
SOC-52..SOC-54 | Task | Done | Incident-response tabletop (2026-06-25), post-IR, BC/DR scenario
SOC-57 | Task | Done | Role-based access (IBM IAM groups)
SOC-70 | Task | Done | Background checks for new hires
SOC-73 | Task | Done | List of all production code changes in the audit period, with the filter used

### MDP digest (6 issues)
MDP-1..MDP-6 | Idea | Parking lot | Jira Product Discovery template sample ideas (archived ideas, rewards program, express checkout, waiting list, refactor profile, VR travel). Not BusPlanner content; ignore.

### PROD digest (all 848 issues)
Format: KEY | type | status | what (+ ENG/SPT links). Products and Features first; then, per product, every non-Backlog item on its own line; Backlog Feature Requests are packed several per line as "KEY what" to stay within the line budget.

#### Products, Features and Epics (124)
PROD-52 | Epic | Done | CA-NS-AVRCE - Custom SQL View Request
PROD-94 | Epic | Done | CA-AB-PRSD - Undo Manual Student Scan in Turns Requester: Peace River
PROD-117 | Epic | Done | CA-QC-CSSBE – Request for new report
PROD-214 | Epic | Done | Trips SE: WICOMICO - Change Object Code to a Dropdown (ENG-719,ENG-721,ENG-722,ENG-723,ENG-724)
PROD-215 | Epic | Done | BP Quick - Yankton - Add ability generate QR code of Student ID (ENG-720)
PROD-229 | Epic | Done | US-NC-GCS (Guilford) - BUS PASSES ON BP WEB (format change request) (ENG-1496)
PROD-253 | Epic | Done | Driver Time Sheet — Dual-View Approval (PRD §3.5) (under PROD-330) (ENG-765)
PROD-274 | Epic | Done | Employees (T&A) (under PROD-330) (ENG-766)
PROD-275 | Epic | In Progress | Positions (T&A) (under PROD-330) (ENG-767)
PROD-276 | Epic | Done | Job Codes (T&A) (under PROD-330) (ENG-768)
PROD-277 | Epic | Done | Absence Types (T&A) (under PROD-330) (ENG-769)
PROD-278 | Epic | In Progress | Departments (T&A) (under PROD-330) (ENG-770)
PROD-279 | Epic | In Progress | Holidays (T&A) (under PROD-330) (ENG-771)
PROD-280 | Epic | In Progress | Locations / Geofences (T&A) (under PROD-330) (ENG-761)
PROD-281 | Epic | In Progress | Employee–Vehicle Assignment (T&A) (under PROD-330) (ENG-772)
PROD-282 | Epic | Done | Pay Periods (T&A) (under PROD-330) (ENG-773)
PROD-283 | Epic | In Progress | Pay Cycle Summary (T&A) (under PROD-330) (ENG-774)
PROD-284 | Epic | Done | Payroll Export (T&A) (under PROD-330) (ENG-4)
PROD-285 | Epic | In Progress | Audit Log (T&A) (under PROD-330) (ENG-762)
PROD-286 | Epic | In Progress | Overtime Monitoring (T&A) (under PROD-330) (ENG-763)
PROD-287 | Epic | In Progress | Settings — rounding & tolerances (T&A) (under PROD-330) (ENG-764)
PROD-288 | Epic | In Progress | Notifications (T&A, V2) (under PROD-330)
PROD-330 | Feature | On Hold | BP Unified: Time & Attendance (under PROD-676)
PROD-337 | Epic | Done | Map/Run Editor stop label: show equipment summary (Livingston/Prince George) (under PROD-331) (ENG-860)
PROD-397 | Epic | Backlog | Unified Login (under PROD-856)
PROD-424 | Epic | Done | BP Quick: Live Viewer Role for School Monitoring (ENG-1159)
PROD-459 | Epic | Backlog | Nash County T&A - Export and PDF (under PROD-859) (ENG-1523)
PROD-477 | Epic | Done | Chipmunk: Add show/hide password toggle (eye icon) on login and account creation
PROD-555 | Product | Backlog | Test product
PROD-670 | Product | Backlog | BusPlanner Finance (Contracts)
PROD-671 | Product | Backlog | BusPlanner Fleet
PROD-672 | Product | Backlog | BusPlanner GPS / GPS+
PROD-673 | Product | Backlog | BusPlanner Unified: GPS+
PROD-674 | Product | Backlog | Chipmunk - Tracker
PROD-675 | Product | Backlog | Delays App
PROD-676 | Product | Backlog | BusPlanner Unified: Time & Attendance
PROD-677 | Product | Backlog | BusPlanner Dispatch
PROD-678 | Product | Backlog | BusPlanner Quick
PROD-679 | Product | Backlog | BusPlanner Unified: Dispatch
PROD-680 | Product | Backlog | BusPlanner Unified: Chatbot
PROD-681 | Product | Backlog | BusPlanner Web
PROD-682 | Product | Backlog | BusPlanner Workflow
PROD-683 | Product | Backlog | BusPlanner Unified: Core Features and Infrastructure
PROD-684 | Product | Backlog | BusPlanner Turns
PROD-685 | Product | Backlog | BusPlanner Trips SE
PROD-686 | Product | Backlog | BusPlanner Pro
PROD-687 | Product | Backlog | BusPlanner Trips CE
PROD-688 | Product | Backlog | BusPlanner - Dev Questions
PROD-724 | Product | Backlog | Common Mobile Platform
PROD-777 | Epic | Backlog | [US-NY-STSI (Suffolk)] Planned first and last student times to cover the full run, irrespect... (under PROD-768)
PROD-802 | Feature | Backlog | [CA-ON-TSTG] Add "Geocode Errors" location for students with non-geocodable addresses (under PROD-686)
PROD-819 | Feature | Backlog | BP Unified: Chatbot - v2.0 (under PROD-680)
PROD-821 | Feature | Backlog | BP Pro: Tech Debt (under PROD-686)
PROD-822 | Feature | Backlog | Chipmunk - Tracker: Tech Debt (under PROD-674)
PROD-823 | Product | Backlog | BusPlanner Legacy (Old World) - Core features and Infrastructure
PROD-824 | Feature | Backlog | BusPlanner Core: Tech Debt (under PROD-823)
PROD-825 | Feature | Backlog | BP Unified: GPS+ - v1 (under PROD-673) (ENG-298)
PROD-826 | Feature | Backlog | BP Unified: GPS+ Vehicle Mapping (under PROD-673) (ENG-1196)
PROD-827 | Feature | To Do | BP Unified: GPS+ - Smart Mapping (under PROD-673)
PROD-829 | Feature | To Do | BP Unified: GPS+ - ETA Algorithm (under PROD-673)
PROD-831 | Feature | Backlog | BP Unified: GPS+ - Alerts (under PROD-673)
PROD-832 | Feature | Backlog | BP Unified: GPS+ - Path Compare Summary (under PROD-673)
PROD-833 | Feature | Backlog | BP Unified: GPS+ - On Time Reporting (under PROD-673)
PROD-834 | Feature | Backlog | BP Unified: GPS+ - Path Generation (under PROD-673)
PROD-835 | Feature | Backlog | BP Unified: GPS+ - Path Playback (under PROD-673)
PROD-836 | Feature | Backlog | BP Unified: GPS+ - Staff Manager (under PROD-673)
PROD-837 | Feature | Backlog | BP Unified: GPS+ - Bugs and General Items (under PROD-673)
PROD-838 | Feature | Backlog | BP Unified: GPS+ - Vehicle Manager (under PROD-673)
PROD-840 | Feature | Backlog | BP Unified: GPS+ - Customer Asks (under PROD-673)
PROD-841 | Feature | Backlog | BP Unified: GPS+: Plan vs Actual - v2 (under PROD-673)
PROD-842 | Feature | Backlog | BP Unified: Chatbot - Customer Asks (under PROD-680)
PROD-843 | Feature | Backlog | BP Unified: Dispatch - Customer Asks (under PROD-679)
PROD-844 | Product | Backlog | BP Unified: Admin Module
PROD-845 | Feature | Backlog | BP Unified: Admin Module - Settings (under PROD-844)
PROD-846 | Feature | Backlog | BP Unified: Admin Module - UI for Product Setups (under PROD-844)
PROD-847 | Product | Backlog | BP Unified: Discipline Module
PROD-848 | Feature | Backlog | BP Unified: Discipline Module - v1 (under PROD-847)
PROD-849 | Feature | Backlog | BP Unified: Discipline Module - Customer Asks (under PROD-847)
PROD-850 | Product | Backlog | BP Unified: Turns & Chipmunk <> New World
PROD-851 | Product | Backlog | BP Unified: Parent Experience
PROD-852 | Product | Backlog | BP Unified: Driver Experience
PROD-853 | Product | Backlog | BP Unified: Trips
PROD-854 | Product | Backlog | BP Unified: Fleet
PROD-855 | Feature | Backlog | BP Unified: Plan vs Actual (under PROD-683)
PROD-856 | Feature | In Progress | BP Unified: Foundation, Schema Setup, and Infrastructure Work (under PROD-683)
PROD-857 | Feature | Backlog | BP Unified: Tracker Algorithm (under PROD-683)
PROD-858 | Feature | In Progress | BP Unified: Time and Attendance Core (under PROD-676)
PROD-859 | Feature | In Progress | BP Unified: Time and Attendance - v1 (under PROD-676)
PROD-860 | Feature | Done | BP Unified (Mobile): Time and Attendance (under PROD-676)
PROD-862 | Product | Backlog | BusPlanner Performance Management
PROD-887 | Feature | Backlog | Chipmunk - Tracker: New Features (under PROD-674)
PROD-888 | Feature | Backlog | BP Pro: New Features (under PROD-686)
PROD-889 | Feature | Backlog | BusPlanner Turns: Bugs and General Tasks (under PROD-684)
PROD-890 | Feature | Backlog | BP Quick: Bugs and General Tasks (under PROD-678)
PROD-891 | Feature | Backlog | BusPlanner Finance: Bugs and General Tasks (under PROD-682)
PROD-892 | Feature | Backlog | Delays App: Bugs and General Tasks (under PROD-675)
PROD-893 | Feature | Backlog | BP Pro: Bugs and General Tasks (under PROD-686)
PROD-894 | Feature | Backlog | Chipmunk - Tracker Bugs and General Tasks (under PROD-674)
PROD-895 | Feature | Backlog | BP Quick: New Features (under PROD-678)
PROD-896 | Feature | Backlog | Delays App: New Features (under PROD-675)
PROD-897 | Feature | In Progress | BP Unified: Chatbot - v1 (under PROD-680)
PROD-898 | Feature | Backlog | BP Fleet: Bugs and General Tasks (under PROD-671)
PROD-899 | Feature | Backlog | BP Fleet: New Features (under PROD-671)
PROD-900 | Feature | In Progress | General Mobile Infrastructure (under PROD-724)
PROD-901 | Feature | Backlog | BusPlanner Workflows (under PROD-682)
PROD-902 | Feature | Backlog | BusPlanner Finance Contracts (under PROD-682)
PROD-903 | Feature | Backlog | BP Pro: Add Staff Binding for Finance Contract (under PROD-686)
PROD-904 | Feature | Backlog | Trips CE: Bugs and General Tasks (under PROD-687)
PROD-905 | Feature | Backlog | BusPlanner Dispatch: Bugs and General Tasks (under PROD-677)
PROD-906 | Feature | Backlog | Trips CE: New Features (under PROD-687)
PROD-907 | Feature | Backlog | BusPlanner Web: Bugs and General Tasks (under PROD-681)
PROD-908 | Feature | Backlog | BP Unified: Dispatch - v1 (under PROD-679)
PROD-909 | Feature | Backlog | BusPlanner Web: New Features (under PROD-681)
PROD-910 | Feature | Backlog | BusPlanner Dispatch: New Features (under PROD-677)
PROD-911 | Feature | In Progress | BP Unified: Chatbot - v1.5 (under PROD-680)
PROD-912 | Feature | Backlog | GPS / GPS+: New Features (under PROD-672)
PROD-913 | Feature | Backlog | Trips SE: New Features (under PROD-685)
PROD-914 | Feature | Backlog | BusPlanner Turns: New Features (under PROD-684)
PROD-915 | Feature | Backlog | Tracker Optimizations (under PROD-674)
PROD-916 | Feature | Backlog | GPS / GPS+ Bugs and General Tasks (under PROD-672)
PROD-917 | Feature | Backlog | Trips SE: Bugs and General Tasks (under PROD-685)
PROD-918 | Feature | Backlog | Dev Questions (under PROD-688)
PROD-938 | Feature | Backlog | BP Unified: Chatbot - Bugs (under PROD-680)
PROD-939 | Feature | Backlog | BusPlanner Core: Release Management (under PROD-823)

#### BusPlanner Pro (192)
PROD-2 | FR | Declined | [US-NC-GCS] - Route Directions Report
PROD-7 | FR | Done | CA-ON-OSTA - Student Report
PROD-61 | FR | Declined | CA-NB-GNB - Allow incident/accident entry and attachments on protected Staff without Admin rights
PROD-62 | FR | Declined | CA-ON-DSTS (Durham) - BP PRO - (request to have the average travel speeds calculated via the spee...
PROD-63 | FR | Declined | CA-NB-GNB - BP Pro - Dashboard Filtering Enhancements: Exclusion & “Not in Group” Support
PROD-74 | FR | Ready for Development | CA-ON-CTSE (CTSE)- BP Pro - Add Sub-Setting to Refine Driving Path Eligibility Calculation (ENG-196,ENG-2381)
PROD-79 | FR | Done | CA-QC-CSSBE - Bulk Available Stops by Student Group
PROD-92 | FR | Done | CA-ON-HPSTS - BP Pro - Update Custom Table
PROD-159 | FR | Ready for Development | CA-ON-STSBHN Integrating GeoTIFF Aerial Imagery
PROD-203 | FR | Done | US-FL-MDCPS (Miami) - Run string styling for runs requiring a bus aide or wheelchair (behind a se...
PROD-230 | FR | Scheduled | US-NC-GASTON - BP Pro: print one school boundary per page, masked, with readable street names
PROD-331 | FR | Done | Student equipment icons on maps (wheelchair, car seat, harness, walker, etc.).
PROD-340 | FR | Scheduled | [CA-ON-HSTS] As a client, I'd like a way to delete removed contacts when no replacement contact i...
PROD-393 | FR | Ready for Development | Add *.vrt to the Pro imagery open-file filter
PROD-394 | FR | Ready for Development | Fix on-the-fly overview handling for large raster mosaics in GEO_GdalDB
PROD-428 | FR | Ready for Development | [CA-NL-NLESD] - Auto Assignment to recognize run capacities.
PROD-434 | FR | Ready for Development | Bulk Report to Identify Eligible Bus Stops for a Group of Students
PROD-443 | FR | Ready for Development | LESA - Student Name Tags — Custom Report Changes
PROD-455 | FR | Done | US-FL-MDCPS - Run Descriptions with wheelchair & bus aide Request
PROD-480 | FR | Ready for Development | [US-MI-LESA] - Equipment icons/labels on Find Run/Route, Find Student & Student Listing (currentl... (ENG-2046)
PROD-481 | FR | Ready for Development | [US-MI-LESA] - Attendance report: sort/print alphabetically by last name + fix print cut-off (ENG-2047)
PROD-497 | FR | Ready for Development | Miami Run string styling for runs requiring a bus aide or wheelchair (behind a setting)
PROD-518 | FR | Declined | [CA-AB-CESD] - Government Report Request
PROD-519 | FR | Gathering Requirements | [CA-ON-STSYR (York)] - Verify classification list against ministry spec (ENG-2785)
PROD-533 | FR | Done | CESD Custom report: adapt Red Deer Public RDL with custom column order (ENG-2059)
PROD-550 | FR | Scheduled | [US-MD-PGCPS] - Map: display wheelchair (equipment) students with a distinct icon vs other students
PROD-552 | FR | Declined | [CA-ON-TLDSB] - Cancellation/Delay Ministry Report (ENG-2104)
PROD-562 | FR | Scheduled | MSDE - Maryland State Reports - Accident Report
PROD-563 | FR | Scheduled | MSDE - Maryland State Reports - Ridership Report
PROD-620 | FR | Scheduled | BP Pro - PGCPS - Color-coordinate runs with their stops and students on the map
PROD-621 | FR | Scheduled | BP Pro - PGCPS - Cluster stops: mark stops as cluster stops and show them with a distinct icon
PROD-622 | FR | To Do | BP Pro - PGCPS - Custom stop boundaries with lasso-to-assign students on the map
PROD-623 | FR | Scheduled | BP Pro - PGCPS - Show students on the map by selected address type
PROD-626 | FR | In Progress | [] TDTIMS Reports - NC DPI Requested Modifications for 2026 Reporting Cycle
PROD-632 | FR | In Progress | BP Pro - Show weather zone for each stop on the student record and in stop properties
PROD-644 | FR | Gathering Requirements | US-MD-PGCPS - Custom reports package () - 2 ad-hoc and 3 scheduled reports
PROD-700 | FR | Scheduled | MSDE - Maryland State Reports - Monthly Active Employee Report: setting to generate with or witho...
PROD-708 | FR | Done | [BPPro] Texas districts can't produce the monthly SHARS Medicaid transportation export from BusPl...
PROD-754 | FR | On Hold | [CA-ON-CTSO] - BP Pro: don't refresh/redraw the map on non-extent actions (highlighting a stop/st...
PROD-768 | FR | Done | [US-NY-STSI (Suffolk)] AM/PM Component Report - identify which run was late, with start and end t...
PROD-770 | FR | Scheduled | [US-MD-PGCPS] Automate Route Directions by Run distribution for changed runs each print cycle
PROD-778 | FR | Done | [US-NY-STSI (Suffolk)] Planned first/last student times should use full run span regardless of di...
PROD-790 | FR | Ready for Development | [US-MD-PGCPS] Audit trail for who enables or disables Enable route change logging in Pro
PROD-791 | FR | Done | [PGCPS]Audit log / change history for route changes (who deleted what, and when), plus ability to...
PROD-792 | FR | Ready for Development | Pro: “Number of Days Per Year” setting for Ontario reports is worded as if it takes a number, cau...
PROD-795 | FR | Scheduled | [CA-AB-CBE (Calgary Public)] - Track Met at Bus Changes in Student History BP Pro
PROD-814 | FR | Ready for Development | [US-MD-PGCPS] Run Directions Condensed: page breaks, first-page header, line-by-line directions a...
PROD-816 | FR | Ready for Development | BP Pro - PGCPS - Bulk edit stops into cluster stops
Backlog FRs (144):
- PROD-10 CA-AB CSCN Centre Nord Student Weight when creating a Sibling; PROD-14 Add Active Address Only Checkbox to Find Student Dialog; PROD-15 CA-ON OSTA Ottawa - Route Changes Report to include change/update o...; PROD-20 Edit Assigned Driver to Route
- PROD-22 CA-NB-GNB - Add Scan Card field in Find Student search; PROD-23 CA-ON-WESTS - Update Operator view of Student Contact Details - Rem...; PROD-25 CA-ON-WESTS - Enable “Show Future Transportation” in Export Manager...; PROD-26 US-GA-BCS | Request to Automate process of deleting student not inc...
- PROD-36 CA-AB-RVS - Global search for transported students without seat ass...; PROD-39 In Bus Planner Pro - It would be nice to be able to apply more filt...; PROD-41 As a Transportation Manager, it would be nice to have more granular...; PROD-48 In Bus Planner Pro, It would be nice to be able to sort the vehicle...
- PROD-54 CA-NB-GNB - Allow incident/accident entry and attachments on protec...; PROD-55 CA-ON-DSTS (Durham) - BP PRO - (request to have the average travel ...; PROD-56 CA-NB-GNB - BP Pro - Dashboard Filtering Enhancements: Exclusion & ...; PROD-64 CA-AB-BRSD - Allow full-length or configurable character limits in ...
- PROD-66 CA-AB-RDCRS - BP Pro - Attendnace Sheet Custom Report; PROD-73 Add a feature flag to let the client choose between "Arrival" time ...; PROD-75 CA-AB-RVS - Usability and Insight Enhancements for Students and Routes; PROD-84 US-NY-STSI - BP Pro - Request for New Query / Report
- PROD-86 CA-AB-RVS - Add Ctrl + Snap-to-Points behavior to Streets Edit/Add ...; PROD-89 Add option to Student Summary on BP Pro; PROD-90 Introduce Text Wrapping on Equipment Details; PROD-96 Have an option to have Instruction updates in BP Pro, trigger notif...
- PROD-100 CA-AB-ECSD - New Run/Component Type for Weekly Early Dismissal (e.g...; PROD-101 US-MD-CALVERT - Calvert - BP Pro - Create report that allows extrac...; PROD-102 CA-AB-GPCSD - BP PRO - Enhancement Request – Route Manager Comments...; PROD-105 CA-ON-TSTG - BP Pro - Add New Filter to Student Listing Report
- PROD-106 CA-ON-STSYR - BP Pro - Create Option to 'Remove' Student Fields Fro...; PROD-107 CA-AB-FMPSD - SQL Query Request – Transported Students by School by...; PROD-109 CA-AB-SAPS - Add ability to search by Bus Pass Number in BusPlanner...; PROD-110 VP-ON-LCHS (London Christian High) - BP Pro - bulk update Bus Stop ...
- PROD-114 CA-ON-TBSTS (Tri-Board) - BP PRO - Dark Mode Functionality; PROD-127 CA-NL-NLESD - Feature request - custody calendar integration; PROD-129 CA-AB-SAPS - Pro/web/Turns - Feature request for field in BPPro; PROD-130 CA-ON-FBUS – Comment Box/ Field on Run Editor and Route Manager
- PROD-132 CA-NS-SSRCE (South Shore) - BP Pro - Turnaround feature request; PROD-135 New Dashboard - To Identify Students With Retiring Transportation Date; PROD-140 CA-ON-STSCO (Peterborough) - BP Pro - disable Met at bus flag updates; PROD-143 CA-ON-DSTS - Add Dark Mode/theme option to BusPlanner Pro
- PROD-148 CA-AB-CSCN - Display Pop-up warning to notify the user of changes t...; PROD-151 CA-ON-STSTB - BusPlanner Pro - Allow for a Watermark Option On Map; PROD-152 US-MI-LESA - BusPlanner Pro - Request for More File Export Options ...; PROD-153 CA-SK-First (First) - BP PRO - enhancement to the geocode address s...
- PROD-154 CA-SK-HZSD (Horizon SD) - BP Pro - Added "Driver Name" field in rou...; PROD-155 CA-ON-TSTG - Option to append Comment (or selected field) to auto-g...; PROD-157 US-MD-PGCPS - Alternate Address Display; PROD-164 CA-AB-CBE - BP PRO - way to bulk remove School Alternate IDs and or...
- PROD-165 CA-ON-CLASS - Adding a Stop to a Paired Run; PROD-166 StreetGUID Import Tool for BP Maps; PROD-171 CA-AB-CSCN - Pro - live Vs Planned database; PROD-177 CA-ON-STSYR (York) - Pro - Exception Color Customization
- PROD-181 CA-ON-STSYR (York) - BP Pro - postal codes for bus stops; PROD-182 Staff Report – Extended Properties with Expiry Date Support (Maryla...; PROD-185 CA-ON-TBSTS - BP PRO - Address Eligibility Search improvement (narr...; PROD-186 Route Report - Multiple contact numbers for students w/ multiple stops
- PROD-191 CA-AB-CBE (Calgary Public) - BP Pro - efficient way to calculate el...; PROD-192 CA-ON-STSYR (York) - BP Pro - street labels missing on route summar...; PROD-193 Have the ability to use something other than "Walker"; PROD-199 CA-NS-SRCE - Annual KMS per Run/Route/Vehicle Report Request
- PROD-201 CA-NS-CSAP (CSAP) - BP PRO - Road Closure - Start and End date feat...; PROD-226 CA-ON-CTSO (CTSO) - Bug Report- Home Room; PROD-233 CA-AB-RVS - Review Eligibility itemized changes made by the Student...; PROD-236 ZD Ticket - CA-SK-First (First) - BP UI Request
- PROD-237 [CA-NB-GNB] - Vehicle Manager Report; PROD-240 [CA-AB-RVS] - Mail Auto-Formatting; PROD-241 CA-ON-HSTS (Halton) - Student Properties - Make Equipment Box Expan...; PROD-242 [CA-NL-NLESD] - Student Update Setting
- PROD-245 [CA-AB-CBE] - BusPlanner Pro Logging; PROD-249 [CA-AB-EPSB] - Date Format Setting; PROD-332 [CA-ON-TSTG] Add Travel Time column to Student Listing report; PROD-334 [] [CA-ON-OSTA] Route reports should have an option to always displ...
- PROD-339 [CA-AB-ECSD] Uncheck Filters by Default in Find Student; PROD-341 [CA-AB-RVS] Add a setting or tooltip to prevent users from accident...; PROD-343 CA-AB-ECSD - BP PRO feature request (report); PROD-395 CA-SK-First (First) - BP Pro Feature Request (BP Tasks Reports)
- PROD-419 [CA-AB-CCSD] Find students on different routes AM vs PM; PROD-423 US-FL-MDCPS (Miami) - Simple Text Query; PROD-425 [] [CA-ON-HSTS] - Run Directions Feature Request; PROD-427 [US-FL-MDCPS] - Bulk Run Update (ENG-749)
- PROD-438 [US-NY-STSI] Provide a way to bulk update the Effective/Retire date...; PROD-446 CA-ON-WDSTS - Feature Request (Remove Vehicle ID from Reports); PROD-447 Bus Stop Listing FEATURE REQUEST; PROD-452 BP Pro - Map/screen refreshes on every action while working
- PROD-456 [CA-ON-STSCO] Limit Operators from seeing old route changes; PROD-457 CA-NS-HRCE - export format be fixed or customizable to select neede...; PROD-472 CA-ON-TBSTS - New "for selected students" box on Find Student tool ...; PROD-478 [US-NY-STSI (Suffolk)][] Route Details Condensed Report
- PROD-482 CA-ON-OSTA - Display Route Directions in KM; PROD-483 [US-MD-PGCPS] Locate multiple students using a non-"Home" address type; PROD-484 [CA-ON-OSTA] - Increase Alert Field Character Limit in BP Pro Exten...; PROD-492 [US-GA-BCS (Buford)] - Options for Spec Ed Transportation on Regula...
- PROD-494 [66929/52487][TSTG] As a client, I'd like an easier way to; PROD-501 US-MD-PGCPS - BP Pro — Assign Students to Nearby Stops: add per-stu...; PROD-505 [US-MD-PGCPS] Do not show changes made by geoadmin in Find Route Ch...; PROD-506 [US-FL-SDCC] Add the bus (vehicle number) and Route ID/name to Stud...
- PROD-508 [STSTB-Thunder Bay] As a user, Id like more clarity on why students...; PROD-513 [CA-ON-TBSTS (Tri-Board)] - School Name Shown In Report Option; PROD-520 [US-FL-SDOC (Osceola)] - Requesting Effective and Retire Date to Sh...; PROD-522 [CA-AB-RVS (Rocky View)] - Feature Request for Better Historical Tr...
- PROD-530 [US-MD-SMCPS] - Calculate walk-to-stop distance from private/public...; PROD-534 CA-AB-PSD - 70913 - Pro or Web - Student Scan IDs; PROD-535 [US-NY-STSI] - Separate Access Levels for BP Pro and Maps; PROD-539 CA-ON-OSTA (OSTA) - BP PRO Student Report limited contact filters
- PROD-542 BusPlannerPro Dashboard by District Filter request; PROD-543 [CA-ON-CLASS] - Route Change Email Customization; PROD-571 [CA-ON-STC (STC)] - Undo Button; PROD-572 [CA-AB-CBE (Calgary Public)] - Add RoutePoint File Option for Extra...
- PROD-573 [CA-ON-FBUS] Auto-set serviced schools when creating a new stop fro...; PROD-577 [CA-YT-YDE] - Route Summary by Route Custom Format; PROD-578 [CA-ON-ENROUTE] - Report Font Size Setting; PROD-579 US-FL-MDCPS (Miami) - 69490 - Pro - School Closure Planner
- PROD-580 CESD - 72683 - Pro - Map Labels; PROD-582 [VP-ON-WCHS (Woodland)] - Warning/Notice when Student's are Added t...; PROD-590 [CA-ON-HSTS] - Invalid Ride Time Logic; PROD-591 [US-MD-PGCPS] - Alternate Address Change Tracking
- PROD-595 [CA-AB-SPS] - Add Contact 1 and Contact 2 Phone numbers in Run Mani...; PROD-599 [CA-ON-TSTG (Toronto)] - Mass Update Feature for Bus Stops; PROD-602 US-FL-SJCSD (St. Johns) - Route Daily Drive Time Change Log; PROD-603 CA-ON-NETBST - Allow Excel upload for custody calendars
- PROD-613 CA-ON-CTSO - BP Pro - Run Editor access from Transfer dialog and al...; PROD-614 [CA-NS-HRCE] - Route Change Notifications: log & notify on run move...; PROD-624 BP Pro - PGCPS - Personalized layout (needs scoping); PROD-625 BP Pro - PGCPS - Routing large numbers of students within bus capac...
- PROD-629 CA-ON-STOPR - Transport details and a map for an individual; PROD-652 US-MI-LESA | BP Pro | Uncheck Gen ed status on mass; PROD-669 [CA-ON-STOPR] Provide live access to OpenstreetMaps data in BP Pro; PROD-693 CA-ON-STSBHN (Brantford) - - BP Pro - Export all school contacts (n...
- PROD-702 [BPPro] Texas districts can't produce the TEA Route Services and Op...; PROD-706 [BPPro] Districts can't print labeled, color-coded attendance bound...; PROD-716 [US-MD-PGCPS] - Bulk remove equipment; PROD-723 [US-FL-MDCPS] - BP Pro or Maps - Add an option Run ID font size
- PROD-752 [] [CA-MB-ESD] Hosted clients can't print large-format maps (24x30,...; PROD-753 [CA-ON-CTSO] Make stop numbers match between Pro and Route reports; PROD-769 [CA-ON-CTSO] Object Information: add "Home Room" as an option when ...; PROD-772 Student Update Report
- PROD-789 [US-MD-PGCPS] Audit trail for who enables or disables \"Enable rout...; PROD-797 [CA-ON-STEO] [BPPro] Student update imports bad SIS data without wa...; PROD-800 CA-ON-WESTS (Windsor) - [BPPro] Ontario Ministry Routes report can'... (ENG-2536); PROD-804 [CA-ON-WESTS (Windsor)] - BP Pro: add AM/PM option when setting stu...
- PROD-805 [CA-ON-WESTS (Windsor)] - BP Pro: find route changes on a selection...; PROD-810 [CA-SK-FIRST (First Student)] - BP Pro - Focus GPS Stop Points expo...; PROD-818 – CA-SK-First – BP Pro: Add CSV file type to GPS Stop Points File s...; PROD-820 [CA-NS-AVRCE] Pro: Show and search depots by selected routes, runs ...

#### BusPlanner Web (124)
PROD-43 | FR | Ready for Development | CA-AB-CBE | Request to highlight Certain fields in Run/Route Reports
PROD-228 | FR | Scheduled | BP Web- Add 'Send email to School User Only' to School Alerts and General Alerts
PROD-335 | FR | Done | [CA-ON-WESTS] - SQL Query Request
PROD-435 | FR | Ready for Development | [STSTB] Changes to Alert Logic
PROD-473 | FR | Done | Want Standard Users to access Staff Manager
PROD-486 | FR | Ready for Development | Make busplanneraddupdate.txt authoritative for adds, removals & location updates (UGDSB BP Web pr...
PROD-487 | FR | Ready for Development | Key BP Web professional user identity on employee number instead of email (UGDSB SSO)
PROD-507 | FR | In Progress | [US-MD-PGCPS] - Student Listing - Student ID option
PROD-547 | FR | Scheduled | [US-MD-PGCPS] - BP Web: Parent Notification Letter — generate & send letters to parents, selectab...
PROD-564 | FR | Scheduled | BP Web- Route Reports - Option to list weather zone for each bus stop
PROD-565 | FR | Scheduled | BPWeb-Parent Portal - Option to list weather zone for each assigned bus stop
PROD-566 | FR | Scheduled | BPWeb- Create report that lists students in each weather zone by on stop assignment
PROD-592 | FR | Ready for Development | OSTA - 73477 - Web/Pro - Enrollment schedule search in Find Student
PROD-596 | FR | Declined | US-MD-PGCPS - BP Web - Wants a custom import
PROD-612 | FR | In Progress | BP Web & Quick - US-MD-PGCPS - New "Run Directions Condensed" run sheet report with selectable pr...
PROD-631 | FR | Done | [US-MD-PGCPS (Prince George's)]- Ridership Report
PROD-633 | FR | In Progress | BP Web - Transportation Alerts - Show Component Type (AM/PM) when posting an alert for a zone
PROD-713 | FR | Declined | [STSTB][Alerts] Multi-day bus cancellations disappear from parent apps overnight before the cance... (ENG-2466)
PROD-714 | FR | Declined | [STSTB]Families receive a repeat notification every morning for a multi-day cancellation they've ... (ENG-2466)
PROD-715 | FR | Declined | [CA-ON-STSTB]Expired alerts stay on the Post Transportation Alerts page and have to be deleted ma... (ENG-2466)
PROD-782 | FR | Done | [CA-ON-TSTG][BP Web] Parents can't check eligibility for an LocationID on BP Web
Backlog FRs (103):
- PROD-4 ca-ab-ecsd | BusPlanner Web | Route Change Reports; PROD-6 Report - Street Properties by Route/Run Report; PROD-9 new report on web for operators; PROD-12 General Notifications - Give parents choice which Weather Zone to s...
- PROD-13 CSCN - BP WEB PARENT EMAIL CHANGE PERMISSION; PROD-18 CA-ON WDSTS Wellington-Dufferin | Pausing Email Notifications in BP...; PROD-28 CA-ON-TRIBOARD - Student Portal Login Request; PROD-29 CA-AB-CSCN - BP Web - Add option to show names of emergency contact...
- PROD-32 US-FL-PASCO - Bus Planner Web - Additional Reporting Functionality; PROD-35 CA-NB-GNB - Bus Planner Web Suggestion - In the Staff Manager, It w...; PROD-40 As a Parent, I'm unable to see all columns needed on mobile while r...; PROD-42 For MFA, It would be nice to be able to configure the default 4 min...
- PROD-44 Posting Alerts By Zone Improvement; PROD-50 Professional Users get General Notice; PROD-65 CA-NB-GNB | Automated task for Cache update BP Web; PROD-67 As a Parent - I would like Expired Notifications to be more clear i...
- PROD-68 Parent Portal - Show bus route, driver name and bus character; PROD-69 CA-ON-HSTS (Halton) - BP Web - Allow BP Web Professional Users to s...; PROD-72 CA-ON-HSTS - Allow Notifications to send to other operators; PROD-80 CA-ON-TSTG - Unique Identifier for Alerts with Reason = Accident (a...
- PROD-83 CA-NB-GNB - BP WEB - display the reason to public subscribers for B...; PROD-85 As a Client with a large number of Subscribers, I would like more v...; PROD-87 CA-NS-CSAP (CSAP) - BP WEB - Where's my bus issue - setting that al...; PROD-91 CA-AB-CSCN - BP Web - Add POPA Requirements to Route details by Rou...
- PROD-98 CA-AB-ECSD - Configurable placement (or centered default) for Schoo...; PROD-99 CA-NL-NLESD - BP Web subscribers- identify subscribers without chil...; PROD-113 CA-ON-HSTS - Component Type Filter; PROD-118 CA-ON-STSTB - Post a Targeted Notice Page - Allow for run selection...
- PROD-119 CA-AB-GYPSD - Extend Alert Scheduling with Calendar Picker for Futu...; PROD-126 CA-SK-PVSD - BP Web - Which School do I Attend? Edit/Copy the same ...; PROD-128 CA-NB-GNB – Address Eligibility API Request; PROD-133 CA-NS-CCRCE – BP Web – Alert Listing Report Output Format on Save
- PROD-134 CA-AB-ECSD - Clarify ETS vs Yellow Bus eligibility messaging; PROD-136 CA-ON-STSCO (Peterborough) - Web - Multiple feature requests; PROD-138 CA-NS-CSAP - Which School Do I Attend – Treat blank Program as “No ...; PROD-147 CA-AB-CSCN - “View as Parent” button in BusPlanner Web for school s...
- PROD-160 CA-NS-CCRCE - Add “Subscriber” as a User Role in BusPlanner Web to ...; PROD-163 CA-AB-BGRS - Shortest driving distance - "Can I Ride a Bus?" page; PROD-167 US-MD-PGCPS - Add Student Instruction field to Route Directions by ...; PROD-170 Transportation Alert settings — default checkbox selection
- PROD-174 BP Web - Option to set more than one top-priority contact for Emerg...; PROD-178 US-FL-SJCSD (St. Johns) - BP Pro/Web - Check out time reflected in ...; PROD-188 CA-ON-STSCO (Peterborough) - BP WEB - Issues with Select Database f...; PROD-195 US-FL-SJCSD - BP Web - BP Web ESE Filtering
- PROD-200 CA-ON-TSTG - Ridership Report in Web; PROD-227 CA-ON-STSBHN (Brantford) - BP Web adjustment of "school year" location; PROD-231 CA-ON-CTSO (CTSO) - BP Web - Dropdown prompts you to select a db on...; PROD-234 CA-SK-HERTZ-SASK (Hertz Southland Saskatoon) - Doubled routes
- PROD-248 CA-ON-STSTB - Web - have alerts that post as always delete after th...; PROD-333 [CA-ON-STSCO]Allow admins to lock/hide Posting Alert recipient-skip...; PROD-433 CA-ON-STEO - Pro - Allow portal access - confidential students and ...; PROD-439 [CA-AB-AVPS] - Select Student IDs and Send Targeted Messages throug...
- PROD-440 CA-AB-PSD - Web - Report format change (ENG-1224); PROD-445 CA-ON-WESTS (Windsor) - Hover tooltip on programs; PROD-474 CA-ON-OSTA (OSTA) - Change the Distance Mileage to KM in BP Web; PROD-493 [CA-AB-RDPSD (Red Deer Public)] - Update Title for Can I Ride A Bus
- PROD-500 CA-NL-NLESD - One-Time Subscriber Account Export request; PROD-509 [CA-ON-TBSTS (Tri-Board)] - C&D export filename format (CANCEL vs C...; PROD-510 [CCSBE] As a client, I'd like a way to force all subscribers to rec...; PROD-511 [CSSBE] As a client, I'd like a window of time I can prevent Emails...
- PROD-514 [STEO] As a web admin, I'd like to have a role that can create and ...; PROD-524 [CA-ON-TSTG] - BP Web: annual subscriber account re-authentication ...; PROD-525 [CA-ON-NSTS] As an API, I should return Vehicle VIN# field when cal...; PROD-536 BP Web - Parent portal account creation - account already exists me...
- PROD-544 CA-ON-STSCO - Bus Operator Manager to receive all Alert Posting ema...; PROD-546 [CA-NL-NLESD] - Prevent User Roles from seeing Future Transportation; PROD-574 [CA-ON-WDSTS] Warn users when they pick the wrong Duration when pos...; PROD-581 CA-AB-PSD - BP Web - Alerts email changes
- PROD-583 PSD - 71662 - Alerts - add CC option on alert emails; PROD-586 Would like to be able to archive Reason types; PROD-589 [CA-ON-WESTS (Windsor)] - Setting Request to Have Include Effective...; PROD-593 CA-ON-TSTG - 70629 - Alerts - School - All Clear
- PROD-594 [CA-ON-TSTG] - Add a setting to set the default numbers of rows; PROD-597 [CA-AB-ECSD] - Add Approvals for Alerts Posted; PROD-607 US-FL-SDCC - BP Web - Active status for students when scanning; PROD-609 CA-ON-STOPR | Automate cancellation and delay report (ENG-2041,ENG-2104)
- PROD-610 CA-QC-CSSBE - BP Web - Printer Friendly Reports; PROD-611 CA-ON-HWSTS (Hamilton) - - Reports Route Directions and Load Times; PROD-616 [CA-ON-TSTG] - BP Web - Subscriber Report; PROD-617 [CA-QC-CSSBE] - BP Web - French Translation Corrections for Route C...
- PROD-628 [CA-ON-STSTB] Add Web setting for default checked/unchecked state o...; PROD-640 [CA-ON-STSTB] - Medical Detail / Alert and Needs; PROD-643 [CA-ON-WESTS (Windsor)] - Show "Out of Boundary" message in Can I R...; PROD-651 [BPWeb] Schools can't print and RFID-encode student ID cards in one...
- PROD-666 [US-MD-WCPS] - Target Notice for Parents without Students; PROD-694 CA-ON-SWOSTS (London) - - Multi-language support / translation for ...; PROD-709 [CA-ON-TLDSB] BP WEB - Admins can't retire a delay reason type once...; PROD-722 Web - Request to remove medical details from route change reports
- PROD-727 [CA-AB-SPS] - BP Web - Student Listing: show home bus and transfer ...; PROD-728 [BPWeb] Districts spend days hand-scoring driver license violations...; PROD-740 [BPWeb] Dispatch has to write parent alerts from scratch and can't ...; PROD-746 [BPWeb] Students without their bus pass have to be looked up by han...
- PROD-750 [BPWeb] Campus staff can't see when their buses will arrive at scho...; PROD-765 US-MI-LESA (Livingston) - [BPWeb] Drivers can't see student grade, ...; PROD-773 [CA-ON-ETBTC] - BP Web: Cancellation/Delay report CSV shows Reason ...; PROD-775 OSTA - 73477 - Web/Pro - "Other" enrollment schedule option in Set ...
- PROD-776 HSTS - BP WEB - Staff can't export a seating chart to PDF from the ...; PROD-786 [CA-ON-TSTG] - Automatically enable “Receive Email” when a subscrib...; PROD-787 [CA-AB-CBE] - Add logging/audit trail showing which user (or proces...; PROD-788 CA-ON-HSTS (Halton) - [BPWeb] Districts can't notify families and s...
- PROD-794 [CA-ON-NPSSTS] BP Web – Parent Portal: allow subscribers to choose ...; PROD-803 [CA-ON-WESTS (Windsor)] - BP Web: apply ShowStudentEffectiveDate_Ag...; PROD-813 CA-ON-WESTS (Windsor) [BPWeb] Parents can't tell which weather zone...

#### (no parent) (67)
PROD-460 | Story | Backlog | [Time Card · PDF] Per-driver signature timesheet (PDF export) (ENG-1524)
PROD-461 | Story | Backlog | [Time Card · PDF] Configurable PDF template per client (not V1) (ENG-1525)
PROD-462 | Story | Backlog | [Time Card · Filters] Positions filter (multi-select) (ENG-1526)
PROD-463 | Story | Backlog | [Time Card · Filters] Departments filter (multi-select) (ENG-1527)
PROD-464 | Story | Backlog | [Time Card · Dates] Work-week + custom date range selector (ENG-1529)
PROD-465 | Story | Backlog | [Time Card · CSV] Grid-dump CSV export (ENG-1530)
PROD-466 | Story | Backlog | [Time Card · CSV] Export chooser (CSV/PDF) + fix current redirect (ENG-1531)
PROD-467 | Story | Backlog | [Payroll Export] Step 1 — pay period + custom date range (ENG-1532)
PROD-468 | Story | Backlog | [Payroll Export] Step 2 — add filters to the review grid (ENG-1533)
PROD-469 | Story | Backlog | [Payroll Export] Generate payroll file — LINQ scan-pair CSV (ENG-1534)
PROD-470 | Story | Backlog | [Payroll Export] Show a client only their own export format(s) (ENG-1535)
PROD-471 | Story | Backlog | [Payroll Export] Configure which exports a client can use (not V1) (ENG-1536)
PROD-479 | Story | Done | Show/hide password toggle (eye icon) on Chipmunk login and account creation (ENG-1548)
PROD-499 | Story | Backlog | BP Unified: Time & Attendance - Driver Time Card — driver stepper navigation & toolbar control fixes
PROD-919 | Story | Backlog | [CA-AB-SAPS] BP Web Workflow: completed bus pass replacement requests show no completed-by user o...
PROD-923 | FR | Done | TDTIMS Report Needed
PROD-928 | FR | To Do | [CA-ON-STOPR] - Find Route: search slack between individual run pairs, not just component totals
PROD-929 | FR | Gathering Requirements | [CA-ON-STOPR] - BP Finance – Prorate run costs by effective date when a run moves between routes/...
PROD-943 | FR | To Do | BP Pro - US-MD-PGCPS - Toggle a Google Maps or OpenStreetMap layer over the map to show missing s...
Backlog FRs (48):
- PROD-863 [Fleet] Deferred repairs sit on separate work orders, so a bus has ...; PROD-864 [Fleet] Techs have to leave the work order to see a bus's repair hi...; PROD-865 [Fleet] The shop isn't alerted when a bus opened for repair is stil...; PROD-866 [Fleet] Parts staff aren't warned when a part was bought cheaper fr...
- PROD-867 [Fleet] Superseded part numbers don't carry the old part's history ...; PROD-868 [Fleet] Techs aren't flagged when a part they're installing carries...; PROD-869 [Fleet] Supervisors can't see all open work orders and which techs ...; PROD-870 [Fleet] Part photos are stored as attachments and don't display in ...
- PROD-871 [Fleet] Fuel from three sources has to be loaded by hand, so fuel n...; PROD-872 [Fleet] EV battery and telematics data is spread across 5 to 6 sepa...; PROD-873 [Fleet] POs cut in the district's purchasing system would have to b...; PROD-874 [Fleet] The shop can't pull which parts went on which vehicles over...
- PROD-875 [Fleet] A bad mass change can't be rolled back quickly; PROD-876 [Trips] Dispatcher can't narrow driver picks by availability, neare...; PROD-877 [Trips] A driver's regular route bus doesn't carry over to their fi...; PROD-878 [Trips] The trip calendar can't be filtered by status, so the dispa...
- PROD-879 [Trips] Drivers aren't reminded when a digital trip sheet hasn't be...; PROD-880 [Trips] Driver bidding can't follow Beaverton's rule of offering tr...; PROD-881 [Trips] Transportation can't look up past trips by who requested th...; PROD-882 [Trips] Trip requests don't capture the contact teacher's phone and...
- PROD-883 [Trips] Requesters can't choose a budget number when they submit a ...; PROD-884 [Trips] Requesters can't flag a budget number that isn't set up in ...; PROD-885 [Trips] Fields the district never uses can't be hidden from trip sc...; PROD-886 [Trips] Trip charges can't be set by activity type and budget number
- PROD-920 [CA-ON-WDSTS (Wellington-Dufferin)]- UI for Managing Parent 2FA; PROD-921 BP Pro - Show student home address with pickup and drop-off stops o...; PROD-922 BP Pro - US-MD-PGCPS - Decouple Student ID Import from the Database...; PROD-924 [BPPro] Bi-Weekly Attendance Sheet report changes – LESA Pinckney
- PROD-925 84901 [BPPro] Allow line breaks in bus stop Instructions field – LE...; PROD-926 84901 [BPPro] Include deadhead directions in HTML Run Directions re...; PROD-927 [CA-AB-CESD] Attendance Report – show transfer scan-off, use prefer...; PROD-930 CA-ON-OSTA - [BPPro] Effective-date delays count stat holidays as w... (ENG-2540,ENG-1988)
- PROD-931 [BPPro] Planners must apply Run Optimize Analysis results one run a...; PROD-932 [CA-ON-WESTS] - BP Pro – Equipment map icons: set a standard colour...; PROD-933 [Fleet] Shop supervisors can't see repeat repairs for one shop or o...; PROD-934 [Fleet] Technicians aren't warned about a repeat repair while they ...
- PROD-935 [Fleet] Supervisors can't review and sign off on work orders that o...; PROD-936 [Chipmunk] Riders get no alert when their bus is swapped for the da...; PROD-937 [BPPro] Service coordinators can't tell waypoints apart from bus st...; PROD-940 [CA-ON-WDSTS] – New run type for late runs in BP Pro
- PROD-941 CA-ON-WESTS (Windsor) [BPWeb] Transportation staff receive AI-infla...; PROD-942 [US-FL-MDCPS] BP Web – Student Listing / Student Transportation Lis...; PROD-944 [BPWeb] Parents with children at different schools get the same tar...; PROD-945 [Workflow] Users can't filter the Work List by school and must open...
- PROD-946 [BPQuick] Routers can't flag a student as special ed when adding th...; PROD-947 [BPQuick] Routers can't change bus stop frequency in Quick; PROD-948 [BPQuick] Routers can't create or copy variations at the stop level...; PROD-949 [BPQuick] Route Condensed report isn't available in Quick

#### BusPlanner Unified: Time & Attendance (67)
PROD-254 | Story | Done | Shift view scaffold + segmented view toggle (Shift ↔ Calendar)
PROD-255 | Story | Done | Shifts table — one row per planned shift (Planned | Actual | Δ | Status)
PROD-256 | Story | Done | Δ tolerance pills + status icons (backend-configured tolerance)
PROD-257 | Story | Done | Inline editing of actual times, job code & vehicle
PROD-258 | Story | Done | Multi-punch data model — one planned shift ↔ N actual punches (backend)
PROD-259 | Story | Done | Multi-punch rendering in the shifts table
PROD-260 | Story | Done | Add clock-in global modal with live match preview
PROD-261 | Story | Done | Driver queue + Approve & next, with approve-only sticky footer
PROD-262 | Story | Done | Stats grid — Planned, Actual, OT, Net Delta, Status
PROD-263 | Story | Done | Variance-by-job-code table
PROD-264 | Story | Done | Work-week stepper (work-week-snapped)
PROD-265 | Story | Done | Absence rows & day-level holiday decoration in Shift view
PROD-266 | Story | Done | Remove reject/disapprove from Calendar view (approve-only)
PROD-267 | Story | Done | Backend — retire shift reject; time-card approve-only + frozen-on-export
PROD-268 | Story | Done | Remove delete-shift action; corrections via edit-to-zero only
PROD-269 | Story | Done | Reconcile PRD §3.5 footer — remove &quot;Reject&quot; to match approve-only
PROD-270 | Story | Done | Add Absence modal — type, date, duration & notes
PROD-271 | Story | Done | Half-day absence with time-window selection
PROD-272 | Story | Done | Multi-day absence entry (date range)
PROD-273 | Story | Done | Remove / undo absence — full, per-day, or partial
PROD-289 | Story | Done | Employees list & CRUD — verify against PRD
PROD-290 | Story | Done | Employee custom properties
PROD-291 | Story | Done | Employee ↔ department cardinality rules
PROD-292 | Story | Done | Employee import — configuration & warnings
PROD-293 | Story | In Progress | Positions CRUD — verify against PRD
PROD-294 | Story | In Progress | Position → Job Code eligibility mapping
PROD-295 | Story | In Progress | Position ↔ holiday applicability
PROD-296 | Story | Done | Job Codes CRUD — verify against PRD
PROD-297 | Story | Done | External pay-code mapping
PROD-298 | Story | Done | Job code edit restrictions — locked-once-referenced
PROD-299 | Story | Done | Absence Types CRUD — paid/unpaid designation
PROD-300 | Story | In Progress | Departments CRUD — verify against PRD
PROD-301 | Story | In Progress | Department ↔ pay-period association
PROD-302 | Story | Done | Holidays CRUD & calendar — verify against PRD
PROD-303 | Story | In Progress | Holiday credit calculation
PROD-304 | Story | Done | Position-scoped holiday applicability
PROD-305 | Story | In Progress | Locations CRUD (ENG-775)
PROD-306 | Story | In Progress | Geofence configuration (independent clock-in/out) (ENG-776)
PROD-307 | Story | In Progress | Employee ↔ vehicle assignment
PROD-308 | Story | In Progress | Bulk assignment operations
PROD-309 | Story | In Progress | Unassigned Employees microapp
PROD-310 | Story | Done | Pay period configuration & lifecycle
PROD-311 | Story | Done | Pay period auto-generation (Year-Start Wizard & cycles)
PROD-312 | Story | Done | Department-level pay-period overrides
PROD-313 | Story | Done | OT/PTO/Holiday aggregation summary
PROD-314 | Story | In Progress | Overtime calculation (>40h)
PROD-315 | Story | Done | Payroll export flow — select → review grid → confirm
PROD-316 | Story | Done | External pay-code mapping in export
PROD-317 | Story | Done | CSV / flat-file export format
PROD-318 | Story | Done | Frozen-on-export enforcement
PROD-319 | Story | Done | Audit Log — Recent activity view (ENG-778)
PROD-320 | Story | Done | Audit Log — By pay period view (ENG-779)
PROD-321 | Story | Done | Audit Log — event model & event type catalog (ENG-777)
PROD-322 | Story | Done | Audit Log — four-value change table for time edits (ENG-780)
PROD-323 | Story | Done | Audit Log — access control (mirror edit-time-cards) (ENG-781)
PROD-324 | Story | Done | Audit Log — CSV export of visible events (V1) (ENG-782)
PROD-325 | Story | In Progress | Overtime dashboard microapp (ENG-783)
PROD-326 | Story | Done | Time card overtime alert (ENG-784)
PROD-327 | Story | In Progress | Rounding rules configuration (ENG-785)
PROD-328 | Story | Done | Tolerance thresholds configuration (ENG-786)
PROD-329 | Story | In Progress | Notification triggers & templates (V2)
PROD-429 | FR | Done | BP Staff T&A Access
Backlog FRs (5):
- PROD-783 [US-NC-NCPS] Time & Attendance: Clicking an employee in the dashboa...; PROD-784 [US-NC-NCPS] Time & Attendance: No report compares employees’ actua...; PROD-785 [US-NC-NCPS] Time & Attendance: Supervisors can only view a driver ...; PROD-811 Associate pay periods with positions, not departments
- PROD-812 Holiday pay: configurable hours, average-day calculation, and emplo...

#### BusPlanner Workflow (57)
PROD-336 | FR | Done | [CA-ON-STSCO] - Workflow Archiving
PROD-344 | FR | Ready for Development | Restrict "Refer To" dropdown on Incident/Misconduct form to Principals/VPs of the submitting scho...
PROD-431 | FR | Done | CA-ON-STSCO - Submittal Search Feature Request Improvements (ENG-681,ENG-1578)
PROD-537 | FR | Declined | NLESD - 70927 - Workflow - submit button WF forms grey out to not allow multiple submittals
Backlog FRs (53):
- PROD-5 CA-ON-STSBHN (Brantford) - BusPlanner Workflow | Settings request; PROD-11 Customize Workflow Forms - Auto Populate Fields based on the user's...; PROD-17 CA-ON WESTS Windsor |Workflow Request; PROD-27 CA-ON-HSTS (Halton) | Setting to disable school admin from receivin...
- PROD-37 CA-AB-FHSD (Foothills) - BP Workflow/BP Pro - Feature request; PROD-38 As a Workflow User, It would be nice to process Transportation Appl...; PROD-47 CA-NB-GNB - BP Workflow - Feature Request for Workflow model; PROD-78 US-FL-KIPP-JAX - Add a generic Workflow Model Type without required...
- PROD-97 US-FL-SLPS - BP Workflow - Submittal auto archive request; PROD-104 CA-ON-WDSTS - BP Workflow - Workflow changes - Models; PROD-108 CA-ON-WDSTS – BP Web – Workflow – Send Email Reminders for Open Wor...; PROD-131 CA-NS-HRCE - Safety Dashboard + Provider Incident Intake (Workflow-...
- PROD-139 CA-QC-CSSBE - CSSBE Lottery/Draw – “Available Routes within Walking...; PROD-142 CA-ON-WDSTS - Workflow Model Change - Add Logic Between Two Drop Do...; PROD-144 BP Web - CA-AB-ECSD - Change Name of Link to Workflow page to view ...; PROD-145 CA-NL-NLESD - Workflows - all automatic letters to include student ...
- PROD-146 Request: Dynamic / Consortium-Based Eligibility Messaging on Workfl...; PROD-149 CA-NS-CBVRCE – Create New Form; PROD-150 CA-ON-WDSTS - Ability to have more then 1 drop down in Form; PROD-156 CA-ON-WDSTS – Workflow – Auto PDF Form Submission
- PROD-161 CA-AB-BTPS (Buffalo Trail) - Workflow feature request - forwarding ...; PROD-169 School-Specific Workflow Form Visibility / Custom Roles; PROD-172 CA-ON-TLDSB - Show target database on Workflow Submittals page; PROD-176 CA-ON-WDSTS (Wellington-Dufferin) - Workflow - automatically add va...
- PROD-179 CA-ON-WESTS - BP WEB Workflow Forms/Models - Program Drop-down request; PROD-180 CA-ON-CLASS (Chatham-Kent/CLASS) - BP Web/Workflow - Operators acce...; PROD-189 CA-ON-CLASS (Chatham-Kent) - BP Workflow - auto-notify form submitt...; PROD-196 CA-AB-CSCN (Centre-Nord) - BP Web/Workflow - Restrict text from pri...
- PROD-202 NLESD - Bulk Upload Workflow Attachments; PROD-232 CSCN Workflow - want a checkmark; PROD-392 CA-QC-CSSBE - Workflow request - auto-populating forms; PROD-437 CA-AB-AVPS - DEVELOP EN MASSE TOOLS
- PROD-495 [CA-ON-STEO] - Automatic Form Upload for Workflow; PROD-503 [CA-AB-BRSD (Battle River)]; PROD-521 [CA-NS-AVRCE (Annapolis Valley)] - Contact Form Link Change; PROD-528 STEO - 69172 - Workflow - Dropdown edit
- PROD-540 CA-ON-STSCO - 73235 - Workflow - Add granular (per-form / per-role)...; PROD-545 WDSTS - Workflow models - dropdown lists; PROD-575 CA-ON-STSBHN (Brantford) - 74669 - Workflow - Automations; PROD-576 US-FL-SJCSD (St. Johns) - 74071 - Workflow - Bulk archive/edit subm...
- PROD-585 US-FL-MDCPS (Miami) - 67674 - workflow - Feature request "Form Proc...; PROD-587 CA-ON-STSCO (Peterborough) - 74905 - Workflow - Submission Details ...; PROD-588 CA_ON_STEO - 72908 - Workflow - drop down of all users to be includ...; PROD-604 CA-AB-SAPS - Workflow - Allow any field type in any form section
- PROD-608 CA-NB-GNB (New Brunswick) - - setting that will automatically notif...; PROD-732 [Workflow] ASD-S staff can’t sign in to Workflow with their distric...; PROD-751 Add ticket number to confirmation message; PROD-774 CA-ON - STSCO (Peterborough) - [Workflow] TSC form hangs on submit ...
- PROD-780 CA-ON-OSTA - 81790 - Workflow - Increase character limit for Descri...; PROD-806 [CA-ON-WESTS (Windsor)] - Workflow Form F2 (Désinscription / Transp...; PROD-807 [CA-ON-WESTS (Windsor)] - Workflow Form F4 (Transport de courtoisie...; PROD-808 [CA-ON-WESTS (Windsor)] - Workflow: School Admin submittals default...
- PROD-809 [CA-ON-WESTS (Windsor)] - Workflow Form 2 / F2 (Opt-Out / Transport...

#### BusPlanner Turns (40)
PROD-111 | FR | Declined | CA-AB-PRSD - Turns Undo Scan
PROD-338 | FR | Ready for Development | Recurring/scheduled import of scan card assignments
PROD-441 | FR | Done | BP Turns - Additional Step for Manual Scan (ENG-1308)
PROD-538 | FR | Gathering Requirements | [CA-AB-PRSD (Peace River)] - BP Turns Request - END ROUTE button
PROD-553 | FR | Ready for Development | [CA-AB-PRSD] - BP Turns: pop-up at final stop listing students scanned ON but not yet scanned OFF...
PROD-601 | FR | On Hold | [CA-AB-PSD] - BP Turns: configurable zones around school/transfer sites so scans/transfers regist...
PROD-638 | FR | To Do | [Ridership] Drivers can't record which guardian a PreK/K student was released to
PROD-656 | FR | To Do | [Turns] Drivers can't build seating charts on the tablet, only office staff can in BP Web
PROD-696 | FR | On Hold | [Turns] Drivers can't reverse a mistaken manual load, so parents are told their child is on a bus...
PROD-741 | FR | To Do | [Turns] Drivers have to find their name and type a password to log in to the tablet, instead of t...
PROD-760 | FR | To Do | [Turns] PM drivers can't see how many students should get off at the next stop, a Smart Tag featu...
PROD-761 | FR | Done | [Turns] Drivers can't see a live count of students on board, so after an accident there's no imme...
PROD-763 | FR | Gathering Requirements | CA-NL-NLESD - [Turns] Feature Request: Bulk Update All Schools and All Grades for Turns Logins
PROD-779 | FR | To Do | CA-NL-NLESD - [Turns] Driver login via RFID card tap with user to card ID mapping
Backlog FRs (26):
- PROD-24 Change Mappings for Turns to be temporary; PROD-33 US-DC-DCSC - Turns Suggestion - As a Driver, I would like to be abl...; PROD-34 US-DC-DCSC - Turns Suggestion - As a Driver, I would like to be abl...; PROD-95 CA-AB-SAPS - Title: Exclude future-dated students from BusPlanner T...
- PROD-158 CA-AB-PRSD - NFC Scanning Compatibility on Samsung Galaxy Tab Activ...; PROD-190 CA-AB-Southland (Southland) - BP Turns - selecting All Runs / All A...; PROD-194 CA-NL-NLESD (Newfoundland) and Yankton - BP Turns - driver log-in u...; PROD-197 CA-AB-SAPS - Bp Turns - pop up to remind the driver to click the en...
- PROD-223 BP Turns - GNB -GPS snap-back delay; PROD-224 BP Turns - GNB- Improve Font Size; PROD-239 [US-FL-SDCC] Provide turn by turn directions during deadheads; PROD-449 All clients with turns - add web setting
- PROD-454 BP Turns - Display student contact number in the app (client-level ...; PROD-554 [CA-AB-PRSD] - Report: list all students with their assigned Scan C...; PROD-584 [CA-AB-SAPS] As a Turns Client, I would like the ability to send sp...; PROD-655 [Turns] Drivers can't check a pickup person's ID against anything o...
- PROD-657 [Turns] After an accident, drivers can't produce the seating chart ...; PROD-703 [Turns] Drivers can't get directions to a trip destination on the t...; PROD-705 [Turns] Districts can't track which students were evacuated on whic...; PROD-739 [Turns] Dispatch and supervisors can't message drivers on the table...
- PROD-742 [Turns] Small districts have to buy radios or rely on cell phones j...; PROD-743 Cross contractor student scanning; PROD-759 [Turns] PM drivers aren't told which stops have no students on boar...; PROD-764 [CA-AB-PRSD] - BP Turns: stops disappear from list view when trigge...
- PROD-767 [CA-ON-SAPS] Turns: Drivers need a way to know when a scanned pass ...; PROD-796 [TSTG]WAT legacy GTS vehicle mappings appearing in BP Turns and ove...

#### BusPlanner Trips SE (33)
PROD-103 | FR | Done | US-MD-Calvert - BusPlanner Trips SE - Driver Trip Sheet (Driver Report to PDF under Assignments/B...
PROD-125 | FR | Done | US-MD-CALVERT - BP Trips - Trips Feature Request
PROD-243 | FR | Scheduled | Trips SE - Add Trip Number to Driver Trip Sheet Report
PROD-659 | FR | On Hold | [Trips] Dispatch can't see which buses and drivers are tied up on trips, so vehicles get double-b...
PROD-690 | FR | Scheduled | [US-MD-WCPS] Request changes to Trips for operational needs
PROD-698 | FR | Declined | BP Trips - Miami - New Depot Structure
Backlog FRs (27):
- PROD-19 US-FL-SJCSD | trips se ALERT REQUEST; PROD-21 US-MD-CALVERT | Trips Change; PROD-30 CA-NB-GNB - Trips SE - New Setting for Trim Reminders to Driver; PROD-31 CA-NB-GNB - Trips SE - Give Requesters ability to see and export th...
- PROD-76 CA-AB-RVS - Enhancements for Recurring Trips, Permissions, Blackout...; PROD-81 Request to add SSO to Trips for Individual User Generation; PROD-115 Ability to hide charges on finalized invoice.; PROD-137 CA-AB-HPSD (High Prairie) - BP Trips - Cost Summary setting request
- PROD-141 US-MD-Calvert - Daily Trip Capacity Cap in BusPlanner Trips; PROD-183 US-MD-WCPS Trips SSO; PROD-187 CA-AB-HPSD - BP Trips - allowing the same driver on overlapping trips; PROD-246 US-FL-SJCSD (St. Johns) - Trips - BusPlanner Trips to generate a ma...
- PROD-247 [Lowndes County] Fiscal Year Separation / Multi-Year Database Support; PROD-421 US-GA-LCSD - Trips - Trip Estimate Permissions; PROD-422 [38977/59419][US-MD-SMCPS]New vehicle cost type - Trips; PROD-426 US-SD-YSD - Trips - date format
- PROD-436 US-MD-CALVERT - Trips - Request to add year suffix after trip numbers; PROD-502 US-FL-SJCSD - Trips - Adding a confirmation and checkbox.; PROD-504 [US-SD-YSD][] - Trips Email Notifications – Admin Users; PROD-541 CA-ON-SWOSTS (London) - BP Trips - Bus Manifest Preview Request
- PROD-606 BP Trips SE - WCPS - Ability to Alert Coaches of Trips details and ...; PROD-663 [US-MD-Calvert] - Filter By Vehicle ID BP Trips; PROD-701 [Trips] District can't cap trips during route hours or by grade/cam...; PROD-704 [Trips] Districts track field trip students on paper rosters, so th...
- PROD-707 [Trips] Campus nurses and cafeteria staff aren't told about field t...; PROD-748 [CA-AB-HPSD][Trips] Can't bill two groups of trips at different rat...; PROD-757 [Trips] Drivers can't be offered and accept field trips electronica...

#### Chipmunk - Tracker (24)
PROD-57 | FR | Declined | Make a setting to enable Chipmunk Dashboard for Bus Operators in BP Web.
PROD-58 | FR | Declined | Make a setting to enable Chipmunk Dashboard for Bus Operators in BP Web.
PROD-396 | FR | Done | Embed Chipmunk Assistant (Chatbase) into Chipmunk app via in-app browser (ENG-1147)
PROD-515 | FR | Ready for Development | Chipmunk: show Scheduled Stop time to parents instead of school arrival time
PROD-523 | FR | Done | [US-MD-PGCPS] - Technical Review of App Inconsistencies
PROD-532 | FR | Declined | Chipmunk: show Scheduled Stop time to parents instead of school arrival time
Backlog FRs (18):
- PROD-45 US-DC-DCSC - Enforce fixed 0.5-mile notification radius in Chipmunk...; PROD-46 CA-AB-GSACRD - Chipmunk - Chipmunk Alert feature request; PROD-51 Make a setting to enable Chipmunk Dashboard for Bus Operators in BP...; PROD-93 As a Client, I want more visibility to the amount of user's who hav...
- PROD-168 Chipmunk - See Reason on Alerts Page; PROD-448 All Chipmunk Users - Add feature in web to disable parent lockout i...; PROD-489 Chipmunk: Graceful error state when a district tracker is unavailab...; PROD-527 STSTB - 68919 - Chipmunk
- PROD-529 STSTB - 68919 - Chipmunk - Wording Adjustment on Chipmunk; PROD-531 GPS+ - configurable schedule for tracker service routing data impor...; PROD-598 Indian River - - Chipmunk - Data export (ENG-1942); PROD-615 CA-AB-PRSD (Peace River) - - Limit Chipmunk visibility of school ar...
- PROD-639 [Chipmunk] Parents can't add authorized pickup people for their Pre...; PROD-641 [CA-ON-STSBHN] - Chipmunk User Report; PROD-721 Chipmunk - Replace "bus not reporting" with condition-specific mess... (ENG-2508); PROD-731 [Chipmunk] Parents don't get a late-route notification unless a dis...
- PROD-744 US-KY-MT (Miller) - - Chipmunk - Multi-language support (Spanish, H...; PROD-755 [Chipmunk] SPED parents have no way to tell dispatch and the driver...

#### BusPlanner Unified: Core Features and Infrastructure (23)
PROD-398 | Story | Backlog | [V1] Enter email to begin sign-in (ENG-1063)
PROD-399 | Story | Backlog | [V1] Account not found on email lookup (ENG-1064)
PROD-400 | Story | Backlog | [V1] Choose organization when email maps to multiple clients (ENG-1065)
PROD-401 | Story | Backlog | [V1] Proceed directly to password for single-client email (ENG-1066)
PROD-402 | Story | Backlog | [V1] Sign in with password (ENG-1067)
PROD-403 | Story | Backlog | [V1] Wrong-password feedback (ENG-1068)
PROD-404 | Story | Backlog | [V1] Change email from the password screen (ENG-1069)
PROD-405 | Story | Backlog | [V1] Land on the Dashboard after sign-in (ENG-1070)
PROD-406 | Story | Backlog | [V1] Brute-force protection & enumeration mitigation (ENG-1071)
PROD-407 | Story | Backlog | [V1] Authenticated session across products (ENG-1072)
PROD-408 | Story | Backlog | [V2] See SSO options for my client
PROD-409 | Story | Backlog | [V2] Multiple SSO buttons for multi-district clients
PROD-410 | Story | Backlog | [V2] Authenticate via IdP redirect
PROD-411 | Story | Backlog | [V2] Request a password reset
PROD-412 | Story | Backlog | [V2] Verify OTP code
PROD-413 | Story | Backlog | [V2] Set a new password
PROD-414 | Story | Backlog | [V2] Passwordless magic-link login
PROD-415 | Story | Backlog | [V2] Multi-factor authentication
PROD-416 | Story | Backlog | [V2] "Keep me signed in"
PROD-417 | Story | Backlog | [V3] Show only the applicable login method
PROD-418 | Story | Backlog | [V3] Enforcement-level configuration for dynamic method
PROD-749 | FR | On Hold | [Platform] Demos send prospects to separately bookmarked Trips, Fleet, BP Web and Quick sites, un...
Backlog FRs (1):
- PROD-756 [Unified] Transportation departments have no system to log, route, ...

#### BusPlanner Fleet (21)
PROD-59 | FR | Scheduled | CA-NS-AVRCE - Custom SQL View Request
PROD-661 | FR | On Hold | [Inspections] Defects found on inspection don't create a Fleet work order, so drivers write them ...
Backlog FRs (19):
- PROD-16 CA-SK PSPT Prairie Spirit | Fleet Request; PROD-71 As a Fleet User, I'd like to be able to set a static annual service...; PROD-120 CA-AB-BRSD - BusPlanner Fleet - Inventory/Barcoding; PROD-121 CA-AB-BRSD - Backport bin number printing to 12.2.1
- PROD-122 CA-MB-ESD (Evergreen) - BP Fleet - Feature Request – GPS-Driven Odo...; PROD-123 The client would like adjustments made to the Work Order report for...; PROD-660 [Fleet] Dispatch and Trips can't see when a bus is down for repair,...; PROD-662 [Fleet] Mechanics aren't told a PM is coming due, so buses come bac...
- PROD-710 [US-FL-MDCPS] - Fleet – Enforce required fields: Vehicle on Work Or...; PROD-711 [US-FL-MDCPS] - Editable Purchase Order date; PROD-717 [CA-AB-PRSD] - Cost reporting by manufacturer, model year and type; PROD-718 [CA-AB-PRSD] - Fleet Custom Query
- PROD-719 [CA-AB-PRSD] - Geotab and BP Fleet Integration; PROD-720 [CA-AB-PRSD] - Report Limitations; PROD-725 [US-FL-MDCPS]Maintenance staff can't find a specific fuel adjustmen...; PROD-726 [US-FL-MDCPS] BP Fleet – Add Department column to Work Order Excel ...
- PROD-745 [US-FL-MDCPS] Fleet – Miami – Fleet_Cost export: exclude zero-value...; PROD-758 [Fleet] Shops can't assign buses to a mechanic, so a foreman has to...; PROD-766 [CA-AB-PRSD] BP Fleet: add 'repair cost average' calculation/report...

#### BusPlanner GPS / GPS+ (20)
PROD-653 | FR | To Do | [GPS+] Dispatch can't see which students got on or off at a serviced stop when a parent calls
PROD-730 | FR | To Do | [GPS+] Dispatchers have no way to know a route is running late until a parent calls
Backlog FRs (18):
- PROD-88 Easier ability to clicking bus information; PROD-124 CA-ON-STSTB - Pro/Quick/Chipmunk - Various GPS feature requests; PROD-175 CA-ON-STSTB (Thunder Bay) - BP Alerts and GPS + - Add feature that ...; PROD-198 GPS+ Smart Mappings - Limit vehicle suggestions based on assigned O...
- PROD-235 GPS+ - Exclude waypoints in stop count; PROD-238 [] [CA-ON-TSTG] Routes not mapped; PROD-244 CA-AB-SAPS - Ridership - report changes; PROD-526 STSTB - 69273 - GPS+ - Skip stop and end run button
- PROD-548 [GPS+] Geotab GO10 - investigate GPS+ data collection and GPS reade...; PROD-642 [CA-ON-TSTG]GPS On-Time Reporting: allow multi-select of Component ...; PROD-729 [GPS+] Campuses have no way to know when every student has safely e...; PROD-734 [GPS+] Districts can't see how many unique students they transporte...
- PROD-735 [GPS+] Dispatch and supervisors can't see how many students are sti...; PROD-737 [GPS+] Districts can't draw their own areas on the map to capture w...; PROD-738 [GPS+] Districts can't set speed limits for specific areas, so supe...; PROD-747 [BPWeb][CA-ON-TSTG] Operators can't tell current GPS vehicle mappin...
- PROD-781 [GPS+] Supervisors aren't alerted when a bus leaves its route, so a...; PROD-799 [Halton] - Logging for GPS reader

#### BusPlanner Quick (20)
PROD-60 | FR | Declined | CA-AB-GYPSD (Grande Yellowhead) - BP QUICK - Windows Users show up in BPQuick
PROD-70 | FR | Done | Bus Pass - CC sized cards
PROD-450 | FR | Ready for Development | [] - QR Print in Bulk, Bus Pass Template
PROD-664 | FR | Gathering Requirements | Quick - Bulk Import Users
PROD-798 | FR | Ready for Development | [US-MD-PGCPS] Default operator setting for users on BusPlanner Web and Quick
Backlog FRs (15):
- PROD-53 CA-AB-GYPSD (Grande Yellowhead) - BP QUICK - Windows Users show up ...; PROD-77 CA-AB-PRSD - Enhancements to Ridership Report; PROD-82 As a Transportation service, it's important for me to have visibili...; PROD-116 Option for the Quick map to overlay in BusPlanner Pro
- PROD-162 US-MD-PGCPS - BP QUICK - Add instructions/comments as option to sho...; PROD-184 CA-MB-ESD (Evergreen) - BP Quick - Multiple phone numbers displayed; PROD-213 BP Quick - Student Properties - Generate QR Code for Student Card; PROD-222 BP Quick - Ridership Reporting - GNB - add ability to search by stu...
- PROD-342 US-MO-EITAS (EITAS) - Quick/Pro - Manually entering missed scans; PROD-432 AB PSD - Optional fields for Bus Passes; PROD-485 US-MD-CCPS - BP Quick - Transportation display in basic student info; PROD-549 [Ridership] End-to-End Ridership Printing Solution with BusPlanner
- PROD-654 [Ridership] Supervisors can't see which students were loaded manual...; PROD-712 Quick - Report Sorting; PROD-815 [US-MD-PGCPS] BusPlanner Quick: multi-operator run filter for the m...

#### BusPlanner Dispatch (12)
PROD-1 | FR | Ready for Development | Old World -BP Dispatch - Liveviewer - Fix the count showing up in card filters
PROD-551 | FR | Gathering Requirements | [US-FL-SDIRC] - Dispatch: allow clearing the driver on a run & have a replacement fully replace t...
PROD-627 | FR | Gathering Requirements | [US-FL-MDCPS] - Dispatch: show sub drivers & sub attendants in the Reassign Dashboard (no existin...
PROD-667 | FR | Gathering Requirements | BP Dispatch Historical Reporting
PROD-793 | FR | To Do | [US-FL-MDCPS] Dispatch: Real-time KPI dashboard for Dispatch users and School Viewer (contract co...
Backlog FRs (7):
- PROD-49 Report Request - Bus Substitutions; PROD-668 [US-FL-MDCPS] Provide an option to turn off "Send Run Changes" in D...; PROD-697 [Dispatch] Dispatchers can't see new route times from combining run...; PROD-699 [Dispatch] Districts can't tell from the Quick Log Viewer what chan...
- PROD-733 [GPS+] Live Viewer only shows On Time or Late, so dispatchers can't...; PROD-736 [Dispatch] Dispatchers can only reassign one driver or bus at a tim...; PROD-771 [US-FL-MDCPS] Add a "Schools" dropdown list to filter the GPS Live ...

#### BusPlanner Legacy (Old World) - Core features and Infrastructure (7)
Backlog FRs (7):
- PROD-8 CA-ON-STSTB - Network Performance issues; PROD-112 US-GA-GCPS - Back-up task option; PROD-173 Automated audit logs for logins; PROD-250 [CA-ON-STSCO] - Downtime Message Change
- PROD-420 [CA-ON-Triboard] - Resource Increase; PROD-605 CA-ON-RCJTC (Renfrew) - MFA - Support TOTP authenticators and per-u...; PROD-630 Automating a backup and restore and adding to DB registry.

#### (no product) (6)
PROD-216 | Story | Done | BP Quick - Generate, download & print QR code for a Student Card from Student Properties (Scans tab)
PROD-217 | Story | Done | Trips SE: Replace BudgetCodeFundingAccounts with structured Budget Code → Object Codes data model
PROD-218 | Story | Done | Trips SE: Add ObjectCodeRequiredOnTrips general setting
PROD-219 | Story | Done | Trips SE: Budget Code / Object Code editor (two-column master/detail)
PROD-220 | Story | Done | Trips SE: Trip form — data-driven Object Code field (combobox with CUSTOM fallback / plain-text f...
PROD-221 | Story | Done | Trips SE: Enforce required Object Code on trip save when ObjectCodeRequiredOnTrips is true

#### BusPlanner Unified: GPS+ (3)
PROD-488 | FR | Ready for Development | BP Unified: GPS+ "Show on map" — choose which vehicles the Live Fleet Map shows (ENG-1595)
Backlog FRs (2):
- PROD-442 Upgrade RCJCT to New World GPS+; PROD-762 Centralize GPS vehicle mappings so new world customers maintain one...

#### Delays App (2)
Backlog FRs (2):
- PROD-568 Delays- Thunderbay- Show Reason type on Delays for Cancellation; PROD-801 [CA-NS-CSAP] - French Version for Delays App

#### BusPlanner Finance (Contracts) (2)
PROD-251 | FR | Ready for Development | [US-MD-SMCPS] Finance Contract Issues - Attendant Pay & Driver Variable Time Calc Discrepancies
Backlog FRs (1):
- PROD-567 Finance Contract(s) - TLDSB

#### BP Unified: Discipline Module (1)
PROD-658 | FR | To Do | [Discipline] Drivers and campuses have no way to write up, route, and track bus discipline referr...

#### BusPlanner - Dev Questions (1)
Backlog FRs (1):
- PROD-490 [CA-AB-EPSD] - EPSB custom report (Proposal , Option 2): dev feasib...

#### BusPlanner Performance Management (1)
PROD-451 | FR | Done | [CA-ON-TSTG] - BP PM not updating

#### BusPlanner Unified: Chatbot (1)
Backlog FRs (1):
- PROD-476 Chipmunk Assistant: Identify parent + district on Chatbase conversa... (ENG-1617)

### Project purposes in one line each
- SPT: intake of customer problems from Zendesk (Bug, Dev Question, Workflow). Workflow: Backlog -> Ready for Development -> In Progress -> On Hold -> Done. Real engineering work moves to ENG (clone or move; label `jira_escalated`); "Done" in SPT often means "moved, duplicate, answered or created by mistake", not "fixed".
- IN: DevOps and IT for the hosted (SaaS) estate on IBM Cloud (Classic VSIs per customer, plus new-world Kubernetes) and internal IT (onboarding, VPN, mail). Workflow: Backlog -> In Progress -> On Hold -> Done. Customer slowness and outage tickets land here from support; product fixes are linked to ENG.
- SOC: SOC 2 evidence collection (audit window 2026-06-06 to 2026-08-30), all Done.
- PROD: product requirements. Client asks (Feature Request), sales/prospect asks (label Sales), Unified product structure and T&A user stories. Workflow: Backlog -> To Do / Gathering Requirements -> Scheduled -> Ready for Development -> In Progress -> User Acceptance Testing -> Approved for Release -> Done; or On Hold / Declined.
- MDP: sandbox, ignore.

## 3. Customer-reported problem themes (SPT 117 + customer tickets in IN)

Counts are of SPT tickets unless noted; one ticket may sit in two themes.

| # | Theme | SPT count | Example keys | Product / module |
|---|---|---|---|---|
| 1 | GPS data wrong or missing: "No GPS Events" while the bus runs, wrong vehicle on a run, late status when on time, reader stops silently, reader will not start, mapping wiped | 18 | SPT-34 (ENG-629/635), 424, 774, 787/788 (ENG-165), 770, 808, 824, 884, 886, 888, 904, 211, 942, 26, 31, 632, 761 | GPS readers (Zonar, Samsara, Synovia/WAT, GTS, Geotab), Tracker/GeoIMS, Quick GPS Live, GPS+ Live Viewer and Smart Mapping, Dispatch Live Viewer |
| 2 | Report output wrong or inconsistent (wrong runs in range, totals wrong, PDF differs from Show/Save, rows dropped, units wrong, wrong audience) | 17 | SPT-507 (ENG-2306), 742, 794, 802, 830, 851, 879, 894, 901/902, 906, 909, 918, 878, 927, 361, 872, 633 | BP Web reports, Pro reports, Finance RCBA, Trips export, government (FEFP, Ontario) |
| 3 | Parent notifications not delivered or wrong (push missing, late, late notice for a cancelled bus, Chipmunk "bus not reporting", cannot add student) | 13 | SPT-71 (dup of ENG-442/443), 200 (ENG-1088), 848, 849, 825, 907, 352, 915, 32, 447, 935, 880 | BP Web Post Alerts -> Chipmunk / Delays app / email; Chipmunk contact matching and tracking |
| 4 | Turns tablet and ridership scans (no students on stops, card IDs not matched, duplicates, pending scans lost, crash recovery, wrong stop at shared locations, merged runs scan red) | 11 | SPT-245 (ENG-1266), 566 (parent ENG-66), 585, 586 (ENG-2069), 807, 857, 856, 881, 432, 395, 883 | BP Turns, scan card matching (BPX_AVLScanCardStudent), substitutions/vehicle mappings |
| 5 | Performance and outages (slow Web/Pro/Workflow, 100% CPU, RDP disconnects, report taking hours) | 9 SPT + ~35 IN | SPT-408, 629, 809, 892, 897, 895, 938, 940, 119; IN-35, 41, 59, 61, 66, 72, 75, 84, 91, 103, 111, 113, 164, 204, 213 | Hosted servers, SQL indexing, GeoIMS, RDS/RemoteApp, Windows updates |
| 6 | Student, stop and eligibility data in Pro (walk path, right-side service, auto-assign, future-dated stops, duplicate enrolments, pending address changes, imports) | 13 | SPT-141, 212, 298, 810, 834, 875, 889, 910 (ENG-2881), 912, 932, 939, 893, 124 | BP Pro routing/eligibility, Student Update, Staff Update, data extract |
| 7 | Login, roles and permissions (parents at two boards with SSO, role save fails, menu shown without role, report empty for non-admins) | 7 | SPT-370, 597, 928, 941, 918, 893, 885 | BP Web parent portal + SSO + contact matching, Quick roles, Pro permissions |
| 8 | Money: Finance, Trips and Fleet costs | 9 | SPT-742, 802, 791 (ENG-2812), 878, 916, 925 (ENG-2626), 933, 927, 410 | BP Finance (RCBA), Trips SE, BP Fleet (SAP export, parts transfer) |
| 9 | Workflow forms | 6 | SPT-89, 117, 838, 847 (ENG-2982), 876, 914 | BP Workflow (web) |
| 10 | Upgrade / install / version questions | 8 | SPT-117, 119, 210, 784, 824, 899, 847, 851 | Installer, BP Info, Pro government tools |
| 11 | Time-zone change (Alberta stayed on UTC-6 on 2026-11-01) | 1 SPT, 13 IN | SPT-914; IN-217, 220, 221, 222, 223..229, 239 (ENG-2971) | Server clocks, scheduled tasks, Geotab reader, Quick Live GPS ETAs, Workflow timestamps |

Deep-read adjustments (after reading every SPT/IN comment; counts above are by symptom, below is by cause):
- Not product defects after all: SPT-26 (refresh task), 89 and 370/597 (by design), 298 and 440 (customer setting), 410 and 742 (as designed: Trips availability is time-overlap only; RCBA Time/Distance show the last day), 539, 632 and 808 (reader config/credentials), 938 (CSV saved to a network drive), 395 (config). Theme 2 effectively drops to 14 and theme 1 to 15 genuine defects.
- Theme 5 by cause (IN): SQL configuration on hosted servers (memory caps, MAXDOP, parallelism, tempdb: IN-35, 39, 47, 58, 60, 66, 67, 75, 78, 201) ~10; product code (GeoIMS polling query and worker leak IN-35, 61, 83, 103; PathServer thread leak IN-111, 213 / ENG-2967; Pro queries IN-59 / ENG-1553..1556; Trips CE queries IN-72; Pro help-launcher loop SPT-897; Pro crash signature IN-87) ~10; Windows September 2026 update RDS hang (SPT-895, IN-84, 164, 195 - 54 servers) ~5; customer network (IN-108, 204, 214) 3; IBM host/network (IN-90, 104, 130, 87) 4.
- New theme 12, silent operational failures (no alert until a customer calls): IN-42, 45 (new-world prod backups stopped 37 days), 57, 63, 68, 106 (password spray locking the SQL service account), 113, 116, 118, 201 (server unpatched 8 months); SPT-888, 99.

Customers with the most SPT tickets: STSTB (9), TSTG (9), PRSD (8), SJCSD (7), WDSTS (5), SAPS (5), NHCS (4), MDCPS (3), PGCPS (3), SWOSTS (3), OSTA (3).

## 4. Feature requests (PROD)

621 Feature Requests: Backlog 498, Ready for Development 28, Done 27, Scheduled 19, Declined 17, To Do 12, Gathering Requirements 9, On Hold 6, In Progress 5. By product (FR + Story): Pro 192, Web 124, T&A 67 (stories), Workflow 57, Turns 40, Trips SE 33, Chipmunk 24, Unified core/login 23, Fleet 21, GPS/GPS+ 20, Quick 20, Dispatch 12, unparented 67 (T&A stories and the 2026-11 Beaverton Fleet/Trips sales batch). About 190 FRs are carried over from Azure DevOps (body is just "DevOps ID: 4xxxx").

| Theme | Approx. count | Examples | Status |
|---|---|---|---|
| New or changed reports, columns, filters, formats | ~110 | PROD-15, 105, 332, 478, 520, 539, 595, 612 (Run Directions Condensed), 614, 644, 770, 814 | Mostly Backlog; PGCPS run sheets In Progress / Ready |
| State and ministry reporting | ~14 | MSDE PROD-562, 563, 700; NC TDTIMS 626, 923; Texas TEA 702, SHARS 708; Ontario 519, 792, 800; CESD 518/533 | Scheduled / In Progress / Done (708, 923) |
| Map and routing display (equipment icons, address types, cluster stops, colours, imagery, OSM/Google layer) | ~25 | PROD-331, 480, 483, 550, 620-623, 816, 932, 943, 159, 393, 394 | PGCPS items Scheduled / To Do; 331 Done |
| Alerts and parent notifications (zones, weather zones, quiet hours, approvals, language, targeting) | ~35 | PROD-12, 228, 435, 510, 511, 547, 564-566, 597, 633, 713-715 (declined, ENG-2466), 740, 786, 794, 813, 944 | 228, 547, 564-566 Scheduled; 633 In Progress |
| Audit trail and change history | ~12 | PROD-173, 245, 505, 508, 522, 591, 699, 787, 789/790, 791 (Done), 795 | 791 Done, 790 Ready, 795 Scheduled |
| Bulk operations | ~15 | PROD-38, 164, 427, 437, 438, 576, 599, 664, 716, 736, 763, 816 | Backlog except 816, 763 |
| Turns driver features and safety | ~25 | PROD-441 (Done), 553 (end-of-run not-scanned-off check), 538, 601, 656, 696, 739, 741, 759-761, 779 | 761 Done; 553 Ready; 656, 741, 760, 779 To Do |
| Workflow forms, automation and permissions | ~45 | PROD-38, 108, 344, 431 (Done), 540, 575, 604, 732, 774, 945 | Mostly Backlog |
| Trips SE (sheets, budgets, SSO, notifications, bidding) | ~33 | PROD-103/125 (Done), 214/217-221 (Done, Object Code), 243, 504, 690, 876-886 | 243, 690 Scheduled |
| Fleet (work orders, PM, parts, SAP export, fuel) | ~35 | PROD-59, 660-662, 710, 711, 745, 863-875, 933-935 | Backlog; 59 Scheduled |
| Chipmunk parent app | ~24 | PROD-396 (Done), 479 (Done), 489, 515, 721 (ENG-2508), 731, 936 | 515 Ready; rest Backlog |
| GPS+ / Dispatch live operations | ~30 | PROD-1, 526, 653, 667, 668, 697, 730, 733, 735, 737, 738, 771, 781, 793, 799 | 653, 730, 793 To Do |
| Login, SSO, MFA | ~25 | Unified Login PROD-397..418 (V1-V3 stories, ENG-1063..1072), 81, 183, 487, 605, 732, 920 | Backlog |
| Multi-language | 6 | PROD-510, 617, 694, 744, 801, 806 | Backlog |
| Time & Attendance (Unified) | 67 stories + 9 FRs | PROD-253..329, 459..471, 783-785, 811, 812 | Most Done or In Progress; Nash export/PDF Backlog |

Most-requesting customers: PGCPS (~30, many Scheduled), STSTB (~15), TSTG (~15), WESTS (~14), MDCPS (~14), OSTA (~10), PRSD (~10), GNB (~10), LESA (~8). Sales-label batches: New Caney ISD and other Texas prospects (Turns, GPS+, Trips, TEA/SHARS), Beaverton (Fleet, Trips), Cleveland ISD (Trips).

## 5. Business rules and expected behaviours (testable; not already in domain.md)

Notifications and alerts
- A General Notice posted with "Do not push to app" unchecked is delivered to Chipmunk (push + Alerts tab) as well as the Delays app and email. (SPT-71)
- A cancelled bus does not generate late notices to parents, even if the vehicle moves. (SPT-825; PROD-175 asks to disable GPS late reporting on cancelled runs)
- Alerts posted in BP Web reach the Delays app as a push promptly and turn the BP Web alert indicator red; observed delays of 6 minutes and missed pushes are defects. (SPT-848, 849)
- An "All Day" alert is removed automatically at 6 PM the same day. (PROD-435)
- "Post a School Alert" is shown only to users with the School Closer role. (SPT-928)
- The Delays app (Android) renders General Notice HTML, with tappable links. (SPT-907; regression of ADO 37310)
- Alert Listing "Save" writes one row per alert. (SPT-851)

Reports
- Cancellation & Delay report: a time range covering only the morning returns no PM runs, and vice versa. (SPT-507)
- Route Summary by Route uses the same unit (km on an English-Canada site) in PDF as in Show/Save. (SPT-894)
- Route Changes web report and its PDF list the same changes; stops whose effective date is after the range are excluded. (SPT-879)
- Route Directions by Run with "Include Deadheads" shows only variations that the run itself has. (SPT-830)
- Student Listing results grid shows each student's transportation Effective and Retire dates, including in the Excel export. (SPT-901/902)
- FEFP Supplemental Roster produces one roster per selected route, or warns. (SPT-906)
- Ontario government reports are not visible to US clients. (SPT-909)
- Student Scan Report returns scans for every role permitted to run it, not only Site Admin. (SPT-918)
- Trips export: Total Cost equals the sum of the component cost columns to the cent. (SPT-878)
- Trips SE Trip Listing date filter includes the last day; a single-day range returns that day's trips. (SPT-927)
- Finance RCBA totals are the sum of each day's cost; its Time and Distance columns show only the last day of the range, while Route Listing shows the weekly weighted average (so they legitimately differ for routes with variations). Additional Cost line items are NOT included in RCBA today (gap). (SPT-742, 802)
- Student Eligibility calculator writes StudEligErrors.txt to the user's Documents folder when any student errors. (SPT-872)

Turns and scanning
- A scanned card ID matches the student whether it is stored or read as 7 digits or zero-padded 8 digits (match is currently an exact string join; about 51K SAPS scan events were orphaned in Sept 2026). Pro currently demands 8 digits when a card is added. (SPT-566)
- After a crash or reopen, Turns resumes the current route and position without re-selecting bus/route/AM-PM, and keeps scans already taken. (SPT-807)
- Where several stops share one location, the driver can choose which stop to open; scans land on the chosen stop. (SPT-857)
- Students on runs merged in Dispatch scan green at their planned stops. (SPT-856)
- Pending scans that fail are retried with the current vehicle ID. (SPT-585)
- A student appears once in Turns ridership even after a school change. (SPT-432)
- Manual scans in Turns require an extra confirmation step. (PROD-441, Done)
- Turns shows a live count of students on board, AM and PM. (PROD-761, Done)

Parent portal, login and roles
- When a board uses SSO that supplies the student list, BP Web replaces the parent's student list with the SSO list, so a parent with children at two boards sees only that board's children (by design; a feature request is needed). (SPT-370, 597)
- Quick Roles page: an Administrator can save a role. (SPT-941)
- Pro Edit Student comment pane is read-only but scrollable for users without Alter Object. (SPT-893)
- Workflow forms show reCAPTCHA to every viewer, not only BP Support. (SPT-847)
- Workflow "upload to BP as student attachment" reports failure when the student does not exist. (SPT-876)
- Workflow student search on a form's example/preview view lists test students; that is by design, not a privacy leak. (SPT-89)
- BP Web MFA codes expire after 4 minutes by default. (PROD-42)

Pro data and routing
- BP Web shows a student's PM trip only when both the home drop-off and the school pickup assignments exist and are current; it gives no warning when one is missing (current behaviour, flagged as a bug). (SPT-910, ENG-2881)
- Auto-assign must not assign a student to a stop that no longer serves the student's school (the GNB case was a customer setting). (SPT-298)
- Student Update with "Don't pend address changes if same Geocode" does not pend changes that geocode to the same point (address equivalencies apply). (SPT-932)
- Staff Update rejects contacts without a Contact Type instead of leaving unsaved records. (SPT-912)
- A home stop on a route effective in the past is offered (not shown as future-dated) when assigning stops. (SPT-810)
- Effective-date delays in Pro skip Saturdays and Sundays only, not holidays (current behaviour). (PROD-930)
- Extended Property UserFieldGuid differs between databases (summer vs school year), which breaks third-party imports. (SPT-124)

Finance, Trips and Fleet
- Fleet parts transfer: received stock carries the sending shop's unit cost; work orders are not charged 0.00. (SPT-933)
- Fleet SAP export does not re-export legacy (already exported) work orders. (SPT-925)
- Trips SE: when ObjectCodeRequiredOnTrips is true, a trip cannot be saved without an Object Code; Object Code is a combobox driven by the Budget Code with a custom fallback. (PROD-218, 220, 221)
- Trips SE vehicle availability is decided only by time-window overlap: a bus booked 2:00-7:30 PM is offered for a morning trip the same day, and a bus ending at 5:00 PM is offered for a 5:00 PM start (no padding). (SPT-410, dev answer)
- Scan-card matching, reader settings and service start-up (from the deep read): reader settings should tolerate trailing spaces and base URLs with or without a trailing "/" (SPT-632, 884); Windows services (Subscription Service, GTS reader) must survive SQL being unavailable at boot (IN-68); Geotab reader must request at most 50,000 records and handle OverLimitException and rate limits (IN-200).
- GPS AVL events (BPX_AVLEvent) are kept for a 31-day rolling window, so GPS/OTP reports cannot be produced for older dates; Duplicati retention 7D:U,4W:1D,12M:1M limits historical restores. (IN-78, IN-218)
- Route change notifications sent from Dispatch must use the run times as saved after manual edits. (SPT-898)
- Unified (new-world) backups: daily snapshots, prod 90 days + monthly 365 days, non-prod 14 days; crash-consistent only; region loss not covered; no test restore yet. (IN-45)

Time & Attendance (Unified)
- Time cards are approve-only: there is no reject on shifts or in Calendar view. (PROD-266, 267, 269)
- A shift cannot be deleted; corrections are made by editing times to zero. (PROD-268)
- Once a pay period is exported its data is frozen. (PROD-267, 318)
- Job-code fields are locked once a job code is referenced. (PROD-298)
- Overtime is computed on a weekly threshold above 40 hours; the time card shows an OT alert. (PROD-314, 326)
- Audit Log access follows the edit-time-cards permission; time edits show actual and payable before/after. (PROD-322, 323)
- Absences: half-day with a time window, multi-day ranges, and full/per-day/partial undo. (PROD-271, 272, 273)
- Pay periods are associated with departments today; product says they should be associated with positions. (PROD-811)
- Clicking an employee in the dashboard overtime section does not open the time card (open ask). (PROD-783)

Unified login (planned)
- Sign-in starts with email; an email on several clients shows an organisation picker, one client goes straight to password; success lands on the Dashboard; lookups and logins are rate-limited without revealing whether an account exists. (PROD-398..407)

Infrastructure and process
- Geotab GetStatusData calls must request at most 50,000 records (Geotab's new limit). (IN-200)
- Hosted servers are sized for 40% headroom at peak CPU and RAM (CTO, 2026-10-19). (IN-136)
- SOC 2 control: every production code change is tested and approved by someone other than its author before merge, with Jira/PR evidence; test environments use test data. (SOC-38, SOC-42)

## 6. Signs of testing gaps (defects customers found)

| Area | Escaped defects | Keys |
|---|---|---|
| Regressions after a release or upgrade | Alert export split rows after 13.3.1.244; reCAPTCHA missing after 10-19 update; Delays HTML regression; spatial DB creation broken since 13.2.3.177; GPS Live dead after upgrade; StudEligErrors.txt no longer written; Workflow school groups no longer listed; fix believed released but not present | SPT-851, 847, 907, 899, 824, 872, 838, 117 |
| Turns in the field | Students missing on stops; 51K orphaned scans from card-ID format; pending scans lost; no crash recovery; wrong stop at shared locations; merged runs scan red; null-reference on Submit; duplicate student | SPT-245, 566, 585, 586, 807, 857, 856, 881, 432 |
| Parent notification delivery | Push not sent or late to Chipmunk/Delays; late notices for a cancelled bus | SPT-71, 200, 848, 849, 825 |
| Report correctness | Wrong runs by time, totals, units, PDF vs screen, silently dropped rows, rounding, date ranges, wrong-country report, role scope | SPT-507, 742, 794, 830, 879, 894, 901, 906, 909, 918, 878, 927 |
| Permissions and roles | Admin cannot save roles; menu shown without role; report empty for non-admins; disabled pane | SPT-941, 928, 918, 893 |
| Time-zone rule change | Alberta UTC-6: server clocks, scheduled tasks skipped as missed starts, Geotab EventTime 60 min behind (SDK time-zone mapping; locally built hotfix), Quick ETAs an hour old, Workflow approval timestamped before submission | IN-217, 220, 221, 222 (ENG-2971); SPT-914 |
| Scale and performance | Student Report fails above ~6-8K selected students (regression from PR 543, ENG-2042); eligibility tool slow; 25-min web report; 90-min reports; Route Map Report missed in the Background Reports migration; GeoIMS map-extent query 3.2 s x 6,000 runs after a large street import; Trips CE queries top CPU; Pro queries fixed in ENG-1553..1556. (SPT-938 removed: network-drive output, not a defect) | SPT-892, 809, 629, 408; IN-59, 72, 103 |
| Resource leaks in server components | PathServer thread/handle leak during eligibility runs (1.16M threads, 126 GB; ENG-2967); GeoIMS worker processes never exit (7 GB); Pro help launcher runaway loop exhausting a shared server; Pro crash signature (34 crashes) | IN-111, 213; IN-61, 83; SPT-897; IN-87 |
| Ridership data loss | Scan-card exact-string match orphaned ~51K scans (Pro adds a leading zero); SubmitScanEvent returned HTTP 500 on ~95% of device calls at SAPS with nothing logged | SPT-566; IN-35 |
| Service robustness after reboot / config | Subscription Service and GTS reader crash at boot when SQL is not ready and never restart; reader settings with a trailing space or missing "/" break readers | IN-68; SPT-632, 884 |
| Silent failures with no alerting | Nightly SFTP student update stopped unnoticed; BP Web emails stopped after data-centre move (Subscription Service suspended); GPS reader stopped unnoticed; Pulseway not alerting; old-world Duplicati backups failing 2 weeks; new-world prod backups stopped 37 days with no alert and no test restore ever done | IN-42, 63, 57, 116, 118, 45; PROD-799; SPT-888 |
| Data import and integrity | Duplicate enrolment rows break extracts; Staff Update leaves unsaved records; address pends; Info API missing runs | SPT-875, 912, 932, 937 |
| Money calculations | Fleet receive-transfer keeps receiving shop's cost (41 receipts at $0, 923 records to fix; still in 12.4.14); legacy 2006 work orders re-exported to SAP with wrong G/L amounts; Trips cent rounding; Additional Cost lines missing from RCBA; planned-time billing history missing 229 routes (SPT-742 removed: as designed) | SPT-933, 925, 878, 802, 794 |
| Turns merged runs / Dispatch | Merged-in students scan red/orange (Turns fixes cover AM last stop only); route-change emails send pre-correction times; Live Viewer drops valid mapping mid-run | SPT-856, 898, 886 |

## Deep read: SPT

Full description and all comments of every SPT issue (comments fetched embedded via JQL; all returned counts equal totals). Per issue only what is new beyond the digest. "Escaped" = defect a customer found in production.

Batch 1-2 (SPT-24..SPT-245)
- SPT-24, 33, 75: test tickets (Zendesk-Jira sync check). Nothing to learn.
- SPT-26: root cause not DataRemote; a weekend Dispatch refresh task caused the Quick "connection forcibly closed"/No GPS Events. Resolved without code change. Not a product defect.
- SPT-31: fix is configuration: add a GPS Vehicle ID Prefix on one reader and update vehicle IDs in SQL so IDs are unique across providers (no vendor call needed). Rule: vehicle IDs must be unique across all GPS readers on a site, or one provider's assets take over another's runs. Escaped config/design gap, customer-visible (wrong bus on runs).
- SPT-32: SDCC Chipmunk "cannot add student" resolved 07-21 without a code fix noted; possibly a non-issue per CSM.
- SPT-34: a hotfix shipped 06-17 did not fix "No GPS Events" in Quick while Pro had events; cloned to ENG-629/635. Escaped defect; hotfix failed verification in production.
- SPT-71: extension of ENG-445 (multi-day alerts not pushed to Chipmunk); General Notices also affected; duplicate of ENG-442/443. Escaped defect.
- SPT-82: answer: to cost an early-start school in Finance the Pro school year must start on the early date, and regular routes need contract events (holiday/PD) so those days cost $0. Changing the database date alone does not help. Rule recorded.
- SPT-89: as designed (example/preview view shows test students).
- SPT-99: STSCO outage 06-25 left Workflow submittals without their automatic student update; impact found by comparing submittal PublicId with the Pro student extended field holding the originating workflow, per FormVersion DatabaseGuid (NULL = default DB). Rule: every approved submittal should leave its PublicId on the student; a missing one means the update did not complete.
- SPT-117: ADO 42366 (JMCSS Workflow "view" page grade/school) shipped in 12.2.1.328 (2026-04-02); customer on that version still saw the bug. Unresolved On Hold. Possible escaped defect or incomplete fix.
- SPT-119: memory rise after 12 -> 13.1.0.14 upgrade on a self-hosted server; advice: disable "pathworker" in BP Quick settings; sizing guidance 8 cores, 32-64 GB RAM (from comparable SaaS clients, not telemetry).
- SPT-124: GUIDs differ when extended properties are created separately in each database; same GUID only if created before the DB copy. No dev fix planned; options: script to align GUIDs or look up by name.
- SPT-141: no resolution yet (Haley investigating). Expected: walking path should not require crossing a no-crossing street when students live on the stop's side.
- SPT-200: blocked on new client logs. Support checklist for a missed push: Post Alerts push setting, Subscription Service log viewer, Site Admin log viewer.
- SPT-210: Yukon BP Info errors on 13.1.1.71 resolved (DB injection). Upgrade-path defect.
- SPT-211: triage rule: Samsara reader must be the same version as BP Pro; if it is and the DB switch still errors, it is a bug.
- SPT-212: addressed in ENG-807 (clearer Right Side Service error).
- SPT-245: no comments; duplicated by ENG-1266 (Turns showed no students at stops for YSD before school start). Escaped defect at go-live.

Batch 3-4 (SPT-298..SPT-633)
- SPT-298: customer setting caused auto-assign to keep a removed school on the stop; not a defect.
- SPT-352: no comments; Chipmunk "Bus Not Reporting" (generic message; see PROD-721 for condition-specific messaging).
- SPT-361: closed; Ontario MOE dropped its plan to automate the delays report via the BP Web API; boards keep using the Web Cancellation & Delay report.
- SPT-370: by design (SSO-supplied student list overwrites the portal list). Workarounds: two portal accounts, or SSO for authentication only with BP_ContactMatching for authorisation. Needs a feature request.
- SPT-395: solved by configuration (Turns substitutions at CESD). Note: the ticket body contains a REST test-user credential; not copied, should be redacted.
- SPT-408: root cause: Route Map Report by Route was not converted to Background Reports in the first rollout; fix = convert it. Also explains STSWR and HWSTS slowness. Escaped gap (report missed in a migration).
- SPT-410: as designed. Trips SE availability = time-window overlap only; no same-day exclusion and no padding (a bus ending 5:00 PM is free for a 5:00 PM start). Rule recorded; corrects section 5's SPT-410 line.
- SPT-424: SAPS GPS Live: after an upgrade, check the GPS Live database pointer first; it was correct; still On Hold.
- SPT-432: resolved by itself (likely nightly refresh); not reproduced.
- SPT-440: NHCS/CALVERT Quick bus pass button fixed by turning on a setting (not a code fix).
- SPT-447: working after re-check; no fix.
- SPT-507: customer says the report worked before their 2026-09-04 upgrade; closed without detail (relates ENG-2306). Ministry submission data at risk. Likely escaped regression.
- SPT-539: "not a bug" (cache manager with two live DBs).
- SPT-566: full root cause: scan attribution joins BPX_AVLScanEvent.ScanCardID to BPX_AVLScanCardStudent by exact string; 2026-27 SAPS cards are 7 digits but ~3K card rows were stored zero-padded to 8 by the office card reader path (Pro demands 8 digits). Impact Sept 1-23: ~51K orphaned scan events, ~37K never attributable, ~15K double-recorded, ~2K students. Short-term: nightly SQL job adds an unpadded twin card per student (worked 10-02). Long-term fix pending: normalise at comparison time (computed indexed column), stop the padding entry path, backfill. Earlier ADO-42956 had been "resolved and released" without fixing it. Escaped defect, high impact (parents and staff cannot see who is on the bus).
- SPT-585, 586: follow-ups found by code reading in ENG-2069 (not yet reproduced); support insisted they are separate from SPT-584.
- SPT-597: duplicate of the SPT-370 question.
- SPT-629: TSTG web report 25 min after a fix; proposed missing index on BP_Address(AddressTypeGUID) including AddressGUID, EffectiveDate, RetireDate; related ENG-890.
- SPT-632: GTS reader error caused by an extra space in the GTS Reader Console settings; config, not code. Rule: reader settings should trim whitespace (testable hardening).
- SPT-633: backfilling the PGCPS 4Mativ report for past dates needs DB restores from Duplicati; the report only reflects current data.

Batch 5-6 (SPT-742..SPT-831)
- SPT-742: as designed. RCBA sums the correct per-day cost over the range, but its Time and Distance columns show ONE day's values (the last day in the range); Route Listing shows the weekly weighted average. Customer confusion arose because Sept 30 (Wed) lacked the Thu/Fri noon run. Rule recorded: RCBA total = sum of daily costs; Time/Distance = last day of range. Not an escaped defect; a usability/labelling gap. Corrects section 5's SPT-742 line (RCBA vs Route Listing differences are expected).
- SPT-761: guidance: deleting mappings is enough for mapping issues; if wrong vehicles from another operator/provider appear, delete those vehicles and their GPS events too (reader re-imports vehicles). Done 10-26.
- SPT-770, 774, 788, 807, 810, 825, 829, 830: no comments; nothing beyond the digest. SPT-774 notes escalation was delayed on BusPlanner's side.
- SPT-784: support confirmed the Ontario Operator Importer "access violation" is a bug (not data-specific).
- SPT-787: closed and re-filed as SPT-788 (reporter correction).
- SPT-791: contract values, not formulas, need changing; Fuel Escalator = f(FuelCost, BaseFuelCost, FuelEscalatorRates by vehicle size band <7, <30, <48 ...).
- SPT-794: STSI found 229 of 1,275 routes (213 Z-prefixed, 16 V-prefixed) absent from BPX_AMPMComponentHistory for Oct 1-14 (19,964 rows); the upstream capture logic is unknown to the customer; billing (planned hours) impact. Done without comments; see PROD-778 (planned times use full run span). Escaped data-capture gap affecting billing.
- SPT-801: static Dispatch training page (copy of Quick Reassign Dashboard and GPS Vehicle Assignments at 13.2.7.197, anonymised Clay data) to be hosted restricted, noindex, no-cache. Not a defect.
- SPT-802: Additional Cost line items are not included in RCBA (no column); converted to ENG work. Confirms a gap.
- SPT-808: root cause: Zonar returned "unauthorized" - credentials. Config, not code.
- SPT-809: workaround found; escalation paused.
- SPT-824: solved; GPS Live had to be tested on the customer's RDP Quick to see events (no code fix noted).
- SPT-831: training request; Pro custom reports are SSRS .rdl files loaded via File > Report/Export Wizard > Custom Report.

Batch 7-8 (SPT-834..SPT-885)
- SPT-834: StudentEligibility rows whose enrolment no longer exists are orphans and may be deleted; that clears the FK block on deleting a Travel Code. Data-hygiene gap (orphans not cleaned when enrolments are removed).
- SPT-838, 841, 844, 856, 857, 872, 875, 876, 879, 883: no comments; nothing beyond the digest except:
  - SPT-847: forms had thousands of bot submissions before reCAPTCHA; regression after the 2026-10-19 environment update; differs by viewer (client vs support). Escaped regression.
  - SPT-856: suspected cause: Turns still treats students from the other original run as not on the merged run (matches ENG-2082 at SDCC). Turns PR 674 and PR 697 (2.9.19+) only cover AM scan-off at the last stop, not PM boarding. Rule: merged-in students belong to the merged run for every stop, AM and PM. Escaped defect.
  - SPT-875: duplicate BPX_Enrollment rows for one student/school are hidden from the Student view; most imports/exports read only one row, so extracts disagree with Pro. Same pattern seen at RVS (ZD 28195, 49 students; BPX_Grade/BPX_Enrollment). No rule yet for which row is valid. Escaped data-integrity defect.
- SPT-848: created by mistake (duplicate of SPT-849).
- SPT-849: the customer is several versions behind; support asked them to upgrade, as many customers use alert push without issue. Possibly fixed in a later release; not confirmed.
- SPT-851: on hold to compare the Alert Listing export on 13.2.1.193 (pre-upgrade) with 13.3.1.244. Suspected regression.
- SPT-878: unconfirmed cause: Total Cost computed from unrounded components and rounded once, components rounded separately; 12 of a batch's trips off by +/-$0.01. Expected: Total = sum of displayed rounded components.
- SPT-880: support's assumption (not dev-confirmed) is that a temporary substitution takes priority over the bus's regular assignment for Chipmunk position/ETA; Route B parents' view is unconfirmed. Open test question.
- SPT-881: not reproduced; recurred as a different first-stop error on 10-27; device is the A9+ test tablet; may coincide with the 13.3.2 hotfix deploy. Check Sentry.
- SPT-884: stack trace shows the host "api.ca.samsara.comfleet": the reader joins the base URL and path without a "/". Either the base URL must end with "/" or the reader should join safely. Testable rule: reader accepts a base URL with or without a trailing slash. Body also contains a live API token (redact in Jira).
- SPT-885: resolved by resetting the T&A user's password.

Batch 9-10 (SPT-886..SPT-914)
- SPT-886: Dispatch Live Viewer drops a valid, unexpired mapping to "No GPS Mapping" mid-run with no substitution; workaround: re-match the GPS vehicle in the Live Viewer. Open; escaped defect.
- SPT-888: Zonar reader silently stops (outages 10-09..10-23 and again 10-26); restart from last date backfills. No alert fired. Escaped reliability/monitoring gap.
- SPT-889: one split-custody student's two-stop setup did not link to the school pickup/drop-off; fixed by hand in Bus Stop Manager; cause unknown.
- SPT-892: regression: ENG-2042 traced Msg 8623 to PR 543 (merged 2026-04-21) - Selected-students mode builds a literal IN list; failure threshold fell from >20K to ~6-8K students. Workaround: select by School/School Group/Student Group/District, or batches under ~5K. Escaped regression (scale not tested).
- SPT-893: expected: any user who can view student comments can scroll the full comment without Alter Object (Alter Object also grants edit on Student, Exception, District, School, Boundary).
- SPT-895: root cause: Microsoft September 2026 update KB5123099 on Server 2016 makes RDS hang when sessions close; fixed by KB5126868; faulty updates blocked in patching; fleet-wide (IN-195). HRCE lost BP Pro ~43 min mid-run. Infrastructure, not product.
- SPT-897: root cause: a disconnected RDS session's BusPlannerPro.exe kept launching BusPlannerHelp.exe, which kept crashing; memory exhausted, SQL starved, CPU 100% for all Web/Workflow users. Fixed by killing the session. Product defect in Pro's help launcher (runaway loop) - escaped; worth a regression check.
- SPT-898: merged double-back runs get wrong times (already ENG-1342; maybe ENG-2096); worse, "Send run changes" emails parents the pre-correction times. Rule: route-change notifications must use the times as saved after manual edits.
- SPT-899, 900, 902, 906, 907, 909, 910, 912: no comments beyond the digest, except:
  - SPT-900: BP PM accepted types per support: .pdf .xls .xlsx .ppt .pptx .doc .docx .jpg .gif .png .csv .html .txt; video upload behaviour and size limits unconfirmed.
  - SPT-906: missing FEFP rosters vary between runs of the same routes (not data-driven); header says "October Survey (2025-2026)" while dates are October 2026. Escaped defect (silent omission in a state report).
  - SPT-910: also: some Pro screens (e.g. Bus Stop Info) change retire dates on the home drop-off without the school pickup, so the halves drift; the route change log records date changes that were not saved; an operator told a school three students were off the route. Rules: Web and Pro agree on PM runs; retiring from any screen keeps both halves in step; change log records only saved changes. Escaped defect.
- SPT-901: closed and re-filed as SPT-902 (reporter correction).
- SPT-904: late status equals run start vs ETA because the tracker never recorded the first school stop; lead: a manual edit to the active vehicle mapping 20 minutes before the stop may have made the tracker reload/lose position (ENG-2631 closed earlier because tracker logs expired; retention since extended). Open.
- SPT-914: SAPS (Alberta) approval timestamped 34 min before submission (one hour offset) right after the 2026-11-01 Alberta time-zone change; list page then shows "Untreated" and blank user. Likely part of the Alberta time-zone theme (IN-217/221). Escaped defect.

Batch 11-12 (SPT-915..SPT-942)
- SPT-915, 921, 924, 927, 928, 932, 935, 940, 941, 942: no comments beyond the digest, except:
  - SPT-932: support suspects only the physical address fields are checked for equivalency, so mailing-address changes always pend; behaviour of "Don't pend if same Geocode" with equivalencies is undocumented. Test question.
  - SPT-942: Samsara Reader 13.4.227 installed but BP Pro GPS settings list only GTS and Zonar; unclear whether a licence/module flag is needed. Open setup gap.
- SPT-916: Finance (Test DB) operator invoice Outputs list empty; nightly tasks and RCBA run fine in both DBs; cause open (likely contract/output setup).
- SPT-918: reproduced on a second site (PRSD, 13.3.1.244): Student Scan Report empty for every non-Site-Admin role. Customer is piloting ridership and wants these reports before deciding. Escaped defect (role scoping).
- SPT-925: more legacy (2006) work orders re-exported to SAP on 2026-07-23, with G/L amounts that do not match the Fleet work order totals ($342 vs $310.49; $1,980 vs $258.03) and labour-only orders posted to parts inventory. Escaped defect in Fleet SAP export after data migration (money).
- SPT-933: confirmed still present in Fleet 12.4.14: receive-transfer path keeps the receiving shop's unit cost and never updates AverageCost/LastCost, while the other two transfer paths average correctly. Since 7/1: 6,931 transfer receives, 41 received at 0.00 although sent with cost; 923 part-location records at 0.00 need a data fix. Interim: Inventory > Edit Unit Cost (sets Average/Last cost since ENG-2700). Escaped defect (cost, exported work orders charged $0).
- SPT-937: BP Info /api/Run/GetAll omits some runs for a third party's API account though a test account with the same permissions gets them. Note: body contains a support test-account credential (not copied; redact).
- SPT-938: resolved: the 20-40 h Ontario Ministry Student report was caused by saving the CSV to a network drive; saving locally was fast. Not a product defect; useful triage rule (check output location before blaming report performance). Removes it from section 6 "scale" list.
- SPT-939: re-typed as a Dev Question. Current behaviour: walk distance is measured to the closest school point (location or access point). Open question whether the school location can be excluded; moving the location point may affect routing destinations.

SPT deep-read totals: 117 issues; full description of all 117; 65 had comments (all read, every comment returned); 52 had none. Credentials or tokens appear in SPT-395, 884 and 937 (keys noted only).

## Deep read: IN

Full description and all comments of every IN issue (comments embedded via JQL). IN is infrastructure; most items are not product defects. Per issue only what matters for QA.

Batch 1-3 (IN-1..IN-31)
- IN-1..IN-24 resizes: IBM Classic B1 profiles cannot be resized across families (B1 -> M1) with the attached Windows Server 2016 licence (IN-8); some target profiles do not exist (IN-21 -> mx3d-24x240). TSTG-Web has no SQL Server (IN-14). No product impact.
- IN-11/29/30: Datadog licensed for 4 hosts, rotated across customers (about $18/host plus SQL monitoring) rather than monitoring every server. Implication: most customer servers have no APM/SQL telemetry at any given time.
- IN-25: backups today are per-host Duplicati (DB + files), redundant across Toronto data centres but not to a second IBM region; target: whole-VM images replicated multi-zone, short retention, plus existing SQL backups; SQL point-in-time not yet confirmed.
- IN-26: company password manager (KeePass today, not available to all) and authenticator-app MFA (move off SMS).
- IN-27: April 2026 Windows update (CVE-2026-26151) shows a warning on every .rdp launch and turns off drive/printer/clipboard redirection by default. BusPlanner .rdp files were signed with an expired wildcard cert; re-signed with a code-signing cert but not rolled out. Only "signed + publisher thumbprint trusted via GPO/Intune" restores seamless redirection; RemoteApp/RDWeb may still re-prompt; TSTG reports it cannot enable redirection at all. Customer-visible on every hosted Pro launch; test item for any hosted-Pro check (clipboard/drive redirection for imports/exports).

Batch 4-5 (IN-32..IN-51)
- IN-32, 33, 36, 42, 46, 48: no comments; nothing beyond the digest except IN-36 (shared SQL instances are a contract question; Linux SQL considered) and IN-42 (NHCS nightly student update failed from 07-07 and kept re-running the same file until disabled; no alert).
- IN-34: Pro on Azure Virtual Desktop/FSLogix: Pro does not create or repair the GEOENVU folder (installer creates C:\geoenvu); the location can be redirected only with the GEOENVU environment variable. Per-user must-persist: Settings folder (.ini files) and BusPlanner folder; LogFiles can be excluded (daily logs, grows large); Fonts/Images/Res/Styles/Palette/Messages/MapSpace/PdfTemplates/Templates are static. Customer also reports that changing Units of Measure in one database applies to ALL databases (settings are per user, not per DB). Rule/test idea: UOM setting scope.
- IN-35: SAPS slowness, three layers: (1) SQL config: optimize-for-ad-hoc, cost threshold 5 -> 50; (2) root cause 2026-08-14: one GeoIMS polling query on BPX_AVLEvent with literal timestamps (new plan each run, 365K page reads, 20 s, all 8 cores with MAXDOP 0, tempdb flood); fixed by MAXDOP 4, tempdb move, and an index (now 5 pages per run); (3) 2026-11-02 login failures: RD Gateway UDP channel dropped sessions (176/day); UDP disabled 11-03, drops to 0. Open dev item: /Rest/api/GPS/SubmitScanEvent returned HTTP 500 on ~95% of calls from bus devices on 11-02 (20,271 errors vs 423 successes), cause not logged anywhere. Escaped defects: unparameterised GeoIMS query; silent SubmitScanEvent failures (ridership data loss).
- IN-37: CCSD weekly refresh task silently did not launch; no log, no email; comments are Zendesk-sync tests.
- IN-38: certificate renewal to be automated; public TLS max lifetime 200 days now, 100 days from March 2027, 47 days from March 2029. One shared cert covers *.mybusplanner.ca/.com, *.georef.com, *.busplannerweb.com and is bound in IIS, RDS (4 roles + listener), Tracker REST (HTTP.sys) and FTPS; match by thumbprint (file name changes). Some customers use their own domains. Risk: expired cert breaks all access without warning.
- IN-39: Attridge GPS+ server idle at ~100% memory because SQL max memory was unbounded (held 128 GB); capped at 24 GB, resized to bx2-16x64 (~$1,500/month from ~$3,000).
- IN-40: whitelisting: customer needs only its SaaS server IP and port 443 (web and RDP); browser also calls Google reCAPTCHA and OpenStreetMap.
- IN-41: RCJTC disconnects: RD Gateway HTTPS tunnel reset externally (TCP error 64, gateway event 303/1226), then RDP torn down (0xD0000001); not idle timeouts. Duo pre-auth API timeouts on 28% of logins (FailOpen = 0). Mitigation: disconnect limit raised from 30 min to 3 h (10-14) so users reconnect to their session; only sessions started after the GPO get the new limit. Still open.
- IN-43: US staging/prod k8s provisioned 2026-07-28 for the Yankton T&A go-live; US and CA fully separate (data residency).
- IN-44: offshore developer works on client DBs through a Canada-hosted PC instead of downloads (less PII scrambling).
- IN-45 (32 comments, all read): new-world (Unified) SQL servers had NO backups until 2026-08-19. Snapshot policies by tag (prod daily 90 d + monthly 365 d; non-prod daily 14 d); crash-consistent only; cross-region copy unavailable on both accounts (region loss not covered, accepted limitation). Incident: CA backup policies silently stopped creating jobs from 2026-08-31 to 2026-10-07 (37 days, prod included, two monthly backups missed) because IBM's health check stopped recognising CLI-format authorizations; no alert fires when no job is created. Fixed by re-creating authorizations in IBM's documented format. A coverage-check script exists but was not scheduled. CA dev snapshots then stuck (IBM case, resolved 10-09). US backups set up 2026-10-07, healthy daily through 11-10. Test restore never performed in either account. QA relevance: Unified prod data recoverability is unverified; "silence is not evidence of coverage".
- IN-47: PASCO slowness: SQL max memory capped at 12 GB on a 64 GB box; raised to 36 GB.
- IN-49: offshore monitoring accounts: no clipboard/drive/printer redirection, RD Gateway audit, auto-launch tracker page, read-only .rdp share.
- IN-50: MDCPS app server time drift: server synced to an external NTP instead of the domain hierarchy; fixed (NT5DS). (Recurs in IN-233.)
- IN-51: new Canadian support accounts set to never expire, because a password reset would break scheduled tasks that run under them.

Batch 6-7 (IN-52..IN-71)
- IN-52..55: resize records only (Gaston, Harnett, Miami upsized for school opening).
- IN-56: BRSD slowness: LogDNA agent removed; Defender AV exclusions added for SQL processes/files.
- IN-57: Pulseway was not alerting on CPU/RAM/service failures for any Chipmunk server; St John's, Clay and Niagara hit ~100% CPU unnoticed (support learned from customers). Reconfigured 08-14. Monitoring gap.
- IN-58: PASCO: after memory fix, tempdb moved off C: (4 files, caps); remaining slowness is query/CPU work for dev.
- IN-59: FBUS: "NOT AN INFRASTRUCTURE PROBLEM": no resource pressure; four expensive queries (including a DISTINCT StudentGUID query found only via plan-cache dump) fixed in ENG-1553..1556 (PRs 1316-1318, 1321). Escaped performance defects in Pro queries at a 2026 upgrade.
- IN-60: PGCPS BP Web outages: Client app pool workers crashed 50-75 times/day in clr.dll (0xc0000005 / COR_E_EXECUTIONENGINE) because the 176-vCPU VM split into 3 processor groups and .NET server GC built 48-64 GC heaps per worker x 8 workers; IIS rapid-fail then disabled the pool. Re-entering credentials only cleared the disabled flag. Fix 08-17: max workers 8 -> 2, idle timeout off, processor-group/GC settings; zero crashes after. Then: MAXDOP 1 -> 8 made reports faster but caused Pro freezes for some routers (parallelism overhead + forced plan); both settings changed again 08-26; busiest DBs (BPTrackerService.mdf at 32 ms/write on the boot volume) moved to 50K-IOPS volumes; second SQL server PGCPS1 built for tracker/web DBs. Infra (oversizing) caused a customer-visible outage; lesson: bigger VMs can break .NET.
- IN-61: JMCSS slowness: GeoIMS worker processes spawn under load and never exit (72 workers, 7 GB), starving SQL; restart frees memory; recurred 10-05 and 10-20; VM doubled 10-20; handed to dev as an application defect (GeoIMS worker pool leak). Escaped defect, relates ENG-2802.
- IN-62: CALVERT lag: resources fine (resize only if memory >90%); needs dev root cause.
- IN-63: First Student sites stopped sending all BP Web email after the July data-centre move; 7 of 8 fixed by re-running the web installer; Prince Albert fixed when found that the Subscription Service was Suspended. Silent failure for weeks.
- IN-64: CrushFTP upgraded to 11.5.5 (10-14) without a pre-upgrade snapshot (last snapshot June 2025); hash validation shows a stale CrushFTPJarProxy.jar needing a manual swap. Process gap (no rollback point).
- IN-65: FBUS: "Find Student" fast for the first few searches then slow; path server had to be restarted to show the 26-27 DB; DB pool 70 -> 120 helped briefly. (Merged into IN-59 work.)
- IN-66: CTSO: RAM increase NOT needed; SQL capped at 45 GB on a 64 GB box starved BusPlanner Server/GeoIMS/IIS (5.5 GB); fix is lowering the SQL cap. Rule: on single-box installs, leave memory for the app tier.
- IN-67: NCPS: SQL capped at 50 GB on 255 GB, MAXDOP 1; raised to 80 GB, MAXDOP 8, Query Store on; dominant bottleneck is storage write latency. App findings for dev: ss_Setting looked up ~37 times/second (needs caching, all sites); something queries a 2021-22 archive tracker DB 4.9M times. Nightly Duplicati full-backs up 52 unchanging historical DBs (5.6 TB in 14 days).
- IN-68: PSPT Subscription Service and GTS reader crash at startup after Windows Update reboots (SQL login fails ~30 s after boot; exception unhandled in OnStart) and nothing restarts them; email down Aug 18-26. Product defect: services should retry/handle SQL unavailability at start; recovery actions should be configured. Escaped defect.
- IN-69, 70: no comments; distribution list; OSTA memory 98%.
- IN-71: SAPS: IBM had to enable the target resize profile; customer reports Pro/Dispatch/Web slower as more staff log in each morning and slower than last year.

Batch 8-9 (IN-72..IN-92)
- IN-72: SWOSTS (self-hosted, 4-core SQL): no memory shortage or blocking; CPU contention from expensive Trips (BPTripsCE) queries, high ad hoc compile rate, old-year DBs, GeoIMS; SQL 2022 on RTM with no CUs. Same report 6 min quiet vs >1 h under load. Customer patched SQL, pruned old trips/DBs; ENG-1590 (13.2.3) may help GEO table queries; customer at risk of leaving for a competitor. Product finding: Trips CE queries are a top CPU consumer.
- IN-73: duplicate of IN-71.
- IN-74: PGCPS third SQL server (.22) built; LIVE_2627 DB moved .20 -> .21 -> .22 with row/schema hash verification; RemoteApp failed until inbound 443 security group added.
- IN-75: HRCE Web slowness: not BPWeb; instance-level parallelism defaults (MAXDOP 0, threshold 5) and missing indexes on ss_SMSQueue, ss_QueueStatus, wf_Comment (SMS poll query 2,936 -> 4 reads). Product finding: those three indexes should ship with BP Web.
- IN-76: offshore analysts given Pro and SQL access (reversal of IN-49 controls).
- IN-77, 85, 86, 92: no comments. IN-85: MDCPS RemoteApp "Element not found": a clock excursion made RD Connection Broker write invalid datetimes (SQL error 535 datediff overflow); third clock drift on that host.
- IN-78: PGCPS historical OTP report: SQL 2019 Web Edition caps the engine at 16 cores / 64 GB (32 of 176 processors visible); MAXDOP was 1 on .20; changed to 8. Rule: BPX_AVLEvent keeps a 31-day rolling window (~3M GPS events/day), so OTP reports for older dates cannot be produced. BusPlanner Pro writes ~25,000 errors/day to the Windows Application log (log only holds 3.3 h).
- IN-80, 81, 88, 89: internal/resize/VPN. IN-81: Indian River Chipmunk down at CPU/RAM 99%; resized.
- IN-82: CSSBE user locked out by a hung RDS session (single-session limit); reboot cleared.
- IN-83: ECSD high memory is normal SQL caching; real issue is GeoIMS memory leak - re-assigned to dev. Escaped defect (GeoIMS, same as IN-61).
- IN-84: TSTG app server logon hang: UmRdpService hang wedged session notifications; matches Microsoft known issue with September update KB5122876 (Server 2019), fixed by KB5126651 installed 10-20.
- IN-87 (14 comments): PGCPS "kicked out / Pro closes / slow login" were three problems: (1) whole-VM stalls of 6-42 s triggered when Windows turns the display back on at a staff full-desktop logon (fix: display-off timeout disabled 10-15; IBM also moved the VM off a tainted node); a stall on 10-06 made the system clock run ~20x fast for 6 min and broke the Tracker (clock 1h48m ahead) - W32Time hardened; (2) a 10-minute disconnect timeout destroyed sessions (fixed); (3) BP Pro crashes: 34 shared one deterministic signature, fixed by development (around 10-02). After every stop/start the clock boots 4 h ahead until W32Time corrects it; Geotab reader services crashed on first start (error 1064) after a restart. Escaped Pro crash defect; tracker sensitive to clock jumps.
- IN-90: FBUS www29: IBM console showed the VM "Halted" while Windows ran; BP Web /Alerts.aspx/GetGeneralNotices averaged 121 s per call for hours before staff noticed; 117 SQL "non-yielding scheduler" events; suspect outdated XenTools (2020) after IBM host migration. Open with IBM.
- IN-91: PASCO: server has headroom; slowness is app-to-SQL chattiness and undone IN-58 dev work; rerouting 3 runs around a sinkhole took 1 hour; Quick GPS Live up to 5 min to load buses so the call centre uses a third-party tracker.

Batch 10-11 (IN-94..IN-113)
- IN-94: corporate FTP licence allows 10 concurrent connections; lingering ftpadmin sessions made the QA2 deployment's FTP download fail ("Max user limit reached"); ftpadmin idle timeout set to 15 min. QA pipeline impact.
- IN-95: AUSD RD Gateway: Duo caused CAP failures; the RDS deployment's gateway name was the internal .corp FQDN, so every RDWeb-generated .rdp pointed at an unresolvable gateway (wildcard cert covers only one label of *.mybusplanner.com). Fixed 10-01; a second, intermittent fault on the district network remained. Rule for new hosted servers: published .rdp gatewayhostname must be the external FQDN (also explains IN-88).
- IN-96, 97, 98, 99, 100, 101, 102, 105, 107, 110, 112: internal/IT; nothing for QA except IN-102/112 (customer LIVE DB backups restored to QA SQL servers for testing; browser downloads from CrushFTP produced 0-byte files, curl with resume works) and IN-107 (Duplicati backups of live .mdf files fail when Windows deletes the VSS shadow mid-run).
- IN-103: PSD slowness: not resources. (1) A support user loaded the AB_Streets layer into LIVE during school hours (577,865 map changes/day vs normal 20-170); PathServer reloads the whole street network on every change (397 reloads). (2) After the weekly web DB refresh copied 681K street segments, the main GeoIMS map-extent query (parent tracking/web portal) became a 3.2 s single-threaded query run ~6,000 times, doubling bus-run CPU. Handed to dev. Rules: map imports belong outside operating hours; GeoIMS map-extent query must scale with large street layers. Escaped performance defect.
- IN-104: internal VSI hung after a TOR01 data-centre network incident (2026-10-02); IBM blames outdated XenServer tools.
- IN-106: NS clients (AVRCE, CBVRCE, SRCE, TCRCE): SQL Server failed to start after Windows Update reboots on 08-31 because the shared service account was locked out. Root cause (10-28): internet password-spray against RD Web Access sign-in pages (/RDWeb/Pages/en-US/login.aspx) on client servers - ~1.57M failed sign-ins in 24 h across 18 servers - repeatedly locking the SQL service account. Fix: automatic IP blocking rolled out; failed sign-ins down 96-99% where deployed; two servers cannot be protected (firewall off); lockouts down to 1/day. Security/availability risk shared across customers via one service account.
- IN-108: TSTG 10-06 disconnects: RCA done (network-path analysis); no product cause recorded.
- IN-109: FTP slowness that delays QA1/QA2 deployments (upload 12 min vs 2-3; download >1 h; failed deploys) caused by the AWS t3.medium FTP server exhausting CPU credits (throttled to 20%). Directly affects QA environment build delivery.
- IN-111: CCSD: PathServer.exe 12.2.1.223 leaks threads/handles (1.16M threads, ~7M handles, 126 GB after 26 days; ~5,000 threads/hour during eligibility runs); crashed 10-09 (ucrtbase 0xc0000409); leak confirmed and tied to CalculateEligibility runs; eligibility tasks still exceed their 72 h limit (each school 1-3 h). Escaped product defect (PathServer leak), relates ENG-2777/2967/2968.
- IN-113: PGCPS login outage 10-08: TermService hung (sessions not created though passwords accepted); Pulseway checks only that a service is "running", so nothing alerted. Watchdog script + event-log alerting + dump-capture runbook added.

Batch 12-14 (IN-114..IN-139)
- Mostly internal IT / no comments (IN-114, 119, 121, 124, 125, 129, 131, 132, 134). Notable:
- IN-115: SDCC: nightly pre-refresh backup of the Dispatch DB so a day of dispatch can be audited after the nightly refresh overwrites it (Dispatch is a refresh of Live); retention 7 days, asked to keep indefinitely offsite.
- IN-116, 118: Duplicati 2.0.5.1 beta (2020) SQL backup jobs failed silently for ~2 weeks (last good Sep 22/23) on STSCO and FBUS servers ("files missing from remote storage"); repaired 10-09. Backup monitoring gap on old-world servers.
- IN-117: CI "Docker build & push to ICR" blocked by a 2 GB registry storage cap per account (85-125 MB per image); raised to 5 GB. Pipeline impact for QA environments.
- IN-120: Projects team given IBM Cloud and k8 prod/staging SQL logins for new-world setup (mirrors developer access).
- IN-122, 123, 127, 128: C: drive full (browser caches per user), stuck RDS session needing a VSI power cycle, recurring memory alerts on six servers, automated C: clean-up.
- IN-126: monthly SaaS maintenance: Windows updates on all IBM VSIs via Pulseway on a Friday 9 PM ET window, with reboots. (These reboots triggered IN-68 and IN-106 service failures.)
- IN-130: HPSTS www45 froze 10-02 19:23 for ~59 h with no crash; consistent with the TOR01 data-centre incident (IN-104); unnoticed over a weekend.
- IN-133: customer FTP uploads restricted by source IP on Core FTP Server; customer IP change broke nightly uploads.
- IN-136/137/139: IBM bill CAD 246K (Aug) -> 322K (Sep); right-sizing saves ~CAD 43K/month; CTO rule 40% headroom at peak; usage measured by Pulseway 7-day script (fails on PGCPS1/2). Downsizes run on evenings with maintenance mode and a service check. QA note: performance complaints may follow downsizes; compare against the resize dates.

Batch 15-18 (IN-140..IN-179)
- IN-140..152: all downsizes executed the evening of 2026-10-20 (maintenance mode, resize, service check). Several stopped at an intermediate size (e.g. HPSD cxf-24x48, YSD cx2-32x64). Sub-tasks IN-153..179 (except 164) have no comments; descriptions are the step plans already in the digest.
- IN-164: ECSD could not log in to RemoteApp all day 10-19 (gateway fine; sessions hung on creation); root cause: September 2026 cumulative update KB5122876 (Server 2019) RDS hang, installed in the 10-16 patch window; fixed by the October update. Same root cause as IN-84, IN-195 and SPT-895 (Server 2016 variant). The monthly patch window itself caused customer outages.

Batch 19-21 (IN-180..IN-204)
- IN-180..193: resize sub-tasks, no comments.
- IN-194: Pulseway 7-day usage script failed on PGCPS1/2 because performance counters were not collecting; started 10-20.
- IN-195: fleet audit 10-20: 54 servers had the faulty September 2026 Windows update without a fix (36 Server 2019, 17 Server 2016, 1 Server 2022); patched case by case as customers hit RDS hangs (ECSD, TSTG, CCSD, Southland, CSAP, HPSTS, MDCPS, WWW21...). Any hosted-Pro customer can lose logins until patched.
- IN-196: ops log: an internal web status dashboard service ran under a departed/personal account and failed when its password changed; Unified ETL design (per-client COS keys, ENG-2534) reviewed; more Duplicati SQLite consistency errors on two servers (backups not verified after repair).
- IN-197: CCSD nightly SFTP upload of the student/contacts CSV failed for days because a support user's LibreOffice session on the server held the file open. Process gap: support should not open live import files in place.
- IN-198: onboarding.
- IN-199: PHP shell CVE audit: no PHP on the six Ubuntu SQL hosts (re-verified 11-10).
- IN-200: Geotab Reader hard-codes resultsLimit 200,000 on Get:StatusData (Geotab cap 50,000) and also exceeds Geotab's per-minute request limits; needs a code change and release (back to dev). Rule: reader must handle OverLimitException and respect rate limits. Product defect found by a third party.
- IN-201: CLASS www18: Windows Update broken since June (wuauserv crashing every 2.5 min; last patch Feb 2026); fixed; SQL parallelism defaults tuned (CXPACKET gone, one-off plans 4.9 GB -> 21 MB). Server unpatched for 8 months unnoticed.
- IN-202: TSTG Pro "Not Responding" during Delete Unused Vehicles (~4,000 vehicles) coincided with recurring 98% CPU bursts every 10 min (Sep 22 - Oct 16) that stopped after a restart. Test idea: bulk vehicle delete at scale.
- IN-203: STEO downsized pending SaaS move.
- IN-204: TSTG 25 sessions dropped 10-23: customer-side network (TDSB/TCDSB); 10-minute disconnected-session timeout then logged off 16 users (lost work). Same as IN-108.

Batch 22-25 (IN-205..IN-239)
- IN-205: no report or screen shows how many BP Web parent accounts have 2FA on (gap; see PROD-920).
- IN-206, 218, 238 (ops logs; all comments read, including IN-218's first one): NCPS nightly BPT_DispatchRefresh (backup Live, restore to _DISPATCH) took ~1.5 h because it competed with the nightly Duplicati job on the same disk; Duo RD Gateway plugin v2.3.0.18 (installed 9/29) denied some users; RCJTC portal certificate chain incomplete after renewal (Chrome-only error); a support RDS broker DB had no session rows for two MDCPS users (RemoteApp "not registered with RD Connection Broker"); Duplicati retention 7D:U,4W:1D,12M:1M means backups older than 12 months (and most daily ones older than 4 weeks) are gone, so old-date restores are not possible (ENG-3026); nightly dev builds older than ~1 week are deleted from busbox1; security alerts on staff endpoints were false positives from Claude Code.
- IN-207, 209, 212, 232, 234, 237: onboarding/access/security; IN-209 MFA abuse after a stolen phone was contained.
- IN-210: STOPR backup cleanup fails after NTLMv2-only hardening because the delete step runs as the scheduled-task account (not SQL's) and fails to authenticate to the share; not a product incompatibility.
- IN-211: STSBHN board SFTP failure is specific to FileZilla against Core FTP Server (build 2022); WinSCP works.
- IN-213: CCSD: recurrence of the PathServer thread leak (IN-111) during the Saturday-Wednesday eligibility window; caused an unexpected shutdown on 10-29 and incomplete eligibility results; ENG-2967 created and ranked top priority. Escaped defect.
- IN-214: NLESD login failures were on the customer network.
- IN-215, 216, 219, 222, 231, 233, 236, 239: no comments beyond the digest. IN-222: AACS data stored correctly but Quick Live GPS showed "1 hr ago" (display-side offset). IN-231: HERTZ users booted from Pro and the GPS tab disappears after reconnect, requiring the module number to be re-entered. IN-239: Geotab fix ENG-2971 released in 13.4.2.
- IN-217: Alberta adopted permanent UTC-6 in 2026; servers on "Mountain Time" fell back on 11-01. Fixed by Microsoft's new "(UTC-06:00) Mountain Time (Alberta)" zone on ~23 Alberta client servers (some lacked it until the October cumulative update).
- IN-220: after the zone change, Task Scheduler kept the old offset until restart, so every scheduled task woke an hour late and was skipped as a missed start (0x800710E0); CBE and LPSD lost a morning of tasks (no BPScript logs). Rule: restart Task Scheduler (reboot) after a time-zone change.
- IN-221: the Geotab Reader takes its time-zone mapping from the Geotab SDK, so it kept old Mountain rules: GPS EventTime 60 min behind from 11-01 to 11-04 for ~35 Alberta customers; Quick Live GPS "No GPS Events", Bus Stop Compare failed, pre-trip inspection and scan times off by an hour. Hotfix (ENG-2971) built locally from a hotfix branch, not by the pipeline, and installed per server (IN-223..229); the reader fix works only if the server has the new Alberta zone. Escaped defect; release-process note (locally built hotfix).
- IN-230: new-world VPN: IBM can change the client VPN server IP during maintenance, silently breaking security-group rules (prod SQL unreachable; US VPN users could never reach US staging/prod SQL). Fixed with dedicated /28 VPN subnets and a drift-check script.
- IN-235: Brotli CVE check: TSTG clean; fleet scripts via Pulseway check IIS Brotli module and .NET runtimes (patched 8.0.33 / 9.0.22 / 10.0.14).

IN deep-read totals: 235 issues; every description read; comments read on all 108 issues that have them (IN-45 and IN-218 needed extra paging; all 32 and 21 comments read). No secrets copied (IPs, keys, hashes, passwords omitted).
