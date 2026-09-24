# MYHOSWEB Program Tracker

**Artifact:** Program Progress Tracker (Phase-0 Planning)
**Status:** Active — authoritative source of truth for implementation progress
**Source inputs:** `MYHOSWEB-DEVELOPMENT-ORDER.md` (approved, frozen), `MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md`, `MYHOSWEB-SCREEN-FEATURE-CATALOG.md`

## 1. Purpose and Scope

This tracker records **execution and delivery status only**. It is the authoritative source for:

- Program Management
- Progress Monitoring
- Capacity Planning
- Roadmap Tracking
- BoD Reporting (via generated JSON/HTML)

It is **NOT** a replacement for the Development Order, Feature Registry, Complexity Assessment, Architecture documents, or Implementation Plans. Planning and design artifacts remain authoritative for scope, sequence, and complexity; this document only tracks what has actually been executed and delivered.

## 2. Structure and Conventions

The tracking hierarchy mirrors the approved Development Order:

```text
Program
  └── Milestone   (## Milestone Mxx — Title)
       └── Screen (### SC-xx Screen Name)
            └── Feature (#### FT-xx-yy Feature Name)
```

The tracking unit is **Milestone + Screen + Feature**. Each occurrence of a Feature under a Screen has its own tracking record. A Screen may appear in multiple milestones (e.g., SC-01 Admisi appears in M01 and M06); each occurrence is tracked separately because the delivery context differs.

### Field Conventions

| Convention | Value |
| ---------- | ----- |
| Date format | `YYYY-MM-DD` (ISO 8601) |
| Duration format | `Nd` (business days), e.g. `10d` |
| Unknown / not yet planned | `TBD` |
| Not applicable / not yet occurred | `-` |
| Missing Rollout hospital | single `TBD` row; duplicate the row per hospital as rollout proceeds |

### Status Values

Phase statuses (Analysis, Testing, Pilot Deployment, Rollout rows) use exactly:

```text
NOT_STARTED | IN_PROGRESS | COMPLETED | BLOCKED
```

Feature **Overall Status** reflects the current delivery stage and uses exactly:

```text
NOT_STARTED | PLANNING | ANALYSIS | IMPLEMENTATION | REVIEW | TESTING | PILOT_DEPLOYMENT | ROLLED_OUT | COMPLETED | BLOCKED
```

Rollout status for an individual hospital uses the phase status set. When all pilot and rollout hospitals reach `COMPLETED` and the feature is accepted, the Overall Status becomes `COMPLETED`.

## 3. Program Summary

| Milestone | Title | Screens | Features | Completed | In Progress | Blocked | Not Started |
| --------- | ----- | ------- | -------- | --------- | ----------- | ------- | ----------- |
| M01 | Patient Admission Foundation | 1 | 6 | 6 | 0 | 0 | 0 |
| M02 | Emergency Department Operations | 1 | 4 | 0 | 0 | 0 | 4 |
| M03 | Outpatient Clinical Operations | 1 | 4 | 0 | 0 | 0 | 4 |
| M04 | Pharmacy Operations | 1 | 7 | 0 | 0 | 0 | 7 |
| M05 | Billing and Cashier Operations | 2 | 6 | 0 | 0 | 0 | 6 |
| M06 | Inpatient Operations | 3 | 7 | 0 | 0 | 0 | 7 |
| M07 | Inventory Foundation and Shared Barang Capability | 4 | 13 | 0 | 0 | 0 | 13 |
| M08 | Procurement Operations | 2 | 6 | 0 | 0 | 0 | 6 |
| M09 | Laboratory Operations | 1 | 8 | 0 | 0 | 0 | 8 |
| M10 | Radiology Operations | 1 | 8 | 0 | 0 | 0 | 8 |
| M11 | Master Data Foundation | 1 | 5 | 0 | 0 | 0 | 5 |
| M12 | Medical Record Administration | 1 | 5 | 0 | 0 | 0 | 5 |
| M13 | Operating Theatre Operations | 1 | 7 | 0 | 0 | 0 | 7 |
| **Total** | — | — | **86** | **6** | **0** | **0** | **80** |

