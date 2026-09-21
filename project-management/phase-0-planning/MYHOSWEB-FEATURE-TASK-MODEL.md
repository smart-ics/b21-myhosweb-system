# MYHOSWEB Feature Task Model

**Document Status:** Draft (for review)
**Artifact Type:** Phase-0 planning standard
**Scope:** Standard work/tasks required to deliver one Feature through the Knowledge-Centric SDLC

---

## 1. Purpose

This task model defines the **standard work** required to deliver a single Feature
from analysis through deployment. It is a **template**, not a plan for any specific
Feature.

It answers one question:

> "What work must be performed for every Feature from analysis through deployment,
> who performs it, and what artifact/state results from each task?"

It exists so that:

1. Every Feature follows the **same lifecycle**, with the same roles, gates, and
   artifact ownership.
2. The **authority model** from the manifesto is preserved in planning (who owns
   which artifact and which gate).
3. Later artifacts — Feature-Level Detailed Planning, Capacity Planning, and the
   Roadmap — have a single, deterministic task standard to decompose against.

This document introduces no durations, no manpower estimates, and no roadmap. It
describes *what* work exists and *who* owns it, not *how long* or *how many people*.

---

## 2. Feature Delivery Lifecycle

Every Feature passes through the same workflow. The lifecycle below is taken
directly from the manifesto and must not be reordered or extended.

```text
FEATURE
  ↓
FEASIBILITY-ASSESSMENT
  ↓
GAP CLOSURE
  ↓
ARCHITECTURE
  ↓
IMPLEMENTATION-PLAN
  ↓
IMPLEMENTATION  ↔  REVIEW   (NO-GO remediation loop stays inside this pair)
  ↓
IMPLEMENTATION-PLAN = COMPLETED
  ↓
TEST PACKAGE CREATION
  ↓
TEST EXECUTION
  ↓
PASS ──────────────────────────────→ DEPLOYMENT

FAIL
  ↓
ISSUE CREATION
  ↓
ISSUE (BUG)
  ↓
BUG-INVESTIGATION
  ↓
ARCHITECTURE UPDATE
  ↓
PLANNING
  ↓
IMPLEMENTATION
  ↓
REVIEW
  ↓
TEST EXECUTION (Re-test) ── PASS ──→ DEPLOYMENT
```

Three mechanisms in this lifecycle must never be conflated:

| Mechanism | Where it lives | Produces an ISSUE? | Invokes BUG-INVESTIGATION? | Is it testing? |
| --------- | -------------- | ------------------ | -------------------------- | -------------- |
| **NO-GO** | Inside Implementation ↔ Review loop | No | No | No |
| **TEST FAIL** | Human testing of a completed plan | Yes (via Issue Creation) | Yes (via BUG workflow) | Yes |
| **BUG ISSUE** | Formal defect intake, re-enters SDLC at BUG-INVESTIGATION | It *is* the ISSUE | Yes | No |

This distinction is the backbone of the task model: a review rejection is not a
bug, and a test failure is never fixed directly inside Implementation or Testing.

---

## 3. Standard Feature Task Model

### 3.1 Normal Feature Delivery (CHANGE-REQUEST path)

The sequence below delivers a new or changed capability. It begins at Discovery
and ends at Deployment.

