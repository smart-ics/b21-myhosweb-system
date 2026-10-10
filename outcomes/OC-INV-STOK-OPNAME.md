# OUTCOME: Rekonsiliasi Fisik Stok Opname (StokOpname)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-INV-STOK-OPNAME     |
| Version     | 1.1                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Dalam operasional rumah sakit modern, pengelolaan persediaan logistik medis (seperti sediaan farmasi, obat-obatan berisiko tinggi / *High Alert*, narkotika, psikotropika, vaksin, dan Bahan Medis Habis Pakai / BMHP) serta logistik non-medis (seperti linen, alat tulis kantor, bahan pembersih, dan reagen laboratorium) memegang peranan vital bagi kelangsungan pelayanan klinis, keselamatan pasien (*patient safety*), kepatuhan regulasi kefarmasian, dan pengendalian aset keuangan institusi.

Secara berkala maupun insidental, rumah sakit wajib melakukan pembuktian kebenaran fisik atas saldo persediaan yang tercatat di sistem informasi persediaan (*perpetual inventory record*). Kegiatan stock opname mendukung cakupan menyeluruh (*Full Opname*) maupun pemeriksaan terarah/sampling (*Partial/Spot Opname*) dan bertujuan untuk:
1. Menemukan dan mengidentifikasi selisih (*variance*) antara kuantitas fisik riil di rak/penyimpanan dengan kuantitas saldo sistem teoritis yang direkonstruksi dari buku besar pada saat penghitungan dilakukan (*reconstructed system quantity at count time*).
2. Menjamin integritas penghitungan melalui metode penghitungan buta (*Blind Count*) bagi staf pelaksana di lapangan tanpa menampilkan saldo sistem, guna mengeliminasi bias konfirmasi (*confirmation bias*).
3. Mendukung fleksibilitas pencatatan fisik dalam berbagai satuan kemasan logistik (*Packaging Unit of Measure* seperti boks, strip, botol, vial, atau ampul) dengan normalisasi deterministik ke Satuan Dasar terkecil (*Base Unit of Measure*).
4. Memverifikasi ketepatan identitas fisik barang hingga tingkat granularitas nomor batch/lot manufaktur dan tanggal kedaluwarsa (*expiration date*), mencegah peredaran sediaan farmasi kedaluwarsa atau cacat batch di titik pelayanan.
5. Menegakkan tata kelola pengendalian intern (*internal control*) dan pemisahan tugas (*segregation of duties*) melalui mekanisme hitung ulang terbuka (*Open Count Recount*) oleh supervisor independen atas barang berselisih yang dievaluasi terhadap saldo sistem waktu hitung ulang (*reconstructed at recount time*), dilengkapi kewajiban klasifikasi alasan selisih (*mandatory discrepancy reason*).
6. Menyediakan alur tata kelola persetujuan manajerial (*Manager Approval Governance*) yang seragam (termasuk mekanisme bypass verifikasi saat selisih nol, penolakan untuk perbaikan/rework, dan pembatalan sesi) sebelum hasil rekonsiliasi disahkan.
7. Menghasilkan rekonsiliasi hasil stock opname yang sah, terkunci, dan dapat dipertanggungjawabkan (*persisted physical stock reconciliation*) sebagai dasar resmi penyesuaian persediaan (*inventory adjustment*) oleh pemegang otoritas saldo persediaan (`INV-STOK`).

Tanpa keberadaan formal outcome **StokOpname** (*Physical Stock Reconciliation exists*), rumah sakit rentan mengalami distorsi data ketersediaan obat, kebocoran/kehilangan barang yang tidak terdeteksi (*shrinkage*), pembukuan persediaan fiktif, temuan audit kepatuhan BPOM/Kemenkes, serta risiko kegagalan klinis akibat barang yang tercatat tersedia di sistem ternyata tidak ada secara fisik di depo/ruang perawatan.

---

## 2. Outcome Statement

