---
name: ics-outcome-creation
description: Create or update an OUTCOME artifact that defines a persisted business result, its specification, participating capabilities, and business boundaries.
license: Proprietary
compatibility: opencode
metadata:
  audience: ica-analyst, ica-architect
  artifact: OUTCOME
---

# What I do

- Create a new OUTCOME artifact
- Update an existing OUTCOME artifact
- Define persisted business outcomes
- Define outcome specifications
- Define outcome boundaries
- Identify participating capabilities
- Identify participating domains
- Define business constraints
- Define business exceptions
- Define acceptance criteria

# Conceptual Foundation

Business Hierarchy

Domain
↓
Capability
↓
Outcome

Interaction Hierarchy

Outcome
↓
Use Case

Where:

- Domain defines business scope.
- Capability defines business ability.
- Outcome defines persisted business result.
- Use Case defines interaction.

# Classification Rules

DOMAIN asks:

"What business capability does the system support?"

OUTCOME asks:

"What business fact must exist or change?"

USE CASE asks:

"How does an actor interact with the system?"

If the request creates, modifies, maintains, or removes persisted business state, it belongs to OUTCOME.

If the request only interacts with existing business state, it belongs to USE CASE.

Examples:

USE CASE

- Search Patient
- View Patient
- View Laboratory Result
- Print Laboratory Result
- Export Report

OUTCOME

- Outpatient Visit Exists
- Laboratory Result Exists
- Bed Assignment Exists
- Billing Transaction Exists
- Discharge Record Exists

# Execution Process

Step 1 — Classify Request

Determine whether the request is:

- Outcome
- Use Case
- Capability Change

If the request is only a Use Case, stop and recommend the Use Case workflow.

---

Step 2 — Identify Outcome

Determine:

- What business fact must exist?
- What business fact must change?
- What business fact must be maintained?

Define the Outcome in business language.

---

Step 3 — Identify Participating Capabilities

Identify all Capabilities required to establish or modify the Outcome.

Capabilities may belong to:

- One Domain
- Multiple Domains

Cross-domain Outcomes are allowed.

An Outcome may require capabilities from multiple Domains.

---

Step 4 — Validate Capabilities

Validate participating Capabilities against the Capability Catalog.

If a required Capability does not exist:

STOP.

Escalate to Product Owner for scope approval.

---

Step 5 — Define Outcome Specification

Define:

- Required business facts
- Required recorded information
- Required business conditions
- Required completion conditions

---

Step 6 — Define Boundaries

Define:

- Outcome Start
- Outcome End

---

Step 7 — Define Constraints and Exceptions

Identify:

- Business Constraints
- Business Exceptions

---

Step 8 — Define Acceptance Criteria

Define measurable business criteria proving the Outcome exists as specified.

# Scope Validation Rule

The Domain Catalog is authoritative.

The Capability Catalog is authoritative.

Every Outcome must reference one or more existing Capabilities.

An Outcome may reference Capabilities from multiple Domains.

Cross-domain Outcomes are expected and supported.

If a required Capability does not exist:

STOP.

Do not create the Outcome.

Escalate to Product Owner for scope approval.

# What I do not do

Outcome does not own:

- Domain definitions
- Capability definitions
- Technical architecture
- Database design
- API design
- UI design
- Navigation design
- User journeys
- Screen layouts
- SOP documents

Business scope belongs to DOMAIN.

Business ability belongs to CAPABILITY.

Interaction belongs to USE CASE.

Technical realization belongs to ARCHITECTURE.

# Artifact Ownership

Outcome owns:

- Business Purpose
- Outcome Specification
- Outcome Boundary
- Participating Capabilities
- Participating Domains
- Business Constraints
- Business Exceptions
- Acceptance Criteria

# Outcome Specification

Outcome Specification defines:

- What business fact must exist
- What business fact must change
- What must be recorded
- What must be verifiable
- What proves completion

Outcome Specification must be:

- business-oriented
- measurable
- testable
- implementation-independent

Outcome Specification must not contain:

- database schema
- API contracts
- UI layouts
- technical design

# Participating Capabilities

Participating Capabilities identify the business abilities required to establish or modify the Outcome.

Capabilities may belong to one or more Domains.

Example:

Outcome:
Outpatient Visit Exists

Participating Capabilities:

- Manage Patient
- Register Outpatient Visit
- Manage Insurance Coverage

Participating Domains:

- Patient
- Admission
- Billing

# Outcome Boundary

Outcome Boundary defines:

- Outcome Start
- Outcome End

The boundary determines where responsibility begins and ends.

# Acceptance Criteria

Acceptance Criteria verify that the Outcome exists as specified.

Acceptance Criteria must validate:

- Outcome completeness
- Outcome correctness
- Business constraints
- Business exceptions

Acceptance Criteria must be business-oriented.

# Ambiguous Request Handling

If a request appears to be a Use Case but participates in establishing or modifying an Outcome:

1. Identify the parent Outcome.
2. Analyze the Outcome first.
3. Record the Use Case as an interaction mechanism.
4. Do not promote the Use Case into an Outcome.

Example:

Use Case:
Validate Laboratory Result

Outcome:
Laboratory Result Updated

The Outcome remains the primary concern.

# Preconditions

Before using this skill:

- Domain Catalog must exist.
- Capability Catalog must exist.
- Relevant Domain definitions must be available.

# Independence Rule

Outcome depends on business Capabilities.

Outcome does not depend on:

- technical design
- implementation
- UI design
- screen design

An Outcome must remain valid even when implementation changes.

# Output

Produce:

<CODE>-OUTCOME.md

Recommended location:

outcomes/<CODE>-OUTCOME.md

The artifact must follow:

assets/outcome-template.md

# Versioning

Use:

Major.Minor

Update:

- Version
- LastUpdated

Do not maintain history inside the document.

# Escalation Rules

Capability not found in Greenfield Mode:

→ Product Owner

Outcome creation or Outcome change:

→ Analyst + Architect

Use Case only:

→ Developer

# When to use me

Use this skill when:

- A new persisted business result must be created.
- An existing persisted business result must change.
- Business state must be formalized.
- Multiple Capabilities collaborate to establish an Outcome.
- Business constraints must be formalized.
- Acceptance criteria must be formalized.

Ask clarifying questions when:

- Outcome Specification is ambiguous.
- Participating Capabilities are unclear.
- Business constraints are unclear.
- Business exceptions are unclear.
- Acceptance criteria are unclear.