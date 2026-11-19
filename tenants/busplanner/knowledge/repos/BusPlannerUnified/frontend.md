# BusPlannerUnified — Web client (front end) map

Snapshot: commit 0137276 (read-only copy under `repos/BusPlannerUnified`). Mapped 2026-11-10 by static reading only (no builds or tests were run).
Path convention: `client/...` = `BusPlannerUnified/client/...` from the repo root; `docs/...` and `pipelines/...` are repo-root. `:N` = line number.
Anything marked UNVERIFIED is inferred, not read directly.

## 1. Stack

| Concern | What | Evidence |
|---|---|---|
| Framework | React ^19.2.0, react-dom ^19.2.0, TypeScript ~5.9.3 (`strict`, `noUnusedLocals`) | `client/package.json:26-27,56`; `client/tsconfig.app.json:20-22` |
| Build | Vite ^7.3.1 + `@vitejs/plugin-react`; dev server port 3000; `build` = `tsc -b && vite build` | `client/package.json:7-8,58`; `client/vite.config.ts:4-9` |
| UI library | None (no MUI/Ant/Tailwind). Hand-rolled components in `src/components/ui` (Button, Dialog, ConfirmProvider, MultiSelect, SearchInput, StatusBadge), inline styles + `src/index.css`, `src/theme/tokens.ts`; icons `lucide-react`; font `@fontsource-variable/outfit` | `client/package.json:14-33`; `client/src/main.tsx:5-7` |
| Design system | Proposal stage only: "Nothing here is implemented yet" (tokens.css, Storybook, `--bp-*` vars are planned). GPS Plus has its own palette `src/pages/gpsplus/theme.ts`; chatbot has `chatTheme.ts` scoped to `.bp-chat-scope` | `docs/design/README.md:3`; `docs/design/gpsplus-contrast-findings.md:6`; `client/src/components/chatbot/CLAUDE.md:17` |
| Reads | GraphQL via Apollo Client ^4.1.6 (`/graphql` on the API, `cache-and-network`). `gql` documents are inline in pages (only `src/graphql/client.ts` exists in `graphql/`). List pages page through every cursor with `useAllNodes` | `client/src/graphql/client.ts:10-37`; `client/src/hooks/useAllNodes.ts:6-35` |
| Writes + some reads | REST via axios ^1.13.6 (`src/api/axiosClient.ts`); GPS Plus, payroll export, chatbot, tenant/login use REST GETs too | `client/src/api/axiosClient.ts:31-54`; `client/src/pages/gpsplus/events/__tests__/useEventLog.test.tsx:56-65` |
| Chatbot transport | SSE over `fetch` + `ReadableStream` (not `EventSource`), bearer header | `client/src/components/chatbot/CLAUDE.md:40-41` |
| Forms | `react-hook-form` ^7.71.2 (LoginPage; other pages UNVERIFIED) | `client/src/pages/LoginPage.tsx:1,48` |
| Maps / export | `leaflet` ^1.9.4 + `react-leaflet` ^5; `jspdf` + `jspdf-autotable` (timesheet PDF); `react-markdown` + `remark-gfm` (chat) | `client/package.json:22-32` |
| Routing | `react-router-dom` ^7.13.1, `BrowserRouter`, one flat `<Routes>` in `App.tsx`. (docs/testing/FrontendTests.md:8 says "v6" — stale) | `client/package.json:31`; `client/src/App.tsx:79-148` |
| Auth library | None third-party. Custom `AuthContext` + JWT in `localStorage` | `client/src/auth/AuthContext.tsx` |
| Monitoring | Datadog RUM, only when `config.json` has a `dd` block | `client/src/main.tsx:46-68` |

**Login flow** (`client/src/pages/LoginPage.tsx`)
1. Email-first: step `email` -> `POST /api/tenant/resolve-email` -> 0 clients = account-not-found copy; 1 client = step `password`; >1 = step `picker` (org chooser) then `password` (`:138-161`, `client/src/api/tenantApi.ts:38-41`).
2. `?client=<code>` deep link: `GET /api/tenant/by-code`; states `resolving/invalid/inactive/error/ok`; `ok` shows a combined email+password screen and skips the lookup (`:61-102`, `:252-258`; `tenantApi.ts:19-29`).
3. Submit -> `POST /api/auth/login {email,password,clientCode}` (`client/src/api/authApi.ts:18-21`); failure always shows `INCORRECT_PASSWORD_MESSAGE` (`LoginPage.tsx:39-40,180-182`).
4. Response is persisted to `localStorage` keys: `bp_token, bp_expiresAt, bp_email, bp_fullName, bp_clientCode, bp_permissions, bp_customerAccess, bp_departmentAccess, bp_schoolAccess, bp_districtAccess, bp_operatorAccess, bp_depotAccess`, later `bp_displayTimeZone, bp_isDistrictZone, bp_hoursFormat` (`AuthContext.tsx:54-70,244-270`).
5. After login navigates to sanitized `?redirect=` target, else `/`; `/` (`LandingRoute`) resolves the first module the user may open (T&A, then GPS Plus), else `/no-modules` (`LoginPage.tsx:133`; `client/src/pages/LandingRoute.tsx`; `client/src/modules/registry.ts:22-67`).
6. After auth, two session reads: district time zone and hours format (`AuthContext.tsx:177-207`). Failures are silent (UTC / DECIMAL fallback).
7. Session expiry: any 401 from axios or Apollo clears storage and hard-redirects to `/login?expired=1&redirect=...` (`axiosClient.ts:16-27,46-54`; `graphql/client.ts:25-29`). Deliberate logout does not carry a redirect (`client/src/auth/ProtectedRoute.tsx:23-31`).
8. Not in V1: SSO, forgot-password, keep-me-signed-in (`LoginPage.tsx:42-44`).

