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

> One row per Feature. Each Capability is listed with its owning Domain (name only) in parentheses; Features with multiple Capabilities list each on its own line (`<br>`).

| No | Feature | Capability |
|---|---|---|
| 1 | FT-01-01 Booking | CAP-03-02 Booking (Admission)<br>CAP-01-01 Data Sosial Pasien (Patient)<br>CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization)<br>CAP-02-04 Jadwal Praktek (Organization)<br>CAP-03-04 Tracker (Admission) |
| 2 | FT-01-02 Registrasi Rawat Jalan dan IGD | CAP-03-01 Registrasi (Admission)<br>CAP-01-01 Data Sosial Pasien (Patient)<br>CAP-03-04 Tracker (Admission)<br>CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization)<br>CAP-13-02 Jaminan (Tata Rekening) |
| 3 | FT-01-03 Registrasi Rawat Inap | CAP-03-01 Registrasi (Admission)<br>CAP-05-01 Penempatan Bed (Rawat Inap)<br>CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization)<br>CAP-13-02 Jaminan (Tata Rekening) |
| 4 | FT-01-04 VCLAIM BPJS | CAP-16-01 VClaim (BPJS Integration) |
| 5 | FT-01-05 Patient Journey Tracking | CAP-03-04 Tracker (Admission) |
| 6 | FT-01-06 Jadwal Praktek | CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization) |
| 7 | FT-01-07 Antrian | CAP-03-03 Antrian (Admission) |
| 8 | FT-02-01 Rincian Tagihan Pasien | CAP-13-03 Billing (Tata Rekening)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization)<br>CAP-13-02 Jaminan (Tata Rekening) |
| 9 | FT-02-02 Alokasi Pembayaran | CAP-13-04 Payment (Tata Rekening)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-13-02 Jaminan (Tata Rekening)<br>CAP-03-01 Registrasi (Admission) |
| 10 | FT-02-03 Deposit | CAP-13-04 Payment (Tata Rekening)<br>CAP-03-01 Registrasi (Admission) |
| 11 | FT-02-04 Refund | CAP-13-04 Payment (Tata Rekening)<br>CAP-03-01 Registrasi (Admission) |
| 12 | FT-02-05 Reg-Out | CAP-13-03 Billing (Tata Rekening)<br>CAP-13-04 Payment (Tata Rekening) |
| 13 | FT-03-01 Order Bayar | CAP-13-04 Payment (Tata Rekening)<br>CAP-13-02 Jaminan (Tata Rekening)<br>CAP-03-01 Registrasi (Admission) |
| 14 | FT-03-02 Pembayaran | CAP-13-04 Payment (Tata Rekening)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-03-01 Registrasi (Admission)<br>CAP-13-02 Jaminan (Tata Rekening) |
| 15 | FT-03-03 Closing Shift | CAP-13-04 Payment (Tata Rekening) |
| 16 | FT-04-01 Data Sosial Pasien | CAP-01-01 Data Sosial Pasien (Patient) |
| 17 | FT-04-02 Manajemen Berkas | CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 18 | FT-04-03 Casemix dan Coding | CAP-14-01 Casemix (Manajemen RM)<br>CAP-14-03 ICD-X (Manajemen RM) |
| 19 | FT-04-04 Pelaporan RL | CAP-14-02 Pelaporan RS (Manajemen RM) |
| 20 | FT-04-05 Pelaporan Index dan Sensus | CAP-14-02 Pelaporan RS (Manajemen RM) |
| 21 | FT-05-01 Antrian | CAP-03-03 Antrian (Admission)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 22 | FT-05-02 Tindakan | CAP-04-01 Tindakan (Rawat Jalan)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-13-01 Tarif (Tata Rekening)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization) |
| 23 | FT-05-03 Rujuk Internal | CAP-04-02 Rujukan Internal (Rawat Jalan)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-02 Dokter (Organization)<br>CAP-02-01 Layanan (Organization) |
| 24 | FT-05-04 CPOE (Order Pemeriksaan) | CAP-15-02 Order Lab (CPOE)<br>CAP-15-03 Order Radiologi (CPOE)<br>CAP-15-01 Prescription (CPOE)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 25 | FT-05-05 Pakai Barang | CAP-11-01 Persediaan (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 26 | FT-05-06 Mutasi Barang | CAP-11-02 Mutasi (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 27 | FT-05-07 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 28 | FT-06-01 Tindakan | CAP-04-01 Tindakan (Rawat Jalan)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-13-01 Tarif (Tata Rekening)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization) |
| 29 | FT-06-02 Pakai Bed | CAP-05-01 Penempatan Bed (Rawat Inap)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 30 | FT-06-03 Transfer Unit | CAP-05-02 Transfer (Rawat Inap)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 31 | FT-06-04 Discharge | CAP-05-03 Discharge (Rawat Inap)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-13-01 Tarif (Tata Rekening)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 32 | FT-06-05 Pakai Barang | CAP-11-01 Persediaan (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 33 | FT-06-06 Mutasi Barang | CAP-11-02 Mutasi (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 34 | FT-06-07 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 35 | FT-07-01 IGD Visit | CAP-06-01 IGD Visit (Emergency)<br>CAP-03-01 Registrasi (Admission) |
| 36 | FT-07-02 Triage | CAP-06-02 Triage (Emergency)<br>CAP-06-01 IGD Visit (Emergency) |
| 37 | FT-07-03 Ambulance | CAP-06-04 Ambulance (Emergency)<br>CAP-03-01 Registrasi (Admission)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-13-01 Tarif (Tata Rekening) |
| 38 | FT-07-04 Tindakan | CAP-04-01 Tindakan (Rawat Jalan)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-13-01 Tarif (Tata Rekening)<br>CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization) |
| 39 | FT-07-05 Pakai Barang | CAP-11-01 Persediaan (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 40 | FT-07-06 Mutasi Barang | CAP-11-02 Mutasi (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 41 | FT-07-07 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 42 | FT-08-01 External Registration | CAP-01-01 Data Sosial Pasien (Patient)<br>CAP-03-01 Registrasi (Admission) |
| 43 | FT-08-02 Order Laboratorium | CAP-15-02 Order Lab (CPOE)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 44 | FT-08-03 Charge | CAP-13-03 Billing (Tata Rekening)<br>CAP-13-01 Tarif (Tata Rekening)<br>CAP-03-01 Registrasi (Admission) |
| 45 | FT-08-04 Sample Collection | CAP-07-02 Sample Collection (Laboratory)<br>CAP-15-02 Order Lab (CPOE)<br>CAP-02-01 Layanan (Organization) |
| 46 | FT-08-05 Result Management | CAP-07-03 Result Management (Laboratory)<br>CAP-15-02 Order Lab (CPOE) |
| 47 | FT-08-06 Pakai Barang | CAP-11-01 Persediaan (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 48 | FT-08-07 Mutasi Barang | CAP-11-02 Mutasi (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 49 | FT-08-08 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 50 | FT-09-01 Order Radiologi | CAP-15-03 Order Radiologi (CPOE)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization) |
| 51 | FT-09-02 Scheduling | CAP-08-02 Examination (Radiology)<br>CAP-15-03 Order Radiologi (CPOE)<br>CAP-03-01 Registrasi (Admission) |
| 52 | FT-09-03 Imaging | CAP-08-02 Examination (Radiology)<br>CAP-15-03 Order Radiologi (CPOE)<br>CAP-03-01 Registrasi (Admission) |
| 53 | FT-09-04 Expertise | CAP-08-03 Expertise (Radiology)<br>CAP-15-03 Order Radiologi (CPOE)<br>CAP-02-02 Dokter (Organization) |
| 54 | FT-09-05 Verification | CAP-08-03 Expertise (Radiology)<br>CAP-15-03 Order Radiologi (CPOE)<br>CAP-02-02 Dokter (Organization) |
| 55 | FT-09-06 Pakai Barang | CAP-11-01 Persediaan (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 56 | FT-09-07 Mutasi Barang | CAP-11-02 Mutasi (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 57 | FT-09-08 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 58 | FT-10-01 Order Operasi | CAP-15-04 Order Operasi (CPOE)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-01 Layanan (Organization)<br>CAP-02-02 Dokter (Organization) |
| 59 | FT-10-02 Scheduling | CAP-09-02 Scheduling (Operating Theatre)<br>CAP-15-04 Order Operasi (CPOE)<br>CAP-02-02 Dokter (Organization) |
| 60 | FT-10-03 Pre-Operative Clearance | CAP-09-03 Operative Procedure (Operating Theatre)<br>CAP-02-02 Dokter (Organization)<br>CAP-15-04 Order Operasi (CPOE) |
| 61 | FT-10-04 Post-Operative Management | CAP-09-04 Recovery (Operating Theatre)<br>CAP-15-04 Order Operasi (CPOE)<br>CAP-03-01 Registrasi (Admission)<br>CAP-02-02 Dokter (Organization) |
| 62 | FT-10-05 Pakai Barang | CAP-11-01 Persediaan (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 63 | FT-10-06 Mutasi Barang | CAP-11-02 Mutasi (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 64 | FT-10-07 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 65 | FT-11-01 Antrian Apotek | CAP-10-02 Sales (Pharmacy)<br>CAP-15-01 Prescription (CPOE)<br>CAP-11-06 Barang (Inventory)<br>CAP-13-03 Billing (Tata Rekening) |
| 66 | FT-11-02 Telaah Resep | CAP-15-01 Prescription (CPOE)<br>CAP-03-01 Registrasi (Admission)<br>CAP-11-06 Barang (Inventory) |
| 67 | FT-11-03 Penjualan | CAP-10-02 Sales (Pharmacy)<br>CAP-15-01 Prescription (CPOE)<br>CAP-11-06 Barang (Inventory)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-03-01 Registrasi (Admission) |
| 68 | FT-11-04 Dispensing | CAP-10-03 Dispensing (Pharmacy)<br>CAP-11-06 Barang (Inventory)<br>CAP-10-02 Sales (Pharmacy)<br>CAP-11-05 Stock-Ledger (Inventory) |
| 69 | FT-11-05 Serah Obat | CAP-10-05 Serah Obat (Pharmacy)<br>CAP-10-03 Dispensing (Pharmacy)<br>CAP-15-01 Prescription (CPOE)<br>CAP-10-02 Sales (Pharmacy)<br>CAP-13-03 Billing (Tata Rekening)<br>CAP-13-04 Payment (Tata Rekening) |
| 70 | FT-11-06 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 71 | FT-11-07 Mutasi | CAP-11-02 Mutasi (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-11-06 Barang (Inventory) |
| 72 | FT-12-01 Terima Barang (DO) | CAP-12-02 Terima Barang (Procurement)<br>CAP-12-01 Purchasing (Procurement)<br>CAP-11-06 Barang (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory) |
| 73 | FT-12-02 Mutasi | CAP-11-02 Mutasi (Inventory)<br>CAP-11-06 Barang (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory) |
| 74 | FT-12-03 Opname | CAP-11-03 Opname (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-02-01 Layanan (Organization)<br>CAP-11-06 Barang (Inventory) |
| 75 | FT-12-04 Musnah | CAP-11-04 Pemusnahan (Inventory)<br>CAP-11-06 Barang (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory) |
| 76 | FT-12-05 Retur Beli | CAP-12-04 Retur Beli (Procurement)<br>CAP-11-06 Barang (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory)<br>CAP-12-05 Supplier (Procurement) |
| 77 | FT-13-01 Material Request | CAP-12-01 Purchasing (Procurement)<br>CAP-11-06 Barang (Inventory)<br>CAP-02-01 Layanan (Organization) |
| 78 | FT-13-02 Forecasting | CAP-12-01 Purchasing (Procurement)<br>CAP-11-06 Barang (Inventory)<br>CAP-11-05 Stock-Ledger (Inventory) |
| 79 | FT-13-03 Purchase Request | CAP-12-01 Purchasing (Procurement)<br>CAP-11-06 Barang (Inventory) |
| 80 | FT-13-04 Purchase Order | CAP-12-01 Purchasing (Procurement)<br>CAP-12-05 Supplier (Procurement)<br>CAP-11-06 Barang (Inventory) |
| 81 | FT-13-05 Faktur Tagihan | CAP-12-03 Faktur Tagihan (Procurement)<br>CAP-12-05 Supplier (Procurement)<br>CAP-11-06 Barang (Inventory) |

## 3. Mapping Statistics

| Metric | Count |
|---|---|
| Table Rows (one per Feature) | 81 |
| Features Mapped | 81 |
| Feature–Capability Relationships | 274 |
| Features with Multiple Capability Mappings | 74 |
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