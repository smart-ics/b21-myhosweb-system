# OUTCOME: Pakai Barang

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-06          |
| Version     | 1.1               |
| Status      | Final Draft       |
| LastUpdated | 2026-10-08        |

---

## 1. Business Purpose

Unit laboratorium memerlukan bahan habis pakai dan reagen untuk menjalankan pemeriksaan laboratorium maupun mendukung aktivitas operasional laboratorium sehari-hari. Penggunaan barang-barang tersebut harus dicatat secara tertib dan akurat agar keberadaan dan jumlah fisik stok barang pada lokasi laboratorium selalu mencerminkan kondisi aktual.

OC-08-06 bertanggung jawab atas **Pencatatan Pemakaian Barang (Pakai Barang)** pada lokasi laboratorium, serta **koreksi melalui Edit dan Pembatalan (Cancel) transaksi pemakaian**. Ketika transaksi pemakaian berhasil disimpan secara persisten, stok barang pada lokasi laboratorium berkurang seketika sebesar jumlah yang digunakan. Transaksi yang sudah tersimpan **tidak boleh dihapus**, namun **masih dapat diedit atau dibatalkan** apabila masih memungkinkan dikoreksi secara bisnis, dengan penyesuaian stok yang konsisten dan atomik tanpa pernah menghasilkan stok negatif.

---

## 2. Outcome Statement