## 4. Milestone Trackers

---

## Milestone M01 — Patient Admission Foundation

**Business description:** Establish the patient entry point into the hospital system, including registration, scheduling, queueing, BPJS validation, and patient tracking.

**Milestone Status:** IN_PROGRESS

### SC-01 Admisi

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-01-01 | Booking | SC-01 | Admisi | 3 | COMPLETED | TBD | TBD |
| FT-01-02 | Registrasi Rawat Jalan dan IGD | SC-01 | Admisi | 4 | COMPLETED | TBD | TBD |
| FT-01-04 | VCLAIM BPJS | SC-01 | Admisi | 5 | COMPLETED | TBD | TBD |
| FT-01-05 | Patient Journey Tracking | SC-01 | Admisi | 4 | COMPLETED | TBD | TBD |
| FT-01-06 | Jadwal Praktek | SC-01 | Admisi | 3 | COMPLETED | TBD | TBD |
| FT-01-07 | Antrian | SC-01 | Admisi | 3 | COMPLETED | TBD | TBD |

#### FT-01-01 Booking

| Field | Value |
| ----- | ----- |
| Overall Status | COMPLETED |
| Planned Start Date | TBD |
| Planned Duration | TBD |
| Actual Completion Date | 2026-09-22 |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-01-02 Registrasi Rawat Jalan dan IGD

| Field | Value |
| ----- | ----- |
| Overall Status | COMPLETED |
| Planned Start Date | TBD |
| Planned Duration | TBD |
| Actual Completion Date | 2026-09-22 |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-01-04 VCLAIM BPJS

| Field | Value |
| ----- | ----- |
| Overall Status | COMPLETED |
| Planned Start Date | TBD |
| Planned Duration | TBD |
| Actual Completion Date | 2026-09-22 |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-01-05 Patient Journey Tracking

| Field | Value |
| ----- | ----- |
| Overall Status | COMPLETED |
| Planned Start Date | TBD |
| Planned Duration | TBD |
| Actual Completion Date | 2026-09-22 |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-01-06 Jadwal Praktek

| Field | Value |
| ----- | ----- |
| Overall Status | COMPLETED |
| Planned Start Date | TBD |
| Planned Duration | TBD |
| Actual Completion Date | 2026-09-22 |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-01-07 Antrian

| Field | Value |
| ----- | ----- |
| Overall Status | COMPLETED |
| Planned Start Date | TBD |
| Planned Duration | TBD |
| Actual Completion Date | 2026-09-22 |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M02 — Emergency Department Operations

**Business description:** Enable the complete operational workflow for emergency services from arrival through treatment.

**Milestone Status:** NOT_STARTED

### SC-07 IGD

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-07-01 | IGD Visit | SC-07 | IGD | 3 | NOT_STARTED | TBD | TBD |
| FT-07-02 | Triage | SC-07 | IGD | 3 | NOT_STARTED | TBD | TBD |
| FT-07-03 | Ambulance | SC-07 | IGD | 3 | NOT_STARTED | TBD | TBD |
| FT-07-04 | Tindakan | SC-07 | IGD | 3 | NOT_STARTED | TBD | TBD |

#### FT-07-01 IGD Visit

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-07-02 Triage

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-07-03 Ambulance

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-07-04 Tindakan

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M03 — Outpatient Clinical Operations

**Business description:** Enable outpatient service operations, including treatment, internal referrals, and examination ordering.

**Milestone Status:** NOT_STARTED

### SC-05 Poli Rawat Jalan

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-05-01 | Antrian | SC-05 | Poli Rawat Jalan | 3 | NOT_STARTED | TBD | TBD |
| FT-05-02 | Tindakan | SC-05 | Poli Rawat Jalan | 3 | NOT_STARTED | TBD | TBD |
| FT-05-03 | Rujuk Internal | SC-05 | Poli Rawat Jalan | 3 | NOT_STARTED | TBD | TBD |
| FT-05-04 | CPOE (Order Pemeriksaan) | SC-05 | Poli Rawat Jalan | 4 | NOT_STARTED | TBD | TBD |

