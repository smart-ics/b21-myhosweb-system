# OUTCOME: SampleCollection (Pengambilan Spesimen Laboratorium)

| Field       | Value                      |
|-------------|----------------------------|
| Code        | OC-LAB-SAMPLE-COLLECTION   |
| Version     | 1.0                        |
| Status      | Draft                      |
| LastUpdated | 2026-10-10                 |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, memvalidasi, dan memelihara bukti serah-terima fisik pengambilan materi biologis pasien (*specimen sample record*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan Pengambilan Spesimen Laboratorium memastikan integritas rantai pengawasan (*chain of custody*) dari materi biologis manusia (seperti darah vena, darah arteri, darah kapiler, urine, feses, sputum, cairan serebrospinal, atau cairan tubuh lainnya). Pencatatan ini mendokumentasikan jenis tabung/wadah penampung (*vacutainer*), identitas petugas flebotomi yang melakukan tindakan penusukan/pengambilan, waktu riil pengambilan, serta penilaian awal mengenai kelayakan fisik spesimen (apakah volume mencukupi, tidak membeku pada tabung antikoagulan, dan tidak mengalami hemolisis).

Fakta Pengambilan Spesimen ini merupakan fondasi operasional yang esensial untuk:
1. Menandai bahwa materi fisik pasien telah resmi berada dalam penguasaan instalasi laboratorium untuk dilakukan analisis diagnostik.
2. Mengunci rincian pemeriksaan pada order terkait (*OrderLab* / `LAB-ORDER`) sehingga tidak dapat diubah sembarangan tanpa otorisasi.
3. Memberikan kepastian keselamatan pasien (*patient safety*) bahwa spesimen yang diuji di instrumen analisa benar-benar berasal dari pasien yang tepat melalui identifikasi barcode tabung.
4. Memicu dimulainya penghitungan waktu tunggu pelayanan laboratorium (*Turn Around Time* / TAT).

---

## 2. Outcome Statement

Catatan pengambilan spesimen biologis pasien telah tercatat secara resmi sebagai fakta bisnis persisten (`Specimen Sample Record exists`) dan siap digunakan sebagai materi biologis sah untuk pengujian analisis laboratorium.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Laboratory** (`LAB`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pengelolaan penerimaan, identifikasi spesimen, pemeliharaan status kelayakan sampel (`LAB-COLLECT`), serta menghubungkannya ke order laboratorium terkait. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data identitas demografi dan nomor rekam medis pasien (`PAS-DATSOS`) untuk verifikasi identitas fisik pasien sebelum penusukan/pengambilan. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data petugas flebotomis/analis kesehatan/perawat pelaksana pengambilan spesimen (`ORG-PPA`) serta titik lokasi sampling (`ORG-LAYANAN`). |
| **Pelayanan Klinis** (`RNA` / `RJL` / `IGD`) | **Contributing Domains:** Menyediakan titik lokasi pelayanan fisik tempat flebotomi dilaksanakan (misal di samping tempat tidur bangsal rawat inap / *bedside sampling* atau di bilik triase IGD). |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `LAB-COLLECT` Specimen Collection | Laboratory | Known | **Primary Capability:** Menerima permintaan sampling, memverifikasi jenis tabung, mempersistensi catatan pengambilan spesimen, dan mengelola status kelayakan fisik sampel. |
| `LAB-ORDER` Order Lab | Laboratory | Known | Menyediakan referensi permintaan pemeriksaan laboratorium yang mendasari kebutuhan pengambilan spesimen. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan snapshot identitas pasien guna validasi keselamatan pasien (*positive patient identification*) sebelum sampling. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi petugas flebotomis, analis laboratorium, atau perawat yang berwenang mengambil sampel. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit/ruangan tempat pengambilan spesimen dilaksanakan. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Pengambilan Spesimen Laboratorium (*SampleCollection*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Catatan Pengambilan Spesimen Unik**:
   - Terbentuk satu catatan pengambilan spesimen dengan nomor identifikasi sampel unik (*SampleCollectionId* / *SampleBarcode*) yang sah.
2. **Keterikatan pada Order Laboratorium yang Sah**:
   - Spesimen terikat secara eksplisit pada satu nomor permintaan laboratorium aktif (*OrderLabId* pada `LAB-ORDER`).
3. **Akuntabilitas Petugas Pengambil (Flebotomis)**:
   - Teridentifikasi petugas pengambil spesimen yang terdaftar dan kompeten (`ORG-PPA`).
4. **Verifikasi Identitas Pasien Sesuai Standar Keselamatan**:
   - Konfirmasi identitas pasien fisik telah dilakukan sebelum pengambilan menggunakan minimal dua parameter identifikasi (Nama Lengkap dan Nomor Rekam Medis / Tanggal Lahir).
5. **Kejelasan Spesifikasi Materi Biologis**:
   - Teridentifikasi jenis materi biologis yang diambil (Darah Vena, Darah Arteri, Urine, Feses, Sputum, Cairan Pleura, dsb.).
   - Teridentifikasi jenis tabung vacutainer/wadah penampung (misal: EDTA Ungu, Serum Merah/Kuning, Citrate Biru, Heparin Hijau, Wadah Steril Urine).
   - Pengelompokan tabung mengikuti aturan efisiensi flebotomi: beberapa tes yang memerlukan spesimen dan tabung antikoagulan yang sama dikonsolidasikan dalam satu tabung fisik (*vacutainer grouping rule*).
6. **Kepastian Waktu Pengambilan Riil**:
   - Tercatat tanggal dan jam riil saat spesimen berhasil diambil dari tubuh pasien.
7. **Penilaian Kelayakan Fisik Spesimen**:
   - Spesimen memiliki status penilaian fisik: **Memenuhi Syarat (Adequate/Accepted)** atau **Ditolak (Rejected)** karena ketidaklayakan fisik (lisis, beku pada tabung antikoagulan, volume kurang, wadah rusak).
8. **Status Siklus Hidup Definitif**:
   - Sampel memiliki status definitif: **Diambil (Collected)**, **Diterima di Meja Analis (Received)**, atau **Perlu Pengambilan Ulang (Rejected/Re-collection Required)**.

---

## 5.2 Required Recorded Information

Setiap entitas `SampleCollection` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Sampel & Referensi Order:
- **`SampleCollectionId`**: Identifier unik entitas pencatatan pengambilan spesimen.
- **`SampleBarcode`**: Nomor kode barcode spesimen unik yang dicetak pada label tabung/wadah.
- **`OrderLabId`**: Nomor referensi order laboratorium yang menjadi dasar pengambilan sampel.
- **`OrderNo`**: Nomor transaksi order operasional laboratorium.
- **`RegId`**: Nomor registrasi kunjungan aktif pasien (atau `RegExternalId`).
- **Snapshot Pasien**:
  - Nomor Rekam Medis (`PatientId`).
  - Nama Lengkap Pasien.
  - Jenis Kelamin dan Tanggal Lahir Pasien.

#### B. Rincian Wadah & Spesimen Fisik:
- **Jenis Spesimen**: Tipe materi biologis (Darah Vena, Urine Sewaktu, Sputum Pagi, dsb.).
- **Tipe Wadah / Vacutainer**: Kode dan warna tabung penampung (EDTA, Serum Gel, Citrate, Heparin, Pot Urine Steril).
- **Jumlah Tabung Fisik**: Jumlah tabung/wadah yang berhasil diambil untuk order tersebut.
- **Estimasi Volume**: Keterangan kecukupan volume spesimen (Cukup / Minimal).
- **Daftar Tes yang Terkait dengan Sampel**: Daftar kode dan nama tes laboratorium yang akan diuji menggunakan spesimen ini.

#### C. Waktu & Lokasi Pelaksanaan:
- **Waktu Sampling**: Tanggal dan jam riil saat penusukan vena / penyerahan spesimen berlangsung.
- **Lokasi Sampling**: Unit layanan atau ruangan tempat pengambilan sampel dilakukan (misal: Loket Sampling Lab, Bangsal Mawar Kamar 203, Ruang Resusitasi IGD).
- **Metode Sampling**: Keterangan teknik sampling (Flebotomi Vena, Punksi Arteri, Penampungan Mandiri Pasien, Aspirasi Cairan).

#### D. Akuntabilitas Petugas:
- **Petugas Flebotomi**: Identitas dan nama petugas analis laboratorium atau perawat yang mengambil spesimen.
- **Petugas Penerima (bila berbeda)**: Identitas petugas meja laboratorium yang memverifikasi penerimaan fisik tabung di laboratorium.

#### E. Kualitas Fisik & Status Kelayakan:
- **Status Kelayakan**:
  - `Diterima (Accepted)`: Kualitas fisik spesimen memenuhi standar analisis laboratorium.
  - `Ditolak (Rejected)`: Spesimen tidak memenuhi syarat analitik dan tidak boleh diproses ke instrumen.
- **Kondisi Fisik Khusus (bila ada)**:
  - *Hemolisis*: Tingkat lisis darah (None / Ringan / Berat).
  - *Lipemik*: Tingkat kekeruhan lemak serum.
  - *Ikterik*: Tingkat peningkatan bilirubin fisik.
  - *Bekuan*: Adanya mikrobekuan pada tabung EDTA.
- **Data Penolakan / Sampling Ulang (wajib terisi bila ditolak)**:
  - *Waktu Penolakan*: Tanggal dan jam spesimen dinyatakan ditolak.
  - *Petugas Penolak*: Identitas staf yang menolak sampel.
  - *Alasan Penolakan*: Kategori penolakan (misal: Darah Lisis, Volume Tidak Cukup, Tabung Salah/Tertukar, Darah Membeku, Spesimen Bocor/Rusak).
  - *Instruksi Tindak Lanjut*: Catatan permintaan flebotomi ulang (*Re-collection*).

---

### 5.3 Required Business Conditions

1. **Keabsahan Order Laboratorium**:
   - Order laboratorium yang mendasari pengambilan sampel harus berstatus aktif (`Requested / Ordered`).
   - Order yang berstatus `Deferred` tidak boleh diambil spesimennya sebelum masa penundaan berakhir dan status diaktifkan kembali.
   - Order yang berstatus `Cancelled` dilarang diambil spesimennya.
2. **Kepatuhan Identifikasi Pasien**:
   - Petugas wajib mencocokkan identitas gelang pasien atau konfirmasi verbal pasien dengan data order sebelum melakukan penusukan/pengambilan sampel.
3. **Penerapan Aturan Konsolidasi Tabung (Vacutainer Grouping)**:
   - Jika satu order meminta beberapa pemeriksaan yang menggunakan jenis tabung dan antikoagulan yang sama (misal: Darah Lengkap dan HbA1c sama-sama memerlukan EDTA), sistem mengelompokkan kebutuhan menjadi 1 tabung EDTA fisik, kecuali volume darah yang disyaratkan melebihi kapasitas tabung.
4. **Penguncian Order Pasca-Sampling**:
   - Keberhasilan perekaman `SampleCollection` secara otomatis memicu penguncian item pada `OrderLab` agar rincian pemeriksaan tidak dapat diubah tanpa prosedur pembatalan resmi.
5. **Penolakan Spesimen Non-Destructive**:
   - Penolakan sampel tidak menghapus catatan sampling yang gagal, melainkan mencatat status `Rejected` beserta alasan penolakan dan memicu instruksi penugasan sampling ulang.

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan pengambilan sampel tersimpan persisten dengan identifier unik `SampleCollectionId` dan `SampleBarcode`.
2. Tabung spesimen fisik telah ditempeli label barcode yang memuat minimal: Barcode ID, Nomor RM, Nama Pasien, dan Tanggal Sampling.
3. Status order laboratorium terkait telah berpindah menjadi status spesimen terambil (`Collected / Received`).
4. Catatan sampel tersedia pada daftar kerja meja analitik laboratorium (*testing worklist*) dan siap diproses ke instrumen laboratorium atau dimasukkan hasilnya.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)
- **Dimulai saat:** Petugas flebotomi atau perawat memanggil pasien ke bilik sampling laboratorium atau mendatangi tempat tidur pasien rawat inap/IGD untuk menyiapkan tabung dan memverifikasi identitas pasien.

### 6.2 End Boundary (Titik Akhir)
- **Berakhir saat:** Spesimen berhasil diambil ke dalam wadah penampung, divalidasi kelayakan fisiknya, dicatat waktu dan identitas flebotomisnya, serta tersimpan secara persisten di dalam sistem berstatus `Collected` atau `Received`.

---

## 7. Business Constraints

1. **Prinsip Kepemilikan Tunggal Spesimen terhadap Order**:
   - Setiap catatan `SampleCollection` wajib memiliki relasi yang jelas terhadap tepat satu order laboratorium (`OrderLabId`).
2. **Kemandirian Spesimen terhadap Proses Analisis**:
   - Entitas `SampleCollection` merepresentasikan keberadaan materi fisik sampel, bukan nilai parameter uji. Apabila instrumen analyzer gagal membaca atau hasil tes harus diulang, spesimen fisik yang sama tetap dapat digunakan kembali selama volumenya masih mencukupi.
3. **Integritas Waktu Pengambilan Riil**:
   - Waktu sampling yang dicatat wajib merefleksikan saat penusukan/pengambilan fisik riil, bukan waktu dokter menerbitkan order, karena stabilitas analit biokimia sangat bergantung pada jeda waktu antara sampling dan pengujian.
4. **Larangan Analisis atas Spesimen Ditolak**:
   - Spesimen yang telah ditandai dengan status `Rejected` dilarang digunakan untuk perekaman hasil laboratorium (`LAB-RESULT`).

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Order Belum Selesai Masa Puasa (Deferred)** | Petugas mencoba mencatat pengambilan sampel untuk order yang berstatus `Deferred` (misal syarat puasa belum terpenuhi). | Sistem menolak pencatatan sampling dan memberikan peringatan bahwa order masih dalam masa persiapan medis pasien. |
| **EX-02: Pasien Menolak Flebotomi / Vena Sulit Ditemukan** | Pasien menolak tindakan penusukan darah atau petugas flebotomi gagal memperoleh darah setelah beberapa kali percobaan. | Sistem mencatat status kegagalan sampling dengan keterangan alasan klinis, mengembalikan order ke status menunggu, dan memberi notifikasi ke perawat/dokter penanggung jawab. |
| **EX-03: Kualitas Spesimen Rusak / Lisis / Beku** | Darah yang diambil mengalami lisis berat atau terdapat bekuan fibrin pada tabung antikoagulan saat diverifikasi di lab. | Sistem mengubah status spesimen menjadi `Rejected`, mencatat alasan penolakan secara spesifik, dan memicu notifikasi permintaan pengambilan sampel ulang (*re-sampling*). |
| **EX-04: Volume Spesimen Tidak Mencukupi (QNS — Quantity Not Sufficient)** | Volume darah atau cairan tubuh yang berhasil diambil kurang dari batas minimal yang disyaratkan oleh instrumen analisa. | Petugas menandai status sampel sebagai `Rejected - QNS` atau meminta persetujuan apakah pengujian dapat diprioritaskan hanya untuk parameter yang paling kritis. |
| **EX-05: Tabung Penampung Tertukar / Tidak Sesuai** | Spesimen dimasukkan ke dalam tabung dengan antikoagulan yang keliru (misalnya darah untuk tes hemostasis dimasukkan ke tabung EDTA, bukan Citrate). | Sistem mewajibkan penolakan spesimen dan melarang pemrosesan pengujian dengan tabung yang keliru. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat entitas pengambilan spesimen baru dengan identifier unik `SampleCollectionId` dan `SampleBarcode`, terhubung dengan order laboratorium aktif. | Completeness |
| **AC-02** | Catatan spesimen memuat secara lengkap jenis spesimen biologis, jenis tabung vacutainer, identitas flebotomis, lokasi sampling, serta tanggal dan jam sampling riil. | Correctness |
| **AC-03** | Aturan konsolidasi tabung (*vacutainer grouping*) berhasil menggabungkan beberapa tes dengan persyaratan tabung yang sama menjadi satu kebutuhan tabung penampung terpadu. | Business Rule (Grouping) |
| **AC-04** | Keberhasilan pencatatan `SampleCollection` secara otomatis mengunci item pemeriksaan pada `OrderLab` agar tidak dapat diubah secara bebas. | Business Rule (Locking) |
| **AC-05** | Upaya pencatatan spesimen pada order yang berstatus 'Deferred' atau 'Cancelled' berhasil dicegah dengan peringatan validasi yang informatif. | Exception Handling |
| **AC-06** | Penolakan spesimen karena lisis/beku/volume kurang berhasil dicatat dengan status 'Rejected' disertai alasan penolakan dan memicu penugasan flebotomi ulang. | Exception Handling (Rejection) |
| **AC-07** | Waktu pencatatan sampling riil terekam dengan presisi dan menjadi dasar perhitungan Turn Around Time (TAT) pelayanan laboratorium. | Correctness (TAT Tracking) |
| **AC-08** | Spesimen yang berstatus 'Collected/Received' dapat diakses oleh kapabilitas `LAB-RESULT` sebagai basis materi pengujian analitik. | Integration (Downstream) |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `SampleCollection`:

- **Pengujian Instrumen & Perekaman Angka Hasil:** Proses memasukkan tabung ke mesin analyzer otomatis, pembacaan reagen, dan pencatatan angka hasil uji (merupakan wewenang `LAB-RESULT` / Outcome *HasilLab*).
- **Pengelolaan Reagen & Kontrol Kualitas Alat (QC):** Kalibrasi mesin lab, pencatatan batch reagen, kurva Levey-Jennings, dan maintenance mesin (merupakan modul teknis mesin/LIS).
- **Penerbitan Order Pemeriksaan Laboratorium:** Pemilihan item tes diagnostik oleh dokter DPJP (merupakan wewenang `LAB-ORDER` / Outcome *OrderLab*).
- **Pembebanan Biaya Tindakan Sampling:** Perhitungan tarif jasa flebotomi dan tabung vacutainer pada tagihan pasien (merupakan wewenang `TRK-BILLING` dan `TRK-TARIF`).