| Task ID | Task | Purpose | Responsible Role | Input | Output / State |
| ------- | ---- | ------- | ---------------- | ----- | -------------- |
| T-01 | Feature Analysis (Discovery) | Define the requested business change in business terms | Analyst | ISSUE (CHANGE-REQUEST), business request | DOMAIN and FEATURE (new or updated) |
| T-02 | Gap Identification (Feasibility Assessment) | Assess the change against the current system and identify gaps, open questions, risks, and assumptions | Analyst (analysis activity) | DOMAIN, FEATURE, ISSUE, current artifacts, current codebase | FEASIBILITY-ASSESSMENT (Current State, Gap Analysis, Open Questions, Risks, Assumptions, Decisions) |
| T-03 | Open Question Resolution (Gap Closure) | Resolve every blocking gap and open question and record decisions | Analyst (analysis activity) | FEASIBILITY-ASSESSMENT | Updated FEASIBILITY-ASSESSMENT; all blocking GAPs and OQs CLOSED with Decision, Rationale, Impact, Architecture Impact, Resolved By, Resolved Date |
| T-04 | Feasibility Completion | Declare the assessment ready for planning | Architect | FEASIBILITY-ASSESSMENT (all blocking gaps/OQs closed) | FEASIBILITY-ASSESSMENT status = READY-FOR-PLANNING |
| T-05 | Architecture Update | Realize approved decisions as target technical structure | Architect | FEATURE, FEASIBILITY-ASSESSMENT, approved decisions | ARCHITECTURE |
| T-06 | Implementation Planning | Define the phased/sliced plan that transforms current code into target architecture | Architect | FEATURE, ARCHITECTURE, current codebase | IMPLEMENTATION-PLAN (phases, slices, dependencies, execution order); Execution Approval = APPROVED |
| T-07 | Implementation | Implement one approved slice per execution | Implementer | IMPLEMENTATION-PLAN (approved), ARCHITECTURE, codebase | Source code changes; slice implementation status = IMPLEMENTED |
| T-08 | Review | Verify the slice satisfies plan and architecture | Reviewer | Source code, IMPLEMENTATION-PLAN, ARCHITECTURE | Slice review status = GO or NO-GO; REVIEW artifact only when findings/remediation must be preserved |
| T-09 | Remediation / Re-review (NO-GO loop) | Correct review findings and re-verify, without leaving the Implementation ↔ Review loop | Implementer (remediation), then Reviewer (re-review) | NO-GO findings | Remediated source code; re-review GO, or escalation to Architect after second NO-GO |
| T-10 | Plan Completion | Declare the whole plan complete | Reviewer | Every slice IMPLEMENTED and GO | IMPLEMENTATION-PLAN = COMPLETED |
| T-11 | Test Package Creation | Define human-executable tests for the completed implementation as a whole | Tester | IMPLEMENTATION-PLAN (COMPLETED), FEATURE, ARCHITECTURE | TEST-PACKAGE |
| T-12 | Test Execution | Execute the test package and record results | Tester | TEST-PACKAGE, IMPLEMENTATION-PLAN (COMPLETED), FEATURE, ARCHITECTURE | TEST-EXECUTION (PASS/FAIL per test case) |
| T-13 | Deployment | Release the validated solution and verify post-release health | Deployer | Tested solution (all PASS), deployment environment | Deployment Checklist, Deployment Result, Serah Terima documentation |

### 3.2 Defect Fix (BUG workflow)

A **TEST FAIL** (T-12) does not return work to Implementation. It becomes a formal
defect through Issue Creation and re-enters the SDLC through BUG-INVESTIGATION.
Defect fixing therefore follows a **separate task sequence**, never inside T-07/T-12.

| Task ID | Task | Purpose | Responsible Role | Input | Output / State |
| ------- | ---- | ------- | ---------------- | ----- | -------------- |
| B-01 | Issue Creation (defect intake) | Convert a confirmed FAIL into a formal defect | Issue Intake | TEST-EXECUTION FAIL record(s) | ISSUE (Type = BUG) |
| B-02 | Bug Investigation | Determine the defect's cause, affected components, impact, and correction direction | Analyst (analysis activity) | ISSUE (BUG), current artifacts, current codebase | BUG-INVESTIGATION (Problem Analysis, Affected Components, Impact, Alternative Evaluation, Decision, Rationale) |
| B-03 | Architecture Update | Realize the approved correction direction technically | Architect | BUG-INVESTIGATION, approved decisions | ARCHITECTURE (updated) |
| B-04 | Planning | Create the implementation plan for the correction | Architect | ARCHITECTURE (updated), current codebase | IMPLEMENTATION-PLAN (correction); Execution Approval = APPROVED |
| B-05 | Implementation | Implement the correction slices | Implementer | IMPLEMENTATION-PLAN (approved), ARCHITECTURE, codebase | Source code changes; slice implementation status = IMPLEMENTED |
| B-06 | Review | Verify the correction satisfies plan and architecture | Reviewer | Source code, IMPLEMENTATION-PLAN, ARCHITECTURE | Slice review status = GO/NO-GO; plan COMPLETED when all slices GO |
| B-07 | Re-test | Re-execute tests against the corrected solution | Tester | TEST-PACKAGE (reused or updated), IMPLEMENTATION-PLAN (COMPLETED), FEATURE, ARCHITECTURE | TEST-EXECUTION (updated; all previously failed cases now PASS) |
| B-08 | Deployment | Release the corrected solution | Deployer | Re-tested solution (all PASS), environment | Deployment Checklist, Deployment Result |

The correction path from B-05 onward mirrors the normal path: Implementation →
Review → Plan COMPLETED → Test Package → Test Execution (Re-test) → Deployment.
A NO-GO during B-06 stays inside the same Implementation ↔ Review loop and does
not create a new ISSUE.

