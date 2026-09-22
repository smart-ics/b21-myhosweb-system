# MYHOSWEB Feature Complexity Assessment

## 1. Purpose

This artifact provides an initial, business-oriented complexity assessment for every feature in the MYHOSWEB Screen-Feature Catalog. It is intended to support Phase-0 roadmap planning, development timeframe estimation, feature prioritization, resource allocation, and Board of Directors planning discussion.

The assessment is relative and directional. It uses only the scope defined in `MYHOSWEB-SCREEN-FEATURE-CATALOG.md`; it is not a technical design, implementation plan, or delivery commitment. Shared or canonical features are counted once for product implementation estimation, while remaining visible in each Screen's operational scope.

## 2. Complexity Scale

| Level | Meaning | Guideline |
| ----- | ------- | --------- |
| **1** | Very Low | Simple CRUD/maintenance, few rules, minimal dependencies, predictable workflow |
| **2** | Low | Small workflow, limited business rules, few dependencies, low operational risk |
| **3** | Medium | Several workflow steps, moderate business rules, some cross-feature/domain dependencies |
| **4** | High | Complex workflow/lifecycle, many business rules, significant dependencies, integration or operational risk |
| **5** | Very High | Exceptional system complexity across multiple dimensions; major integration, financial, regulatory, or operational consequences |

The assessment dimensions are:

1. **System Workflow**: breadth, number of steps, approvals, transitions, and operational stages managed by MYHOSWEB.
2. **System Business Rules**: validations, exceptions, calculations, approvals, and controls enforced by MYHOSWEB.
3. **Dependencies**: internal domains/features, legacy components, and external systems that MYHOSWEB must interact with.
4. **Data & Lifecycle**: data relationships, history, states, continuity, and migration sensitivity managed by MYHOSWEB.
5. **Operational / Financial / Regulatory Risk**: consequences of an incorrect system transaction, calculation, status, or report.

These dimensions guide the assessment and are not a mathematical formula. Professional knowledge is not treated as system business rules when the user supplies the decision or result. The levels describe relative business-planning complexity, not coding effort. Level 5 is reserved for exceptional system complexity across multiple dimensions.

Complexity is reported in two forms:

- **Business Complexity**: the business-planning complexity of the feature itself, using the Level 1–5 scale above.
- **Technical Complexity**: the sum of the Capability Complexity levels of the capabilities the feature maps to, per the Capability Complexity table in `MYHOSWEB-DOMAIN-CATALOG.md`. It reflects the breadth of capability surface the feature must integrate and is not capped at 5.
- **Complexity Value**: the weighted total computed as `(Business Complexity × 1.5) + (Technical Complexity × 0.75)`.
- **Screen Complexity Level**: a 1–5 classification per Screen based only on Total Complexity Value, mapped by fixed bands:

| Total Complexity Value | Level |
| ---------------------- | ----- |
| < 50 | 1 |
| 50–64 | 2 |
| 65–79 | 3 |
| 80–94 | 4 |
| ≥ 95 | 5 |

## 3. Feature Assessment

### SC-01 Admisi

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-01-01 | Booking | 3 | 16 | 16.5 | Reservation workflow with schedule availability, patient details, and booking status controls. |
| FT-01-02 | Registrasi Rawat Jalan dan IGD | 4 | 18 | 19.5 | Multi-path registration workflow with identity, coverage, status, and service routing controls. |
| FT-01-03 | Registrasi Rawat Inap | 4 | 16 | 18 | Admission workflow with patient, coverage, bed, and administrative status dependencies. |
| FT-01-04 | VCLAIM BPJS | 5 | 5 | 11.25 | External BPJS integration with eligibility validation, response handling, and regulatory consequences. |
| FT-01-05 | Patient Journey Tracking | 4 | 4 | 9 | Cross-department status tracking across multiple patient workflow states. |
| FT-01-06 | Jadwal Praktek | 3 | 4 | 7.5 | Schedule maintenance with provider, service, availability, and change controls. |
| FT-01-07 | Antrian | 3 | 3 | 6.75 | Queue state management and routing across registration and service delivery. |

### SC-02 Tata Rekening

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-02-01 | Rincian Tagihan Pasien | 4 | 14 | 16.5 | Consolidates service charges with financial calculations, status, and cross-feature dependencies. |
| FT-02-02 | Alokasi Pembayaran | 4 | 16 | 18 | Applies payment allocation rules across multiple bill items with financial accuracy controls. |
| FT-02-03 | Deposit | 3 | 8 | 10.5 | Manages a controlled financial balance lifecycle and related account status. |
| FT-02-04 | Refund | 4 | 8 | 12 | Applies refund eligibility, approval, reversal, and audit controls. |
| FT-02-05 | Reg-Out | 4 | 8 | 12 | Coordinates administrative closure with complete service and payment status. |