#### FT-05-01 Antrian

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-05-02 Tindakan

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-05-03 Rujuk Internal

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-05-04 CPOE (Order Pemeriksaan)

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M04 — Pharmacy Operations

**Business description:** Enable prescription processing, dispensing, medication handover, and pharmacy stock control.

**Milestone Status:** NOT_STARTED

### SC-11 Apotek

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-11-01 | Antrian Apotek | SC-11 | Apotek | 3 | NOT_STARTED | TBD | TBD |
| FT-11-02 | Telaah Resep | SC-11 | Apotek | 3 | NOT_STARTED | TBD | TBD |
| FT-11-03 | Penjualan | SC-11 | Apotek | 4 | NOT_STARTED | TBD | TBD |
| FT-11-04 | Dispensing | SC-11 | Apotek | 3 | NOT_STARTED | TBD | TBD |
| FT-11-05 | Serah Obat | SC-11 | Apotek | 3 | NOT_STARTED | TBD | TBD |
| FT-11-06 | Opname | SC-11 | Apotek | 3 | NOT_STARTED | TBD | TBD |
| FT-11-07 | Mutasi | SC-11 | Apotek | 3 | NOT_STARTED | TBD | TBD |

#### FT-11-01 Antrian Apotek

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-11-02 Telaah Resep

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-11-03 Penjualan

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-11-04 Dispensing

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-11-05 Serah Obat

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-11-06 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-11-07 Mutasi

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M05 — Billing and Cashier Operations

**Business description:** Establish revenue cycle processing, including billing, payment allocation, cashier operation, and financial settlement.

**Milestone Status:** NOT_STARTED

### SC-02 Tata Rekening

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-02-01 | Rincian Tagihan Pasien | SC-02 | Tata Rekening | 4 | NOT_STARTED | TBD | TBD |
| FT-02-02 | Alokasi Pembayaran | SC-02 | Tata Rekening | 4 | NOT_STARTED | TBD | TBD |
| FT-02-05 | Reg-Out | SC-02 | Tata Rekening | 4 | NOT_STARTED | TBD | TBD |

#### FT-02-01 Rincian Tagihan Pasien

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-02-02 Alokasi Pembayaran

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-02-05 Reg-Out

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

### SC-03 Kasir

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-03-01 | Order Bayar | SC-03 | Kasir | 3 | NOT_STARTED | TBD | TBD |
| FT-03-02 | Pembayaran | SC-03 | Kasir | 4 | NOT_STARTED | TBD | TBD |
| FT-03-03 | Closing Shift | SC-03 | Kasir | 4 | NOT_STARTED | TBD | TBD |

#### FT-03-01 Order Bayar

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-03-02 Pembayaran

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-03-03 Closing Shift

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M06 — Inpatient Operations

**Business description:** Enable inpatient service management, including bed occupancy, transfer, discharge, and related financial processes.

**Milestone Status:** NOT_STARTED

### SC-01 Admisi

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-01-03 | Registrasi Rawat Inap | SC-01 | Admisi | 4 | NOT_STARTED | TBD | TBD |

#### FT-01-03 Registrasi Rawat Inap

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

### SC-06 Bangsal Rawat Inap

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-06-01 | Tindakan | SC-06 | Bangsal Rawat Inap | 3 | NOT_STARTED | TBD | TBD |
| FT-06-02 | Pakai Bed | SC-06 | Bangsal Rawat Inap | 4 | NOT_STARTED | TBD | TBD |
| FT-06-03 | Transfer Unit | SC-06 | Bangsal Rawat Inap | 4 | NOT_STARTED | TBD | TBD |
| FT-06-04 | Discharge | SC-06 | Bangsal Rawat Inap | 4 | NOT_STARTED | TBD | TBD |

#### FT-06-01 Tindakan

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-06-02 Pakai Bed

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-06-03 Transfer Unit

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-06-04 Discharge

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

