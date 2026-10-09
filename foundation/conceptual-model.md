# CONCEPTUAL MODEL

## 1. Purpose

This document defines the official conceptual language used throughout the MyHosWeb system.

Its purpose is to:

* establish a shared understanding between business, product, design, and engineering;
* provide a consistent vocabulary for analysis and design;
* define the relationships between business concepts and system concepts;
* govern system scope through an authoritative Domain and Capability structure;
* ensure future enhancements follow the same conceptual model.

---

# 2. Core Concepts

## Domain

A **Domain** defines the business scope boundary of the system.

A Domain answers:

> What business area does the system officially support?

A Domain owns Capabilities.

The **Domain Catalog** is the authoritative definition of system scope.

Examples:

* Patient
* Admission
* Outpatient
* Inpatient
* Emergency
* Laboratory
* Radiology
* Pharmacy
* Billing

---

## Capability

A **Capability** is a business ability possessed by a Domain.

A Capability answers:

> What is this Domain capable of doing?

Characteristics:

* business-oriented;
* implementation-independent;
* stable;
* scope-defining.

A Capability is a **claim of business ability**.

Capabilities define what the system is allowed to support.

Capabilities do NOT define implementation.

Capabilities do NOT define user interaction.

Capabilities do NOT define workflow.

A Capability not present in the Domain Catalog represents a potential scope expansion.

A Capability belongs to exactly one Domain.

Examples:

```text
Laboratory

- Receive Laboratory Order
- Collect Specimen
- Manage Laboratory Result
- Validate Laboratory Result
```

---

## Outcome

An **Outcome** is a persisted current business state that the system establishes or changes.

An Outcome answers:

> What business fact must now be true?

Characteristics:

* persisted;
* represents current business state;
* measurable;
* verifiable;
* business-oriented;
* specification-oriented.

An Outcome is the **primary unit of business change**.

A Use Case may establish or change an Outcome.

An Outcome must have sufficient specification to determine whether the requested work is complete.

The specification of an Outcome provides the basis for Definition of Done and acceptance criteria.

Outcome must be expressed in business terms.

Examples:

```text
Patient exists
Outpatient Visit exists
Laboratory Result exists
Bed Assignment exists
Discharge Record exists
Billing Transaction exists
```

*Note: These examples represent persisted current business states (facts established or maintained in current operational reality), not merely persisted entities.*

An Outcome is NOT:

* user-visible behavior;
* UI state;
* screen state;
* displayed information;
* an interaction;
* a navigation result;
* a temporary display result.

---

## Use Case

A **Use Case** is an interaction scenario through which an actor uses the system.

A Use Case answers:

> How does an actor interact with the system?

Characteristics:

* interaction-oriented;
* does not require new persistence structures.

A Use Case may:

* read persisted information;
* display persisted information;
* search persisted information;
* navigate persisted information;
* invoke an existing business operation;
* participate in establishing or changing an Outcome.

A Use Case is not itself the persisted business result.

Not every Use Case produces an Outcome. A Use Case may simply consume or display an existing Outcome.

Examples:

```text
Standalone Use Cases:

- Search Patient
- View Patient
- View Laboratory Result
- Print Laboratory Result
- Export Report
- Browse Visit History
```

```text
Use Cases participating in an Outcome:

Outcome: Outpatient Visit exists

Use Cases:
- Search Patient
- Select Clinic
- Select Doctor
- Select Insurance
- Confirm Registration
```

---

## Actor

An **Actor** is a person, role, or external system that interacts with the system to achieve an Outcome or perform a Use Case.

An Actor answers:

> Who performs the work?

Examples:

* Registration Staff
* Nurse
* Doctor
* Laboratory Analyst
* Pathologist
* Cashier
* External System

---

## Screen

A **Screen** is a bounded user interface area representing a single operational context.

A Screen answers:

> Where does the actor perform the work?

Characteristics:

