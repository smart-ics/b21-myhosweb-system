# OUTCOME: Pakai Barang

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-05     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Rumah sakit memerlukan pencatatan operasional yang membuktikan bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit.

**Pakai Barang adalah pencatatan bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit.**

Fokus utama outcome ini adalah **terjadinya penggunaan barang**, bukan sekadar barang tersedia, dipindahkan, disimpan, atau dihitung.

Pakai Barang ditetapkan sebagai **Operational Service Event**, bukan Clinical Service Event. Outcome ini memastikan rumah sakit memiliki fakta bisnis yang jelas dan terverifikasi bahwa barang tertentu telah dikonsumsi atau digunakan dalam konteks operasional atau pelayanan rumah sakit. 

Pencatatan ini beroperasi secara mandiri dan implementation-independent, serta memisahkan peristiwa penggunaan fisik barang dari:
1. Pelaksanaan tindakan klinis kepada pasien;
2. Perpindahan fisik logistik antar-unit kerja;
3. Penghitungan fisik persediaan (opname);
4. Konsekuensi downstream pengelolaan persediaan (seperti pengurangan kartu stok gudang, kalkulasi biaya, atau jurnal akuntansi).

---

## 2. Outcome Statement

> Pertanyaan bisnis utama:
> **“Business fact apa yang harus ada setelah Pakai Barang terjadi?”**
>
> Jawaban:
> **Terdapat catatan bahwa suatu barang telah digunakan dalam konteks kegiatan pelayanan atau operasional rumah sakit.**

**Pakai Barang adalah pencatatan bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit.**

Outcome ini merepresentasikan fakta operasional yang dapat diamati (*observable*) dan diverifikasi:
1. Suatu barang yang teridentifikasi telah digunakan/dikonsumsi;
2. Penggunaan tersebut berlangsung dalam konteks kegiatan pelayanan atau operasional rumah sakit;
3. Terdapat catatan operasional yang sah atas peristiwa penggunaan barang tersebut.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Inventory (`INV`) | **Domain Utama (Owner):** Mengelola kapabilitas pencatatan pemakaian barang (`INV-PAKAI`) sebagai pencatatan bahwa barang telah digunakan, serta menyediakan master item barang (`INV-MASTER`) yang sah digunakan di lingkungan rumah sakit. |
| Rawat Inap (`RNA`) | **Operational Context Domain:** Menyediakan konteks operasional lingkungan bangsal rawat inap tempat terjadinya pemakaian barang (khususnya dalam ruang lingkup bangsal rawat inap / SC-06). |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan referensi unit layanan atau ruangan tempat barang digunakan (`ORG-LAYANAN`) serta data petugas atau staf yang menggunakan/mencatat pemakaian barang (`ORG-PPA`). |
| Pasien (`PAS`) | **Supporting / Context Domain (Kondisional):** Menyediakan identitas pasien (`PAS-DATSOS`) apabila barang digunakan dalam konteks pelayanan kepada pasien tertentu. |
| Admission (`ADM`) | **Supporting / Context Domain (Kondisional):** Menyediakan referensi episode pelayanan aktif (`ADM-REG`) apabila pemakaian barang berkaitan langsung dengan episode rawat inap pasien. |

> **Catatan Batasan Domain:**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain dan Capability. Outcome ini tidak mengambil alih kepemilikan atas manajemen pengadaan barang (`PUR`), mutasi perpindahan barang antar-lokasi (`INV-MUTASI`), penghitungan fisik opname (`INV-OPNAME`), tindakan klinis (`OC-06-01`), maupun pembentukan tagihan pasien (`TRK-BILLING`). Domain-domain tersebut berpartisipasi murni sesuai batas tanggung jawab bisnisnya masing-masing.

---

## 4. Participating Capabilities

