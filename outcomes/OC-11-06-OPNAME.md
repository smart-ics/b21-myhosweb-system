# OUTCOME: Opname

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-06     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Opname menghasilkan **hasil resmi penghitungan persediaan** pada satu lokasi persediaan (*Inventory Location*), yang menunjukkan jumlah fisik persediaan riil, perbandingannya dengan catatan persediaan pada waktu penghitungan, selisih yang ditemukan, serta hasil verifikasi independen dan persetujuan bertingkat atas selisih tersebut.

Outcome ini menetapkan fakta bisnis persediaan yang kredibel, akuntabel, dan sah untuk menjadi **dasar penyesuaian persediaan** (*Inventory Adjustment*).

Tanpa hasil Opname yang sah dan terverifikasi, setiap perbedaan antara kondisi fisik dan catatan persediaan tidak dapat dipertanggungjawabkan, serta tidak memiliki legitimasi bisnis untuk mengubah saldo persediaan rumah sakit.

---

## 2. Outcome Statement

Hasil resmi penghitungan fisik persediaan pada satu *Inventory Location* **telah diverifikasi secara independen dan disetujui (*Approved*) oleh Manager beserta konsekuensi bisnis dari selisih yang ditemukan, sebagai catatan resmi yang sah dan siap menjadi dasar penyesuaian persediaan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Inventory (`INV`)** | Pemilik utama outcome Opname (`INV-OPNAME`): menyelenggarakan penghitungan fisik, membandingkan fisik dengan catatan persediaan pada waktu penghitungan (`INV-STOK`), mengidentifikasi selisih, mencatat hasil verifikasi independen, dan menerbitkan hasil opname resmi yang disetujui sebagai dasar penyesuaian persediaan. |
| **Apotek (`APT`)** | Konteks operasional sesi opname farmasi (SC-11): unit layanan farmasi yang menyelenggarakan sesi penghitungan pada lokasi persediaan apotek terkait. |
| **Organisasi (`ORG`)** | Menyediakan konteks lokasi persediaan (`ORG-LAYANAN`) serta tata kelola pemisahan fungsi petugas (*Segregation of Duties*): penghitung awal, verifikator selisih, pemeriksa fisik (Supervisor), dan penyetuju hasil opname (Manager). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `INV-OPNAME` Stok Opname | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan / Personel Berwenang | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

1. **Satu Sesi = Satu Lokasi Persediaan (*Single Location Scope*):** Satu sesi Opname hanya berlaku untuk satu *Inventory Location* tertentu.
2. **Cakupan Sesi Terdefinisi (*Defined Session Scope*):** Sesi memiliki batasan cakupan item yang eksplisit, baik mencakup seluruh item lokasi (*Full Opname*) maupun sebagian item (*Partial / Cycle Counting*). Hanya item yang termasuk dalam cakupan sesi yang menjadi bagian dari hasil opname. Item di luar cakupan tidak dianggap berselisih dan tidak ikut menjadi dasar penyesuaian.
3. **Pencatatan Fisik Nol (*Physical Zero*):** Item yang termasuk dalam cakupan sesi tetapi secara fisik tidak ditemukan di lokasi tetap wajib dicatat dengan jumlah fisik **0**.
4. **Waktu Penghitungan per Item (*Point-in-Time Attribution*):** Setiap item yang dihitung memiliki pencatatan waktu penghitungan fisik yang pasti.
5. **Kondisi Pembanding Waktu Penghitungan (*Point-in-Time Comparison*):** Perbandingan dengan catatan persediaan merepresentasikan kondisi catatan persediaan tepat pada waktu item tersebut dihitung. Transaksi persediaan operasional tetap dapat berlangsung selama proses Opname; transaksi yang terjadi setelah waktu penghitungan suatu item tidak mengubah kondisi catatan persediaan yang menjadi pembanding bagi item tersebut.
6. **Verifikasi Selisih Independen (*Independent Discrepancy Verification*):**
   - Jika jumlah fisik awal sama dengan catatan persediaan, hasil penghitungan awal langsung menjadi hasil final.
   - Jika terdapat perbedaan (selisih), item wajib diverifikasi melalui penghitungan ulang oleh pihak berwenang yang berbeda dari penghitung awal.
   - Penghitung awal dilarang memverifikasi selisihnya sendiri (*Segregation of Duties*).
   - Hasil penghitungan ulang menjadi jumlah fisik final untuk item yang berselisih.