Transaksi pemakaian barang oleh petugas laboratorium pada lokasi laboratorium **telah berhasil disimpan secara persisten**, dan **stok barang pada lokasi laboratorium terkait telah berkurang atau disesuaikan secara konsisten dan atomik sesuai status dan kuantitas transaksi yang berlaku (Active atau Cancelled)**, dengan riwayat transaksi yang **tidak pernah dihapus**, serta **dapat diedit atau dibatalkan** selama masih memungkinkan dikoreksi secara bisnis.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik konteks operasional transaksi: menyediakan lingkungan operasional tempat pemakaian bahan habis pakai dan reagen berlangsung oleh petugas laboratorium. |
| Inventory | Pemilik kapabilitas pencatatan konsumsi barang dan saldo stok: menyediakan verifikasi ketersediaan stok, eksekusi pemotongan/penyesuaian/pengembalian stok per lokasi, validasi aturan stok non-negatif, dan pencatatan mutasi konsumsi. |
| Organisasi | Menyediakan identitas actor terautentikasi dan verifikasi kepemilikan permission **Pakai Barang**. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `INV-PAKAI` Pakai Barang | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-USER` User & Petugas | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Karakteristik Transaksi Pemakaian:**
  - Satu transaksi Pakai Barang hanya mencatat **satu jenis barang**.
  - Satu transaksi merepresentasikan **satu kejadian pemakaian barang**.
  - Transaksi mencatat kuantitas/jumlah pemakaian barang.
  - Pemakaian barang bersifat independen: **tidak wajib dikaitkan dengan Order Laboratorium** dan **tidak wajib dikaitkan dengan pemeriksaan pasien**.
  - Barang dapat digunakan untuk pemeriksaan pasien maupun aktivitas operasional laboratorium lainnya.
- **Keterikatan Transaksi dan Perubahan Stok (Stock Deduction Fact):**
  - Stok barang pada lokasi laboratorium berkurang **ketika dan hanya ketika transaksi pemakaian berhasil disimpan** (Save berhasil $\rightarrow$ transaksi tercatat dan stok barang berkurang sesuai jumlah pemakaian).
  - Jumlah stok yang berkurang persis sama dengan jumlah pemakaian yang dicatat pada transaksi.
  - Keberhasilan transaksi pemakaian dan pengurangan stok merupakan satu kesatuan utuh; jika penyimpanan gagal, transaksi tidak dianggap terjadi dan stok tidak boleh berubah.
  - Jumlah pemakaian tidak boleh melebihi stok yang tersedia; sistem harus menolak transaksi apabila stok tidak mencukupi, dan stok tidak boleh menjadi negatif.
- **Larangan Penghapusan (No Delete Fact):**
  - Transaksi Pakai Barang yang sudah berhasil disimpan **tidak boleh dihapus** dari sistem dalam kondisi apa pun, menjaga rekam jejak audit transaksi.
- **Koreksi melalui Edit Transaksi:**
  - Transaksi yang sudah tersimpan **masih dapat diedit** apabila masih memungkinkan dikoreksi secara bisnis.
  - Edit dilakukan terhadap transaksi yang sudah ada (**bukan membuat transaksi baru**).
  - Perubahan data transaksi harus diikuti penyesuaian dampak terhadap stok secara langsung dan atomik:
    - Jika jumlah pemakaian **dinaikkan**, hanya selisih tambahan yang perlu mengurangi stok.
    - Jika jumlah pemakaian **diturunkan**, selisihnya harus dikembalikan ke stok.
    - Jika stok tidak mencukupi untuk perubahan yang membutuhkan tambahan pengurangan stok, operasi edit harus ditolak.
    - Jika edit gagal, baik perubahan transaksi maupun perubahan stok tidak boleh tersimpan sebagian.
- **Koreksi melalui Pembatalan (Cancel Transaksi):**
  - Pembatalan transaksi merupakan **bagian dari OC-08-06**.
  - Transaksi yang sudah tersimpan **masih dapat dibatalkan** apabila masih memungkinkan dikoreksi secara bisnis.
  - Pembatalan **tidak menghapus transaksi**; status transaksi berubah menjadi **`Cancelled`**.
  - Stok pada lokasi laboratorium dikembalikan sebesar jumlah yang sebelumnya dikurangi oleh transaksi tersebut.
  - Perubahan status transaksi menjadi `Cancelled` dan pengembalian stok harus konsisten; tidak boleh hanya salah satunya yang berhasil.
- **Otorisasi Petugas:**
  - Transaksi simpan baru (Create), perubahan (Edit), maupun pembatalan (Cancel) dilakukan oleh petugas laboratorium yang memiliki permission **Pakai Barang**.
  - Tidak diperlukan permission khusus untuk melakukan Edit atau Cancel.

### 5.2 Required Recorded Information

#### A. Transaksi Pemakaian Barang (Create & Active)
Setiap transaksi pemakaian barang mencatat minimal:
- **Barang** — identitas/kode barang yang digunakan (satu jenis barang per transaksi).
- **Jumlah Pemakaian** — kuantitas barang yang digunakan.
- **Lokasi Pemakaian** — identitas lokasi inventori laboratorium tempat barang diambil/digunakan.
- **Petugas Transaksi** — identitas petugas/user laboratorium yang melakukan transaksi.
- **Waktu Transaksi** — waktu pencatatan transaksi dilakukan.
- **Status Transaksi** — status keberlakuan transaksi (aktif / berlaku).

#### B. Informasi Perubahan (Edit)
Ketika transaksi diedit selama masih memungkinkan dikoreksi secara bisnis, tercatat:
- Nilai kuantitas pemakaian yang telah diperbarui.
- Identitas petugas yang melakukan edit dan waktu perubahan.
- Rekam jejak perubahan kuantitas untuk dasar kalkulasi selisih stok (delta).

#### C. Informasi Pembatalan (Cancel)
Ketika transaksi dibatalkan selama masih memungkinkan dikoreksi secara bisnis, tercatat:
- **Status Transaksi** — berubah menjadi **`Cancelled`**.
- Identitas petugas yang membatalkan dan waktu pembatalan.

### 5.3 Required Business Conditions

- Petugas yang melakukan transaksi simpan baru, edit, atau cancel harus memiliki permission **Pakai Barang**.
- Barang yang dipilih harus valid dan terdaftar pada master barang.
- Lokasi laboratorium yang dipilih harus merupakan lokasi inventori yang valid dan aktif.
- Pada saat Create: jumlah pemakaian wajib $\le$ stok tersedia pada lokasi laboratorium tersebut.
- Pada saat Edit dengan kenaikan jumlah pemakaian: selisih tambahan pemakaian wajib $\le$ stok tersedia pada lokasi laboratorium tersebut.
- Sistem tidak boleh menghasilkan stok bernilai negatif pada lokasi tersebut, baik setelah create, edit, maupun cancel.
- Keberhasilan penyimpanan data transaksi dan eksekusi perubahan/penyesuaian stok harus diperlakukan secara atomik (satu kesatuan utuh; tidak boleh ada kondisi perubahan parsial).
- Transaksi yang telah tersimpan tidak boleh dihapus secara fisik maupun logis dari database histori.
- Operasi Edit dan Cancel hanya dapat dijalankan apabila transaksi masih berada dalam kondisi memungkinkan dikoreksi secara bisnis.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- **Untuk Transaksi Pemakaian Baru (Create):**
  - Data transaksi Pakai Barang tersimpan secara persisten dengan status aktif dan memuat atribut minimal (barang, jumlah pemakaian, lokasi pemakaian, petugas transaksi, waktu transaksi).
  - Saldo stok barang pada lokasi laboratorium terkait berkurang persis sebesar jumlah pemakaian secara persisten.
- **Untuk Perubahan Transaksi (Edit):**
  - Data transaksi Pakai Barang yang ada diperbarui secara persisten dengan nilai jumlah pemakaian yang baru (tanpa membuat transaksi baru).
  - Saldo stok barang pada lokasi laboratorium terkait bertambah/berkurang persis sebesar selisih kuantitas baru terhadap kuantitas lama.
  - Data transaksi tetap utuh dan tidak terhapus.
- **Untuk Pembatalan Transaksi (Cancel):**
  - Status data transaksi Pakai Barang berubah menjadi **`Cancelled`** secara persisten (transaksi tetap ada dan tidak dihapus).
  - Saldo stok barang pada lokasi laboratorium terkait telah bertambah kembali sebesar jumlah pemakaian transaksi tersebut.

---

## 6. Outcome Boundary

### Start

- **Untuk Pemakaian Baru (Create):** Dimulai ketika petugas laboratorium yang memiliki permission Pakai Barang mencatat penggunaan satu jenis barang pada lokasi laboratorium tertentu.
- **Untuk Perubahan (Edit):** Dimulai ketika petugas laboratorium yang memiliki permission Pakai Barang mengubah data transaksi pemakaian tersimpan yang masih memungkinkan dikoreksi secara bisnis.
- **Untuk Pembatalan (Cancel):** Dimulai ketika petugas laboratorium yang memiliki permission Pakai Barang membatalkan transaksi pemakaian tersimpan yang masih memungkinkan dikoreksi secara bisnis.

### End

- **Untuk Pemakaian Baru (Create):** Berakhir ketika transaksi pemakaian berhasil disimpan secara persisten dan stok barang pada lokasi laboratorium terkait berkurang seketika sebesar jumlah pemakaian.
- **Untuk Perubahan (Edit):** Berakhir ketika transaksi pemakaian berhasil diperbarui dan selisih stok (pengurangan tambahan atau pengembalian stok) berhasil diaplikasikan secara atomik.
- **Untuk Pembatalan (Cancel):** Berakhir ketika status transaksi berhasil berubah menjadi `Cancelled` dan stok barang dikembalikan secara penuh sesuai jumlah pemakaian transaksi tersebut secara atomik.

### Scope Boundary & Batas Tanggung Jawab

OC-08-06 berfokus murni pada pencatatan konsumsi barang laboratorium, pengelolaan status transaksinya (Active/Cancelled), dan penyesuaian stok terkait. OC-08-06 secara tegas **tidak mengambil tanggung jawab outcome lain**:

- **Bukan Order Laboratorium (OC-08-02):** Pemakaian barang tidak membuat, mengubah, maupun menyelesaikan Order Laboratorium. Pemakaian barang tidak boleh dibuat dependent terhadap Order Laboratorium.
- **Bukan Sample Collection (OC-08-04):** Pengambilan sampel pasien tidak mengendalikan transaksi pemakaian barang, dan pemakaian barang tidak menjadi prerequisite pengambilan sampel.
- **Bukan Result Management (OC-08-05):** Pengisian hasil pemeriksaan atau rilis hasil tidak mengendalikan pemakaian barang.
- **Bukan Pemeriksaan Pasien:** Pemakaian barang dapat terjadi untuk pemeriksaan pasien maupun kebutuhan operasional laboratorium non-pasien (seperti kalibrasi instrumen, kontrol harian/QC, pembersihan alat, dsb.). Pasien atau pemeriksaan bukan prerequisite transaksi.
- **Bukan Pengadaan / Penerimaan Barang (SC-12 / SC-13):** Proses pengadaan, pemesanan ke vendor, dan penerimaan fisik barang dari pihak luar bukan tanggung jawab OC ini.
- **Bukan Mutasi Barang Antar Lokasi (OC-08-07):** Pemindahan stok barang antar lokasi/gudang/unit bukan bagian dari transaksi pemakaian barang.
- **Bukan Stock Opname (OC-08-08):** Penyesuaian fisik berkala (stock opname) dan rekonsiliasi selisih stok fisik bukan tanggung jawab OC ini.

---

## 7. Business Constraints

1. **Satu Transaksi Satu Jenis Barang:** Satu transaksi Pakai Barang hanya mencatat satu jenis barang. Transaksi mencatat minimal: barang, jumlah yang dipakai, lokasi pemakaian, petugas/user yang melakukan transaksi, dan waktu transaksi.
2. **Keterikatan Stok dan Transaksi (Atomisitas):** Stok barang berkurang ketika transaksi pemakaian berhasil disimpan. Jika penyimpanan gagal, transaksi tidak dianggap terjadi dan stok tidak boleh berubah. Kegagalan operasi pada create, edit, maupun cancel tidak boleh menyebabkan perubahan stok atau data transaksi secara parsial.
3. **No Negative Stock Invariant:** Jumlah pemakaian tidak boleh melebihi stok yang tersedia. Sistem harus menolak transaksi apabila stok tidak mencukupi, dan stok tidak boleh menjadi negatif dalam kondisi apa pun (baik saat create maupun edit kenaikan jumlah). Setelah edit atau cancel, saldo stok harus merepresentasikan transaksi Pakai Barang yang masih berlaku.
4. **Larangan Penghapusan (No Delete Invariant):** Transaksi yang sudah berhasil disimpan **tidak boleh dihapus**. Riwayat transaksi selalu dipertahankan di dalam sistem.
5. **Mekanisme Edit Transaksi:** Transaksi yang sudah tersimpan masih dapat diedit apabila masih memungkinkan dikoreksi secara bisnis. Edit dilakukan dengan memodifikasi transaksi yang ada (bukan membuat transaksi baru). Perubahan jumlah pemakaian berdampak langsung pada stok:
   - Kenaikan pemakaian $\rightarrow$ hanya selisih tambahan yang mengurangi stok.
   - Penurunan pemakaian $\rightarrow$ selisihnya dikembalikan ke stok.
   - Jika stok tidak mencukupi untuk tambahan pengurangan, edit ditolak dan stok tidak berubah.
6. **Mekanisme Pembatalan (Cancel):** Transaksi yang sudah tersimpan masih dapat dibatalkan apabila masih memungkinkan dikoreksi secara bisnis. Pembatalan merupakan bagian dari OC-08-06. Pembatalan tidak menghapus transaksi, melainkan mengubah statusnya menjadi `Cancelled` dan mengembalikan stok sebesar jumlah pemakaian transaksi tersebut.
7. **Independence from Clinical Orders / Visits:** Pemakaian barang tidak wajib dikaitkan dengan Order Laboratorium dan tidak wajib dikaitkan dengan pemeriksaan pasien tertentu. Keduanya bukan prasyarat validitas transaksi.
8. **Actor Permission Policy:** Aktor adalah petugas laboratorium yang memiliki permission **Pakai Barang**. Transaksi Create, Edit, dan Cancel menggunakan permission yang sama (`Pakai Barang`); tidak diperlukan permission khusus tambahan untuk edit atau cancel.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| Petugas laboratorium tidak memiliki permission **Pakai Barang** | Operasi Create, Edit, atau Cancel ditolak. Sistem tidak melakukan perubahan data transaksi dan stok tidak berubah. |
| Barang tidak ditemukan / tidak valid pada master barang | Transaksi ditolak. Sistem tidak menyimpan transaksi dan stok tidak berubah. |
| Lokasi laboratorium tidak valid / tidak aktif | Transaksi ditolak. Sistem tidak menyimpan transaksi dan stok tidak berubah. |
| Jumlah pemakaian bernilai $\le 0$ atau tidak valid | Transaksi ditolak. Jumlah pemakaian harus berupa kuantitas positif yang valid. |
| Pada Create: Stok barang yang tersedia pada lokasi tidak mencukupi (jumlah pemakaian $>$ stok tersedia) | Transaksi ditolak dengan alasan stok tidak mencukupi. Sistem tidak menyimpan transaksi dan stok tidak berubah sama sekali (mencegah stok negatif). |
| Pada Edit: Penambahan kuantitas pemakaian melebihi stok yang tersedia (selisih kenaikan $>$ stok tersedia) | Edit ditolak dengan alasan stok tidak mencukupi untuk tambahan pengurangan. Data transaksi dan stok tidak berubah. |
| Upaya melakukan Edit atau Cancel terhadap transaksi yang sudah tidak lagi memungkinkan dikoreksi secara bisnis | Aksi ditolak oleh sistem. Data transaksi dan saldo stok tidak berubah. |
| Upaya melakukan penghapusan (Delete) terhadap transaksi Pakai Barang yang sudah tersimpan | Aksi ditolak secara mutlak oleh sistem. Transaksi yang sudah tersimpan tidak boleh dihapus. |
| Upaya melakukan Edit terhadap transaksi yang sudah berstatus `Cancelled` | Aksi ditolak. Transaksi yang telah dibatalkan tidak dapat diedit kembali. |
| Terjadi kegagalan teknis/penyimpanan saat eksekusi Create, Edit, atau Cancel | Seluruh proses dibatalkan (rollback). Baik data transaksi maupun stok tidak boleh tersimpan/berubah secara parsial (prinsip atomisitas). |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Petugas laboratorium dengan permission **Pakai Barang** dapat mencatat transaksi pemakaian satu jenis barang pada lokasi laboratorium dengan mencatat barang, jumlah pemakaian, lokasi pemakaian, petugas transaksi, dan waktu transaksi, tanpa prerequisite Order Laboratorium atau pemeriksaan pasien. | Completeness |
| AC-02 | Ketika transaksi pemakaian berhasil disimpan, transaksi tercatat dan stok barang pada lokasi laboratorium berkurang seketika sesuai jumlah pemakaian. | Correctness |
| AC-03 | Jika penyimpanan transaksi pemakaian baru gagal, transaksi tidak dianggap terjadi dan stok barang pada lokasi laboratorium tidak mengalami perubahan. | Constraint |
| AC-04 | Transaksi pemakaian baru ditolak dan stok tidak berubah apabila jumlah pemakaian melebihi stok yang tersedia pada lokasi laboratorium, memastikan stok tidak menjadi negatif. | Constraint |
| AC-05 | Transaksi Pakai Barang yang sudah berhasil disimpan tidak boleh dihapus dari sistem dalam kondisi apa pun. | Constraint |
| AC-06 | Transaksi yang sudah tersimpan masih dapat diedit pada transaksi yang bersangkutan (tanpa membuat transaksi baru) selama masih memungkinkan dikoreksi secara bisnis, oleh petugas dengan permission **Pakai Barang** tanpa memerlukan permission khusus. | Completeness |
| AC-07 | Pada operasi Edit, jika jumlah pemakaian dinaikkan, hanya selisih tambahannya yang mengurangi stok; jika stok tidak mencukupi untuk selisih tersebut, edit ditolak dan stok tidak berubah. | Correctness |
| AC-08 | Pada operasi Edit, jika jumlah pemakaian diturunkan, selisih pengurangannya dikembalikan ke stok pada lokasi laboratorium terkait. | Correctness |
| AC-09 | Jika operasi Edit gagal disimpan, perubahan data transaksi maupun penyesuaian stok tidak tersimpan secara parsial. | Constraint |
| AC-10 | Transaksi yang sudah tersimpan masih dapat dibatalkan selama masih memungkinkan dikoreksi secara bisnis, oleh petugas dengan permission **Pakai Barang** tanpa memerlukan permission khusus. | Completeness |
| AC-11 | Pada operasi Cancel, transaksi tidak dihapus melainkan statusnya berubah menjadi **`Cancelled`**, dan stok barang pada lokasi laboratorium dikembalikan sebesar jumlah yang sebelumnya dikurangi oleh transaksi tersebut. | Correctness |
| AC-12 | Perubahan status transaksi menjadi `Cancelled` dan pengembalian stok pada operasi Cancel berlangsung secara atomik dan konsisten; tidak boleh hanya salah satunya yang berhasil. | Constraint |
| AC-13 | Setelah seluruh operasi (Create, Edit, atau Cancel), stok pada lokasi laboratorium tidak bernilai negatif dan selalu merepresentasikan transaksi Pakai Barang yang masih berlaku. | Constraint |
| AC-14 | Operasi Create, Edit, dan Cancel ditolak apabila petugas tidak memiliki permission **Pakai Barang**. | Exception |

---

## 10. Out of Scope

- Pencatatan dan pengelolaan permintaan pemeriksaan pasien → **OC-08-02 Order Laboratorium**.
- Pengambilan dan pencatatan sampel biologis pasien → **OC-08-04 Sample Collection**.
- Pencatatan, verifikasi, rilis, dan koreksi hasil pengujian laboratorium → **OC-08-05 Result Management**.
- Pembebanan tarif/biaya layanan laboratorium kepada tagihan pasien → **OC-08-03 Charge**.
- Pengadaan barang, pemesanan ke vendor, penerimaan surat jalan/DO dari supplier eksternal, dan retur beli → **SC-12 Gudang / SC-13 Purchasing**.
- Perpindahan atau mutasi barang antar lokasi inventori laboratorium atau antar unit → **OC-08-07 Mutasi Barang**.
- Penghitungan fisik berkala, identifikasi selisih fisik, dan rekonsiliasi stok opname → **OC-08-08 Opname**.
- Penentuan formula kebutuhan reagen otomatis per jenis pemeriksaan (auto-deduct per test formula) → di luar cakupan OC-08-06; pencatatan pada OC ini adalah pemakaian barang secara eksplisit per kejadian.

---

## 11. Business Decisions & Open Questions

### Confirmed Decisions

1. **Independensi Klinis:** Pakai Barang tidak wajib terkait dengan Order Laboratorium atau pemeriksaan pasien tertentu. Transaksi dapat digunakan untuk pemakaian barang/reagen dalam pemeriksaan pasien maupun aktivitas operasional laboratorium lainnya. `OrderLaboratorium`, pasien, atau pemeriksaan bukan prerequisite transaksi.
2. **Karakteristik & Data Transaksi:** Satu transaksi Pakai Barang hanya untuk satu jenis barang. Minimal transaksi mencatat: barang, jumlah yang dipakai, lokasi pemakaian, petugas/user yang melakukan transaksi, dan waktu transaksi.
3. **Stock Deduction & Atomisitas:** Stock deduction terjadi ketika transaksi berhasil disimpan. Save berhasil $\rightarrow$ transaksi tercatat dan stok barang berkurang sesuai jumlah pemakaian. Save gagal $\rightarrow$ transaksi tidak dianggap terjadi dan stok tidak boleh berubah.
4. **Batas Stok & Invariant Non-Negatif:** Jumlah pemakaian tidak boleh melebihi stok yang tersedia. Sistem harus menolak transaksi apabila stok tidak mencukupi. Stok tidak boleh menjadi negatif.
5. **Larangan Penghapusan:** Transaksi yang sudah berhasil disimpan tidak boleh dihapus.
6. **Koreksi via Edit Transaksi:** Transaksi yang sudah tersimpan masih dapat diedit apabila masih memungkinkan dikoreksi secara bisnis. Edit bukan membuat transaksi baru. Perubahan transaksi harus diikuti penyesuaian dampak terhadap stok: jika dinaikkan, hanya selisih tambahan yang mengurangi stok (ditolak jika stok tidak cukup); jika diturunkan, selisihnya dikembalikan ke stok. Jika edit gagal, tidak boleh tersimpan sebagian.
7. **Koreksi via Pembatalan (Cancel):** Transaksi yang sudah tersimpan masih dapat dibatalkan apabila masih memungkinkan dikoreksi secara bisnis. Pembatalan merupakan bagian dari OC-08-06. Pembatalan tidak menghapus transaksi; status transaksi menjadi `Cancelled`. Stok dikembalikan sebesar jumlah yang sebelumnya dikurangi oleh transaksi tersebut. Perubahan status dan pengembalian stok harus konsisten.
8. **Permission Model:** Tidak diperlukan permission khusus untuk edit atau cancel. Edit dan cancel menggunakan permission yang sama dengan akses `Pakai Barang`.
9. **Invariant Stok Pasca-Aksi:** Setelah edit atau cancel, stok tidak boleh negatif dan harus merepresentasikan transaksi Pakai Barang yang masih berlaku.
10. **Scope Boundary:** OC-08-06 tidak mengambil tanggung jawab Order Laboratorium, Sample Collection, Result Management, pengadaan/penerimaan barang, mutasi barang antar lokasi, maupun stock opname.

### Open Questions

1. **Kriteria "Masih Memungkinkan Dikoreksi secara Bisnis":** Apa batasan/kondisi bisnis pasti yang menentukan apakah suatu transaksi Pakai Barang masih boleh di-Edit atau di-Cancel versus sudah terkunci permanen? *(Belum ditentukan: tidak membuat asumsi batas waktu, shift, stock opname, penutupan akuntansi, maupun approval; dibiarkan terbuka untuk diputuskan oleh Product Owner).*
2. **Keterangan / Alasan Perubahan (Reason for Edit / Cancel):** Apakah pada saat melakukan Edit atau Cancel, petugas diwajibkan (mandatory) memasukkan teks alasan perubahan/pembatalan sebagai bagian dari audit trail, atau bersifat opsional?
3. **Pencatatan Nomor Batch / Expiry Date:** Apakah pencatatan pemakaian barang laboratorium mencatat informasi nomor batch dan tanggal kadaluarsa (*Batch/Expiry*) secara spesifik, atau murni pada level kuantitas barang di lokasi inventori?
