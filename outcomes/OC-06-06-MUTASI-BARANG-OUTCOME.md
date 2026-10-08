# OUTCOME: Mutasi Barang

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-06     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Rumah sakit mengelola persediaan dan barang yang terdistribusi di berbagai unit kerja, bangsal rawat inap, instalasi, maupun lokasi penyimpanan internal. Untuk menjaga ketertiban operasional dan keterlacakan aliran barang di lingkungan internal rumah sakit, diperlukan pencatatan resmi setiap kali terjadi perpindahan barang dari satu lokasi atau unit ke lokasi atau unit lainnya.

**Mutasi Barang adalah pencatatan perpindahan barang/persediaan yang berada dalam pengelolaan rumah sakit dari satu lokasi atau unit asal ke lokasi atau unit tujuan.**

Fokus utama outcome ini adalah **terjadinya perpindahan internal barang**, dengan prinsip utama:

> **Barang tercatat berpindah dari asal ke tujuan dengan jumlah dan waktu perpindahan yang dapat ditelusuri.**

Mutasi Barang merupakan **Operational Service Event** (peristiwa operasional perpindahan fisik/logistik internal), bukan Clinical Service Event. Alur sederhananya:

> **Barang berpindah dari asal ke tujuan → perpindahan dicatat → menjadi fakta operasional yang dapat ditelusuri.**

Outcome ini dirancang secara **pragmatis, operasional, sederhana, dan tidak terlalu detail**, serta bersifat reusable untuk konteks bangsal rawat inap (SC-06) maupun unit layanan/logistik lainnya di lingkungan rumah sakit yang memiliki kebutuhan perpindahan barang.

---

## 2. Outcome Statement

> Pertanyaan bisnis utama:
> **“Business fact apa yang harus ada setelah Mutasi Barang terjadi?”**
>
> Jawaban:
> **Terdapat catatan bahwa barang/persediaan yang berada dalam pengelolaan rumah sakit telah berpindah dari satu lokasi atau unit asal ke lokasi atau unit tujuan dengan jumlah dan waktu perpindahan yang dapat ditelusuri.**

**Mutasi Barang adalah pencatatan perpindahan barang/persediaan yang berada dalam pengelolaan rumah sakit dari satu lokasi atau unit asal ke lokasi atau unit tujuan.**

Outcome ini merepresentasikan fakta operasional bahwa:
1. Barang/persediaan yang berada dalam pengelolaan rumah sakit berpindah dari lokasi atau unit asal ke lokasi atau unit tujuan;
2. Perpindahan barang tersebut telah dicatat sebagai fakta operasional yang sah, memuat kuantitas barang dan waktu perpindahan yang dapat ditelusuri (fokus: *barang berpindah dari mana → ke mana*).

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Inventory (`INV`) | **Domain Utama (Owner):** Menyediakan kapabilitas pencatatan perpindahan barang/persediaan (`INV-MUTASI`) serta referensi item barang (`INV-MASTER`). |
| Rawat Inap (`RNA`) | **Operational Context Domain:** Menyediakan konteks operasional lingkungan bangsal rawat inap sebagai salah satu unit asal atau unit tujuan perpindahan barang (khususnya untuk SC-06). |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan referensi unit layanan atau lokasi penyimpanan asal dan tujuan perpindahan barang (`ORG-LAYANAN`), serta petugas yang mencatat atau melakukan serah terima perpindahan (`ORG-PPA`). |

> **Catatan Batasan Domain:**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain dan Capability. Outcome ini tidak mengambil alih kepemilikan atas manajemen pengadaan (`PUR`), pemakaian barang (`INV-PAKAI`), opname persediaan (`INV-OPNAME`), pemusnahan barang (`INV-MUSNAH`), tindakan klinis (`OC-06-01`), maupun billing (`TRK-BILLING`). Domain pendukung berpartisipasi murni sebagai penyedia konteks lokasi/unit dan petugas transaksi.

---

## 4. Participating Capabilities