**Runtime config**: `/config.json` fetched before first render; required `apiUrl`, optional `dd` block; boot fails loudly with a `<pre>` error if missing (`client/src/runtimeConfig.ts:39-62`; `main.tsx:15-28`). Local value `apiUrl = http://localhost:5000` (`client/public/config.json`). CI overwrites `dist/config.json` per environment (`runtimeConfig.ts:4-6`). No `.env*` files exist in `client/`; the only build-time env read is `import.meta.env.DEV` -> `IS_DEV_BUILD` (`client/src/utils/buildEnv.ts:5`). `VITE_API_URL` in docs/testing/FrontendTests.md:10 is stale.

## 2. App structure (`client/src`)

| Folder | Contents |
|---|---|
| `App.tsx`, `main.tsx`, `runtimeConfig.ts` | Provider tree (Apollo > Auth > Confirm > Router > ChatbotProvider), all routes, boot |
| `pages/` | Top-level: Login, Landing/Dashboard routes, DashboardPage (dev-build tile grid), NoModules, Customers, Roles, Users, ChatbotAdmin, AskAi, MapTest |
| `pages/ta/` | Time & Attendance: 27 page components plus pure logic modules (`shiftHours.ts`, `timecardCalc.ts`, `weeklyBreakdown.ts`, `timescanCsv.ts`, `timesheetPdf.ts`, `overtimeData.ts`, `toleranceThresholds.ts`, `payCycleSummary.ts`, `rosterScope.ts`, `timeText.ts`, `workWeek.ts`, `taSettingCatalog.ts`), `RecalculatePayableDialog.tsx` |
| `pages/gpsplus/` | GPS Plus: `GpsLiveViewerPage`, `GpsPathComparePage`, `events/GpsEventViewerPage`, `GpsComingSoonPage`; subfolders `live/`, `compare/`, `events/`, `shared/`; `surfaces.ts` (labels, paths, permissions), `theme.ts` |
| `pages/analytics/` | `StopClassificationPage` (8 tabs, `client/src/pages/analytics/CLAUDE.md:8-16`), `RouteVehicleMismatchPage` |
| `modules/` | Module registry: `ta` (gate: any `ta:` permission), `gps` (gate: any GPS read permission); drives landing, product rail, Access Denied link (`modules/registry.ts:22-40`) |
| `microapps/` | Dashboard microapp contract + registry + event bus; one registered microapp (T&A overtime) mounted directly by `TADashboardPage`; grid shell not built (`microapps/registry.ts:1-10`, `microapps/types.ts:1-6`) |
| `components/` | `ui/`, `grid/ConfigurableGrid.tsx` (shared list grid, ~1000 lines), `layout/` (AppShell, Sidebar, NavPanel, GpsTopBar, PageHeader), `map/` (BPMap = Leaflet wrapper, popups, wkt), `chatbot/` (dock, Ask AI page parts, `renderers/` for table/chart/map/report/link/text), `ErrorBoundary.tsx` |
| `api/` | One axios module per area: auth, tenant, session, users, roles, customers, departments, depots, districts, operators, schools, shifts, analytics, map, planningMap, gpsPlusCompare, chatbot, chatbotAdmin |
| `graphql/` | `client.ts` only (Apollo client + auth link + 401 link) |
| `hooks/` | `useAllNodes` (cursor paging), `useDebouncedValue`, `useSessionViewState` |
| `auth/` | `AuthContext`, `ProtectedRoute`, `redirectTarget` (sanitizer), `useLogout`, `session.ts` |
| `utils/` | `date.ts` (calendar dates), `timeZone.ts` (district-zone instants), `hoursFormat.ts`, `viewStateStore.ts`, `a11y.ts`, `buildEnv.ts` |
| `dev/` | `chartGallery/` — QA chart gallery served by `client/chart-gallery.html` on the dev server only; never built for release (`chatbot/CLAUDE.md:27`) |
| `__mocks__/` | Jest module stubs (section 4) |

## 3. Screen inventory (from `client/src/App.tsx:83-147`)

Gate = `ProtectedRoute` (`client/src/auth/ProtectedRoute.tsx`): not signed in -> `/login?redirect=`; missing permission/module -> inline "Access Denied" + link to the user's landing module. There are no client-side roles, only permission strings.

