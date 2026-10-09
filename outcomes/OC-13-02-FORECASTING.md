# OUTCOME: Forecasting

| Field       | Value        |
|-------------|--------------|
| Code        | OC-13-02     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-09   |

---

## 1. Business Purpose

Pengelolaan rantai pasok material rumah sakit (mencakup obat-obatan, bahan medis habis pakai/BMHP, reagen laboratorium, dan perlengkapan operasional non-medis) membutuhkan perencanaan yang akurat untuk menjamin kesinambungan pelayanan medis sekaligus mencegah pemborosan biaya akibat kelebihan persediaan (*overstock*) atau kadaluarsa barang.

**Forecasting** adalah proses analisis dan proyeksi kebutuhan material rumah sakit untuk periode mendatang berdasarkan sintesis data:
- Konsumsi historis pemakaian operasional.
- Tren kebutuhan aktivitas pelayanan rumah sakit.
- Permintaan material dari unit kerja (*Material Request*).
- Posisi saldo persediaan saat analisis dilakukan.
- Persediaan pengaman (*safety stock*).
- Estimasi waktu tunggu pengadaan (*lead time*).

Outcome ini menghasilkan dokumen perencanaan resmi yang memuat:
1. **Proyeksi Kebutuhan Material (*Demand Forecast*)**: estimasi volume material yang akan dikonsumsi oleh seluruh unit rumah sakit selama horizon periode perencanaan.
2. **Rekomendasi Jumlah Pengadaan (*Procurement Recommendation*)**: estimasi kuantitas material yang perlu diadakan/dibeli dari pemasok untuk memenuhi proyeksi kebutuhan dengan mempertimbangkan posisi stok dan pasokan berjalan.

Dokumen Forecasting berfungsi murni sebagai **acuan perencanaan (*planning baseline*)** bagi tim pengadaan dan manajemen rumah sakit, **bukan sebagai transaksi pembelian atau komitmen finansial**. Hasil rekomendasi pengadaan menjadi referensi resmi bagi proses pengajuan kebutuhan material (*Material Request* pada `OC-13-01`) maupun inisiasi proses pengadaan (*Purchase Request* pada `OC-13-03`).

---

## 2. Outcome Statement

Satu dokumen perencanaan **Forecasting Kebutuhan Material (*Material Demand Forecast & Procurement Recommendation Plan*)** untuk suatu horizon periode tertentu **telah terbentuk, diverifikasi, dan difinalisasi sebagai rekaman persisten (*persisted snapshot*), memuat proyeksi kebutuhan (*Demand Forecast*) dan rekomendasi jumlah pengadaan (*Procurement Recommendation*) per material aktif beserta penandaan status pengecualian secara transparan, siap dijadikan acuan resmi perencanaan pengadaan rumah sakit.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Purchasing** | **Domain pemilik konteks perencanaan**: Menetapkan parameter periode forecasting, mengonsumsi data permintaan material unit (`PUR-MATREQ`), memproses proyeksi kebutuhan dan rekomendasi pengadaan, mengelola siklus hidup serta revisi dokumen perencanaan, dan menyediakan dasar acuan bagi proses pengadaan lanjutan (`PUR-PURREQ`). |
| **Inventory** | **Penyedia data persediaan dan konsumsi historis**: Menyediakan master katalog material aktif (`INV-MASTER`), posisi saldo fisik dan stok efektif (`INV-STOK`), riwayat konsumsi riil operasional (`INV-PAKAI`), riwayat mutasi barang (`INV-MUTASI`), serta parameter dasar persediaan (*safety stock* dan *lead time*). |
| **Organisasi** | **Penyedia struktur unit kerja & layanan**: Menyediakan identitas dan klasifikasi unit pelayanan, instalasi rawat, dan gudang/depo penyimpanan (`ORG-LAYANAN`) yang menjadi sumber data permintaan, lokasi penyimpanan persediaan, dan titik pemakaian barang. |
| **Layanan Klinis & Penunjang** *(RJL, RNA, IGD, LAB, RAD, KMO, APT)* | **Penyedia konteks tren beban pelayanan**: Menyediakan data tren volume aktivitas operasional (kunjungan poliklinik, sensus rawat inap, tindakan IGD/OK, tes laboratorium, pemeriksaan radiologi, dan transaksi resep) yang relevan sebagai faktor pendorong (*demand drivers*) kebutuhan material. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PUR-FORECAST` Forecasting & Rekomendasi Pengadaan | Purchasing | Capability Candidate |
| `PUR-MATREQ` Material Request | Purchasing | Known |
| `PUR-PURREQ` Purchase Request | Purchasing | Known |
| `PUR-PO` Purchase Order | Purchasing | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-PAKAI` Pakai Barang | Inventory | Known |
| `INV-MUTASI` Mutasi | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Catatan Tata Kelola Arsitektur:**  
> Kapabilitas `PUR-FORECAST` belum terdaftar dalam master `DOMAIN-CATALOG.md` (di mana domain Purchasing saat ini hanya memiliki `PUR-SUPPLIER`, `PUR-MATREQ`, `PUR-PURREQ`, `PUR-PO`, `PUR-DO`, `PUR-FAKTUR`, dan `PUR-RETURN`). Oleh karena itu, kapabilitas ini dicatat secara formal sebagai **Capability Candidate** dan dieskalasikan untuk pembaruan katalog domain pada siklus tata kelola berikutnya.

