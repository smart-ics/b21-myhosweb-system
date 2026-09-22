# MyHospital Domain Catalog V1.1

## Purpose

This document defines the business domains of the MyHospital Platform and the major business capabilities owned by each domain.

The purpose of this catalog is to establish a common business decomposition model for:
- Screen planning
- Feature discovery
- Complexity assessment
- Development roadmap planning
- Migration planning from legacy desktop applications to MyHospital Web

> **Note:** This catalog is not intended to define technical architecture, database structure, aggregates, APIs, or user interface design.

---

## Table of Contents

- [DOM-01 Patient](#dom-01-patient)
- [DOM-02 Organization](#dom-02-organization)
- [DOM-03 Admission](#dom-03-admission)
- [DOM-04 Rawat Jalan](#dom-04-rawat-jalan)
- [DOM-05 Rawat Inap](#dom-05-rawat-inap)
- [DOM-06 Emergency](#dom-06-emergency)
- [DOM-07 Laboratory](#dom-07-laboratory)
- [DOM-08 Radiology](#dom-08-radiology)
- [DOM-09 Operating Theatre](#dom-09-operating-theatre)
- [DOM-10 Pharmacy](#dom-10-pharmacy)
- [DOM-11 Inventory](#dom-11-inventory)
- [DOM-12 Procurement](#dom-12-procurement)
- [DOM-13 Tata Rekening](#dom-13-tata-rekening)
- [DOM-14 Manajemen RM](#dom-14-manajemen-rm)
- [DOM-15 CPOE](#dom-15-cpoe)
- [DOM-16 BPJS Integration](#dom-16-bpjs-integration)

---

## DOM-01 Patient

### Purpose
Manage patient identity and demographic information used across all hospital services.

### Capabilities
- **CAP-01-01 Data Sosial Pasien**: Manage patient demographic, administrative, contact, and social information.

---

## DOM-02 Organization

### Purpose
Manage hospital organizational resources used to deliver healthcare services.

### Capabilities
- **CAP-02-01 Layanan**: Manage hospital services and service definitions.
- **CAP-02-02 Dokter**: Manage healthcare providers and practitioner information.
- **CAP-02-03 Bed**: Manage bed master data and bed classification.
- **CAP-02-04 Jadwal Praktek**: Manage doctor practice schedules and availability.

---

## DOM-03 Admission

### Purpose
Manage patient entry into hospital services.

### Capabilities
- **CAP-03-01 Registrasi**: Manage patient registration activities.
- **CAP-03-02 Booking**: Manage service reservations and appointments.
- **CAP-03-03 Antrian**: Manage patient queueing processes.
- **CAP-03-04 Tracker**: Manage patient journey and service tracking throughout the admission process.

---

## DOM-04 Rawat Jalan

### Purpose
Manage outpatient service operations.

### Capabilities
- **CAP-04-01 Tindakan**: Manage outpatient procedures and service execution.
- **CAP-04-02 Rujukan Internal**: Manage referrals between hospital units and providers.
- **CAP-04-03 Kontrol**: Manage follow-up visits and scheduled return consultations.

---

## DOM-05 Rawat Inap

### Purpose
Manage inpatient stay operations.

### Capabilities
- **CAP-05-01 Penempatan Bed**: Manage patient bed assignment and occupancy.
- **CAP-05-02 Transfer**: Manage patient movement between rooms, wards, and classes.
- **CAP-05-03 Discharge**: Manage inpatient discharge processes.
- **CAP-05-04 Intensive Care**: Manage intensive care unit placement and operational workflows.

---

## DOM-06 Emergency

### Purpose
Manage emergency care operations.

### Capabilities
- **CAP-06-01 IGD Visit**: Manage emergency visit lifecycle and patient flow.
- **CAP-06-02 Triage**: Manage emergency patient prioritization and acuity classification.
- **CAP-06-03 Observasi**: Manage observation care prior to disposition.
- **CAP-06-04 Ambulance**: Manage ambulance requests and ambulance service operations.

---

## DOM-07 Laboratory

### Purpose
Manage laboratory examination services.

### Capabilities
- **CAP-07-02 Sample Collection**: Manage specimen collection and specimen tracking.
- **CAP-07-03 Result Management**: Manage laboratory result recording, verification, and release.

---

## DOM-08 Radiology

### Purpose
Manage radiology examination services.

### Capabilities
- **CAP-08-02 Examination**: Manage radiology examination execution and imaging workflow.
- **CAP-08-03 Expertise**: Manage radiologist interpretation, reporting, and result authorization.

---

## DOM-09 Operating Theatre

### Purpose
Manage surgical service operations.

### Capabilities
- **CAP-09-02 Scheduling**: Manage operating theatre scheduling and resource allocation.
- **CAP-09-03 Operative Procedure**: Manage surgical procedure execution.
- **CAP-09-04 Recovery**: Manage post-operative recovery room activities.

---

## DOM-10 Pharmacy

### Purpose
Manage medication services and pharmacy operations.

### Capabilities
- **CAP-10-02 Sales**: Manage direct medication sales transactions.
- **CAP-10-03 Dispensing**: Manage medication preparation and dispensing processes.
- **CAP-10-04 Retur Jual**: Manage medication sales returns.
- **CAP-10-05 Serah Obat**: Manage medication handover to patients.

---

## DOM-11 Inventory

### Purpose
Manage inventory assets and stock control.

### Capabilities
- **CAP-11-01 Persediaan**: Manage inventory balances and stock availability.
- **CAP-11-02 Mutasi**: Manage inventory movement between locations.
- **CAP-11-03 Opname**: Manage stock verification and stock reconciliation activities.
- **CAP-11-04 Pemusnahan**: Manage inventory destruction and disposal processes.
- **CAP-11-05 Stock-Ledger**: Manage inventory stock ledger and movement history.
- **CAP-11-06 Barang**: Manage item/goods master data, specifications, and classifications.

---

## DOM-12 Procurement

### Purpose
Manage procurement and purchasing activities.

### Capabilities
- **CAP-12-01 Purchasing**: Manage purchasing requests and purchase orders.
- **CAP-12-02 Terima Barang**: Manage goods receipt processes.
- **CAP-12-03 Faktur Tagihan**: Manage supplier invoices and purchase billing documents.
- **CAP-12-04 Retur Beli**: Manage supplier return transactions.
- **CAP-12-05 Supplier**: Manage supplier master data, profiles, and vendor information.

---

## DOM-13 Tata Rekening

### Purpose
Manage financial settlement of patient services.

### Capabilities
- **CAP-13-01 Tarif**: Manage service tariffs and pricing structures.
- **CAP-13-02 Jaminan**: Manage payer, guarantor, and insurance eligibility information.
- **CAP-13-03 Billing**: Manage charge accumulation and billing processes.
- **CAP-13-04 Payment**: Manage payment transactions and financial settlement.

---

## DOM-14 Manajemen RM

### Purpose
Manage medical record administration and statutory hospital reporting.

### Capabilities
- **CAP-14-01 Casemix**: Manage coding, grouping, and reimbursement classification activities.
- **CAP-14-02 Pelaporan RS**: Manage mandatory hospital reporting, statistics, and healthcare reporting obligations.
- **CAP-14-03 ICD-X**: Manage ICD coding and diagnosis classification.

---

## DOM-15 CPOE

### Purpose
Manage computerized physician order entry.

### Capabilities
- **CAP-15-01 Prescription**: Manage medication prescribing activities.
- **CAP-15-02 Order Lab**: Manage laboratory examination requests.
- **CAP-15-03 Order Radiologi**: Manage radiology examination requests.
- **CAP-15-04 Order Operasi**: Manage surgical procedure requests.

---

## DOM-16 BPJS Integration

### Purpose
Manage integration services between MyHospital and BPJS Kesehatan.

### Capabilities
- **CAP-16-01 VClaim**: Manage BPJS claim submission and verification through VClaim services.
- **CAP-16-02 EKlaim**: Manage electronic claim submission and validation.
- **CAP-16-03 Antrol (Antrian Online)**: Manage BPJS online queue registration and service.
- **CAP-16-04 HFIS**: Manage hospital facility information reporting to BPJS.

---

## Notes

This catalog represents Domain Version 1.1 and serves as the baseline for Phase-0 Migration Planning.

### Stable ID Convention

- **Domain ID** (`DOM-xx`): `xx` is the domain sequence number, assigned by the order in this catalog (`DOM-01` … `DOM-16`).
- **Capability ID** (`CAP-xx-yy`): `xx` is the owning Domain number; `yy` is the capability sequence within that Domain.

Identifiers are stable and permanent. Renames preserve the ID; removals retire the ID and never reuse it. Downstream planning artifacts must reference these IDs without redefining them.

Subsequent artifacts will further decompose:
**Domain → Capability → Feature → Screen/Workspace**

Used for complexity estimation, roadmap creation, and implementation planning.

## Traceability Matrix

| This Artifact | Source Artifact | Relationship | Downstream Artifact |
| ------------- | --------------- | ------------ | ------------------- |
| Domain Catalog | — | Defines the business domains and capabilities that bound all Phase-0 planning | Screen-Feature Catalog |
| Domain Catalog | — | Defines the Domains and Capabilities referenced by the Feature–Capability Mapping | Feature–Capability Mapping |