| Capability | Domain | Status | Konteks Partisipasi |
|------------|--------|--------|---------------------|
| `INV-PAKAI` Pakai Barang | Inventory | Known | Mengelola pencatatan bahwa suatu barang telah digunakan dalam kegiatan rumah sakit. |
| `INV-MASTER` Item Master | Inventory | Known | Menyediakan identitas dan referensi item barang yang sah dan terdaftar di rumah sakit. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit kerja, bangsal, atau ruangan tempat barang digunakan. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi staf atau petugas yang menggunakan atau mencatat pemakaian barang. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas pasien jika pemakaian barang dilakukan untuk asuhan pasien tertentu (kondisional). |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks episode rawat inap aktif jika pemakaian barang terkait dengan episode pelayanan pasien (kondisional). |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Domain Catalog:**
> Seluruh capability yang berpartisipasi berstatus **Known** dan terdaftar dalam Domain Catalog yang berlaku. OC-06-05 tidak mendefinisikan capability baru secara sepihak. Apabila di masa mendatang timbul kebutuhan kapabilitas domain baru di luar Domain Catalog, kebutuhan tersebut wajib dieskalasikan kepada Product Owner untuk persetujuan ruang lingkup (*scope approval*).

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Teridentifikasinya item barang yang digunakan sebagai barang yang sah dalam operasional rumah sakit.
- Teridentifikasinya kuantitas (jumlah) barang yang digunakan.
- Teridentifikasinya unit kerja, bangsal, atau lokasi tempat barang digunakan.
- Teridentifikasinya waktu terjadinya penggunaan barang.
- Teridentifikasinya petugas atau staf yang mencatat/menggunakan barang.
- Terdapat konteks kegiatan yang mendasari penggunaan barang (baik terkait pelayanan pasien tertentu maupun kebutuhan operasional rutin unit tanpa pasien).
- Terdapat catatan operasional yang sah dan dapat diverifikasi bahwa barang tersebut telah digunakan.
- Apabila terjadi koreksi atau pembatalan atas pencatatan pemakaian barang, koreksi tersebut tercatat secara akuntabel tanpa menghapus rekam jejak audit operasional.

### 5.2 Required Recorded Information

Pencatatan Pakai Barang harus dapat membuktikan informasi bisnis inti berikut secara *implementation-independent*:

- **Barang yang Digunakan:** Identifikasi item barang yang dikonsumsi/digunakan.
- **Jumlah Penggunaan:** Besaran atau kuantitas barang yang digunakan.
- **Waktu Penggunaan:** Waktu (tanggal dan/atau jam) penggunaan barang terjadi atau dicatat.
- **Unit / Lokasi Penggunaan:** Unit kerja, bangsal, atau ruangan tempat barang digunakan.
- **Petugas Pencatat / Pengguna:** Identitas petugas atau staf yang menggunakan atau mencatat pemakaian barang.
- **Konteks Kegiatan / Pasien (Kondisional):**
  - Identitas pasien dan/atau episode pelayanan, apabila barang digunakan dalam konteks pelayanan langsung kepada pasien tertentu; **ATAU**
  - Keterangan kegiatan operasional unit, apabila barang digunakan untuk kebutuhan operasional umum unit tanpa terkait pasien tertentu.
- **Keterangan Tambahan (Opsional):** Catatan kontekstual mengenai pemakaian barang (misalnya keperluan khusus atau referensi kegiatan).
- **Informasi Pembatalan / Koreksi (Kondisional):** Alasan bisnis dan akuntabilitas petugas apabila catatan pemakaian barang dibatalkan atau dikoreksi.

### 5.3 Required Business Conditions

- Item barang yang dicatat merupakan barang yang sah dan aktif dalam katalog barang rumah sakit.
- Jumlah barang yang digunakan harus bernilai positif (lebih besar dari nol).
- Waktu penggunaan merupakan waktu yang valid dan tidak berada di masa depan.
- Unit kerja atau lokasi tempat penggunaan barang merupakan unit operasional yang valid.
- Jika penggunaan barang dikaitkan dengan pasien, identitas pasien harus valid dalam sistem rumah sakit.
- Penggunaan barang dapat berdiri sendiri untuk operasional unit tanpa keharusan adanya data pasien.
- Peristiwa pemakaian barang bukan merupakan pemindahan fisik antar-lokasi (bukan mutasi) dan bukan pencocokan stok fisik (bukan opname).

