---
DocumentName: BPJS Domain
Version: 1.0
LastUpdate: 2026-10-09
UpdatedBy: Drury Yudis
---

# BPJS DOMAIN

Domain Code: **BPJ**



## 1. Purpose



The **BPJS** Domain manages the hospital's integration with BPJS healthcare systems for patient visit registration, online queues, claim processing, and facility information.



It connects hospital operational data with the relevant BPJS services without taking ownership of the underlying patient, clinical, admission, or financial records.



## 2. Definition



The **BPJS** Domain is responsible for managing the hospital-side capabilities required to exchange and process information through BPJS systems.



It covers VClaim, e-Klaim, Antrol, and HFIS integrations.



## 3. Responsibilities



The BPJS Domain is responsible for:



- Managing BPJS-related patient visit registration through VClaim.

- Managing the preparation and processing of BPJS healthcare claims through e-Klaim.

- Managing online queue information through Antrol.

- Managing the exchange of hospital facility information required by HFIS.

- Maintaining the association between hospital operational records and corresponding BPJS records or identifiers where required.



## 4. Capabilities



### 4.1 BPJ-VCLAIM — VClaim



The capability to manage BPJS-related patient visit registration through VClaim.



It supports the administrative registration required for a patient visit covered by BPJS.



The hospital's patient identity and visit registration remain owned by the \*\*Pasien\*\* and \*\*Admission\*\* Domains. VClaim manages the corresponding interaction with the BPJS system.



### 4.2 BPJ-EKLAIM — e-Klaim



The capability to manage the preparation and processing of healthcare claims submitted to BPJS.



It handles claim-related information derived from the patient's care and financial records for submission and processing through e-Klaim.



The underlying clinical records remain owned by the relevant clinical Domains. Billing and tariff records remain owned by \*\*Tata Rekening\*\*. The BPJS Domain manages the BPJS claim workflow and its integration.



### 4.3 BPJ-ANTROL — Antrol



The capability to manage online queue information exchanged with the BPJS Antrol system.



It supports the publication or synchronization of relevant patient queue information between the hospital and Antrol.



The hospital's registration and local service queue remain owned by the relevant operational Domains. Antrol handles the BPJS-facing online queue integration.



### 4.4 BPJ-HFIS — HFIS



The capability to manage the exchange of hospital facility information required by the BPJS HFIS system.



This capability covers the BPJS-facing integration for relevant facility and service information. The exact information maintained or synchronized depends on the hospital's HFIS integration requirements.



The hospital's authoritative organizational structure remains owned by the \*\*Organisasi\*\* Domain.



## 5. Domain Boundary



### Owns



- BPJS system integration for VClaim, e-Klaim, Antrol, and HFIS.

- BPJS-facing registration records and identifiers required by these integrations.

- BPJS claim processing workflow and claim exchange records.

- BPJS-facing online queue information.

- BPJS-facing facility information exchange.



### Does Not Own



- Patient identity and demographic information → \*\*Pasien\*\*

- Hospital visit registration → \*\*Admission\*\*

- Hospital service units, providers, schedules, and facility structure → \*\*Organisasi\*\*

- Clinical care and clinical documentation → corresponding clinical Domains

- Tariffs, patient billing, and payment transactions → \*\*Tata Rekening\*\*

- The hospital's local service queue → corresponding operational Domain



The BPJS Domain manages the **BPJS-facing integration and processing**. It does not replace the hospital Domain that owns the underlying business record.



## 6. Relationships



| Related Domain | Relationship |
|---|---|
| Pasien | Provides the authoritative patient identity used in BPJS-related processes. |
| Organisasi | Provides hospital service, provider, schedule, and facility information relevant to BPJS integration. |
| Admission | Provides the hospital visit registration associated with VClaim and online queue processes. |
| Clinical Domains | Provide clinical information required for BPJS claim processing. |
| Tata Rekening | Provides tariff and billing information relevant to claim preparation and processing. |


## 7. Capability Map



| Capability | Business Ability |
|---|---|
| BPJ-VCLAIM | Manage BPJS-related patient visit registration through VClaim. |
| BPJ-EKLAIM | Manage BPJS healthcare claim preparation and processing through e-Klaim. |
| BPJ-ANTROL | Exchange online queue information with Antrol. |
| BPJ-HFIS | Exchange hospital facility information with HFIS. |



## 8. Domain Rules



1. BPJS integration records must refer to the authoritative hospital records owned by the relevant Domains.

2. VClaim integration does not replace the hospital's patient identity or visit registration.

3. e-Klaim manages the BPJS claim process; it does not own the underlying clinical records or hospital billing records.

4. Antrol integration does not replace the hospital's local queue management.

5. HFIS integration does not replace the authoritative organizational and facility structure maintained by Organisasi.