7. **Kelengkapan Menyeluruh Sebelum Persetujuan (*All-or-Nothing Finality*):** Seluruh item dalam cakupan sesi wajib memiliki hasil fisik final yang tuntas. Tidak boleh ada item yang masih menunggu verifikasi atau menggantung ketika hasil opname diajukan untuk *Approval*.
8. **Akuntabilitas Pemeriksaan dan Persetujuan Bertingkat (*Tiered Review and Approval*):**
   - Supervisor bertanggung jawab memastikan kebenaran jumlah fisik final, terutama untuk item yang berselisih.
   - Manager memberikan persetujuan resmi (*Approval*) atas hasil opname dan konsekuensi bisnis dari selisih tersebut, sehingga hasil secara resmi sah menjadi dasar penyesuaian persediaan.
9. **Ketiadaan Nilai Finansial (*Quantity-Only Scope*):** Hasil resmi opname mencatat fakta kuantitas fisik final, catatan persediaan pembanding, dan kuantitas selisih. Opname tidak menetapkan nilai finansial (Rupiah) dari selisih tersebut.
10. **Imutabilitas Catatan Resmi (*Immutable Official Record*):** Hasil Opname yang telah disetujui (*Approved*) merupakan catatan historis resmi yang dilarang diedit atau dihapus secara langsung (*no silent mutation*). Setiap koreksi pasca-Approval wajib dilakukan melalui proses korektif resmi tersendiri dengan pertanggungjawaban dan persetujuan terpisah, dengan tetap mempertahankan catatan lama sebagai riwayat historis.
11. **Pemisahan dari Eksekusi Penyesuaian (*Decoupling from Inventory Adjustment*):** Tanggung jawab bisnis Outcome Opname berakhir pada hasil yang telah disetujui (*Approved*). Pelaksanaan penyesuaian saldo persediaan, pembaruan kartu stok, dan posting ke *Stock Ledger* bukan tanggung jawab Outcome Opname.

---

### 5.2 Required Recorded Information

Pencatatan hasil resmi Opname wajib mencakup:
- Identitas unik sesi opname;
- Identitas *Inventory Location* yang dihitung;
- Waktu pembukaan dan penetapan cakupan sesi;
- Tipe cakupan sesi (*Full Opname* atau *Partial / Cycle Counting*);
- Daftar seluruh item persediaan yang termasuk dalam cakupan sesi;
- Rincian untuk setiap item dalam cakupan sesi:
  - Identitas item persediaan (`INV-MASTER`);
  - Satuan ukuran persediaan;
  - Waktu pencatatan penghitungan fisik awal;
  - Identitas petugas penghitung awal;
  - Jumlah fisik awal;
  - Jumlah catatan persediaan pada waktu penghitungan;
  - Status selisih awal (cocok atau berselisih);
  - Informasi verifikasi selisih (jika berselisih): identitas petugas verifikator independen, waktu verifikasi penghitungan ulang, dan jumlah fisik hasil hitung ulang;
  - Jumlah fisik final;
  - Jumlah selisih final (kuantitas fisik final dikurangi catatan persediaan pembanding);
- Catatan konfirmasi verifikasi Supervisor atas kepastian kebenaran jumlah fisik final;
- Bukti persetujuan Manager:
  - Identitas Manager yang menyetujui;
  - Waktu persetujuan (*Approval timestamp*);
  - Pernyataan persetujuan resmi atas hasil opname dan konsekuensi bisnis selisih;
