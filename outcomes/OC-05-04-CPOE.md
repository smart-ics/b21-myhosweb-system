# OUTCOME: Computerized Provider Order Entry (CPOE)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-04     |
| Version     | 1.2          |
| Status      | Review       |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Setiap kebutuhan diagnostik, terapi, intervensi medis, maupun konsultasi penunjang pasien yang diputuskan dalam proses pelayanan rawat jalan memerlukan penerjemahan dari intensi klinis (*clinical intent*) menjadi instruksi resmi yang terotorisasi (*authorized prospective clinical instruction*).

Kapabilitas **Computerized Provider Order Entry (CPOE)** menyediakan mekanisme terstandardisasi bagi Petugas Pemberi Asuhan (PPA) untuk menyusun, mengesahkan, dan merutekan instruksi klinis ke unit kerja pelaksana (*Destination* seperti Laboratorium, Radiologi, Apotek, dan Kamar Operasi), serta memantau status pemenuhannya secara terkoordinasi dan akuntabel.

Sebagai fakta bisnis yang terpersistensi, Clinical Order merepresentasikan rencana instruksi prospektif dan **bukan** bukti pelaksanaan maupun pembebanan biaya (*Order ≠ Charge*). Kelayakan pembebanan biaya (*Charge Eligibility*) hanya timbul dari fakta pemenuhan aktual yang disahkan oleh unit pelaksana dan diteruskan ke domain Tata Rekening.

---

## 2. Outcome Statement