| Capability | Domain | Status | Konteks Partisipasi |
|------------|--------|--------|---------------------|
| `INV-MUTASI` Mutasi | Inventory | Known | Menyediakan kapabilitas pencatatan bahwa barang/persediaan telah berpindah dari satu lokasi/unit ke lokasi/unit lainnya di internal rumah sakit. |
| `INV-MASTER` Item Master | Inventory | Known | Menyediakan referensi identitas item barang/persediaan yang sah di rumah sakit. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit kerja, bangsal, instalasi, atau lokasi penyimpanan asal dan tujuan mutasi barang. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi staf atau petugas operasional yang mencatat atau melakukan serah terima perpindahan barang (sebagai data pendukung transaksi). |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Domain Catalog:**
> Seluruh capability yang tercantum berstatus **Known** dan mengacu pada Domain Catalog yang berlaku. OC-06-06 tidak membuat atau mengasumsikan capability baru. Apabila di kemudian hari diperlukan capability tambahan, hal tersebut harus menjadi keputusan Product Owner melalui proses tata kelola yang berlaku.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Fakta Bisnis Utama:**
- Barang yang dipindahkan teridentifikasi sebagai barang yang sah dalam pengelolaan rumah sakit.
- Lokasi atau unit asal barang teridentifikasi.
- Lokasi atau unit tujuan barang teridentifikasi.
- Lokasi/unit asal dan lokasi/unit tujuan merupakan entitas lokasi/unit yang berbeda.
- Kuantitas atau jumlah barang yang dipindahkan teridentifikasi dan bernilai positif (> 0).
- Waktu terjadinya atau pencatatan perpindahan barang teridentifikasi.
- Terjadinya perpindahan barang dari asal ke tujuan telah dicatat sebagai fakta operasional yang dapat ditelusuri.

### 5.2 Required Recorded Information

Pencatatan Mutasi Barang mencatat informasi bisnis utama:
- **Barang yang Dipindahkan:** Identitas barang/persediaan yang dipindahkan.
- **Lokasi / Unit Asal:** Identitas lokasi atau unit pengirim barang (asal).
- **Lokasi / Unit Tujuan:** Identitas lokasi atau unit penerima barang (tujuan).
- **Jumlah Perpindahan:** Besaran atau kuantitas barang yang dipindahkan (> 0).
- **Waktu Perpindahan:** Waktu terjadinya perpindahan atau pencatatan mutasi barang.

**Informasi Pendukung Transaksi (Sesuai Kebutuhan Operasional):**
- **Petugas:** Identitas petugas/staf yang menyerahkan, menerima, atau mencatat mutasi barang (sebagai data pendukung transaksi, bukan objek utama manajemen kepemilikan aset).
- **Keterangan Tambahan (Opsional):** Catatan operasional terkait perpindahan barang jika diperlukan.

### 5.3 Required Business Conditions

- Barang yang dipindahkan berada dalam pengelolaan internal rumah sakit.
- Lokasi/unit asal dan lokasi/unit tujuan merupakan lokasi/unit yang valid di lingkungan rumah sakit.
- Lokasi/unit asal tidak boleh sama dengan lokasi/unit tujuan (asal ≠ tujuan).
- Jumlah barang yang dipindahkan bernilai lebih dari nol (> 0).
- Waktu perpindahan merupakan waktu yang sah dan tidak berada di masa depan.
- Perpindahan barang merupakan perpindahan internal dalam pengelolaan rumah sakit, bukan pengeluaran permanen (bukan pemusnahan) dan bukan konsumsi (bukan pakai barang).

### 5.4 Completion Proof

Outcome ini dinyatakan terpenuhi (*established*) apabila:

- Terdapat catatan operasional yang sah bahwa barang/persediaan telah berpindah dari satu lokasi atau unit asal ke lokasi atau unit tujuan.
- Jumlah barang dan waktu perpindahan dapat ditelusuri secara jelas.
- Catatan mutasi barang dapat diverifikasi sebagai fakta operasional yang mandiri.
- Keabsahan catatan perpindahan barang berdiri sendiri dan tidak bergantung pada detail inventori tingkat lanjut seperti batch/lot, expiry date, harga/nilai barang, stock valuation, FIFO/FEFO, alur approval berjenjang, atau jurnal akuntansi downstream.

---

## 6. Outcome Boundary

### Start

Terjadinya inisiasi atau pelaksanaan perpindahan fisik barang/persediaan dari satu lokasi atau unit asal menuju lokasi atau unit tujuan di internal rumah sakit.

