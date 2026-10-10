# OUTCOME: Musnah

| Field       | Value        |
|-------------|--------------|
| Code        | OC-12-04     |
| Version     | 1.2          |
| Status      | Draft        |
| LastUpdated | 2026-10-10   |

---

## 1. Business Purpose

Pembukuan Musnah memastikan barang persediaan yang telah dimusnahkan secara fisik dikeluarkan dari persediaan resmi rumah sakit berdasarkan bukti pemusnahan yang sah.

Outcome ini membentuk fakta bisnis penghapusan persediaan yang akurat, tertelusur, dan dapat dipertanggungjawabkan, serta memastikan barang yang belum benar-benar dimusnahkan tidak terhapus dari saldo persediaan resmi.

---

## 2. Outcome Statement

Transaksi Musnah **telah dibukukan dan disahkan berdasarkan bukti pemusnahan fisik yang sah, sehingga barang yang dimusnahkan resmi dikeluarkan dari persediaan dan saldo persediaan berkurang sesuai jumlah aktual yang disahkan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Inventory (`INV`)** | **Pemilik Utama:** Mengelola pembukuan Musnah atas barang persediaan (`INV-MUSNAH`), pembaruan pengurangan saldo persediaan resmi (`INV-STOK`), serta informasi identitas dan atribut barang (`INV-MASTER`). |
| **Organisasi (`ORG`)** | **Kolaborator Organisasi:** Menyediakan definisi unit kerja dan lokasi penyimpanan barang persediaan yang dimusnahkan (`ORG-LAYANAN`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `INV-MUSNAH` Musnah | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Validasi Otoritatif:** Seluruh Capability di atas telah diverifikasi dan tercatat resmi pada katalog otoritatif (`domain/DOMAIN-CATALOG.md`): `INV-MUSNAH`, `INV-STOK`, dan `INV-MASTER` tercatat pada Domain 11 (Inventory), serta `ORG-LAYANAN` tercatat pada Domain 02 (Organisasi).

---

## 5. Outcome Specification

### 5.1 Required Business Facts

- **Pencatatan Realisasi Fisik (Bukan Izin/Usulan):** Pembukuan Musnah mencatat realisasi pemusnahan fisik yang telah benar-benar terlaksana dan disahkan, bukan sekadar usulan, izin, atau rencana pemusnahan.
- **Berlaku untuk Seluruh Barang Persediaan:** Pemusnahan dapat diberlakukan bagi seluruh kategori barang persediaan (farmasi, BMHP, maupun non-medis) yang tercatat di lokasi penyimpanan resmi rumah sakit.
- **Kuantitas Aktual Sesuai Pengesahan:** Kuantitas barang dalam transaksi Musnah mencerminkan jumlah fisik yang nyata-nyata dimusnahkan dan disahkan pada bukti pemusnahan fisik.
- **Pengurangan Saldo Persediaan Resmi:** Saldo persediaan resmi pada lokasi penyimpanan berkurang tepat sebesar kuantitas yang disahkan dimusnahkan setelah transaksi Musnah dibukukan.
- **Akuntabilitas Status Barang:** Barang yang telah ditetapkan tidak layak pakai dilarang digunakan kembali; barang yang belum selesai dimusnahkan secara fisik tetap dapat dipertanggungjawabkan keberadaan dan statusnya.
- **Kekekalan Transaksi & Audit Trail:** Transaksi Musnah yang telah dibukukan tidak boleh dihapus secara permanen (*hard delete*); setiap koreksi merupakan fakta transaksi baru berotorisasi yang merujuk transaksi asal.

---

### 5.2 Required Recorded Information

- Identitas transaksi Musnah (nomor referensi transaksi Musnah);
- Identitas lokasi penyimpanan (gudang/unit penyimpan barang);
- Tanggal pelaksanaan pemusnahan fisik dan tanggal pembukuan Musnah;
- Identitas pejabat yang mengesahkan pemusnahan serta saksi/pelaksana sesuai tata kelola kategori barang;
- Rujukan dokumen bukti pemusnahan fisik yang sah (misalnya Berita Acara Pemusnahan / BAP);
- Rincian item barang yang dimusnahkan:
  - Identitas dan nama barang persediaan;
  - Satuan ukuran;
  - Kuantitas aktual yang dimusnahkan dan disahkan;
  - Alasan pemusnahan yang sah (kedaluwarsa, rusak, terkontaminasi, dsb.);
  - Nomor batch/lot dan tanggal kedaluwarsa (untuk kategori barang yang mempersyaratkan pelacakan batch dan masa kedaluwarsa);
- Status akhir transaksi Musnah: **Dibukukan** (*Posted* / *Final*);
- Jika terjadi koreksi pasca-pembukuan: identitas transaksi koreksi, referensi transaksi Musnah asal, alasan koreksi, otorisasi koreksi, dan bukti pendukung verifikasi fisik.

---

### 5.3 Required Business Conditions

- Pemusnahan fisik telah selesai dilaksanakan dan didukung bukti pemusnahan yang sah sesuai tata kelola kategori barang;
- Barang yang dimusnahkan tercatat secara sah pada lokasi penyimpanan yang bersangkutan;
- Pengesahan pembukuan dilakukan oleh pejabat yang berwenang atas pengelolaan persediaan.

---

### 5.4 Completion Proof

- Transaksi Musnah berstatus **Dibukukan** (*Posted* / *Final*) dengan rujukan dokumen bukti pemusnahan fisik yang sah;
- Saldo persediaan resmi pada lokasi penyimpanan berkurang tepat sebesar kuantitas aktual yang disahkan dimusnahkan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika dokumen bukti pemusnahan fisik yang sah (seperti Berita Acara Pemusnahan yang telah disahkan pihak berwenang) tersedia untuk diproses dalam pembukuan Musnah ke persediaan resmi.

### End

Berakhir ketika transaksi Musnah disahkan (**Dibukukan** / *Posted*), barang resmi dikeluarkan dari persediaan resmi rumah sakit, dan saldo persediaan pada lokasi penyimpanan berkurang sesuai kuantitas aktual yang disahkan.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Realisasi Fisik Berbasis Bukti Sah:** Pembukuan Musnah adalah pencatatan resmi atas pemusnahan fisik yang telah terlaksana (bukan izin atau usulan pemusnahan). Pembukuan Musnah wajib didukung dokumen bukti pemusnahan fisik yang sah dan kuantitas dalam transaksi Musnah harus tepat mencerminkan jumlah fisik yang nyata-nyata dimusnahkan dan disahkan.
2. **Cakupan Universal dan Tata Kelola Proporsional:** Pemusnahan berlaku untuk seluruh jenis barang persediaan (farmasi, BMHP, maupun logistik non-medis) di lokasi penyimpanan resmi rumah sakit, dengan tata kelola dokumen, saksi, dan otorisasi yang mengikuti aturan bisnis masing-masing kategori barang.
3. **Akuntabilitas Batch dan Kedaluwarsa:** Untuk kategori barang yang dikelola berdasarkan batch dan masa kedaluwarsa (seperti obat dan BMHP), identitas nomor batch dan tanggal kedaluwarsa wajib dicatat dan dapat dipertanggungjawabkan.
4. **Larangan Penggunaan Barang Tidak Layak:** Barang yang telah ditetapkan tidak layak pakai dilarang kembali dialokasikan atau digunakan dalam operasional pelayanan, meskipun proses pembukuannya belum selesai.
5. **Pengurangan Saldo Persediaan Resmi:** Setelah transaksi Musnah dibukukan, saldo persediaan resmi pada lokasi penyimpanan berkurang tepat sebesar kuantitas yang benar-benar dimusnahkan dan disahkan.
6. **Integritas Catatan dan Tata Kelola Koreksi:** Dokumen dan baris transaksi Musnah yang sudah dibukukan tidak boleh dihapus secara permanen (*hard delete*). Koreksi pasca-pembukuan wajib dicatat sebagai fakta transaksi koreksi baru berotorisasi yang merujuk transaksi Musnah asal, serta wajib mencerminkan kondisi fisik sebenarnya:
   - Jika barang fisik terbukti masih ada, stok tidak boleh otomatis dikembalikan ke stok aktif sebelum keberadaan dan kelayakannya diverifikasi secara sah.
   - Jika barang fisik tidak ada namun tidak terbukti dimusnahkan, kondisi tersebut wajib diselesaikan sebagai kehilangan atau selisih persediaan, bukan dengan mengembalikan saldo fiktif ke stok aktif.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Bukti pemusnahan fisik belum ada, tidak lengkap, atau belum disahkan** | Pembukuan Musnah ditolak atau ditahan hingga bukti pemusnahan fisik yang sah dan lengkap tersedia. |
| **Kuantitas fisik yang dimusnahkan berbeda dari usulan awal** | Pembukuan Musnah hanya mencatat kuantitas aktual yang sah dimusnahkan; sisa barang tetap dipertanggungjawabkan pada status persediaan yang sesuai. |
| **Barang tidak tercatat pada lokasi penyimpanan atau saldo tercatat tidak mencukupi saat pembukuan** | Pembukuan Musnah ditahan untuk investigasi fisik dan rekonsiliasi catatan persediaan sebelum transaksi dapat disahkan. |
| **Upaya penghapusan permanen (*hard delete*) atas transaksi Musnah yang sudah dibukukan** | Ditolak. Transaksi Musnah asli wajib dipertahankan; koreksi diproses melalui fakta transaksi koreksi baru. |
| **Pengajuan koreksi tanpa bukti verifikasi fisik riil atau otorisasi berwenang** | Ditolak. Penyesuaian persediaan dilarang dilakukan tanpa bukti verifikasi kondisi fisik riil dan persetujuan pejabat berwenang. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Pembukuan Musnah memvalidasi adanya dokumen bukti pemusnahan fisik yang sah dan pengesahan pihak berwenang sebelum transaksi Musnah dapat dibukukan. | Constraint |
| **AC-02** | Transaksi Musnah mencatat lokasi penyimpanan, identitas barang, kuantitas aktual, alasan pemusnahan, serta nomor batch dan tanggal kedaluwarsa jika relevan. | Completeness |
| **AC-03** | Kuantitas persediaan yang dibukukan dan pengurangan saldo persediaan resmi terbukti tepat sama dengan jumlah aktual yang disahkan pada bukti pemusnahan fisik dalam transaksi Musnah. | Correctness |
| **AC-04** | Barang yang masih dalam tahap usulan atau belum dimusnahkan secara fisik terbukti tidak boleh dibukukan sebagai Musnah; saldo persediaannya tetap tercatat di sistem, sementara larangan penggunaan operasional tetap berlaku. | Constraint |
| **AC-05** | Barang yang telah dinyatakan tidak layak pakai terbukti tidak dapat dialokasikan atau digunakan kembali dalam operasional meskipun pembukuan belum selesai. | Constraint |
| **AC-06** | Transaksi Musnah yang telah dibukukan dilarang di-*hard delete*, dan setiap koreksi terbukti membentuk catatan transaksi baru berotorisasi yang merujuk transaksi Musnah asal serta mencerminkan kondisi fisik riil tanpa menciptakan saldo fiktif. | Correctness |
| **AC-07** | Upaya pembukuan Musnah tanpa bukti sah atau pengajuan koreksi tanpa verifikasi fisik riil dan otorisasi terbukti ditolak oleh sistem. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Mekanisme Fisik Pengamanan & Karantina Barang:** Tata cara penyimpanan sementara, segel pengamanan, atau karantina fisik barang yang menunggu pemusnahan (larangan penggunaan adalah aturan bisnis, sedangkan tata laksana fisik pengamanannya berada di luar batas outcome ini).
- **Proses Pengajuan & Otorisasi Usulan Pemusnahan:** Alur telaah awal usulan pemusnahan, pembentukan panitia/tim pemusnah, dan penetapan izin sebelum pemusnahan fisik dilaksanakan.
- **Tata Cara Teknis Pelaksanaan Pemusnahan Fisik:** Prosedur insinerasi, pembuangan limbah B3, penimbunan, destruksi mekanis, serta kepatuhan keselamatan kerja dan lingkungan hidup.
- **Pencatatan Akuntansi & Jurnal Finansial:** Penghitungan nilai buku kerugian persediaan, alokasi akun beban pemusnahan, dan integrasi penjurnalan akuntansi umum.
- **Investigasi Hukum atas Kehilangan/Kecurangan:** Penyelidikan tindak pidana, tuntutan ganti rugi, atau sanksi administratif atas barang persediaan yang hilang di luar pemusnahan resmi.
- **Detail Desain Teknis & UI:** Skema tabel basis data, spesifikasi API, antarmuka pengguna (UI/UX), mekanisme teknis penyimpanan dokumen digital, serta struktur teknis workflow approval.
