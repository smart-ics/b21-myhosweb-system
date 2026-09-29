---
DocumentName: Pasien Domain
Version: 1.0
LastUpdate: 2026-09-30
UpdatedBy: Drury Yudis
---

# PASIEN DOMAIN

Domain Code: **PAS**

## 1. Purpose

The **Pasien** Domain owns the identity and social information of a patient used throughout the hospital system.

Its responsibility is to ensure that a patient can be consistently identified and that the patient's social information is maintained as shared master information.

## 2. Definition

A **Patient** is a person who is registered in the hospital system and identified by a unique medical record identity.

The Pasien Domain is responsible for:

* patient identity;
* patient social information;
* maintaining a single patient identity when duplicate medical record identities exist.

## 3. Responsibilities

The Pasien Domain owns the following responsibilities:

* Maintain patient social data.
* Maintain patient identity across the hospital system.
* Maintain the relationship between a patient and their medical record number(s).
* Resolve duplicate patient identities.

## 4. Capabilities

### 4.1 PAS-DATSOS — Data Sosial Pasien

**Definition**

The capability to maintain the patient's social and demographic information required by the hospital.

**Scope**

#### Wilayah

* Provinsi
* Kabupaten/Kota
* Kecamatan
* Kelurahan

#### Status Sosial

* Status Kawin
* Pekerjaan
* Pendidikan
* Agama
* Suku

This capability provides the shared patient social information used by other Domains.

### 4.2 PAS-MERGE — Merge Duplicated Pasien

**Definition**

The capability to consolidate multiple patient identities that represent the same real-world person into a single patient identity.

**Scope**

* Identify duplicate patient identities.
* Select the patient identity that will remain as the primary identity.
* Merge duplicate patient identities.
* Preserve the relevant medical record history associated with the duplicated identities.
* Prevent the creation of inconsistent patient identity after merge.

The result is one authoritative patient identity for the same real-world person.

## 5. Domain Boundary

### Owns

* Patient identity.
* Patient social information.
* Patient medical record identity association.
* Patient duplicate resolution.

### Does Not Own

* Patient registration and visit creation → **Admission**
* Clinical care and clinical records → corresponding clinical Domains
* Billing and payment → **Tata Rekening**
* Medical record filing, coding, and reporting → **Berkas Rekam Medis**
* Insurance membership and claim processing → **BPJS**

## 6. Relationships

The Pasien Domain is a foundational Domain used by other hospital Domains.

Examples:

```text
Pasien
  ↓
Admission
  ↓
Rawat Jalan / Rawat Inap / IGD
```

```text
Pasien
  ↓
Berkas Rekam Medis
```

```text
Pasien
  ↓
Tata Rekening
```

Other Domains may use the patient identity and social information, but they do not own it.

## 7. Domain Rules

1. One real-world person should have one authoritative patient identity.
2. Patient social information is shared master information.
3. Patient identity must remain consistent across all Domains.
4. Duplicate patient identities must be resolved through **PAS-MERGE**, not by creating another patient record.
5. A merge must preserve the patient's relevant historical information.