| Route | Page | Purpose | Required |
|---|---|---|---|
| `/login` | LoginPage | Email-first sign-in, `?client=`, `?expired=1`, `?redirect=` | public |
| `/` | LandingRoute | Redirect to first permitted module | signed in |
| `/no-modules` | NoModulesPage | Signed-in user with no module | signed in |
| `/dashboard` | DashboardRoute | Dev build: tile grid (only entry to Analytics, Map Test, Payroll Simulator). Release build: redirect like `/` (`pages/DashboardRoute.tsx:12-22`) | signed in |
| `/customers` | CustomersPage | Customer (district) CRUD incl. time zone | `customer:read` |
| `/admin/roles` | RolesPage | Roles and permissions | `admin:roles` |
| `/admin/users` | UsersPage | User accounts | `admin:users:read` |
| `/admin/chatbot` | ChatbotAdminPage | Conversations, flagged messages, corrections, test cases | `admin:chatbot:read` |
| `/ask-ai` (`ASK_AI_PATH`, `components/chatbot/chatSession.ts:59`) | AskAiPage | Full-page chatbot; also needs the client's CHATBOT flag (`GET api/chatbot/availability`) | `chatbot:read` |
| `/ta` | TADashboardPage | T&A dashboard | module `ta` (any `ta:*`) |
| `/ta/timesheet` | TimesheetPage | Time Card: shifts, edits, approvals | `ta:shift:read` |
| `/ta/audit-log` | AuditLogPage | Audit log | `ta:auditlogs:read` |
| `/ta/absences` | AbsencesPage | Absences | `ta:absence:read` |
| `/ta/trip-credits` | TripCreditsPage | Trip credits | `ta:tripcredit:read` |
| `/ta/admin/employees` | TAEmployeesPage | Employee roster, CSV import/export, custom fields | `ta:employee:read` |
| `/ta/admin/departments` | DepartmentsPage | Departments | `ta:department:read` |
| `/ta/admin/positions` | PositionsPage | Positions | `ta:position:read` |
| `/ta/admin/job-codes` | JobCodesPage | Job codes | `ta:jobcode:read` |
| `/ta/admin/absence-types` | AbsenceTypesPage | Absence types | `ta:absencetype:read` |
| `/ta/admin/holidays` | HolidaysPage | Holidays | `ta:holiday:read` |
| `/ta/admin/locations` | LocationsPage | Locations | `ta:location:read` |
| `/ta/admin/pay-periods` | PayPeriodsPage | Pay periods | `ta:payperiod:read` |
| `/ta/admin/schedules` | SchedulesPage | Schedules | `ta:schedule:read` |
| `/ta/admin/rounding-rules` | RoundingRulesPage | Rounding rules | `ta:roundingrule:read` |
| `/ta/admin/employee-fields` | EmployeeFieldsPage | Custom employee fields | `ta:employee:read` |
| `/ta/admin/shift-templates` | ShiftTemplatesPage | Shift templates | `ta:shifttemplate:read` |
| `/ta/admin/approval-steps` | ApprovalStepsPage | Approval steps | `ta:approval:read` |
| `/ta/admin/settings` | TaSettingsPage | T&A settings | `ta:tasettings:read` |
| `/ta/admin/work-week` | WorkWeekPage | Work week | `ta:tasettings:read` |
| `/ta/admin/assignments` | AssignmentsPage | Employee-position / position-job-code / employee-location links | `ta:employee:read` |
| `/ta/payroll-export` | PayrollExportPage | Export wizard (freezes pay period) | `ta:payperiod:read` |
| `/ta/payroll-export/history` | PayrollExportHistoryPage | Export history | `ta:payperiod:read` |
| `/ta/payroll-simulator` | PayrollSimulatorPage | Dev/QA tool, no nav entry (`pages/DashboardPage.tsx:33-40`) | `ta:payperiod:read` |
| `/ta/pay-cycle-summary` | PayCycleSummaryPage | Report | `ta:payperiod:read` |
| `/ta/overtime` | OvertimePage | Overtime | `ta:shift:read` |
| `/ta/year-start-wizard` | YearStartWizardPage | Generate holidays + pay periods for a year | `ta:holiday:write` |
| `/analytics/stop-classification` | StopClassificationPage | 8-tab stop classification analytics | `analytics:read` |
| `/analytics/route-vehicle-mismatch` | RouteVehicleMismatchPage | Vehicle/route mismatch | `analytics:read` |
| `/gps-plus` | GpsIndexRedirect | Redirect to first permitted GPS surface (`App.tsx:68-72`) | signed in |
| `/gps-plus/live-viewer` | GpsLiveViewerPage | Live fleet table + map, pins, route management | `gpsplus:live:read` |
| `/gps-plus/path-compare` | GpsPathComparePage | Planned vs actual path and stop compare | `gpsplus:compare:read` |
| `/gps-plus/event-viewer` | GpsEventViewerPage | GPS event log + map | `gpsplus:events:read` |
| `/gps-plus/device-mapping` | GpsComingSoonPage | Placeholder only | `gpsplus:devicemapping:read` |
| `/map-test` | MapTestPage | Dev map test | signed in |
| `*` | — | Redirect to `/login` | — |