### 5.4 Completion Proof

Outcome ini dinyatakan terpenuhi (*established*) apabila:

- Terdapat rekaman catatan operasional yang sah yang membuktikan bahwa barang tertentu dalam jumlah tertentu telah digunakan pada unit/lokasi dan waktu yang jelas.
- Catatan penggunaan barang dapat diverifikasi oleh pihak berkepentingan (misalnya kepala bangsal, auditor operasional, atau penanggung jawab logistik).
- Keberadaan fakta pemakaian barang bersifat mandiri dan tidak bergantung pada keberhasilan atau waktu penyelesaian proses downstream (seperti mutasi kartu stok, kalkulasi biaya persediaan, maupun pembebanan billing pasien).

---

## 6. Outcome Boundary

### Start

Dimulai ketika barang digunakan dalam kegiatan pelayanan atau operasional rumah sakit.

### End

Berakhir ketika penggunaan barang telah tercatat sebagai fakta operasional yang dapat diverifikasi.

> **Catatan Batasan Boundary:**
> Batasan Pakai Barang tidak diperluas ke aktivitas sebelum atau sesudahnya. Secara tegas, boundary **TIDAK mencakup**:
> - Pengadaan barang (*procurement* / *purchasing*);
> - Penerimaan barang (*receiving* / *delivery order*);
> - Penyimpanan barang di gudang atau depo persediaan;
> - Pemindahan barang antar-lokasi/unit (*mutasi barang*);
> - Penghitungan atau pencocokan fisik persediaan (*stock opname*);
> - Penentuan biaya dan valuasi persediaan (*costing* / *valuation*);
> - Pelaksanaan tindakan klinis (*clinical procedure*).

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Fokus Tunggal pada Penggunaan Barang:**
   Pakai Barang hanya mencatat bahwa suatu barang telah digunakan. Outcome ini tidak mencakup pengelolaan sistem persediaan (*inventory management*) secara keseluruhan, pengadaan, maupun penyimpanan.
2. **Pengurangan Stok Bukan Definisi Utama:**
   Pengurangan persediaan/stok dapat menjadi konsekuensi logistik lanjutan apabila barang tersebut dikelola sebagai item persediaan, namun pengurangan stok bukan merupakan identitas dari Outcome Pakai Barang. Fakta bahwa barang telah digunakan tetap sah terbentuk terlepas dari apakah barang tersebut barang stok, barang non-stok, maupun perlengkapan operasional.
3. **Pasien Bukan Syarat Utama (Kondisionalitas Pasien):**
   Penggunaan barang dapat terkait dengan pelayanan pasien tertentu (misalnya pemakaian bahan medis habis pakai/BMHP saat perawatan pasien), namun dapat juga terjadi untuk kebutuhan operasional rutin unit tanpa pasien tertentu (misalnya cairan pembersih/disinfektan bangsal, form kertas, baterai tensimeter, atau alat tulis operasional). Ketiadaan data pasien tidak membatalkan keabsahan pencatatan Pakai Barang.
4. **Pemisahan Tegas dengan Tindakan (Tindakan ≠ Pakai Barang):**
   Pakai Barang mencatat barang yang digunakan, bukan tindakan klinis yang dilakukan menggunakan barang tersebut. Keduanya merupakan event yang berbeda:
   - Pemberian injeksi → **Tindakan** (`OC-06-01`)
   - Penggunaan 1 buah spuit → **Pakai Barang** (`OC-06-05`)
   Satu tindakan klinis dapat mengonsumsi barang atau tidak mengonsumsi barang, dan pemakaian barang dapat terjadi tanpa ada tindakan klinis.