### SC-02 Tata Rekening

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-02-03 | Deposit | SC-02 | Tata Rekening | 3 | NOT_STARTED | TBD | TBD |
| FT-02-04 | Refund | SC-02 | Tata Rekening | 4 | NOT_STARTED | TBD | TBD |

#### FT-02-03 Deposit

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-02-04 Refund

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M07 — Inventory Foundation and Shared Barang Capability

**Business description:** Establish warehouse inventory control and the shared stock-management capabilities used by operational departments.

**Milestone Status:** NOT_STARTED

### SC-12 Gudang

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-12-02 | Mutasi | SC-12 | Gudang | 3 | NOT_STARTED | TBD | TBD |
| FT-12-03 | Opname | SC-12 | Gudang | 3 | NOT_STARTED | TBD | TBD |
| FT-12-04 | Musnah | SC-12 | Gudang | 4 | NOT_STARTED | TBD | TBD |
| FT-12-05 | Retur Beli | SC-12 | Gudang | 4 | NOT_STARTED | TBD | TBD |

#### FT-12-02 Mutasi

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-12-03 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-12-04 Musnah

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-12-05 Retur Beli

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

### SC-05 Poli Rawat Jalan

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-05-05 | Pakai Barang | SC-05 | Poli Rawat Jalan | 3 | NOT_STARTED | TBD | TBD |
| FT-05-06 | Mutasi Barang | SC-05 | Poli Rawat Jalan | 3 | NOT_STARTED | TBD | TBD |
| FT-05-07 | Opname | SC-05 | Poli Rawat Jalan | 3 | NOT_STARTED | TBD | TBD |

#### FT-05-05 Pakai Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-05-06 Mutasi Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-05-07 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

### SC-07 IGD

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-07-05 | Pakai Barang | SC-07 | IGD | 3 | NOT_STARTED | TBD | TBD |
| FT-07-06 | Mutasi Barang | SC-07 | IGD | 3 | NOT_STARTED | TBD | TBD |
| FT-07-07 | Opname | SC-07 | IGD | 3 | NOT_STARTED | TBD | TBD |

#### FT-07-05 Pakai Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-07-06 Mutasi Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-07-07 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

### SC-06 Bangsal Rawat Inap

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-06-05 | Pakai Barang | SC-06 | Bangsal Rawat Inap | 3 | NOT_STARTED | TBD | TBD |
| FT-06-06 | Mutasi Barang | SC-06 | Bangsal Rawat Inap | 3 | NOT_STARTED | TBD | TBD |
| FT-06-07 | Opname | SC-06 | Bangsal Rawat Inap | 3 | NOT_STARTED | TBD | TBD |

#### FT-06-05 Pakai Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-06-06 Mutasi Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-06-07 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M08 — Procurement Operations

**Business description:** Enable material planning, purchasing, supplier ordering, receiving coordination, and invoice processing.

**Milestone Status:** NOT_STARTED

### SC-13 Purchasing

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-13-01 | Material Request | SC-13 | Purchasing | 3 | NOT_STARTED | TBD | TBD |
| FT-13-02 | Forecasting | SC-13 | Purchasing | 4 | NOT_STARTED | TBD | TBD |
| FT-13-03 | Purchase Request | SC-13 | Purchasing | 4 | NOT_STARTED | TBD | TBD |
| FT-13-04 | Purchase Order | SC-13 | Purchasing | 4 | NOT_STARTED | TBD | TBD |
| FT-13-05 | Faktur Tagihan | SC-13 | Purchasing | 4 | NOT_STARTED | TBD | TBD |

#### FT-13-01 Material Request

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-13-02 Forecasting

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-13-03 Purchase Request

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-13-04 Purchase Order

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-13-05 Faktur Tagihan

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

### SC-12 Gudang

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-12-01 | Terima Barang (DO) | SC-12 | Gudang | 4 | NOT_STARTED | TBD | TBD |

#### FT-12-01 Terima Barang (DO)

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M09 — Laboratory Operations