Action-level permissions seen in code (not routes): `ta:employee:write`, `ta:employee:delete` (`pages/ta/__tests__/TAEmployeesPage.test.tsx:63-66`); `gpsplus:routemanagement:write`, `gpsplus:devicemapping:write` (`pages/gpsplus/surfaces.ts:26-31`). GPS permission names must be kept in sync by hand with the server `Permissions.cs` (`surfaces.ts:19-21`). Sidebar nav items carry the same permissions as routes (`client/src/components/layout/Sidebar.tsx:64-102`); "Smart Mappings" and "Dispatch" are placeholders with no route (`surfaces.ts:47-48`; `modules/registry.ts:17-20`). The floating chat dock appears on every page when chatbot is available, hidden on `/ask-ai` (`chatbot/CLAUDE.md:15`).

## 4. Test setup

| Item | Value | Evidence |
|---|---|---|
| Runner | Jest ^30.3.0, `jest-environment-jsdom`, `ts-jest` ^29.4.6 using `tsconfig.test.json` | `client/package.json:51-54`; `client/jest.config.ts:4-9` |
| Libraries | `@testing-library/react` ^16.3.2, `user-event` ^14.6.1, `jest-dom` ^6.9.1, `jest-axe` ^11 | `client/package.json:36-38,52` |
| Discovery | Only `**/__tests__/**/*.test.ts(x)`. A test file outside a `__tests__` folder is silently never run | `client/jest.config.ts:22`; `client/CLAUDE.md` ("Other client conventions") |
| Global setup | `jest.polyfills.ts` (TextEncoder/Decoder); `jest.setup.ts`: jest-dom, RTL `asyncUtilTimeout` 5000 ms, `jest.setTimeout(20000)`, resets `IS_DEV_BUILD` mock to `true` after each test | `client/jest.setup.ts:21,27,31-33` |
| Auto-mapped mocks (`moduleNameMapper`) | any `.../api/axiosClient` and `./axiosClient` -> `src/__mocks__/axiosClient.ts` (all verbs `jest.fn()` with no default return, plus `handleSessionExpired`); `.../graphql/client` -> empty stub (exports `graphqlClient`, not `apolloClient`); `.../utils/buildEnv` -> settable `IS_DEV_BUILD`; CSS -> `identity-obj-proxy` | `client/jest.config.ts:10-19`; `client/src/__mocks__/*.ts` |
| MSW | Not used (not in `package.json`) | `client/package.json` |
| Shared helpers | No global custom render. `renderWithProviders` / `src/__tests__/testUtils.tsx` described in docs/testing/FrontendTests.md:68-125 does not exist. Local helpers only: `components/chatbot/__tests__/sessionHarness.tsx` (`makeSession`, `SessionHarness`), `pages/gpsplus/live/__tests__/factories.ts` (`makeRow`, fixed instants `T`, `TZ`), `pages/gpsplus/events/__tests__/fixtures.ts`, `renderers/__tests__/{chart,link,report}Fixtures.ts` | file listing; `sessionHarness.tsx:10-14`; `factories.ts:3-14` |
| Coverage | No `coverageThreshold`, no `collectCoverage`, no coverage script, nothing published in CI | `client/jest.config.ts`; `pipelines/templates/frontend-build-test.yml` |
| Time zone pin | None in jest config (no `TZ` set). UNVERIFIED whether any test depends on the machine zone | `client/jest.config.ts` |
| Scripts | `dev`, `build`, `lint`, `lint:prune`, `preview`, `test` (= `jest`) | `client/package.json:6-13` |
| Size | ~158 test files, 23 of them `*.a11y.test.tsx` (counted from the file listing) | `client/src/**/__tests__` |

Commands (run from `BusPlannerUnified/client`; standard Jest CLI — not executed during this mapping):

```
npm ci                                              # install
npm test                                            # all tests (= jest)
npx jest --ci                                       # exactly what the pipeline runs
npx jest src/auth/__tests__/ProtectedRoute.test.tsx # one file
npx jest src/pages/gpsplus/live                     # one folder
npx jest -t "denies the T&A index"                  # one test by name (add a file path to narrow)
npx jest --coverage                                 # ad hoc coverage; no thresholds enforced
npm run lint                                        # ESLint incl. jsx-a11y gate
npx tsc -b                                          # type check (tsc --noEmit checks nothing here)
```

`tsconfig.app.json:28` excludes tests from `tsc -b`; test files are type-checked only by ts-jest while Jest runs (UNVERIFIED that ts-jest diagnostics are at default).

## 5. Test conventions (derived from the files cited)

Files read: `auth/__tests__/ProtectedRoute.test.tsx`, `auth/__tests__/AuthContext.test.tsx`, `pages/__tests__/LoginPage.test.tsx`, `pages/__tests__/CustomersPageTimeZones.test.tsx`, `pages/ta/__tests__/TAEmployeesPage.test.tsx`, `pages/ta/__tests__/AssignmentsPage.test.tsx`, `pages/ta/__tests__/timecardCalc.test.ts`, `pages/gpsplus/live/__tests__/LiveTable.a11y.test.tsx`, `pages/gpsplus/live/__tests__/useLiveFleet.test.tsx`, `pages/gpsplus/live/__tests__/useFleetFilterOptions.test.tsx`, `pages/gpsplus/__tests__/GpsLiveViewerPage.pinning.test.tsx`, `pages/gpsplus/events/__tests__/useEventLog.test.tsx`, `components/chatbot/__tests__/ChatWidget.test.tsx`, `components/layout/__tests__/Sidebar.test.tsx` (all under `client/src`).