### SC-03 Kasir

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-03-01 | Order Bayar | 3 | 12 | 13.5 | Prepares payment transactions from outstanding patient charges with status controls. |
| FT-03-02 | Pembayaran | 4 | 16 | 18 | Manages financial transactions, exceptions, receipts, and reconciliation data. |
| FT-03-03 | Closing Shift | 4 | 4 | 9 | Controls shift closure, cash accountability, reconciliation, and operational status. |

### SC-04 Rekam Medis

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-04-01 | Data Sosial Pasien | 2 | 2 | 4.5 | Maintains patient identity and social data with basic accuracy and update controls. |
| FT-04-02 | Manajemen Berkas | 3 | 6 | 9 | Manages record availability, status, continuity, and retrieval across care activities. |
| FT-04-03 | Casemix dan Coding | 4 | 8 | 12 | Records and manages user-provided coding results with review status, administrative data, and reporting controls. |
| FT-04-04 | Pelaporan RL | 5 | 5 | 11.25 | Produces regulatory reports from broad data dependencies with high correctness and submission risk. |
| FT-04-05 | Pelaporan Index dan Sensus | 4 | 5 | 9.75 | Aggregates recurring institutional data with historical continuity and reporting controls. |

### SC-05 Poli Rawat Jalan

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-05-01 | Antrian | 3 | 9 | 11.25 | Queue progression and service coordination within outpatient care. |
| FT-05-02 | Tindakan | 3 | 18 | 18 | Records service activity and related administrative or charge status across a patient visit. |
| FT-05-03 | Rujuk Internal | 3 | 11 | 12.75 | Routes referrals across services with status, acceptance, and handoff controls. |
| FT-05-04 | CPOE (Order Pemeriksaan) | 4 | 16 | 18 | Manages examination orders, routing, status, and downstream service dependencies. |
| FT-05-05 | Pakai Barang | 3 | 10 | 12 | Shared item-consumption capability with contextual stock accountability in outpatient care. |
| FT-05-06 | Mutasi Barang | 3 | 10 | 12 | Shared stock-movement capability with contextual custody controls in outpatient care. |
| FT-05-07 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual variance handling in outpatient care. |

### SC-06 Bangsal Rawat Inap

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-06-01 | Tindakan | 3 | 18 | 18 | Records inpatient service activity and related administrative or charge status over time. |
| FT-06-02 | Pakai Bed | 4 | 10 | 13.5 | Manages bed allocation, availability, occupancy, and release states. |
| FT-06-03 | Transfer Unit | 4 | 10 | 13.5 | Coordinates unit transfer status, location, responsibility, and continuity data. |
| FT-06-04 | Discharge | 4 | 17 | 18.75 | Manages administrative discharge steps, completion status, and financial or continuity controls. |
| FT-06-05 | Pakai Barang | 3 | 10 | 12 | Shared item-consumption capability with contextual stock accountability in inpatient care. |
| FT-06-06 | Mutasi Barang | 3 | 10 | 12 | Shared stock-movement capability with contextual custody controls in inpatient care. |
| FT-06-07 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual variance handling in inpatient care. |

### SC-07 IGD

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-07-01 | IGD Visit | 3 | 8 | 10.5 | Initiates and tracks an emergency visit with changing administrative status. |
| FT-07-02 | Triage | 3 | 7 | 9.75 | Records and routes the user-provided priority result without performing clinical assessment. |
| FT-07-03 | Ambulance | 3 | 14 | 15 | Coordinates transport request, assignment, availability, and status tracking. |
| FT-07-04 | Tindakan | 3 | 14 | 15 | Records emergency service activity and related administrative or charge status. |
| FT-07-05 | Pakai Barang | 3 | 10 | 12 | Shared item-consumption capability with contextual stock accountability in emergency care. |
| FT-07-06 | Mutasi Barang | 3 | 10 | 12 | Shared stock-movement capability with contextual custody controls in emergency care. |
| FT-07-07 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual variance handling in emergency care. |