---

## 5. Outcome Specification

### 5.1 Required Business Facts

- **Hakikat Dokumen Perencanaan (Persisted Snapshot):** Dokumen Forecasting merupakan rekaman fakta perencanaan yang tersimpan secara persisten (*immutable snapshot*) pada saat difinalisasi. Dokumen ini bukan hasil kueri dinamis real-time; perubahan data operasional di kemudian hari tidak boleh mengubah isi dokumen yang telah difinalisasi secara otomatis.
- **Posisi Antara dalam Rantai Pasok:** Forecasting berposisi di antara evaluasi kebutuhan internal dan proses perencanaan/pengajuan pengadaan. Dokumen ini menjadi referensi perencanaan bagi `OC-13-01` (*Material Request*) dan `OC-13-03` (*Purchase Request*), tetapi tidak mengeksekusi proses transaksi tersebut.
- **Dua Pilar Analisis Per Material:** Setiap baris material dalam dokumen wajib menyajikan dua hasil kalkulasi analitis independen:
  1. *Demand Forecast* (Proyeksi Kebutuhan): proyeksi konsumsi material selama periode perencanaan.
  2. *Procurement Recommendation* (Rekomendasi Pengadaan): estimasi jumlah kuantitas yang perlu diadakan dari pemasok.
- **Pembedaan Makna Mutasi Inventory:** Data mutasi barang (`INV-MUTASI`) wajib dibedakan berdasarkan maknanya. Mutasi antar-gudang (misal transfer dari Gudang Utama ke Depo Rawat Jalan/Farmasi) **dilarang otomatis dianggap sebagai konsumsi baru**, karena konsumsi sesungguhnya hanya terjadi saat barang digunakan/dikeluarkan ke pasien/layanan (`INV-PAKAI`).
- **Pencegahan Penghitungan Ganda (*Anti-Double Counting*):**
  - *Outstanding Material Request* (permintaan dari unit yang belum terpenuhi) hanya boleh ditambahkan ke dalam analisis jika kebutuhan tersebut terbukti belum tercakup dalam perhitungan forecast historis dan belum dialokasikan stok fisiknya.
  - Kebutuhan selama *lead time* pengadaan wajib diperhitungkan secara eksplisit, tetapi dilarang ditambahkan kembali apabila rentang waktu *lead time* tersebut telah tercakup di dalam horizon periode forecast yang sama.
  - Pasokan masuk yang sedang berjalan (*incoming supply / on-order*) dari Purchase Order aktif dan stok yang dialokasikan (*allocated stock*) harus diperhitungkan secara konsisten.
