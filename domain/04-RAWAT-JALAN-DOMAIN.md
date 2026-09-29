---

DocumentName: Rawat Jalan Domain
Version: 1.0
LastUpdate: 2026-09-30
UpdatedBy: Drury Yudis
----------------------

# RAWAT JALAN DOMAIN

Domain Code: **RJL**

## Purpose

The **Rawat Jalan** Domain manages the delivery of outpatient clinical services after a patient has been registered for an outpatient visit.

The domain is responsible for the patient's outpatient clinical encounter, clinical actions performed during the encounter, outpatient queue management, internal referral, and optional initial examination before the patient reaches the target clinic.

## Definition

**Rawat Jalan** is the domain that manages the **clinical service delivery of an outpatient visit**.

It begins after outpatient registration and covers the clinical activities performed in outpatient service units until the outpatient clinical encounter is completed or transferred to another service.

## Capabilities

### 1. Konsultasi

The capability to conduct and record the **clinical consultation** between the patient and the healthcare provider during an outpatient encounter.

It includes the clinical assessment and decision-making performed as part of the consultation.

### 2. Tindakan Klinis

The capability to record and manage the **chargeable clinical procedures and interventions** performed during an outpatient encounter.

The purpose of this capability is to ensure that clinical services delivered to the patient are properly represented as billable service items for operational and financial processing.

This capability focuses on the administrative representation of clinical procedures rather than the clinical documentation itself.

Examples:

* Consultation charge
* Procedure charge
* Nursing intervention charge
* Minor surgery charge
* Other billable outpatient clinical services

Clinical documentation, clinical findings, observations, assessments, diagnoses, and medical records are outside the scope of this capability and belong to the EMR domain.


### 3. Antrian Poli

The capability to manage the **outpatient clinic queue**.

It organizes patients waiting for service at a specific outpatient clinic and supports the progression of patients through the clinic service queue.

### 4. Rujukan Internal

The capability to transfer a patient from one outpatient service to another service within the hospital as part of the same episode of care.

Examples:

```text
Poli Mata
   ↓
Laboratorium
```

```text
Poli Penyakit Dalam
   ↓
Poli Gizi
```

The destination service remains within the hospital's internal service structure.

### 5. Pemeriksaan Awal

The capability to automatically place patients into a queue for an **initial examination or screening service** before they are served by their target outpatient clinic.

This capability is primarily intended for hospitals where all patients must undergo a common preliminary examination before entering their respective target clinics.

Example:

```text
Patient Registered
       ↓
Initial Examination Queue
       ↓
Initial Examination / Screening
       ↓
Target Outpatient Clinic
```

For example, in a specialized eye hospital, patients may first undergo an initial eye screening before being served by their respective ophthalmology clinic.

The capability determines the patients who require initial examination and automatically places them in the appropriate initial examination queue.

## Domain Boundary

### Owns

* Outpatient clinical consultation.
* Outpatient clinical procedures and interventions.
* Outpatient clinic queues.
* Internal referral between outpatient services.
* Initial examination and screening workflow before outpatient clinic service.

### Does Not Own

* Patient identity and demographic information → **Pasien Domain**
* Booking and appointment → **Admission Domain**
* Hospital registration and visit creation → **Admission Domain**
* Service units, doctors, PPA, and practice schedules → **Organisasi Domain**
* Inpatient care → **Rawat Inap Domain**
* Emergency care → **Gawat Darurat Domain**
* Laboratory services → **Laboratory Domain**
* Radiology services → **Radiology Domain**
* Pharmacy services → **Apotek Domain**
* Billing and payment → **Tata Rekening Domain**

## Relationships

| Domain                          | Relationship                                                                                                           |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Pasien                          | Rawat Jalan uses the authoritative patient identity for outpatient clinical care.                                      |
| Organisasi                      | Rawat Jalan uses service units, PPA, and outpatient practice schedules to deliver and organize outpatient services.    |
| Admission                       | Admission provides the registered outpatient visit that becomes the context for outpatient clinical care.              |
| Rawat Inap                      | A patient may be transferred from outpatient care to inpatient care when clinically required.                          |
| Gawat Darurat                   | A patient may be directed to emergency care when the required service falls outside outpatient care.                   |
| Laboratory / Radiology / Apotek | Rawat Jalan may initiate or direct patient care toward these service domains as part of the patient's outpatient care. |

## Capability Map

| Capability       | Business Ability                                                                                               |
| ---------------- | -------------------------------------------------------------------------------------------------------------- |
| Konsultasi       | Conduct and record outpatient clinical consultation                                                            |
| Tindakan Klinis  | Perform and record outpatient clinical procedures and interventions                                            |
| Antrian Poli     | Manage the patient queue for outpatient clinics                                                                |
| Rujukan Internal | Transfer patients between internal outpatient services                                                         |
| Pemeriksaan Awal | Automatically queue patients for required initial examination or screening before the target outpatient clinic |
