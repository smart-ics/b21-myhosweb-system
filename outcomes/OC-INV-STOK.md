# OUTCOME: Saldo Persediaan Stok (Stok)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-INV-STOK            |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Dalam operasional rumah sakit modern, pengelolaan persediaan barang logistik medis (seperti obat-obatan, vaksin, cairan infus, dan Bahan Medis Habis Pakai / BMHP) maupun logistik umum (seperti alat tulis kantor, linen, dan bahan pembersih) memegang peranan krusial bagi keselamatan pasien (*patient safety*), kelancaran pelayanan klinis, dan kesehatan finansial institusi.

Untuk menjamin ketersediaan logistik di titik pelayanan sekaligus memenuhi standar akreditasi dan kepatuhan regulasi farmasi, rumah sakit membutuhkan pencatatan posisi persediaan yang perpetual, akuntabel, dan dapat dipertanggungjawabkan (*persisted business state*). Otoritas saldo persediaan harus mampu:
1. Mengetahui secara pasti kuantitas barang yang tersedia di setiap lokasi penyimpanan fisik maupun logis (gudang pusat, depo farmasi, bangsal rawat inap, poli rawat jalan, kamar operasi, laboratorium, maupun unit penyiapan sementara).
2. Mempertahankan ketertelusuran asal perolehan barang (*Receipt Source / Batch Provenance*) hingga ke dokumen penerimaan barang (*Goods Receipt / Delivery Order*) dan nilai perolehan harga pokok perolehan (HPP).
3. Mengelola dimensi tanggal kedaluwarsa (*Expiration Date*) secara granular dan menegakkan tata kelola pengeluaran berbasis *First-Expired, First-Out* (FEFO) atau *First-In, First-Out* (FIFO) guna meminimalkan risiko kerugian akibat obat kedaluwarsa.
4. Mencegah stok bernilai negatif tanpa pengecualian (*zero tolerance for negative stock*), mempertahankan riwayat saldo yang telah habis (*depleted balances*) demi integritas audit, serta mencatat setiap perubahan saldo melalui jurnal mutasi yang tidak dapat diubah (*append-only ledger*) dengan mekanisme pembatalan berupa jurnal pembalik (*reverse journal*).

Tanpa keberadaan formal outcome **Stok** (*Inventory Stock Level exists*), rumah sakit akan mengalami kehilangan kontrol persediaan, ketidakmampuan menelusuri nomor batch saat terjadi penarikan obat (*batch recall*), kerancuan valuasi aset persediaan, serta risiko kegagalan pelayanan medis akibat data ketersediaan barang yang tidak mencerminkan fisik riil.

---

## 2. Outcome Statement

