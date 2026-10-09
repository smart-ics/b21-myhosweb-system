# OUTCOME: PakaiBed (Inpatient Bed Occupancy)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-RNA-PAKAI-BED  |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat dan memelihara status penempatan fisik pasien di tempat tidur rawat inap (*inpatient bed occupancy*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*). 

Pencatatan penempatan tempat tidur memastikan adanya kepastian lokasi fisik perawatan pasien di unit bangsal, menetapkan akuntabilitas serah terima tempat tidur oleh staf perawat penerima, serta merekam interval waktu okupansi (waktu masuk s/d waktu keluar) beserta kelas pembebanan yang berlaku (*billing class* / status titip kelas).

Fakta penempatan tempat tidur ini merupakan fondasi operasional yang esensial untuk:
1. Mengetahui posisi riil keberadaan pasien rawat inap di rumah sakit setiap saat.
2. Menyediakan dasar data durasi waktu dan kelas perawatan yang valid bagi kalkulasi pembebanan sewa kamar (*Room Charge* / `RNA-ROOMCHARGE`) dan pembentukan rincian tagihan (*Billing* / `TRK-BILLING`).
3. Menyediakan data historis pergerakan tempat tidur untuk kompilasi sensus harian bangsal serta indikator utilisasi tempat tidur rumah sakit (BOR, LOS, TOI pada `BRM-RPT` / `BRM-INDIKATOR`).

---

## 2. Outcome Statement