- **Non-Negatif Rekomendasi:** Nilai rekomendasi pengadaan dilarang bernilai negatif. Jika posisi stok dan pasokan masuk melampaui kebutuhan periode (kondisi surplus), nilai rekomendasi pengadaan wajib ditetapkan bernilai nol (`0`).
- **Cakupan Material Aktif:** Satu dokumen Forecasting mencakup seluruh material yang berstatus **aktif untuk pengadaan** pada master data (`INV-MASTER`) untuk periode terkait. Material non-aktif tidak diikutsertakan dalam cakupan reguler.
- **Perlakuan Material Tanpa Histori Konsumsi:** Ketiadaan riwayat konsumsi tidak boleh otomatis diartikan bahwa kebutuhan material adalah nol (`0`). Untuk material tanpa histori memadai:
  - Sistem dapat menyediakan estimasi berbasis material sejenis yang relevan.
  - Pengguna dapat memasukkan estimasi manual yang beralasan.
  - Sumber dan metode estimasi wajib tercatat dan dapat ditelusuri (*traceable*).
  - Nilai estimasi dilarang dicatat atau mencemari database konsumsi historis aktual.
  - Material tanpa dasar estimasi yang memadai wajib ditandai sebagai **Pengecualian (*Exception*)** dan tidak dianggap memiliki rekomendasi pengadaan yang valid.
- **Exception-Based Finalization:** Dokumen perencanaan dapat difinalisasi meskipun masih memuat material berstatus pengecualian, asalkan seluruh material tersebut ditandai secara eksplisit dan tidak dianggap memiliki rekomendasi pengadaan yang sah.
- **Pemisahan Status Dokumen vs Status Kelayakan Item:**
  - Status Dokumen: `Draft` atau `Finalized`.
  - Status Kelayakan Analisis Item: `Valid Recommendation` atau `Exception / Insufficient Basis`.
  - Status dokumen `Finalized` tidak mengindikasikan bahwa seluruh material di dalamnya memiliki rekomendasi pengadaan yang valid.
- **Versioning dan Immutability Dokumen:** Pembaruan perencanaan atas dokumen yang telah difinalisasi dilakukan melalui penerbitan revisi baru (misal V1.0 $\rightarrow$ V2.0). Dokumen revisi baru dimulai dengan status `Draft`. Versi `Finalized` sebelumnya tetap menjadi acuan perencanaan aktif yang sah sampai revisi baru resmi difinalisasi.

---

### 5.2 Required Recorded Information

#### A. Informasi Header Dokumen Perencanaan
- **Nomor Dokumen Perencanaan:** Identifikasi unik dokumen forecasting (misal: `FC-YYYYMM-XXXX`).
- **Horizon Periode Perencanaan:** Jenis horizon (Bulanan, Triwulanan, Tahunan) beserta tanggal mulai (*start date*) dan tanggal akhir (*end date*).
- **Nomor Versi Dokumen:** Penomoran versi formal (misal: `v1.0`, `v2.0`).
- **Referensi Versi Sebelumnya:** Tautan ke dokumen versi sebelumnya jika dokumen merupakan hasil revisi.
- **Status Dokumen:** `Draft` atau `Finalized`.
- **Waktu Penyusunan & Finalisasi:** Timestamp pembuatan draf dan timestamp pengesahan dokumen final.
- **Aktor Terkait:** Identitas pengguna penyusun (*author*) dan pengguna yang memfinalisasi (*finalizer/approver*).
- **Catatan & Justifikasi Perencanaan:** Keterangan umum mengenai asumsi makro atau konteks periode perencanaan.

#### B. Informasi Rincian Baris Material (*Line Items*)
- **Identitas Material:**
  - Kode Item Material dan Nama Material (sesuai `INV-MASTER`).
  - Kelompok/Kategori Material (misal: Obat Generik, Obat Paten, BMHP, Gas Medis, Reagen).
  - Satuan Ukuran Perencanaan (*Unit of Measure* / UoM).
