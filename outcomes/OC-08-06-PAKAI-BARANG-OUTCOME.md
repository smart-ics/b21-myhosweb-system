# OUTCOME: Pakai Barang

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-06          |
| Version     | 1.3               |
| Status      | Final Draft       |
| LastUpdated | 2026-10-09        |

---

## 1. Business Purpose

Unit laboratorium memerlukan bahan habis pakai dan reagen untuk menjalankan pemeriksaan laboratorium maupun mendukung aktivitas operasional laboratorium sehari-hari. Penggunaan barang-barang tersebut harus dicatat secara tertib dan akurat agar keberadaan dan jumlah fisik stok barang pada lokasi laboratorium selalu mencerminkan kondisi aktual.

OC-08-06 bertanggung jawab atas **Pencatatan Pemakaian Barang (Pakai Barang)** pada lokasi laboratorium, serta **koreksi melalui Edit dan Pembatalan (Cancel) transaksi pemakaian**. Ketika transaksi pemakaian berhasil disimpan secara persisten, stok barang pada lokasi laboratorium berkurang seketika sebesar jumlah yang digunakan. Transaksi yang sudah tersimpan **tidak boleh dihapus**, namun **masih dapat diedit** (selama kondisi stok mencukupi apabila terdapat penambahan kuantitas pemakaian) atau **dibatalkan** (khusus transaksi berstatus `Active`, tanpa bergantung pada kondisi stok saat ini, dengan kewajiban menyertakan alasan pembatalan). Penyesuaian stok dilakukan secara konsisten dan atomik tanpa pernah menghasilkan stok negatif.

---

## 2. Outcome Statement

Transaksi pemakaian barang oleh petugas laboratorium pada lokasi laboratorium **telah berhasil disimpan secara persisten tanpa mencatat nomor batch maupun tanggal kadaluarsa**, dan **stok barang pada lokasi laboratorium terkait telah berkurang atau disesuaikan secara konsisten dan atomik sesuai status dan kuantitas transaksi yang berlaku (Active atau Cancelled)**, dengan riwayat transaksi yang **tidak pernah dihapus**, serta **dapat diedit** (selama stok mencukupi untuk penambahan kuantitas) atau **dibatalkan** (khusus transaksi berstatus `Active` dengan menyertakan alasan pembatalan wajib).

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik konteks operasional transaksi: menyediakan lingkungan operasional tempat pemakaian bahan habis pakai dan reagen berlangsung oleh petugas laboratorium. |
| Inventory | Pemilik kapabilitas pencatatan konsumsi barang dan saldo stok: menyediakan verifikasi ketersediaan stok, eksekusi pemotongan/penyesuaian/pengembalian stok per lokasi, validasi aturan stok non-negatif, dan pencatatan mutasi konsumsi (pada tingkat kuantitas barang di lokasi inventori tanpa tracking batch/expiry). |
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
  - Transaksi mencatat kuantitas/jumlah pemakaian barang murni pada tingkat kuantitas barang di lokasi inventori (**tidak mencatat informasi nomor batch maupun tanggal kadaluarsa / Batch/Expiry secara spesifik**).
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
  - Transaksi yang sudah tersimpan **masih dapat diedit** pada transaksi yang bersangkutan (**bukan membuat transaksi baru**).
  - **Kriteria Kelayakan Edit:** Edit dapat dilakukan selama kondisi stok pada lokasi laboratorium memungkinkan apabila terjadi penambahan kuantitas pemakaian (stok tersedia $\ge$ selisih kenaikan kuantitas). Jika kuantitas diturunkan, edit selalu memungkinkan secara stok.
  - Perubahan data transaksi harus diikuti penyesuaian dampak terhadap stok secara langsung dan atomik:
    - Jika jumlah pemakaian **dinaikkan**, hanya selisih tambahan (delta) yang perlu mengurangi stok.
    - Jika jumlah pemakaian **diturunkan**, selisihnya (delta) harus dikembalikan ke stok.
    - Jika stok tidak mencukupi untuk perubahan yang membutuhkan tambahan pengurangan stok, operasi edit harus ditolak.
    - Jika edit gagal, baik perubahan transaksi maupun perubahan stok tidak boleh tersimpan sebagian.
  - Keterangan/alasan perubahan pada saat Edit bersifat opsional.