**Business description:** Enable laboratory workflow from registration through specimen collection and result management.

**Milestone Status:** NOT_STARTED

### SC-08 Laboratorium

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-08-01 | External Registration | SC-08 | Laboratorium | 3 | NOT_STARTED | TBD | TBD |
| FT-08-02 | Order Laboratorium | SC-08 | Laboratorium | 3 | NOT_STARTED | TBD | TBD |
| FT-08-03 | Charge | SC-08 | Laboratorium | 3 | NOT_STARTED | TBD | TBD |
| FT-08-04 | Sample Collection | SC-08 | Laboratorium | 3 | NOT_STARTED | TBD | TBD |
| FT-08-05 | Result Management | SC-08 | Laboratorium | 4 | NOT_STARTED | TBD | TBD |
| FT-08-06 | Pakai Barang | SC-08 | Laboratorium | 3 | NOT_STARTED | TBD | TBD |
| FT-08-07 | Mutasi Barang | SC-08 | Laboratorium | 3 | NOT_STARTED | TBD | TBD |
| FT-08-08 | Opname | SC-08 | Laboratorium | 3 | NOT_STARTED | TBD | TBD |

#### FT-08-01 External Registration

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-08-02 Order Laboratorium

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-08-03 Charge

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-08-04 Sample Collection

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-08-05 Result Management

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-08-06 Pakai Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-08-07 Mutasi Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-08-08 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M10 — Radiology Operations

**Business description:** Enable radiology workflow from order management through interpretation and verification.

**Milestone Status:** NOT_STARTED

### SC-09 Radiologi

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-09-01 | Order Radiologi | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |
| FT-09-02 | Scheduling | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |
| FT-09-03 | Imaging | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |
| FT-09-04 | Expertise | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |
| FT-09-05 | Verification | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |
| FT-09-06 | Pakai Barang | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |
| FT-09-07 | Mutasi Barang | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |
| FT-09-08 | Opname | SC-09 | Radiologi | 3 | NOT_STARTED | TBD | TBD |

#### FT-09-01 Order Radiologi

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-09-02 Scheduling

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-09-03 Imaging

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-09-04 Expertise

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-09-05 Verification

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-09-06 Pakai Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-09-07 Mutasi Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-09-08 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M11 — Master Data Foundation

**Business description:** Establish organizational master data required by all operational modules.

**Milestone Status:** NOT_STARTED

### SC-14 Mastering

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-14-01 | Master Organisasi | SC-14 | Mastering | TBD | NOT_STARTED | TBD | TBD |
| FT-14-02 | Master Dokter | SC-14 | Mastering | TBD | NOT_STARTED | TBD | TBD |
| FT-14-03 | Master Jaminan | SC-14 | Mastering | TBD | NOT_STARTED | TBD | TBD |
| FT-14-04 | Master Layanan | SC-14 | Mastering | TBD | NOT_STARTED | TBD | TBD |
| FT-14-05 | Master Tarif | SC-14 | Mastering | TBD | NOT_STARTED | TBD | TBD |

#### FT-14-01 Master Organisasi

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-14-02 Master Dokter

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-14-03 Master Jaminan

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-14-04 Master Layanan

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-14-05 Master Tarif

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M12 — Medical Record Administration

**Business description:** Enable administrative medical record management, coding, and regulatory reporting.

**Milestone Status:** NOT_STARTED

### SC-04 Rekam Medis

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-04-01 | Data Sosial Pasien | SC-04 | Rekam Medis | 2 | NOT_STARTED | TBD | TBD |
| FT-04-02 | Manajemen Berkas | SC-04 | Rekam Medis | 3 | NOT_STARTED | TBD | TBD |
| FT-04-03 | Casemix dan Coding | SC-04 | Rekam Medis | 4 | NOT_STARTED | TBD | TBD |
| FT-04-04 | Pelaporan RL | SC-04 | Rekam Medis | 5 | NOT_STARTED | TBD | TBD |
| FT-04-05 | Pelaporan Index dan Sensus | SC-04 | Rekam Medis | 4 | NOT_STARTED | TBD | TBD |

