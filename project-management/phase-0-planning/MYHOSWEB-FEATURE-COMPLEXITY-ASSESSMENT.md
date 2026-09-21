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
| **5** | Very High | Highly complex lifecycle, dense business rules, multiple domains/systems, regulatory/financial/patient-safety impact |

The assessment dimensions are:

1. **Workflow**: breadth, number of steps, and lifecycle or state changes.
2. **Business Rules**: density, exceptions, approvals, and decision rules.
3. **Dependencies**: cross-feature, cross-domain, external, and legacy dependencies.
4. **Risk / Impact**: operational, financial, regulatory, and patient-safety consequences.
5. **Data / Migration**: data volume, history, quality, continuity, and migration sensitivity.

These dimensions guide the assessment and are not a mathematical formula. The levels describe relative business-planning complexity, not coding effort. Level 5 is reserved for features that are genuinely exceptional across multiple dimensions.

## 3. Feature Assessment

### SC-01 Admisi

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-01-01 | Booking | 3 | Reservation workflow with schedule and patient coordination rules. |
| FT-01-02 | Registrasi Rawat Jalan dan IGD | 4 | Multi-step registration spanning routine and emergency admission paths. |
| FT-01-03 | Registrasi Rawat Inap | 4 | Admission workflow with bed-related and inpatient eligibility dependencies. |
| FT-01-04 | VCLAIM BPJS | 5 | BPJS integration, validation, eligibility handling, and compliance risk. |
| FT-01-05 | Patient Journey Tracking | 4 | Cross-department journey visibility across multiple patient states. |
| FT-01-06 | Jadwal Praktek | 3 | Schedule maintenance with provider, service, and availability rules. |
| FT-01-07 | Antrian | 3 | Queue lifecycle and coordination across registration and service delivery. |

### SC-02 Tata Rekening

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-02-01 | Rincian Tagihan Pasien | 4 | Comprehensive charge consolidation with financial and service dependencies. |
| FT-02-02 | Alokasi Pembayaran | 4 | Payment allocation requires financial accuracy across multiple bill items. |
| FT-02-03 | Deposit | 3 | Controlled financial balance lifecycle with patient account implications. |
| FT-02-04 | Refund | 4 | Refund eligibility, approval, and financial reversal rules create operational risk. |
| FT-02-05 | Reg-Out | 4 | Patient financial closure depends on complete service and payment status. |

### SC-03 Kasir

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-03-01 | Order Bayar | 3 | Payment preparation workflow linked to outstanding patient charges. |
| FT-03-02 | Pembayaran | 4 | Financial transaction handling with accuracy, exception, and reconciliation concerns. |
| FT-03-03 | Closing Shift | 4 | Shift closure requires cash accountability, reconciliation, and operational controls. |

### SC-04 Rekam Medis

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-04-01 | Data Sosial Pasien | 2 | Patient identity and social information requires accuracy and maintenance controls. |
| FT-04-02 | Manajemen Berkas | 3 | Record lifecycle and availability management across patient care activities. |
| FT-04-03 | Casemix dan Coding | 5 | High rule density with clinical classification, financial, and review implications. |
| FT-04-04 | Pelaporan RL | 5 | Regulatory reporting with broad data dependencies and high correctness expectations. |
| FT-04-05 | Pelaporan Index dan Sensus | 4 | Recurring reporting and aggregation across clinical and operational activity. |

### SC-05 Poli Rawat Jalan

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-05-01 | Antrian | 3 | Queue progression and service coordination within outpatient care. |
| FT-05-02 | Tindakan | 4 | Clinical service workflow with patient, provider, and charge dependencies. |
| FT-05-03 | Rujuk Internal | 3 | Referral workflow crossing services with routing and acceptance rules. |
| FT-05-04 | CPOE (Order Pemeriksaan) | 4 | Multi-step examination ordering with clinical and downstream service dependencies. |
| FT-05-05 | Pakai Barang | 3 | Shared item-consumption capability with contextual stock accountability in outpatient care. |
| FT-05-06 | Mutasi Barang | 3 | Shared stock-movement capability with contextual custody controls in outpatient care. |
| FT-05-07 | Opname | 3 | Shared stock-counting capability with contextual variance handling in outpatient care. |