- **Koreksi melalui Pembatalan (Cancel Transaksi):**
  - Pembatalan transaksi merupakan **bagian dari OC-08-06**.
  - Pembatalan **hanya dapat dilakukan pada transaksi yang berstatus `Active`**. Upaya membatalkan transaksi yang sudah berstatus `Cancelled` harus ditolak tanpa penyesuaian stok.
  - **Independensi Stok pada Cancel:** Pembatalan transaksi berstatus `Active` **tidak bergantung pada kondisi stok saat ini**; pembatalan menambah/mengembalikan stok sehingga tidak ada risiko menghasilkan stok negatif.
  - **Kewajiban Alasan Pembatalan (Mandatory Cancel Reason):** Petugas **wajib menyertakan keterangan/alasan pembatalan (*CancelReason*)** saat melakukan Cancel. Pembatalan tanpa alasan harus ditolak oleh sistem.
  - Pembatalan **tidak menghapus transaksi**; status transaksi berubah menjadi **`Cancelled`**.
  - Ketika transaksi dibatalkan (termasuk transaksi yang sebelumnya telah melalui satu atau lebih operasi Edit), stok pada lokasi laboratorium **dikembalikan sebesar jumlah pemakaian aktif terakhir (current/latest active quantity)** dari transaksi tersebut, bukan jumlah awal saat Create.
    - *Contoh alur:* Create 10 $\rightarrow$ stok berkurang 10. Edit 10 menjadi 7 $\rightarrow$ stok bertambah 3 (stok terefleksi berkurang bersih 7). Cancel $\rightarrow$ stok bertambah 7 (mengembalikan kuantitas aktif terakhir 7).
  - Perubahan status transaksi menjadi `Cancelled` dan pengembalian stok harus konsisten; tidak boleh hanya salah satunya yang berhasil.
- **Otorisasi Petugas:**
  - Transaksi simpan baru (Create), perubahan (Edit), maupun pembatalan (Cancel) dilakukan oleh petugas laboratorium yang memiliki permission **Pakai Barang**.
  - Tidak diperlukan permission khusus untuk melakukan Edit atau Cancel.

### 5.2 Required Recorded Information

#### A. Transaksi Pemakaian Barang (Create & Active)
Setiap transaksi pemakaian barang mencatat minimal:
- **Barang** — identitas/kode barang yang digunakan (satu jenis barang per transaksi, tanpa batch/expiry).
- **Jumlah Pemakaian** — kuantitas barang yang digunakan.
- **Lokasi Pemakaian** — identitas lokasi inventori laboratorium tempat barang diambil/digunakan.
- **Petugas Transaksi** — identitas petugas/user laboratorium yang melakukan transaksi.
- **Waktu Transaksi** — waktu pencatatan transaksi dilakukan.
- **Status Transaksi** — status keberlakuan transaksi (`Active`).

#### B. Informasi Perubahan (Edit)
Ketika transaksi diedit, tercatat:
- Nilai kuantitas pemakaian yang telah diperbarui (current/latest active quantity).
- Identitas petugas yang melakukan edit dan waktu perubahan.
- Rekam jejak perubahan kuantitas untuk dasar kalkulasi selisih stok (delta).
- *Alasan perubahan (opsional).*

#### C. Informasi Pembatalan (Cancel)
Ketika transaksi berstatus `Active` dibatalkan, tercatat:
- **Status Transaksi** — berubah menjadi **`Cancelled`**.
- **Alasan Pembatalan (CancelReason)** — keterangan/alasan pembatalan yang **wajib diisi**.
- Identitas petugas yang membatalkan dan waktu pembatalan.

### 5.3 Required Business Conditions