- **Parameter Persediaan Acuan:**
  - *Lead Time* Pengadaan (dalam hari/minggu acuan).
  - *Safety Stock* (kuantitas batas aman minimum yang harus dipelihara).
- **Data Posisi Persediaan & Pasokan Saat Analisis:**
  - Saldo Stok Efektif / Stok yang Dapat Digunakan (*usable / available stock* dari `INV-STOK`).
  - Kuantitas Stok Teralokasi (*allocated stock* untuk reservasi unit tertentu).
  - Pasokan Masuk Berjalan (*incoming supply / on-order* dari `PUR-PO` atau transfer intra-organisasi yang belum diterima).
  - Kuantitas Permintaan Tertunda (*outstanding / unfulfilled Material Request* dari `PUR-MATREQ`).
- **Hasil Demand Forecast:**
  - Angka Riwayat Konsumsi Pembanding (rata-rata pemakaian historis periode lalu dari `INV-PAKAI`).
  - Angka Proyeksi Kebutuhan (*Demand Forecast Quantity*).
  - Metode / Dasar Proyeksi:
    - `Historical Consumption` (berdasarkan riwayat konsumsi riil).
    - `Service Trend Adjusted` (riwayat konsumsi disesuaikan dengan tren aktivitas pelayanan).
    - `Analogous Item Estimation` (estimasi berbasis material sejenis).
    - `Manual User Estimation` (estimasi manual oleh staf perencanaan).
  - Tautan Referensi Estimasi (kode item analogi atau catatan justifikasi manual).
- **Hasil Procurement Recommendation:**
  - Kuantitas Rekomendasi Pengadaan (*Procurement Recommendation Quantity*, nilai $\ge 0$).
- **Status Kelayakan Analisis Item:**
  - `Valid Recommendation` — perhitungan didukung data historis atau estimasi yang memadai, siap dijadikan acuan pengadaan.
  - `Exception / Insufficient Basis` — dasar estimasi tidak memadai atau data tidak lengkap; kuantitas rekomendasi tidak sah dijadikan acuan pengadaan.
- **Catatan Pengecualian / Keterangan Khusus:** Catatan wajib apabila berstatus pengecualian atau menggunakan estimasi non-historis.

---

### 5.3 Required Business Conditions

- **Keabsahan Horizon Perencanaan:** Periode awal dan akhir perencanaan terdefinisi secara sah, dengan horizon waktu default bulanan (atau triwulanan/tahunan sesuai pilihan pengguna).
- **Kesesuaian Horizon Waktu Data:** Seluruh variabel kalkulasi (demand forecast, lead time, stok, dan pasokan masuk) disinkronisasikan ke dalam horizon waktu periode yang sama.
- **Validitas Status Material:** Seluruh material yang masuk ke dalam baris analisis terverifikasi berstatus aktif untuk pengadaan pada master katalog material (`INV-MASTER`).
- **Verifikasi Integritas Konsumsi:** Perhitungan konsumsi historis hanya menyerap data transaksi pemakaian riil unit (`INV-PAKAI`) atau pengeluaran mutasi akhir; mutasi transfer antar-lokasi persediaan tidak digandakan sebagai konsumsi.
- **Validasi Unik Outstanding Request:** Permintaan material dari unit (`PUR-MATREQ`) yang disertakan telah divalidasi belum terlayani secara fisik dan belum tercermin dalam rata-rata proyeksi konsumsi berjalan.
- **Non-Pencemaran Data Historis:** Estimasi manual atau analogi material baru disimpan secara terisolasi pada dokumen forecasting dan tidak diinjeksikan ke dalam tabel histori transaksi inventory.
- **Kesiapan Finalisasi Berbasis Pengecualian:** Dokumen perencanaan hanya dapat difinalisasi apabila setiap baris item material telah memiliki status kelayakan yang eksplisit (`Valid Recommendation` atau `Exception / Insufficient Basis`).

---

### 5.4 Completion Proof

