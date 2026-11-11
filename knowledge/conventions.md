# Test conventions

> Status: BusPlanner Unified derived 2026-11-10 from existing tests. Full detail, source files and house-style skeletons: `repos/BusPlannerUnified/tests-ci-infra.md` section 3 (backend), `repos/BusPlannerUnified/frontend.md` section 5 (front end), `repos/BusPlannerUnified/chatbot.md` section 7 (manual QA scripts). Read the skeleton before writing a test.

## Defaults (any repo)

- Match the framework, folder layout and naming already used. Do not introduce a new framework or dependency without asking.
- One behaviour per test. Assert on outcomes a user or caller can observe.
- No sleeps. Tests create their own data and do not depend on order.
- Every test for a bug fix references the ticket key.

## BusPlanner Unified: backend (xUnit, Moq, FluentAssertions)

- **Class:** `<SystemUnderTest>Tests`; behaviour slices get a suffix (`TimesheetControllerBulkApproveTests`). Namespace mirrors the folder. File-scoped namespaces.
- **Method:** `Method_Condition_ExpectedResult` (`Login_WrongPassword_Returns401`). Newer seeded tests also use sentence style.
- **Assertions:** FluentAssertions with a "because" string stating the business rule. Exceptions via `await act.Should().ThrowAsync<T>()`.
- **Unit data:** `TestDbContextFactory.Create()` plus builders; mock `ICurrentUserService` to make scoping live; `FakeTaAuthorizationService` for T&A permissions. Use fixed calendar dates, never "today".
- **Integration:** take the collection fixture in the constructor and call `factory.CreateClient()`. Never use `IClassFixture<TestWebApplicationFactory>`: a second factory drops the shared database. Mint tokens with `AuthHelper` (`GenerateUserToken(perms…)`, `GenerateEntityScopedToken` for scope tests; the admin token has no `analytics:read`).
- **Traits:** only `Category` = `SeededDb`, `Eval`, `KnownGap`, and only in the Integration project.
- **Repo rule:** any change under `BusPlanner.Tests.Integration` is reported to the user with the file list; never set a SQL server value; never claim a pass that was not run.

## BusPlanner Unified: front end (Jest, React Testing Library, jest-axe)

- **Location:** `__tests__/` beside the code, `<Subject>.test.ts(x)`. Jest finds nothing outside `__tests__/`. Split by behaviour (`Page.pinning.test.tsx`); accessibility sweeps are `<Subject>.a11y.test.tsx`.
- **Names:** `describe('<Component or behaviour>')`, optionally with the ticket; `it(...)` is a full sentence stating behaviour. The `action_condition_result` style in `docs/testing/FrontendTests.md` is not what the code does.
- **Rendering:** plain RTL `render`, in `MemoryRouter` when routing matters, with a small local `renderPage()` helper per file. There is no shared render helper. Stub `AppShell` and heavy children (maps, grids) with `jest.mock`.
- **API mocking:** module-level `jest.mock` only. No MSW, no network interception. For GraphQL pages mock `hooks/useAllNodes` and Apollo `useQuery`.
- **Auth:** mock `auth/AuthContext` `useAuth` with a `signedInWith(permissions)` helper.
- **Queries:** role and accessible name first, then label, then text. `getByTestId` only against test stubs: production code has no `data-testid`.
- **Interaction and async:** `userEvent.setup()`; `findBy…` and `waitFor`; fake timers for polling hooks, restored in `afterEach`.
- **Time:** fixed `Date.UTC(...)` instants and explicit IANA zones, never the wall clock.
- **a11y:** `axe` on every render state; only `color-contrast` may be disabled.

## BusPlanner Unified: manual QA scripts (`docs/qa`)

Scripts come in pairs per story: an engineering script and a UI-only script. Steps are written as Do / Expect, values are collected from the tenant under test, and hand-run SQL is the oracle. New scripts should match that template (chatbot map section 7).

## End-to-end

None exists, so there is no convention yet. Choosing a framework is a team decision: propose, do not introduce.