Hasil penghitungan fisik persediaan pada suatu lokasi persediaan organisasi rumah sakit (mencakup cakupan sesi *Full* atau *Partial*, penghitungan buta per tupel barang-batch-kedaluwarsa, normalisasi ke satuan dasar terkecil, deteksi barang tak terhitung, perbandingan terhadap saldo sistem hasil rekonstruksi waktu hitung, verifikasi hitung ulang terbuka oleh supervisor dengan klasifikasi alasan selisih, dan otorisasi manajerial) **telah direkonsiliasi, diverifikasi keabsahannya, dan disahkan secara persisten sebagai laporan resmi hasil stock opname yang membekukan kuantitas final serta menerbitkan kandidat penyesuaian untuk modul persediaan eksternal (*Physical Stock Reconciliation exists*)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Inventory** (Primary Owner) | Pemilik utama: mengelola cakupan sesi (*Full/Partial*), penghitungan fisik buta, normalisasi satuan dasar, identifikasi selisih persediaan, verifikasi hitung ulang supervisor, klasifikasi alasan selisih, otorisasi sesi manajerial, dan penerbitan laporan hasil rekonsiliasi serta kandidat penyesuaian (`INV-OPNAME`), memvalidasi master barang dan rasio konversi satuan (`INV-MASTER`), serta menyediakan data transaksi historis untuk rekonstruksi saldo sistem dan menerima kandidat penyesuaian yang disetujui untuk pembaruan buku besar persediaan (`INV-STOK`). |
| **Organisasi** | Menyediakan struktur resmi lokasi persediaan rumah sakit (`ORG-LAYANAN` seperti Gudang Farmasi Pusat, Depo Rawat Jalan, Depo Rawat Inap, Depo IGD, Depo OK, Laboratorium, dan Bangsal Perawatan), serta data petugas pelaksana (*counter*), supervisor verifikator (*recounter*), dan kepala unit/manajer penyetuju (*approver*) yang berwenang (`ORG-PPA`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `INV-OPNAME` Stok Opname | Inventory | Known (Primary) |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Tenaga Medis / Petugas | Organisasi | Known |

> *Hubungan Lintas Kapabilitas & Pemisahan Batas:*  
> - `INV-OPNAME` bertindak sebagai pemilik penuh proses konfigurasi sesi, penghitungan fisik buta, deteksi selisih, verifikasi hitung ulang terbuka, klasifikasi alasan selisih, penentuan kuantitas final, dan otorisasi manajerial. Siklus hidup kapabilitas ini berakhir saat sesi berstatus disetujui (**Approved**).
> - `INV-STOK` bertindak sebagai penyedia data pergerakan persediaan untuk merekonstruksi saldo sistem teoritis pada waktu hitung (*Count Time*) maupun waktu hitung ulang (*Recount Time*), serta bertindak sebagai modul eksternal yang mengonsumsi hasil rekonsiliasi yang disetujui (`Approved`) untuk mengeksekusi penyesuaian fisik ke buku besar stok (*movement ledger posting*).
> - `INV-MASTER` menjamin keabsahan kode barang, nama, klasifikasi, Satuan Dasar (*Base UoM*), dan tabel konversi satuan kemasan (*Packaging UoM*).
> - `ORG-LAYANAN` dan `ORG-PPA` menjamin keabsahan lokasi fisik opname serta penegakan pemisahan tugas peran (*maker-checker-approver*).

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Keberadaan Sesi Tunggal Aktif per Lokasi (*Single Active Session exists*)**: Suatu lokasi persediaan (`ORG-LAYANAN`) hanya boleh memiliki paling banyak satu sesi stock opname yang berstatus aktif (*in-progress*) pada satu waktu. Sesi baru tidak dapat dibuka sebelum sesi aktif sebelumnya disetujui (`Approved`), ditolak permanen (`Rejected`), atau dibatalkan (`Cancelled`).
- **Definisi Cakupan Sesi (*Session Scope Fact*)**: Sesi mendefinisikan cakupannya secara tegas:
  - **Full Opname**: Seluruh persediaan yang berada di lokasi dievaluasi. Barang yang tercatat pada saldo sistem namun tidak tercatat dalam penghitungan fisik secara otomatis dievaluasi sebagai barang terhitung dengan kuantitas nol (\(\text{Count Qty} = 0\)) dan ditandai sebagai Barang Selisih (*Variance Item / Missing Stock*).
  - **Partial / Spot Opname**: Hanya persediaan yang termasuk dalam manifes atau kategori tertentu yang dievaluasi.
- **Granularitas Penghitungan Tupel (*Tuple-Level Counting Fact*)**: Setiap entri fisik dicatat pada tingkat tupel granular: `(Barang, Nomor Batch/Lot, Tanggal Kedaluwarsa)`. Evaluasi selisih ditegakkan pada tingkat tupel ini.
- **Normalisasi Satuan Kemasan ke Satuan Dasar (*UoM Normalization Fact*)**: Kuantitas fisik yang diinput staf dalam satuan kemasan logistik (*Packaging UoM*) dikonversi dan disimpan secara deterministik dalam Satuan Dasar terkecil (*Base UoM*) barang sebelum dibandingkan dengan saldo sistem.
- **Penghitungan Buta untuk Staf Pelaksana (*Blind Count Fact*)**: Pada tahap penghitungan (*Counting*), staf pelaksana di lapangan tidak diperlihatkan angka saldo sistem teoretis untuk mencegah bias konfirmasi (*confirmation bias*).
- **Konsolidasi Nilai Hitung Tunggal (*Consolidated Count Tally Fact*)**: Setiap tupel barang mempertahankan tepat satu nilai kuantitas hitung konsolidasi. Penginputan ulang atas tupel yang sama oleh staf akan menimpa (*overwrite*) nilai sebelumnya dan memperbarui stempel waktu hitung (*Count Time*).
- **Rekonstruksi Saldo Sistem pada Waktu Hitung (*Reconstructed System Quantity at Count Time*)**: Perbandingan selisih awal dilakukan dengan membandingkan kuantitas fisik terhadap saldo sistem teoritis yang direkonstruksi persis pada titik waktu hitung (*Count Time*).
- **Identifikasi Selisih Deterministik (*Variance Identification Fact*)**: Setiap tupel yang memiliki \(\text{Count Qty} \ne \text{System Qty}\) pada waktu hitung secara otomatis ditandai sebagai Barang Selisih (*Variance Item*).
- **Bypass Verifikasi untuk Selisih Nihil (*Zero-Variance Verification Bypass Fact*)**: Jika seluruh barang yang dihitung dalam suatu sesi memiliki selisih nol (\(\text{Variance} = 0\)), sesi secara otomatis melewati tahap verifikasi dan berpindah langsung dari `Counting` ke `WaitingApproval`.
- **Verifikasi Hitung Ulang Terbuka oleh Supervisor (*Open Count Recount Fact*)**: Jika terdapat barang selisih, Supervisor melakukan hitung ulang independen dengan visibilitas penuh terhadap saldo sistem dan selisih awal (*Open Count*).
- **Rekonstruksi Saldo Sistem pada Waktu Hitung Ulang (*Recount-Time Balance Reconstruction Fact*)**: Hasil hitung ulang supervisor dibandingkan terhadap saldo sistem yang direkonstruksi persis pada titik waktu hitung ulang (*Recount Time*), menjamin transaksi operasional yang terjadi di antara waktu hitung awal dan hitung ulang tetap diperhitungkan secara akurat.
- **Kewajiban Klasifikasi Alasan Selisih (*Mandatory Discrepancy Reason Fact*)**: Jika setelah hitung ulang selisih tetap ada (\(\text{Recount Qty} \ne \text{System Qty at Recount Time}\)), supervisor wajib mencatat klasifikasi alasan selisih standar (*Discrepancy Reason*) dan catatan penjelasan investigasi sebelum item dapat berstatus `Verified`. Kuantitas hitung ulang menjadi Kuantitas Final (*Final Quantity*).
- **Tata Kelola Persetujuan Manajerial Seragam (*Uniform Manager Approval Fact*)**: Seluruh sesi wajib melalui penelaahan formal oleh Kepala Instalasi / Manajer (`ORG-PPA`). Manajer dapat menyetujui sesi (`Approved`), menolak untuk perbaikan (*Rework* kembali ke `Verifying` atau `Counting`), atau menolak permanen (`Rejected`).
- **Penyelesaian Siklus pada Status Disetujui (*Domain Lifecycle Termination at Approved*)**: Batas siklus hidup outcome ini tercapai dan berakhir secara persisten saat sesi disahkan (**Approved**). Sesi membekukan laporan rekonsiliasi dan menerbitkan daftar Kandidat Penyesuaian (*Adjustment Candidates*) untuk dikonsumsi oleh `INV-STOK`.

---

### 5.2 Required Recorded Information

Dokumen rekonsiliasi stok opname mencatat informasi terstruktur pada tingkat sesi (*header*), rincian penghitungan (*items*), hasil hitung ulang (*recounts*), serta log persetujuan/penolakan:

#### 1. Atribut Sesi Stock Opname (*Session Information*)
- **Identitas Sesi Unik**: Nomor sesi unik standar rumah sakit (misal: `SO-FAR-202610-0001`).
- **Identitas Lokasi Persediaan**: Kode dan nama lokasi persediaan sah dari `ORG-LAYANAN`.
- **Cakupan Sesi (*Session Scope*)**: `Full` (seluruh persediaan lokasi) atau `Partial` (spot opname berbasis manifes/kategori).
- **Manifes Cakupan (*Scope Manifest*)**: Daftar kode barang/kategori yang dievaluasi (jika berstatus `Partial`).
- **Waktu Mulai dan Selesai Sesi**: Periode operasional sesi berlangsung.
- **Status Sesi Opname**: `Draft`, `Counting`, `WaitingVerification`, `Verifying`, `WaitingApproval`, `Approved`, `Rejected`, `Cancelled`.
- **Petugas Penanggung Jawab Sesi**: ID dan nama penanggung jawab dari `ORG-PPA`.
- **Ringkasan Rekonsiliasi**:
  - Total item dihitung (*Total Counted Items*).
  - Total item cocok / nihil selisih (*Zero Variance Items*).
  - Total item berselisih (*Variance Items*).
  - Total item tak terhitung yang di-nol-kan (*Uncounted Missing Items* - khusus sesi `Full`).
  - Total nominal selisih lebih (*Surplus Valuation* dalam Rupiah).
  - Total nominal selisih kurang (*Deficit/Shrinkage Valuation* dalam Rupiah).
  - Netto nilai finansial selisih opname (*Net Variance Valuation*).

#### 2. Atribut Rincian Item Penghitungan (*Counted Item Information*)
- **Identitas Rincian Hitung Unik**: ID baris penghitungan fisik.
- **Tupel Identitas Fisik**:
  - Kode dan nama barang dari `INV-MASTER`.
  - Nomor Batch / Lot manufaktur.
  - Tanggal Kedaluwarsa (*Expiration Date*).
- **Satuan Input & Konversi**:
  - Satuan Kemasan Input (*Packaging UoM*, misal: Boks).
  - Faktor Konversi ke Satuan Dasar (*Conversion Factor*, misal: 1 Boks = 100 Tablet).
  - Satuan Dasar Terkecil (*Base UoM*, misal: Tablet).
- **Kuantitas Hitung Fisik Konsolidasi (*Count Quantity*)**: Kuantitas fisik hasil hitung staf yang telah dinormalisasi ke *Base UoM* (\(\ge 0\)).
- **Waktu Hitung Fisik (*Count Time*)**: Stempel waktu saat entri hitung dicatat.
- **Identitas Staf Penghitung (*Counted By*)**: ID dan nama staf pelaksana dari `ORG-PPA`.
- **Kuantitas Sistem pada Waktu Hitung (*Reconstructed System Quantity at Count Time*)**: Saldo teoritis sistem pada titik *Count Time*.
- **Nilai Selisih Awal (*Initial Variance*)**: \(\text{Count Qty} - \text{System Qty at Count Time}\).
- **Harga Pokok Perolehan Satuan (HPP)**: Nilai perolehan per satuan terkecil saat sesi dibuka.
- **Nilai Finansial Selisih Awal**: Nominal rupiah (\(\text{Initial Variance} \times \text{HPP}\)).
- **Status Item**: `Match` (selisih = 0) atau `PendingVerification` (selisih \(\ne 0\)).

#### 3. Atribut Verifikasi Hitung Ulang (*Recount Result Information*)
- **Waktu Hitung Ulang (*Recount Time*)**: Stempel waktu saat verifikasi fisik dilakukan supervisor.
- **Identitas Supervisor Pemverifikasi (*Recounted By*)**: ID dan nama supervisor independen dari `ORG-PPA`.
- **Kuantitas Hitung Ulang (*Recount Quantity*)**: Kuantitas fisik hasil verifikasi supervisor dalam *Base UoM* (\(\ge 0\)).
- **Kuantitas Sistem pada Waktu Hitung Ulang (*Reconstructed System Quantity at Recount Time*)**: Saldo teoritis sistem yang direkonstruksi pada titik *Recount Time*.
- **Kuantitas Final yang Disetujui (*Final Quantity*)**: Kuantitas resmi yang dikunci (\(\text{Final Quantity} = \text{Recount Quantity}\) untuk item selisih; atau \(\text{Count Quantity}\) untuk item cocok).
- **Selisih Final (*Final Variance*)**: \(\text{Final Quantity} - \text{System Quantity at Recount Time}\).
- **Nilai Finansial Selisih Final**: Nominal rupiah (\(\text{Final Variance} \times \text{HPP}\)).
- **Klasifikasi Alasan Selisih Standar (*Discrepancy Reason*)**: Kode alasan standar (wajib terisi jika selisih final \(\ne 0\)):
  - `DAMAGED_EXPIRED`: Barang rusak atau kedaluwarsa di rak belum di-write-off.
  - `MISPLACED`: Salah letak rak / tertukar lokasi fisik.
  - `ADMIN_ERROR`: Kesalahan administrasi penerimaan, mutasi belum di-posting, atau salah input UoM.
  - `UNKNOWN_THEFT`: Selisih tidak terjelaskan / dugaan kehilangan fisik.
- **Catatan Investigasi Supervisor**: Penjelasan kualitatif hasil penelusuran supervisor.
- **Status Verifikasi Item**: `Verified`.

#### 4. Atribut Otorisasi Manajerial (*Manager Approval & Governance Information*)
- **Identitas Manajer Peninjau (*Reviewed By*)**: ID dan nama manajer/kepala instalasi dari `ORG-PPA`.
- **Waktu Keputusan Otorisasi (*Decision Datetime*)**: Tanggal dan waktu keputusan diambil.
- **Jenis Keputusan Otorisasi**:
  - `APPROVED`: Sesi disetujui, laporan hasil opname dikunci permanen, kandidat penyesuaian diterbitkan.
  - `REWORK_REQUESTED`: Sesi ditolak dengan instruksi perbaikan (dikembalikan ke status `Verifying` atau `Counting`).
  - `REJECTED`: Sesi ditolak permanen; sesi ditutup tanpa penerbitan kandidat penyesuaian.
- **Catatan & Instruksi Manajer**: Feedback tertulis atas telaah hasil opname dan justifikasi selisih.
- **Daftar Kandidat Penyesuaian (*Adjustment Candidates Payload*)**: Rincian item berselisih yang disahkan untuk diteruskan ke `INV-STOK`.

---

### 5.3 Required Business Conditions

- **Aturan Lokasi Tunggal & Satu Sesi Aktif**: Lokasi harus terdaftar aktif dalam `ORG-LAYANAN`, dan tidak boleh ada sesi lain yang sedang berjalan di lokasi tersebut.
- **Penegakan Pemisahan Tugas (*Strict Segregation of Duties*)**:
  - Staf pelaksana penghitungan awal (*Counter*) dilarang keras melakukan hitung ulang (*Recounter*) pada item yang dihitungnya sendiri.
  - Petugas yang memberikan persetujuan (*Approver*) wajib memiliki kewenangan manajerial unit.
- **Pemisahan Barang Rusak / Kedaluwarsa**: Jika selisih disebabkan oleh barang yang kedaluwarsa atau rusak fisik, kuantitas tersebut tidak boleh disahkan sebagai stok siap pakai, melainkan diteruskan ke proses pemusnahan resmi melalui `INV-MUSNAH`.
- **Kemandirian Operasional**: Pelaksanaan opname di satu lokasi tidak menghentikan operasional pelayanan di lokasi lain.
- **Batas Wewenang Domain**: Kapabilitas `INV-OPNAME` tidak melakukan pemostingan jurnal mutasi stok pada buku besar persediaan; pemostingan mutasi merupakan wewenang penuh `INV-STOK`.

---

### 5.4 Completion Proof

- Rekaman Sesi Stock Opname tersimpan secara persisten dengan nomor sesi unik.
- Status sesi bernilai **Disahkan (Approved)**.
- Seluruh item yang dievaluasi memiliki kuantitas final yang terkunci (*Final Quantity*), dan seluruh sisa selisih memiliki rekaman hitung ulang independen, klasifikasi alasan selisih standar (*Discrepancy Reason*), dan catatan investigasi.
- Dokumen Laporan Hasil Stock Opname (*Stock Opname Result Report*) dan daftar Kandidat Penyesuaian (*Adjustment Candidates*) diterbitkan secara lengkap dengan nilai finansial selisih yang dibekukan (*frozen*).
- Riwayat sesi, stempel waktu, identitas staf penghitung, supervisor pemverifikasi, dan manajer penyetuju tercatat permanen dalam jejak audit yang tidak dapat dihapus (*immutable audit trail*).

---

## 6. Outcome Boundary

### Start

Dimulai saat penanggung jawab persediaan membuka **Sesi Stock Opname baru (*Stock Opname Session Opened*)**:
1. Menetapkan lokasi persediaan (`ORG-LAYANAN`) dan cakupan sesi (`Full` atau `Partial`).
2. Sesi dibentuk dalam status **Draft** dan beralih ke **Counting** saat penghitungan fisik buta dimulai.

### End

Outcome ini tercapai (*established*) dan siklus domain **selesai (terminated)** saat **Laporan Hasil Stock Opname disahkan secara formal oleh Manajer (*Approved*)**:
- Seluruh selisih fisik telah diverifikasi melalui hitung ulang supervisor dan dilengkapi alasan selisih.
- Seluruh kuantitas final dan nilai valuasi selisih telah dikunci permanen.
- Sesi menerbitkan daftar resmi Kandidat Penyesuaian (*Adjustment Candidates*) untuk modul persediaan eksternal (`INV-STOK`).

*Interaksi Hilir (Downstream Consumption):*  
Setelah status `Approved` tercapai, modul eksternal `INV-STOK` mengonsumsi kandidat penyesuaian untuk memposting mutasi persediaan resmi pada buku besar stok (`AdjIn` / `AdjOut`).

---

## 7. Business Constraints

1. **BR-SO-001 (Session Scope Definition)**: Setiap sesi wajib mendefinisikan cakupannya sebagai `Full` (seluruh persediaan lokasi) atau `Partial` (berdasarkan manifes/kategori terpilih).
2. **BR-SO-002 (Single Active Session per Location)**: Satu lokasi persediaan dilarang memiliki lebih dari satu sesi opname aktif bersamaan. Sesi baru hanya dapat dibuka jika sesi sebelumnya telah berstatus `Approved`, `Rejected`, atau `Cancelled`.
3. **BR-SO-003 (Counting Granularity)**: Setiap pencatatan fisik wajib merekam tupel `(Barang, Batch/Lot, Tanggal Kedaluwarsa)`.
4. **BR-SO-004 (Unit of Measure Normalization)**: Kuantitas fisik yang diinput dalam satuan kemasan (*Packaging UoM*) wajib dinormalisasi secara deterministik ke Satuan Dasar terkecil (*Base UoM*) barang.
5. **BR-SO-005 (Consolidated Count Tally)**: Setiap tupel barang mempertahankan satu nilai kuantitas hitung konsolidasi; penginputan ulang atas tupel yang sama menimpa (*overwrite*) nilai sebelumnya dan memperbarui `Count Time`.
6. **BR-SO-006 (Blind Count for Staff)**: Pada fase `Counting`, kuantitas sistem dilarang ditampilkan kepada staf penghitung fisik.
7. **BR-SO-007 (Uncounted Items in Full Opname)**: Pada sesi berstatus `Full`, seluruh barang dalam saldo sistem lokasi yang tidak dicatat dalam penghitungan fisik otomatis di-evaluasi dengan `Count Qty = 0` dan ditandai sebagai Barang Selisih (stok hilang).
8. **BR-SO-008 (Initial System Quantity Reconstruction)**: Perbandingan selisih awal wajib membandingkan kuantitas fisik terhadap saldo sistem yang direkonstruksi dari buku besar persediaan persis pada titik `Count Time`.
9. **BR-SO-009 (Variance Existence)**: Barang Selisih (*Variance Item*) tercipta apabila kuantitas fisik yang dinormalisasi tidak sama dengan saldo sistem hasil rekonstruksi (\(\text{Variance} \ne 0\)).
10. **BR-SO-010 (Zero-Variance Verification Bypass)**: Jika seluruh item yang dihitung dalam suatu sesi memiliki selisih nol, sesi langsung melewati fase `WaitingVerification` dan `Verifying`, berpindah langsung dari `Counting` ke `WaitingApproval`.
11. **BR-SO-011 (Open Count for Supervisor Recount)**: Supervisor yang melakukan hitung ulang pada fase `Verifying` memiliki visibilitas terhadap saldo sistem dan nilai selisih awal (*Open Count*).
12. **BR-SO-012 (Recount System Quantity Reconstruction)**: Penghitungan ulang supervisor wajib membandingkan `Recount Quantity` terhadap saldo sistem yang direkonstruksi persis pada titik waktu hitung ulang (`Recount Time`), menjamin transaksi operasional di antara hitung awal dan hitung ulang tetap diperhitungkan.
13. **BR-SO-013 (Single Recount Limit)**: Satu barang selisih hanya boleh memiliki paling banyak satu kali hasil hitung ulang (*Recount Result*). Kuantitas hitung ulang supervisor secara definitif menjadi Kuantitas Final (*Final Quantity*).
14. **BR-SO-014 (Mandatory Discrepancy Reason)**: Jika selisih tetap ada setelah hitung ulang, supervisor wajib mencatat klasifikasi alasan selisih standar (*Discrepancy Reason*) dan catatan penjelasan investigasi sebelum item dapat berstatus `Verified`.
15. **BR-SO-015 (Complete Verification Precondition)**: Seluruh barang selisih wajib berstatus `Verified` sebelum Laporan Hasil Stock Opname dapat digenerasi dan diajukan untuk persetujuan.
16. **BR-SO-016 (Uniform Manager Approval)**: Seluruh sesi wajib melalui persetujuan formal manajerial tanpa pengecualian, baik yang memiliki selisih maupun yang berselisih nol.
17. **BR-SO-017 (Manager Rejection & Rework)**: Jika manajer menolak hasil opname pada fase `WaitingApproval`, manajer wajib memberikan catatan alasan. Sesi dapat dikembalikan untuk perbaikan (*Rework* ke `Verifying` atau `Counting`), atau ditolak permanen (`Rejected`).
18. **BR-SO-018 (Session Cancellation)**: Sesi dapat dibatalkan (`Cancelled`) oleh pihak berwenang kapan saja sebelum persetujuan formal diberikan. Sesi yang dibatalkan bersifat terminal dan tidak dapat dilanjutkan.
19. **BR-SO-019 (Domain Lifecycle Boundary)**: Siklus hidup domain stock opname selesai secara definitif saat mencapai status `Approved`. Domain ini tidak memiliki wewenang atas pemostingan buku besar persediaan hilir.
20. **BR-SO-020 (Historical Traceability)**: Seluruh data sesi, rincian hitung, hitung ulang supervisor, justifikasi alasan selisih, dan log keputusan manajerial bersifat permanen (*immutable*) dan dapat diaudit setiap saat.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Upaya membuka sesi baru saat masih ada sesi aktif di lokasi yang sama (*Concurrent Active Session Attempt*) | Sistem menolak pembuatan sesi baru dengan pesan pelanggaran *Single Active Session Constraint*; pengguna harus menyelesaikan atau membatalkan sesi yang sedang aktif terlebih dahulu. |
| Barang fisik ditemukan di lokasi namun tidak terdaftar dalam saldo sistem pada waktu hitung (*Unrecorded Physical Item / Ghost Surplus*) | Sistem mencatat saldo sistem sebagai 0, menetapkan seluruh fisik sebagai selisih lebih (*surplus*), memvalidasi kode barang pada `INV-MASTER`, dan mewajibkan verifikasi hitung ulang supervisor untuk mengonfirmasi keabsahan fisik serta mencatat alasan selisih. |
| Barang terdaftar di sistem namun tidak ditemukan sama sekali di rak pada Full Opname (*Missing Uncounted Stock*) | Sistem secara otomatis menetapkan kuantitas fisik = 0 pada saat hitung awal selesai, menandai item sebagai `PendingVerification`, dan mewajibkan supervisor melakukan penelusuran fisik sebelum menetapkan selisih hilang. |
| Terjadi transaksi fisik/resep saat penghitungan sedang berjalan (*Concurrent Operational Movement*) | Sistem menggunakan stempel waktu hitung (*Count Time* untuk hitung awal, dan *Recount Time* untuk hitung ulang) untuk merekonstruksi saldo sistem historis, sehingga transaksi yang sah setelah stempel waktu tersebut tidak menghasilkan selisih palsu (*phantom variance*). |
| Manajer menolak hasil opname karena justifikasi selisih belum memadai (*Manager Rejection with Rework*) | Sistem mencatat catatan revisi manajer, mengembalikan status sesi ke `Verifying` (atau `Counting`), dan membuka kembali akses supervisor/staf untuk melakukan investigasi perbaikan. |
| Manajer menolak hasil opname secara permanen (*Terminal Rejection*) | Sesi ditandai sebagai `Rejected`, seluruh data dibekukan tanpa menerbitkan kandidat penyesuaian, dan penghitungan ulang memerlukan pembukaan sesi baru. |
| Sesi dibatalkan sebelum persetujuan (*Session Aborted*) | Sesi dialihkan ke status `Cancelled`, alasan pembatalan disimpan, dan tidak ada kandidat penyesuaian yang diterbitkan ke `INV-STOK`. |
| Kesalahan konversi satuan kemasan yang diinput staf | Sistem memvalidasi faktor konversi pada `INV-MASTER`; jika satuan tidak sah atau faktor konversi tidak ditemukan, sistem menolak entri hitung hingga satuan yang valid dipilih. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Sistem berhasil membentuk Sesi Stock Opname dengan konfigurasi cakupan `Full` atau `Partial`, dan menolak pembukaan sesi baru jika masih terdapat sesi aktif pada lokasi yang sama. | Completeness & Constraint |
| AC-02 | Pada tahap `Counting`, sistem menyembunyikan saldo sistem dari staf pelaksana (*Blind Count*) dan mendukung pencatatan dalam satuan kemasan (*Packaging UoM*) dengan normalisasi otomatis ke Satuan Dasar (*Base UoM*). | Integrity & Correctness |
| AC-03 | Pada sesi `Full`, sistem secara otomatis mengidentifikasi barang saldo sistem yang tidak terhitung fisik sebagai barang berkuantitas hitung nol (\(\text{Count Qty} = 0\)) dan menandainya sebagai Barang Selisih. | Completeness |
| AC-04 | Sistem merekonstruksi saldo sistem awal pada titik `Count Time` dan merekonstruksi saldo sistem hitung ulang pada titik `Recount Time` untuk mengisolasi mutasi operasional konkuren. | Correctness |
| AC-05 | Jika seluruh barang memiliki selisih nol, sistem secara otomatis melewati tahap `WaitingVerification`/`Verifying` dan langsung beralih ke `WaitingApproval` (*Zero-Variance Bypass*). | Workflow |
| AC-06 | Sistem menolak staf yang sama melakukan hitung ulang (*Recount*) atas barang yang dihitungnya sendiri (*Segregation of Duties*). | Integrity |
| AC-07 | Sistem mewajibkan pencatatan kode klasifikasi alasan selisih standar (*Discrepancy Reason*) dan catatan supervisor pada seluruh barang yang tetap berselisih setelah hitung ulang sebelum dapat berstatus `Verified`. | Constraint |
| AC-08 | Sistem memfasilitasi persetujuan manajerial seragam, mendukung alur perbaikan (*Rework*), penolakan permanen (`Rejected`), dan pembatalan sesi (`Cancelled`). | Governance |
| AC-09 | Sesi yang telah disetujui (`Approved`) membekukan seluruh data rekonsiliasi secara permanen dan menerbitkan daftar Kandidat Penyesuaian (*Adjustment Candidates*) yang valid untuk dikonsumsi oleh `INV-STOK`. | Integrability |
| AC-10 | Seluruh entri penghitungan, hitung ulang supervisor, catatan investigasi alasan selisih, dan log persetujuan/penolakan tersimpan permanen dalam jejak audit yang tidak dapat dihapus (*immutable audit trail*). | Auditability |

---

## 10. Out of Scope

- **Pemostingan Penyesuaian Saldo ke Buku Besar Persediaan (*Inventory Adjustment Ledger Posting*)**: Eksekusi pembaruan saldo fisik dan pembuatan baris jurnal mutasi persediaan merupakan wewenang penuh Outcome `Stok` (`INV-STOK`).
- **Pemusnahan Fisik dan Penghapusan Aset Obat Kedaluwarsa/Rusak**: Otorisasi berita acara dan eksekusi pemusnahan barang kedaluwarsa merupakan wewenang kapabilitas `INV-MUSNAH`.
- **Perencanaan Pengadaan & Perhitungan Reorder Point**: Perhitungan kebutuhan restock pasca-opname merupakan wewenang Domain `Purchasing` (`PUR-MATREQ`, `PUR-FORECAST`).
- **Dispensing dan Pelayanan Resep Pasien**: Verifikasi resep dan penyerahan obat merupakan wewenang Domain `Apotek` (`APT-TELAAH`, `APT-DISPENSING`, `APT-SERAH`).
- **Pembuatan Ayat Jurnal Akuntansi Buku Besar (*General Ledger Posting*)**: Pembukuan ayat jurnal debit/kredit kerugian selisih persediaan (*shrinkage*) ke dalam buku besar akuntansi rumah sakit merupakan wewenang domain Akuntansi Keuangan.