Saldo fisik persediaan barang pada setiap lokasi penyimpanan rumah sakit (mencakup rincian item barang, identitas asal penerimaan/batch, tanggal kedaluwarsa, kuantitas sisa, dan valuasi harga pokok perolehan) **telah tercatat secara persisten, akurat, dan mencerminkan ketersediaan kuantitas riil yang dapat digunakan untuk pelayanan maupun operasional rumah sakit (*Inventory Stock Level exists*)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Inventory** (Primary Owner) | Pemilik utama: memelihara kondisi saldo persediaan perpetual di seluruh tingkatan (`INV-STOK`), mengelola agregat batch rumah sakit dan saldo lokasi, menegakkan aturan alokasi pengeluaran (FEFO/FIFO), mencatat riwayat mutasi persediaan yang tidak dapat diubah, serta memvalidasi katalog master barang (`INV-MASTER`). |
| **Organisasi** | Menyediakan struktur organisasi unit kerja, lokasi gudang logistik, depo farmasi, bangsal perawatan, dan unit pelayanan yang sah dan aktif sebagai lokasi persediaan resmi (`ORG-LAYANAN`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> *Catatan Hubungan Lintas Kapabilitas:*  
> Kapabilitas `INV-STOK` bertindak sebagai otoritas penyedia data saldo dan penjaga integritas pergerakan stok (*State Authority & Consequence Sink*). Transaksi bisnis yang memodifikasi saldo stok dikelola oleh kapabilitas dan outcome terkait:
> - Penerimaan barang dari supplier: domain `Purchasing` (`PUR-DO` / `TerimaBrg`).
> - Pemindahan antar-lokasi persediaan: `INV-MUTASI` (`ReqMutasi`, `Mutasi`, `TerimaMutasi`).
> - Konsumsi operasional unit kerja: `INV-PAKAI` (`PakaiBrg`).
> - Penjualan dan peracikan obat pasien: domain `Apotek` (`APT-ORDER`, `APT-DISPENSING`, `APT-SERAH`).
> - Pemusnahan barang rusak/kedaluwarsa: `INV-MUSNAH` (Musnah).
> - Transformasi repack dan produksi: `INV-REPACK` (Repack).
> - Penghitungan fisik dan penyesuaian selisih stok: `INV-OPNAME` (`StokOpname`).

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Keberadaan Agregat Batch Stok (*Stock Batch exists*)**: Setiap persediaan barang yang diakui masuk ke rumah sakit terikat pada satu identitas sumber penerimaan (*Receipt Source / DO Reference*) yang unik, membentuk satu agregat batch yang mempertahankan total kuantitas sisa di tingkat rumah sakit, tanggal masuk, dan nilai harga pokok perolehan (HPP).
- **Keberadaan Saldo Stok Lokasi (*Location Stock Balance exists*)**: Saldo fisik persediaan dikelola secara granular per kombinasi unik: `(Stock Batch, Unit/Lokasi Layanan, Tanggal Kedaluwarsa)`. Satu lokasi persediaan dapat memiliki beberapa saldo lokasi untuk barang yang sama jika berasal dari penerimaan berbeda atau memiliki tanggal kedaluwarsa yang berbeda.
- **Fakta Non-Negatif Mutlak (*Absolute Non-Negative Quantity Fact*)**: Kuantitas sisa (*Remaining Quantity*) baik pada tingkat saldo lokasi maupun tingkat batch rumah sakit tidak pernah bernilai negatif (\(\ge 0\)) dalam kondisi apa pun.
- **Fakta Retensi Saldo Habis (*Depleted Balance Retention Fact*)**: Saldo lokasi yang kuantitas sisanya telah habis menjadi nol (\(\text{Qty Sisa} = 0\)) tidak dihapus (*never hard-deleted*), melainkan tetap dipertahankan sebagai saldo habis (*Depleted Balance*) untuk keperluan akuntabilitas riwayat, audit trail, dan rekonsiliasi.
- **Fakta Konservasi Persediaan (*Inventory Conservation Fact*)**: Total kuantitas sisa suatu batch di tingkat rumah sakit selalu sama dengan penjumlahan kuantitas sisa di seluruh saldo lokasi batch tersebut (\(\text{Qty Sisa Batch} = \sum \text{Qty Sisa Lokasi}\)). Perpindahan antar-lokasi tidak mengubah total saldo batch rumah sakit.
- **Fakta Alokasi Pengeluaran Deterministik (*Deterministic Outbound Allocation Fact*)**: Ketersediaan stok untuk pemenuhan pengeluaran (penjualan apotek, pemakaian unit, atau mutasi keluar) dialokasikan secara deterministik mematuhi aturan prioritas baku:
  1. *Explicit Expiry Selection* (jika transaksi sumber mensyaratkan tanggal kedaluwarsa tertentu).
  2. *FEFO (First-Expired, First-Out)* (di antara saldo yang memiliki tanggal kedaluwarsa, yang paling dekat kedaluwarsa dikeluarkan lebih dulu).
  3. *FIFO (First-In, First-Out)* (berdasarkan tanggal masuk / urutan penerimaan jika tidak memiliki tanggal kedaluwarsa).
- **Fakta Jurnal Mutasi Tidak Dapat Diubah (*Immutable Stock Movement Ledger Fact*)**: Setiap transaksi yang menambah atau mengurangi saldo fisik tercatat sebagai baris mutasi persediaan yang tidak dapat diedit atau dihapus (*append-only*). Pembatalan transaksi dicatat melalui mutasi pembalik (*reverse journal*) yang mereferensikan mutasi asli.

### 5.2 Required Recorded Information

Posisi saldo persediaan mencatat informasi terstruktur pada dua tingkatan entitas saldo serta buku jurnal pendukung:

#### 1. Atribut Batch Persediaan (*Stock Batch Information*)
- **Identitas Batch Unik**: Pengenal unik batch stok di tingkat sistem rumah sakit.
- **Identitas Barang**: Kode barang dan nama barang yang sah dari `INV-MASTER`.
- **Referensi Asal Penerimaan (*Receipt Source / BrgMasukReffId*)**: Identitas dokumen penerimaan awal (nomor DO barang masuk dari purchasing, dokumen transfer eksternal, atau dokumen saldo awal migrasi).
- **Referensi Pesanan (*PO Reference*)**: Nomor surat pesanan/PO terkait (opsional/carry-over).
- **Tanggal dan Waktu Masuk (*Receipt Datetime*)**: Waktu fisik barang pertama kali diakui masuk ke rumah sakit.
- **Harga Pokok Perolehan Satuan (*Unit Valuation / HPP*)**: Nilai perolehan per satuan terkecil barang yang bersifat tetap untuk sumber penerimaan tersebut.
- **Total Kuantitas Sisa Rumah Sakit (*Hospital-wide Remaining Quantity*)**: Akumulasi kuantitas barang dari batch ini yang masih ada di seluruh lokasi rumah sakit.

#### 2. Atribut Saldo Lokasi Persediaan (*Location Stock Balance Information*)
- **Identitas Saldo Lokasi Unik**: Pengenal unik saldo persediaan pada suatu lokasi.
- **Referensi Batch Induk**: Menunjuk ke identitas `Stock Batch` pemilik.
- **Identitas Lokasi Persediaan**: Kode dan nama unit layanan/gudang/depo dari `ORG-LAYANAN` (misal: Gudang Farmasi Pusat, Depo IGD, Bangsal Bedah, Depo Rawat Jalan, Unit Penyiapan Sementara).
- **Tanggal Kedaluwarsa (*Expiration Date*)**: Tanggal batas kedaluwarsa komoditas medis/farmasi (atau nilai tanggal sentinel penanda jika komoditas non-medis tidak memiliki kedaluwarsa).
- **Nomor Batch Manufaktur (*Manufacturer Lot/Batch Number*)**: Nomor batch pabrik pembuat obat/alkes (opsional, untuk penelusuran recall).
- **Kuantitas Sisa di Lokasi (*Location Remaining Quantity*)**: Jumlah fisik barang yang saat ini tersedia dan dapat digunakan di lokasi bersangkutan (\(\ge 0\)).
- **Status Ketersediaan Saldo**: Status aktif (*Active* jika \(\text{Qty Sisa} > 0\)) atau habis (*Depleted* jika \(\text{Qty Sisa} = 0\)).
- **Token Versi Konkurensi (*Version / OCC Token*)**: Penanda versi untuk mencegah penulisan bersamaan yang bentrok (*Optimistic Concurrency Control*).

#### 3. Atribut Jejak Mutasi Persediaan (*Stock Movement Ledger Information*)
- **Identitas Mutasi Unik**: Nomor urut/pengenal unik baris mutasi.
- **Referensi Saldo Lokasi**: Menunjuk ke saldo lokasi yang terpengaruh.
- **Nomor Referensi Transaksi Sumber (*Source Transaction Reference / TrsReffId*)**: Nomor dokumen bisnis yang mendasari perubahan stok (nomor DO, nomor mutasi, nomor nota penjualan, nomor pemakaian barang, nomor opname).
- **Jenis Mutasi (*Movement Kind*)**: Klasifikasi bisnis mutasi (Penerimaan Barang, Pengeluaran Mutasi, Penerimaan Mutasi, Pengeluaran Penjualan, Pemakaian Internal, Penyesuaian Bertambah, Penyesuaian Berkurang, Pemusnahan, Jurnal Pembalik Pembatalan).
- **Arah dan Kuantitas Mutasi**: Kuantitas Masuk (*Qty In*) atau Kuantitas Keluar (*Qty Out*) — tepat salah satu bernilai \(> 0\).
- **Valuasi Satuan (HPP)**: Nilai perolehan satuan barang saat mutasi dicatat.
- **Tanggal dan Waktu Efektif Mutasi**: Waktu resmi mutasi berlaku secara bisnis.
- **Referensi Mutasi Pembalik (*Reverses Movement ID*)**: Mengidentifikasi ID mutasi asli jika baris ini merupakan jurnal pembalik/pembatalan.

### 5.3 Required Business Conditions

- **Katalog Barang Valid**: Barang yang dikelola saldonya harus terdaftar dengan status aktif dalam katalog master barang (`INV-MASTER`).
- **Lokasi Persediaan Sah**: Lokasi penyimpanan harus terdaftar dengan status aktif dalam struktur organisasi unit layanan rumah sakit (`ORG-LAYANAN`).
- **Integritas Non-Negatif**: Saldo kuantitas tidak boleh berkurang melebihi kuantitas sisa yang tersedia (\(\text{Qty Keluar} \le \text{Qty Sisa Lokasi}\)). Jika permintaan melebihi kuantitas tersedia, transaksi wajib ditolak atau dipenuhi secara parsial sesuai kebijakan transaksi sumber.
- **Eksekusi Alokasi Keluar**:
  - Pengeluaran hanya dapat mengambil stok dari lokasi persediaan yang diminta oleh transaksi sumber.
  - Alokasi memenuhi kuantitas yang diminta dengan mengonsumsi satu atau lebih saldo lokasi secara berurutan sesuai prioritas (Explicit ED \(\rightarrow\) FEFO \(\rightarrow\) FIFO).
- **Konservasi Perpindahan**: Pengeluaran mutasi dari lokasi asal dan penerimaan mutasi di lokasi tujuan wajib mempertahankan identitas asal penerimaan (*Receipt Source*), tanggal kedaluwarsa, dan HPP yang sama.
- **Pembalikan Transaksi Sah**: Pembatalan mutasi persediaan hanya diizinkan jika transaksi sumber terbukti sah dibatalkan dan tidak menimbulkan saldo negatif pada saldo lokasi yang dipulihkan.

### 5.4 Completion Proof

- Rekaman saldo persediaan pada tingkat batch (`Stock Batch`) dan tingkat lokasi (`Location Stock Balance`) tersimpan secara persisten.
- Kuantitas saldo persediaan secara tepat sama dengan hasil kalkulasi historis seluruh mutasi masuk dikurangi mutasi keluar (\(\text{Qty Sisa} = \sum \text{Qty In} - \sum \text{Qty Out}\)).
- Informasi saldo persediaan yang aktif dan siap pakai dapat disajikan secara instan (*real-time queryable*) untuk kebutuhan pemeriksaan ketersediaan (*availability check*), dispensing farmasi, mutasi gudang, dan pemakaian unit.

---

## 6. Outcome Boundary

### Start

Dimulai saat persediaan suatu barang pertama kali diakui masuk ke sistem inventori rumah sakit:
1. Pengesahan penerimaan barang pertama dari supplier (`TerimaBrg` via `PUR-DO`).
2. Pencatatan saldo awal persediaan saat inisialisasi/migrasi sistem baru.
3. Penyesuaian masuk hasil pengesahan stok opname perdana (`StokOpname` via `INV-OPNAME`).

Pengakuan ini membentuk identitas `Stock Batch` dan menginisiasi `Location Stock Balance` pertama di lokasi penerimaan dengan kuantitas sisa awal.

### End

Outcome ini merupakan **kondisi bisnis persisten yang terpelihara secara berkesinambungan (*continuous state maintenance*)**:
- Setiap kali terjadi peristiwa bisnis persediaan yang sah (mutasi keluar, mutasi masuk, pemakaian, penjualan, penyesuaian opname, atau pemusnahan), saldo lokasi dan saldo batch diperbarui seketika dalam transaksi yang sama dengan pencatatan jurnal mutasinya.
- Ketika kuantitas sisa mencapai nol (\(0\)), saldo beralih ke status habis (*Depleted Balance*) namun **tidak diakhiri/dihapus**, melainkan tetap dipertahankan sebagai rekaman permanen posisi persediaan untuk audit dan rekonsiliasi perpetual.

---

## 7. Business Constraints

1. **Absolute Non-Negative Invariant**: Kuantitas sisa persediaan pada saldo lokasi maupun batch dilarang keras bernilai negatif (\(\text{Qty Sisa} \ge 0\)). Sistem wajib menggagalkan seluruh transaksi yang memicu saldo negatif tanpa pengecualian.
2. **Receipt Source Provenance Invariant**: Setiap kuantitas persediaan wajib terikat pada tepat satu sumber penerimaan (*Receipt Source / DO*). Sumber penerimaan ini tidak boleh diubah, dilebur, atau dihilangkan selama siklus hidup barang (termasuk saat mutasi antar-lokasi, pemakaian, maupun retur).
3. **Depleted Balance Retention Invariant**: Saldo lokasi yang kuantitasnya telah habis menjadi nol (\(\text{Qty Sisa} = 0\)) wajib tetap dipertahankan dalam basis data sebagai *Depleted Balance*. Penghapusan fisik baris saldo dilarang keras.
4. **Immutable Movement & Reverse-Journal Invariant**: Baris mutasi persediaan yang telah dicatat bersifat permanen dan tidak dapat diubah (*immutable*). Pembatalan atau koreksi mutasi wajib dilakukan dengan menambahkan baris jurnal pembalik (*reverse movement*) yang menunjuk ke mutasi asli; dilarang melakukan *hard-delete* maupun penandaan *soft-delete* (`Vod*`).
5. **No Stock Invention Invariant**: Kapabilitas stok tidak boleh menciptakan alasan bisnis transaksi sendiri. Setiap mutasi persediaan wajib memiliki referensi dokumen transaksi sumber (*Source Transaction Reference*) yang sah dan telah diotorisasi oleh domain/kapabilitas terkait.
6. **Optimistic Concurrency Control Invariant**: Pembaruan saldo lokasi wajib dilindungi oleh mekanisme kendali konkurensi berbasis versi token (*Version OCC*) guna mencegah penulisan ganda yang hilang (*lost updates*) atau penjualan berlebih (*overselling*) saat beberapa transaksi terjadi bersamaan pada lokasi yang sama.
7. **Hospital-Wide Conservation Invariant**: Total kuantitas sisa batch di tingkat rumah sakit wajib selalu setara dengan jumlah kuantitas sisa seluruh lokasi untuk batch tersebut. Pemindahan barang antar-lokasi di dalam rumah sakit tidak boleh mengubah total kuantitas batch rumah sakit.
8. **Valuation Stability Invariant**: Harga pokok perolehan (HPP) satuan terikat permanen pada identitas sumber penerimaan batch dan tidak boleh diubah secara sepihak di luar transaksi penyesuaian resmi.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Kuantitas permintaan pengeluaran melebihi saldo fisik tersedia di lokasi (\(\text{Qty Minta} > \text{Qty Sisa}\)) | Sistem menolak pengesahan transaksi pengeluaran persediaan dengan kode status penolakan *Insufficient Stock*; tidak mengizinkan pemotongan saldo dan tidak menghasilkan saldo negatif. |
| Bentrok konkurensi saat dua transaksi memotong saldo lokasi yang sama secara simultan (*OCC Concurrency Conflict*) | Transaksi yang datang belakangan digagalkan secara aman, dibatalkan perubahannya (*rollback*), dan diarahkan untuk membaca ulang saldo terkini sebelum mencoba kembali. |
| Transaksi sumber meminta tanggal kedaluwarsa spesifik (*Explicit Expiry Selection*), namun saldo untuk ED tersebut tidak mencukupi atau telah habis | Sistem menolak alokasi dan memberitahukan ketidaktersediaan stok dengan tanggal kedaluwarsa yang diminta; tidak mengalihkan alokasi ke ED lain secara sepihak tanpa otorisasi pengguna. |
| Terjadi pembatalan transaksi sumber yang telah menghasilkan mutasi stok sebelumnya | Sistem menerima instruksi pembatalan, memverifikasi keberadaan mutasi asli, dan menerbitkan mutasi pembalik (*reverse journal*) sebesar kuantitas yang dibatalkan untuk mengembalikan saldo lokasi ke kondisi semula. |
| Upaya pembalikan (*reversal*) terhadap mutasi yang sudah pernah dibalik sebelumnya | Sistem menolak pembalikan ganda (*duplicate reversal*) untuk mencegah penggelembungan saldo persediaan secara tidak sah. |
| Lokasi persediaan atau master barang berstatus non-aktif saat transaksi diproses | Sistem menolak pencatatan mutasi dan pembentukan saldo pada entitas master yang tidak aktif. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Sistem berhasil membentuk rekaman saldo persediaan multi-dimensi per kombinasi barang, sumber penerimaan (batch/DO), lokasi unit layanan, tanggal kedaluwarsa, kuantitas sisa, dan HPP. | Completeness |
| AC-02 | Sistem menolak secara absolut seluruh transaksi pengeluaran yang kuantitasnya melebihi kuantitas sisa tersedia di lokasi bersangkutan, menjamin saldo tidak pernah bernilai negatif (\(\ge 0\)). | Constraint |
| AC-03 | Sistem mengeksekusi alokasi pengeluaran secara deterministik mematuhi urutan prioritas: *Explicit Expiry Selection*, disusul *FEFO* (tanggal kedaluwarsa terdekat), dan disusul *FIFO* (urutan masuk penerimaan). | Correctness |
| AC-04 | Saldo lokasi yang kuantitas sisanya berkurang menjadi nol (\(0\)) tetap tersimpan dalam sistem dengan status *Depleted Balance* dan dapat ditampilkan dalam riwayat audit. | Integrity |
| AC-05 | Setiap perubahan kuantitas saldo dicatat dalam baris mutasi persediaan yang tidak dapat diedit/dihapus (*append-only*), lengkap dengan referensi transaksi sumber dan jenis mutasi. | Auditability |
| AC-06 | Pembatalan transaksi persediaan berhasil menerbitkan baris mutasi pembalik (*reverse journal*) dengan mencatat identitas mutasi asli (*Reverses Movement ID*) dan memulihkan saldo persediaan secara presisi. | Correctness |
| AC-07 | Penjumlahan kuantitas sisa seluruh saldo lokasi untuk suatu batch selalu bernilai tepat sama dengan kuantitas sisa batch di tingkat rumah sakit (\(\text{Qty Batch} = \sum \text{Qty Lokasi}\)). | Conservation |
| AC-08 | Sistem mendeteksi konflik konkurensi (OCC) dan menggagalkan transaksi yang mencoba memperbarui saldo lokasi yang versinya telah berubah di tengah transaksi. | Robustness |

---

## 10. Out of Scope

- **Otorisasi dan Pembuatan Dokumen Transaksi Sumber**: Pengesahan surat pesanan, faktur pembelian, resep dokter, permintaan mutasi, dan nota penjualan merupakan tanggung jawab domain asal (`Purchasing`, `Apotek`, `Rawat Jalan`, `Rawat Inap`, dll.).
- **Prosedur Pengadaan dan Hubungan Pemasok**: Manajemen katalog pemasok, negosiasi harga, dan verifikasi fisik faktur pengadaan merupakan tanggung jawab Domain Purchasing (`PUR-PO`, `PUR-DO`, `PUR-FAKTUR`).
- **Alur Kerja Klinis dan Pelayanan Farmasi**: Validasi resep medis, telaah obat, peracikan, dan edukasi penyerahan obat kepada pasien merupakan tanggung jawab Domain Apotek (`APT-TELAAH`, `APT-DISPENSING`, `APT-SERAH`).
- **Pelaksanaan dan Penjadwalan Hitung Fisik Lapangan**: Pengaturan jadwal opname, pembentukan tim hitung fisik, dan penginputan hasil *stock count* lapangan merupakan tanggung jawab Outcome `StokOpname` (`INV-OPNAME`).
- **Jurnal Keuangan Buku Besar (*General Ledger*)**: Pembukuan ayat jurnal debit dan kredit akuntansi keuangan rumah sakit merupakan tanggung jawab domain Akuntansi Keuangan.
