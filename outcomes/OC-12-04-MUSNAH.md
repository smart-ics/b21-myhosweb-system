# OUTCOME: Musnah

| Field       | Value        |
|-------------|--------------|
| Code        | OC-12-04     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-10   |

---

## 1. Business Purpose

Pencatatan Musnah memastikan barang persediaan yang telah dimusnahkan secara fisik dikeluarkan dari persediaan resmi rumah sakit berdasarkan bukti pemusnahan yang sah.

Outcome ini membentuk fakta bisnis penghapusan persediaan yang akurat, tertelusur, dan dapat dipertanggungjawabkan, serta memastikan barang yang belum benar-benar dimusnahkan tidak terhapus dari saldo persediaan resmi.

---

## 2. Outcome Statement

Catatan realisasi pemusnahan persediaan **telah disahkan berdasarkan bukti pemusnahan fisik yang sah, sehingga barang yang dimusnahkan resmi dikeluarkan dari persediaan dan saldo persediaan berkurang sesuai jumlah aktual yang disahkan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Inventory (`INV`)** | **Pemilik Utama:** Mengelola pencatatan realisasi pemusnahan barang persediaan (`INV-MUSNAH`), pembaruan pengurangan saldo persediaan resmi (`INV-STOK`), serta informasi identitas dan atribut barang (`INV-MASTER`). |
| **Organisasi (`ORG`)** | **Kolaborator Organisasi:** Menyediakan definisi unit kerja dan lokasi penyimpanan barang persediaan yang dimusnahkan (`ORG-LAYANAN`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `INV-MUSNAH` Musnah | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

### 5.1 Required Business Facts

- **Pencatatan Realisasi Fisik (Bukan Izin/Usulan):** Pembukuan Musnah mencatat realisasi pemusnahan fisik yang telah benar-benar terlaksana dan disahkan, bukan sekadar persetujuan usulan, izin pemusnahan, atau rencana pemusnahan.
- **Berlaku untuk Seluruh Barang Persediaan:** Pemusnahan dapat diberlakukan bagi seluruh kategori barang persediaan (farmasi, BMHP, maupun barang non-medis) yang tercatat di lokasi penyimpanan resmi rumah sakit.
- **Kuantitas Aktual Sesuai Pengesahan:** Kuantitas barang yang dibukukan musnah mencerminkan jumlah fisik yang nyata-nyata dimusnahkan dan disahkan pada bukti pemusnahan fisik.
- **Pengurangan Saldo Persediaan Resmi:** Saldo persediaan resmi pada lokasi penyimpanan berkurang tepat sebesar kuantitas yang disahkan dimusnahkan.
- **Akuntabilitas Status Fisik:** Barang yang telah ditetapkan tidak layak pakai diamankan dan dilarang digunakan kembali; barang yang belum selesai dimusnahkan secara fisik tetap dapat dipertanggungjawabkan keberadaan dan statusnya.
- **Kekekalan Transaksi:** Transaksi Musnah yang telah dibukukan bersifat permanen (tidak boleh dihapus secara *hard delete*); setiap koreksi merupakan fakta koreksi baru yang merujuk pada transaksi asal.

---

### 5.2 Required Recorded Information

- Identitas unik transaksi pemusnahan (nomor referensi pembukuan musnah);
- Identitas lokasi penyimpanan (gudang/unit penyimpan barang);
- Tanggal pelaksanaan pemusnahan fisik dan tanggal pembukuan transaksi;
- Identitas pejabat yang mengesahkan pemusnahan serta saksi/pelaksana pemusnahan sesuai tata kelola kategori barang;
- Rujukan dokumen bukti pemusnahan fisik yang sah (misalnya Berita Acara Pemusnahan / BAP);
- Rincian item barang yang dimusnahkan:
  - Identitas dan nama barang persediaan;
  - Satuan ukuran;
  - Kuantitas aktual yang dimusnahkan dan disahkan;
  - Alasan pemusnahan yang sah (kedaluwarsa, rusak, terkontaminasi, atau kondisi lain yang sah);
  - Nomor batch/lot dan tanggal kedaluwarsa (untuk kategori barang yang mempersyaratkan pelacakan batch dan masa kedaluwarsa);
- Status akhir transaksi: **Dibukukan** (*Posted* / *Final*);
- Jika terjadi koreksi pasca-pembukuan: identitas transaksi koreksi, referensi transaksi Musnah asal, alasan koreksi, otorisasi koreksi, dan bukti pendukung verifikasi fisik.

---

### 5.3 Required Business Conditions

- Pemusnahan fisik telah selesai dilaksanakan dan didukung bukti pemusnahan yang sah sesuai tata kelola yang berlaku bagi kategori barang terkait;
- Barang yang dimusnahkan tercatat secara sah pada lokasi penyimpanan yang bersangkutan;
- Pengesahan pembukuan dilakukan oleh pejabat yang berwenang atas pengelolaan persediaan.

---

### 5.4 Completion Proof

- Catatan realisasi pemusnahan berstatus **Dibukukan** (*Posted* / *Final*) dengan rujukan bukti pemusnahan fisik yang sah;
- Saldo persediaan resmi pada lokasi penyimpanan berkurang tepat sebesar kuantitas aktual yang disahkan dimusnahkan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika dokumen bukti pemusnahan fisik yang sah (seperti Berita Acara Pemusnahan yang telah disahkan pihak berwenang) tersedia untuk dibukukan ke dalam persediaan resmi.

### End

- **Hasil Primer (Outcome Selesai):** Catatan realisasi pemusnahan disahkan (**Dibukukan** / *Posted*), barang resmi dikeluarkan dari persediaan, dan saldo persediaan resmi pada lokasi penyimpanan berkurang sesuai kuantitas aktual yang disahkan.
- **Batas Terminal Koreksi:** Jika terjadi koreksi sah pasca-pembukuan, transaksi koreksi baru dicatat merujuk transaksi asal berdasarkan verifikasi kondisi fisik barang yang sebenarnya, tanpa menghapus catatan transaksi asli.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Pencatatan Realisasi Fisik:** Pembukuan Musnah adalah pencatatan resmi atas pemusnahan fisik yang telah terlaksana, bukan izin, usulan, atau rencana pemusnahan. Persetujuan usulan pemusnahan, pengamanan barang, pelaksanaan pemusnahan fisik, dan pembukuan realisasi merupakan tahapan bisnis yang berbeda.
2. **Keterikatan Bukti Sah:** Pembukuan Musnah wajib didukung bukti pemusnahan fisik yang sah (seperti Berita Acara Pemusnahan) dan disahkan oleh pihak yang berwenang.
3. **Kesesuaian Kuantitas Aktual:** Kuantitas yang dibukukan wajib mencerminkan jumlah fisik yang nyata-nyata dimusnahkan dan disahkan, bukan sekadar jumlah usulan awal.
4. **Cakupan Seluruh Jenis Persediaan:** Pemusnahan berlaku untuk seluruh jenis barang persediaan (farmasi, BMHP, maupun barang non-medis) yang tercatat di lokasi penyimpanan rumah sakit.
5. **Diferensiasi Tata Kelola Kategori Barang:** Persyaratan dokumen, saksi, dan pengesahan pemusnahan mengikuti aturan bisnis yang berlaku bagi masing-masing kategori barang. Tidak seluruh kategori barang memiliki prosedur atau dokumen pendukung yang identik (misalnya persyaratan farmasi khusus berbeda dengan logistik umum).
6. **Mandatori Batch dan Kedaluwarsa:** Untuk kategori barang yang dikelola dengan nomor batch dan tanggal kedaluwarsa (seperti obat dan BMHP), nomor batch dan tanggal kedaluwarsa wajib dicatat dan dapat dipertanggungjawabkan.
7. **Larangan Penggunaan Barang Tidak Layak:** Barang yang telah ditetapkan tidak layak digunakan atau dalam proses tunggu pemusnahan dilarang kembali digunakan dalam operasional pelayanan, meskipun proses pembukuannya belum selesai.
8. **Pengurangan Saldo Persediaan Resmi:** Setelah transaksi Musnah dibukukan, saldo persediaan resmi berkurang sesuai jumlah yang benar-benar dimusnahkan dan disahkan.
9. **Kekekalan Catatan (Larangan Hard Delete):** Dokumen dan baris transaksi Musnah yang sudah dibukukan tidak boleh dihapus secara permanen (*hard delete*); riwayat transaksi asli wajib tetap tersedia sebagai bukti historis dan jejak audit.
10. **Prinsip Koreksi Transaksi Baru:** Koreksi atas transaksi Musnah yang sudah dibukukan dicatat sebagai fakta koreksi baru yang merujuk transaksi Musnah asal, memiliki alasan yang sah, bukti pendukung, dan otorisasi yang sesuai.
11. **Koreksi Berbasis Kondisi Fisik Riil:** Penanganan koreksi wajib mencerminkan kondisi fisik barang yang sebenarnya:
    - Jika barang secara fisik terbukti masih ada, stok tidak boleh otomatis dikembalikan ke stok aktif sebelum keberadaan fisik dan kelayakannya diverifikasi secara sah.
    - Jika barang terbukti sudah tidak ada tetapi tidak terbukti telah dimusnahkan, kondisi tersebut wajib diselesaikan sebagai kehilangan atau selisih persediaan sesuai aturan bisnis yang berlaku, bukan dengan mengembalikan saldo fiktif ke stok aktif.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Bukti pemusnahan fisik belum ada atau belum disahkan** | Pembukuan ditolak atau ditahan hingga bukti pemusnahan fisik yang sah dan lengkap tersedia. |
| **Kuantitas fisik yang dimusnahkan berbeda dari usulan awal** | Pembukuan dibukukan hanya sebesar kuantitas aktual yang disahkan dimusnahkan; sisa barang yang tidak dimusnahkan tetap dipertanggungjawabkan pada status persediaan yang sesuai. |
| **Barang tidak tercatat pada lokasi penyimpanan atau saldo tercatat tidak mencukupi saat pembukuan** | Pembukuan ditahan untuk investigasi selisih fisik dan rekonsiliasi catatan persediaan sebelum transaksi dapat disahkan. |
| **Upaya penghapusan permanen (*hard delete*) transaksi yang sudah dibukukan** | Ditolak. Transaksi asli wajib dipertahankan; perubahan diproses melalui fakta transaksi koreksi baru. |
| **Pengajuan koreksi transaksi tanpa verifikasi fisik atau otorisasi berwenang** | Ditolak. Penyesuaian persediaan dilarang dilakukan tanpa bukti verifikasi kondisi fisik riil dan persetujuan pejabat berwenang. |
| **Koreksi atas barang yang fisiknya hilang namun tidak terbukti dimusnahkan** | Dilarang mengembalikan saldo fiktif ke persediaan aktif; kondisi diselesaikan melalui proses penanganan kehilangan atau selisih persediaan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Pembukuan Musnah memvalidasi adanya bukti pemusnahan fisik yang sah dan pengesahan pihak berwenang sebelum transaksi dapat dibukukan. | Constraint |
| **AC-02** | Catatan realisasi pemusnahan mencatat lokasi penyimpanan, identitas barang, kuantitas aktual, alasan pemusnahan, serta nomor batch dan tanggal kedaluwarsa jika relevan. | Completeness |
| **AC-03** | Kuantitas persediaan yang dibukukan musnah terbukti tepat sama dengan jumlah aktual yang disahkan pada bukti pemusnahan fisik. | Correctness |
| **AC-04** | Saldo persediaan resmi pada lokasi penyimpanan berkurang tepat sebesar kuantitas aktual yang disahkan dimusnahkan setelah transaksi dibukukan. | Correctness |
| **AC-05** | Barang yang masih dalam tahap usulan atau belum dimusnahkan secara fisik terbukti tidak tercatat sebagai telah dimusnahkan dan tidak mengurangi saldo persediaan resmi. | Constraint |
| **AC-06** | Barang yang telah dinyatakan tidak layak pakai terbukti tidak dapat dialokasikan atau digunakan kembali dalam operasional meskipun pembukuan belum selesai. | Constraint |
| **AC-07** | Pembukuan pemusnahan dapat diterapkan untuk seluruh kategori barang persediaan (farmasi, BMHP, non-medis) dengan tata kelola dokumen dan saksi yang sesuai kategorinya. | Completeness |
| **AC-08** | Catatan transaksi Musnah yang telah dibukukan dilarang dihapus secara permanen (*hard delete*), dan riwayat aslinya tetap utuh serta tertelusur. | Constraint |
| **AC-09** | Koreksi atas transaksi yang telah dibukukan membentuk catatan transaksi koreksi baru yang merujuk transaksi asal dengan mencantumkan alasan, otorisasi, dan bukti pendukung. | Completeness |
| **AC-10** | Koreksi transaksi terbukti tidak menciptakan saldo fiktif pada stok aktif dan mencerminkan kondisi fisik barang yang sebenarnya (diverifikasi kelayakannya atau dialihkan ke penyelesaian kehilangan). | Correctness |
| **AC-11** | Upaya pembukuan tanpa bukti sah atau upaya koreksi tanpa verifikasi fisik riil dan otorisasi terbukti ditolak oleh sistem. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Proses Pengajuan & Otorisasi Usulan Pemusnahan:** Alur telaah awal usulan pemusnahan, pembentukan panitia/tim pemusnah, dan penetapan izin sebelum pemusnahan fisik dilaksanakan.
- **Tata Cara Teknis Pelaksanaan Pemusnahan Fisik:** Prosedur insinerasi, pembuangan limbah B3, penimbunan, destruksi mekanis, serta kepatuhan keselamatan kerja dan lingkungan hidup.
- **Pencatatan Akuntansi & Jurnal Finansial:** Penghitungan nilai buku kerugian persediaan, alokasi akun beban pemusnahan, dan integrasi penjurnalan akuntansi umum.
- **Investigasi Hukum atas Kehilangan/Kecurangan:** Penyelidikan tindak pidana, tuntutan ganti rugi, atau sanksi administratif atas barang persediaan yang hilang di luar pemusnahan resmi.
- **Detail Desain Teknis & UI:** Skema tabel basis data, spesifikasi API, antarmuka pengguna (UI/UX), mekanisme teknis penyimpanan dokumen digital, serta struktur teknis workflow approval.
