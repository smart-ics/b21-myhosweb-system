# OUTCOME: OrderLab (Order Pemeriksaan Laboratorium)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-LAB-ORDER-LAB  |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, memvalidasi, dan memelihara permintaan pemeriksaan laboratorium (*laboratory examination order*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan Order Pemeriksaan Laboratorium memungkinkan klinisi pengorder dari seluruh unit pelayanan (Rawat Jalan, Rawat Inap, Gawat Darurat, maupun pendaftaran langsung eksternal) untuk mengomunikasikan kebutuhan tes diagnostik pasien secara terstruktur kepada instalasi laboratorium, merinci daftar parameter atau paket tes yang diminta beserta tingkat urgensinya (Rutin atau Cito/Emergency), dan menetapkan syarat kesiapan khusus pasien (seperti puasa atau penundaan persiapan obat).

Fakta Order Laboratorium ini merupakan fondasi operasional yang esensial untuk:
1. Menyediakan dasar otorisasi resmi bagi instalasi laboratorium untuk mempersiapkan tabung/wadah dan melakukan pengambilan spesimen (*SampleCollection* / `LAB-COLLECT`).
2. Memicu pembentukan pembebanan biaya tindakan laboratorium pada akun tagihan pasien (*Billing* / `TRK-BILLING`).
3. Menjadi acuan pemetaan (*scaffolding*) parameter uji bagi perekaman dan validasi hasil laboratorium (*HasilLab* / `LAB-RESULT`).

---

## 2. Outcome Statement

