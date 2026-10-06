# OUTCOME: Tindakan Rawat Jalan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-02     |
| Version     | 1.2          |
| Status      | Review       |
| LastUpdated | 2026-10-05   |

---

## 1. Business Purpose

Setiap prosedur atau intervensi klinis (*clinical procedure/intervention*) yang telah selesai dilaksanakan kepada pasien di poliklinik rawat jalan memerlukan pencatatan resmi sebagai *persisted business fact* agar diakui secara operasional dan dapat dibebankan secara finansial ke dalam tagihan pelayanan pasien.

Pencatatan ini menjembatani pelaksanaan pelayanan klinis rawat jalan dengan proses tata rekening rumah sakit tanpa mencampurkan fungsi dokumentasi medis (*EMR/Electronic Medical Record*) maupun fungsi penagihan kasir.

Tanpa adanya *service/billing record* yang sah dan terverifikasi, tindakan yang telah diberikan berisiko tidak tertagih (*revenue leakage*), tidak dapat dipertanggungjawabkan akuntabilitas pelaksanaannya, atau menimbulkan sengketa dalam penagihan pasien.

---

## 2. Outcome Statement

Satu *service/billing record* atas prosedur klinis yang telah selesai dilaksanakan kepada pasien di lingkungan rawat jalan **telah tercatat secara sah, terhubung ke identitas pasien dan registrasi aktif sumbernya, serta siap dikonsumsi oleh proses billing**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Jalan | **Pemilik utama outcome**: mencatat dan mengelola *service/billing record* atas tindakan klinis yang dilaksanakan di poliklinik rawat jalan (`RJL-TINDAKAN`), serta menerbitkan order/rujukan ke unit pelaksana lain bila diperlukan (`RJL-TRANSFER`). |
| Tata Rekening | Menyediakan master tarif tindakan yang berlaku (`TRK-TARIF`), serta mengonsumsi *service/billing record* ke dalam rincian tagihan pasien (`TRK-BILLING`). |
| Admission | Memelihara keabsahan kunjungan/registrasi aktif yang menjadi wadah episode pelayanan tempat tindakan dicatat (`ADM-REG`). |
| Pasien | Menyediakan data identitas resmi pasien (Nomor Rekam Medis dan data sosial) yang menjadi subjek penerima tindakan (`PAS-DATSOS`). |
| Organisasi | Menyediakan referensi unit/lokasi pelayanan (`ORG-LAYANAN`) dan data tenaga kesehatan pelaksana (`ORG-PPA`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `RJL-TINDAKAN` Tindakan Klinis | Rawat Jalan | Known |
| `RJL-TRANSFER` Rujukan Internal | Rawat Jalan | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

### 5.1 Required Business Facts

- Prosedur atau intervensi klinis telah selesai dilaksanakan secara nyata (*executed*) kepada pasien di unit rawat jalan. Instruksi atau rencana yang belum dieksekusi berstatus **Order Tindakan** dan belum sah menjadi Tindakan.
- Record Tindakan merepresentasikan data administratif dan pembebanan finansial (*service/billing record*), bukan dokumentasi rekam medis (*clinical documentation/EMR*).
- Setiap Tindakan terikat secara tidak ambigu pada satu identitas Pasien (Nomor RM) dan satu Registrasi Kunjungan sumber yang aktif. Bila berasal dari pemenuhan order, referensi order asalnya tercatat.
- Status pelaksanaan tindakan (**Selesai Dilaksanakan**, **Dibatalkan**) terpisah secara tegas dari status pembebanan biaya (*charge_status*). Status tindakan tidak menggunakan status `Final` milik episode billing.
- Record Tindakan memiliki *charge_status* yang sah (**Ready to Bill**, **Pending Tariff**, **Billed**, **Charge Reversed**). Jika tarif belum tersedia pada saat pencatatan, record tetap dipersistensikan dengan status `Pending Tariff` dan konsumsi billing ditangguhkan hingga tarif dilengkapi.

---

### 5.2 Required Recorded Information

**Identitas Pasien & Registrasi Sumber:**
- Nomor Rekam Medis (No. RM) dan Nama Pasien.
- Nomor Registrasi / Kunjungan rawat jalan aktif tempat tindakan dilakukan.
- Referensi identitas *Order Tindakan* asal (jika tindakan berawal dari pemenuhan order).

**Data Layanan & Konteks Pelaksanaan:**
- Nama tindakan dan kode layanan (*service code*) sesuai master layanan rumah sakit.
- Kode referensi ICD-9-CM (opsional, jika tersedia pada master layanan).
- Unit atau lokasi layanan rawat jalan tempat tindakan dilaksanakan.
- Petugas pelaksana / *performer* (opsional, jika dicatat perorangan).
- Waktu pelaksanaan tindakan (tanggal dan waktu selesai).

**Status & Data Finansial:**
- Status pelaksanaan tindakan: `Selesai Dilaksanakan` atau `Dibatalkan`.
- Nilai tarif tindakan yang berlaku (tarif satuan dan total nominal), jika telah ditentukan.
- Status pembebanan biaya (*charge_status*):
  - `Ready to Bill` — tarif tersedia, siap dikonsumsi billing.
  - `Pending Tariff` — tarif belum tersedia pada saat pencatatan; konsumsi billing ditangguhkan hingga tarif diselesaikan di Tata Rekening.
  - `Billed` — record telah dikonsumsi ke dalam rincian tagihan pasien oleh `TRK-BILLING`.
  - `Charge Reversed` — pembebanan biaya dibatalkan secara administratif atas tindakan yang telah dilaksanakan.

---

### 5.3 Required Business Conditions

- Pasien terdaftar secara sah (`PAS-DATSOS`) dan registrasi kunjungan sumber berstatus aktif (`ADM-REG`).
- Layanan tindakan terdaftar dalam master layanan rumah sakit yang aktif.
- Prosedur klinis harus sudah selesai dilaksanakan sebelum pencatatan dilakukan.
- Ketiadaan tarif pada saat pencatatan tidak membatalkan penyimpanan record tindakan; record disimpan dengan `charge_status: Pending Tariff`.
- Registrasi kunjungan sumber belum memiliki episode tagihan yang berstatus `Final` di Tata Rekening.

---

### 5.4 Completion Proof

- Record Tindakan tersimpan secara persisten dengan nomor identifikasi unik serta terhubung ke Nomor Registrasi dan Nomor RM pasien.
- Seluruh atribut wajib minimal tercatat lengkap: nama tindakan, kode layanan, unit layanan, waktu pelaksanaan, status pelaksanaan, dan *charge_status*.
- Status pelaksanaan tindakan terverifikasi sebagai `Selesai Dilaksanakan` (atau `Dibatalkan` dengan *audit trail* permanen bila terjadi pembatalan entri).
- *Charge_status* bernilai sah (`Ready to Bill` siap dikonsumsi billing, atau `Pending Tariff` menunggu penyelesaian tarif).

---

## 6. Outcome Boundary

### Start

Dimulai ketika prosedur atau intervensi klinis telah selesai dilaksanakan secara nyata kepada pasien di unit rawat jalan, dan peristiwa pelaksanaan tersebut siap dicatat sebagai representasi layanan.

### End

Berakhir ketika *service/billing record* atas tindakan tersebut telah berhasil disimpan secara persisten dengan status pelaksanaan sah dan *charge_status* yang valid (`Ready to Bill` atau `Pending Tariff`), terhubung ke registrasi pasien.

> **Batasan Penting:** Jika record yang telah tersimpan terbukti merupakan kesalahan entri administratif (seperti salah pasien atau duplikasi pencatatan), record diakhiri dengan status pelaksanaan **Dibatalkan** disertai *audit trail* permanen tanpa menghapus data fisik.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Bukan Dokumen Rekam Medis:** Record Tindakan murni merupakan representasi administratif dan finansial (*service/billing record*). Outcome ini dilarang menghasilkan *clinical documentation* (lembar CPPT, laporan operasi, asesmen SOAP) yang merupakan yurisdiksi EMR.
- **Keharusan Pelaksanaan Nyata:** Pencatatan Tindakan hanya sah dilakukan setelah prosedur klinis selesai dilaksanakan. Permintaan atau rencana pra-pelaksanaan berstatus *Order Tindakan* dan dilarang menghasilkan *service/billing record*.
- **Kedaulatan Unit Pelaksana:** Tindakan yang dilaksanakan oleh unit penunjang (Laboratorium, Radiologi, Kamar Operasi, Gawat Darurat, Apotek) wajib dicatat dan dibebankan oleh domain unit pelaksana masing-masing. Rawat Jalan hanya berwenang menerbitkan order/rujukan (`RJL-TRANSFER`) dan dilarang mencatat tindakan atas pekerjaan unit lain.
- **Pemisahan Status Pelaksanaan dan Charge Status:** Status pelaksanaan tindakan berdiri sendiri dan terpisah dari *charge_status*. Status tindakan dilarang menggunakan status `Final` milik episode billing (OC-02-01).
- **Mekanisme Koreksi Pasca-Pencatatan:**
  - *Pembatalan Record (Status: Dibatalkan):* Diterapkan jika record terbukti merupakan kesalahan entri administratif (salah pasien/salah layanan); record dinonaktifkan dengan *audit trail* permanen.
  - *Charge Reversal (`charge_status: Charge Reversed`):* Diterapkan jika tindakan memang terlaksana namun pembebanan biayanya harus dibatalkan/dikoreksi (misal tarif salah atau duplikasi tagihan); status pelaksanaan tetap `Selesai Dilaksanakan`.
- **Tarif Non-Blocking:** Ketidaktersediaan tarif pada saat pencatatan tidak boleh membatalkan penyimpanan fakta pelayanan. Record wajib tetap dicatat dengan `charge_status: Pending Tariff`. Blokir hanya berlaku pada konsumsi billing, bukan pada pencatatan record.
- **Performer dan ICD-9-CM Bersifat Opsional:** Ketiadaan data tenaga pelaksana (*performer*) maupun kode ICD-9-CM pada master layanan tidak boleh membatalkan atau memblokir pencatatan tindakan.
- **Integritas Episode Tagihan:** Pencatatan tindakan baru hanya dapat dikaitkan dengan registrasi yang episode tagihannya belum berstatus `Final` di Tata Rekening.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or encounters an exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Prosedur klinis belum dilaksanakan (masih berupa rencana/permintaan) | Pencatatan Tindakan ditolak. Objek tetap berstatus *Order Tindakan*. Tidak ada *service/billing record* yang diterbitkan. |
| Order Tindakan dibatalkan sebelum prosedur dilaksanakan | Pembatalan diproses pada tingkat order. Tidak ada *service/billing record* yang diterbitkan. |
| Permintaan pencatatan tindakan di Rawat Jalan atas pekerjaan unit penunjang (Lab/Rad/Kamar Operasi/Apotek/IGD) | Pencatatan Tindakan ditolak di Rawat Jalan. Unit Rawat Jalan hanya membuat Order Pemeriksaan atau Rujukan Internal (`RJL-TRANSFER`). Pembebanan biaya dicatat oleh unit pelaksana masing-masing. |
| Pasien tidak terdaftar atau Registrasi kunjungan sumber tidak aktif/batal | Pencatatan Tindakan ditolak. Seluruh tindakan wajib terhubung dengan registrasi kunjungan yang sah dan aktif. |
| Layanan tindakan tidak ditemukan dalam master layanan aktif | Pencatatan Tindakan ditolak. Layanan harus terdaftar dalam master layanan rumah sakit. |
| Tarif belum dikonfigurasi untuk kombinasi layanan, kelas, dan jaminan pasien | Record Tindakan **tetap dicatat** dengan `charge_status: Pending Tariff`. Konsumsi oleh `TRK-BILLING` diblokir hingga konfigurasi tarif dilengkapi di `TRK-TARIF`. |
| Data performer (*pelaksana*) tidak diisi | Pencatatan Tindakan tetap dilanjutkan dan disahkan. Performer bersifat opsional. |
| Kode ICD-9-CM belum terpetakan pada master tindakan rumah sakit | Pencatatan Tindakan tetap diproses menggunakan kode layanan internal rumah sakit. |
| Record Tindakan yang telah dicatat terbukti merupakan kesalahan entri administratif | Record diubah status pelaksanaannya menjadi **Dibatalkan** dengan *audit trail* permanen. Tidak ada *service/billing record* aktif yang tersisa. |
| Pembebanan biaya atas tindakan yang nyata dilaksanakan harus dibatalkan/dikoreksi | `charge_status` diubah menjadi **Charge Reversed**. Status pelaksanaan tindakan tetap `Selesai Dilaksanakan` dengan *audit trail* lengkap. |
| Episode tagihan pasien di Tata Rekening telah berstatus `Final` (OC-02-01) | Pencatatan Tindakan baru pada registrasi tersebut ditolak secara mutlak. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Sistem berhasil mencatat tepat satu *service/billing record* atas tindakan klinis yang telah selesai dilakukan kepada pasien di unit rawat jalan. | Completeness |
| AC-02 | Prosedur klinis yang belum dilaksanakan hanya tersimpan sebagai *Order Tindakan* dan tidak menghasilkan *service/billing record*. | Constraint |
| AC-03 | Pencatatan Tindakan berhasil memuat secara lengkap: nama tindakan, kode layanan, unit/lokasi layanan, waktu pelaksanaan, status pelaksanaan, dan *charge_status*. | Completeness |
| AC-04 | Pencatatan Tindakan berhasil dipersistensikan meskipun data performer (*pelaksana*) tidak diisi. | Completeness |
| AC-05 | Setiap record Tindakan yang tersimpan dapat ditelusuri secara tepat ke Nomor Rekam Medis pasien dan Nomor Registrasi kunjungan sumbernya. | Correctness |
| AC-06 | Record Tindakan tidak memuat dokumen rekam medis/EMR (seperti asesmen medis, temuan klinis, SOAP, atau CPPT). | Constraint |
| AC-07 | Pencatatan tindakan atas pekerjaan yang dikerjakan oleh unit penunjang (Lab, Radiologi, Kamar Operasi, Apotek, IGD) ditolak di Rawat Jalan; pencatatan hanya dapat dilakukan oleh unit pelaksana masing-masing. | Constraint |
| AC-08 | Tindakan dapat dicatat secara sah menggunakan kode layanan internal rumah sakit tanpa kewajiban adanya kode ICD-9-CM. | Correctness |
| AC-09 | Status pelaksanaan tindakan dan *charge_status* tersimpan sebagai dua atribut status yang independen dan terpisah. | Correctness |
| AC-10 | Status Tindakan tidak menggunakan status `Final` milik episode billing OC-02-01. | Constraint |
| AC-11 | Record Tindakan dengan `charge_status: Ready to Bill` dapat dibaca dan dikonsumsi oleh kapabilitas `TRK-BILLING` untuk pembentukan rincian tagihan pasien. | Correctness |
| AC-12 | Ketika tarif tidak tersedia, record Tindakan tetap dicatat dengan `charge_status: Pending Tariff` dan konsumsi oleh `TRK-BILLING` diblokir hingga tarif diselesaikan. | Exception |
| AC-13 | Pencatatan Tindakan ditolak jika registrasi pasien tidak aktif atau master layanan tidak ditemukan. | Exception |
| AC-14 | Pembatalan entri administratif atas record Tindakan mengubah status pelaksanaan menjadi `Dibatalkan` dengan *audit trail* permanen tanpa menghapus data fisik. | Exception |
| AC-15 | Pembatalan pembebanan biaya atas tindakan yang nyata terlaksana mengubah `charge_status` menjadi `Charge Reversed` tanpa mengubah status pelaksanaan (`Selesai Dilaksanakan`). | Exception |
| AC-16 | Pencatatan Tindakan baru ditolak jika episode tagihan registrasi terkait di Tata Rekening telah berstatus `Final`. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Dokumentasi Klinis dan Rekam Medis:** Pencatatan temuan klinis, asesmen dokter, lembar informed consent, catatan perkembangan pasien terintegrasi (CPPT), SOAP, dan resume medis → Domain Rekam Medis / EMR (di luar lingkup sistem ini).
- **Pengelolaan Order Tindakan dan CPOE Pra-Pelaksanaan:** Penerbitan instruksi pemeriksaan, resep, atau order tindakan sebelum tindakan dilakukan → Kapabilitas `RJL-TRANSFER` dan kapabilitas order masing-masing domain pelaksana (*future outcome candidate*).
- **Proses Penagihan, Konsolidasi, dan Finalisasi Billing Episode:** Penggabungan seluruh billing registrasi ke dalam episode tagihan, verifikasi rincian tagihan, dan penetapan status tagihan menjadi `Final` → **OC-02-01 Rincian Tagihan Pasien** (Tata Rekening).
- **Proses Pembayaran, Kasir, dan Alokasi Pembayaran:** Penerimaan pembayaran kasir, pencetakan kuitansi/invoice, alokasi pembayaran ke item tindakan, dan pelunasan piutang → **OC-02-02 Alokasi Pembayaran** dan **OC-03-01 Kasir**.
- **Pencatatan Tindakan di Unit Rawat Inap:** Tindakan yang dilaksanakan selama perawatan di bangsal rawat inap → Rawat Inap Domain (`RNA-*`, *future outcome candidate*).
- **Pencatatan Tindakan di Gawat Darurat:** Tindakan yang dilaksanakan di IGD → Gawat Darurat Domain (`IGD-TINDAKAN`, *future outcome candidate*).
- **Pencatatan Pemeriksaan dan Layanan Laboratorium:** Pemeriksaan spesimen dan pencatatan hasil laboratorium → Laboratory Domain (`LAB-COLLECT`, `LAB-RESULT`, *future outcome candidate*).
- **Pencatatan Pemeriksaan Radiologi:** Pemeriksaan radiologi dan akuisisi citra → Radiology Domain (`RAD-EXAM`, `RAD-EXPERTISE`, *future outcome candidate*).
- **Pencatatan Prosedur Kamar Operasi:** Tindakan pembedahan dan prosedur perioperatif → Kamar Operasi Domain (`KMO-OPR`, `KMO-RECOVERY`, *future outcome candidate*).
- **Pengelolaan Obat dan Barang Habis Pakai (BMHP):** Pemakaian obat, alat, dan BMHP yang digunakan selama tindakan → Inventory Domain (`INV-PAKAI`, *future outcome candidate*).
- **Pemeliharaan Master Layanan, Master Tarif, dan Aturan Jaminan:** Konfigurasi master tarif rumah sakit, matriks kelas, dan master jaminan → Tata Rekening Domain (`TRK-TARIF`, `TRK-JAMINAN`).
- **Pengkodean Klaim dan Grouping BPJS:** Penetapan diagnosis utama/sekunder dan grouping INA-CBGs untuk penagihan klaim BPJS → Berkas Rekam Medis Domain (`BRM-CODING`) dan BPJS Domain (`BPJ-EKLAIM`).