### SC-06 Bangsal Rawat Inap

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-06-01 | Tindakan | 4 | Ongoing inpatient services with broader clinical and charge dependencies. |
| FT-06-02 | Pakai Bed | 4 | Bed utilization lifecycle with availability and patient placement implications. |
| FT-06-03 | Transfer Unit | 4 | Patient movement across units requires coordinated state and responsibility changes. |
| FT-06-04 | Discharge | 5 | Multi-step clinical and administrative closure with financial and continuity risks. |
| FT-06-05 | Pakai Barang | 3 | Shared item-consumption capability with contextual stock accountability in inpatient care. |
| FT-06-06 | Mutasi Barang | 3 | Shared stock-movement capability with contextual custody controls in inpatient care. |
| FT-06-07 | Opname | 3 | Shared stock-counting capability with contextual variance handling in inpatient care. |

### SC-07 IGD

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-07-01 | IGD Visit | 3 | Emergency visit initiation under variable urgency and patient conditions. |
| FT-07-02 | Triage | 4 | Priority classification carries high clinical and operational consequence. |
| FT-07-03 | Ambulance | 4 | Coordination of transport, patient movement, and emergency service availability. |
| FT-07-04 | Tindakan | 4 | Emergency treatment workflow with time-sensitive clinical and charge dependencies. |
| FT-07-05 | Pakai Barang | 3 | Shared item-consumption capability with contextual stock accountability in emergency care. |
| FT-07-06 | Mutasi Barang | 3 | Shared stock-movement capability with contextual custody controls in emergency care. |
| FT-07-07 | Opname | 3 | Shared stock-counting capability with contextual variance handling in emergency care. |

### SC-08 Laboratorium

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-08-01 | External Registration | 3 | Registration workflow for external parties with identity and service dependencies. |
| FT-08-02 | Order Laboratorium | 4 | Laboratory order lifecycle connects requests, services, and resulting work. |
| FT-08-03 | Charge | 3 | Charge capture must align laboratory activity with patient financial records. |
| FT-08-04 | Sample Collection | 4 | Sample lifecycle requires identification, collection, and handling controls. |
| FT-08-05 | Result Management | 5 | Result lifecycle, validation, and release carry substantial clinical and operational risk. |
| FT-08-06 | Pakai Barang | 3 | Shared item-consumption capability with contextual stock accountability in laboratory services. |
| FT-08-07 | Mutasi Barang | 3 | Shared stock-movement capability with contextual custody controls in laboratory services. |
| FT-08-08 | Opname | 3 | Shared stock-counting capability with contextual variance handling in laboratory services. |

### SC-09 Radiologi

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-09-01 | Order Radiologi | 4 | Imaging request workflow with clinical, scheduling, and charge dependencies. |
| FT-09-02 | Scheduling | 4 | Resource and appointment coordination for imaging services. |
| FT-09-03 | Imaging | 3 | Receives imaging data from the PACS machine without owning the imaging operation. |
| FT-09-04 | Expertise | 3 | Records the analyst's reading for the image; interpretation complexity remains with the analyst, while the system receives the final result. |
| FT-09-05 | Verification | 4 | Result verification adds review state, responsibility, and release controls. |
| FT-09-06 | Pakai Barang | 3 | Shared item-consumption capability with contextual stock accountability in radiology services. |
| FT-09-07 | Mutasi Barang | 3 | Shared stock-movement capability with contextual custody controls in radiology services. |
| FT-09-08 | Opname | 3 | Shared stock-counting capability with contextual variance handling in radiology services. |

### SC-10 Kamar Operasi

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-10-01 | Order Operasi | 4 | Surgical request workflow with patient, service, and readiness dependencies. |
| FT-10-02 | Scheduling | 4 | Operating room and clinical resource coordination with limited capacity. |
| FT-10-03 | Pre-Operative Clearance | 3 | Administrative capture of the human analyst's final clearance result, with no ownership of the underlying medical assessment. |
| FT-10-04 | Post-Operative Management | 3 | Administrative capture of the human analyst's final post-operative result, with no ownership of the underlying medical knowledge. |
| FT-10-05 | Pakai Barang | 3 | Shared item-consumption capability with contextual stock accountability in operating room services. |
| FT-10-06 | Mutasi Barang | 3 | Shared stock-movement capability with contextual custody controls in operating room services. |
| FT-10-07 | Opname | 3 | Shared stock-counting capability with contextual variance handling in operating room services. |