- Petugas yang melakukan transaksi simpan baru, edit, atau cancel harus memiliki permission **Pakai Barang**.
- Barang yang dipilih harus valid dan terdaftar pada master barang.
- Lokasi laboratorium yang dipilih harus merupakan lokasi inventori yang valid dan aktif.
- Transaksi pemakaian tidak mencatat nomor batch maupun tanggal kadaluarsa.
- Pada saat Create: jumlah pemakaian wajib $\le$ stok tersedia pada lokasi laboratorium tersebut.
- Pada saat Edit dengan kenaikan jumlah pemakaian: selisih tambahan pemakaian wajib $\le$ stok tersedia pada lokasi laboratorium tersebut (kondisi stok memungkinkan penambahan kuantitas).
- Pembatalan (Cancel) hanya diizinkan untuk transaksi yang berstatus `Active`, tidak bergantung pada kondisi saldo stok yang ada, dan wajib menyertakan alasan pembatalan.
- Pada saat Cancel: stok dikembalikan sebesar kuantitas aktif terakhir dari transaksi tersebut.
- Sistem tidak boleh menghasilkan stok bernilai negatif pada lokasi tersebut, baik setelah create, edit, maupun cancel.
- Keberhasilan penyimpanan data transaksi dan eksekusi perubahan/penyesuaian stok harus diperlakukan secara atomik (satu kesatuan utuh; tidak boleh ada kondisi perubahan parsial).
- Transaksi yang telah tersimpan tidak boleh dihapus secara fisik maupun logis dari database histori.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- **Untuk Transaksi Pemakaian Baru (Create):**
  - Data transaksi Pakai Barang tersimpan secara persisten dengan status `Active` dan memuat atribut minimal (barang, jumlah pemakaian, lokasi pemakaian, petugas transaksi, waktu transaksi) tanpa atribut batch/expiry.
  - Saldo stok barang pada lokasi laboratorium terkait berkurang persis sebesar jumlah pemakaian secara persisten.
- **Untuk Perubahan Transaksi (Edit):**
  - Data transaksi Pakai Barang yang ada diperbarui secara persisten dengan nilai jumlah pemakaian yang baru sebagai kuantitas aktif terakhir (tanpa membuat transaksi baru).
  - Saldo stok barang pada lokasi laboratorium terkait bertambah/berkurang persis sebesar selisih kuantitas baru terhadap kuantitas lama.
  - Data transaksi tetap utuh dan tidak terhapus.
- **Untuk Pembatalan Transaksi (Cancel):**
  - Status data transaksi Pakai Barang berubah menjadi **`Cancelled`** secara persisten (transaksi tetap ada dan tidak dihapus) beserta **CancelReason** yang tercatat.
  - Saldo stok barang pada lokasi laboratorium terkait telah bertambah kembali sebesar kuantitas pemakaian aktif terakhir (current/latest active quantity) dari transaksi tersebut sebelum dibatalkan.

---

## 6. Outcome Boundary

### Start

- **Untuk Pemakaian Baru (Create):** Dimulai ketika petugas laboratorium yang memiliki permission Pakai Barang mencatat penggunaan satu jenis barang pada lokasi laboratorium tertentu.
- **Untuk Perubahan (Edit):** Dimulai ketika petugas laboratorium yang memiliki permission Pakai Barang mengubah data transaksi pemakaian tersimpan yang masih berstatus `Active`.
- **Untuk Pembatalan (Cancel):** Dimulai ketika petugas laboratorium yang memiliki permission Pakai Barang membatalkan transaksi pemakaian tersimpan yang berstatus `Active` dengan menyertakan alasan pembatalan.

### End

- **Untuk Pemakaian Baru (Create):** Berakhir ketika transaksi pemakaian berhasil disimpan secara persisten dan stok barang pada lokasi laboratorium terkait berkurang seketika sebesar jumlah pemakaian.
- **Untuk Perubahan (Edit):** Berakhir ketika transaksi pemakaian berhasil diperbarui dan selisih stok (pengurangan tambahan atau pengembalian stok) berhasil diaplikasikan secara atomik.
- **Untuk Pembatalan (Cancel):** Berakhir ketika status transaksi berhasil berubah menjadi `Cancelled`, alasan pembatalan tercatat, dan stok barang dikembalikan sebesar kuantitas pemakaian aktif terakhir (current/latest active quantity) secara atomik.

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