#### FT-04-01 Data Sosial Pasien

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-04-02 Manajemen Berkas

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-04-03 Casemix dan Coding

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-04-04 Pelaporan RL

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-04-05 Pelaporan Index dan Sensus

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## Milestone M13 — Operating Theatre Operations

**Business description:** Enable operating theatre scheduling, operative workflow management, and post-operative coordination.

**Milestone Status:** NOT_STARTED

### SC-10 Kamar Operasi

| Feature ID | Feature Name | Screen ID | Screen Name | Complexity | Overall Status | Planned Start | Duration |
| ---------- | ------------ | --------- | ----------- | ---------- | -------------- | ------------- | -------- |
| FT-10-01 | Order Operasi | SC-10 | Kamar Operasi | 3 | NOT_STARTED | TBD | TBD |
| FT-10-02 | Scheduling | SC-10 | Kamar Operasi | 4 | NOT_STARTED | TBD | TBD |
| FT-10-03 | Pre-Operative Clearance | SC-10 | Kamar Operasi | 3 | NOT_STARTED | TBD | TBD |
| FT-10-04 | Post-Operative Management | SC-10 | Kamar Operasi | 3 | NOT_STARTED | TBD | TBD |
| FT-10-05 | Pakai Barang | SC-10 | Kamar Operasi | 3 | NOT_STARTED | TBD | TBD |
| FT-10-06 | Mutasi Barang | SC-10 | Kamar Operasi | 3 | NOT_STARTED | TBD | TBD |
| FT-10-07 | Opname | SC-10 | Kamar Operasi | 3 | NOT_STARTED | TBD | TBD |

#### FT-10-01 Order Operasi

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-10-02 Scheduling

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-10-03 Pre-Operative Clearance

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-10-04 Post-Operative Management

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-10-05 Pakai Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-10-06 Mutasi Barang

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

#### FT-10-07 Opname

| Field | Value |
| ----- | ----- |
| Overall Status | NOT_STARTED |
| Planned Start Date | TBD |
| Planned Duration | TBD |

**Analysis**

| Analyst | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Testing**

| Tester | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| ------ | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Pilot Deployment**

| Deployer | Hospital | Planned Start | Planned End | Actual Start | Actual End | Duration | Status |
| -------- | -------- | ------------- | ----------- | ------------ | ---------- | -------- | ------ |
| TBD | TBD | TBD | TBD | - | - | - | NOT_STARTED |

**Rollout**

| Hospital | PIC | Status |
| -------- | --- | ------ |
| TBD | TBD | NOT_STARTED |

---

## 5. Maintenance Rules

1. Add, remove, or move tracking records only when the Development Order changes (the Development Order remains the authority on milestone membership; changes there require management approval and must then be reflected here).
2. Update `Overall Status` only as the feature crosses real delivery stages; do not advance status based on plans alone.
3. Record actual dates only when work has actually started or ended; keep planned dates as the baseline and add revised dates in the commit/revision history, not by overwriting silently.
4. For shared canonical capabilities (`Pakai Barang`, `Mutasi Barang`, `Opname`), each Screen occurrence remains a separate record; a single implementation may complete several records at once, but each record must be confirmed independently.
5. Keep column headers, heading formats, and status values exactly as defined above so that JSON/HTML generators can parse this document reliably.
6. Complexity values are copied from the Feature Complexity Assessment (Business Complexity, Level 1-5). `TBD` for SC-14 features indicates no assessment exists yet; update when assessed.

## 6. Traceability

| This Artifact | Source Artifact | Relationship |
| ------------- | --------------- | ------------ |
| Program Tracker | Development Order | Milestone / Screen / Feature grouping and ordering |
| Program Tracker | Screen-Feature Catalog | Screen and Feature identifiers and names |
| Program Tracker | Feature Complexity Assessment | Complexity Level per Feature (Business Complexity) |
| JSON/HTML dashboards | Program Tracker | Generated from this document; this document is the source of truth |