Permintaan pemeriksaan laboratorium atas nama pasien telah tercatat secara resmi sebagai fakta bisnis persisten (`Laboratory Examination Order exists`) dan siap digunakan sebagai dasar pembebanan biaya tindakan serta persiapan pengambilan spesimen laboratorium.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Laboratory** (`LAB`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas penerimaan, validasi katalog tes laboratorium, pemeliharaan status operasional permintaan pemeriksaan (`LAB-ORDER`), serta menyediakan acuan kebutuhan spesimen dan parameter hasil. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data identitas demografi resmi dan nomor rekam medis pasien yang sah melalui `PAS-DATSOS` (untuk pasien terdaftar di RS). |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks administratif resmi episode kunjungan aktif pasien (`RegId` aktif melalui `ADM-REG`). |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data dokter pengorder dan unit layanan asal melalui `ORG-PPA` dan `ORG-LAYANAN`. |
| **Pelayanan Klinis** (`RJL` / `RNA` / `IGD`) | **Contributing Domains:** Menyediakan konteks episode pelayanan klinis tempat permintaan laboratorium diinisiasi (`RJL-KONSUL`, `RNA-TRANSFER`, `IGD-VISIT`). |
| **Tata Rekening** (`TRK`) | **Contributing Domain:** Menyediakan referensi master tarif tindakan lab (`TRK-TARIF`) dan menerima pembebanan biaya pemeriksaan laboratorium (`TRK-BILLING`). |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `LAB-ORDER` Order Lab | Laboratory | Known | **Primary Capability:** Menerima, memvalidasi parameter tes, mempersistensi catatan permintaan pemeriksaan laboratorium, dan mengelola status siklus hidup order. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan snapshot identitas pasien yang menjadi subjek pemeriksaan (Nomor Rekam Medis, nama lengkap, jenis kelamin, tanggal lahir). |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks nomor registrasi kunjungan aktif (`RegId`) bagi pasien internal RS sebagai prasyarat otorisasi order. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi dan kredensial klinis dokter pengorder yang berwenang meminta pemeriksaan laboratorium. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit kerja asal pengorder (Klinik Rawat Jalan, Bangsal Rawat Inap, atau IGD). |
| `RJL-KONSUL` / `RNA-TRANSFER` / `IGD-VISIT` Encounter Klinis | Pelayanan Klinis Terkait | Known | Menyediakan konteks klinis dan diagnosis awal saat pemeriksaan penunjang diinstruksikan. |
| `TRK-TARIF` Tariff | Tata Rekening | Known | Menyediakan referensi tarif resmi tindakan laboratorium yang dipetakan ke dalam paket tes laboratorium. |
| `TRK-BILLING` Billing | Tata Rekening | Known | Menerima pembebanan biaya tindakan laboratorium berdasarkan item pemeriksaan yang dipesan. |

> **Catatan Batasan Kapabilitas Terkait:**
> Pengambilan fisik spesimen darah/cairan tubuh (`LAB-COLLECT`), pendaftaran mandiri pasien luar (`LAB-EXTERNAL`), serta perekaman dan verifikasi medis hasil laboratorium (`LAB-RESULT`) dikelola oleh kapabilitas masing-masing sebagai tahapan terpisah dalam siklus pelayanan laboratorium.

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Permintaan Pemeriksaan Laboratorium (*OrderLab*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Catatan Permintaan Laboratorium**:
   - Terbentuk satu catatan permintaan laboratorium unik dengan nomor referensi order (*OrderLabId* / *OrderNo*) yang sah dan terdaftar.
2. **Keterikatan Konteks Pasien & Pelayanan**:
   - Order terikat secara valid pada identitas pasien (`PAS-DATSOS`) dan nomor registrasi kunjungan aktif (`RegId` pada `ADM-REG`), atau terikat pada registrasi pasien luar (`RegExternalId` pada `LAB-EXTERNAL`).
3. **Akuntabilitas Dokter Pengorder**:
   - Teridentifikasi dokter penanggung jawab pengorder yang memiliki kredensial medis sah (`ORG-PPA`).
4. **Kejelasan Rencana Pemeriksaan Laboratorium**:
   - Memuat minimal satu item/paket tes laboratorium yang valid dan aktif.
   - Setiap item tes laboratorium terpetakan ke spesifikasi kebutuhan spesimen/tabung (*vacutainer*) dan tarif tindakan yang sesuai.
5. **Penetapan Tingkat Urgensi**:
   - Menetapkan tingkat urgensi pemeriksaan secara definitif: **Rutin** atau **Cito (Emergency/STAT)**.
6. **Penetapan Kesiapan Klinis (Deferred/Ready)**:
   - Menetapkan apakah order siap langsung diambil sampelnya (*Ready to Collect*) atau memerlukan penundaan persiapan medis pasien (*Deferred*, misalnya puasa 10–12 jam, penundaan konsumsi obat tertentu, atau pemeriksaan serial terjadwal).
7. **Status Siklus Hidup Awal Definitif**:
   - Order memiliki status awal yang jelas: **Diajukan (Requested/Ordered)**, **Tertunda (Deferred)**, atau **Dibatalkan (Cancelled)**.

---

### 5.2 Required Recorded Information

Setiap entitas `OrderLab` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Order & Konteks Pelayanan:
- **`OrderLabId`**: Identifier unik entitas permintaan pemeriksaan laboratorium.
- **`OrderNo`**: Nomor transaksi operasional laboratorium yang mudah dibaca petugas (*human-readable order number*).
- **`OrderSource`**: Asal sumber order:
  - `Internal-EMR`: Berasal dari modul konsultasi klinis (Rawat Jalan, Rawat Inap, IGD).
  - `External-Direct`: Berasal dari pendaftaran langsung pasien luar laboratorium (`LAB-EXTERNAL`).
- **`RegId`**: Nomor registrasi kunjungan aktif pasien (atau `RegExternalId` untuk pasien luar).
- **Snapshot Pasien**:
  - Nomor Rekam Medis (Nomor RM / `PatientId`).
  - Nama Lengkap Pasien.
  - Tanggal Lahir dan Usia saat Order Dibuat.
  - Jenis Kelamin.
- **Unit Layanan Pengorder**: Kode dan nama instalasi/ruangan/klinik asal pengorder.
- **Waktu Pencatatan**: Tanggal dan jam pembuatan order.

#### B. Tanggung Jawab Medis:
- **Dokter Pengorder**: Identitas dan nama dokter yang menerbitkan instruksi pemeriksaan.
- **Diagnosis Kerja / Indikasi Klinis**: Keterangan indikasi medis atau kecurigaan klinis yang melandasi permintaan pemeriksaan.
- **Catatan Khusus Pengorder**: Instruksi tambahan dari dokter (misalnya: riwayat terapi antikoagulan, kecurigaan sepsis, dsb.).

#### C. Rincian Item Pemeriksaan Laboratorium:
Daftar terstruktur dari setiap pemeriksaan yang diminta, dengan informasi per item:
- **`ItemNo`**: Nomor urut baris pemeriksaan dalam order.
- **`TarifId`**: Referensi tarif tindakan laboratorium dari domain Tata Rekening (`TRK-TARIF`).
- **`TestDefinitionId`**: Referensi definisi katalog tes laboratorium (`LAB-ORDER`).
- **Nama Pemeriksaan**: Nama tes laboratorium resmi (misal: Darah Lengkap, Glukosa Darah Puasa, SGOT, SGPT, Kreatinin).
- **Spesimen yang Disyaratkan**: Jenis spesimen biologis (Darah Vena, Darah Kapiler, Urine Pagi, Feses, Cairan Pleura) dan tipe tabung vacutainer (EDTA, Serum/Clot Activator, Citrate, Heparin).
- **Prioritas Item**: Rutin atau Cito.

#### D. Informasi Penundaan Persiapan (Deferred Information — jika berlaku):
- **Status Deferred**: Penanda bahwa order menunggu pemenuhan syarat persiapan pasien sebelum spesimen boleh diambil.
- **Alasan Penundaan**: Deskripsi syarat persiapan (misal: "Pasien mulai puasa pukul 22.00, pengambilan sampel dijadwalkan besok pukul 07.00").
- **Target Waktu Pengambilan**: Estimasi tanggal dan jam pasien siap diambil spesimennya.

#### E. Status Siklus Hidup & Jejak Pembatalan:
- **Status Order**:
  - `Requested / Ordered`: Order berhasil disimpan dan siap diproses ke tahap pengambilan spesimen atau pembebanan tarif.
  - `Deferred`: Order menunggu kesiapan persiapan pasien.
  - `Cancelled`: Order dibatalkan sebelum pengambilan spesimen dilaksanakan.
- **Petugas Pencatat**: Identitas pengguna sistem yang menginput order.
- **Data Pembatalan** (wajib jika berstatus `Cancelled`):
  - *Waktu Pembatalan*: Tanggal dan jam pembatalan dicatat.
  - *Petugas Pembatal*: Identitas klinisi atau petugas yang membatalkan order.
  - *Alasan Pembatalan*: Keterangan resmi penyebab pembatalan (misal: salah input pemeriksaan, pasien menolak, dokter mengganti terapi).

---

### 5.3 Required Business Conditions

1. **Keabsahan Episode Registrasi Kunjungan**:
   - Pasien harus memiliki nomor registrasi kunjungan aktif (`RegId` pada `ADM-REG` atau `RegExternalId` pada `LAB-EXTERNAL`).
   - Episode kunjungan pasien belum ditutup secara administratif.
2. **Kredensial Dokter Pengorder**:
   - Dokter yang memesan pemeriksaan harus terdaftar aktif dan memiliki kewenangan klinis di `ORG-PPA`.
3. **Validitas Item Pemeriksaan**:
   - Setiap item pemeriksaan yang dipilih harus berstatus aktif dalam katalog tes laboratorium dan memiliki pemetaan tarif yang valid di `TRK-TARIF`.
4. **Prioritas Alokasi Order Cito**:
   - Order berkategori **Cito** wajib secara otomatis ditandai dengan label prioritas darurat di worklist laboratorium untuk mendahului antrean persiapan tabung dan sampling.
5. **Kebijakan Pembatalan Non-Destructive**:
   - Pembatalan order hanya dapat dilakukan selama spesimen belum diambil (`SampleCollection` belum berstatus selesai).
   - Pembatalan wajib merekam jejak audit (waktu, pelaku, dan alasan pembatalan).
6. **Integritas Pemeriksaan saat Deferred**:
   - Selama berstatus `Deferred`, sistem mengunci pengambilan spesimen dan entri hasil hingga status diaktifkan kembali menjadi aktif/siap.

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan permintaan pemeriksaan laboratorium tersimpan persisten dengan identifier unik `OrderLabId` dan `OrderNo`.
2. Status order tercatat sebagai `Requested / Ordered` (atau `Deferred` jika memerlukan persiapan).
3. Rincian pemeriksaan terpetakan secara lengkap ke kebutuhan spesimen biologis dan tabung vacutainer.
4. Catatan order laboratorium dapat ditemukan dan diakses pada worklist operasional laboratorium.
5. Data item pemeriksaan siap dikonsumsi oleh `TRK-BILLING` untuk pembebanan biaya dan oleh `LAB-COLLECT` untuk persiapan sampling.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)
- **Dimulai saat:** Dokter penanggung jawab pasien atau petugas berwenang menginisiasi dan memilih daftar pemeriksaan laboratorium untuk pasien berdasarkan indikasi klinis atau permintaan mandiri pasien luar.

### 6.2 End Boundary (Titik Akhir)
- **Berakhir saat:** Seluruh parameter pemeriksaan divalidasi, disimpan secara persisten ke dalam sistem dengan nomor unik `OrderLabId`, dan berstatus `Requested / Ordered` (atau `Deferred`), siap ditindaklanjuti untuk pengambilan spesimen dan pembebanan tarif.

---

## 7. Business Constraints

1. **Keterikatan Tunggal pada Episode Kunjungan**:
   - Setiap entitas `OrderLab` harus terikat secara spesifik pada tepat satu nomor registrasi kunjungan aktif (`RegId` atau `RegExternalId`).
2. **Kemandirian Operasional dari Catatan EMR**:
   - `OrderLab` mengelola orkestrasi operasional pemeriksaan laboratorium. Rekam medis lengkap, asesmen diagnosis diferensial, dan resep obat tetap dikelola secara independen di domain EMR / Rawat Jalan / Rawat Inap.
3. **Immutability Rincian Pemeriksaan Pasca-Sampling**:
   - Apabila spesimen telah diambil (`SampleCollection` selesai), rincian item tes dalam order laboratorium tersebut terkunci dan tidak boleh diubah atau dihapus. Permintaan tes tambahan harus dibuat melalui order baru.
4. **Kemandirian terhadap Eksekusi Billing Fisik**:
   - Kegagalan sementara pada koneksi kasir/billing tidak boleh membatalkan eksistensi order klinis, namun order akan mencatat status penundaan penagihan hingga sinkronisasi berhasil.
5. **Non-Destructive Cancellation**:
   - Pembatalan order tidak menghapus data secara fisik dari basis data, melainkan memperbarui status menjadi `Cancelled` dan mencatat alasan pembatalan dalam jejak audit.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Registrasi Kunjungan Tidak Aktif / Ditutup** | Pengguna membuat order laboratorium menggunakan nomor registrasi yang tidak ditemukan, dibatalkan, atau status episode perawatannya sudah ditutup (*discharged*). | Sistem menolak pembuatan order dan menginformasikan bahwa pasien harus memiliki status kunjungan aktif. |
| **EX-02: Item Pemeriksaan Tidak Memiliki Definisi / Tarif Aktif** | Item tes laboratorium yang dipilih tidak aktif di katalog atau pemetaan tarifnya di `TRK-TARIF` tidak ditemukan. | Sistem menolak penyimpanan baris item tersebut dan meminta administrator memperbarui katalog tes. |
| **EX-03: Pembatalan pada Order yang Sudah Diambil Sampelnya** | Pengguna berupaya membatalkan order laboratorium padahal spesimen telah diambil (`SampleCollection` sudah terbentuk). | Sistem menolak pembatalan order secara langsung. Pembatalan hanya dapat dilakukan melalui prosedur penolakan spesimen atau terminasi resmi dengan otorisasi khusus. |
| **EX-04: Pembatalan Tanpa Alasan Resmi** | Pengguna mengubah status order menjadi `Cancelled` tanpa mengisi keterangan alasan pembatalan. | Sistem memblokir aksi pembatalan dan mewajibkan pengisian alasan pembatalan. |
| **EX-05: Duplikasi Pemeriksaan Identik dalam Waktu Singkat** | Sistem mendeteksi adanya order aktif untuk jenis tes laboratorium yang sama pada pasien yang sama dalam kurun waktu 24 jam terakhir. | Sistem memberikan peringatan konfirmasi (*warning dialog*) mengenai potensi tes ganda guna mencegah pemborosan biaya atau flebotomi berulang yang tidak perlu. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat permintaan laboratorium baru dengan identifier unik `OrderLabId`, status awal 'Requested', dan menghubungkannya dengan nomor registrasi kunjungan yang sah. | Completeness |
| **AC-02** | Catatan order memuat secara lengkap dokter pengorder, indikasi klinis, snapshot identitas pasien, dan minimal satu item pemeriksaan laboratorium terstruktur. | Correctness |
| **AC-03** | Setiap item pemeriksaan terpetakan dengan benar ke jenis spesimen biologis yang disyaratkan serta tipe tabung vacutainer yang sesuai. | Correctness (Specimen Mapping) |
| **AC-04** | Penetapan prioritas 'Cito' berhasil direkam dan secara otomatis menandai order dengan label prioritas darurat pada daftar kerja instalasi laboratorium. | Business Rule (Urgensi Cito) |
| **AC-05** | Order yang memerlukan puasa/persiapan medis berhasil dicatat dengan status 'Deferred' beserta rincian instruksi persiapan dan target waktu sampling. | Business Rule (Deferred) |
| **AC-06** | Upaya pembuatan order pada kunjungan yang sudah ditutup atau dengan item tes non-aktif berhasil dicegah dengan pesan validasi yang jelas. | Exception Handling |
| **AC-07** | Pembatalan order sebelum pengambilan sampel berhasil mengubah status menjadi 'Cancelled' dan merekam waktu, identitas petugas, serta alasan pembatalan dalam jejak audit. | Constraint & Audit Trail |
| **AC-08** | Order laboratorium yang tersimpan berstatus 'Requested' dapat diakses dan digunakan oleh kapabilitas `LAB-COLLECT` untuk tahap pengambilan spesimen. | Integration (Downstream) |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `OrderLab`:

- **Pengambilan Fisik Spesimen & Flebotomi:** Prosedur penusukan vena, penempelan label barcode pada tabung, dan verifikasi volume fisik spesimen (merupakan wewenang `LAB-COLLECT` / Outcome *SampleCollection*).
- **Perekaman Nilai Parameter & Validasi Hasil:** Pengisian hasil analisis, penghitungan nilai, validasi otomatis, dan verifikasi dokter spesialis patologi klinik (merupakan wewenang `LAB-RESULT` / Outcome *HasilLab*).
- **Pendaftaran Langsung Pasien Luar:** Pencatatan identitas sementara dan penerbitan nomor rekam medis sekali pakai untuk pasien mandiri (merupakan wewenang `LAB-EXTERNAL` / Outcome *RegExternal*).
- **Penetapan Nilai Rupiah Tarif & Pembayaran Kasir:** Perhitungan total tagihan, diskon tarif, alokasi penjamin/asuransi, dan pencatatan struk pembayaran (merupakan wewenang `TRK-BILLING`, `TRK-TARIF`, dan `TRK-KASIR`).
- **Keputusan Klinis Pemilihan Terapi & Pemeriksaan:** Penentuan indikasi medis pemilihan tes laboratorium oleh dokter DPJP (merupakan domain klinis dan EMR).