- Rekaman dokumen perencanaan Forecasting tersimpan secara persisten dengan nomor identifikasi unik, nomor versi definitif, dan status `Finalized`.
- Seluruh material aktif pengadaan tercakup dalam baris dokumen dengan nilai *Demand Forecast*, nilai *Procurement Recommendation*, dan status kelayakan yang terverifikasi.
- Setiap material berstatus `Exception / Insufficient Basis` tertandai secara eksplisit dengan catatan alasan yang dapat diaudit, serta kuantitas rekomendasinya tidak dapat dikonsumsi oleh proses pemesanan.
- Rekaman *audit trail* mencatat secara permanen tanggal finalisasi, identitas pengguna yang memfinalisasi, serta snapshot nilai-nilai parameter sumber saat pengesahan.
- Dokumen versi `Finalized` berstatus aktif dapat diakses dan dijadikan referensi resmi oleh proses *Material Request* (`OC-13-01`) dan inisiasi pengadaan (`OC-13-03`).

---

## 6. Outcome Boundary

### Start
Dimulai ketika perencana pengadaan atau sistem menginisiasi penyusunan perencanaan kebutuhan material untuk periode horizon tertentu (bulanan, triwulanan, atau tahunan), sistem mengidentifikasi seluruh material aktif pengadaan, serta menghimpun posisi persediaan, riwayat konsumsi operasional, parameter persediaan, dan pasokan berjalan.

### End
Berakhir ketika dokumen perencanaan berhasil ditinjau, disesuaikan, dan disahkan dengan status **`Finalized`** melalui pendekatan *exception-based finalization*, menjadi acuan perencanaan persisten yang tidak berubah (*immutable*), siap dirujuk oleh proses pengajuan dan pengadaan rumah sakit.

---

## 7. Business Constraints

> Aturan bisnis mutlak yang wajib dipatuhi pada Outcome ini.

1. **Bukan Transaksi Pembelian atau Komitmen Finansial:** Forecasting murni instrumen perencanaan kebutuhan. Dokumen ini **dilarang menghasilkan komitmen finansial, utang usaha, atau menerbitkan Purchase Order kepada pemasok secara otomatis**.
2. **Bukan Pengganti Transaksi Inventory:** Dokumen Forecasting dilarang mengubah saldo fisik persediaan, menambah stok, mengurangi stok, atau menggantikan peran pencatatan mutasi/pemakaian pada domain Inventory (`INV-*`).
3. **Pemisahan dari Eksekusi Material Request (OC-13-01):** Dokumen Forecasting menyediakan acuan kuantitas rekomendasi perencanaan, namun tidak menggantikan proses permohonan material resmi unit, pengesahan anggaran unit, maupun persetujuan transfer barang pada `OC-13-01`.
4. **Pembedaan Mutasi vs Konsumsi Riil:** Data mutasi antar-lokasi persediaan (`INV-MUTASI`) tidak boleh diasumsikan secara otomatis sebagai konsumsi baru rumah sakit. Konsumsi hanya dihitung dari pemakaian nyata di unit pelayanan (`INV-PAKAI`).
5. **Anti-Double Counting (Pencegahan Penghitungan Ganda):**
   - *Outstanding Material Request* hanya diakomodasi apabila belum tercakup dalam horizon forecast dan belum dialokasikan dari stok fisik yang tersedia.
   - Kebutuhan selama *lead time* pengadaan wajib diperhitungkan secara eksplisit, tetapi dilarang ditambahkan kembali jika sudah tercakup di dalam horizon forecast yang sama.
   - Pasokan masuk (*incoming supply*) dan alokasi persediaan harus diperhitungkan secara konsisten agar kebutuhan tidak dihitung dua kali.
