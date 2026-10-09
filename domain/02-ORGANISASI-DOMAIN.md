---
DocumentName: Organisasi Domain
Version: 1.1
LastUpdate: 2026-10-10
UpdatedBy: Drury Yudis
---

# ORGANISASI DOMAIN

Domain Code: **ORG**

## 1. Purpose

The ORGANISASI domain defines the hospital's operational organization required to deliver
and govern clinical services.

It establishes the hospital's service units, care locations, clinical care providers,
and service schedules.

---

## 2. Definition

ORGANISASI is the domain responsible for defining **where healthcare services are
provided, who provides them, and when they are provided**.

---

## 3. Responsibilities

ORGANISASI is responsible for:

- Defining hospital service units.
- Defining physical care locations and beds.
- Defining healthcare providers involved in clinical care.
- Defining outpatient doctor practice schedules.
- Maintaining mapping between hospital service structures and required governance standards.

---

## 4. Capabilities

### 4.1 ORG-LYN — Layanan

Defines the hospital's service units.

A Layanan represents a functional healthcare service provided by the hospital.

Examples:

- Rawat Jalan
- Rawat Inap
- IGD
- Laboratorium
- Radiologi
- Farmasi

A Layanan may have one or more operational locations and may be associated with
governance classifications.

---

### 4.2 ORG-INST — Instalasi

Defines operational installations within the hospital.

An Instalasi represents an organizational/operational unit that supports the delivery
of hospital services.

An Instalasi may contain or organize multiple Layanan.

---

### 4.3 ORG-GOV-MAP — Governance Mapping

Maintains the relationship between the hospital's internal organization and
external healthcare governance standards.

This includes:

- LayananDk — mapping of Layanan to governance/reporting standards.
- LayananTipeDk — standard governance type for Layanan.
- InstalasiDk — standard governance classification for Instalasi.

The mapping exists to support standardized reporting and governance requirements.

---

### 4.4 ORG-PPA — PPA

Defines healthcare personnel who participate in clinical interventions.

PPA (Petugas Pemberi Asuhan) includes, but is not limited to:

- Dokter
- Perawat
- Apoteker
- Dietisien
- Other clinical personnel involved in patient care.

PPA identifies the personnel who may participate in or be responsible for clinical
interventions and actions.

---

### 4.5 ORG-JADW-PRTK — Jadwal Praktik

Defines outpatient doctor practice schedules.

A schedule associates a doctor with the service/location and the time period in which
the doctor provides outpatient practice.

---

### 4.6 ORG-BANGSAL — Bangsal

Defines the hospital's inpatient care location and bed structure.

Hierarchy:

Bangsal
→ Kamar
→ Bed

Bangsal is an operational service unit equivalent to a Layanan from the organizational
perspective.

Kamar groups beds within a Bangsal.

Bed represents the individual inpatient accommodation/resource.

---

## 5. Domain Boundary

### Owns

- Layanan
- Instalasi
- Governance mapping for Layanan and Instalasi
- PPA
- Doctor outpatient practice schedules
- Bangsal
- Kamar
- Bed

### Does Not Own

- Patient identity and demographics → PASIEN
- Clinical encounters → relevant clinical domain
- Clinical interventions/actions → relevant clinical domain
- Billing and financial transactions → relevant financial domain
- Clinical documentation/results → relevant clinical domain

---

## 6. Relationships

ORGANISASI provides organizational context used by other domains.

Examples:

- PASIEN references organizational context when a patient receives care.
- Clinical domains reference Layanan, Instalasi, PPA, and/or Bed when recording care.
- Reporting depends on governance mappings maintained by ORGANISASI.