5. **Pemisahan Tegas dengan Mutasi Barang (Mutasi ≠ Pakai Barang):**
   Perpindahan fisik barang antar lokasi atau unit kerja adalah Mutasi Barang, bukan Pakai Barang:
   - Gudang Logistik → Bangsal Rawat Inap → **Mutasi Barang** (`OC-06-06` / `INV-MUTASI`)
   - Spuit kemudian digunakan dalam pelayanan di Bangsal → **Pakai Barang** (`OC-06-05`)
   Mutasi memindahkan lokasi barang tanpa mengonsumsinya. Pakai Barang menyatakan barang telah selesai dikonsumsi/digunakan.
6. **Pemisahan Tegas dengan Opname (Opname ≠ Pakai Barang):**
   Penghitungan fisik atau pencocokan kondisi stok di lokasi penyimpanan adalah Opname, bukan Pakai Barang:
   - Menghitung jumlah fisik spuit yang tersisa di lemari obat bangsal → **Opname** (`OC-06-07` / `INV-OPNAME`)
   - Mengambil dan menggunakan 1 buah spuit → **Pakai Barang** (`OC-06-05`)
7. **Pengecualian Detail Inventory Tingkat Lanjut:**
   Detail inventori tingkat lanjut seperti nomor batch, tanggal kedaluwarsa (*expiry date*), nomor seri (*serial number*), harga pokok (*costing*), metode valuasi persediaan (FIFO/FEFO/Average), dan jurnal akuntansi persediaan berada di luar batas Outcome ini. Detail tersebut tidak boleh dijadikan syarat wajib pembentukan fakta Pakai Barang kecuali dipersyaratkan oleh capability yang telah disetujui.
8. **Integritas Koreksi / Pembatalan:**
   Pencatatan pemakaian barang yang keliru dapat dibatalkan atau dikoreksi melalui mekanisme bisnis yang sah dengan mencantumkan alasan bisnis. Pembatalan/koreksi tidak boleh menghapus jejak audit bahwa pencatatan pemakaian pernah dilakukan.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Item barang yang digunakan tidak terdaftar atau tidak aktif dalam katalog barang | **Pencatatan ditolak.** Barang yang dicatat harus merupakan item yang dikenal dan sah dalam operasional rumah sakit. |