1. **Satu Transaksi Satu Jenis Barang & Tanpa Batch/Expiry:** Satu transaksi Pakai Barang hanya mencatat satu jenis barang. Transaksi mencatat minimal: barang, jumlah yang dipakai, lokasi pemakaian, petugas/user yang melakukan transaksi, dan waktu transaksi. Transaksi tidak mencatat informasi nomor batch maupun tanggal kadaluarsa (Batch/Expiry) secara spesifik.
2. **Keterikatan Stok dan Transaksi (Atomisitas):** Stok barang berkurang ketika transaksi pemakaian berhasil disimpan. Jika penyimpanan gagal, transaksi tidak dianggap terjadi dan stok tidak boleh berubah. Kegagalan operasi pada create, edit, maupun cancel tidak boleh menyebabkan perubahan stok atau data transaksi secara parsial.
3. **No Negative Stock Invariant:** Jumlah pemakaian tidak boleh melebihi stok yang tersedia. Sistem harus menolak transaksi apabila stok tidak mencukupi, dan stok tidak boleh menjadi negatif dalam kondisi apa pun (baik saat create maupun edit kenaikan jumlah). Setelah edit atau cancel, saldo stok harus merepresentasikan transaksi Pakai Barang yang masih berlaku.
4. **Larangan Penghapusan (No Delete Invariant):** Transaksi yang sudah berhasil disimpan **tidak boleh dihapus**. Riwayat transaksi selalu dipertahankan di dalam sistem.
5. **Mekanisme Edit Transaksi & Kriteria Stok:** Transaksi yang sudah tersimpan masih dapat diedit pada transaksi yang ada (bukan membuat transaksi baru). Edit pemakaian barang diperbolehkan selama kondisi stok memungkinkan untuk melakukan penambahan kuantitas pemakaian:
   - Kenaikan pemakaian $\rightarrow$ hanya selisih tambahan (delta) yang mengurangi stok; jika stok tidak mencukupi untuk selisih tersebut, edit ditolak dan stok tidak berubah.
   - Penurunan pemakaian $\rightarrow$ selisihnya (delta) dikembalikan ke stok; selalu diperbolehkan secara kondisi stok.
   - Keterangan/alasan pada saat Edit tidak diwajibkan.