6. **Batas Bawah Rekomendasi Non-Negatif:** Nilai rekomendasi pengadaan tidak boleh bernilai negatif ($Procurement Recommendation \ge 0$). Jika persediaan dan pasokan berjalan melebihi proyeksi kebutuhan, nilai rekomendasi adalah nol (`0`).
7. **Ketiadaan Histori Bukan Berarti Kebutuhan Nol:** Tidak adanya riwayat konsumsi pada material baru/aktif dilarang diartikan secara sepihak bahwa kebutuhan material adalah nol. Material tersebut wajib ditangani melalui estimasi analogi, estimasi manual, atau ditandai sebagai *Exception*.
8. **Isolasi Data Estimasi:** Nilai estimasi manual atau analogi yang dimasukkan oleh pengguna dilarang disimpan sebagai konsumsi aktual pada riwayat transaksi inventory.
9. **Immutability Dokumen Final:** Dokumen yang telah berstatus `Finalized` bersifat *read-only* dan tidak berubah otomatis bila data real-time berubah. Segala perubahan kebutuhan harus ditempuh melalui pembuatan dokumen revisi baru.
10. **Independensi Versi Revisi Berjalan:** Pembuatan revisi baru dalam status `Draft` tidak menggantikan atau membatalkan dokumen `Finalized` sebelumnya. Versi final sebelumnya tetap menjadi acuan perencanaan aktif yang sah sampai revisi baru difinalisasi.
11. **Pemisahan Status Dokumen dan Status Analisis Item:** Status dokumen `Finalized` tidak menyatakan bahwa seluruh item memiliki rekomendasi yang valid. Pengambilan acuan pengadaan wajib menyaring hanya item-item yang berstatus `Valid Recommendation`.

---

## 8. Business Exceptions

> Kondisi pengecualian bisnis dan perilaku yang diharapkan dari sistem.

| Exception | Expected Behavior |
|-----------|-------------------|
| Material aktif pengadaan belum memiliki riwayat konsumsi operasional | Sistem menawarkan estimasi berbasis material sejenis yang relevan. Jika tidak ada referensi sejenis, pengguna dapat memasukkan estimasi manual. Jika tidak ada estimasi yang memadai, item ditandai sebagai `Exception / Insufficient Basis` dengan rekomendasi tidak valid. Kebutuhan tidak otomatis dianggap nol. |
| Pengguna memasukkan estimasi kebutuhan manual | Nilai estimasi manual dicatat dengan penanda sumber `Manual User Estimation` disertai catatan justifikasi. Nilai ini diisolasi dan dilarang dicatat sebagai konsumsi historis aktual di domain Inventory. |
| Perhitungan menghasilkan kebutuhan pengadaan negatif (posisi surplus) | Nilai *Procurement Recommendation* otomatis ditetapkan menjadi nol (`0`). Catatan surplus persediaan ditampilkan untuk transparansi perencanaan. |
| Rentang waktu *lead time* pengadaan melebihi sisa horizon periode perencanaan | Sistem menandai indikasi *long lead-time warning*. Kebutuhan selama lead time dihitung secara proporsional sesuai horizon tanpa melakukan penambahan ganda pada kebutuhan periode berikutnya. |
| Outstanding Material Request terdeteksi sudah terpenuhi atau sudah dialokasikan dari stok on-hand | Kuantitas Material Request tersebut dikeluarkan dari penambahan kebutuhan untuk mencegah *double counting*. |
| Terjadi perubahan data konsumsi, transaksi stok, atau PO setelah dokumen difinalisasi | Isi dokumen `Finalized` **tetap tidak berubah** (*immutable*). Pengguna yang memerlukan penyesuaian diarahkan untuk menerbitkan versi revisi dokumen baru. |
| Dokumen perencanaan hendak difinalisasi namun terdapat material dengan estimasi yang belum memadai | Mekanisme *exception-based finalization* mengizinkan finalisasi dokumen, dengan syarat seluruh material yang belum memadai ditandai secara eksplisit sebagai `Exception / Insufficient Basis`. Item tersebut diblokir dari acuan pengadaan otomatis. |
| Dokumen perencanaan berstatus `Draft` dibatalkan penyusunannya | Draf dokumen ditandai berstatus `Cancelled` dengan *audit trail*. Dokumen versi `Finalized` sebelumnya (jika ada) tetap berlaku penuh sebagai acuan aktif. |
| Percobaan penerbitan transaksi Purchase Order langsung dari dokumen forecasting | Sistem menolak perintah secara mutlak. Dokumen forecasting hanya dapat dijadikan referensi kebutuhan bagi pembuatan *Material Request* atau *Purchase Request*. |