### SC-11 Apotek

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-11-01 | Antrian Apotek | 3 | Queue progression must coordinate prescriptions, customers, and dispensing capacity. |
| FT-11-02 | Telaah Resep | 4 | Clinical and administrative prescription review with safety implications. |
| FT-11-03 | Penjualan | 4 | Pharmacy sales involve financial, prescription, and item availability rules. |
| FT-11-04 | Dispensing | 5 | Multi-step medication preparation with high safety and traceability expectations. |
| FT-11-05 | Serah Obat | 4 | Handover lifecycle requires identity, completion, and accountability controls. |
| FT-11-06 | Opname | 3 | Shared stock-counting capability with contextual medicine variance handling. |
| FT-11-07 | Mutasi | 3 | Shared stock-movement capability with contextual medicine custody controls. |

### SC-12 Gudang

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-12-01 | Terima Barang (DO) | 4 | Receiving workflow requires quantity, condition, and document matching controls. |
| FT-12-02 | Mutasi | 3 | Shared stock-movement capability with contextual warehouse custody controls. |
| FT-12-03 | Opname | 3 | Shared stock-counting capability with contextual warehouse variance handling. |
| FT-12-04 | Musnah | 4 | Destruction workflow requires authorization, traceability, and accountability. |
| FT-12-05 | Retur Beli | 4 | Purchase return lifecycle requires supplier, item, and financial coordination. |

### SC-13 Purchasing

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-13-01 | Material Request | 3 | Request initiation and review across operational demand sources. |
| FT-13-02 | Forecasting | 4 | Demand estimation requires historical interpretation and planning judgment. |
| FT-13-03 | Purchase Request | 4 | Controlled procurement request workflow with approval and budget implications. |
| FT-13-04 | Purchase Order | 4 | Supplier commitment lifecycle with commercial and fulfillment dependencies. |
| FT-13-05 | Faktur Tagihan | 4 | Invoice handling requires document matching and financial accountability. |

### SC-14 Mastering

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-14-01 | Master Organisasi | 2 | Organization structure maintenance affects multiple operational contexts. |
| FT-14-02 | Master Dokter | 2 | Provider information maintenance supports scheduling and care workflows. |
| FT-14-03 | Master Jaminan | 3 | Payer and coverage rules have broad financial and admission implications. |
| FT-14-04 | Master Layanan | 2 | Service catalog maintenance supports clinical and financial activities. |
| FT-14-05 | Master Tarif | 3 | Pricing maintenance has broad financial impact and high accuracy expectations. |

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

| Screen | Feature Count | Complexity Profile | Overall Complexity |
| ------ | ------------- | ------------------ | ------------------ |
| SC-01 Admisi | 7 | 3x3, 3x4, 1x5 | 5 |
| SC-02 Tata Rekening | 5 | 1x3, 4x4 | 4 |
| SC-03 Kasir | 3 | 1x3, 2x4 | 4 |
| SC-04 Rekam Medis | 5 | 1x2, 1x3, 1x4, 2x5 | 5 |
| SC-05 Poli Rawat Jalan | 7 | 5x3, 2x4 | 4 |
| SC-06 Bangsal Rawat Inap | 7 | 3x3, 3x4, 1x5 | 5 |
| SC-07 IGD | 7 | 4x3, 3x4 | 4 |
| SC-08 Laboratorium | 8 | 4x3, 3x4, 1x5 | 5 |
| SC-09 Radiologi | 8 | 5x3, 3x4 | 4 |
| SC-10 Kamar Operasi | 7 | 5x3, 2x4 | 4 |
| SC-11 Apotek | 7 | 3x3, 3x4, 1x5 | 5 |
| SC-12 Gudang | 5 | 2x3, 3x4 | 4 |
| SC-13 Purchasing | 5 | 1x3, 4x4 | 4 |
| SC-14 Mastering | 5 | 3x2, 2x3 | 3 |

## 5. Complexity Ranking

The ranking reflects the combination of feature breadth, highest individual complexity, cross-department workflow, regulatory or financial exposure, lifecycle depth, and operational risk.