6. **Mekanisme Pembatalan (Cancel), Independensi Stok, & Mandatory Reason:**
   - Pembatalan merupakan bagian dari OC-08-06 dan **hanya berlaku untuk transaksi berstatus `Active`**.
   - Pembatalan **tidak bergantung pada kondisi stok**; sistem selalu memproses pengembalian stok tanpa terhalang saldo stok saat ini.
   - **Keterangan/alasan pembatalan (*CancelReason*) wajib diisi**; pembatalan tanpa alasan ditolak oleh sistem.
   - Pembatalan tidak menghapus transaksi, melainkan mengubah statusnya menjadi `Cancelled`.
   - Stok dikembalikan sebesar **kuantitas pemakaian aktif terakhir (current/latest active quantity)** dari transaksi tersebut sebelum dibatalkan, bukan kuantitas awal saat Create.
   - Upaya pembatalan pada transaksi yang sudah berstatus `Cancelled` ditolak tanpa penyesuaian stok.
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
| Pada Edit: Penambahan kuantitas pemakaian melebihi stok yang tersedia (selisih kenaikan $>$ stok tersedia) | Edit ditolak dengan alasan stok tidak mencukupi untuk tambahan pengurangan kuantitas. Data transaksi dan stok tidak berubah. |
| Upaya melakukan Cancel tanpa menyertakan alasan pembatalan (*CancelReason*) | Pembatalan ditolak. Alasan pembatalan wajib diisi untuk setiap operasi Cancel. Data transaksi dan saldo stok tidak berubah. |
| Upaya melakukan penghapusan (Delete) terhadap transaksi Pakai Barang yang sudah tersimpan | Aksi ditolak secara mutlak oleh sistem. Transaksi yang sudah tersimpan tidak boleh dihapus. |
| Upaya melakukan Edit terhadap transaksi yang sudah berstatus `Cancelled` | Aksi ditolak. Transaksi yang telah dibatalkan tidak dapat diedit kembali. |
| Upaya melakukan Cancel terhadap transaksi yang sudah berstatus `Cancelled` | Aksi ditolak. Pembatalan hanya dapat dilakukan terhadap transaksi berstatus `Active`. Tidak ada penyesuaian stok yang terjadi. |
| Terjadi kegagalan teknis/penyimpanan saat eksekusi Create, Edit, atau Cancel | Seluruh proses dibatalkan (rollback). Baik data transaksi maupun stok tidak boleh tersimpan/berubah secara parsial (prinsip atomisitas). |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Petugas laboratorium dengan permission **Pakai Barang** dapat mencatat transaksi pemakaian satu jenis barang pada lokasi laboratorium dengan mencatat barang, jumlah pemakaian, lokasi pemakaian, petugas transaksi, dan waktu transaksi, tanpa mencatat nomor batch maupun tanggal kadaluarsa, serta tanpa prerequisite Order Laboratorium atau pemeriksaan pasien. | Completeness |
| AC-02 | Ketika transaksi pemakaian berhasil disimpan, transaksi tercatat dengan status `Active` dan stok barang pada lokasi laboratorium berkurang seketika sesuai jumlah pemakaian. | Correctness |
| AC-03 | Jika penyimpanan transaksi pemakaian baru gagal, transaksi tidak dianggap terjadi dan stok barang pada lokasi laboratorium tidak mengalami perubahan. | Constraint |
| AC-04 | Transaksi pemakaian baru ditolak dan stok tidak berubah apabila jumlah pemakaian melebihi stok yang tersedia pada lokasi laboratorium, memastikan stok tidak menjadi negatif. | Constraint |
| AC-05 | Transaksi Pakai Barang yang sudah berhasil disimpan tidak boleh dihapus dari sistem dalam kondisi apa pun. | Constraint |
| AC-06 | Transaksi yang sudah tersimpan masih dapat diedit pada transaksi yang bersangkutan (tanpa membuat transaksi baru) oleh petugas dengan permission **Pakai Barang** tanpa memerlukan permission khusus. | Completeness |
| AC-07 | Pada operasi Edit, jika jumlah pemakaian dinaikkan, edit hanya berhasil jika kondisi stok mencukupi untuk selisih tambahannya (delta); jika stok tidak mencukupi, edit ditolak dan stok tidak berubah. | Correctness |
| AC-08 | Pada operasi Edit, jika jumlah pemakaian diturunkan, selisih pengurangannya (delta) dikembalikan ke stok pada lokasi laboratorium terkait. | Correctness |
| AC-09 | Jika operasi Edit gagal disimpan, perubahan data transaksi maupun penyesuaian stok tidak tersimpan secara parsial. | Constraint |
| AC-10 | Transaksi yang berstatus **`Active`** dapat dibatalkan tanpa bergantung pada kondisi stok saat ini, oleh petugas dengan permission **Pakai Barang** tanpa memerlukan permission khusus. | Completeness |
| AC-11 | Operasi Cancel ditolak apabila petugas tidak menyertakan alasan pembatalan (**CancelReason**), dan data transaksi maupun stok tidak berubah. | Exception |
| AC-12 | Pada operasi Cancel yang menyertakan alasan pembatalan terhadap transaksi berstatus `Active`, transaksi tidak dihapus melainkan statusnya berubah menjadi **`Cancelled`**, dan stok barang pada lokasi laboratorium dikembalikan sebesar kuantitas pemakaian aktif terakhir (current/latest active quantity) dari transaksi tersebut sebelum dibatalkan. | Correctness |
| AC-13 | Pada transaksi yang telah diedit sebelum dibatalkan (misal: Create 10 $\rightarrow$ Edit 7 $\rightarrow$ Cancel), operasi Cancel mengembalikan kuantitas aktif terakhir (7) ke stok, bukan kuantitas awal (10). | Correctness |
| AC-14 | Upaya menjalankan operasi Cancel pada transaksi yang sudah berstatus **`Cancelled`** ditolak oleh sistem, dan tidak terjadi penyesuaian stok. | Exception |
| AC-15 | Perubahan status transaksi menjadi `Cancelled` dan pengembalian stok pada operasi Cancel berlangsung secara atomik dan konsisten; tidak boleh hanya salah satunya yang berhasil. | Constraint |
| AC-16 | Setelah seluruh operasi (Create, Edit, atau Cancel), stok pada lokasi laboratorium tidak bernilai negatif dan selalu merepresentasikan transaksi Pakai Barang yang masih berlaku. | Constraint |
| AC-17 | Operasi Create, Edit, dan Cancel ditolak apabila petugas tidak memiliki permission **Pakai Barang**. | Exception |

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
- Pelacakan dan manajemen nomor batch dan tanggal kadaluarsa (Batch / Expiry tracking) → di luar cakupan OC-08-06; pencatatan dilakukan murni pada tingkat kuantitas barang di lokasi inventori laboratorium.

---

## 11. Business Decisions & Open Questions

### Confirmed Decisions

