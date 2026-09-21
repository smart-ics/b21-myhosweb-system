# MYHOSWEB Development Order

**Planning Status:** Approved and frozen

## Table of Contents

- [1. Executive Summary](#1-executive-summary)
- [2. Planning Principles](#2-planning-principles)
- [3. Approved Development Order](#3-approved-development-order)
  - [Milestone-1 — Patient Admission Foundation](#milestone-1--patient-admission-foundation)
  - [Milestone-2 — Emergency Department Operations](#milestone-2--emergency-department-operations)
  - [Milestone-3 — Outpatient Clinical Operations](#milestone-3--outpatient-clinical-operations)
  - [Milestone-4 — Pharmacy Operations](#milestone-4--pharmacy-operations)
  - [Milestone-5 — Billing and Cashier Operations](#milestone-5--billing-and-cashier-operations)
  - [Milestone-6 — Inpatient Operations](#milestone-6--inpatient-operations)
  - [Milestone-7 — Inventory Foundation and Shared Barang Capability](#milestone-7--inventory-foundation-and-shared-barang-capability)
  - [Milestone-8 — Procurement Operations](#milestone-8--procurement-operations)
  - [Milestone-9 — Laboratory Operations](#milestone-9--laboratory-operations)
  - [Milestone-10 — Radiology Operations](#milestone-10--radiology-operations)
  - [Milestone-11 — Master Data Foundation](#milestone-11--master-data-foundation)
  - [Milestone-12 — Medical Record Administration](#milestone-12--medical-record-administration)
  - [Milestone-13 — Operating Theatre Operations](#milestone-13--operating-theatre-operations)
- [4. Development Order Governance](#4-development-order-governance)
- [5. Relationship to Other Planning Artifacts](#5-relationship-to-other-planning-artifacts)
- [6. Traceability Matrix](#6-traceability-matrix)

---

## 1. Executive Summary

MYHOSWEB will be delivered incrementally. Existing hospitals will continue using the desktop system while MYHOSWEB is progressively introduced. Deployment will not wait for the completion of the full system; features and Screens will be released as they become production-ready.

The development order is a deliberate business-priority sequence. It is designed to maximize operational value while minimizing implementation risk by establishing patient-facing workflows first, followed by revenue, shared operational, and specialized capabilities. This sequence is the baseline for future planning, prioritization, scope control, capacity planning, and roadmap activities.

## 2. Planning Principles

### Incremental Delivery

Features are delivered independently and may be deployed without waiting for later milestones. Each completed milestone is intended to provide usable operational value.

### Patient Lifecycle First

Patient-facing operational workflows receive priority before supporting and administrative capabilities. This establishes the core service journey before expanding the system's supporting functions.

### Revenue Protection

Billing, pharmacy, and payment capabilities are prioritized before secondary operational modules to protect revenue capture, payment control, and financial settlement.

### Shared Capability Reuse

Inventory-related capabilities are developed once and reused by multiple Screens. This avoids treating repeated operational usage as separate business capabilities.

### Deferred Specialization

Highly specialized modules such as Laboratory, Radiology, Operating Theatre, and Medical Record Administration are scheduled after core operational workflows are stabilized.

## 3. Approved Development Order

The following sequence is the approved business delivery order. The feature tables retain the approved Screen and Feature identifiers. The source approval record contains a skipped label; this document presents the same approved sequence as thirteen consecutive milestones for executive planning purposes.

### Milestone-1 — Patient Admission Foundation

**Business description:** Establish the patient entry point into the hospital system, including registration, scheduling, queueing, BPJS validation, and patient tracking.

**Why this milestone exists:** Every subsequent patient-facing service depends on a reliable and visible admission journey.

**Business value:** The hospital gains a consistent front door for patient access, better visibility of patient movement, and a foundation for coordinated service delivery.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-01 Admisi | FT-01-01 Booking |
| 2 | SC-01 Admisi | FT-01-02 Registrasi Rawat Jalan dan IGD |
| 3 | SC-01 Admisi | FT-01-04 VCLAIM BPJS |
| 4 | SC-01 Admisi | FT-01-05 Patient Journey Tracking |
| 5 | SC-01 Admisi | FT-01-06 Jadwal Praktek |
| 6 | SC-01 Admisi | FT-01-07 Antrian |

### Milestone-2 — Emergency Department Operations

**Business description:** Enable the complete operational workflow for emergency services from arrival through treatment.

**Why this milestone exists:** Emergency services require a focused workflow that supports rapid intake, prioritization, transport, and treatment.

**Business value:** Emergency teams gain greater operational visibility and a more coordinated response to urgent patient needs.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-07 IGD | FT-07-01 IGD Visit |
| 2 | SC-07 IGD | FT-07-02 Triage |
| 3 | SC-07 IGD | FT-07-03 Ambulance |
| 4 | SC-07 IGD | FT-07-04 Tindakan |

### Milestone-3 — Outpatient Clinical Operations

**Business description:** Enable outpatient service operations, including treatment, internal referrals, and examination ordering.

**Why this milestone exists:** Outpatient services represent a core recurring care pathway and require coordinated clinical and service activity.

**Business value:** Outpatient teams gain a structured workflow from queue management through treatment and examination requests, improving service continuity.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-05 Poli Rawat Jalan | FT-05-01 Antrian |
| 2 | SC-05 Poli Rawat Jalan | FT-05-02 Tindakan |
| 3 | SC-05 Poli Rawat Jalan | FT-05-03 Rujuk Internal |
| 4 | SC-05 Poli Rawat Jalan | FT-05-04 CPOE (Order Pemeriksaan) |

### Milestone-4 — Pharmacy Operations

**Business description:** Enable prescription processing, dispensing, medication handover, and pharmacy stock control.

**Why this milestone exists:** Pharmacy is a direct continuation of patient care and a material point of medication control and revenue realization.

**Business value:** The hospital gains a controlled medication workflow from prescription review through handover, with improved accountability for pharmacy transactions and stock activity.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-11 Apotek | FT-11-01 Antrian Apotek |
| 2 | SC-11 Apotek | FT-11-02 Telaah Resep |
| 3 | SC-11 Apotek | FT-11-03 Penjualan |
| 4 | SC-11 Apotek | FT-11-04 Dispensing |
| 5 | SC-11 Apotek | FT-11-05 Serah Obat |
| 6 | SC-11 Apotek | FT-11-06 Opname |
| 7 | SC-11 Apotek | FT-11-07 Mutasi |

### Milestone-5 — Billing and Cashier Operations

**Business description:** Establish revenue cycle processing, including billing, payment allocation, cashier operation, and financial settlement.

**Why this milestone exists:** Operational services must be connected to reliable charge, payment, and settlement processes.

**Business value:** The hospital gains stronger revenue capture, clearer payment accountability, and controlled cashier closing processes.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-02 Tata Rekening | FT-02-01 Rincian Tagihan Pasien |
| 2 | SC-02 Tata Rekening | FT-02-02 Alokasi Pembayaran |
| 3 | SC-02 Tata Rekening | FT-02-05 Reg-Out |
| 4 | SC-03 Kasir | FT-03-01 Order Bayar |
| 5 | SC-03 Kasir | FT-03-02 Pembayaran |
| 6 | SC-03 Kasir | FT-03-03 Closing Shift |

### Milestone-6 — Inpatient Operations

**Business description:** Enable inpatient service management, including bed occupancy, transfer, discharge, and related financial processes.

**Why this milestone exists:** Inpatient care introduces longer patient journeys and requires coordinated control of beds, units, discharge, and financial obligations.

**Business value:** The hospital gains visibility and control over inpatient capacity, patient movement, discharge, deposits, refunds, and continuity of billing.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-01 Admisi | FT-01-03 Registrasi Rawat Inap |
| 2 | SC-06 Bangsal Rawat Inap | FT-06-01 Tindakan |
| 3 | SC-06 Bangsal Rawat Inap | FT-06-02 Pakai Bed |
| 4 | SC-06 Bangsal Rawat Inap | FT-06-03 Transfer Unit |
| 5 | SC-06 Bangsal Rawat Inap | FT-06-04 Discharge |
| 6 | SC-02 Tata Rekening | FT-02-03 Deposit |
| 7 | SC-02 Tata Rekening | FT-02-04 Refund |

### Milestone-7 — Inventory Foundation and Shared Barang Capability

**Business description:** Establish warehouse inventory control and the shared stock-management capabilities used by operational departments.

**Why this milestone exists:** Reliable stock control is a prerequisite for accountable material usage across the hospital.

**Business value:** The hospital gains a common basis for stock movement, stock counting, disposal, returns, and material usage across departments.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-12 Gudang | FT-12-02 Mutasi |
| 2 | SC-12 Gudang | FT-12-03 Opname |
| 3 | SC-12 Gudang | FT-12-04 Musnah |
| 4 | SC-12 Gudang | FT-12-05 Retur Beli |
| 5 | SC-05 Poli Rawat Jalan | FT-05-05 Pakai Barang |
| 6 | SC-05 Poli Rawat Jalan | FT-05-06 Mutasi Barang |
| 7 | SC-05 Poli Rawat Jalan | FT-05-07 Opname |
| 8 | SC-07 IGD | FT-07-05 Pakai Barang |
| 9 | SC-07 IGD | FT-07-06 Mutasi Barang |
| 10 | SC-07 IGD | FT-07-07 Opname |
| 11 | SC-06 Bangsal Rawat Inap | FT-06-05 Pakai Barang |
| 12 | SC-06 Bangsal Rawat Inap | FT-06-06 Mutasi Barang |
| 13 | SC-06 Bangsal Rawat Inap | FT-06-07 Opname |

**Canonical shared capabilities:** `Pakai Barang`, `Mutasi Barang`, and `Opname` are implemented once as canonical shared capabilities and reused across multiple Screens. Their appearance in a Screen represents contextual use of the same business capability, not a separate implementation for each Screen.

### Milestone-8 — Procurement Operations

**Business description:** Enable material planning, purchasing, supplier ordering, receiving coordination, and invoice processing.

**Why this milestone exists:** Inventory sustainability depends on disciplined planning and controlled replenishment from suppliers.

**Business value:** The hospital gains better purchasing visibility, supplier coordination, receiving control, and invoice traceability.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-13 Purchasing | FT-13-01 Material Request |
| 2 | SC-13 Purchasing | FT-13-02 Forecasting |
| 3 | SC-13 Purchasing | FT-13-03 Purchase Request |
| 4 | SC-12 Gudang | FT-12-01 Terima Barang (DO) |
| 5 | SC-13 Purchasing | FT-13-04 Purchase Order |
| 6 | SC-13 Purchasing | FT-13-05 Faktur Tagihan |

### Milestone-9 — Laboratory Operations

**Business description:** Enable laboratory workflow from registration through specimen collection and result management.

**Why this milestone exists:** Laboratory services require an end-to-end operational path connecting requests, specimens, charges, and results.

**Business value:** Laboratory operations gain improved order visibility, specimen accountability, and timely management of diagnostic results.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-08 Laboratorium | FT-08-01 External Registration |
| 2 | SC-08 Laboratorium | FT-08-02 Order Laboratorium |
| 3 | SC-08 Laboratorium | FT-08-03 Charge |
| 4 | SC-08 Laboratorium | FT-08-04 Sample Collection |
| 5 | SC-08 Laboratorium | FT-08-05 Result Management |
| 6 | SC-08 Laboratorium | FT-08-06 Pakai Barang |
| 7 | SC-08 Laboratorium | FT-08-07 Mutasi Barang |
| 8 | SC-08 Laboratorium | FT-08-08 Opname |

### Milestone-10 — Radiology Operations

**Business description:** Enable radiology workflow from order management through interpretation and verification.

**Why this milestone exists:** Radiology requires coordinated scheduling and controlled progression from examination order to verified interpretation.

**Business value:** Radiology teams gain clearer workflow control, improved examination coordination, and stronger verification discipline.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-09 Radiologi | FT-09-01 Order Radiologi |
| 2 | SC-09 Radiologi | FT-09-02 Scheduling |
| 3 | SC-09 Radiologi | FT-09-03 Imaging |
| 4 | SC-09 Radiologi | FT-09-04 Expertise |
| 5 | SC-09 Radiologi | FT-09-05 Verification |
| 6 | SC-09 Radiologi | FT-09-06 Pakai Barang |
| 7 | SC-09 Radiologi | FT-09-07 Mutasi Barang |
| 8 | SC-09 Radiologi | FT-09-08 Opname |

### Milestone-11 — Master Data Foundation

**Business description:** Establish organizational master data required by all operational modules.

**Why this milestone exists:** Consistent organizational, provider, payer, service, and tariff information is necessary for dependable operations and reporting.

**Business value:** The hospital gains a common reference point for operational consistency, service configuration, and financial control.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-14 Mastering | FT-14-01 Master Organisasi |
| 2 | SC-14 Mastering | FT-14-02 Master Dokter |
| 3 | SC-14 Mastering | FT-14-03 Master Jaminan |
| 4 | SC-14 Mastering | FT-14-04 Master Layanan |
| 5 | SC-14 Mastering | FT-14-05 Master Tarif |

### Milestone-12 — Medical Record Administration

**Business description:** Enable administrative medical record management, coding, and regulatory reporting.

**Why this milestone exists:** Medical record administration requires structured control of patient record administration, coding, and institutional reporting after core operational workflows are established.

**Business value:** The hospital gains stronger record administration, coding support, and regulatory reporting capability.

This milestone focuses on medical record administration and reporting. Clinical documentation and clinical decision-making are owned by the Electronic Medical Record (EMR) platform and are outside the scope of this milestone.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-04 Rekam Medis | FT-04-01 Data Sosial Pasien |
| 2 | SC-04 Rekam Medis | FT-04-02 Manajemen Berkas |
| 3 | SC-04 Rekam Medis | FT-04-03 Casemix dan Coding |
| 4 | SC-04 Rekam Medis | FT-04-04 Pelaporan RL |
| 5 | SC-04 Rekam Medis | FT-04-05 Pelaporan Index dan Sensus |

### Milestone-13 — Operating Theatre Operations

**Business description:** Enable operating theatre scheduling, operative workflow management, and post-operative coordination.

**Why this milestone exists:** Operating theatre services require specialized coordination of orders, scheduling, clearance, operative activity, and post-operative follow-up.

**Business value:** The hospital gains a controlled operating theatre workflow with improved coordination of scarce resources and post-operative activities.

| No | Screen | Feature |
|---:|---|---|
| 1 | SC-10 Kamar Operasi | FT-10-01 Order Operasi |
| 2 | SC-10 Kamar Operasi | FT-10-02 Scheduling |
| 3 | SC-10 Kamar Operasi | FT-10-03 Pre-Operative Clearance |
| 4 | SC-10 Kamar Operasi | FT-10-04 Post-Operative Management |
| 5 | SC-10 Kamar Operasi | FT-10-05 Pakai Barang |
| 6 | SC-10 Kamar Operasi | FT-10-06 Mutasi Barang |
| 7 | SC-10 Kamar Operasi | FT-10-07 Opname |

## 4. Development Order Governance

- This development order is approved and frozen.
- Subsequent planning artifacts must use this sequence.
- Feature complexity may influence effort estimation.
- Feature complexity may influence delivery duration.
- Feature complexity must not alter the approved milestone sequence.
- Future changes to the sequence require explicit management approval.

The approved order governs business prioritization. Estimation and delivery planning may refine the work required within a milestone, but may not reorder the milestones.

## 5. Relationship to Other Planning Artifacts

```text
Domain Catalog
        ↓
Screen-Feature Catalog
        ↓
Feature Complexity Assessment
        ↓
Development Order
        ↓
Feature Work Breakdown
        ↓
Capacity Planning
        ↓
Roadmap
        ↓
Implementation
```

## 6. Traceability Matrix

| This Artifact | Source Artifact | Relationship | Downstream Artifact |
| ------------- | --------------- | ------------ | ------------------- |
| Development Order | Screen-Feature Catalog | Sequences the cataloged Screens/Features into approved milestones using the SC-xx / FT-xx-xx identifiers | Feature Task Model |
| Development Order | Feature Complexity Assessment | Uses complexity to inform effort and duration without reordering the approved sequence | Feature Task Model |