---

## 4. Task Dependencies

Dependencies are shown as "predecessor → successor". A task may start only after
all of its predecessors are complete.

### Normal Feature Delivery

```text
T-01 → T-02 → T-03 → T-04 → T-05 → T-06 → T-07 → T-08
                                    ↑                ↑
                              (loop back)     T-09 ⇄ T-08  (NO-GO loop)

T-08 (all slices GO) → T-10 → T-11 → T-12 → T-13
```

- T-02 requires T-01 (DOMAIN + FEATURE exist).
- T-03 requires T-02 (gaps/OQs identified).
- T-04 requires T-03 (all blocking gaps/OQs CLOSED).
- T-05 requires T-04 (READY-FOR-PLANNING) — planning cannot begin before architecture.
- T-06 requires T-05 (ARCHITECTURE is the source of target-state truth).
- T-07 requires T-06 (Execution Approval = APPROVED).
- T-08 requires T-07 for the slice under review.
- T-09 requires a NO-GO from T-08; it loops back into T-07/T-08 only.
- T-10 requires every slice IMPLEMENTED and GO.
- T-11 requires T-10 (COMPLETED) — an individual slice GO does not unlock testing.
- T-12 requires T-11 (TEST-PACKAGE).
- T-13 requires T-12 with all cases PASS.

### Defect Fix (BUG workflow)

```text
T-12 (FAIL) → B-01 → B-02 → B-03 → B-04 → B-05 → B-06 → B-07 → B-08
                                                        (NO-GO loops inside B-05 ⇄ B-06)
```

- B-01 requires a FAIL in TEST-EXECUTION (T-12 or B-07).
- B-02 requires B-01 (ISSUE with Type = BUG).
- B-03 requires B-02 (investigation decisions recorded).
- B-04 requires B-03 (updated ARCHITECTURE).
- B-05 requires B-04 (Execution Approval).
- B-06 requires B-05.
- B-07 requires B-06 reaching plan COMPLETED (all slices GO).
- B-08 requires B-07 with all previously failed cases PASS.

Cross-workflow note: the BUG workflow does **not** feed back into the original
Feature's Implementation or Testing tasks. It is an independent SDLC cycle that
rejoins the normal sequence at Plan Completion → Testing → Deployment.

---

## 5. Agent / Human Responsibility

Responsibility boundaries follow the manifesto authority model exactly. Each role
owns specific artifacts and fields, and may only advance specific gates.

| Role | Owns | May set/advance | Must never |
| ---- | ---- | --------------- | ---------- |
| Analyst | DOMAIN, FEATURE; FEASIBILITY-ASSESSMENT / BUG-INVESTIGATION content | Gap-closure and investigation decisions | Technical realization, plan structure, gates other than its own analysis content |
| Architect | ARCHITECTURE, IMPLEMENTATION-PLAN structure, Execution Approval | READY-FOR-PLANNING, EXECUTION-APPROVED | Implementation, review, test results |
| Issue Intake | ISSUE | ISSUE creation (CHANGE-REQUEST or BUG) | Domain/architecture/plan/test knowledge |
| Implementer | Source code, slice implementation status | IMPLEMENTED | Review status, plan structure, TEST-PACKAGE, TEST-EXECUTION, ARCHITECTURE |
| Reviewer | Slice review status, plan COMPLETED, REVIEW findings | GO, NO-GO, COMPLETED | Implementation status, plan structure, source code |
| Tester | TEST-PACKAGE, TEST-EXECUTION results | TEST PASSED | Source code, plan, ARCHITECTURE, FEATURE, DOMAIN; fixing defects |
| Deployer | DEPLOYMENT artifacts | DEPLOYED | All upstream knowledge |

### Explicit responsibility boundaries

- **Business analysis is not an Implementer responsibility.** Implementers must
  not invent or redefine business rules, acceptance criteria, domain knowledge, or
  feasibility decisions. When an implementer finds a business gap, they mark the
  slice BLOCKED and raise a request to the Architect/Analyst — they do not decide.
- **Implementers do not modify ARCHITECTURE to match their code.** If the
  architecture cannot be satisfied, the slice is BLOCKED and escalated.
- **Testers do not fix defects.** A tester records a FAIL in TEST-EXECUTION only;
  defect correction is a separate BUG workflow owned by other roles.
- **The NO-GO loop is not testing and is not a bug.** It is reviewer-owned
  remediation inside Implementation ↔ Review.

### Current project context (reflected in planning, not a staffing strategy)

