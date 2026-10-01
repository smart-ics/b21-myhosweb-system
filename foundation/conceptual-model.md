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

An **Outcome** is a persisted business result that the system establishes or changes.

An Outcome answers:

> What business fact must now exist or change?

Characteristics:

* persisted;
* measurable;
* verifiable;
* specification-oriented.

An Outcome is the **primary unit of business change**.

An Outcome must have sufficient specification to determine whether the requested work is complete.

The specification of an Outcome provides the basis for Definition of Done and acceptance criteria.

Outcome must be expressed in business terms.

Examples:

```text
Outpatient Visit exists
Laboratory Result exists
Bed Assignment exists
Discharge Record exists
Billing Transaction exists
```

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
Outcome     →  WHAT must now exist or change  (persisted business result)
Use Case    →  HOW an actor interacts          (interaction scenario)
```

These are distinct concepts and must not be conflated.

An Outcome defines the persisted business result.

A Use Case defines the interaction through which an actor causes or consumes that result.

A single Outcome may be established through multiple Use Cases.

A single Use Case may participate in establishing an Outcome, or may simply consume an existing one.

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

3. Outcome defines the persisted business result and is the primary unit of business change.

4. Use Case defines interaction with business information — it may participate in establishing an Outcome or may only consume existing information.

5. Screen defines operational context.

6. Workspace defines role-oriented work area.

7. Outcomes may span multiple Domains.

8. Outcomes must always be designed from the desired persisted business result.

9. Use Cases must not be confused with Outcomes. A standalone Use Case does not create or modify persisted business state.

10. Request classification governs escalation: scope is checked first (Product Owner), then Outcome impact (Analyst + Architect), then Use Case level (Developer).

11. Technical artifacts such as tables, APIs, forms, reports, charts, and database structures are implementation details and are not Outcomes.

12. All analysis, design, implementation, and future enhancements must use the concepts defined in this document.