| Rank | Screen | Overall Complexity | Rationale |
| ---- | ------ | ------------------ | --------- |
| 1 | SC-04 Rekam Medis | 5 | Includes casemix and coding plus regulatory and recurring institutional reporting. |
| 2 | SC-01 Admisi | 5 | Broad front-door workflow with inpatient, emergency, patient journey, queue, and BPJS integration responsibilities. |
| 3 | SC-06 Bangsal Rawat Inap | 5 | Covers inpatient treatment, bed use, unit transfer, discharge, and stock accountability across a long patient lifecycle. |
| 4 | SC-08 Laboratorium | 5 | Covers registration, ordering, charging, sample lifecycle, results, and stock activities. |
| 5 | SC-11 Apotek | 5 | Combines prescription review, sales, dispensing, medicine handover, queue, and inventory control with high safety risk. |
| 6 | SC-10 Kamar Operasi | 4 | Combines surgical ordering, constrained scheduling, administrative result capture, and stock activities. |
| 7 | SC-09 Radiologi | 4 | Combines ordering, scheduling, receipt of PACS data, analyst-result recording, verification, and stock activities. |
| 8 | SC-02 Tata Rekening | 4 | Concentrates billing, payment allocation, deposits, refunds, and financial closure. |
| 9 | SC-13 Purchasing | 4 | Spans demand, forecasting, requests, supplier commitment, and invoice accountability. |
| 10 | SC-07 IGD | 4 | Emergency urgency, triage, ambulance coordination, treatment, and stock activity create high operational risk. |
| 11 | SC-12 Gudang | 4 | Includes receiving, movement, counting, destruction, and purchase returns with material inventory controls. |
| 12 | SC-03 Kasir | 4 | Focused scope, but payment accuracy and shift reconciliation create meaningful financial risk. |
| 13 | SC-05 Poli Rawat Jalan | 4 | Broad outpatient activity, but most workflows have lower lifecycle depth than inpatient and emergency care. |
| 14 | SC-14 Mastering | 3 | Primarily controlled master data maintenance, with higher impact concentrated in guarantees and tariffs. |

Screens with the same overall level are ordered by breadth, risk, and business-rule density rather than by an assumed delivery sequence.

The Screen Complexity Summary describes operational scope by Screen. Its repeated `Pakai Barang`, `Mutasi Barang`, and `Opname` entries must not be summed as separate product implementations. For overall implementation estimation, use the Shared / Canonical Features table and count each of those three capabilities once.

## 6. Planning Observations

### High-Risk Screens

- SC-07 IGD, SC-06 Bangsal Rawat Inap, and SC-11 Apotek have high operational or patient-safety consequences and multi-step lifecycles.
- SC-02 Tata Rekening and SC-03 Kasir have concentrated financial accuracy, reconciliation, refund, and closure risks.
- SC-04 Rekam Medis has elevated regulatory and reporting risk through Casemix dan Coding, Pelaporan RL, and Pelaporan Index dan Sensus.

### High-Integration Screens

- SC-01 Admisi connects booking, registration, queues, schedules, patient journey, inpatient admission, and VCLAIM BPJS.
- SC-02 Tata Rekening connects service activity and patient completion with billing, payment, deposit, refund, and financial closure.
- SC-05 Poli Rawat Jalan, SC-06 Bangsal Rawat Inap, SC-08 Laboratorium, SC-09 Radiologi, SC-10 Kamar Operasi, and SC-11 Apotek each connect service workflows with patient, charge, and inventory concerns.
- SC-13 Purchasing connects demand, forecasting, purchasing decisions, supplier commitments, and invoice handling.

### Quick-Win Screens

- SC-14 Mastering is the clearest quick-win candidate because most features are focused maintenance workflows, although Master Jaminan and Master Tarif require stronger control.
- SC-03 Kasir has a limited feature count and a focused business boundary, despite the importance of payment and closing accuracy.
- The canonical `Pakai Barang`, `Mutasi Barang`, and `Opname` capabilities should be counted once in product implementation estimation, with their Screen occurrences retained for operational scope and context assessment.

### Screens Suitable for Early Delivery

- SC-14 Mastering is suitable for early delivery to establish foundational organizational, provider, service, guarantee, and tariff information.
- SC-03 Kasir and selected focused parts of SC-12 Gudang are suitable for early consideration because their business boundaries are relatively contained.
- SC-01 Admisi may be considered early for planning visibility because it is a major entry point, but its VCLAIM BPJS and multi-path registration scope make it a substantial effort.

### Screens Suitable for Later Delivery

- SC-04 Rekam Medis, SC-06 Bangsal Rawat Inap, SC-08 Laboratorium, SC-09 Radiologi, and SC-11 Apotek are suitable for later delivery consideration because they combine broad workflows, high-risk state changes, and extensive validation needs.
- SC-02 Tata Rekening and SC-13 Purchasing are also better treated as later-scope candidates when financial closure, procurement accountability, and cross-department dependencies require broader business alignment.

These observations are planning inputs only. They do not establish a roadmap, timeline, sprint sequence, or implementation commitment.