- The **Analyst** performs Feature Analysis, Gap Identification, Open Question
  Resolution, and business clarification. Analyst capacity is not assumed to be
  unlimited.
- **Programmers** are currently positioned primarily as **Implementers** and
  **Testers**, executing separate roles per workflow step.
- Programmers are **not expected to perform business analysis independently**;
  analysis tasks remain Analyst-owned and are supported through coaching/mentoring
  rather than delegated.

The same human may act under more than one role, but **an agent acts under exactly
one role per workflow step**, and Implementation and Review of the same slice must
be performed by different agent executions.

---

## 6. Complexity Relationship

The Complexity Level 1–5 from `MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md` affects
the task model in **degree, not in kind**.

Rules:

- **Complexity does not create different workflows.** A Level 1 Feature and a
  Level 5 Feature follow the identical T-01 → T-13 lifecycle (and the identical
  BUG workflow when defects arise). No stage is added or removed.
- **Complexity affects the amount of work within a stage**, not the stages
  themselves. Higher complexity implies:
  - deeper Feature Analysis and a larger FEATURE (more domains orchestrated);
  - more extensive Gap Identification and a larger FEASIBILITY-ASSESSMENT (more
    gaps, questions, risks, and decisions);
  - a larger ARCHITECTURE (more components, integrations, decisions);
  - a larger IMPLEMENTATION-PLAN with **more slices**;
  - broader testing scope (more test cases) in the TEST-PACKAGE.
- **Complexity affects the number of implementation slices**, which is expressed
  inside T-06/T-07/T-08 — never as extra workflow stages.
- **Complexity affects expected duration**, which is deferred to Capacity Planning.
- **Complexity must not alter the approved milestone sequence** (see
  `MYHOSWEB-DEVELOPMENT-ORDER.md`); it refines effort and duration only.

Complexity is therefore an input to **Feature-Level Detailed Planning** (how many
slices, how deep the analysis, how broad the tests), not an input that changes
this task model.

---

## 7. Shared Feature Handling

Canonical shared features — `Pakai Barang`, `Mutasi Barang`, and `Opname` — follow
the **same Feature lifecycle** as any other Feature. They are not a special
workflow.

The difference is in **counting and reuse**, not in the task model:

- Each canonical feature is analyzed, architected, planned, implemented, reviewed,
  tested, and deployed **once** as a single product capability (one T-01 → T-13
  pass).
- Its repeated appearance across Screens (SC-05 … SC-12) represents **contextual
  usage**, not independent implementations. Those usages do **not** each spawn a
  separate lifecycle.
- Context-specific validation and operational adoption within a Screen may add
  work at the **Screen planning** level, but they do not create separate canonical
  Feature implementations.

Consequence for planning: the number of Feature lifecycles driven through this
task model equals the number of **canonical** features plus non-shared features —
not the sum of Screen occurrences. This is decided in Feature-Level Detailed
Planning, not here.

---

## 8. Planning Use

This task model is the standard that the remaining Phase-0 planning artifacts are
built upon:

```text
Feature Task Model          (this artifact)
        ↓
Feature-Level Detailed Planning   (decompose each catalog Feature into this lifecycle)
        ↓
Capacity Planning                (map task volume and complexity to Analyst/Implementer/Tester capacity)
        ↓
Roadmap                          (sequence Features across milestones and time)
```

Specifically:

- **Feature-Level Detailed Planning** will instantiate T-01 → T-13 (and B-01 →
  B-08 where relevant) per Feature, sized by its Complexity Level.
- **Capacity Planning** will use the responsibility boundaries in Section 5 —
  notably that Analyst work (T-01/T-02/T-03, B-02) is not delegable to
  Implementers and is not unlimited — to derive the workload per role.
- **Roadmap** will order those Features according to the approved Development
  Order and milestones.

Until then, this document remains a **draft standard** and introduces no durations,
no manpower, and no sequence changes.

---

## 9. Traceability Matrix

| This Artifact | Source Artifact | Relationship | Downstream Artifact |
| ------------- | --------------- | ------------ | ------------------- |
| Feature Task Model | Manifesto / SDLC Workflow | Derives the standard T-01→T-13 / B-01→B-08 lifecycle and role/gate authority model | Feature-Level Detailed Planning |
| Feature Task Model | Development Order | Applies the standard lifecycle against the approved milestone sequence | Feature-Level Detailed Planning |

The downstream chain continues: **Feature-Level Detailed Planning → Capacity Planning → Roadmap** (future artifacts, not yet created).
