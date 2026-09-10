# CONCEPTUAL MODEL

## 1. Purpose

This document defines the official conceptual language used throughout the MyHosWeb system.

Its purpose is to:

* establish a shared understanding between business, product, design, and engineering;
* provide a consistent vocabulary for analysis and design;
* define the relationships between business concepts and system concepts;
* ensure future enhancements follow the same conceptual model.

---

# 2. Core Concepts

## Domain

A **Domain** is a distinct business area of the hospital that owns a coherent set of responsibilities, rules, information, and capabilities.

A Domain answers:

> What business area are we dealing with?

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

A **Capability** is a stable business ability that a Domain possesses to fulfill its responsibilities.

A Capability answers:

> What must this Domain be able to do?

Characteristics:

* business-oriented;
* implementation-independent;
* stable over time;
* reusable by multiple Features.

Examples:

```text
Laboratory
 ├─ Order Lab
 ├─ Specimen Collection
 └─ Lab Result Management
```

A Capability belongs to exactly one Domain.

---

## Feature

A **Feature** is a concrete system behavior that realizes one or more Capabilities and enables an actor to achieve a specific Outcome.

A Feature answers:

> What can the actor accomplish using the system?

Characteristics:

* actor-oriented;
* outcome-driven;
* concrete and observable;
* may involve multiple Domains.

Examples:

* Register External Laboratory Patient
* Collect Specimen
* Verify Laboratory Result
* Assign Bed
* Discharge Patient

A Feature may use Capabilities from multiple Domains.

---

## Outcome

An **Outcome** is the observable business result achieved after a Feature is successfully performed.

An Outcome answers:

> What has been achieved?

Examples:

* Patient registered.
* Specimen collected.
* Result verified.
* Bed assigned.
* Patient discharged.
* Billing generated.

Outcome is expressed in business terms, not technical terms.

---

## Actor

An **Actor** is a person, role, or external system that interacts with the system to achieve an Outcome.

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
* exposes Features required by the Actor.

Examples:

```text
Laboratory Screen

 ├─ Lab Staff Workspace
 ├─ Analyst Workspace
 └─ Pathologist Workspace
```

Each Workspace may expose different Features and Worklists.

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
* A Feature produces one or more Outcomes.
* An Outcome may require multiple Features.

---

## User Experience Structure

```text
Screen
    ↓
Workspace
    ↓
Feature
    ↓
Outcome
```

Rules:

* A Screen contains one or more Workspaces.
* A Workspace exposes one or more Features.
* An Actor performs Features within a Workspace.
* Features exist to achieve Outcomes.

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

The Feature produces a single Outcome:

```text
External laboratory patient is registered
and ready for laboratory workflow.
```

---

# 5. Conceptual Hierarchy

```text
BUSINESS

Domain
    ↓
Capability
    ↓
Feature
    ↓
Outcome


USER EXPERIENCE

Screen
    ↓
Workspace
    ↓
Feature
    ↓
Outcome
```

Feature is the bridge between business capabilities and user experience.

---

# 6. Design Principles

1. Domain defines business responsibility.

2. Capability defines business ability.

3. Feature defines user-visible system behavior.

4. Outcome defines business result.

5. Screen defines operational context.

6. Workspace defines role-oriented work area.

7. Features may span multiple Domains.

8. Features should always be designed from the desired Outcome.

9. Technical artifacts such as tables, APIs, forms, reports, charts, and database structures are implementation details and are not Features.

10. All analysis, design, implementation, and future enhancements must use the concepts defined in this document.
