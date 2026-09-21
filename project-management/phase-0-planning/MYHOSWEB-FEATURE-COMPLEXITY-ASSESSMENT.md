# MYHOSWEB Feature Complexity Assessment

## 1. Purpose

This artifact provides an initial, business-oriented complexity assessment for every feature in the MYHOSWEB Screen-Feature Catalog. It is intended to support Phase-0 roadmap planning, development timeframe estimation, feature prioritization, resource allocation, and Board of Directors planning discussion.

The assessment is relative and directional. It uses only the scope defined in `MYHOSWEB-SCREEN-FEATURE-CATALOG.md`; it is not a technical design, implementation plan, or delivery commitment.

## 2. Complexity Scale

| Level | Description |
| ----- | ----------- |
| XS | Very small scope with minimal workflow and limited business rules. |
| S | Small scope with a focused workflow and low dependency. |
| M | Medium scope with several business rules, workflow steps, or departmental touchpoints. |
| L | Large scope with broad workflow, material lifecycle or state management, and multiple dependencies. |
| XL | Very large scope involving substantial cross-domain coordination, integration, regulatory, financial, or operational risk. |
| XXL | Exceptional scope combining extensive workflow breadth, high business-rule density, major dependencies, and significant operational risk. |

Complexity considers workflow breadth, business rule density, cross-domain dependency, external integration dependency, lifecycle and state complexity, legacy migration impact, testing scope, and operational risk. The levels describe relative planning complexity, not coding effort.

## 3. Feature Assessment

### SC-01 Admisi

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-01-01 | Booking | M | Reservation workflow with schedule and patient coordination rules. |
| FT-01-02 | Registrasi Rawat Jalan dan IGD | L | Multi-step registration spanning routine and emergency admission paths. |
| FT-01-03 | Registrasi Rawat Inap | L | Admission workflow with bed-related and inpatient eligibility dependencies. |
| FT-01-04 | VCLAIM BPJS | XL | BPJS integration, validation, eligibility handling, and compliance risk. |
| FT-01-05 | Patient Journey Tracking | L | Cross-department journey visibility across multiple patient states. |
| FT-01-06 | Jadwal Praktek | M | Schedule maintenance with provider, service, and availability rules. |
| FT-01-07 | Antrian | M | Queue lifecycle and coordination across registration and service delivery. |

### SC-02 Tata Rekening

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-02-01 | Rincian Tagihan Pasien | L | Comprehensive charge consolidation with financial and service dependencies. |
| FT-02-02 | Alokasi Pembayaran | L | Payment allocation requires financial accuracy across multiple bill items. |
| FT-02-03 | Deposit | M | Controlled financial balance lifecycle with patient account implications. |
| FT-02-04 | Refund | L | Refund eligibility, approval, and financial reversal rules create operational risk. |
| FT-02-05 | Reg-Out | L | Patient financial closure depends on complete service and payment status. |

### SC-03 Kasir

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-03-01 | Order Bayar | M | Payment preparation workflow linked to outstanding patient charges. |
| FT-03-02 | Pembayaran | L | Financial transaction handling with accuracy, exception, and reconciliation concerns. |
| FT-03-03 | Closing Shift | L | Shift closure requires cash accountability, reconciliation, and operational controls. |

### SC-04 Rekam Medis

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-04-01 | Data Sosial Pasien | M | Patient identity and social information requires accuracy and maintenance controls. |
| FT-04-02 | Manajemen Berkas | M | Record lifecycle and availability management across patient care activities. |
| FT-04-03 | Casemix dan Coding | XL | High rule density with clinical classification, financial, and review implications. |
| FT-04-04 | Pelaporan RL | XL | Regulatory reporting with broad data dependencies and high correctness expectations. |
| FT-04-05 | Pelaporan Index dan Sensus | L | Recurring reporting and aggregation across clinical and operational activity. |