Penempatan fisik pasien pada tempat tidur rawat inap telah tercatat sebagai fakta interval okupansi aktif atau historis yang sah (`Inpatient Bed Occupancy exists`), menetapkan relasi antara pasien rawat inap terdaftar dengan sumber daya tempat tidur spesifik beserta kelas perawatannya untuk kebutuhan pelayanan klinis, pelacakan durasi rawat, dan penagihan sewa kamar.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Rawat Inap** (`RNA`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pencatatan, pemeliharaan status operasional, pengelolaan interval waktu penempatan tempat tidur (`RNA-BED`), dan pencatatan alasan pelepasan bed. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data struktural dan operasional tempat tidur, ruangan/kamar, bangsal, serta unit layanan rawat inap melalui `ORG-BANGSAL`. |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks administratif resmi episode rawat inap pasien (`RegId` aktif tipe Rawat Inap melalui `ADM-REG`). |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data identitas demografi resmi dan nomor rekam medis pasien yang sah melalui `PAS-DATSOS`. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `RNA-BED` Pakai Bed | Rawat Inap | Known | **Primary Capability:** Mencatat registrasi penempatan pasien ke tempat tidur, memelihara status okupansi aktif, dan mencatat pelepasan/checkout tempat tidur. |
| `ORG-BANGSAL` Bangsal | Organisasi | Known | Menyediakan referensi kamar, tempat tidur, unit bangsal, dan konfigurasi kelas fisik tempat tidur. |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks registrasi aktif episode rawat inap (`RegId`) sebagai prasyarat otorisasi penempatan. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan data verifikasi identitas pasien (Nomor Rekam Medis, nama, jenis kelamin, usia). |

> **Catatan Batasan Kapabilitas Terlibat:**
> Sesuai matriks kanonikal, kapabilitas antrean sebelum check-in (`RNA-WAITLIST` / [`OC-RNA-WAITING-LIST.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-RNA-WAITING-LIST.md)), alih rawat (`RNA-TRANSFER`), perhitungan sewa kamar (`RNA-ROOMCHARGE`), kesiapan fisik bed (`RNA-HK`), dan kepulangan administratif (`RNA-DISCHARGE`) dikelola dalam domain/outcome masing-masing dan bertindak sebagai anteseden atau konsumen dari fakta `PakaiBed`.

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Penempatan Tempat Tidur Rawat Inap (*PakaiBed*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Interval Okupansi**:
   - Terbentuk satu catatan interval okupansi unik yang menghubungkan subjek pasien dengan satu unit tempat tidur fisik tertentu.
   - Tercatat waktu mulai penempatan (*check-in timestamp*) yang sah.
2. **Keterikatan Konteks Kunjungan**:
   - Interval terikat secara valid pada nomor registrasi rawat inap aktif (`RegId`).
3. **Penetapan Lokasi Fisik dan Kelas**:
   - Lokasi tempat tidur definitif: Bangsal, Ruangan/Kamar, dan Nomor Bed.
   - Kelas fisik tempat tidur teridentifikasi sesuai master `ORG-BANGSAL`.
   - Kelas pembebanan biaya perawatan (*Billing Class*) terdefinisi (termasuk penandaan status *Titip Kelas* atau *Naik Kelas* jika berbeda dari kelas fisik).
4. **Keabsahan Subjek**:
   - Pasien terverifikasi terdaftar sah di Pasien Domain (`PAS-DATSOS`).
   - Apabila terdapat kasus Bayi Rawat Gabung (*Rooming-in*), tercatat relasi identitas bayi terhadap bed utama (bed ibu).
5. **Status Okupansi Definitif**:
   - Interval memiliki status yang jelas: **Aktif (Occupied)**, **Selesai (Released)**, atau **Dibatalkan (Cancelled)**.

---

### 5.2 Required Recorded Information

Setiap interval `PakaiBed` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Okupansi & Konteks Pelayanan:
- **`OccupancyId` / `PakaiBedId`**: Identitas unik interval penempatan tempat tidur.
- **`RegId`**: Nomor unik registrasi rawat inap aktif pasien.
- **Identitas Pasien**: Nomor Rekam Medis dan nama lengkap pasien.

#### B. Lokasi & Kelas Tempat Tidur:
- **Unit Bangsal / Instalasi**: Kode dan nama bangsal perawatan.
- **Kamar / Ruangan**: Kode dan nomor kamar perawatan.
- **Nomor Bed**: Identifikasi kode/nomor tempat tidur fisik.
- **Kelas Bed Fisik**: Kelas fasilitas tempat tidur sesuai konfigurasi master `ORG-BANGSAL` (misal: VIP, Kelas 1, Kelas 2, Kelas 3, dsb.).
- **Kelas Pembebanan (*Billing Class*)**: Kelas tarif rawat inap yang berlaku untuk perhitungan biaya sewa kamar pasien (mengakomodasi kasus titip kelas/naik kelas).

#### C. Atribut Khusus Rawat Gabung (*Rooming-in*):
- **Indikator Rawat Gabung**: Penanda boolean apakah bed ditempati dalam konteks rawat gabung.
- **Referensi Pasien Utama / Anak**: Nomor RM / Nama bayi atau ibu yang saling tertaut dalam rawat gabung.

#### D. Periode Waktu & Status Okupansi:
- **Waktu Mulai Masuk (*Check-in Timestamp*)**: Tanggal dan jam pasien mulai menempati tempat tidur.
- **Waktu Selesai Keluar (*Check-out Timestamp*)**: Tanggal dan jam pasien meninggalkan tempat tidur (bernilai kosong selama status masih aktif).
- **Status Okupansi**: Nilai status siklus hidup interval:
  - `Aktif / Occupied`: Pasien sedang menempati tempat tidur.
  - `Selesai / Released`: Pasien telah keluar/dilepas dari tempat tidur.
  - `Dibatalkan / Cancelled`: Penempatan dibatalkan karena kesalahan administratif operasional.

#### E. Akuntabilitas Petugas & Alasan Pelepasan:
- **Petugas Penempatan**: Identitas staf/perawat bangsal yang mencatat check-in.
- **Petugas Pelepasan**: Identitas staf/perawat yang mencatat checkout/pelepasan (jika telah selesai).
- **Alasan Pelepasan**: Keterangan penyebab pelepasan bed saat checkout:
  - `Pindah Kamar/Bed (Transfer Internal)`
  - `Pindah Bangsal (Transfer External Bangsal/ICU)`
  - `Pulang / Discharge (Izin Dokter, APS, Rujuk Keluar)`
  - `Meninggal Dunia`
- **Catatan Pembatalan**: Alasan pembatalan dan identitas petugas pembatal (wajib diisi jika status `Cancelled`).

---

### 5.3 Required Business Conditions

1. **Prasyarat Episode Admisi**:
   - Pasien harus memiliki registrasi pelayanan bertipe **Rawat Inap** dengan status **Terdaftar** pada `ADM-REG`.
   - Episode registrasi rawat inap belum ditutup secara administratif.
2. **Ketersediaan & Kesiapan Bed Fisik**:
   - Tempat tidur harus berstatus aktif dalam master organisasi `ORG-BANGSAL`.
   - Tempat tidur fisik tidak boleh sedang ditempati oleh pasien aktif lain, **kecuali** untuk kasus penempatan Bayi Rawat Gabung (*Rooming-in*) pada bed ibu.
3. **Otoritas Unit Penerima**:
   - Penempatan pasien ke tempat tidur harus dilakukan oleh staf/perawat berwenang di unit bangsal penerima tempat tidur yang bersangkutan.
4. **Konsistensi Kronologis Waktu**:
   - Waktu keluar (*Check-out*) harus secara kronologis sama dengan atau setelah waktu masuk (*Check-in*).

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan interval penempatan tempat tidur tersimpan secara persisten dengan identifier unik.
2. Status okupansi tercatat sebagai **Aktif (Occupied)** untuk penempatan baru, atau **Selesai (Released)** untuk penempatan yang telah dilepas.
3. Tempat tidur fisik pada bangsal terkait terkonfirmasi terisi (*Occupied*) dalam tampilan keterisian bangsal.
4. Data interval penempatan dapat diakses oleh fungsi penagihan kamar (`RNA-ROOMCHARGE`) untuk menghitung lama hari rawat dan kelas tarif yang berlaku.
5. Kueri sensus rawat inap (`BRM-RPT`) mencatat keberadaan pasien di tempat tidur terkait pada tanggal/jam sensus yang bersangkutan.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)

- **Dimulai saat:** Pasien tiba secara fisik di unit bangsal rawat inap dan staf/perawat bangsal yang berwenang mengonfirmasi penerimaan serta melakukan penempatan fisik pasien ke tempat tidur tertentu (*Check-in / Placement Confirmation*).
- **Catatan:** Pemilihan/alokasi kamar di loket pendaftaran admisi atau antrean bangsal (`RNA-WAITLIST` / [`OC-RNA-WAITING-LIST.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-RNA-WAITING-LIST.md)) merupakan reservasi/antrean dan **bukan** permulaan fakta `PakaiBed`.

### 6.2 End Boundary (Titik Akhir)

- **Berakhir saat:** Pasien secara fisik meninggalkan tempat tidur dan perawat mencatat pelepasan/checkout tempat tidur (*Bed Release / Check-out*), baik karena perpindahan (*transfer*), pemulangan (*discharge*), maupun pasien meninggal dunia.
- **Pelepasan ini secara langsung mengakhiri interval `PakaiBed`** (mencatat waktu keluar dan alasan pelepasan) serta memicu status fisik tempat tidur pada unit kerja bangsal menjadi status pembersihan (*Dirty / Pending Housekeeping*) untuk ditindaklanjuti oleh fungsi *Housekeeping* (`RNA-HK`).

---

## 7. Business Constraints

1. **Model Interval Waktu (Occupancy Interval)**:
   - Setiap periode penempatan tempat tidur dicatat sebagai satu interval tersendiri dengan waktu masuk definitif.
   - Perpindahan tempat tidur (*transfer*) menutup interval saat ini dan membuka interval penempatan baru pada bed tujuan.
2. **Aturan Eksklusivitas Bed & Pengecualian Rawat Gabung**:
   - Satu tempat tidur fisik secara umum hanya dapat ditempati oleh tepat satu pasien aktif dalam satu kurun waktu yang sama.
   - **Pengecualian Rawat Gabung (Rooming-in):** Satu tempat tidur fisik utama (misal bed ibu melahirkan) diperbolehkan menampung pasien tambahan (bayi baru lahir) dengan indikator relasi rawat gabung tanpa mewajibkan alokasi bed fisik tersendiri.
3. **Fleksibilitas Multi-Bed Per Pasien**:
   - Sistem memperbolehkan seorang pasien memiliki lebih dari satu penempatan tempat tidur aktif secara bersamaan apabila terdapat kebutuhan operasional khusus (seperti penahanan bed/titip bed saat perawatan sementara di unit intensif/prosedur bedah khusus, atau penanganan darurat/bencana).
4. **Pencatatan Ganda Kelas Fisik dan Kelas Pembebanan**:
   - Sistem wajib mencatat kelas tempat tidur fisik aktual (dari `ORG-BANGSAL`) DAN kelas pembebanan rawat (*billing class*).
   - Hal ini menjamin bahwa selisih kelas (akibat titip kelas karena kamar penuh, atau permintaan naik kelas) terdokumentasi secara transparan sebagai dasar kalkulasi tarif di `RNA-ROOMCHARGE` dan `TRK-BILLING`.
5. **Batal Bersyarat & Audit Trail (Non-Destructive Cancellation)**:
   - Penempatan tempat tidur yang salah rekam (*human error* / salah klik) hanya dapat dibatalkan (status `Cancelled`) apabila **belum terbentuk transaksi finansial billing** atau pembebanan tindakan medis pada periode penempatan tersebut.
   - Pembatalan wajib menyertakan identitas petugas yang membatalkan dan alasan pembatalan resmi yang tersimpan dalam jejak audit (*audit trail*).
6. **Integritas Kronologis & Historis**:
   - Interval penempatan yang telah selesai (*Released*) bersifat *read-only* bagi operasional harian. Koreksi data historis hanya dapat dilakukan melalui wewenang supervisi khusus dengan pencatatan audit perubahan.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Bed Fisik Sedang Terisi** | Pengguna mencoba menempatkan pasien pada bed yang statusnya masih aktif ditempati pasien lain, tanpa indikator Rawat Gabung. | Sistem menolak penempatan baru dan menampilkan pesan bahwa tempat tidur sedang terisi oleh pasien lain beserta informasi pasien yang sedang menempati. |
| **EX-02: Bed Tidak Siap Pakai / Maintenance** | Pengguna memilih bed yang status fisiknya sedang rusak, dalam perbaikan, atau belum selesai proses pembersihan (Housekeeping). | Sistem menolak penempatan dan memberi tahu bahwa tempat tidur belum siap digunakan (memerlukan verifikasi status kesiapan bed). |
| **EX-03: Registrasi Admisi Tidak Valid / Bukan Rawat Inap** | Nomor registrasi (`RegId`) yang dimasukkan bukan bertipe Rawat Inap atau berstatus sudah batal/selesai. | Sistem menolak pencatatan penempatan tempat tidur dan menginstruksikan pengguna untuk memeriksa status registrasi admisi pasien. |
| **EX-04: Penolakan Pembatalan Akibat Keterikatan Billing** | Pengguna berupaya membatalkan penempatan bed (status `Cancelled`), namun komponen biaya kamar atau tindakan pada interval tersebut telah diproses/terkunci di Billing. | Sistem menolak pembatalan langsung, mewajibkan penyesuaian/pembatalan transaksi pembebanan di Tata Rekening terlebih dahulu sebelum penempatan dapat dibatalkan. |
| **EX-05: Waktu Checkout Tidak Valid** | Waktu keluar yang diinput mendahului waktu masuk check-in. | Sistem menolak input dan memvalidasi bahwa waktu selesai harus sama dengan atau setelah waktu mulai penempatan. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat interval penempatan baru dengan identifier unik, waktu masuk yang valid, status 'Occupied', dan menghubungkannya dengan `RegId` rawat inap yang sah. | Completeness |
| **AC-02** | Kelas bed fisik dan kelas pembebanan rawat (*billing class*) tersimpan secara akurat pada interval penempatan, termasuk penandaan titip kelas atau naik kelas. | Correctness |
| **AC-03** | Penempatan bayi baru lahir pada bed ibu dengan indikator Rawat Gabung (*Rooming-in*) berhasil disimpan tanpa ditolak oleh validasi keterisian tempat tidur. | Business Rule (Rawat Gabung) |
| **AC-04** | Sistem mengizinkan pasien yang sama memiliki penempatan bed aktif tambahan jika diperlukan untuk kebutuhan operasional khusus (multi-bed). | Business Rule (Multi-Bed) |
| **AC-05** | Upaya menempatkan pasien pada bed yang sedang terisi oleh pasien non-rawat gabung berhasil dicegah dan menghasilkan notifikasi penolakan yang informatif. | Exception Handling |
| **AC-06** | Proses checkout bed berhasil mencatat waktu keluar, mengubah status interval menjadi 'Released', merekam alasan pelepasan, serta memicu status fisik bed menjadi kotor/perlu pembersihan untuk housekeeping. | Boundary (End Boundary) |
| **AC-07** | Pembatalan penempatan yang salah rekam berhasil mengubah status menjadi 'Cancelled' dengan mencatat alasan dan petugas pembatal, asalkan belum terdapat transaksi billing terkunci pada interval terkait. | Constraint & Audit Trail |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `PakaiBed`:

- **Master Struktur Fasilitas & Bed:** Penambahan, pengeditan, atau penghapusan master gedung, bangsal, ruangan, dan nomor bed (merupakan wewenang `ORG-BANGSAL` pada Domain Organisasi).
- **Pengelolaan Antrean Masuk Bangsal:** Antrean tunggu pasien di bangsal sebelum proses penempatan fisik di tempat tidur (merupakan wewenang `RNA-WAITLIST` / [`OC-RNA-WAITING-LIST.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-RNA-WAITING-LIST.md)).
- **Pembersihan dan Sterilisasi Fisik:** Tata laksana pembersihan kasur, sterilisasi ruangan, dan perubahan status siap pakai kamar (merupakan wewenang `RNA-HK`).
- **Kalkulasi & Penetapan Tarif Kamar:** Aturan perhitungan nominal rupiah sewa kamar, diskon, atau pengali tarif (merupakan wewenang `RNA-ROOMCHARGE` dan `TRK-TARIF`).
- **Pengelompokan Tagihan Finansial & Kasir:** Pembentukan akun penagihan pasien dan penerimaan pembayaran (merupakan wewenang `TRK-BILLING` dan `TRK-KASIR`).
- **Dokumentasi Asuhan Klinis:** Catatan rekam medis dokter/perawat, observasi klinis, asuhan keperawatan, dan instruksi medis pasien (merupakan wewenang EMR / domain klinis).