---

## 9. Acceptance Criteria

> Kriteria pengujian yang dapat diverifikasi untuk membuktikan keberadaan Outcome sesuai spesifikasi.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Sistem berhasil membentuk dokumen perencanaan forecasting persisten yang memuat nilai *Demand Forecast* dan *Procurement Recommendation* per baris material aktif. | Completeness |
| AC-02 | Seluruh material yang ditandai aktif untuk pengadaan pada master data tercakup dalam baris dokumen forecasting pada periode terkait. | Completeness |
| AC-03 | Material yang tidak aktif untuk pengadaan pada master data tidak dimasukkan ke dalam baris analisis dokumen forecasting. | Constraint |
| AC-04 | Analisis konsumsi historis hanya menyerap pemakaian operasional riil (`INV-PAKAI`); mutasi transfer antar-lokasi persediaan (`INV-MUTASI`) tidak dihitung sebagai konsumsi baru. | Correctness |
| AC-05 | Kebutuhan selama *lead time* diperhitungkan secara eksplisit dan tidak ditambahkan kembali apabila telah tercakup dalam horizon forecast yang sama. | Correctness |
| AC-06 | Outstanding Material Request yang telah tercakup dalam forecast atau telah dialokasikan stok fisiknya tidak dihitung ulang sebagai penambahan kebutuhan (*anti-double counting*). | Constraint |
| AC-07 | Dalam kondisi surplus persediaan (stok dan incoming supply melebihi kebutuhan periode), nilai *Procurement Recommendation* bernilai nol (`0`) dan tidak pernah bernilai negatif. | Correctness |
| AC-08 | Material aktif tanpa riwayat konsumsi tidak otomatis memiliki nilai forecast nol (`0`). | Constraint |
| AC-09 | Estimasi manual atau estimasi berbasis material sejenis tercatat dengan sumber yang dapat ditelusuri dan tidak mencemari database konsumsi aktual Inventory. | Correctness |
| AC-10 | Material tanpa dasar estimasi yang memadai ditandai sebagai `Exception / Insufficient Basis` dan kuantitas rekomendasinya tidak dianggap valid. | Exception |
| AC-11 | Sistem mengizinkan finalisasi dokumen (*exception-based finalization*) meskipun memuat material berstatus `Exception / Insufficient Basis`, selama penandaan status item tercatat secara eksplisit. | Correctness |
| AC-12 | Header dokumen berstatus `Finalized` tidak menyebabkan item berstatus `Exception / Insufficient Basis` otomatis dianggap valid. | Correctness |
| AC-13 | Dokumen berstatus `Finalized` bersifat *immutable*; perubahan transaksi data sumber di kemudian hari tidak mengubah angka pada dokumen final tersebut. | Constraint |
| AC-14 | Penerbitan revisi baru menghasilkan draf dokumen versi baru (misal V2.0) tanpa mengubah atau menghapus versi final sebelumnya. | Correctness |
| AC-15 | Dokumen versi final sebelumnya tetap menjadi acuan aktif yang sah selama revisi baru masih berstatus `Draft`. | Constraint |
| AC-16 | Dokumen forecasting tidak menerbitkan Purchase Order, tidak mengikat komitmen finansial ke supplier, dan tidak mengubah saldo fisik persediaan di gudang. | Constraint |
| AC-17 | Setiap dokumen forecasting yang difinalisasi memuat rekaman audit (*audit trail*) lengkap mencakup tanggal finalisasi, identitas finalisator, serta snapshot data parameter acuan. | Completeness |
| AC-18 | Rekomendasi pengadaan dari dokumen final yang valid dapat dibaca dan dijadikan referensi perencanaan oleh proses *Material Request* (`OC-13-01`) dan *Purchase Request* (`OC-13-03`). | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit tidak dicakup oleh Outcome ini.

