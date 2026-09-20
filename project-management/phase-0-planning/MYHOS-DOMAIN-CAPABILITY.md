# MyHospital Domain Catalog V1.1

## Purpose

This document defines the business domains of the MyHospital Platform and the major business capabilities owned by each domain.

The purpose of this catalog is to establish a common business decomposition model for:

* Screen planning
* Feature discovery
* Complexity assessment
* Development roadmap planning
* Migration planning from legacy desktop applications to MyHospital Web

This catalog is not intended to define technical architecture, database structure, aggregates, APIs, or user interface design.

---

# 01. Patient

## Purpose

Manage patient identity and demographic information used across all hospital services.

## Capabilities

### Data Sosial Pasien

Manage patient demographic, administrative, contact, and social information.

---

# 02. Organization

## Purpose

Manage hospital organizational resources used to deliver healthcare services.

## Capabilities

### Layanan

Manage hospital services and service definitions.

### Dokter

Manage healthcare providers and practitioner information.

### Bed

Manage bed master data and bed classification.

---

# 03. Admission

## Purpose

Manage patient entry into hospital services.

## Capabilities

### Registrasi

Manage patient registration activities.

### Booking

Manage service reservations and appointments.

### Antrian

Manage patient queueing processes.

### Tracker

Manage patient journey and service tracking throughout the admission process.

---

# 04. Rawat Jalan

## Purpose

Manage outpatient service operations.

## Capabilities

### Tindakan

Manage outpatient procedures and service execution.

### Rujukan Internal

Manage referrals between hospital units and providers.

### Kontrol

Manage follow-up visits and scheduled return consultations.

---

# 05. Rawat Inap

## Purpose

Manage inpatient stay operations.

## Capabilities

### Penempatan Bed

Manage patient bed assignment and occupancy.

### Transfer

Manage patient movement between rooms, wards, and classes.

### Discharge

Manage inpatient discharge processes.

### Intensive Care

Manage intensive care unit placement and operational workflows.

---

# 06. Emergency

## Purpose

Manage emergency care operations.

## Capabilities

### IGD Visit

Manage emergency visit lifecycle and patient flow.

### Triage

Manage emergency patient prioritization and acuity classification.

### Observasi

Manage observation care prior to disposition.

### Ambulance

Manage ambulance requests and ambulance service operations.

---

# 07. Laboratory

## Purpose

Manage laboratory examination services.

## Capabilities

### Order Lab

Manage laboratory examination requests.

### Sample Collection

Manage specimen collection and specimen tracking.

### Result Management

Manage laboratory result recording, verification, and release.

---

# 08. Radiology

## Purpose

Manage radiology examination services.

## Capabilities

### Order Radiologi

Manage radiology examination requests.

### Examination

Manage radiology examination execution and imaging workflow.

### Expertise

Manage radiologist interpretation, reporting, and result authorization.

---

# 09. Operating Theatre

## Purpose

Manage surgical service operations.

## Capabilities

### Order Operasi

Manage surgical procedure requests.

### Scheduling

Manage operating theatre scheduling and resource allocation.

### Operative Procedure

Manage surgical procedure execution.

### Recovery

Manage post-operative recovery room activities.

---

# 10. Pharmacy

## Purpose

Manage medication services and pharmacy operations.

## Capabilities

### Prescription

Manage medication prescribing activities.

### Sales

Manage direct medication sales transactions.

### Dispensing

Manage medication preparation and dispensing processes.

### Retur Jual

Manage medication sales returns.

---

# 11. Inventory

## Purpose

Manage inventory assets and stock control.

## Capabilities

### Persediaan

Manage inventory balances and stock availability.

### Mutasi

Manage inventory movement between locations.

### Opname

Manage stock verification and stock reconciliation activities.

### Pemusnahan

Manage inventory destruction and disposal processes.

---

# 12. Procurement

## Purpose

Manage procurement and purchasing activities.

## Capabilities

### Purchasing

Manage purchasing requests and purchase orders.

### Terima Barang

Manage goods receipt processes.

### Faktur Tagihan

Manage supplier invoices and purchase billing documents.

### Retur Beli

Manage supplier return transactions.

---

# 13. Tata Rekening

## Purpose

Manage financial settlement of patient services.

## Capabilities

### Tarif

Manage service tariffs and pricing structures.

### Jaminan

Manage payer, guarantor, and insurance eligibility information.

### Billing

Manage charge accumulation and billing processes.

### Payment

Manage payment transactions and financial settlement.

---

# 14. Manajemen RM

## Purpose

Manage medical record administration and statutory hospital reporting.

## Capabilities

### Casemix

Manage coding, grouping, and reimbursement classification activities.

### Pelaporan RS

Manage mandatory hospital reporting, statistics, and healthcare reporting obligations.

---

# Notes

This catalog represents Domain Version 1.1 and serves as the baseline for Phase-0 Migration Planning.

Subsequent artifacts will further decompose:

Domain → Capability → Feature → Screen/Workspace

for complexity estimation, roadmap creation, and implementation planning.