* represents one operational area;
* contains one or more Workspaces;
* groups related activities together.

Examples:

* Laboratory
* Emergency Department
* Pharmacy
* Billing

---

## Workspace

A **Workspace** is a focused work area within a Screen where a specific Actor performs a coherent unit of work.

A Workspace answers:

> What work is performed here?

Characteristics:

* role-oriented;
* outcome-oriented;
* exposes Outcomes and Use Cases required by the Actor.

Examples:

```text
Laboratory Screen

 ├─ Lab Staff Workspace
 ├─ Analyst Workspace
 └─ Pathologist Workspace
```

Each Workspace may expose different Outcomes, Use Cases, and Worklists.

---

# 3. Semantic Distinction

The conceptual model requires a clear separation between:

```text
Outcome     →  WHAT must now be true           (persisted current business state)
Use Case    →  HOW an actor interacts          (interaction scenario)
```

These are distinct concepts and must not be conflated.

An Outcome defines the persisted current business state (the business fact that the system establishes or changes).

A Use Case defines the interaction through which an actor causes or consumes that state.

A single Outcome may be established or changed through multiple Use Cases.

A single Use Case may participate in establishing or changing an Outcome, or may simply consume an existing one.

---

# 4. Relationships

## Business Hierarchy

```text
BUSINESS

Domain
    ↓
Capability
    ↓
Outcome
```

Rules:

* A Domain owns one or more Capabilities.
* A Capability belongs to exactly one Domain.
* A Capability may contribute to multiple Outcomes.
* An Outcome may require Capabilities from multiple Domains.
* The Domain Catalog is the authoritative definition of system scope.

---

## Interaction Hierarchy

```text
INTERACTION

Outcome
    ↓
Use Case
```

Rules:

* An Outcome may be established or changed through one or more Use Cases.
* A Use Case may participate in establishing or changing an Outcome, or may only consume an existing Outcome.
* Not every Use Case produces an Outcome.

---

## User Experience Hierarchy

```text
USER EXPERIENCE

Screen
    ↓
Workspace
    ↓
Outcome / Use Case
```

Rules:

* A Screen contains one or more Workspaces.
* A Workspace exposes Outcomes and Use Cases.
* An Actor performs Use Cases within a Workspace.
* Use Cases establish, change, or consume Outcomes.

---

## Cross-Domain Outcomes

Outcomes are not constrained to a single Domain.

An Outcome may require Capabilities from multiple Domains.

Example:

```text
Outcome:
External laboratory patient registration exists
and is ready for laboratory workflow.

Capabilities used:

Patient
 └─ Patient Data

Admission
 └─ Registration

Laboratory
 └─ External Registration
```

---

# 5. Request Classification and Escalation

All system requests must be classified according to the governance model below. Classification determines scope impact and required escalation.

**Scope is always checked before implementation classification.**

## Decision Tree

```text
REQUEST
   │
   ▼
Capability exists in Domain Catalog?
   │
   ├── NO
   │     ↓
   │  New Capability
   │     ↓
   │  Product Owner Approval
   │
   └── YES
         ↓
   Does it create or modify
   a persisted Outcome?
         │
         ├── YES
         │     ↓
         │  Outcome Change
         │     ↓
         │  Analyst + Architect
         │
         └── NO
               ↓
            Use Case
               ↓
           Developer
```

---

### Question 1: Does the request require a Capability that is outside the Domain Catalog?

If YES:

```text
New / Missing Capability
        ↓
Product Owner
```

Product Owner approval is required because the request may expand system scope.

---

### Question 2: Does the request create or modify a persisted Outcome?

If YES:

```text
Outcome Change
        ↓
Analyst + Architect
```

The request requires business analysis and architectural analysis because the persisted business model is being created or changed.

---

### Question 3: Otherwise

If the request:

* uses existing Capabilities;
* does not create or modify a persisted Outcome;
* only interacts with existing business information;

