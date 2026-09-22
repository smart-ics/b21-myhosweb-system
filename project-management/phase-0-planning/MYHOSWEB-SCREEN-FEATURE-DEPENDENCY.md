**SC-01 Admisi**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 1 | SC-01 Admisi | FT-01-01 Booking | - FT-01-06 Jadwal Praktek |
| 2 | SC-01 Admisi | FT-01-02 Registrasi Rawat Jalan dan IGD | - FT-04-01 Data Sosial Pasien<br>- FT-01-01 Booking (opt)<br>- FT-14-02 Master Dokter<br>- FT-14-03 Master Jaminan<br>- FT-14-01 Master Organisasi |
| 3 | SC-01 Admisi | FT-01-03 Registrasi Rawat Inap | - FT-14-02 Master Dokter<br>- FT-14-03 Master Jaminan<br>- FT-14-01 Master Organisasi<br>- FT-04-01 Data Sosial Pasien |
| 4 | SC-01 Admisi | FT-01-04 VCLAIM BPJS |  |
| 5 | SC-01 Admisi | FT-01-05 Patient Journey Tracking |  |
| 6 | SC-01 Admisi | FT-01-06 Jadwal Praktek | - FT-14-02 Master Dokter<br>- FT-14-01 Master Organisasi |
| 7 | SC-01 Admisi | FT-01-07 Antrian |  |

**SC-02 Tata Rekening**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 8 | SC-02 Tata Rekening | FT-02-01 Rincian Tagihan Pasien | - FT-01-02 Registrasi Rawat Jalan dan IGD |
| 9 | SC-02 Tata Rekening | FT-02-02 Alokasi Pembayaran | - FT-02-01 Rincian Tagihan Pasien<br>- FT-14-03 Master Jaminan |
| 10 | SC-02 Tata Rekening | FT-02-03 Deposit | - FT-01-03 Registrasi Rawat Inap |
| 11 | SC-02 Tata Rekening | FT-02-04 Refund | - FT-03-02 Pembayaran |
| 12 | SC-02 Tata Rekening | FT-02-05 Reg-Out | - FT-02-02 Alokasi Pembayaran |

**SC-03 Kasir**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 13 | SC-03 Kasir | FT-03-01 Order Bayar | - FT-01-02 Registrasi Rawat Jalan dan IGD |
| 14 | SC-03 Kasir | FT-03-02 Pembayaran | - FT-03-01 Order Bayar<br>- FT-02-03 Deposit<br>- FT-02-05 Reg-Out |
| 15 | SC-03 Kasir | FT-03-03 Closing Shift | - FT-03-02 Pembayaran |

**SC-04 Rekam Medis**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 16 | SC-04 Rekam Medis | FT-04-01 Data Sosial Pasien |  |
| 17 | SC-04 Rekam Medis | FT-04-02 Manajemen Berkas | - FT-01-02 Registrasi Rawat Jalan dan IGD<br>- FT-14-01 Master Organisasi |
| 18 | SC-04 Rekam Medis | FT-04-03 Casemix dan Coding | - FT-01-02 Registrasi Rawat Jalan dan IGD |
| 19 | SC-04 Rekam Medis | FT-04-04 Pelaporan RL |  |
| 20 | SC-04 Rekam Medis | FT-04-05 Pelaporan Index dan Sensus |  |

**SC-05 Poli Rawat Jalan**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 21 | SC-05 Poli Rawat Jalan | FT-05-01 Antrian |  |
| 22 | SC-05 Poli Rawat Jalan | FT-05-02 Tindakan | - FT-01-02 Registrasi Rawat Jalan dan IGD<br>- FT-14-05 Master Tarif<br>- FT-14-01 Master Organisasi |
| 23 | SC-05 Poli Rawat Jalan | FT-05-03 Rujuk Internal | - FT-01-02 Registrasi Rawat Jalan dan IGD |
| 24 | SC-05 Poli Rawat Jalan | FT-05-04 CPOE (Order Pemeriksaan) | - FT-01-02 Registrasi Rawat Jalan dan IGD<br>- FT-14-02 Master Dokter<br>- FT-14-01 Master Organisasi |
| 25 | SC-05 Poli Rawat Jalan | FT-05-05 Pakai Barang | - FT-07-05 Pakai Barang (shared) |
| 26 | SC-05 Poli Rawat Jalan | FT-05-06 Mutasi Barang | - FT-12-02 Mutasi (shared) |
| 27 | SC-05 Poli Rawat Jalan | FT-05-07 Opname | - FT-12-03 Opname (shared) |

