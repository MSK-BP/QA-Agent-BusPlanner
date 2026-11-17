# CCSD eligibility path forward (2026-11-13)

- **Recording:** https://fathom.video/calls/901652385
- **Class:** qa-context
- **Source read:** summary
- **Areas:** Eligibility

## Decisions

- Three steps: finish the current full run, analyse CCSD's process against the standard model, then agree a new process with CCSD — owner: BusPlanner engineering (status update owner: Umar Mir) — decided — [03:08](https://fathom.video/calls/901652385?timestamp=188)

## Positions and concerns

- **Cause of the slow calculation:** BusPlanner holds that the full-student run is a habit from launch support, not a system need, and is the main suspect; CCSD is the only customer with the problem while larger boards run the same code. The customer (CCSD) said it is open to changing its process. No opposing view recorded. Outcome: analysis first, then a joint new process — [08:50](https://fathom.video/calls/901652385?timestamp=530), [05:29](https://fathom.video/calls/901652385?timestamp=329)
- **Urgency:** the customer is concerned that a delayed transit pass scanning feature puts student passes and related rebates at risk, so the run must finish quickly. BusPlanner committed to finish the run over the weekend. Outcome: decided — [11:55](https://fathom.video/calls/901652385?timestamp=715)

## Rules and facts

- CCSD recalculates eligibility for all students; other customers recalculate only changed students. The full run is a habit from launch, not a system need — stated — [08:50](https://fathom.video/calls/901652385?timestamp=530)
- Large full runs failed or stalled (Nov 2025, spring 2026, summer 2026); small daily change-only runs work — stated — [06:17](https://fathom.video/calls/901652385?timestamp=377)
- CCSD is the only customer with this problem; larger boards run the same code — stated — [02:00](https://fathom.video/calls/901652385?timestamp=120)

## Plans

- PLANNED: finish the current full eligibility run (about 60% done at the meeting), target Monday 2026-11-16, owner BusPlanner engineering — decided — [04:08](https://fathom.video/calls/901652385?timestamp=248)
- PLANNED: root-cause analysis of CCSD's process against the standard change-only model, then a proposal to CCSD, no target date, owner BusPlanner engineering — decided — [04:36](https://fathom.video/calls/901652385?timestamp=276)

## Defects and risks

- The full-student run is the main suspect for the slowness (related to ENG-2967, ENG-3043, IN-111, IN-213 in the knowledge base) — tentative — [08:50](https://fathom.video/calls/901652385?timestamp=530)
- A transit pass scanning feature for CCSD waits on the eligibility results — stated — [11:55](https://fathom.video/calls/901652385?timestamp=715)

## Open questions

- Is a full-student eligibility run a supported scenario that QA must load-test, or will it be discouraged?

## Confirms

- CCSD server at 100% CPU with eligibility tasks running for days (IN-111, relates IN-213, ENG-2967) — `knowledge/jira/other-projects.md`
- "Eligibility calculation completes for all schools under concurrent runs" is a rule with no test coverage (ENG-2967, ENG-3043) — `knowledge/domain.md`
- Eligibility uses the Path Server (ENG-3043); performance and memory exhaustion is a recurring bug theme — `knowledge/domain.md`
