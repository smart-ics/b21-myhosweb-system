# OUTCOME: Pakai Barang

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-05     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Rumah sakit memerlukan pencatatan operasional yang membuktikan bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit.

**Pakai Barang adalah pencatatan bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit.**

Fokus utama outcome ini adalah **terjadinya penggunaan barang**, bukan sekadar barang tersedia, dipindahkan, disimpan, atau dihitung.

Pakai Barang merupakan **Operational Service Event**, bukan Clinical Service Event. Alur sederhananya:

> **Barang digunakan → penggunaan dicatat → menjadi fakta operasional yang dapat diverifikasi.**

Outcome ini berfokus pada fakta bisnis bahwa barang telah digunakan secara nyata dalam kegiatan operasional atau pelayanan rumah sakit, tanpa mengikat spesifikasi teknis manajemen persediaan (*inventory management*), mekanisme pengurangan stok, atau detail teknis sistem.

---

## 2. Outcome Statement

> Pertanyaan bisnis utama:
> **“Business fact apa yang harus ada setelah Pakai Barang terjadi?”**
>
> Jawaban:
> **Terdapat catatan bahwa suatu barang telah digunakan dalam konteks kegiatan pelayanan atau operasional rumah sakit.**

**Pakai Barang adalah pencatatan bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit.**

Outcome ini merepresentasikan fakta operasional bahwa:
1. Suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit;
2. Penggunaan barang tersebut telah dicatat sebagai fakta operasional yang sah dan dapat diverifikasi.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Inventory (`INV`) | **Domain Utama (Owner):** Menyediakan kapabilitas pencatatan pemakaian barang (`INV-PAKAI`) serta referensi item barang (`INV-MASTER`). |
| Rawat Inap (`RNA`) | **Operational Context Domain:** Menyediakan konteks operasional lingkungan bangsal rawat inap tempat penggunaan barang berlangsung (khususnya untuk SC-06). |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan konteks unit layanan tempat barang digunakan (`ORG-LAYANAN`) serta petugas yang mencatat atau menggunakan barang (`ORG-PPA`). |
| Pasien (`PAS`) | **Supporting / Context Domain (Kondisional):** Menyediakan konteks data pasien (`PAS-DATSOS`) apabila penggunaan barang terkait dengan pelayanan pasien tertentu. |
| Admission (`ADM`) | **Supporting / Context Domain (Kondisional):** Menyediakan konteks episode pelayanan (`ADM-REG`) apabila penggunaan barang terkait dengan episode rawat inap pasien. |

> **Catatan Batasan Domain:**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain dan Capability. Outcome ini tidak mengambil alih kepemilikan atas manajemen pengadaan (`PUR`), mutasi perpindahan barang (`INV-MUTASI`), opname persediaan (`INV-OPNAME`), tindakan klinis (`OC-06-01`), maupun billing (`TRK-BILLING`). Domain pendukung berpartisipasi murni sebagai penyedia konteks sesuai kebutuhan.

---

## 4. Participating Capabilities

| Capability | Domain | Status | Konteks Partisipasi |
|------------|--------|--------|---------------------|
| `INV-PAKAI` Pakai Barang | Inventory | Known | Menyediakan kapabilitas pencatatan bahwa suatu barang telah digunakan dalam kegiatan rumah sakit. |
| `INV-MASTER` Item Master | Inventory | Known | Menyediakan referensi identitas item barang yang sah di rumah sakit. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit kerja atau lokasi tempat barang digunakan. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi petugas atau staf yang mencatat atau menggunakan barang. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan konteks identitas pasien apabila penggunaan barang terkait pelayanan pasien tertentu (kondisional). |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks episode rawat inap apabila penggunaan barang terkait episode pelayanan pasien (kondisional). |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Domain Catalog:**
> Seluruh capability yang tercantum berstatus **Known** dan mengacu pada Domain Catalog yang berlaku. OC-06-05 tidak membuat atau mengasumsikan capability baru. Apabila di kemudian hari diperlukan capability tambahan, hal tersebut harus menjadi keputusan Product Owner melalui proses tata kelola yang berlaku.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Fakta Bisnis Utama:**
- Barang yang digunakan teridentifikasi sebagai barang yang sah dalam operasional rumah sakit.
- Kuantitas atau jumlah barang yang digunakan teridentifikasi.
- Terjadinya penggunaan barang telah dicatat sebagai fakta operasional yang dapat diverifikasi.