- Status resmi siklus hidup sesi opname: **Approved** (tanggung jawab bisnis opname selesai) dan **Closed** (seluruh penyesuaian persediaan lanjutan tuntas dan sesi diarsipkan);
- Catatan jejak audit dan riwayat koreksi (jika ada proses korektif resmi pasca-Approval).

---

### 5.3 Required Business Conditions

- Sesi opname dibuka untuk satu *Inventory Location* yang sah dan aktif;
- Setiap item yang dihitung memiliki rekaman waktu penghitungan fisik yang valid;
- Catatan persediaan pembanding merepresentasikan kondisi catatan tepat pada waktu penghitungan item;
- Pihak yang memverifikasi selisih adalah personel yang berbeda dari penghitung awal item tersebut (*Segregation of Duties*);
- 100% item dalam cakupan sesi telah memiliki status hasil fisik final sebelum pengajuan *Approval*;
- Pengajuan *Approval* ditolak jika masih terdapat item yang belum final atau masih menunggu verifikasi;
- Persetujuan diberikan oleh Manager yang berwenang atas hasil fisik dan konsekuensi bisnis dari selisih persediaan.

---

### 5.4 Completion Proof

> What proves this Outcome is complete?

1. **Penyelesaian Bisnis (*Approved*):**
   - Dokumen hasil opname memperoleh persetujuan resmi dari Manager dan bertransisi ke status **Approved**;
   - Bukti otorisasi Manager (identitas penyetuju dan waktu persetujuan) tercatat sah;
   - Seluruh item dalam cakupan sesi memiliki catatan kuantitas fisik final, catatan persediaan pembanding pada waktu hitung, dan selisih final yang lengkap tanpa ada item yang menggantung;
   - Dokumen hasil opname terkunci (*immutable*) dari perubahan langsung dan sah menjadi referensi dasar penyesuaian persediaan.
2. **Penyelesaian Administratif / Siklus Sistem (*Closed*):**
   - Sesi opname bertransisi ke status **Closed** setelah proses penyesuaian persediaan lanjutan (*Inventory Adjustment*) pada domain persediaan selesai dieksekusi dengan sukses dan sesi diarsipkan secara administratif.

---

## 6. Outcome Boundary

### Start

Dimulai ketika sesi opname pada satu *Inventory Location* dibuka secara resmi dan cakupan item (*Full Opname* atau *Partial / Cycle Counting*) ditetapkan untuk mulai dilakukan penghitungan fisik persediaan.

### End