- **Location and naming**: `__tests__/` beside the code; `<Subject>.test.ts(x)`. One subject is often split by behaviour: `GpsLiveViewerPage.pinning/.viewstate/.mapstale...`, `TableRenderer.export/.headers`. Accessibility sweeps are `<Subject>.a11y.test.tsx`. Pure logic gets `.test.ts`.
- **describe / it**: `describe('<Component or behaviour>')`, sometimes with the ticket: `describe('AssignmentsPage search + sort (ENG-907)')`. `it(...)` is a full plain-English sentence stating behaviour: `it('hides write actions but keeps Export for a read-only user')`. The `action_condition_expectedResult` naming in docs/testing/FrontendTests.md:1286-1288 is not what the code does. Long "why" comments above tests, often citing the ENG ticket or regression, are the norm.
- **Rendering**: plain RTL `render`, wrapped in `MemoryRouter` (with `initialEntries`) when the component routes; a small local `renderPage()/renderAt()/renderTab()` helper per file. `AppShell` is usually stubbed to a fragment; heavy children (FleetMap, BPMap/Leaflet, ConfigurableGrid, ChatPanel) are stubbed with `jest.mock`. Hooks use `renderHook`. a11y sweeps wrap in `<main>` so axe's `region` rule stays on (`LiveTable.a11y.test.tsx:11-16`).
- **API mocking**: module-level `jest.mock`, never network interception. Three patterns: (a) rely on the auto-mapped axios stub and set `axiosClient.get.mockResolvedValue(...)` (`useEventLog.test.tsx:5-7`); (b) mock the feature's own API/source module (`../../api/tenantApi`, `../live/liveFleetSource`, `../../api/customersApi`); (c) for GraphQL pages mock `hooks/useAllNodes`, `@apollo/client/react` `useQuery` and `@apollo/client/core` `gql` (`TAEmployeesPage.test.tsx:30-59`). `MockedProvider` appears in one file only (`useFleetFilterOptions.test.tsx:3`). Variables referenced inside `jest.mock` factories are `mock`-prefixed. `require()` after mocks is used when import order matters.
- **Auth / permissions**: `jest.mock('.../auth/AuthContext', () => ({ useAuth: () => (...) }))` returning a partial object; common helper `signedInWith(permissions)` with `hasPermission: (p) => permissions.includes(p)` (`ProtectedRoute.test.tsx:40-47`, `Sidebar.test.tsx:15-21`). Scope claims faked as `operatorAccess: ['*']` etc. Dev vs release build via `__setIsDevBuild(false)` (`Sidebar.test.tsx:43-45`). Real `AuthProvider` is used only in the AuthContext tests, with `jest.mock('../../api/authApi')`.
- **Queries**: role + accessible name first (`getByRole('button', { name: /add employee/i })`, `columnheader`, `link`, `table`, `status`, `combobox`), then `getByLabelText`, `getByText`, `within(...)`, `getByTitle` for rail tiles. `getByTestId` is used only against test-only stubs and probes (27 test files; production code has no `data-testid`, see section 10). Assertions use jest-dom (`toBeInTheDocument`, `toHaveAttribute('aria-sort', ...)`, `toHaveTextContent`).
- **Interaction**: `const user = userEvent.setup()` then `await user.click/type`; `fireEvent` in a minority of files (chatbot).
- **Async**: `await screen.findBy...`, `await waitFor(() => expect(...))`; hooks with timers use `jest.useFakeTimers()` + `act(async () => jest.advanceTimersByTime(...))` + a `flush()` helper, with `useRealTimers()` in `afterEach` (`useLiveFleet.test.tsx:61,78-83,103-106`). Deferred promises ("held reads") are used to test in-flight states (`GpsLiveViewerPage.pinning.test.tsx:113-117`).
- **Hygiene**: `beforeEach(() => jest.clearAllMocks())`; `mockReset()` + reinstall when call counts matter; `localStorage.clear()` / `sessionStorage.clear()`; fixed `Date.UTC(...)` instants and explicit IANA zones, never the wall clock (`factories.ts:3-11`).
- **a11y sweep**: `expect.extend(toHaveNoViolations)`; `expect(await axe(container, { rules: { 'color-contrast': { enabled: false } } })).toHaveNoViolations()`; sweep every render state; only `color-contrast` may be disabled (`client/CLAUDE.md` "Rendered checks").

House-style skeleton:

```tsx
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { MemoryRouter } from 'react-router-dom';

const mockUseAuth = jest.fn();
jest.mock('../../../auth/AuthContext', () => ({ useAuth: () => mockUseAuth() }));
jest.mock('../../../api/widgetsApi', () => ({ getWidgets: jest.fn() }));
import { getWidgets } from '../../../api/widgetsApi';
import { WidgetsPage } from '../WidgetsPage';

const signedInWith = (permissions: string[]) =>
  mockUseAuth.mockReturnValue({ hasPermission: (p: string) => permissions.includes(p), permissions });
const renderPage = () => render(<MemoryRouter><WidgetsPage /></MemoryRouter>);

beforeEach(() => {
  jest.clearAllMocks();
  (getWidgets as jest.Mock).mockResolvedValue([{ id: 'w1', name: 'Bus 204' }]);
});

describe('WidgetsPage', () => {
  // ENG-0000: a read-only user must still see the list.
  it('hides Add for a user without the write permission', async () => {
    signedInWith(['widgets:read']);
    renderPage();
    await waitFor(() => expect(screen.getByText('Bus 204')).toBeInTheDocument());
    expect(screen.queryByRole('button', { name: /add widget/i })).not.toBeInTheDocument();
  });
});
```