**Konteks Penggunaan (Sesuai Kebutuhan):**
- Penggunaan barang dapat memuat konteks unit/lokasi, waktu penggunaan, atau petugas yang mencatat/menggunakan.
- Penggunaan barang dapat memuat konteks pasien/episode apabila digunakan untuk pelayanan pasien, atau dicatat tanpa data pasien apabila digunakan untuk operasional unit.

### 5.2 Required Recorded Information

Pencatatan Pakai Barang mencatat informasi bisnis utama:
- **Barang yang Digunakan:** Identitas barang yang digunakan.
- **Jumlah Penggunaan:** Besaran atau kuantitas barang yang digunakan.

**Konteks Penggunaan (Sesuai Kebutuhan):**
- **Waktu Penggunaan:** Waktu terjadinya penggunaan atau pencatatan barang.
- **Unit / Lokasi:** Unit kerja atau ruangan tempat barang digunakan.
- **Petugas:** Petugas atau staf yang menggunakan atau mencatat penggunaan barang.
- **Konteks Pasien / Pelayanan (Kondisional):** Identitas pasien atau episode pelayanan jika penggunaan barang terkait pelayanan pasien tertentu.
- **Keterangan Tambahan (Opsional):** Keterangan operasional mengenai penggunaan barang.

### 5.3 Required Business Conditions

- Barang yang dicatat merupakan barang yang sah dalam operasional rumah sakit.
- Jumlah barang yang digunakan bernilai lebih dari nol (> 0).
- Penggunaan barang dapat dicatat dalam konteks pasien maupun non-pasien.
- Penggunaan barang bukan merupakan perpindahan fisik barang antar-lokasi (bukan mutasi) dan bukan pemeriksaan fisik stok (bukan opname).

### 5.4 Completion Proof

Outcome ini dinyatakan terpenuhi (*established*) apabila:

- Terdapat catatan operasional yang sah bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit.
- Catatan penggunaan barang dapat diverifikasi sebagai fakta operasional.
- Keabsahan catatan penggunaan barang berdiri sendiri dan tidak bergantung pada mekanisme penyesuaian persediaan, costing, atau pembebanan tagihan downstream.

---

## 6. Outcome Boundary

### Start

Barang digunakan dalam kegiatan pelayanan atau operasional rumah sakit.

### End

Penggunaan barang telah dicatat sebagai fakta operasional yang dapat diverifikasi.

> **Catatan Batasan Boundary:**
> Boundary Pakai Barang berfokus pada pencatatan penggunaan barang dan tidak diperluas sampai proses pengurangan stok, costing, accounting, rekonsiliasi, maupun inventory control.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Fokus pada Pencatatan Penggunaan Barang:**
   Pakai Barang hanya mencatat bahwa suatu barang telah digunakan. Outcome ini tidak mencakup pengelolaan sistem persediaan (*inventory management*) secara keseluruhan, pengadaan, maupun penyimpanan.
2. **Pengurangan Stok Bukan Definisi Utama:**
   Pengurangan persediaan/stok dapat menjadi konsekuensi logistik lanjutan dari barang yang dikelola sebagai stok, namun bukan merupakan definisi atau syarat pembentukan Outcome Pakai Barang. Fakta bahwa barang telah digunakan tetap sah tercatat terlepas dari apakah barang tersebut barang stok, non-stok, atau perlengkapan operasional.
3. **Pasien Bukan Syarat Utama (Kondisionalitas Pasien):**
   Penggunaan barang tidak harus terkait pasien:
   - Sarung tangan digunakan untuk pelayanan pasien → dapat terkait pasien;
   - Alat tulis digunakan oleh unit administrasi → tidak terkait pasien;
   - Bahan operasional digunakan oleh unit → tidak terkait pasien.
   Konteks pasien/episode bersifat kondisional dan bukan bagian dari definisi inti Pakai Barang.
4. **Pembedaan Tegas dari Tindakan (Pakai Barang ≠ Tindakan):**
   - **Tindakan** mencatat aktivitas atau tindakan pelayanan klinis yang dilakukan kepada pasien.
   - **Pakai Barang** mencatat barang yang digunakan dalam kegiatan tersebut.
   Contoh: Pemberian injeksi adalah Tindakan (`OC-06-01`), sedangkan penggunaan 1 buah spuit adalah Pakai Barang (`OC-06-05`). Keduanya merupakan event yang berbeda.
