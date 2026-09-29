# LABORATORY DOMAIN

Domain Code: **LAB**

## Purpose

The **Laboratory** Domain manages the operational delivery of laboratory services for patients.

It is responsible for laboratory orders, direct external registration, specimen collection, and laboratory result management.

Clinical interpretation and broader medical record management remain outside this Domain.

## Definition

**Laboratory** is the domain responsible for managing the operational lifecycle of a laboratory examination, from receiving or creating the laboratory order, through specimen collection, to the availability and management of laboratory results.

The Domain also supports direct laboratory registration for cases where a patient comes to the laboratory without going through the normal hospital registration process.

## Responsibilities

The Laboratory Domain is responsible for:

* Managing laboratory orders.
* Registering patients directly for laboratory services when required.
* Managing specimen collection.
* Managing laboratory examination results.
* Maintaining the operational relationship between the patient, laboratory order, specimen, and result.

## Capabilities

### 1. LAB-ORDER — Order Lab

The capability to manage requests for laboratory examinations.

An order represents a request for one or more laboratory examinations for a patient.

The order may originate from another service domain or from a laboratory registration process.

This capability manages:

* Laboratory examination requests.
* Requested laboratory tests.
* Patient and visit context when applicable.
* Order status and lifecycle.

The clinical decision to request a laboratory examination belongs to the originating clinical service.

---

### 2. LAB-EXTERNAL — Registrasi External

The capability to register a patient directly for laboratory services without requiring a normal hospital admission or visit registration process.

This is intended for patients who come directly to the laboratory, for example for a standalone laboratory examination.

The registration:

* Creates the operational laboratory registration required to perform the examination.
* Creates a medical record number for the registration when required by the system.
* Does **not** establish a maintained patient master identity.
* The generated medical record number is **one-time use only** for this external laboratory registration.
* The generated medical record identity is not maintained as a permanent patient identity by the Laboratory Domain.

If the patient later requires a normal hospital visit, the normal **Pasien** and **Admission** processes apply.

---

### 3. LAB-COLLECT — Specimen Collection

The capability to collect and manage specimens required for laboratory examinations.

It covers the operational handling of specimens from an ordered laboratory examination.

This includes:

* Identifying the required specimen.
* Recording specimen collection.
* Associating the specimen with the laboratory order.
* Maintaining specimen status during laboratory processing.

The clinical result itself is outside this capability and belongs to **LAB-RESULT**.

---

### 4. LAB-RESULT — Lab Result Management

The capability to manage laboratory examination results.

It covers the recording, validation, and availability of laboratory results associated with a laboratory order and specimen.

This includes:

* Recording laboratory test results.
* Managing result status.
* Validating or confirming results according to laboratory workflow.
* Making completed results available to the appropriate consuming service.

The capability manages the laboratory result as a laboratory service output. Clinical interpretation of the result belongs to the responsible clinical service.

## Domain Boundary

### Owns

* Laboratory orders.
* Direct external laboratory registration.
* Laboratory specimens and collection.
* Laboratory examination results.
* The operational relationship between orders, specimens, and results.

### Does Not Own

* Patient identity and permanent patient master data → **Pasien Domain**
* Hospital registration and normal visit creation → **Admission Domain**
* Clinical consultation and clinical decision-making → relevant clinical Domain
* Clinical medical record → **EMR / relevant clinical Domain**
* Laboratory tariff and billing → **Tata Rekening Domain**
* Hospital service/unit master data → **Organisasi Domain**

## Relationships

| Related Domain         | Relationship                                                                                                     |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Pasien                 | Laboratory uses the authoritative patient identity when the patient is registered in the normal hospital system. |
| Admission              | Laboratory may receive an examination request in the context of a registered hospital visit.                     |
| Rawat Jalan            | Outpatient care may initiate a laboratory order for the patient.                                                 |
| Rawat Inap             | Inpatient care may initiate a laboratory order for the patient.                                                  |
| Gawat Darurat          | Emergency care may initiate a laboratory order for the patient.                                                  |
| Organisasi             | Laboratory uses service and organizational information defined by Organisasi.                                    |
| Tata Rekening          | Laboratory services may generate billable charges using financial definitions maintained by Tata Rekening.       |
| EMR / Clinical Domains | Laboratory results may become part of the patient's clinical record and support clinical decision-making.        |

## Core Rules

1. Every laboratory examination must be associated with a laboratory order or an approved direct laboratory registration.
2. A specimen must belong to a laboratory order.
3. A laboratory result must belong to the corresponding laboratory examination.
4. External registration is intended for direct laboratory service and does not create a maintained permanent patient identity.
5. A medical record number created for external laboratory registration is one-time use only.
6. Permanent patient identity remains owned by the **Pasien Domain**.