1. **Independensi Klinis:** Pakai Barang tidak wajib terkait dengan Order Laboratorium atau pemeriksaan pasien tertentu. Transaksi dapat digunakan untuk pemakaian barang/reagen dalam pemeriksaan pasien maupun aktivitas operasional laboratorium lainnya. `OrderLaboratorium`, pasien, atau pemeriksaan bukan prerequisite transaksi.
2. **Karakteristik & Data Transaksi:** Satu transaksi Pakai Barang hanya untuk satu jenis barang. Minimal transaksi mencatat: barang, jumlah yang dipakai, lokasi pemakaian, petugas/user yang melakukan transaksi, dan waktu transaksi.
3. **Peniadaan Pencatatan Batch / Expiry:** Pemakaian barang laboratorium tidak mencatat informasi nomor batch dan tanggal kadaluarsa (Batch/Expiry) secara spesifik; pencatatan berfokus pada kuantitas pemakaian barang di lokasi laboratorium.
4. **Stock Deduction & Atomisitas:** Stock deduction terjadi ketika transaksi berhasil disimpan. Save berhasil $\rightarrow$ transaksi tercatat dan stok barang berkurang sesuai jumlah pemakaian. Save gagal $\rightarrow$ transaksi tidak dianggap terjadi dan stok tidak boleh berubah.
5. **Batas Stok & Invariant Non-Negatif:** Jumlah pemakaian tidak boleh melebihi stok yang tersedia. Sistem harus menolak transaksi apabila stok tidak mencukupi. Stok tidak boleh menjadi negatif.
6. **Larangan Penghapusan:** Transaksi yang sudah berhasil disimpan tidak boleh dihapus.
7. **Koreksi via Edit Transaksi & Kriteria Stok:** Transaksi yang sudah tersimpan masih dapat diedit pada transaksi yang ada (bukan membuat transaksi baru). Kriteria kelayakan edit ditentukan oleh kondisi stok: edit dapat dilakukan selama kondisi stok pada lokasi laboratorium memungkinkan apabila ada penambahan kuantitas pemakaian (stok mencukupi untuk selisih kenaikan). Jika kuantitas diturunkan, selisihnya dikembalikan ke stok. Keterangan alasan pada saat Edit bersifat opsional.
8. **Koreksi via Pembatalan (Cancel), Independensi Stok, & Alasan Wajib:**
   - Pembatalan merupakan bagian dari OC-08-06 dan hanya berlaku untuk transaksi berstatus `Active`.
   - Pembatalan transaksi tidak bergantung pada kondisi stok saat ini.
   - **Keterangan/alasan pembatalan (*CancelReason*) wajib diisi** oleh petugas saat melakukan Cancel; pembatalan tanpa alasan ditolak.
   - Pembatalan tidak menghapus transaksi; status transaksi menjadi `Cancelled`.
   - Stok dikembalikan sebesar **kuantitas pemakaian aktif terakhir (current/latest active quantity)** dari transaksi tersebut sebelum dibatalkan, bukan kuantitas awal saat Create.
   - Upaya pembatalan pada transaksi yang sudah berstatus `Cancelled` ditolak tanpa penyesuaian stok.
   - Perubahan status dan pengembalian stok harus konsisten.
9. **Permission Model:** Tidak diperlukan permission khusus untuk edit atau cancel. Edit dan cancel menggunakan permission yang sama dengan akses `Pakai Barang`.
10. **Invariant Stok Pasca-Aksi:** Setelah edit atau cancel, stok tidak boleh negatif dan harus merepresentasikan transaksi Pakai Barang yang masih berlaku.
11. **Scope Boundary:** OC-08-06 tidak mengambil tanggung jawab Order Laboratorium, Sample Collection, Result Management, pengadaan/penerimaan barang, mutasi barang antar lokasi, maupun stock opname.

### Open Questions

*Seluruh Open Questions telah terjawab dan dikonfirmasi:*
- *Kriteria kelayakan koreksi edit ditentukan oleh ketersediaan stok untuk penambahan kuantitas, sedangkan pembatalan tidak bergantung pada kondisi stok (Terjawab).*
- *Keterangan/alasan hanya wajib untuk Cancel, sedangkan untuk Edit opsional (Terjawab).*
- *Pencatatan pemakaian barang tidak mencatat informasi nomor batch dan tanggal kadaluarsa secara spesifik (Terjawab).*