### SC-08 Laboratorium

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-08-01 | External Registration | 3 | 6 | 9 | Registers external parties with identity, service, and administrative status controls. |
| FT-08-02 | Order Laboratorium | 3 | 9 | 11.25 | Manages laboratory requests, routing, status, and resulting work references. |
| FT-08-03 | Charge | 3 | 11 | 12.75 | Captures laboratory charges and aligns them with patient financial records. |
| FT-08-04 | Sample Collection | 3 | 8 | 10.5 | Tracks sample identification, collection status, handling, and continuity. |
| FT-08-05 | Result Management | 4 | 7 | 11.25 | Stores, validates administratively, versions, and releases user-provided results. |
| FT-08-06 | Pakai Barang | 3 | 10 | 12 | Shared item-consumption capability with contextual stock accountability in laboratory services. |
| FT-08-07 | Mutasi Barang | 3 | 10 | 12 | Shared stock-movement capability with contextual custody controls in laboratory services. |
| FT-08-08 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual variance handling in laboratory services. |

### SC-09 Radiologi

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-09-01 | Order Radiologi | 3 | 9 | 11.25 | Manages imaging requests with scheduling, charge, and status dependencies. |
| FT-09-02 | Scheduling | 3 | 10 | 12 | Coordinates imaging appointments and resource availability. |
| FT-09-03 | Imaging | 3 | 10 | 12 | Receives imaging data from the PACS machine without owning the imaging operation. |
| FT-09-04 | Expertise | 3 | 8 | 10.5 | Records the analyst's reading for the image; interpretation complexity remains with the analyst, while the system receives the final result. |
| FT-09-05 | Verification | 3 | 8 | 10.5 | Manages administrative review status and release of the user-provided result. |
| FT-09-06 | Pakai Barang | 3 | 10 | 12 | Shared item-consumption capability with contextual stock accountability in radiology services. |
| FT-09-07 | Mutasi Barang | 3 | 10 | 12 | Shared stock-movement capability with contextual custody controls in radiology services. |
| FT-09-08 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual variance handling in radiology services. |

### SC-10 Kamar Operasi

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-10-01 | Order Operasi | 3 | 11 | 12.75 | Manages operating requests with patient, service, readiness, and status dependencies. |
| FT-10-02 | Scheduling | 4 | 9 | 12.75 | Coordinates operating-room appointments, capacity, resources, and schedule states. |
| FT-10-03 | Pre-Operative Clearance | 3 | 9 | 11.25 | Administrative capture of the human analyst's final clearance result, with no ownership of the underlying medical assessment. |
| FT-10-04 | Post-Operative Management | 3 | 12 | 13.5 | Administrative capture of the human analyst's final post-operative result, with no ownership of the underlying medical knowledge. |
| FT-10-05 | Pakai Barang | 3 | 10 | 12 | Shared item-consumption capability with contextual stock accountability in operating room services. |
| FT-10-06 | Mutasi Barang | 3 | 10 | 12 | Shared stock-movement capability with contextual custody controls in operating room services. |
| FT-10-07 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual variance handling in operating room services. |

### SC-11 Apotek

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-11-01 | Antrian Apotek | 3 | 14 | 15 | Queue progression coordinates prescriptions, customers, and dispensing capacity. |
| FT-11-02 | Telaah Resep | 3 | 10 | 12 | Records and manages the user's prescription-review status without performing pharmaceutical assessment. |
| FT-11-03 | Penjualan | 4 | 18 | 19.5 | Manages pharmacy transactions with financial, prescription, and item-availability rules. |
| FT-11-04 | Dispensing | 3 | 12 | 13.5 | Tracks dispensing workflow, item status, quantities, and completion without performing medication judgment. |
| FT-11-05 | Serah Obat | 3 | 22 | 21 | Manages medicine handover status, identity confirmation, and completion records. |
| FT-11-06 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual medicine variance handling. |
| FT-11-07 | Mutasi | 3 | 8 | 10.5 | Shared stock-movement capability with contextual medicine custody controls. |

### SC-12 Gudang

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-12-01 | Terima Barang (DO) | 4 | 13 | 15.75 | Receiving workflow requires quantity, condition, and delivery-document matching controls. |
| FT-12-02 | Mutasi | 3 | 8 | 10.5 | Shared stock-movement capability with contextual warehouse custody controls. |
| FT-12-03 | Opname | 3 | 10 | 12 | Shared stock-counting capability with contextual warehouse variance handling. |
| FT-12-04 | Musnah | 4 | 9 | 12.75 | Destruction workflow requires authorization, traceability, and accountability. |
| FT-12-05 | Retur Beli | 4 | 11 | 14.25 | Purchase return lifecycle requires supplier, item, and financial coordination. |

### SC-13 Purchasing

