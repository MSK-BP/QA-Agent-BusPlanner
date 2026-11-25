---
name: eng-3306-condition-evaluator
description: ENG-3306, the Discipline forms engine condition evaluator (.NET library). Local build and test checks against a dev checkout. Run after each change to the library.
env: local
module: [forms-engine]
flow: []
priority: []
tag: []
ticket: [ENG-3306]
cases: []
---
# Suite: eng-3306-condition-evaluator

The QA cases of ENG-3306 (QA-1 to QA-4, performance, Done items) plus three gap cases: parity with the Python reference, parse-error positions, and the NULL-condition rule. All cases use the `cli` channel against `%USERPROFILE%\Repos\qa-checkouts\BusPlannerUnified-dev`, and they run one after another (they share one build and one shadow-file path). About 10 minutes. ENG-3306-04 stays Blocked until a Turns branch references the library (open item R10).