then it is a Use Case-level request.

```text
Use Case
    ↓
Developer
```

The developer may implement it without Outcome-level analysis.

---

# 6. Legacy and Reverse-Engineering Mode

The same Domain → Capability → Outcome → Use Case model applies to legacy systems where no Domain Catalog or Capability Catalog exists yet.

There is no separate conceptual model for legacy systems.

## Capability Status

When the Domain/Capability Catalog is incomplete or absent, Capability status may be:

* **Known Capability** — confirmed to exist in the system or domain knowledge.
* **Existing but Undocumented Capability** — the system already supports it, but it is not yet recorded in the catalog.
* **Capability Candidate** — it is unclear whether the system already supports this capability; requires confirmation.

The absence of documentation must NOT automatically mean the capability is new.

## Reverse-Engineering Process

When reverse-engineering a legacy system:

1. Discover the Outcome being produced or changed.
2. Identify the Use Cases involved.
3. Infer the participating business capabilities.
4. Record capability uncertainty explicitly.
5. Do not fabricate scope decisions.

Where a capability cannot be confirmed from the existing system or domain knowledge, mark it as a **Capability Candidate** and escalate it for Product Owner scope decision when necessary.

The same conceptual definitions remain valid in both formalized and legacy systems.

---

# 7. On the Term "Feature"

The methodology deliberately does NOT attempt to resolve the industry-wide ambiguity of the word "Feature".

The term **Feature is not used as a first-class conceptual category** in this model.

Whether another team or software tool informally calls something a "feature" is irrelevant to this conceptual model.

There is no hidden replacement concept such as "Business Feature", "Functional Feature", or similar terminology.

The primary concern for request classification and escalation is the **Outcome**.

---

# 8. Design Principles

1. Domain defines business scope boundary.

2. Capability defines business ability as a scope-defining claim.

3. Outcome defines the persisted current business state and is the primary unit of business change.

4. Use Case defines interaction with business information — it may participate in establishing or changing an Outcome or may only consume existing information.

5. Screen defines operational context.

6. Workspace defines role-oriented work area.

7. Outcomes may span multiple Domains.

8. Outcomes must always be designed from the desired persisted current business state.

9. Use Cases must not be confused with Outcomes. A standalone Use Case does not create or modify persisted business state.

10. Request classification governs escalation: scope is checked first (Product Owner), then Outcome impact (Analyst + Architect), then Use Case level (Developer).

11. Technical artifacts such as tables, APIs, forms, reports, charts, and database structures are implementation details and are not Outcomes.

12. All analysis, design, implementation, and future enhancements must use the concepts defined in this document.

---

# 9. AI Agent Guidance

This section is written specifically for AI Agents operating within this methodology.

It consolidates the rules needed to correctly classify Outcomes, Use Cases, and Workspaces without ambiguity.

---

## 9.1 Outcome Identification Rules

Apply these rules in strict order when identifying Outcomes for a Workspace:

**Rule 1 — Business State Test**

An Outcome corresponds to a persisted current business state established or maintained by the system.

Outcome identification must focus on:

- persisted business state
- current operational reality
- business facts

and must NOT focus on database entities or tables. An entity may be the mechanism used to represent that state, but the Outcome itself is defined by the business state, not by the entity.

Ask: *"What business fact must now be true as a result of the work performed in this Workspace?"*

Name the Outcome using the convention `<Entity> exists` — e.g., `Patient exists`, `Booking exists`, `Outpatient Visit exists`.

**Rule 2 — State Transition Test**

If a candidate Outcome is an operational state transition or lifecycle change of a business state that is already established, it is NOT a separate Outcome.

It is a **Use Case** that changes or updates the existing Outcome.

```text
WRONG: Outcome = "Booking is cancelled"
RIGHT: Use Case = "Cancel Booking"  →  operates on Outcome: "Booking exists"
```

