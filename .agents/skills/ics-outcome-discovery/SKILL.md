---
name: ics-outcome-discovery
description: Discover and classify Outcomes for a given Workspace. Determines which persisted business entities the Workspace produces, and distinguishes Outcomes from Use Cases, following the conceptual model.
license: Proprietary
compatibility: opencode
metadata:
  audience: ica-analyst, ica-architect, ica-issuer
  references:
    - b21-myhosweb-system/foundation/conceptual-model.md
    - b21-myhosweb-system/domain/DOMAIN-CATALOG.md
---

## What I do

- Read the conceptual model to ground all classification decisions.
- Read the Domain Catalog to identify the Domain and Capability that owns the Workspace.
- Identify the persisted business entities the Workspace produces.
- Classify each candidate as an Outcome or a Use Case.
- Produce a structured Outcome list with supporting Use Cases.
- Escalate scope questions when a required Capability is absent from the Domain Catalog.

## What I do not do

- I do not define the business specification of an Outcome (that belongs to FEATURE).
- I do not define architecture or implementation (that belongs to ARCHITECTURE).
- I do not enumerate every possible Use Case exhaustively (that belongs to FEATURE).
- I do not invent Capabilities that do not exist in the Domain Catalog.

## Inputs required

| Input | Source | Purpose |
|---|---|---|
| Workspace name | User or calling agent | Identifies the work area to analyse |
| Workspace URL | User or calling agent | Confirms identity and context |
| conceptual-model.md | Foundation docs | Authoritative definitions |
| DOMAIN-CATALOG.md | Domain docs | Authoritative scope |
| Domain file(s) | Domain docs | Capability detail |

## Classification Rules

Read these rules before performing any classification. They are derived from
`conceptual-model.md` and must be applied strictly.

### Rule 1 — Entity Test (Outcome)

An Outcome corresponds to a distinct **persisted business entity**.

Ask:

> What new business entity must exist as a result of the work performed in this Workspace?

Name the Outcome as:

```text
<Business Entity> exists
```

Examples:

```text
✓ Booking exists
✓ Outpatient Visit exists
✓ Laboratory Result exists

✗ Patient is registered       ← action, not an entity
✗ Booking is confirmed        ← state change, not a new entity
✗ Show booking list           ← display, not a persisted entity
```

### Rule 2 — State Transition Test (Use Case)

A state change of an existing Outcome is **NOT** a new Outcome.

If a candidate describes modifying the state of an entity that already exists
(e.g., confirming, cancelling, rescheduling, updating), it is a **Use Case**
that operates on the existing Outcome.

```text
WRONG: Outcome = "Booking is cancelled"
RIGHT: Use Case = "Cancel Booking"  →  operates on Outcome: "Booking exists"
```

### Rule 3 — Count Test

The number of Outcomes for a Workspace equals the number of **distinct persisted
business entities** the Workspace manages.

It is NOT determined by the number of:
- operations (CRUD)
- state transitions
- buttons or actions
- screens or tabs

```text
WRONG: 4 Outcomes  →  Booking exists / Booking confirmed / Booking cancelled / Booking rescheduled
RIGHT: 1 Outcome   →  Booking exists
       3 Use Cases →  Confirm Booking / Cancel Booking / Reschedule Booking
```

### Rule 4 — Consumption Test (Standalone Use Case)

If the Workspace only reads, displays, searches, or navigates existing
information without creating or modifying a persisted entity, it produces
**no Outcomes**. It contains only standalone Use Cases.

### Rule 5 — Cross-Domain Rule

An Outcome may require Capabilities from multiple Domains.

Do not limit the Outcome analysis to a single Domain. Ask:

> Which Domains contribute their Capabilities to produce this Outcome?

Document all contributing Capabilities even if they belong to different Domains.

### Rule 6 — Scope Escalation Rule

If a required Capability is **not present in the Domain Catalog**, do not
proceed with Outcome classification for that capability.

Flag it as a **Capability Candidate** and escalate to the Product Owner before
continuing.