### End

Perpindahan barang dari lokasi/unit asal ke lokasi/unit tujuan telah dicatat sebagai fakta operasional yang sah dan dapat ditelusuri.

> **Catatan Batasan Boundary:**
> Boundary Mutasi Barang berfokus pada pencatatan perpindahan fisik/logistik internal barang (dari mana → ke mana). Boundary tidak diperluas sampai pada proses pengadaan dari supplier, penerimaan faktur, pemakaian klinis, audit aset tetap, penyesuaian nilai persediaan, maupun pembukuan akuntansi.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Fokus pada Perpindahan Internal:** Mutasi Barang hanya mencakup perpindahan internal barang/persediaan yang sudah berada dalam pengelolaan rumah sakit.
   - Contoh cakupan yang sah:
     - Gudang → Bangsal Rawat Inap
     - Unit A → Unit B
     - Lokasi penyimpanan A → Lokasi penyimpanan B
     - Gudang Farmasi → Unit pelayanan
2. **Lokasi Asal dan Tujuan Berbeda:** Lokasi/unit asal dan lokasi/unit tujuan perpindahan harus berbeda (asal ≠ tujuan). Pergerakan di dalam lokasi/rak yang sama tanpa perpindahan unit/lokasi bukan merupakan Mutasi Barang.
3. **Keterlacakan Aliran Barang:** Pencatatan harus menjamin keterlacakan mengenai barang apa yang berpindah, dari mana asal perpindahan, ke mana tujuan perpindahan, berapa banyak jumlahnya, dan kapan perpindahan terjadi.
4. **Mutasi Barang Berbeda dari Pakai Barang (Mutasi Barang ≠ Pakai Barang):**
   - **Mutasi Barang** mencatat perpindahan barang antar lokasi/unit internal.
   - **Pakai Barang** (`OC-06-05`) mencatat barang yang digunakan/dikonsumsi dalam aktivitas pelayanan atau operasional.
   - Mutasi tidak berarti barang sudah digunakan atau dikonsumsi.
5. **Mutasi Barang Berbeda dari Pengadaan Barang (Mutasi Barang ≠ Pengadaan Barang):**
   - **Pengadaan Barang** (`PUR`) adalah proses perencanaan dan pemesanan untuk memperoleh atau membeli barang dari luar/supplier.
   - **Mutasi Barang** adalah perpindahan internal barang yang sudah berada dalam pengelolaan rumah sakit.
6. **Mutasi Barang Berbeda dari Penerimaan Barang (Mutasi Barang ≠ Penerimaan Barang):**
   - **Penerimaan Barang** (`PUR-DO`) mencatat barang pertama kali diterima dari pihak ketiga/supplier ke dalam rumah sakit.
   - **Mutasi Barang** mencatat perpindahan antar lokasi/unit internal setelah barang berada dalam pengelolaan rumah sakit.
7. **Mutasi Barang Berbeda dari Penghapusan/Pemusnahan (Mutasi Barang ≠ Penghapusan/Musnah):**
   - **Mutasi Barang** tetap mempertahankan barang di dalam pengelolaan rumah sakit (hanya berpindah lokasi/unit).
   - **Penghapusan/Musnah** (`INV-MUSNAH`) mengeluarkan barang dari pengelolaan rumah sakit karena rusak, kedaluwarsa, atau dimusnahkan.
8. **Tidak Diperluas Menjadi Asset Management:**
   - Mutasi Barang bukan merupakan pencatatan perubahan kepemilikan aset hukum atau audit aset tetap.
   - Istilah atau konsep "penanggung jawab" tidak dijadikan objek utama outcome.
   - Identitas staf yang menyerahkan/menerima atau petugas pencatat cukup diperlakukan sebagai data pendukung transaksi logistik.
9. **Kemandirian dari Detail Implementasi dan Akuntansi:**
   - Atribut seperti *batch/lot*, *expiry date*, harga/nilai barang, *stock valuation*, jurnal akuntansi, metode *FIFO/FEFO*, *approval* bertingkat, audit aset, dan nomor dokumen berformat kompleks tidak boleh menjadi syarat wajib pembentukan outcome. Detail tersebut merupakan concern teknis atau domain lanjutan dan tidak boleh memperluas definisi outcome.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk.