**SC-06 Bangsal Rawat Inap**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 28 | SC-06 Bangsal Rawat Inap | FT-06-01 Tindakan | - FT-01-03 Registrasi Rawat Inap |
| 29 | SC-06 Bangsal Rawat Inap | FT-06-02 Pakai Bed | - FT-01-03 Registrasi Rawat Inap<br>- FT-14-01 Master Organisasi<br>- FT-14-05 Master Tarif |
| 30 | SC-06 Bangsal Rawat Inap | FT-06-03 Transfer Unit | - FT-01-03 Registrasi Rawat Inap<br>- FT-14-01 Master Organisasi |
| 31 | SC-06 Bangsal Rawat Inap | FT-06-04 Discharge | - FT-01-03 Registrasi Rawat Inap<br>- FT-06-02 Pakai Bed |
| 32 | SC-06 Bangsal Rawat Inap | FT-06-05 Pakai Barang | - FT-07-05 Pakai Barang (shared) |
| 33 | SC-06 Bangsal Rawat Inap | FT-06-06 Mutasi Barang | - FT-12-02 Mutasi (shared) |
| 34 | SC-06 Bangsal Rawat Inap | FT-06-07 Opname | - FT-12-03 Opname (shared) |

**SC-07 IGD**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 35 | SC-07 IGD | FT-07-01 IGD Visit | - FT-01-02 Registrasi Rawat Jalan dan IGD<br>- FT-14-01 Master Organisasi |
| 36 | SC-07 IGD | FT-07-02 Triage | - FT-07-01 IGD Visit |
| 37 | SC-07 IGD | FT-07-03 Ambulance | - FT-01-02 Registrasi Rawat Jalan dan IGD |
| 38 | SC-07 IGD | FT-07-04 Tindakan | - FT-07-01 IGD Visit |
| 39 | SC-07 IGD | FT-07-05 Pakai Barang |  |
| 40 | SC-07 IGD | FT-07-06 Mutasi Barang | - FT-12-02 Mutasi (shared) |
| 41 | SC-07 IGD | FT-07-07 Opname | - FT-12-03 Opname (shared) |

**SC-08 Laboratorium**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 42 | SC-08 Laboratorium | FT-08-01 External Registration |  |
| 43 | SC-08 Laboratorium | FT-08-02 Order Laboratorium |  |
| 44 | SC-08 Laboratorium | FT-08-03 Charge | - FT-14-05 Master Tarif<br>- FT-01-02 Registrasi Rawat Jalan dan IGD (opt) |
| 45 | SC-08 Laboratorium | FT-08-04 Sample Collection | - FT-08-02 Order Laboratorium |
| 46 | SC-08 Laboratorium | FT-08-05 Result Management | - FT-08-02 Order Laboratorium<br>- FT-08-04 Sample Collection (opt) |
| 47 | SC-08 Laboratorium | FT-08-06 Pakai Barang | - FT-07-05 Pakai Barang (shared) |
| 48 | SC-08 Laboratorium | FT-08-07 Mutasi Barang | - FT-12-02 Mutasi (shared) |
| 49 | SC-08 Laboratorium | FT-08-08 Opname | - FT-12-03 Opname (shared) |