## Procedure

Follow these steps in order:

```text
STEP 1 — Read the conceptual model
  File: b21-myhosweb-system/foundation/conceptual-model.md
  Purpose: Ground all classification decisions in authoritative definitions.

STEP 2 — Read the Domain Catalog
  File: b21-myhosweb-system/domain/DOMAIN-CATALOG.md
  Purpose: Identify the Domain Code and Capabilities relevant to the Workspace.

STEP 3 — Read the Domain file
  File: b21-myhosweb-system/domain/<domain-file>.md
  Purpose: Understand Capability scope and boundary for this Workspace.

STEP 4 — Identify the Domain
  Determine which Domain owns this Workspace based on its URL and context.
  Confirm the Domain Code from the Domain Catalog.

STEP 5 — Identify the Capability
  Determine which Capability within that Domain this Workspace exercises.
  Confirm the Capability Code from the Domain Catalog.
  If the required Capability is absent → apply Rule 6 (Scope Escalation).

STEP 6 — Identify candidate business entities
  Ask: "What new persisted business entity does this Workspace create or manage?"
  List all candidates.

STEP 7 — Apply Rule 1 (Entity Test)
  For each candidate that represents a new persisted entity:
  → Name it as "<Entity> exists"
  → Add to Outcome list.

STEP 8 — Apply Rule 2 (State Transition Test)
  For each remaining candidate that represents a state change:
  → Reclassify as a Use Case.
  → Assign it to the Outcome it operates on.

STEP 9 — Apply Rule 4 (Consumption Test)
  For candidates that only read or display existing information:
  → Classify as standalone Use Cases (no Outcome produced).

STEP 10 — Apply Rule 3 (Count Test)
  Verify: Outcome count = number of distinct persisted business entities.
  If count seems high, re-examine whether candidates are truly distinct entities
  or state transitions of the same entity.

STEP 11 — Apply Rule 5 (Cross-Domain Rule)
  For each Outcome, identify all Capabilities from all Domains required to
  produce it. Document contributing Domains and Capabilities.

STEP 12 — Produce the output
  Format the result using the Output Structure below.
```

## Output Structure

Produce the following structure for each Workspace analysed:

```text
Workspace: <Name>
URL: <url>
Domain: <Domain Name> (<Domain Code>)
Capability: <Capability Name> (<Capability Code>)

OUTCOMES
────────
Outcome 1: <Entity> exists
  Contributing Capabilities:
    - <Domain Code>-<CAP>  <Description>
    - <Domain Code>-<CAP>  <Description>  (if cross-domain)

  Use Cases — Establish:
    - <Use Case>    (creates the entity)

  Use Cases — Modify State:
    - <Use Case>    (changes state, does NOT create a new Outcome)

  Use Cases — Consume:
    - <Use Case>    (reads or displays, produces no Outcome)

[Repeat for each Outcome]

STANDALONE USE CASES (no Outcome produced)
──────────────────────────────────────────
  - <Use Case>
  - <Use Case>

SCOPE FLAGS
───────────
  CAPABILITY CANDIDATE: <name>  →  Escalate to Product Owner
  [or: none]
```

## Classification Checklist (quick reference)

Before finalising the output, verify each answer:

| Check | Expected |
|---|---|
| Every Outcome named as `<Entity> exists`? | Yes |
| Any state-change named as an Outcome? | No — reclassify as Use Case |
| Outcome count = distinct persisted entities? | Yes |
| All contributing Capabilities identified? | Yes |
| Absent Capabilities flagged for escalation? | Yes |
| Read-only interactions classified as standalone Use Cases? | Yes |

## When to use me

Use this skill when:

- A new Workspace is being analysed for the first time.
- Outcomes for an existing Workspace need to be validated or corrected.
- A FEATURE artifact is being prepared and Outcome classification must be confirmed first.
- There is uncertainty about whether something is an Outcome or a Use Case.
- A Workspace spans multiple Domains and cross-domain Capabilities must be mapped.
