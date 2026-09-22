# MYHOSWEB Feature–Capability Mapping

## 1. Purpose

This artifact provides the initial Feature–Capability mapping for the MYHOSWEB platform. It realizes the unified scope model:

```text
Domain → Capabilities
Screen → Features → Capabilities
```

Relationships:

- A Domain contains many Capabilities.
- A Screen contains many Features.
- A Feature may map to MANY Capabilities.
- A Feature may map to Capabilities across different Domains.
- Feature ↔ Capability is an explicit N:M relationship.

> **Initial / Subject to Manual Review** — This mapping is a first-pass inference from existing artifacts. Business meaning was preferred over Screen ownership. Review and correct before use in downstream planning.

## 2. Feature–Capability Mapping

| No | Feature | Capability | Domain |
|---|---|---|---|
| 1 | FT-01-01 Booking | CAP-03-02 Booking | DOM-03 Admission |
| 2 | FT-01-02 Registrasi Rawat Jalan dan IGD | CAP-03-01 Registrasi | DOM-03 Admission |
| 3 | FT-01-02 Registrasi Rawat Jalan dan IGD | CAP-03-04 Tracker | DOM-03 Admission |
| 4 | FT-01-03 Registrasi Rawat Inap | CAP-03-01 Registrasi | DOM-03 Admission |
| 5 | FT-01-03 Registrasi Rawat Inap | CAP-05-01 Penempatan Bed | DOM-05 Rawat Inap |
| 6 | FT-01-04 VCLAIM BPJS | CAP-16-01 VClaim | DOM-16 BPJS Integration |
| 7 | FT-01-05 Patient Journey Tracking | CAP-03-04 Tracker | DOM-03 Admission |
| 8 | FT-01-06 Jadwal Praktek | CAP-02-01 Layanan | DOM-02 Organization |
| 9 | FT-01-06 Jadwal Praktek | CAP-02-02 Dokter | DOM-02 Organization |
| 10 | FT-01-07 Antrian | CAP-03-03 Antrian | DOM-03 Admission |
| 11 | FT-02-01 Rincian Tagihan Pasien | CAP-13-03 Billing | DOM-13 Tata Rekening |
| 12 | FT-02-02 Alokasi Pembayaran | CAP-13-04 Payment | DOM-13 Tata Rekening |
| 13 | FT-02-03 Deposit | CAP-13-04 Payment | DOM-13 Tata Rekening |
| 14 | FT-02-04 Refund | CAP-13-04 Payment | DOM-13 Tata Rekening |
| 15 | FT-02-05 Reg-Out | CAP-13-03 Billing | DOM-13 Tata Rekening |
| 16 | FT-02-05 Reg-Out | CAP-13-04 Payment | DOM-13 Tata Rekening |
| 17 | FT-03-01 Order Bayar | CAP-13-04 Payment | DOM-13 Tata Rekening |
| 18 | FT-03-02 Pembayaran | CAP-13-04 Payment | DOM-13 Tata Rekening |
| 19 | FT-03-03 Closing Shift | CAP-13-04 Payment | DOM-13 Tata Rekening |
| 20 | FT-04-01 Data Sosial Pasien | CAP-01-01 Data Sosial Pasien | DOM-01 Patient |
| 21 | FT-04-02 Manajemen Berkas | CAP-14-01 Casemix | DOM-14 Manajemen RM |
| 22 | FT-04-02 Manajemen Berkas | CAP-14-02 Pelaporan RS | DOM-14 Manajemen RM |
| 23 | FT-04-03 Casemix dan Coding | CAP-14-01 Casemix | DOM-14 Manajemen RM |
| 24 | FT-04-04 Pelaporan RL | CAP-14-02 Pelaporan RS | DOM-14 Manajemen RM |
| 25 | FT-04-05 Pelaporan Index dan Sensus | CAP-14-02 Pelaporan RS | DOM-14 Manajemen RM |
| 26 | FT-05-01 Antrian | CAP-03-03 Antrian | DOM-03 Admission |
| 27 | FT-05-02 Tindakan | CAP-04-01 Tindakan | DOM-04 Rawat Jalan |
| 28 | FT-05-03 Rujuk Internal | CAP-04-02 Rujukan Internal | DOM-04 Rawat Jalan |
| 29 | FT-05-04 CPOE (Order Pemeriksaan) | CAP-15-02 Order Lab | DOM-15 CPOE |
| 30 | FT-05-04 CPOE (Order Pemeriksaan) | CAP-15-03 Order Radiologi | DOM-15 CPOE |
| 31 | FT-05-05 Pakai Barang | CAP-11-01 Persediaan | DOM-11 Inventory |
| 32 | FT-05-06 Mutasi Barang | CAP-11-02 Mutasi | DOM-11 Inventory |
| 33 | FT-05-07 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 34 | FT-06-01 Tindakan | CAP-04-01 Tindakan | DOM-04 Rawat Jalan |
| 35 | FT-06-02 Pakai Bed | CAP-05-01 Penempatan Bed | DOM-05 Rawat Inap |
| 36 | FT-06-03 Transfer Unit | CAP-05-02 Transfer | DOM-05 Rawat Inap |
| 37 | FT-06-04 Discharge | CAP-05-03 Discharge | DOM-05 Rawat Inap |
| 38 | FT-06-05 Pakai Barang | CAP-11-01 Persediaan | DOM-11 Inventory |
| 39 | FT-06-06 Mutasi Barang | CAP-11-02 Mutasi | DOM-11 Inventory |
| 40 | FT-06-07 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 41 | FT-07-01 IGD Visit | CAP-06-01 IGD Visit | DOM-06 Emergency |
| 42 | FT-07-02 Triage | CAP-06-02 Triage | DOM-06 Emergency |
| 43 | FT-07-03 Ambulance | CAP-06-04 Ambulance | DOM-06 Emergency |
| 44 | FT-07-04 Tindakan | CAP-04-01 Tindakan | DOM-04 Rawat Jalan |
| 45 | FT-07-05 Pakai Barang | CAP-11-01 Persediaan | DOM-11 Inventory |
| 46 | FT-07-06 Mutasi Barang | CAP-11-02 Mutasi | DOM-11 Inventory |
| 47 | FT-07-07 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 48 | FT-08-01 External Registration | CAP-07-02 Sample Collection | DOM-07 Laboratory |
| 49 | FT-08-02 Order Laboratorium | CAP-15-02 Order Lab | DOM-15 CPOE |
| 50 | FT-08-03 Charge | CAP-13-03 Billing | DOM-13 Tata Rekening |
| 51 | FT-08-04 Sample Collection | CAP-07-02 Sample Collection | DOM-07 Laboratory |
| 52 | FT-08-05 Result Management | CAP-07-03 Result Management | DOM-07 Laboratory |
| 53 | FT-08-06 Pakai Barang | CAP-11-01 Persediaan | DOM-11 Inventory |
| 54 | FT-08-07 Mutasi Barang | CAP-11-02 Mutasi | DOM-11 Inventory |
| 55 | FT-08-08 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 56 | FT-09-01 Order Radiologi | CAP-15-03 Order Radiologi | DOM-15 CPOE |
| 57 | FT-09-02 Scheduling | CAP-08-02 Examination | DOM-08 Radiology |
| 58 | FT-09-03 Imaging | CAP-08-02 Examination | DOM-08 Radiology |
| 59 | FT-09-04 Expertise | CAP-08-03 Expertise | DOM-08 Radiology |
| 60 | FT-09-05 Verification | CAP-08-03 Expertise | DOM-08 Radiology |
| 61 | FT-09-06 Pakai Barang | CAP-11-01 Persediaan | DOM-11 Inventory |
| 62 | FT-09-07 Mutasi Barang | CAP-11-02 Mutasi | DOM-11 Inventory |
| 63 | FT-09-08 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 64 | FT-10-01 Order Operasi | CAP-15-04 Order Operasi | DOM-15 CPOE |
| 65 | FT-10-02 Scheduling | CAP-09-02 Scheduling | DOM-09 Operating Theatre |
| 66 | FT-10-03 Pre-Operative Clearance | CAP-09-03 Operative Procedure | DOM-09 Operating Theatre |
| 67 | FT-10-04 Post-Operative Management | CAP-09-04 Recovery | DOM-09 Operating Theatre |
| 68 | FT-10-05 Pakai Barang | CAP-11-01 Persediaan | DOM-11 Inventory |
| 69 | FT-10-06 Mutasi Barang | CAP-11-02 Mutasi | DOM-11 Inventory |
| 70 | FT-10-07 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 71 | FT-11-01 Antrian Apotek | CAP-10-02 Sales | DOM-10 Pharmacy |
| 72 | FT-11-02 Telaah Resep | CAP-15-01 Prescription | DOM-15 CPOE |
| 73 | FT-11-03 Penjualan | CAP-10-02 Sales | DOM-10 Pharmacy |
| 74 | FT-11-04 Dispensing | CAP-10-03 Dispensing | DOM-10 Pharmacy |
| 75 | FT-11-05 Serah Obat | CAP-10-05 Serah Obat | DOM-10 Pharmacy |
| 76 | FT-11-06 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 77 | FT-11-07 Mutasi | CAP-11-02 Mutasi | DOM-11 Inventory |
| 78 | FT-12-01 Terima Barang (DO) | CAP-12-02 Terima Barang | DOM-12 Procurement |
| 79 | FT-12-02 Mutasi | CAP-11-02 Mutasi | DOM-11 Inventory |
| 80 | FT-12-03 Opname | CAP-11-03 Opname | DOM-11 Inventory |
| 81 | FT-12-04 Musnah | CAP-11-04 Pemusnahan | DOM-11 Inventory |
| 82 | FT-12-05 Retur Beli | CAP-12-04 Retur Beli | DOM-12 Procurement |
| 83 | FT-13-01 Material Request | CAP-12-01 Purchasing | DOM-12 Procurement |
| 84 | FT-13-02 Forecasting | CAP-12-01 Purchasing | DOM-12 Procurement |
| 85 | FT-13-03 Purchase Request | CAP-12-01 Purchasing | DOM-12 Procurement |
| 86 | FT-13-04 Purchase Order | CAP-12-01 Purchasing | DOM-12 Procurement |
| 87 | FT-13-05 Faktur Tagihan | CAP-12-03 Faktur Tagihan | DOM-12 Procurement |
| 88 | FT-14-01 Master Organisasi | CAP-02-01 Layanan | DOM-02 Organization |
| 89 | FT-14-02 Master Dokter | CAP-02-02 Dokter | DOM-02 Organization |
| 90 | FT-14-03 Master Jaminan | CAP-13-02 Jaminan | DOM-13 Tata Rekening |
| 91 | FT-14-04 Master Layanan | CAP-02-01 Layanan | DOM-02 Organization |
| 92 | FT-14-05 Master Tarif | CAP-13-01 Tarif | DOM-13 Tata Rekening |