**SC-09 Radiologi**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 50 | SC-09 Radiologi | FT-09-01 Order Radiologi | - FT-01-02 Registrasi Rawat Jalan dan IGD |
| 51 | SC-09 Radiologi | FT-09-02 Scheduling | - FT-09-01 Order Radiologi |
| 52 | SC-09 Radiologi | FT-09-03 Imaging | - FT-09-01 Order Radiologi |
| 53 | SC-09 Radiologi | FT-09-04 Expertise | - FT-09-01 Order Radiologi<br>- FT-09-03 Imaging (opt) |
| 54 | SC-09 Radiologi | FT-09-05 Verification | - FT-09-04 Expertise |
| 55 | SC-09 Radiologi | FT-09-06 Pakai Barang | - FT-07-05 Pakai Barang (shared) |
| 56 | SC-09 Radiologi | FT-09-07 Mutasi Barang | - FT-12-02 Mutasi (shared) |
| 57 | SC-09 Radiologi | FT-09-08 Opname | - FT-12-03 Opname (shared) |

**SC-10 Kamar Operasi**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 58 | SC-10 Kamar Operasi | FT-10-01 Order Operasi | - FT-01-03 Registrasi Rawat Inap<br>- FT-14-01 Master Organisasi |
| 59 | SC-10 Kamar Operasi | FT-10-02 Scheduling | - FT-10-01 Order Operasi |
| 60 | SC-10 Kamar Operasi | FT-10-03 Pre-Operative Clearance | - FT-10-02 Scheduling |
| 61 | SC-10 Kamar Operasi | FT-10-04 Post-Operative Management | - FT-10-03 Pre-Operative Clearance |
| 62 | SC-10 Kamar Operasi | FT-10-05 Pakai Barang | - FT-07-05 Pakai Barang (shared) |
| 63 | SC-10 Kamar Operasi | FT-10-06 Mutasi Barang | - FT-12-02 Mutasi (shared) |
| 64 | SC-10 Kamar Operasi | FT-10-07 Opname | - FT-12-03 Opname (shared) |

**SC-11 Apotek**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 65 | SC-11 Apotek | FT-11-01 Antrian Apotek | - FT-11-02 Telaah Resep |
| 66 | SC-11 Apotek | FT-11-02 Telaah Resep |  |
| 67 | SC-11 Apotek | FT-11-03 Penjualan | - FT-11-01 Antrian Apotek<br>- FT-11-02 Telaah Resep |
| 68 | SC-11 Apotek | FT-11-04 Dispensing | - FT-11-02 Telaah Resep |
| 69 | SC-11 Apotek | FT-11-05 Serah Obat | - FT-11-04 Dispensing |
| 70 | SC-11 Apotek | FT-11-06 Opname | - FT-12-03 Opname (shared) |
| 71 | SC-11 Apotek | FT-11-07 Mutasi | - FT-12-02 Mutasi (shared) |

**SC-12 Gudang**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 72 | SC-12 Gudang | FT-12-01 Terima Barang (DO) | - FT-13-04 Purchase Order |
| 73 | SC-12 Gudang | FT-12-02 Mutasi |  |
| 74 | SC-12 Gudang | FT-12-03 Opname |  |
| 75 | SC-12 Gudang | FT-12-04 Musnah |  |
| 76 | SC-12 Gudang | FT-12-05 Retur Beli |  |

**SC-13 Purchasing**

| No | Screen | Feature | Dependency |
|----|--------|---------|------------|
| 77 | SC-13 Purchasing | FT-13-01 Material Request |  |
| 78 | SC-13 Purchasing | FT-13-02 Forecasting |  |
| 79 | SC-13 Purchasing | FT-13-03 Purchase Request |  |
| 80 | SC-13 Purchasing | FT-13-04 Purchase Order | - FT-13-01 Material Request (opt)<br>- FT-13-03 Purchase Request (opt) |
| 81 | SC-13 Purchasing | FT-13-05 Faktur Tagihan | - FT-13-04 Purchase Order<br>- FT-12-01 Terima Barang (DO) (opt) |