### SC-05 Poli Rawat Jalan

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-05-01 | Antrian | M | Queue progression and service coordination within outpatient care. |
| FT-05-02 | Tindakan | L | Clinical service workflow with patient, provider, and charge dependencies. |
| FT-05-03 | Rujuk Internal | M | Referral workflow crossing services with routing and acceptance rules. |
| FT-05-04 | CPOE (Order Pemeriksaan) | L | Multi-step examination ordering with clinical and downstream service dependencies. |
| FT-05-05 | Pakai Barang | M | Item consumption affects service activity and stock accountability; reusable pattern may apply across units. |
| FT-05-06 | Mutasi Barang | M | Stock movement lifecycle and custody controls; reusable pattern may apply across units. |
| FT-05-07 | Opname | M | Periodic stock counting and variance handling; reusable pattern may apply across units. |

### SC-06 Bangsal Rawat Inap

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-06-01 | Tindakan | L | Ongoing inpatient services with broader clinical and charge dependencies. |
| FT-06-02 | Pakai Bed | L | Bed utilization lifecycle with availability and patient placement implications. |
| FT-06-03 | Transfer Unit | L | Patient movement across units requires coordinated state and responsibility changes. |
| FT-06-04 | Discharge | XL | Multi-step clinical and administrative closure with financial and continuity risks. |
| FT-06-05 | Pakai Barang | M | Item consumption affects inpatient service records and stock accountability; reusable pattern may apply across units. |
| FT-06-06 | Mutasi Barang | M | Stock movement across inpatient locations with custody controls; reusable pattern may apply across units. |
| FT-06-07 | Opname | M | Periodic stock counting and variance handling; reusable pattern may apply across units. |

### SC-07 IGD

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-07-01 | IGD Visit | M | Emergency visit initiation under variable urgency and patient conditions. |
| FT-07-02 | Triage | L | Priority classification carries high clinical and operational consequence. |
| FT-07-03 | Ambulance | L | Coordination of transport, patient movement, and emergency service availability. |
| FT-07-04 | Tindakan | L | Emergency treatment workflow with time-sensitive clinical and charge dependencies. |
| FT-07-05 | Pakai Barang | M | Emergency item consumption requires timely stock accountability; reusable pattern may apply across units. |
| FT-07-06 | Mutasi Barang | M | Emergency stock movement requires location and custody control; reusable pattern may apply across units. |
| FT-07-07 | Opname | M | Periodic stock counting and variance handling in an emergency environment; reusable pattern may apply across units. |

### SC-08 Laboratorium

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-08-01 | External Registration | L | Registration workflow for external parties with identity and service dependencies. |
| FT-08-02 | Order Laboratorium | L | Laboratory order lifecycle connects requests, services, and resulting work. |
| FT-08-03 | Charge | M | Charge capture must align laboratory activity with patient financial records. |
| FT-08-04 | Sample Collection | L | Sample lifecycle requires identification, collection, and handling controls. |
| FT-08-05 | Result Management | XL | Result lifecycle, validation, and release carry substantial clinical and operational risk. |
| FT-08-06 | Pakai Barang | M | Consumable usage affects laboratory activity and stock accountability; reusable pattern may apply across units. |
| FT-08-07 | Mutasi Barang | M | Stock movement across laboratory locations with custody controls; reusable pattern may apply across units. |
| FT-08-08 | Opname | M | Periodic stock counting and variance handling; reusable pattern may apply across units. |

### SC-09 Radiologi

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-09-01 | Order Radiologi | L | Imaging request workflow with clinical, scheduling, and charge dependencies. |
| FT-09-02 | Scheduling | L | Resource and appointment coordination for imaging services. |
| FT-09-03 | Imaging | XL | Examination lifecycle involves high operational coordination and clinical result dependency. |
| FT-09-04 | Expertise | L | Specialist interpretation workflow with clinical accountability. |
| FT-09-05 | Verification | L | Result verification adds review state, responsibility, and release controls. |
| FT-09-06 | Pakai Barang | M | Consumable usage affects radiology activity and stock accountability; reusable pattern may apply across units. |
| FT-09-07 | Mutasi Barang | M | Stock movement across radiology locations with custody controls; reusable pattern may apply across units. |
| FT-09-08 | Opname | M | Periodic stock counting and variance handling; reusable pattern may apply across units. |