- **Batas Tanggung Jawab Bisnis Opname:** Berakhir ketika hasil penghitungan fisik dan selisih seluruh item dalam cakupan sesi disetujui secara resmi oleh Manager (**Approved**), menghasilkan catatan resmi yang siap digunakan sebagai dasar penyesuaian persediaan.
- **Batas Siklus Administratif / Sistem:** Sesi opname ditutup secara administratif (**Closed**) setelah proses penyesuaian saldo persediaan pada domain persediaan selesai dieksekusi dan sesi diarsipkan.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Single Location Scope Invariant:** Satu sesi opname hanya berlaku untuk satu *Inventory Location*.
2. **Explicit Item Scope Invariant:** Hanya item yang terdaftar dalam cakupan sesi yang menjadi bagian dari hasil opname dan menjadi dasar penyesuaian persediaan. Item di luar cakupan tidak dianggap berselisih dan tidak disesuaikan.
3. **Physical Zero Accountability Invariant:** Item yang masuk dalam cakupan sesi namun secara fisik tidak ditemukan di lokasi persediaan wajib dicatat dengan jumlah fisik 0.
4. **Point-in-Time Attribution Invariant:** Setiap item yang dihitung wajib memiliki waktu penghitungan, dan perbandingan dengan catatan persediaan wajib merepresentasikan kondisi catatan persediaan tepat pada waktu item tersebut dihitung.
5. **Post-Count Independence Invariant:** Transaksi persediaan operasional yang terjadi setelah waktu penghitungan suatu item dilarang mengubah kondisi catatan persediaan yang menjadi pembanding bagi item tersebut.
6. **Segregation of Duties Invariant:** Verifikasi atas item yang berselisih wajib dilakukan melalui penghitungan ulang oleh pihak berwenang yang berbeda dari penghitung awal. Penghitung awal dilarang memverifikasi selisihnya sendiri.
7. **Supervisor Verification Invariant:** Supervisor bertanggung jawab memastikan kebenaran jumlah fisik final, terutama untuk item yang berselisih, sebelum hasil diajukan ke Manager.
8. **Manager Business Approval Invariant:** Approval Manager merupakan persetujuan atas hasil opname dan konsekuensi bisnis dari selisih tersebut, sehingga hasil sah menjadi dasar penyesuaian persediaan.
9. **All-or-Nothing Approval Invariant:** Approval Manager hanya dapat diberikan setelah seluruh item dalam cakupan sesi memiliki hasil final. Dilarang mengajukan atau memberikan Approval jika masih ada item yang menggantung atau menunggu verifikasi.
10. **Quantity-Only Scope Invariant:** Hasil opname hanya menetapkan jumlah fisik final, catatan pembanding, dan selisih kuantitas. Opname dilarang menetapkan nilai finansial (Rupiah) atas selisih.
11. **Official Record Immutability Invariant:** Hasil opname yang telah berstatus *Approved* merupakan catatan resmi dan tidak boleh diedit atau dihapus untuk mengubah fakta historis secara langsung (*no silent mutation*).
12. **Controlled Correction Invariant:** Koreksi atas kesalahan yang ditemukan pasca-Approval wajib dilakukan melalui proses korektif resmi dengan pertanggungjawaban dan persetujuan tersendiri, dengan tetap mempertahankan catatan hasil lama sebagai riwayat historis.
13. **Adjustment Responsibility Decoupling Invariant:** Tanggung jawab Outcome Opname berakhir pada hasil yang telah disetujui (*Approved*). Pelaksanaan penyesuaian saldo persediaan, pembaruan kartu stok, dan posting ke *Stock Ledger* bukan tanggung jawab Outcome Opname.
14. **Operational Policy Neutrality Invariant:** Kebijakan format penghitungan (*Full Opname* vs *Cycle Counting*) maupun sarana pencatatan fisik (kertas vs *barcode scanner* / aplikasi mobile) merupakan kebijakan operasional yang tidak mengubah kaidah integritas bisnis opname.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Item Cakupan Tidak Ditemukan Fisik** | Item tetap dicatat dengan jumlah fisik 0. Jika catatan persediaan > 0, sistem menetapkan status berselisih dan mewajibkan verifikasi ulang independen sebelum kuantitas 0 dinyatakan final. |
| **Penghitung Awal Mencoba Memverifikasi Selisih Sendiri** | Tindakan verifikasi ditolak oleh sistem karena melanggar *Segregation of Duties*. Verifikasi selisih wajib dialihkan dan dilaksanakan oleh petugas pemeriksa yang berbeda dari penghitung awal. |
| **Pengajuan Approval dengan Item Menggantung (*Pending Verification*)** | Pengajuan *Approval* diblokir oleh sistem. Seluruh item yang berselisih wajib menyelesaikan penghitungan ulang dan memiliki hasil fisik final sebelum diajukan ke Manager. |
| **Transaksi Operasional Berlangsung Selama Sesi Opname** | Transaksi operasional persediaan tetap diizinkan berjalan. Kondisi catatan pembanding tetap mengacu pada catatan persediaan tepat saat item dihitung; transaksi yang terjadi setelah waktu hitung tidak membatalkan atau mengubah catatan pembanding item tersebut. |
| **Upaya Modifikasi atau Penghapusan Hasil Pasca-Approval** | Perubahan atau penghapusan langsung atas hasil opname berstatus *Approved* ditolak. Perbaikan harus diproses melalui mekanisme koreksi resmi terpisah dengan persetujuan tersendiri. |
| **Koreksi Resmi Diterbitkan Pasca-Approval** | Diterbitkan dokumen koreksi resmi baru yang merujuk pada sesi opname asal; catatan hasil opname asli tetap dipertahankan utuh dalam riwayat audit historis. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Sesi opname hanya dapat dibuat untuk satu *Inventory Location* tertentu. | Constraint |
| **AC-02** | Sesi opname membatasi pencatatan dan perbandingan hanya pada item yang termasuk dalam cakupan sesi (*Full Opname* atau *Partial / Cycle Counting*). | Completeness |
| **AC-03** | Item dalam cakupan sesi yang tidak ditemukan secara fisik di lokasi tercatat dengan jumlah fisik 0. | Completeness |
| **AC-04** | Setiap item yang dihitung mencatat waktu penghitungan, dan catatan persediaan pembanding merepresentasikan kondisi pada waktu penghitungan tersebut. | Correctness |
| **AC-05** | Transaksi operasional persediaan yang terjadi setelah waktu penghitungan tidak mengubah nilai catatan persediaan pembanding untuk item yang bersangkutan. | Correctness |
| **AC-06** | Item dengan jumlah fisik sama dengan catatan persediaan langsung ditetapkan sebagai hasil fisik final tanpa kewajiban verifikasi ulang. | Correctness |
| **AC-07** | Item dengan selisih kuantitas wajib melalui penghitungan ulang oleh pihak berwenang yang berbeda dari penghitung awal, dan hasil hitung ulang menjadi hasil fisik final. | Constraint |
| **AC-08** | Sistem menolak proses verifikasi selisih jika petugas verifikator sama dengan petugas penghitung awal. | Constraint |
| **AC-09** | Pengajuan *Approval* ditolak jika masih terdapat item dalam cakupan sesi yang belum memiliki hasil final atau masih menunggu verifikasi. | Constraint |
| **AC-10** | *Approval* hanya dapat diberikan oleh Manager dan mengesahkan seluruh hasil fisik final beserta konsekuensi bisnis selisih menjadi status **Approved**. | Correctness |
| **AC-11** | Hasil resmi opname mencantumkan kuantitas fisik final, catatan persediaan pembanding, dan kuantitas selisih tanpa mencantumkan nilai finansial (Rupiah). | Completeness |
| **AC-12** | Hasil opname yang berstatus **Approved** terkunci secara permanen dari pengeditan atau penghapusan langsung. | Constraint |
| **AC-13** | Koreksi kesalahan pasca-Approval tidak mengubah catatan historis lama, melainkan membentuk catatan korektif baru dengan persetujuan tersendiri. | Exception |
| **AC-14** | Tanggung jawab bisnis Opname selesai pada status **Approved**, dan transisi ke status **Closed** terjadi setelah proses penyesuaian persediaan lanjutan berhasil diselesaikan dan sesi diarsipkan. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pelaksanaan Penyesuaian Saldo Persediaan (*Inventory Adjustment*):** Pembuatan dokumen penyesuaian stok, mutasi buku saldo fisik, dan posting jurnal ke *Stock Ledger* → Domain Persediaan (`INV-STOK`, `INV-MUTASI`).
- **Valuasi Finansial Selisih Persediaan:** Penilaian nominal rupiah atas selisih persediaan fisik dan pencatatan jurnal akuntansi keuangan → Akuntansi / Tata Rekening Domain.
- **Pengelolaan Master Barang & Lokasi:** Pendaftaran master data barang persediaan (`INV-MASTER`) dan konfigurasi lokasi/unit rumah sakit (`ORG-LAYANAN`).
- **Mekanisme Teknis Rekonstruksi Stok:** Arsitektur teknis *point-in-time snapshot*, *database locking*, *message broker / event queue*, dan skema kueri tabel *ledger*.
- **Kebijakan Media Operasional:** Pemilihan instrumen pencatatan fisik (lembar kerja kertas vs pemindai *barcode* / aplikasi mobile).
- **Desain Teknis & Implementasi Sistem:** Skema tabel basis data, spesifikasi API *endpoint*, antarmuka layar pengguna (UI/screen), dan rute navigasi aplikasi.
