# OUTCOME: RegExternal (Registrasi Pasien Eksternal Laboratorium)

| Field       | Value                |
|-------------|----------------------|
| Code        | OC-LAB-REG-EXTERNAL  |
| Version     | 1.0                  |
| Status      | Draft                |
| LastUpdated | 2026-10-10           |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, memvalidasi, dan memelihara catatan pendaftaran langsung pasien luar laboratorium (*direct external lab registration*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan Registrasi Pasien Eksternal Laboratorium memungkinkan pasien yang datang langsung (*walk-in* atas inisiatif sendiri / Atas Permintaan Sendiri - APS) maupun pasien yang membawa surat rujukan dari fasilitas kesehatan luar (dokter praktik mandiri, puskesmas, klinik pratama, atau rumah sakit lain) untuk segera mendapatkan pelayanan diagnostik laboratorium tanpa harus mengantre dan melalui prosedur registrasi kunjungan rumah sakit reguler di loket admisi umum (*Admission / ADM*).

Fakta Registrasi Pasien Eksternal ini merupakan fondasi operasional yang esensial untuk:
1. Menyediakan jalur pelayanan mandiri yang cepat (*streamlined fast-track*) bagi kebutuhan diagnostik penunjang laboratorium tanpa birokrasi pendaftaran rawat jalan reguler.
2. Menerbitkan nomor identitas operasional transaksi laboratorium yang bersifat **sekali pakai (*one-time use only*)**, sehingga tidak membentuk atau memelihara master rekam medis permanen di Domain Pasien (`PAS-DATSOS`) dan tidak mencemari data master pasien rumah sakit.
3. Membentuk akun penagihan langsung ke kasir laboratorium/Tata Rekening (`TRK-BILLING` dan `TRK-KASIR`) guna penyelesaian transaksi keuangan mandiri.
4. Menjadi dasar otorisasi bagi pembuatan permintaan tes laboratorium khusus pasien luar (*OrderLab* / `LAB-ORDER`).

---

## 2. Outcome Statement

Pendaftaran langsung pasien eksternal laboratorium telah tercatat secara resmi sebagai fakta bisnis persisten (`Direct External Lab Registration exists`) dengan nomor identitas operasional sekali pakai dan siap digunakan sebagai dasar pemesanan tes diagnostik serta pembebanan tagihan kasir.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Laboratory** (`LAB`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pencatatan pendaftaran mandiri pasien luar, penerbitan nomor identitas operasional sekali pakai (`LAB-EXTERNAL`), serta menghubungkannya ke order laboratorium (`LAB-ORDER`). |
| **Tata Rekening** (`TRK`) | **Contributing Domain:** Menyediakan master tarif pemeriksaan laboratorium non-penjamin/umum (`TRK-TARIF`) dan membentuk akun tagihan kasir penunjang (`TRK-BILLING` dan `TRK-KASIR`). |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan data loket/petugas pendaftaran laboratorium (`ORG-PPA` dan `ORG-LAYANAN`) serta informasi dokter atau instansi perujuk luar. |

> **Prinsip Batasan Domain Pasien & Admisi (Domain Boundary Rule):**
> Sesuai aturan kanonikal [`domain/07-LABORATORY-DOMAIN.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/07-LABORATORY-DOMAIN.md), registrasi eksternal laboratorium sengaja dirancang independen dari **Domain Pasien (`PAS`)** dan **Domain Admission (`ADM`)**. Registrasi ini tidak membentuk rekam medis master rumah sakit permanen. Jika suatu saat pasien tersebut berobat ke poliklinik atau IGD rumah sakit, pasien wajib menjalani pendaftaran reguler di Admission (`ADM-REG`).

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `LAB-EXTERNAL` Registrasi External | Laboratory | Known | **Primary Capability:** Merekam data identitas sosial pasien luar, menerbitkan nomor transaksi/identitas sekali pakai, mengelola asal rujukan luar, dan memelihara status registrasi eksternal. |
| `LAB-ORDER` Order Lab | Laboratory | Known | Menerima konteks registrasi eksternal sebagai dasar pembuatan catatan permintaan pemeriksaan tes lab. |
| `TRK-TARIF` Tariff | Tata Rekening | Known | Menyediakan referensi tarif tindakan laboratorium paket luar/umum. |
| `TRK-BILLING` Billing | Tata Rekening | Known | Membentuk akun transaksi tagihan langsung untuk pembayaran kasir penunjang. |
| `TRK-KASIR` Kasir | Tata Rekening | Known | Menerima pelunasan pembayaran kasir sebelum atau sesudah tindakan pemeriksaan lab dieksekusi. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi loket pendaftaran instalasi laboratorium. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Registrasi Pasien Eksternal Laboratorium (*RegExternal*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Catatan Registrasi Eksternal Unik**:
   - Terbentuk satu catatan pendaftaran pasien eksternal dengan identifier unik (*RegExternalId*) yang sah.
2. **Penerbitan Nomor Rekam Medis Operasional Sekali Pakai (One-Time Identity)**:
   - Diterbitkan nomor identitas/rekam medis sementara dengan format khusus (misal: prefiks `EXT-` atau penomoran sekuensial khusus eksternal) yang ditandai secara tegas sebagai nomor sekali pakai (*one-time use only*).
3. **Perekaman Data Identitas Pasien Luar**:
   - Data sosial dan demografi pasien luar terekam secara lengkap (Nama Lengkap, NIK/KTP jika ada, Tanggal Lahir atau Estimasi Usia, Jenis Kelamin, Nomor Kontak/Telepon, dan Alamat).
4. **Kejelasan Asal Rujukan Luar**:
   - Teridentifikasi asal kedatangan pasien: **Atas Permintaan Sendiri (APS)** atau **Rujukan Fasilitas Luar** (dilengkapi nama dokter pengirim dan instansi/klinik perujuk luar).
5. **Keterikatan Akun Penagihan Kasir**:
   - Terbentuk akun penagihan langsung pada sistem penagihan Tata Rekening (`TRK-BILLING`) untuk memproses pembayaran kasir (`TRK-KASIR`).
6. **Ketiadaan Hubungan dengan Master Pasien Permanen**:
   - Terkonfirmasi bahwa data registrasi ini beroperasi pada lingkup transaksional laboratorium dan tidak melakukan pembaruan atau pembuatan entitas pada master pasien permanen (`PAS-DATSOS`).
7. **Status Siklus Hidup Definitif**:
   - Registrasi memiliki status awal yang jelas: **Aktif (Active)**, **Selesai (Completed)**, atau **Dibatalkan (Cancelled)**.

---

### 5.2 Required Recorded Information

Setiap entitas `RegExternal` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Registrasi:
- **`RegExternalId`**: Identifier unik entitas registrasi eksternal laboratorium.
- **`ExternalMrNo`**: Nomor identitas/rekam medis sementara sekali pakai (*one-time use medical record number*).
- **`RegistrationDate`**: Tanggal dan jam pencatatan pendaftaran dilakukan.
- **`LoketLab`**: Loket atau bilik pendaftaran laboratorium tempat transaksi dibuka.

#### B. Data Sosial Pasien Luar (Demografi Terbatas):
- **Nama Lengkap Pasien**: Nama pasien luar sesuai kartu identitas fisik.
- **Nomor Identitas Kependudukan (NIK)**: Nomor KTP/Paspor (opsional, jika tersedia untuk keperluan pelaporan kesehatan).
- **Tanggal Lahir / Usia**: Tanggal lahir pasien (atau taksiran usia dalam tahun/bulan untuk penetapan nilai rujukan).
- **Jenis Kelamin**: Laki-laki atau Perempuan (wajib untuk penentuan rentang nilai normal analitik).
- **Nomor Telepon / WhatsApp**: Nomor kontak aktif pasien/keluarga untuk konfirmasi atau pengiriman notifikasi/PDF hasil digital.
- **Alamat Tinggal**: Alamat domisili singkat pasien.

#### C. Informasi Rujukan Luar:
- **Kategori Kedatangan**:
  - `APS (Atas Permintaan Sendiri)`: Pasien datang mandiri tanpa surat rujukan dokter.
  - `Rujukan Luar (External Referral)`: Pasien membawa surat permintaan pemeriksaan laboratorium dari pihak luar.
- **Nama Dokter Perujuk Luar**: Nama dokter pengirim yang menandatangani surat rujukan (wajib jika kategori Rujukan Luar).
- **Instansi / Faskes Pengirim**: Nama klinik, puskesmas, atau laboratorium perujuk (opsional).
- **Diagnosis Rujukan / Indikasi Klinis Luar**: Keterangan indikasi atau diagnosa yang tertulis pada lembar pengantar rujukan.

#### D. Penagihan Finansial & Kasir:
- **`BillingAccountId`**: Nomor referensi akun tagihan langsung di domain Tata Rekening (`TRK-BILLING`).
- **Skema Pembayaran**: Penjaminan biaya pasien eksternal (Umum/Tunai, Kartu Debit/Kredit, QRIS, atau Asuransi Rekanan Khusus Lab Eksternal).

#### E. Status Operasional & Jejak Pembatalan:
- **Status Registrasi**:
  - `Active`: Registrasi aktif dan siap digunakan untuk pembuatan order lab atau transaksi kasir.
  - `Completed`: Seluruh proses pemeriksaan lab dan penyelesaian transaksi telah tuntas.
  - `Cancelled`: Registrasi dibatalkan sebelum tindakan atau transaksi dilaksanakan.
- **Petugas Pendaftaran**: Identitas staf administrasi loket laboratorium yang memproses registrasi.
- **Data Pembatalan (wajib jika Cancelled)**:
  - *Waktu Pembatalan*: Tanggal dan jam pembatalan dicatat.
  - *Petugas Pembatal*: Identitas pengguna yang membatalkan registrasi.
  - *Alasan Pembatalan*: Alasan resmi pembatalan (misal: pasien batal periksa, salah input data identitas, kendala biaya).

---

### 5.3 Required Business Conditions

1. **Sifat Sekali Pakai (*One-Time Use Only*)**:
   - Nomor identitas eksternal (`ExternalMrNo`) yang diterbitkan hanya sah dan berlaku untuk episode pemeriksaan laboratorium yang didaftarkan saat itu.
   - Sistem dilarang menggunakan kembali nomor identitas eksternal tersebut untuk episode kunjungan rawat inap, rawat jalan, atau gawat darurat rumah sakit reguler.
2. **Kemandirian dari Master Pasien RS**:
   - Proses pendaftaran eksternal dilarang menyisipkan data pasien baru ke dalam master data pasien permanen rumah sakit (`PAS-DATSOS`) untuk menjaga kemurnian data rekam medis utama.
3. **Kelayakan Penentuan Nilai Rujukan**:
   - Data jenis kelamin dan tanggal lahir (atau estimasi umur) wajib terisi lengkap agar instrumen laboratorium dapat menetapkan rentang nilai rujukan analitik yang akurat pada hasil pemeriksaan nantinya.
4. **Penyelesaian Kewajiban Keuangan (Cash-First Principle)**:
   - Sebagai kebijakan standar pasien eksternal mandiri, pembayaran tagihan di kasir laboratorium (`TRK-KASIR`) diselesaikan sebelum pengambilan spesimen atau sebelum hasil pemeriksaan diserahkan secara resmi.
5. **Syarat Pembatalan Registrasi**:
   - Pembatalan registrasi eksternal hanya dapat dieksekusi jika belum ada pembayaran yang diselesaikan di kasir dan belum ada spesimen yang diambil pada order laboratorium terkait.

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan pendaftaran eksternal tersimpan persisten dengan identifier unik `RegExternalId` dan `ExternalMrNo`.
2. Lembar tanda bukti registrasi eksternal atau bukti pendaftaran kasir laboratorium dapat dicetak untuk pasien.
3. Entitas registrasi ini dapat dipilih dan digunakan sebagai konteks pasien sah pada pembuatan order pemeriksaan laboratorium (`LAB-ORDER`).
4. Akun tagihan langsung terbentuk pada sistem Tata Rekening dan siap menerima pembayaran di kasir loket laboratorium.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)
- **Dimulai saat:** Pasien luar mendatangi loket pendaftaran instalasi laboratorium dengan membawa surat rujukan luar atau menyatakan keinginan melakukan pemeriksaan laboratorium atas permintaan sendiri.

### 6.2 End Boundary (Titik Akhir)
- **Berakhir saat:** Data demografi terbatas pasien luar dan informasi rujukan berhasil divalidasi, disimpan secara persisten dengan nomor unik `RegExternalId` dan nomor identitas sekali pakai, serta akun penagihan kasir terbentuk, siap dilanjutkan ke pemilihan item pemeriksaan laboratorium.

---

## 7. Business Constraints

1. **Non-Contamination of Hospital Master Data**:
   - Registrasi eksternal beroperasi secara terisolasi dalam batas domain laboratorium dan tidak boleh memicu pembuatan entitas rekam medis permanen di Domain Pasien (`PAS`).
2. **Non-Reusability for Hospital Encounters**:
   - Nomor rekam medis eksternal tidak dapat digunakan sebagai acuan admisi rawat inap atau pendaftaran rawat jalan rumah sakit. Jika pasien eksternal membutuhkan penanganan rawat inap darurat berdasarkan hasil laboratorium yang kritis, pasien wajib didaftarkan melalui loket pendaftaran IGD/Admission rumah sakit secara normal (`ADM-REG`).
3. **Keterikatan Finansial Langsung**:
   - Setiap registrasi eksternal wajib memiliki akun transaksi finansial aktif di domain Tata Rekening (`TRK`) untuk memastikan seluruh biaya tindakan laboratorium tercatat akuntabel dan tertagih.
4. **Perekaman Audit Pembatalan**:
   - Pembatalan registrasi eksternal bersifat *non-destructive*, memperbarui status menjadi `Cancelled` dan merekam identitas staf serta alasan pembatalan.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Pembatalan Registrasi yang Telah Memiliki Pembayaran Kasir** | Pengguna berupaya membatalkan registrasi eksternal padahal tagihannya telah dibayar lunas di kasir (`TRK-KASIR`). | Sistem memblokir pembatalan registrasi dan mewajibkan penyelesaian prosedur pengembalian uang (*refund / void payment*) di kasir terlebih dahulu. |
| **EX-02: Pembatalan Registrasi yang Spesimennya Telah Diambil** | Pengguna mencoba membatalkan registrasi eksternal padahal order lab terkait sudah berstatus `Collected` pada `LAB-COLLECT`. | Sistem menolak pembatalan registrasi secara langsung karena materi biologis telah berada dalam proses penanganan analitik. |
| **EX-03: Pasien Luar Menolak Menyebutkan Identitas Minimal** | Pasien menolak memberikan nama lengkap, jenis kelamin, atau perkiraan usia. | Sistem menolak pembuatan registrasi eksternal karena jenis kelamin dan usia merupakan prasyarat mutlak kalkulasi rentang nilai normal analitik laboratorium. |
| **EX-04: Nomor Telepon Tidak Valid pada Permintaan Hasil Digital** | Pasien meminta hasil laboratorium dikirimkan via tautan pesan digital/WhatsApp namun nomor telepon yang dimasukkan tidak valid. | Sistem memberikan peringatan validasi format kontak agar hasil digital dapat terkirim dengan sukses. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat registrasi eksternal baru dengan identifier unik `RegExternalId` dan menerbitkan nomor identitas sementara sekali pakai (`ExternalMrNo`). | Completeness |
| **AC-02** | Catatan registrasi merekam secara lengkap nama pasien luar, jenis kelamin, tanggal lahir/usia, nomor kontak, serta kategori kedatangan (APS atau Rujukan Luar). | Correctness |
| **AC-03** | Registrasi eksternal yang terbentuk tidak membuat catatan rekam medis permanen baru pada master data Domain Pasien (`PAS-DATSOS`). | Constraint (Master Isolation) |
| **AC-04** | Keberhasilan registrasi eksternal secara otomatis membentuk akun tagihan langsung pada domain Tata Rekening (`TRK-BILLING`). | Integration (Billing) |
| **AC-05** | Entitas `RegExternal` yang aktif dapat dipilih dan digunakan sebagai konteks pasien yang sah pada pembuatan order laboratorium (`LAB-ORDER`). | Integration (Downstream) |
| **AC-06** | Upaya pembatalan registrasi yang telah memiliki transaksi kasir lunas berhasil dicegah sebelum prosedur kasir diselesaikan. | Exception Handling |
| **AC-07** | Pembatalan registrasi eksternal yang belum diproses berhasil mengubah status menjadi 'Cancelled' dan mencatat alasan pembatalan dalam jejak audit. | Audit Trail |
| **AC-08** | Sistem mencegah penggunaan nomor identitas eksternal sekali pakai untuk pendaftaran kunjungan rawat jalan atau rawat inap rumah sakit reguler. | Business Rule (One-Time Identity) |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `RegExternal`:

- **Pendaftaran Kunjungan Rumah Sakit Reguler:** Registrasi pasien rawat jalan, rawat inap, atau instalasi gawat darurat rumah sakit (merupakan wewenang `ADM-REG` / Outcome *Registrasi*).
- **Pengelolaan Master Identitas Pasien Permanen:** Penggabungan nomor rekam medis duplikat, verifikasi KTP Dukcapil master, dan pemeliharaan data sosial pasien seumur hidup (merupakan wewenang `PAS-DATSOS` / Outcome *DataSosialPasien*).
- **Penerbitan Order Tes Laboratorium:** Pemilihan daftar pemeriksaan analitik yang dipesan (merupakan wewenang `LAB-ORDER` / Outcome *OrderLab*).
- **Penerimaan Fisik Uang Kasir & Struk:** Transaksi kasir penerimaan pembayaran tunai/debit/qris (merupakan wewenang `TRK-KASIR` / Outcome *Kasir*).