Satu atau lebih *Clinical Order* yang merepresentasikan *clinical intent* atas kebutuhan pelayanan pasien **telah disahkan secara sah oleh Petugas Pemberi Asuhan (PPA) yang berwenang, dirutekan ke unit kerja pelaksana (*Destination*), dapat ditelusuri status pemenuhannya secara akuntabel, dan ditutup setelah seluruh tanggung jawab koordinasi klinis selesai**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Jalan | **Domain pemilik konteks layanan**: inisiasi kebutuhan klinis, penyusunan draf order (*authoring*), otorisasi medis (`RJL-KONSUL`), dan peninjauan ringkasan status pemenuhan. |
| Laboratory | Unit pelaksana (*Destination*) untuk order pemeriksaan spesimen dan laboratorium klinik (`LAB-ORDER`). |
| Radiology | Unit pelaksana (*Destination*) untuk order pemeriksaan pencitraan dan radiodiagnostik (`RAD-ORDER`). |
| Apotek | Unit pelaksana (*Destination*) untuk order peresepan obat, farmasi klinis, dan BMHP (`APT-RESEP`). |
| Kamar Operasi | Unit pelaksana (*Destination*) untuk penjadwalan dan persiapan prosedur pembedahan (`KMO-ORDER`). |
| Admission | Memelihara keabsahan kunjungan aktif (*Visit*) pasien tempat order diterbitkan (`ADM-REG`, `ADM-TRACKER`). |
| Organisasi | Menyediakan master unit kerja layanan (`ORG-LAYANAN`) dan data kewenangan klinis PPA (`ORG-PPA`). |
| Pasien | Menyediakan data identitas sah pasien (Nomor RM dan data sosial) yang menjadi subjek instruksi (`PAS-DATSOS`). |
| Tata Rekening | Mengonsumsi fakta pemenuhan aktual yang layak dibebankan (*Charge Eligibility*) dari unit pelaksana untuk pembentukan tagihan pasien (`TRK-BILLING`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `CPOE-ORDER` Pengelolaan Clinical Order | Cross-Domain | Capability Candidate |
| `RJL-KONSUL` Konsultasi | Rawat Jalan | Known |
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `RAD-ORDER` Order Radiologi | Radiology | Known |
| `APT-RESEP` Resep | Apotek | Known |
| `KMO-ORDER` Order Operasi | Kamar Operasi | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Hakikat Clinical Order:** Clinical Order merupakan representasi instruksi klinis prospektif terstruktur yang terikat pada satu identitas pasien (No. RM) dan satu registrasi kunjungan aktif (*Visit*).
- **Pemisahan Order dan Biaya (*Order ≠ Charge*):** Pembuatan draf, otorisasi, pengiriman, penerimaan, maupun persiapan order tidak membentuk beban tagihan finansial. Kelayakan biaya (*Charge Eligibility*) hanya sah timbul dari eksekusi pemenuhan aktual di unit pelaksana.
- **Pemisahan Peran Author dan Authorizer:** Identitas penyusun instruksi (*Order Author*) dan pengambil tanggung jawab medikolegal formal (*Order Authorizer*) dicatat sebagai entitas terpisah, meskipun dilakukan oleh individu yang sama.
- **Siklus Hidup Terstandarisasi:** Clinical Order bergerak melalui tahapan: **Draft → Authorized → Dispatched → Accepted → In Fulfilment → Fulfilled → Closed**, serta status terminal/pengecualian (**Rejected**, **Cancelled**, **Discontinued**, **Not Fulfilled**, **Entered in Error**).
- **Pembedaan Status Penerimaan vs Pemenuhan:** Status penerimaan dan persiapan (*Accepted*, *In Fulfilment*) tidak sama dengan status *Fulfilled*. Status *Fulfilled* mensyaratkan keterpenuhan kriteria penyelesaian objektif (*Completion Criterion*) dari kategori order terkait.
- **Kedaulatan Unit Pelaksana (*Destination Sovereignty*):** Unit pelaksana (Lab, Radiologi, Apotek, Kamar Operasi) berdaulat penuh atas alur kerja teknis internalnya. CPOE mengoordinasikan instruksi dan memelihara ringkasan status pemenuhan (*Fulfilment Summary*).
- **Isolasi Dampak Klarifikasi (*Impact Isolation*):** Unit pelaksana berhak menerima (*Accept*), menolak (*Reject*), atau meminta klarifikasi (*Request Clarification*). Penangguhan order (*On Hold*) akibat klarifikasi tidak boleh menahan item order lain milik pasien yang tidak berkaitan secara klinis.
- **Integritas Pengendalian Perubahan:** Perubahan pasca-otorisasi dicatat sebagai *Amendment* dengan riwayat instruksi awal tetap utuh. Pembatalan (*Cancel*) hanya sah sebelum pengerjaan fisik dimulai; jika pengerjaan telah berjalan, dilakukan penghentian (*Discontinue*).
- **Kemandirian Koordinasi Klinis:** Penutupan status order menjadi **Closed** menandai tuntasnya koordinasi klinis CPOE dan berdiri sendiri, tidak bergantung pada siklus penagihan atau pembayaran kasir di Tata Rekening.

### 5.2 Required Recorded Information

**Konteks Pasien & Kunjungan:**
- Nomor Registrasi Kunjungan (*Visit ID*) yang aktif.
- Nomor Rekam Medis (No. RM) dan nama pasien.
- Poliklinik/unit rawat jalan asal pembuat order (*Origin Service Unit*).

**Atribut Instruksi Klinis:**
- Kategori order (*Order Type*: Lab, Radiologi, Resep/Farmasi, Kamar Operasi, Prosedur/Konsul).
- Rincian item dan parameter instruksi klinis.
- Indikasi klinis / catatan pertimbangan medis pemesanan.
- Skala prioritas (Rutin, Urgent, Cito/Stat).
- Waktu dan jadwal permintaan pelaksanaan.
- Relasi paket klinis (*Order Set*, bila berlaku).

**Akuntabilitas & Otorisasi:**
- Identitas pembuat draf (*Order Author*).
- Identitas pengesah medikolegal (*Order Authorizer*).
- Tanggal dan waktu otorisasi sah.
- Penanggung jawab klinis aktif (*Responsible Clinician / DPJP*).

**Perutean, Status, & Ringkasan Pemenuhan:**
- Unit kerja pelaksana tujuan (*Destination*).
- Status siklus hidup terkini (*Order Lifecycle Status*).
- Keputusan penerimaan (*Accept*, *Reject* dengan alasan, atau *Request Clarification*).
- Riwayat perubahan (*Amendment*, *Cancellation*, atau *Discontinuation*).
- Ringkasan pemenuhan (*Fulfilment Summary*), waktu penyelesaian, dan tautan referensi hasil resmi/rekam medis.

### 5.3 Required Business Conditions

- Kunjungan rawat jalan pasien berstatus aktif dalam pengelolaan Admission (`ADM-REG`).
- Authorizer memiliki kewenangan klinis (*clinical privileges*) yang sah sesuai kategori order yang disahkan (`ORG-PPA`).
- Unit pelaksana tujuan (*Destination*) aktif dan berwenang melayani kategori order terkait (`ORG-LAYANAN`).
- Instruksi klinis memenuhi parameter minimal yang diwajibkan oleh definisi order (termasuk indikasi klinis bila disyaratkan).
- Otorisasi susulan pada instruksi verbal/darurat (*Exceptional Order*) diselesaikan dalam batas periode kebijakan rumah sakit tanpa pemalsuan waktu (*no backdating*).

### 5.4 Completion Proof

- Clinical Order tersimpan secara persisten dengan nomor identifikasi unik terhubung ke *Visit* aktif dan data pasien.
- Seluruh kriteria penyelesaian (*Completion Criterion*) kategori order terpenuhi dan tercatat dalam *Fulfilment Summary*, atau order mencapai status terminasi sah (*Rejected*, *Cancelled*, *Discontinued*, *Not Fulfilled*, *Entered in Error*).
- Tautan referensi hasil resmi (*Result Reference*) atau dokumentasi pelaksanaan tersedia di unit pelaksana / EMR.
- Status koordinasi klinis order tercatat sebagai **Closed**.
- Kelayakan pembebanan biaya (*Charge Eligibility*) atas pemenuhan aktual telah diteruskan ke domain Tata Rekening (bila terdapat porsi layanan yang terlaksana).

---

## 6. Outcome Boundary

### Start

Dimulai ketika Petugas Pemberi Asuhan (PPA) mengidentifikasi kebutuhan klinis pasien di poliklinik dan menginisiasi penyusunan instruksi prospektif (*clinical intent*), atau ketika instruksi verbal/darurat diberikan pada situasi klinis mendesak.

### End

Berakhir ketika Clinical Order mencapai status akhir:
- Berstatus **Closed** setelah pemenuhan terkonfirmasi, kriteria penyelesaian terpenuhi, tautan hasil terbentuk, dan tanggung jawab koordinasi klinis tuntas; ATAU
- Berstatus akhir melalui terminasi sah (**Rejected**, **Cancelled**, **Discontinued**, **Not Fulfilled**, atau **Entered in Error**) dengan alasan pertanggungjawaban tercatat permanen.

> **Batasan Penting:** Penutupan koordinasi klinis CPOE (*Closed*) berdiri sendiri dan **TIDAK** bergantung pada penyelesaian transaksi penagihan atau pembayaran kasir di Tata Rekening.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Clinical Order Bukan Bukti Pelaksanaan:** Clinical Order adalah instruksi klinis prospektif, bukan bukti bahwa prosedur/layanan medis telah dilaksanakan.
- **Order Bukan Biaya (Order ≠ Charge):** Pembuatan draf, otorisasi, pengiriman, penerimaan, maupun persiapan order tidak membentuk beban tagihan finansial. Biaya hanya dapat muncul dari fakta pemenuhan aktual di unit pelaksana.
- **Pemisahan Penulis dan Pengesah:** Identitas pembuat draf (*Order Author*) dan pengesah (*Order Authorizer*) dicatat secara terpisah guna menjamin akuntabilitas medikolegal formal.
- **Kedaulatan Domain Pelaksana:** Domain pelaksana khusus (Lab, Radiologi, Apotek, Kamar Operasi) berdaulat penuh atas alur kerja teknis internalnya. CPOE hanya mengoordinasikan instruksi dan memantau ringkasan pemenuhan.
- **Pembedaan Status Fulfilled:** Status penerimaan atau persiapan (*Accepted*, *In Fulfilment*) tidak boleh disamakan dengan status *Fulfilled*. Status *Fulfilled* wajib memenuhi kriteria penyelesaian objektif (*Completion Criterion*).
- **Isolasi Dampak Klarifikasi:** Penangguhan order (*On Hold*) akibat permintaan klarifikasi hanya berlaku pada item order terkait dan dilarang menahan order lain milik pasien yang tidak berkaitan secara klinis.
- **Pengendalian Perubahan Pasca-Otorisasi:** Instruksi yang telah diotorisasi tidak dapat diedit langsung; perubahan dicatat sebagai *Amendment*. Pembatalan (*Cancel*) hanya sah sebelum pengerjaan fisik dimulai.
- **Imutabilitas Riwayat Keputusan:** Riwayat instruksi yang telah disahkan, penolakan, amandemen, dan catatan pembatalan bersifat permanen dan tidak boleh dihapus fisik dari sistem.
- **Integritas Kronologi Waktu:** Kronologi waktu pada order verbal/darurat wajib mencerminkan waktu nyata tanpa pemalsuan (*no backdating*). Otorisasi susulan wajib diselesaikan sesuai batas waktu kebijakan rumah sakit.
- **Kemandirian Siklus Koordinasi dari Billing:** Penutupan koordinasi CPOE (*Closed*) tidak bergantung pada penyelesaian siklus verifikasi tagihan maupun pembayaran kasir di Tata Rekening.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or encounters an exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Registrasi kunjungan (*Visit*) pasien tidak aktif atau telah ditutup | Penyusunan dan otorisasi Clinical Order ditolak. |
| Pengesah tidak memiliki kewenangan klinis (*clinical privileges*) untuk kategori order terkait | Otorisasi ditolak; instruksi dialihkan kepada klinisi yang berwenang. |
| Order ditolak oleh unit kerja tujuan (*Destination*) | Status order menjadi **Rejected** disertai alasan penolakan; pemenuhan dihentikan tanpa menghasilkan beban biaya. |
| Unit kerja tujuan meminta klarifikasi atas keselamatan atau kelengkapan klinis | Status order menjadi **On Hold for Clarification**; pengerjaan ditunda hingga klarifikasi tuntas tanpa menahan order lain yang tidak berkaitan. |
| Pemesan membatalkan order sebelum pelaksanaan fisik dimulai | Status order menjadi **Cancelled**; koordinasi di unit tujuan dihentikan tanpa beban biaya. |
| Pembatalan diajukan saat pelaksanaan fisik telah berjalan di unit tujuan | Pembatalan otomatis ditolak; penghentian dialihkan ke mekanisme penghentian klinis (**Discontinued**) atau penyesuaian porsi pemenuhan. |
| Terapi atau tindakan serial dihentikan di tengah jalan | Status order menjadi **Discontinued**; pelaksanaan yang telah lewat tetap sah, jadwal pelaksanaan masa depan dibatalkan. |
| Teridentifikasi kesalahan mendasar pasca-otorisasi (salah pasien/salah perutean) | Status order menjadi **Entered in Error** dengan alasan lengkap; order dinonaktifkan tanpa menghapus riwayat audit data asli. |
| Otorisasi susulan instruksi verbal/darurat melampaui batas waktu kebijakan RS | Order ditandai membutuhkan perhatian kepatuhan klinis (*compliance alert*) dan dilaporkan untuk audit medikolegal. |
| Pelaksanaan fisik gagal akibat kendala klinis atau penolakan pasien | Status order menjadi **Not Fulfilled** disertai catatan kendala; kelayakan biaya hanya berlaku atas porsi persiapan yang sah menurut kebijakan rumah sakit. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Clinical Order berhasil dicatat dengan struktur lengkap: identitas pasien, konteks kunjungan aktif, kategori order, instruksi klinis, prioritas, jadwal permintaan, Author, Authorizer, Destination, dan penanggung jawab aktif. | Completeness |
| AC-02 | Pembuatan draf, otorisasi, perutean, penerimaan, maupun persiapan order tidak membentuk kelayakan biaya (*Charge Eligibility*) pada Tata Rekening. | Constraint |
| AC-03 | Sistem mencatat dan membedakan identitas pembuat draf (*Order Author*) dan pengesah (*Order Authorizer*) sebagai dua entitas peran yang mandiri. | Correctness |
| AC-04 | Clinical Order bertransisi mengikuti siklus hidup yang sah (**Draft → Authorized → Dispatched → Accepted → In Fulfilment → Fulfilled → Closed**), di mana status persiapan/penerimaan tidak disamakan dengan `Fulfilled`. | Correctness |
| AC-05 | Unit tujuan (*Destination*) dapat menerima (*Accept*), menolak (*Reject* disertai alasan), atau meminta klarifikasi (*Request Clarification*), di mana penangguhan klarifikasi hanya mengisolasi order terkait tanpa menahan order lain. | Completeness |
| AC-06 | Perubahan terhadap instruksi yang telah diotorisasi terekam sebagai *Amendment* dengan mempertahankan riwayat instruksi awal, alasan perubahan, dan otorisasi perubahan. | Constraint |
| AC-07 | Perekaman instruksi verbal/darurat mempertahankan kronologi waktu nyata tanpa *backdating*, serta mencatat otorisasi susulan dalam batas waktu kebijakan yang berlaku. | Constraint |
| AC-08 | Upaya pembatalan setelah pelaksanaan fisik dimulai di unit tujuan ditolak oleh sistem dan dialihkan ke mekanisme *Discontinuation*. | Exception |
| AC-09 | Status `Closed` dicapai setelah seluruh kriteria penyelesaian koordinasi klinis CPOE terpenuhi, tanpa bergantung pada penyelesaian siklus penagihan di Tata Rekening. | Constraint |
| AC-10 | Kelayakan pembebanan biaya (*Charge Eligibility*) hanya diteruskan ke domain Tata Rekening berdasarkan fakta pemenuhan aktual yang dilaporkan oleh unit pelaksana. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Alur Kerja Teknis Internal Unit Pelaksana:** Kalibrasi instrumen laboratorium, manajemen reagen, pengaturan radiasi mesin pencitraan, sterilisasi instrumen operasi, dan teknik peracikan obat → Domain pelaksana terkait (`LAB-*`, `RAD-*`, `KMO-*`, `APT-*`).
- **Penyimpanan Dokumentasi Medis Otoritatif (EMR):** Penyimpanan narasi ekspertise diagnostik lengkap, arsip citra radiologi DICOM, grafik hasil laboratorium, dan resume medis CPPT → Domain Penunjang Terkait dan Rekam Medis Elektronik (EMR).
- **Laporan Dokumentasi Pembedahan Resmi:** Penyusunan laporan operasi lengkap, laporan anestesi, dan *surgical safety checklist* → Domain Kamar Operasi (`KMO-OPR`) dan EMR.
- **Pencatatan Tindakan Rawat Jalan Langsung:** Pencatatan prosedur/tindakan klinis yang langsung diselesaikan di ruang periksa poli tanpa melalui order penunjang → **OC-05-02 Tindakan Rawat Jalan** (`RJL-TINDAKAN`).
- **Rujukan Pasien Antar-Dokter/Poli:** Pengalihan pelayanan medis pasien ke dokter tujuan lain pada hari yang sama → **OC-05-03 Rujuk Internal** (`RJL-TRANSFER`).
- **Konfigurasi Tarif dan Aturan Pembebanan Biaya:** Penetapan besaran tarif layanan, matriks penjaminan asuransi, dan finalisasi episode tagihan → Tata Rekening (`TRK-TARIF`, `TRK-BILLING`, `TRK-JAMINAN`).
- **Penerimaan Pembayaran Kasir:** Pembayaran biaya pemeriksaan/resep dan cetak kuitansi di loket kasir → Kasir (`TRK-KASIR`, `TRK-PAYMENT`).
- **Manajemen Persediaan dan Stok Fisik:** Pengurangan saldo stok obat/BMHP di depo/gudang, nomor batch, dan kedaluwarsa → Domain Inventory (`INV-*`) dan Apotek (`APT-*`).
- **Pelayanan Keperawatan Rutin:** Tindakan asuhan keperawatan mandiri reguler di ruang rawat → Ruang lingkup keperawatan bangsal (`RNA-*`).