## 6. End-to-end / browser automation

**None exists.** No Playwright, Cypress, Selenium, Puppeteer or WebdriverIO dependency, config or spec anywhere in the repo snapshot (`client/package.json`; repo-wide search). The only traces: `.gitignore:382` ignores `/BusPlannerUnified/client/.playwright-mcp` (an ad hoc tool folder, not a suite), and `docs/design/ENGINEERING-INTEGRATION.md:481` lists Playwright/Chromatic visual regression as a future idea. UI behaviour beyond jsdom is covered only by manual scripts in `docs/qa/*` and `docs/testing/QA-*.md` (outside this map's area). A repo skill `.claude/skills/verify` exists for driving the app locally (not read).

## 7. PR pipeline (Azure Pipelines)

Trigger: PRs targeting `dev`, `staging`, `main` that touch `BusPlannerUnified/client/**` or the two pipeline files; `ubuntu-latest` (`pipelines/frontend-pr.yml:6-19`). One stage, one job, steps in order (`pipelines/templates/frontend-build-test.yml:19-42`):

| Step | Command | Fails the PR when |
|---|---|---|
| Node | Node 22.x | — |
| Install | `npm ci` | lockfile out of sync |
| Lint | `npm run lint` (`eslint .`) | any ESLint **error**: every `jsx-a11y` recommended rule (new findings only; ~300 old ones baselined in `client/eslint-suppressions.json`), `react-hooks` errors, TS-ESLint errors. Also exit 2 when a baselined finding was fixed but `npm run lint:prune` was not run. Warnings do not fail: `no-explicit-any`, `set-state-in-effect`, `preserve-manual-memoization`, `only-export-components` (`client/eslint.config.js:88-114`; `docs/testing/FrontendTests.md:1339-1345`) |
| Test | `npx jest --ci` | any failing test, including the jest-axe sweeps |
| Build | `npm run build` = `tsc -b && vite build` | any TypeScript error in app code (type check happens here, not as a separate step) or a bundling error |
| Publish | `dist` as artifact `frontend-dist` | — |

Not in the pipeline: coverage collection or thresholds, E2E, visual regression, contrast checks, Storybook. The same template is reused by `frontend-deploy-*.yml` (`frontend-build-test.yml:1-2`). The template's comment pointing to a README "Pre-existing tech debt" section is stale: `client/README.md` is the stock Vite template.

## 8. Coverage gaps (no test file found in the snapshot)

High value, no render/behaviour test:
- `pages/ta/TimesheetPage.tsx` (~7,400 lines; the core Time Card). Only its extracted logic is tested (`shiftHours.ts` via `shiftPerPunchEdits`/`shiftTimeZone`/`unresolvedShift` tests, `timecardCalc`, `weeklyBreakdown`, `timeText`, `timesheetPdf`, `timescanCsv`).
- `pages/ta/PayrollExportPage.tsx` (~860), `PayrollExportHistoryPage.tsx`, `PayrollSimulatorPage.tsx`, `YearStartWizardPage.tsx` (~500). docs/testing/FrontendTests.md specifies tests for these (P0/P1) that were never written.
- `pages/ta/AuditLogPage.tsx` (~920), `SchedulesPage.tsx` (~750), `TADashboardPage.tsx`, `OvertimePage.tsx` (data module tested only).
- T&A CRUD pages with no test: Absences, AbsenceTypes, Departments, Positions, JobCodes, Holidays, Locations, PayPeriods, RoundingRules, TripCredits, EmployeeFields, ShiftTemplates, ApprovalSteps, WorkWeek, TaSettings (catalog module tested only).
- Platform: `pages/UsersPage.tsx` (~850), `pages/RolesPage.tsx` (~410) — none. `CustomersPage` — time-zone picker only. `ChatbotAdminPage` (~1,190) — feedback loop only.
- Analytics: `StopClassificationPage.tsx` (~1,750) and `RouteVehicleMismatchPage.tsx` (~750) — none.
- Shared: `components/grid/ConfigurableGrid.tsx` (~1,000) — only date and hours cell formatting; no sort/search/column-config/preferences tests. `components/ui/*` (Dialog, ConfirmProvider, MultiSelect, Button, SearchInput, StatusBadge) — none. `components/layout/NavPanel.tsx`, `AppShell.tsx`, `components/ErrorBoundary.tsx` — none.
- Infrastructure: `api/axiosClient.ts` 401 handler and `graphql/client.ts` error link (both replaced by stubs in every test), `runtimeConfig.ts`, `main.tsx`, `hooks/useAllNodes.ts`, `auth/useLogout.ts`, `microapps/*`, most `api/*.ts` modules.
- `App.tsx` route table itself has no test: route-to-permission wiring is verified only per `ProtectedRoute` unit.

Well covered by comparison: GPS Plus (`pages/gpsplus/**`, ~70 test files incl. a11y sweeps), chatbot UI (`components/chatbot/**`, ~38), auth (4), login (1 large file).
a11y sweeps exist only for GPS Plus, chatbot, NoModules, AskAi (`docs/testing/FrontendTests.md:1375-1383` plus later additions); no T&A, admin or analytics page has one (AssignmentsPage imports jest-axe inside its normal test).

## 9. Risk notes for QA

- **Time Card complexity**: single 7,400-line component, no render tests, three-tier Actual/Edited/Payable times — `client/src/pages/ta/TimesheetPage.tsx`; logic in `client/src/pages/ta/shiftHours.ts`.
- **Payroll export is irreversible in effect** (freezes the pay period) and untested in the client — `client/src/pages/ta/PayrollExportPage.tsx`; expected behaviour in `docs/testing/FrontendTests.md:468-584`.
- **Calendar dates vs instants**: T&A dates are calendar dates; `toISOString()` shifts them a day west of UTC. Helpers: `client/src/utils/date.ts:1-8`. Test with a browser zone west and east of UTC and around midnight.
- **District time zone, never browser zone**: instants (audit `occurredAt`, `exportedDate`) are rendered in the customer's zone from `GET /api/session/time-zone`; shift wall-clock values are already district time and must not be converted twice — `client/src/utils/timeZone.ts:1-16`; `client/src/auth/AuthContext.tsx:20-27,174-190`. Fallback is UTC when the call fails or no single zone applies: a silent, wrong-looking time is a plausible defect. Check with tester machine zone != district zone, DST changes, shifts crossing midnight (`pages/ta/__tests__/shiftTimeZone.test.ts`).
- **Hours format** DECIMAL vs HH:MM is a per-district setting applied at display only — `client/src/utils/hoursFormat.ts`; `AuthContext.tsx:28-33`.
- **Raw date calls remain** in pages (`new Date()` / `toLocale*String` / `toISOString`): 16 hits in `TimesheetPage.tsx`, 14 in `analytics/StopClassificationPage.tsx`, 9 in `ChatbotAdminPage.tsx`, 7 in `analytics/RouteVehicleMismatchPage.tsx`, 4 in `ta/AuditLogPage.tsx` (grep counts; each needs review, not all are bugs).
- **Customer time zone picker** has broken before (ENG-1348, Windows vs IANA ids) — `client/src/pages/__tests__/CustomersPageTimeZones.test.tsx:5-14`.
- **Permission-gated UI is client-side display only**: route gates in `client/src/App.tsx`, nav in `client/src/components/layout/Sidebar.tsx:64-102,209`, in-page action gates via `hasPermission` across ~25 pages (e.g. `ta/AssignmentsPage.tsx`, `ta/TADashboardPage.tsx`, `ta/TimesheetPage.tsx`). Permissions are read from `localStorage` at load, so a role change needs re-login. Always confirm the API also refuses (403).
- **Session key mismatch**: `axiosClient.handleSessionExpired` clears 7 `bp_*` keys while `AuthContext` owns 15; on 401 `bp_clientCode`, `bp_schoolAccess`, `bp_districtAccess`, `bp_operatorAccess`, `bp_depotAccess`, `bp_displayTimeZone`, `bp_isDistrictZone`, `bp_hoursFormat` are left behind — `client/src/api/axiosClient.ts:6-14` vs `client/src/auth/AuthContext.tsx:54-70`. Login is still forced (token removed); the stale zone/format is reused as the next sign-in's first paint (`AuthContext.tsx:158-170`). Worth a shared-machine, two-tenant test.
- **Scope-aware UI**: GPS Live Viewer distinguishes "no buses in your access" from "no buses running" using operator/depot grants — `client/src/pages/gpsplus/__tests__/GpsLiveViewerPage.pinning.test.tsx:29-34`.
- **Dev vs release build differences**: `/dashboard` tile grid, rail "Home" tile and chat "Copy debug log" exist only when `IS_DEV_BUILD` — `client/src/pages/DashboardRoute.tsx`; `Sidebar.tsx:403`; `chatbot/CLAUDE.md:18`. Analytics, Map Test and Payroll Simulator have no nav entry in release builds (URL only).
- **Live Viewer**: auto-refresh timers, pinned-bus read slower than grid read, map sources, sessionStorage view state — `client/src/pages/gpsplus/GpsLiveViewerPage.tsx` (~1,300 lines), `live/useLiveFleet.ts`.
- **Chatbot streaming**: detach/re-attach of in-flight turns, at-most-once fallback, 403 = access refused, attachments limits (5 files, 9 MB total, images <= 5 MB) — `client/src/components/chatbot/CLAUDE.md:38-91,30`. Availability = signed in + `chatbot:read` + client CHATBOT flag.
- **List truncation**: server caps GraphQL pages; pages must use `useAllNodes` or silently show partial lists — `client/src/hooks/useAllNodes.ts:6-11`. Test lists with more rows than one page.
- **Accessibility, known open defects**:
  - Colour contrast fails WCAG 1.4.3 on all three GPS Plus pages: `GPS.fgFaint #AAAAAA` (2.07-2.32:1) and `GPS.fgMuted #878787` (3.21-3.59:1) on captions, row counts, "Unassigned" cells, notices; not fixed, awaiting a design decision — `docs/design/gpsplus-contrast-findings.md:8-29,47-66`; tokens in `client/src/pages/gpsplus/theme.ts`. Chat chart yellow series is under 3:1 on white, accepted — `chatbot/CLAUDE.md:27`.
  - ~300 baselined jsx-a11y findings (unlabelled inputs, click handlers without keyboard path) across 31 files: all T&A admin pages, Users, Roles, Customers, analytics, `ConfigurableGrid`, `Dialog`, `MultiSelect`, `ConfirmProvider`, `NavPanel` — `client/eslint-suppressions.json`; `docs/testing/FrontendTests.md:1334-1337,1398-1400`. GPS Plus and ChatbotAdminPage have zero entries.
  - Automated checks cannot see contrast or landmark structure (jsdom); these need a browser audit — `docs/testing/FrontendTests.md:1388-1397`.
  - Design rules to test against once implemented: 4.5:1 text pairs, visible 2px focus ring on every interactive element, status never colour-only — `docs/design/DESIGN-SYSTEM.md:246-263,366-367`.
- **Stale documentation**: `docs/testing/FrontendTests.md` sections before "Accessibility Checks" are an old specification (Router v6, `VITE_API_URL`, 5 localStorage keys, 2-argument `login`, `testUtils.tsx`, password-on-first-screen LoginPage). Trust the code and `client/CLAUDE.md`.

## 10. Stable hooks for UI automation

- **`data-testid` does not exist in production code.** A search of `client/src` excluding `__tests__` folders finds zero `data-testid` attributes. The 132 `data-testid`/`getByTestId` hits are all inside 27 test files, on test-only stubs and probes (`data-testid="grid"`, `"fleet-map"`, `"chat-panel"`, `"authenticated"`). Test ids cannot be used as locators against the running app.
- **Accessible roles/labels are strong in GPS Plus and chatbot** (enforced by lint with zero baseline plus axe sweeps): named tables (`getByRole('table', { name: 'Live fleet' })`), `aria-sort` on headers, per-row labelled buttons (`Pin Bus 201`), `role="status"`/`alert`, `aria-expanded` — `pages/gpsplus/live/__tests__/LiveTable.a11y.test.tsx:53-74`; `GpsLiveViewerPage.pinning.test.tsx:102`. Highest `aria-label|role=` density: `events/EventLogGrid.tsx` (20), `compare/CompareGrid.tsx` (18), `GpsPathComparePage.tsx` (11), `ta/TimesheetPage.tsx` (30).
- **Weak in T&A admin / Users / Roles / Customers / analytics**: these files hold the baselined `label-has-associated-control` and click-on-div findings, so `getByLabel` will often fail; most have 0-2 `aria-label|role=` hits. Practical locators there: visible button text (`Add Employee`, `Export CSV`, `Import CSV`, `Create Employee`), `title` attributes (grid row actions `title="Edit"`/`"Delete"` per docs/testing/FrontendTests.md:679,694 — UNVERIFIED against current grid code; rail tiles `title="Time & Attendance"`, `"GPS Plus"`, `"Home"` per `Sidebar.test.tsx:40-61`), placeholder/aria-label on search (`Search employee-positions...` per `AssignmentsPage.test.tsx:82`), and table structure (`row`/`cell`/`columnheader`).
- **Login page** is automation-friendly: labelled `Email` and `Password` inputs, buttons `Continue` / `Sign in`, `aria-invalid` on bad email, `role="status"` session-expired banner, exported message constants — `pages/__tests__/LoginPage.test.tsx:61-64,78-80,115-116`; `pages/LoginPage.tsx:23-24,39-40,249`.
- **Stable non-DOM hooks**: route paths (section 3), `localStorage` `bp_*` keys for session seeding or assertions, `/config.json` for pointing a build at an environment, `?client=`, `?redirect=`, `?expired=1` query parameters.
- CSS class names are sparse (inline styles dominate); a few exist (`access-denied`, `dashboard`, `nav-card`, `bp-chat-scope`, `bp-login-brand`) — `auth/ProtectedRoute.tsx:39`; `pages/DashboardPage.tsx:11,23`. Not a reliable general strategy.
- Recommendation for any future E2E suite: role/name locators first; where T&A pages lack labels, raise a11y fixes (which also shrink the lint baseline) rather than adding brittle CSS/XPath; agree a `data-testid` convention with the dev team before relying on one.

## Could not determine

- Actual pass/fail state, runtime and coverage percentage of the Jest suite (nothing was executed).
- Whether a branch policy makes the frontend PR pipeline a required check (not in the YAML).
- Whether `react-hook-form` is used beyond LoginPage; exact form validation patterns in T&A pages.
- Whether any test depends on the machine time zone (no `TZ` pin in the Jest config).

- **Seen 2026-11-19 on US staging (build `c7a2c81`):** the signed-in shell (sidebar with Dashboard, Time Card, Administration ...) exposes no `nav` element and no `role=navigation`: 0 links were found inside a navigation landmark. Locate the menu by link names, not by landmark. Possible accessibility gap (WCAG 1.3.1 / 2.4.1), not yet raised.