### SC-10 Kamar Operasi

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-10-01 | Order Operasi | L | Surgical request workflow with patient, service, and readiness dependencies. |
| FT-10-02 | Scheduling | L | Operating room and clinical resource coordination with limited capacity. |
| FT-10-03 | Pre-Operative Clearance | XL | Multi-party readiness and approval workflow with high patient-safety risk. |
| FT-10-04 | Post-Operative Management | XL | Post-procedure lifecycle spans care, monitoring, documentation, and continuity. |
| FT-10-05 | Pakai Barang | M | Surgical item consumption affects service records and stock accountability; reusable pattern may apply across units. |
| FT-10-06 | Mutasi Barang | M | Stock movement across operating room locations with custody controls; reusable pattern may apply across units. |
| FT-10-07 | Opname | M | Periodic stock counting and variance handling; reusable pattern may apply across units. |

### SC-11 Apotek

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-11-01 | Antrian Apotek | M | Queue progression must coordinate prescriptions, customers, and dispensing capacity. |
| FT-11-02 | Telaah Resep | L | Clinical and administrative prescription review with safety implications. |
| FT-11-03 | Penjualan | L | Pharmacy sales involve financial, prescription, and item availability rules. |
| FT-11-04 | Dispensing | XL | Multi-step medication preparation with high safety and traceability expectations. |
| FT-11-05 | Serah Obat | L | Handover lifecycle requires identity, completion, and accountability controls. |
| FT-11-06 | Opname | M | Periodic medicine stock counting and variance handling. |
| FT-11-07 | Mutasi | M | Medicine movement lifecycle with location and custody controls. |

### SC-12 Gudang

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-12-01 | Terima Barang (DO) | L | Receiving workflow requires quantity, condition, and document matching controls. |
| FT-12-02 | Mutasi | M | Inventory movement with location and custody rules. |
| FT-12-03 | Opname | M | Periodic stock counting and variance handling. |
| FT-12-04 | Musnah | L | Destruction workflow requires authorization, traceability, and accountability. |
| FT-12-05 | Retur Beli | L | Purchase return lifecycle requires supplier, item, and financial coordination. |

### SC-13 Purchasing

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-13-01 | Material Request | M | Request initiation and review across operational demand sources. |
| FT-13-02 | Forecasting | L | Demand estimation requires historical interpretation and planning judgment. |
| FT-13-03 | Purchase Request | L | Controlled procurement request workflow with approval and budget implications. |
| FT-13-04 | Purchase Order | L | Supplier commitment lifecycle with commercial and fulfillment dependencies. |
| FT-13-05 | Faktur Tagihan | L | Invoice handling requires document matching and financial accountability. |

### SC-14 Mastering

| Feature ID | Feature | Complexity | Initial Rationale |
| ---------- | ------- | ---------- | ----------------- |
| FT-14-01 | Master Organisasi | M | Organization structure maintenance affects multiple operational contexts. |
| FT-14-02 | Master Dokter | M | Provider information maintenance supports scheduling and care workflows. |
| FT-14-03 | Master Jaminan | L | Payer and coverage rules have broad financial and admission implications. |
| FT-14-04 | Master Layanan | M | Service catalog maintenance supports clinical and financial activities. |
| FT-14-05 | Master Tarif | L | Pricing maintenance has broad financial impact and high accuracy expectations. |

Repeated floor-stock features are assessed independently because their operational context differs by screen. Their recurring patterns may offer reuse potential, but the assessments remain separate for planning purposes.

## 4. Screen Complexity Summary

| Screen | Feature Count | Complexity Profile | Overall Complexity |
| ------ | ------------- | ------------------ | ------------------ |
| SC-01 Admisi | 7 | 3M, 3L, 1XL | XL |
| SC-02 Tata Rekening | 5 | 1M, 4L | XL |
| SC-03 Kasir | 3 | 1M, 2L | L |
| SC-04 Rekam Medis | 5 | 2M, 1L, 2XL | XL |
| SC-05 Poli Rawat Jalan | 7 | 5M, 2L | L |
| SC-06 Bangsal Rawat Inap | 7 | 3M, 3L, 1XL | XL |
| SC-07 IGD | 7 | 4M, 3L | XL |
| SC-08 Laboratorium | 8 | 3M, 3L, 1XL | XL |
| SC-09 Radiologi | 8 | 3M, 4L, 1XL | XL |
| SC-10 Kamar Operasi | 7 | 3M, 2L, 2XL | XL |
| SC-11 Apotek | 7 | 3M, 3L, 1XL | XL |
| SC-12 Gudang | 5 | 2M, 3L | L |
| SC-13 Purchasing | 5 | 1M, 4L | XL |
| SC-14 Mastering | 5 | 3M, 2L | M |