## 3. Mapping Statistics

| Metric | Count |
|---|---|
| Features Mapped | 86 |
| Feature–Capability Relationships | 92 |
| Features with Multiple Capability Mappings | 6 |
| Features with Ambiguous Mapping | 6 |

## 4. Ambiguous Mappings (Require Manual Review)

| Feature ID | Feature Name | Reason for Ambiguity |
|---|---|---|
| FT-01-02 | Registrasi Rawat Jalan dan IGD | Spans outpatient and emergency registration; could also map to CAP-06-01 |
| FT-01-03 | Registrasi Rawat Inap | Inpatient registration inherently involves bed assignment (CAP-05-01) but is an Admission-domain workflow |
| FT-01-06 | Jadwal Praktek | Doctor practice schedules touch both service definitions (CAP-02-01) and provider management (CAP-02-02) |
| FT-04-02 | Manajemen Berkas | Medical record folder management supports both casemix coding (CAP-14-01) and statutory reporting (CAP-14-02) |
| FT-05-04 | CPOE (Order Pemeriksaan) | Single feature covers both laboratory and radiology orders; maps to two CPOE capabilities |
| FT-07-04 | Tindakan | Emergency procedures could map to Rawat Jalan Tindakan (CAP-04-01) or a distinct Emergency capability not currently defined |

## 5. Traceability Matrix

| This Artifact | Source Artifact | Relationship | Downstream Artifact |
| ------------- | --------------- | ------------ | ------------------- |
| Feature–Capability Mapping | Domain Catalog | Maps Features onto business Domains and Capabilities (N:M) | — |
| Feature–Capability Mapping | Screen-Feature Catalog | References registry-defined Features | — |