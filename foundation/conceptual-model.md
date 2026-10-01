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

A **Domain** is the business scope boundary of the system. It defines what business area the system officially supports.

A Domain answers:

> What business area does the system officially support?

A Domain owns Capabilities.

The **Domain Catalog** is the authoritative definition of system scope. If a requested business ability does not belong to any Domain Capability, the request is out-of-scope.

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

A **Capability** is a business ability possessed by a Domain. It is a claim of what that Domain is capable of doing.

A Capability answers:

> What is this Domain capable of doing?

Characteristics:

* business-oriented;
* stable over time;
* implementation-independent;
* scope-defining.

Capabilities define what the system may legitimately support.

Capabilities do NOT define implementation.

Capabilities do NOT define user interaction.

Capabilities do NOT define workflow.

Examples:

```text
Laboratory

- Receive Laboratory Order
- Collect Specimen
- Manage Laboratory Result
- Validate Laboratory Result
```

A Capability belongs to exactly one Domain.

---

## Feature

A **Feature** is a realization of one or more Capabilities that creates or modifies a persisted business Outcome.

A Feature answers:

> What business state will exist or change?

Characteristics:

* outcome-driven;
* specification-oriented;
* persistence-oriented;
* measurable.

A Feature MUST establish, create, modify, or maintain persisted business state.

A Feature is NOT merely a user interaction.

A Feature is NOT merely a screen action.

A Feature is NOT merely a navigation action.

A Feature is NOT merely data viewing.

Examples:

```text
Feature:
Register Outpatient Visit

Outcome:
Outpatient Visit exists.
```

```text
Feature:
Create Laboratory Result

Outcome:
Laboratory Result exists.
```

```text
Feature:
Assign Bed

Outcome:
Bed Assignment exists.
```

```text
Feature:
Discharge Patient

Outcome:
Discharge Record exists.
```

A Feature may use Capabilities from multiple Domains.

---

## Outcome

An **Outcome** is a persisted business result produced by a Feature.

An Outcome answers:

> What business fact now exists?

Characteristics:

* persisted;
* measurable;
* verifiable;
* becomes the basis of specification and definition of done.

Outcome must be expressed in business terms.

Outcome is NOT a UI state.

Outcome is NOT a screen state.

Outcome is NOT a temporary display result.

Examples:

* Outpatient Visit created.
* Laboratory Result created.
* Bed Assignment created.
* Billing Transaction created.

---

## Use Case

A **Use Case** is an interaction scenario that utilizes existing Capabilities without changing the business model.

A Use Case answers:

> How does an actor interact with the system?

Characteristics:

* interaction-oriented;
* does not establish new business outcomes;
* does not change the business model;
* does not require new persistence structures.

A Use Case may read and present existing persisted data.

A Use Case may also participate in realizing a Feature, providing the interaction steps through which an actor causes or contributes to a persisted Outcome.

Examples:

```text
Standalone Use Cases (no Feature context):

- Search Patient
- View Patient
- View Laboratory Result
- Print Laboratory Result
- Export Report
- Browse Visit History
```

```text
Use Cases within a Feature:

Feature: Register Outpatient Visit

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
* exposes Features and Use Cases required by the Actor.

Examples:

```text
Laboratory Screen

 ├─ Lab Staff Workspace
 ├─ Analyst Workspace
 └─ Pathologist Workspace
```

Each Workspace may expose different Features, Use Cases, and Worklists.

---

# 3. Relationships

## Business Structure

```text
Domain
    ↓
Capability
```

Rules:

* A Domain owns one or more Capabilities.
* A Capability belongs to exactly one Domain.
* The Domain Catalog is the authoritative definition of system scope.

---

## Outcome Structure

```text
Capability
    ↓
Feature
    ↓
Outcome
```

Rules:

* A Feature realizes one or more Capabilities.
* A Capability may contribute to multiple Features.
* A Feature produces one or more persisted Outcomes.
* An Outcome may require multiple Features.

---

## Interaction Structure

```text
Feature
├── defines persisted Outcome
└── may be realized through one or more Use Cases
```

Rules:

* A Feature defines a required persisted business Outcome (WHAT must exist or change).
* A Feature may be realized through one or more Use Cases (HOW an actor causes or contributes to that Outcome).
* Use Cases do not establish new business outcomes.
* Use Cases do not change the business model.

---

## User Experience Structure

```text
Screen
    ↓
Workspace
    ↓
Feature / Use Case
    ↓
Outcome (Feature only)
```

Rules:

* A Screen contains one or more Workspaces.
* A Workspace exposes Features and Use Cases.
* An Actor performs Features and Use Cases within a Workspace.
* Features exist to create or modify persisted Outcomes.
* Use Cases exist to interact with existing information.

---

# 4. Cross-Domain Features

Features are not constrained to a single Domain.

A Feature may use Capabilities from multiple Domains.

Example:

```text
Feature:
Register External Laboratory Patient

Uses:

Patient
 └─ Patient Data

Admission
 └─ Registration

Laboratory
 └─ External Registration
```

The Feature produces a persisted Outcome:

```text
External laboratory patient registration exists
and is ready for laboratory workflow.
```

---

# 5. Request Classification

All system requests must be classified according to the governance model below. Classification determines scope impact and required escalation.

## Use Case

Criteria:

* A Use Case does not itself change the business model.
* A Use Case may participate in realizing a Feature.

Escalation:

* Developer may implement directly.

## Feature

Criteria:

* Creates new persisted Outcome; OR
* Modifies existing persisted Outcome.

Escalation:

* Must involve Analyst and Architect.

## New Capability

Criteria:

* Requires Capability not present in Domain Catalog.

Escalation:

* Requires Product Owner approval.

---

# 6. Conceptual Hierarchy

```text
BUSINESS

Domain
    ↓
Capability
    ↓
Feature
    ↓
Outcome


INTERACTION

Feature
    ↓
Use Case


USER EXPERIENCE

Screen
    ↓
Workspace
    ↓
Feature / Use Case
    ↓
Outcome (Feature only)
```

Where:

* Domain defines scope.
* Capability defines business ability.
* Feature defines a required persisted business outcome (WHAT must exist or change).
* Outcome is the persisted result.
* Use Case defines how an actor interacts to cause or use that outcome (HOW).

---

# 7. Design Principles

1. Domain defines business scope boundary.

2. Capability defines business ability as a scope-defining claim.

3. Feature defines a required persisted business outcome.

4. Outcome defines persisted business result.

5. Use Case defines interaction with existing information.

6. Screen defines operational context.

7. Workspace defines role-oriented work area.

8. Features may span multiple Domains.

9. Features must always be designed from the desired persisted Outcome.

10. Use Cases must never be confused with Features. A Use Case does not create or modify persisted business state.

11. Request classification governs escalation: Use Cases are developer-level, Features require Analyst and Architect, new Capabilities require Product Owner approval.

12. Technical artifacts such as tables, APIs, forms, reports, charts, and database structures are implementation details and are not Features.

13. All analysis, design, implementation, and future enhancements must use the concepts defined in this document.