| Feature ID | Feature | Business Complexity | Technical Complexity | Complexity Value | Initial Rationale |
| ---------- | ------- | ------------------- | -------------------- | ---------------- | ----------------- |
| FT-13-01 | Material Request | 3 | 8 | 10.5 | Captures and routes material demand requests with review status. |
| FT-13-02 | Forecasting | 4 | 9 | 12.75 | Processes historical demand data into forecast records with review and planning controls. |
| FT-13-03 | Purchase Request | 4 | 6 | 10.5 | Manages procurement requests, approvals, budget controls, and status. |
| FT-13-04 | Purchase Order | 4 | 8 | 12 | Manages supplier commitments, order status, fulfillment references, and commercial data. |
| FT-13-05 | Faktur Tagihan | 4 | 8 | 12 | Matches invoice records with purchasing data and maintains financial accountability. |

### Shared / Canonical Features

`Pakai Barang`, `Mutasi Barang`, and `Opname` are common business capabilities reused by multiple operational Screens. Their occurrence in a Screen represents contextual usage, not an independent implementation.

| Canonical Feature | Catalog Usage | Screen Usage Count | Product Implementation Complexity |
| ----------------- | ------------- | ------------------ | ---------------------------------- |
| Pakai Barang | FT-05-05, FT-06-05, FT-07-05, FT-08-06, FT-09-06, FT-10-05 | 6 | 3, estimated once |
| Mutasi Barang | FT-05-06, FT-06-06, FT-07-06, FT-08-07, FT-09-07, FT-10-06, FT-11-07, FT-12-02 | 8 | 3, estimated once |
| Opname | FT-05-07, FT-06-07, FT-07-07, FT-08-08, FT-09-08, FT-10-07, FT-11-06, FT-12-03 | 8 | 3, estimated once |

The catalog labels `Mutasi Barang` as `Mutasi` in SC-11 Apotek and SC-12 Gudang; these occurrences are included in the same canonical business feature. The catalog labels the usage context by Screen, but the planning estimate treats each canonical feature as one product capability.

For planning purposes, **Screen Scope Complexity** includes the operational impact of a shared feature within that Screen. **Product Implementation Complexity** counts each canonical feature once and must not be multiplied by its Screen Usage Count. Context-specific validation and operational adoption may still affect Screen planning, but they do not create separate canonical feature implementations.

## 4. Screen Complexity Summary

Aggregated from the per-feature Complexity Values. The Screen Complexity Level is derived from Total Complexity Value using the fixed bands defined in Section 2.

| Screen | Feature Count | Total Complexity Value | Complexity Level |
| ------ | ------------- | ---------------------- | ---------------- |
| SC-01 Admisi | 7 | 88.5 | 4 |
| SC-02 Tata Rekening | 5 | 69 | 3 |
| SC-03 Kasir | 3 | 40.5 | 1 |
| SC-04 Rekam Medis | 5 | 46.5 | 1 |
| SC-05 Poli Rawat Jalan | 7 | 96 | 5 |
| SC-06 Bangsal Rawat Inap | 7 | 99.75 | 5 |
| SC-07 IGD | 7 | 86.25 | 4 |
| SC-08 Laboratorium | 8 | 90.75 | 4 |
| SC-09 Radiologi | 8 | 92.25 | 4 |
| SC-10 Kamar Operasi | 7 | 86.25 | 4 |
| SC-11 Apotek | 7 | 103.5 | 5 |
| SC-12 Gudang | 5 | 65.25 | 3 |
| SC-13 Purchasing | 5 | 57.75 | 2 |

## 5. Complexity Ranking

Screens are grouped by Complexity Level (1–5), highest first. Within a level, Screens are ordered by Total Complexity Value, then by business-rule density and operational risk.

### Level 5 — Very High

| Screen | Total Complexity Value | Rationale |
| ------ | ---------------------- | --------- |
| SC-11 Apotek | 103.5 | Combines prescription-status workflow, sales, dispensing records, handover, queue, and stock controls. |
| SC-06 Bangsal Rawat Inap | 99.75 | Covers bed, transfer, discharge, service-status, and stock lifecycles. |
| SC-05 Poli Rawat Jalan | 96 | Manages outpatient queues, service records, orders, referrals, and stock usage. |

### Level 4 — High