## 5. Complexity Ranking

The ranking reflects the combination of feature breadth, highest individual complexity, cross-department workflow, regulatory or financial exposure, lifecycle depth, and operational risk.

| Rank | Screen | Overall Complexity | Rationale |
| ---- | ------ | ------------------ | --------- |
| 1 | SC-10 Kamar Operasi | XL | Combines surgical ordering, constrained scheduling, pre-operative clearance, post-operative management, and high-risk stock activity. |
| 2 | SC-04 Rekam Medis | XL | Includes casemix and coding plus regulatory and recurring institutional reporting. |
| 3 | SC-01 Admisi | XL | Broad front-door workflow with inpatient, emergency, patient journey, queue, and BPJS integration responsibilities. |
| 4 | SC-06 Bangsal Rawat Inap | XL | Covers inpatient treatment, bed use, unit transfer, discharge, and stock accountability across a long patient lifecycle. |
| 5 | SC-09 Radiologi | XL | Combines ordering, capacity scheduling, imaging, specialist expertise, verification, and stock activities. |
| 6 | SC-08 Laboratorium | XL | Covers registration, ordering, charging, sample lifecycle, results, and stock activities. |
| 7 | SC-11 Apotek | XL | Combines prescription review, sales, dispensing, medicine handover, queue, and inventory control with high safety risk. |
| 8 | SC-02 Tata Rekening | XL | Concentrates billing, payment allocation, deposits, refunds, and financial closure. |
| 9 | SC-13 Purchasing | XL | Spans demand, forecasting, requests, supplier commitment, and invoice accountability. |
| 10 | SC-07 IGD | XL | Emergency urgency, triage, ambulance coordination, treatment, and stock activity create high operational risk. |
| 11 | SC-12 Gudang | L | Includes receiving, movement, counting, destruction, and purchase returns with material inventory controls. |
| 12 | SC-03 Kasir | L | Focused scope, but payment accuracy and shift reconciliation create meaningful financial risk. |
| 13 | SC-05 Poli Rawat Jalan | L | Broad outpatient activity, but most workflows have lower lifecycle depth than inpatient and emergency care. |
| 14 | SC-14 Mastering | M | Primarily controlled master data maintenance, with higher impact concentrated in guarantees and tariffs. |

Screens with the same overall level are ordered by breadth, risk, and business-rule density rather than by an assumed delivery sequence.

## 6. Planning Observations

### High-Risk Screens

- SC-10 Kamar Operasi, SC-07 IGD, SC-06 Bangsal Rawat Inap, and SC-11 Apotek have high operational or patient-safety consequences and multi-step lifecycles.
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
- Repeated floor-stock features may benefit from consistent business treatment across screens, while still requiring separate validation in each operational context.

### Screens Suitable for Early Delivery

- SC-14 Mastering is suitable for early delivery to establish foundational organizational, provider, service, guarantee, and tariff information.
- SC-03 Kasir and selected focused parts of SC-12 Gudang are suitable for early consideration because their business boundaries are relatively contained.
- SC-01 Admisi may be considered early for planning visibility because it is a major entry point, but its VCLAIM BPJS and multi-path registration scope make it a substantial effort.

### Screens Suitable for Later Delivery

- SC-10 Kamar Operasi, SC-04 Rekam Medis, SC-06 Bangsal Rawat Inap, SC-08 Laboratorium, SC-09 Radiologi, and SC-11 Apotek are suitable for later delivery consideration because they combine broad workflows, high-risk state changes, and extensive validation needs.
- SC-02 Tata Rekening and SC-13 Purchasing are also better treated as later-scope candidates when financial closure, procurement accountability, and cross-department dependencies require broader business alignment.

These observations are planning inputs only. They do not establish a roadmap, timeline, sprint sequence, or implementation commitment.
