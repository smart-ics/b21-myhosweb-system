# AGENTS.md — Agent System & Repository Operating Guide

> **Repository:** `smart-ics/b21-myhosweb-system` (`myhospital-web/b21-myhosweb-system`)  
> **Purpose:** Authoritative foundation, domain decomposition, outcome-driven business architecture, and development wave planning for MyHosWeb (SIMRS / Hospital Information System).

---

## 1. System & Repository Overview

`b21-myhosweb-system` is the central architecture and engineering repository for the **MyHosWeb** frontend ecosystem. It serves as the single source of truth for:
1. **Conceptual Foundation:** Formal metamodel defining Domains, Capabilities, Outcomes, and Use Cases.
2. **Domain Architecture:** 13 healthcare domains defining scope boundaries and capabilities.
3. **Outcome Catalog:** Screen-by-screen business outcomes establishing persisted business state.
4. **Project Lifecycle & Wave Management:** Execution wave maps, development lifecycle governance, and dashboard generators.
5. **Agent Skills:** Reusable AI agent skills for discovery, outcome authoring, and progress tracking.

---

## 2. Conceptual Metamodel (Non-Negotiable Rules)

Every agent operating in this repository must align strictly with [`foundation/conceptual-model.md`](file:///e:/PROJECT/ICS/FE/myhospital-web/b21-myhosweb-system/foundation/conceptual-model.md).

```text
Business Hierarchy:
  Domain        (Defines business scope boundary)
    ↓
  Capability    (Defines claim of business ability)
    ↓
  Outcome       (Defines persisted current business state / entity)
    ↓
  Use Case      (Defines user interaction & state transition on an Outcome)
```

### Core Concept Definitions

| Concept | Primary Question | Definition & Rules | Authoritative Source |
|---|---|---|---|
| **Domain** | *What business area does the system officially support?* | Business scope boundary. Owns capabilities. | [`domain/DOMAIN-CATALOG.md`](file:///e:/PROJECT/ICS/FE/myhospital-web/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) |
| **Capability** | *What is this Domain capable of doing?* | Business ability claim. Implementation-independent, UI-independent. Belongs to exactly 1 Domain. Capabilities not in catalog require escalation. | `domain/*-DOMAIN.md` |
| **Outcome** | *What business fact must now exist or change?* | Persisted current business state. Formula: `<Business Entity> exists`. Represents persisted data/entities, NOT UI actions. | [`outcomes/MYHOSWEB-SCREEN-OUTCOMES-CATALOG.md`](file:///e:/PROJECT/ICS/FE/myhospital-web/b21-myhosweb-system/outcomes/MYHOSWEB-SCREEN-OUTCOMES-CATALOG.md) |
| **Use Case** | *How does an actor interact with the system?* | Interaction flow or state transition operating on an existing Outcome. A state change is NEVER a new Outcome. | Specified within Outcome specs |

### Classification Tests for Agents

- **Entity Test (Outcome):** An Outcome must correspond to a distinct persisted business entity (e.g., `✓ Outpatient Visit exists`, `✗ Patient is registered` [action], `✗ Booking is confirmed` [state change]).
- **State Transition Test (Use Case):** Modifying, cancelling, rescheduling, or confirming an existing entity is a **Use Case**, NOT a new Outcome.
- **Count Test:** Total Outcomes for a workspace = number of distinct persisted entities managed (NOT the number of CRUD actions or tabs).
- **Scope Boundary Test:** Agents must NEVER invent capabilities not present in `DOMAIN-CATALOG.md`. If a missing capability is encountered, flag it as a `Capability Candidate` or escalate.

---

## 3. Development Lifecycle & Human-Agent Distribution

Governance follows [`project-mngmnt/DEVELOPMENT-LIFECYCLE.md`](file:///e:/PROJECT/ICS/FE/myhospital-web/b21-myhosweb-system/project-mngmnt/DEVELOPMENT-LIFECYCLE.md).

```text
Stage-1: Domain Discovery       (100% Human)           → DOMAIN-CATALOG.md
Stage-2: Outcome Discovery      (80% Human / 20% Agent) → SCREEN-OUTCOMES-CATALOG.md & OC-*.md
Stage-3: Core Feature Discovery (80% Human / 20% Agent) → CORE-FEATURE-CATALOG.md
Stage-4: UI Design              (50% Human / 50% Agent) → UI-SPECIFICATION & Figma
Stage-5: BFF Discovery          (20% Human / 80% Agent) → BFF-CATALOG.md
Stage-6: Architecture           (5% Human / 95% Agent)  → ARCHITECTURE.md & IMPLEMENTATION-PLAN.md
Stage-7: Development            (0% Human / 100% Agent) → Source Code & Automated Tests
Stage-8: Testing                (100% Human)           → TEST-REPORT.md
Stage-9: Deployment             (100% Human)           → Production Release
```

---

## 4. Repository Structure & Directory Map

```text
b21-myhosweb-system/
├── .agents/
│   └── skills/
│       ├── ics-outcome-discovery/    # Skill: Analyze workspaces & classify outcomes vs use cases
│       ├── outcome-creation/         # Skill: Author & update standardized OUTCOME specifications
│       │   └── assets/
│       │       └── outcome-template.md # Official template for Outcome markdown files
│       └── progress-tracker/         # Skill: Progress tracking & validation rules
├── domain/                           # Authoritative Domain Definitions (13 Domains)
│   ├── DOMAIN-CATALOG.md             # Master catalog of domains and capabilities
│   ├── 01-PASIEN-DOMAIN.md
│   ├── 02-ORGANISASI-DOMAIN.md
│   ├── 03-ADMISSION-DOMAIN.md
│   ├── 04-RAWAT-JALAN-DOMAIN.md
│   ├── 05-RAWAT-INAP-DOMAIN.md
│   ├── 06-GAWAT-DARURAT-DOMAIN.md
│   ├── 07-LABORATORY-DOMAIN.md
│   ├── 08-RADIOLOGI-DOMAIN.md
│   ├── 09-KAMAR-OPERASI-DOMAIN.md
│   ├── 10-APOTEK-DOMAIN.md
│   ├── 11-INVENTORY-DOMAIN.md
│   ├── 12-PURCHASING-DOMAIN.md
│   └── 13-TATA-REKENING.md
├── foundation/
│   └── conceptual-model.md           # Authoritative conceptual model & vocabulary
├── outcomes/                         # Outcome Specifications (OC-XX-YY-*.md)
│   ├── MYHOSWEB-SCREEN-OUTCOMES-CATALOG.md # Master screen-to-outcome mapping
│   ├── OC-01-01-BOOKING-OUTCOME.md
│   ├── OC-05-02-TINDAKAN.md
│   └── ...
├── project-mngmnt/                   # Lifecycle & Wave Execution Plans
│   ├── DEVELOPMENT-LIFECYCLE.md      # 9-stage development lifecycle
│   ├── SCREEN-WAVE.md                # Wave-based screen breakdown
│   ├── SCREEN-WAVE-TABLE.md          # Tabular wave plan & tracking
│   └── SCREEN-WAVE-DRAFT.txt         # Working draft notes
├── generate_dashboard.js             # Compiles wave-screen.json into HTML dashboard
├── generate_dashboard.py             # Python wrapper for dashboard compilation
├── myhosweb-development-plan.html    # Interactive HTML planning dashboard
├── wave-screen.json                  # Source data for development planning & waves
└── AGENTS.md                         # This file
```

---

## 5. Agent Skills Reference

Skills located in `.agents/skills/` provide defined instructions and boundaries:

### 1. `ics-outcome-discovery` ([`SKILL.md`](file:///.agents/skills/ics-outcome-discovery/SKILL.md))
- **Role:** Evaluates a target workspace or screen and extracts candidate business entities.
- **Rules:** Strictly enforces Entity Test, State Transition Test, Count Test, and Consumption Test against `conceptual-model.md` and `DOMAIN-CATALOG.md`.

### 2. `ics-outcome-creation` ([`SKILL.md`](file:///.agents/skills/outcome-creation/SKILL.md))
- **Role:** Generates or updates an `OC-*.md` document.
- **Template:** Always follow [`.agents/skills/outcome-creation/assets/outcome-template.md`](file:///.agents/skills/outcome-creation/assets/outcome-template.md).
- **Mandatory Sections:**
  1. Business Purpose
  2. Outcome Statement
  3. Participating Domains
  4. Participating Capabilities (Mark status: `Known`, `Existing but Undocumented`, or `Capability Candidate`)
  5. Outcome Specification (Required Business Facts, Recorded Information, Lifecycle State Machine)
  6. Boundaries & Exclusions (Explicitly states what the outcome does NOT do)
  7. Participating Use Cases & Triggers
  8. Business Constraints & Invariants
  9. Acceptance Criteria & Verification

### 3. `progress-tracking` ([`SKILL.md`](file:///.agents/skills/progress-tracker/SKILL.md))
- **Role:** Updates execution progress markdown files.
- **Guardrail:** Never overwrites planning baselines. Discrepancies are recorded as planned vs actual.

---

## 6. Execution Commands & Build Tools

### Generating the Planning Dashboard
When `wave-screen.json` is updated:
```bash
# Using Node directly:
node generate_dashboard.js

# Or using the Python runner:
python generate_dashboard.py
```
This rebuilds `myhosweb-development-plan.html` with interactive timeline, progress metrics, and screen breakdown.

### Git Conventions
- **Branch Naming:** `dev-<author>-<MODULE/SCREEN>` (e.g., `dev-fikri-SC-05`)
- **Commit Messages:** Follow Conventional Commits:
  - `docs(outcome): init OC-05-03 Rujuk Internal`
  - `docs(domain): update 04-RAWAT-JALAN-DOMAIN`
  - `feat(dashboard): update wave calculation logic`
  - `fix(catalog): align capability codes in screen catalog`

### Token Optimization (RTK)
Where `rtk` (Rust Token Killer) is available in shell:
```bash
rtk gain              # Check token savings analytics
rtk gain --history    # Check command history savings
```

---

## 7. Guidelines & Guardrails for AI Agents

1. **Terminology & Language:**
   - Maintain technical prose and architecture structures in clear English or Indonesian according to surrounding document context.
   - **Never translate** standard Indonesian hospital business terms (e.g., *Rawat Jalan*, *Rawat Inap*, *Admisi*, *Gawat Darurat*, *Tata Rekening*, *Rujuk Internal*, *Tindakan*, *Berkas RM*, *Casemix*, *Petugas Pemberi Asuhan (PPA)*).
2. **File Naming Standards:**
   - Outcome files: `outcomes/OC-<SCREEN_ID>-<SEQ>-<NAME>.md` (e.g., `OC-05-02-TINDAKAN.md`)
   - Domain files: `domain/<XX>-<NAME>-DOMAIN.md` (e.g., `04-RAWAT-JALAN-DOMAIN.md`)
3. **Data Integrity & Consistency:**
   - Always verify capability codes (`RJL-*`, `ADM-*`, `TRK-*`, `PAS-*`, `ORG-*`) against [`domain/DOMAIN-CATALOG.md`](file:///e:/PROJECT/ICS/FE/myhospital-web/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) before writing outcome specs.
   - Preserve existing markdown headings and table structures.
   - When generating or updating outcomes, ensure cross-references to participating domains and capabilities are valid.