- **Pembuatan dan Pengesahan Transaksi Material Request:** Pembuatan formulir permintaan barang dari unit pelayanan, verifikasi persetujuan kepala unit, dan reservasi stok gudang $\rightarrow$ **OC-13-01 Material Request** (`PUR-MATREQ`).
- **Pengajuan dan Otorisasi Pengadaan:** Pembuatan dokumen permohonan pembelian resmi, persetujuan anggaran pengadaan, dan komparasi pemasok $\rightarrow$ **OC-13-03 Purchase Request** (`PUR-PURREQ`).
- **Penerbitan dan Komitmen Finansial Purchase Order:** Pembentukan kontrak pemesanan, penerbitan PO ke supplier, negosiasi termin harga, dan pembentukan komitmen utang $\rightarrow$ **OC-13-04 Purchase Order** (`PUR-PO`).
- **Penerimaan Fisik Barang dan Surat Jalan:** Pemeriksaan fisik barang kiriman pemasok, penerimaan delivery order, dan pencatatan berita acara $\rightarrow$ **OC-12-01 Terima Barang (DO)** (`PUR-DO`).
- **Pencatatan Faktur dan Pembayaran Supplier:** Pengakuan utang usaha, pencocokan faktur (*three-way matching*), dan pembayaran kasir $\rightarrow$ **OC-13-05 Faktur Tagihan** (`PUR-FAKTUR`) dan Tata Rekening Domain (`TRK-*`).
- **Pencatatan Transaksi Mutasi dan Pemakaian Fisik:** Mutasi perpindahan stok antar-gudang (`INV-MUTASI`), pencatatan pemakaian barang operasional di poliklinik/bangsal/kamar operasi/lab/rad (`INV-PAKAI`), dan penyesuaian stok fisik opname (`INV-OPNAME`) $\rightarrow$ Inventory Domain.
- **Formulasi Model Matematika Lanjut / AI Algoritmik Lanjutan:** Penerapan algoritma machine learning lanjutan (*deep learning*, *multi-echelon stochastic inventory models*, *SARIMA*, dll.) yang belum dibakukan dalam kebijakan resmi arsitektur rumah sakit $\rightarrow$ *Pending Business Decision* (lihat Bagian 11).

---

## 11. Points Requiring Further Business Decision

> Poin-poin spesifikasi detail yang belum ditentukan dalam dokumentasi arsitektur dasar dan memerlukan keputusan formal lebih lanjut oleh Komite Pengadaan / Product Owner.

1. **Formula Matematis Baku Proyeksi Konsumsi:**  
   Metode matematis spesifik yang akan dijadikan standar default rumah sakit untuk perhitungan konsumsi historis (misalnya: *Simple Moving Average (SMA) 3/6 bulan*, *Weighted Moving Average (WMA)*, atau *Single Exponential Smoothing*).
2. **Kriteria Kesamaan Material Sejenis (Analogi):**  
   Aturan bisnis spesifik untuk menentukan apakah suatu material dapat dijadikan referensi analogi bagi material baru (misalnya: berdasarkan kesamaan kelas terapi obat, kesamaan zat aktif, atau kesamaan kelompok komoditas BMHP).
3. **Kebijakan Pembulatan dan Minimum Order Quantity (MOQ):**  
   Mekanisme pembulatan kuantitas rekomendasi pengadaan terhadap satuan kemasan pabrikan (*Packaging Unit / Pack Size*) atau batas minimum pemesanan dari pemasok (*Minimum Order Quantity*).
4. **Kebijakan Horizon Khusus Material Long Lead-Time:**  
   Aturan penanganan material impor atau bahan khusus yang memiliki waktu tunggu pemesanan (*lead time*) melampaui rentang horizon periode perencanaan normal (misal *lead time* 4 bulan pada perencanaan bulanan).
5. **Ambang Batas Toleransi Deviasi Forecast vs Realisasi:**  
   Ketentuan mengenai persentase deviasi yang memicu evaluasi retrospektif (*forecast accuracy review*) pada siklus perencanaan berikutnya.