| Jumlah penggunaan barang bernilai nol atau negatif | **Pencatatan ditolak.** Kuantitas penggunaan barang harus bernilai positif (> 0). |
| Waktu penggunaan berada di masa depan | **Pencatatan ditolak.** Waktu penggunaan harus merepresentasikan kejadian aktual dan tidak boleh mendahului waktu saat ini. |
| Unit layanan atau lokasi penggunaan tidak teridentifikasi | **Pencatatan ditolak.** Unit atau ruangan tempat terjadinya penggunaan barang harus terdefinisi secara sah. |
| Pencatatan pemakaian ditujukan untuk pasien tertentu, namun identitas pasien tidak valid | **Pencatatan ditolak.** Jika konteks penggunaan dispesifikasikan untuk pasien, identitas pasien harus terdaftar sah dalam sistem. |
| Pencatatan pemakaian barang dilakukan untuk operasional unit tanpa pasien | **Kondisi bisnis yang sah (bukan error).** Pencatatan tetap diterima sebagai pemakaian operasional umum unit kerja. |
| Stok administratif barang di unit tercatat nol atau tidak mencukupi saat barang fisik aktual digunakan | **Fakta operasional pemakaian barang tetap dapat dicatat.** Masalah ketidaksesuaian catatan administratif persediaan diselesaikan melalui rekonsiliasi persediaan downstream tanpa menganulir fakta fisik bahwa barang telah digunakan. |
| Terjadi kekeliruan pencatatan pemakaian barang yang telah tersimpan | Pencatatan dapat dibatalkan atau dikoreksi melalui prosedur pembatalan bisnis yang sah dengan menyertakan alasan pembatalan/koreksi. Jejak audit tetap tersimpan. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Pakai Barang telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Terdapat pencatatan operasional yang membuktikan bahwa suatu barang tertentu telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit. | Completeness |
| AC-02 | Informasi inti mencakup identitas barang, jumlah (kuantitas) yang digunakan, unit/lokasi penggunaan, waktu penggunaan, dan petugas pencatat. | Completeness |
| AC-03 | Pencatatan Pakai Barang dapat dilakukan untuk kebutuhan operasional unit tanpa mensyaratkan adanya data pasien. | Correctness |
| AC-04 | Pencatatan Pakai Barang dapat mengaitkan identitas pasien dan/atau episode pelayanan apabila pemakaian barang dilakukan dalam konteks pelayanan pasien tertentu. | Correctness |
| AC-05 | Pencatatan pemakaian barang dilakukan terpisah dan independen dari pencatatan tindakan klinis (Tindakan ≠ Pakai Barang). | Constraint |
| AC-06 | Pencatatan pemakaian barang dibedakan secara tegas dari perpindahan fisik barang antar lokasi/unit (Mutasi ≠ Pakai Barang). | Constraint |
| AC-07 | Pencatatan pemakaian barang dibedakan secara tegas dari penghitungan/verifikasi stok fisik (Opname ≠ Pakai Barang). | Constraint |
| AC-08 | Validitas pembentukan Outcome Pakai Barang tidak mensyaratkan atribut inventory tingkat lanjut (nomor batch, expiry date, serial number, costing, FIFO/FEFO, atau jurnal akuntansi). | Constraint |
| AC-09 | Pembentukan fakta pemakaian barang tidak dibatalkan atau digagalkan oleh kendala penyesuaian persediaan/pengurangan stok downstream. | Constraint |
| AC-10 | Pembatalan atau koreksi atas catatan pemakaian barang mencatat alasan bisnis dan memelihara jejak audit yang dapat ditelusuri. | Correctness |
| AC-11 | Spesifikasi Outcome Pakai Barang dinyatakan secara murni dalam bahasa bisnis yang *implementation-independent* tanpa bergantung pada skema database, API endpoint, antarmuka pengguna (UI), atau tipe data teknis. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Perencanaan kebutuhan material (*Material Request*) dan pengadaan barang → **Purchasing Domain** (`PUR-MATREQ`, `PUR-PO`).
- Penerimaan barang dari pemasok ke gudang/depo (*Delivery Order*) → **Purchasing / Inventory Domain** (`PUR-DO`).
- Pengelolaan master katalog item barang dan pengaturan stok minimum/maksimum → **Inventory Domain** (`INV-MASTER`, `INV-STOK`).
- Pencatatan perpindahan fisik barang antar lokasi, bangsal, atau depo → **OC-06-06 Mutasi Barang** (`INV-MUTASI`).
- Penghitungan fisik, pencocokan stok fisik, dan penyesuaian selisih persediaan → **OC-06-07 Opname** (`INV-OPNAME`).
- Pengelolaan pemusnahan barang rusak atau kedaluwarsa → **Inventory Domain** (`INV-MUSNAH`).
- Pengemasan ulang (*repack*) atau proses produksi internal barang farmasi/logistik → **Inventory Domain** (`INV-REPACK`).
- Penentuan metode valuasi persediaan (FIFO, LIFO, Average), kalkulasi HPP/costing, dan pembentukan jurnal akuntansi persediaan → **Finance / Costing / Accounting Domain**.
- Pelaksanaan dan pendokumentasian tindakan/prosedur klinis kepada pasien → **OC-06-01 Tindakan** (`RNA-TINDAKAN`, `RJL-TINDAKAN`, `IGD-TINDAKAN`).
- Penentuan tarif barang dan pembebanan tagihan barang ke rekening pasien → **OC-02-01 Rincian Tagihan Pasien** (`TRK-BILLING`, `TRK-TARIF`).
- Desain antarmuka pengguna (UI), formulir isian teknis, endpoint API, skema tabel database, atau penetapan tipe data/enum teknis.