**Rule 3 — Count Test**

The number of Outcomes in a Workspace equals the number of distinct **persisted current business states** established or governed there.

```text
WRONG: Booking exists / Booking is confirmed / Booking is cancelled / Booking is rescheduled = 4 Outcomes
RIGHT: Booking exists = 1 Outcome
       Confirm Booking / Cancel Booking / Reschedule Booking = Use Cases
```

**Rule 4 — Consumption Test**

If the Workspace only reads, displays, searches, or navigates existing business information without establishing or modifying a persisted business state, it has **no Outcomes** — only standalone Use Cases.

---

## 9.2 Common AI Misclassification Patterns

| Misclassification | Correct Classification | Reason |
|---|---|---|
| "Booking is cancelled" as Outcome | Use Case: Cancel Booking | Operational state transition of existing business state, not a new Outcome |
| "Booking is confirmed" as Outcome | Use Case: Confirm Booking | Operational state transition of existing business state |
| "Booking is rescheduled" as Outcome | Use Case: Reschedule Booking | Operational state transition of existing business state |
| Each CRUD operation as an Outcome | One Outcome per persisted business state | CRUD modifies the business state; the persisted business state is the Outcome |
| A report or printed document as an Outcome | Standalone Use Case | Not a persisted current business state |
| A search result as an Outcome | Standalone Use Case | Temporary display, not persisted business state |

---

## 9.3 Outcome Naming Convention

Outcomes are commonly named using the convention:

```text
<Entity> exists
```

> **Important**: This is a naming convention, not the definition of Outcome.
> 
> The definition of Outcome remains: **Persisted current business state**.
> 
> An entity may be the mechanism used to represent that state, but the Outcome is defined by the business state itself (the business fact that must now be true).

Examples:

```text
✓ Patient exists
✓ Booking exists
✓ Outpatient Visit exists
✓ Laboratory Result exists
✓ Bed Assignment exists
✓ Discharge Record exists

✗ Patient is registered          ← describes an action/interaction, not a persisted business state
✗ Booking confirmed              ← describes a lifecycle state transition, not a separate Outcome
✗ Show booking list              ← describes a display action, not a persisted business state
```

---

## 9.4 Workspace Analysis Procedure

When asked to identify Outcomes for a Workspace, follow this procedure:

```text
STEP 1 — Identify the Domain
  Determine which Domain owns this Workspace from the Domain Catalog.

STEP 2 — Identify the Capability
  Determine which Capability within that Domain this Workspace exercises.

STEP 3 — Identify the business state established or maintained
  Ask: "What business fact must now be true as a result of the work performed in this Workspace?"

STEP 4 — Apply the Business State Test (Rule 1)
  Name it using the convention "<Entity> exists".

STEP 5 — Apply the State Transition Test (Rule 2)
  Candidate Outcomes that are lifecycle state changes or transitions of the Step 3/4 business state → reclassify as Use Cases.

STEP 6 — Apply the Count Test (Rule 3)
  Verify: one Outcome per distinct persisted current business state.

STEP 7 — List Use Cases
  Group Use Cases into:
  (a) Use Cases that establish the Outcome
  (b) Use Cases that change the state of the Outcome
  (c) Standalone Use Cases that only consume existing information
```

---

## 9.5 Cross-Domain Outcome Rule

An Outcome may require Capabilities from multiple Domains.

When identifying Outcomes, do NOT limit the analysis to a single Domain.

Ask: *"Which Domains contribute their Capabilities to produce this Outcome?"*

Document all contributing Capabilities even if they belong to different Domains.

---

## 9.6 Escalation Quick Reference

| Situation | Action |
|---|---|
| Required Capability not in Domain Catalog | Stop. Escalate to Product Owner. |
| Request creates or modifies a persisted Outcome | Analyst + Architect required. |
| Request is a Use Case on existing Capabilities and Outcomes | Developer may implement directly. |