5. **Pembedaan Tegas dari Mutasi Barang (Pakai Barang ≠ Mutasi Barang):**
   - **Mutasi Barang** mencatat perpindahan barang dari satu lokasi ke lokasi lain (misalnya Gudang ke Bangsal).
   - **Pakai Barang** mencatat bahwa barang telah digunakan/dikonsumsi di unit tersebut.
6. **Pembedaan Tegas dari Opname (Pakai Barang ≠ Opname):**
   - **Opname** mencatat hasil pemeriksaan atau penghitungan fisik persediaan di suatu lokasi.
   - **Pakai Barang** mencatat peristiwa penggunaan/konsumsi barang.
7. **Pengecualian Detail Inventory Tingkat Lanjut:**
   Detail lanjutan seperti nomor batch, tanggal kedaluwarsa (*expiry date*), nomor seri (*serial number*), harga pokok (*costing*), metode valuasi persediaan (FIFO/FEFO/Average), aturan stok minimum/maksimum, dan jurnal akuntansi persediaan berada di luar batas outcome ini dan bukan merupakan syarat pembentukan fakta Pakai Barang.
8. **Independensi dari Aturan Administratif Stok:**
   Fakta bahwa barang telah digunakan secara fisik tetap sah dicatat sebagai fakta operasional terlepas dari kondisi administratif catatan stok di sistem (misalnya stok administratif tercatat nol atau belum direkonsiliasi).

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Item barang yang digunakan tidak terdaftar atau tidak sah dalam operasional rumah sakit | **Pencatatan ditolak.** Barang yang dicatat harus merupakan item yang dikenal dan sah di rumah sakit. |
| Jumlah penggunaan barang tidak bernilai positif (≤ 0) | **Pencatatan ditolak.** Jumlah barang yang digunakan harus bernilai lebih dari nol. |
| Penggunaan dicatat dalam konteks pasien tertentu, namun identitas pasien tidak valid | **Pencatatan ditolak.** Jika konteks penggunaan dikaitkan dengan pasien, identitas pasien harus sah dalam sistem. |
| Penggunaan dicatat untuk keperluan operasional unit tanpa terkait pasien | **Kondisi bisnis yang sah (bukan error).** Pencatatan tetap sah diterima sebagai pemakaian operasional unit. |
| Status administratif stok di unit tercatat nol atau belum tercatat saat barang fisik aktual digunakan | **Fakta operasional penggunaan barang tetap sah dicatat.** Kesenjangan administratif persediaan diselesaikan pada domain inventory tanpa membatalkan fakta fisik bahwa barang telah digunakan. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Pakai Barang telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Sistem dapat mencatat bahwa suatu barang telah digunakan dalam kegiatan pelayanan atau operasional rumah sakit sebagai fakta operasional yang dapat diverifikasi. | Completeness |
| AC-02 | Penggunaan barang dapat dibedakan dari tindakan klinis (Pakai Barang ≠ Tindakan). | Constraint |
| AC-03 | Penggunaan barang dapat dibedakan dari mutasi barang (Pakai Barang ≠ Mutasi Barang). | Constraint |
| AC-04 | Penggunaan barang dapat dibedakan dari opname (Pakai Barang ≠ Opname). | Constraint |
| AC-05 | Penggunaan barang dapat terjadi dalam konteks pasien maupun non-pasien. | Correctness |
| AC-06 | Keberadaan catatan penggunaan barang bersifat mandiri dan tidak mensyaratkan atribut inventory tingkat lanjut (batch, expired, serial number, costing, FIFO/FEFO, atau jurnal akuntansi). | Constraint |
| AC-07 | Spesifikasi Outcome Pakai Barang tetap *implementation-independent* tanpa bergantung pada skema database, API endpoint, desain antarmuka pengguna (UI), atau mekanisme teknis sistem. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pengadaan barang (*procurement* / *purchasing*).
- Penerimaan barang (*receiving* / *delivery order*).
- Penyimpanan dan pengelolaan penataan persediaan di gudang atau depo.
- Mutasi atau perpindahan fisik barang antar unit/lokasi.
- Pemeriksaan fisik dan penghitungan stok (*stock opname*).
- Costing, valuasi persediaan (FIFO/FEFO/Average), dan jurnal akuntansi persediaan.
- Pelaksanaan dan pendokumentasian tindakan/prosedur klinis kepada pasien.
- Penentuan tarif dan pembebanan tagihan ke billing pasien.
- Desain antarmuka pengguna (UI), formulir isian teknis, API endpoint, atau skema tabel database.