| Exception | Expected Behavior |
|-----------|-------------------|
| Barang tidak valid atau tidak terdaftar dalam pengelolaan rumah sakit | **Pencatatan ditolak.** Hanya barang yang sah dalam pengelolaan rumah sakit yang dapat dimutasikan. |
| Lokasi/unit asal atau tujuan tidak valid dalam operasional rumah sakit | **Pencatatan ditolak.** Lokasi/unit asal dan tujuan harus teridentifikasi secara sah. |
| Lokasi asal sama dengan lokasi tujuan (asal = tujuan) | **Pencatatan ditolak.** Mutasi barang mensyaratkan perpindahan antar lokasi atau unit yang berbeda. |
| Jumlah perpindahan tidak valid atau nonpositif (≤ 0) | **Pencatatan ditolak.** Kuantitas barang yang dipindahkan harus bernilai positif (> 0). |
| Waktu perpindahan berada di masa depan | **Pencatatan ditolak.** Waktu perpindahan harus mencerminkan waktu aktual atau waktu lampau yang sah. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Mutasi Barang telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Sistem dapat mencatat perpindahan barang/persediaan dari satu lokasi/unit asal ke lokasi/unit tujuan dengan kuantitas dan waktu perpindahan yang dapat ditelusuri sebagai fakta operasional. | Completeness |
| AC-02 | Lokasi/unit asal dan lokasi/unit tujuan teridentifikasi secara jelas dan merupakan entitas yang berbeda. | Correctness |
| AC-03 | Perpindahan barang dapat dibedakan secara tegas dari pemakaian barang (Mutasi Barang ≠ Pakai Barang). | Constraint |
| AC-04 | Perpindahan barang dapat dibedakan secara tegas dari pengadaan barang dan penerimaan supplier (Mutasi Barang ≠ Pengadaan / Penerimaan). | Constraint |
| AC-05 | Perpindahan barang dapat dibedakan secara tegas dari pemusnahan atau penghapusan barang (Mutasi Barang ≠ Musnah). | Constraint |
| AC-06 | Mutasi barang berfokus pada perpindahan internal barang dan tidak diperluas menjadi sistem manajemen kepemilikan aset (Asset Management). | Constraint |
| AC-07 | Keberadaan catatan mutasi barang bersifat mandiri dan tidak mensyaratkan atribut teknis atau inventori lanjutan (batch/lot, expiry date, harga/nilai barang, stock valuation, jurnal akuntansi, FIFO/FEFO, approval berjenjang, atau nomor dokumen kompleks). | Constraint |
| AC-08 | Spesifikasi Outcome Mutasi Barang tetap *implementation-independent* tanpa bergantung pada skema database, API endpoint, tata letak antarmuka pengguna (UI), atau mekanisme teknis sistem. | Correctness |
| AC-09 | Outcome Mutasi Barang bersifat operasional, sederhana, dan reusable untuk konteks bangsal rawat inap (SC-06) maupun unit layanan/logistik rumah sakit lainnya. | Completeness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pengadaan barang dari supplier atau pihak eksternal (`PUR-PO`).
- Penerimaan barang pertama kali dari supplier (`PUR-DO`).
- Penggunaan atau konsumsi barang dalam pelayanan klinis atau operasional unit (`OC-06-05 Pakai Barang` / `INV-PAKAI`).
- Penghapusan, pembuangan, atau pemusnahan barang dari pengelolaan rumah sakit (`INV-MUSNAH`).
- Pemeriksaan fisik dan rekonsiliasi jumlah persediaan (*stock opname* / `INV-OPNAME`).
- Pengelolaan kepemilikan aset tetap (*fixed asset management*), depresiasi/penyusutan aset, dan audit aset.
- Valuasi nilai persediaan (*stock valuation*), perhitungan harga pokok (FIFO/FEFO/Average), dan pembukuan jurnal akuntansi keuangan.
- Mekanisme alur otorisasi persetujuan (*multi-level approval workflow*) yang kompleks.
- Skema tabel database, endpoint API, format penomoran dokumen internal sistem, dan rancangan antarmuka pengguna (UI).