| Screen | Total Complexity Value | Rationale |
| ------ | ---------------------- | --------- |
| SC-09 Radiologi | 92.25 | Manages orders, schedules, PACS data receipt, final-result recording, verification, and stock usage. |
| SC-08 Laboratorium | 90.75 | Covers registration, ordering, charges, sample status, result management, and stock activities. |
| SC-01 Admisi | 88.5 | Broad front-door workflow with multiple admission paths and BPJS integration. |
| SC-07 IGD | 86.25 | Manages emergency visit, priority-result recording, transport, service records, and stock usage. |
| SC-10 Kamar Operasi | 86.25 | Combines ordering, constrained scheduling, administrative result capture, and stock activities. |

### Level 3 — Medium

| Screen | Total Complexity Value | Rationale |
| ------ | ---------------------- | --------- |
| SC-02 Tata Rekening | 69 | Concentrates billing, payment allocation, deposits, refunds, and financial closure. |
| SC-12 Gudang | 65.25 | Includes receiving, movement, counting, destruction, and purchase returns with inventory controls. |

### Level 2 — Low

| Screen | Total Complexity Value | Rationale |
| ------ | ---------------------- | --------- |
| SC-13 Purchasing | 57.75 | Spans demand, forecasting, approvals, supplier commitments, and invoice accountability. |

### Level 1 — Very Low

| Screen | Total Complexity Value | Rationale |
| ------ | ---------------------- | --------- |
| SC-04 Rekam Medis | 46.5 | Combines administrative coding-result management with regulatory and recurring institutional reporting. |
| SC-03 Kasir | 40.5 | Focused scope, but payment accuracy and shift reconciliation create financial control risk. |

Screens within the same Complexity Level are ordered by Total Complexity Value, then by business-rule density and operational risk rather than by an assumed delivery sequence.

The Screen Complexity Summary describes operational scope by Screen. Its repeated `Pakai Barang`, `Mutasi Barang`, and `Opname` entries must not be summed as separate product implementations. For overall implementation estimation, use the Shared / Canonical Features table and count each of those three capabilities once.

## 6. Planning Observations

### High-Risk Screens

- SC-07 IGD, SC-06 Bangsal Rawat Inap, and SC-11 Apotek have high operational consequences from time-sensitive status, capacity, transaction, and inventory workflows; the professional decisions remain user-owned.
- SC-02 Tata Rekening and SC-03 Kasir have concentrated financial accuracy, reconciliation, refund, and closure risks.
- SC-04 Rekam Medis has elevated regulatory and reporting risk through Casemix dan Coding, Pelaporan RL, and Pelaporan Index dan Sensus.

### High-Integration Screens

- SC-01 Admisi connects booking, registration, queues, schedules, patient journey, inpatient admission, and VCLAIM BPJS.
- SC-02 Tata Rekening connects service activity and patient completion with billing, payment, deposit, refund, and financial closure.
- SC-05 Poli Rawat Jalan, SC-06 Bangsal Rawat Inap, SC-08 Laboratorium, SC-09 Radiologi, SC-10 Kamar Operasi, and SC-11 Apotek each connect service workflows with patient, charge, and inventory concerns.
- SC-13 Purchasing connects demand, forecasting, purchasing decisions, supplier commitments, and invoice handling.

### Quick-Win Screens

- SC-03 Kasir has a limited feature count and a focused business boundary, despite the importance of payment and closing accuracy.
- The canonical `Pakai Barang`, `Mutasi Barang`, and `Opname` capabilities should be counted once in product implementation estimation, with their Screen occurrences retained for operational scope and context assessment.

### Screens Suitable for Early Delivery

- SC-03 Kasir and selected focused parts of SC-12 Gudang are suitable for early consideration because their business boundaries are relatively contained.
- SC-01 Admisi may be considered early for planning visibility because it is a major entry point, but its VCLAIM BPJS and multi-path registration scope make it a substantial effort.

### Screens Suitable for Later Delivery

- SC-04 Rekam Medis, SC-06 Bangsal Rawat Inap, SC-08 Laboratorium, SC-09 Radiologi, and SC-11 Apotek are suitable for later delivery consideration because they combine broad workflows, high-risk state changes, and extensive validation needs.
- SC-02 Tata Rekening and SC-13 Purchasing are also better treated as later-scope candidates when financial closure, procurement accountability, and cross-department dependencies require broader business alignment.

These observations are planning inputs only. They do not establish a roadmap, timeline, sprint sequence, or implementation commitment.

---

## Traceability Matrix

| This Artifact | Source Artifact | Relationship | Downstream Artifact |
| ------------- | --------------- | ------------ | ------------------- |
| Feature Complexity Assessment | Screen-Feature Catalog | Assigns a Complexity Level 1–5 to each cataloged Feature | Development Order |
