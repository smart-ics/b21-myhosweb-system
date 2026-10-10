# OUTCOME: IgdVisit (Kunjungan Pasien Gawat Darurat)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-IGD-VISIT      |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Instalasi Gawat Darurat (IGD) rumah sakit memerlukan pendekatan operasional khusus di mana pertolongan medis harus diprioritaskan di atas formalitas birokrasi pendaftaran administratif (*Clinical Flow First*). Pasien yang tiba dalam kondisi kritis, tidak sadarkan diri, atau tanpa dokumen kependudukan tidak boleh tertunda penanganan medisnya demi menunggu proses admisi formal selesai.

Rumah sakit wajib memiliki kemampuan untuk mencatat, mengelola, mengoordinasikan, dan memvalidasi siklus hidup kunjungan gawat darurat secara mandiri sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan kunjungan gawat darurat ini berfungsi esensial untuk:
1. **Penyediaan Identitas Operasional Tunggal (*Single Operational Identity*)**: Menerbitkan pengenal operasional independen (**`IgdVisitId`**) segera saat pasien tiba, yang menjadi jangkar tunggal bagi seluruh aktivitas pelayanan klinis di IGD (triase, pemeriksaan dokter, penempatan tempat tidur, tindakan emergensi, dan pemakaian obat/BHP).
2. **Fleksibilitas Admisi Tertunda (*Delayed Administrative Registration*)**: Mengizinkan penanganan medis darurat berjalan mendahului pendaftaran admisi resmi rumah sakit, dengan mekanisme penautan nomor registrasi administratif (**`RegId`**) yang dapat dilakukan secara menyusul setelah kondisi darurat stabil atau keluarga pasien tiba.
3. **Koordinasi Dokter Jaga & Alokasi Tempat Tidur (*Bed Allocation & Transfer*)**: Mengatur penugasan dokter jaga penanggung jawab serta mengoordinasikan penempatan tempat tidur observasi/tindakan IGD (`BedIgd`) dengan aturan kepatuhan mutlak bahwa alokasi tempat tidur harus didahului oleh penilaian triase klinis.
4. **Agregasi Transaksi Klinis & Kesiapan Penagihan Finansial**: Menampung pencatatan tindakan medis darurat (`IGD-TINDAKAN`) dan pemakaian barang habis pakai medis (`BhpIgd`) selama episode penanganan darurat, yang siap diposting ke akun tagihan pasien (`TRK-BILLING`) segera setelah nomor registrasi administratif ditautkan.
5. **Jalur Penyelesaian Episode Layanan yang Terstruktur**: Memfasilitasi berbagai skenario akhir pelayanan gawat darurat: pemulangan pasien sembuh (*Discharge*), alih rawat inap (*Transfer Ranap* / `IGD-RANAP`), pengalihan ke poliklinik rawat jalan (*Redirect Rawat Jalan*), rujukan ke fasilitas kesehatan lain, maupun pembatalan kunjungan (*Void*) yang taat asas.

---

## 2. Outcome Statement

Kunjungan pasien Instalasi Gawat Darurat telah tercatat secara resmi sebagai fakta bisnis persisten (`Emergency Visit exists`), menyediakan identitas operasional pelayanan darurat independen yang mengoordinasikan penugasan tenaga medis, alokasi tempat tidur observasi, dan transaksi penanganan klinis, serta siap ditautkan dengan registrasi administratif dan penagihan rumah sakit.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan didukung Contributing Domains terkait:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Gawat Darurat** (`IGD`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab penuh atas siklus hidup kunjungan IGD (`IgdVisit`), penugasan dokter jaga, orkestrasi tempat tidur observasi/tindakan IGD (`BedIgd`), penegakan gerbang operasional, pencatatan transaksi tindakan darurat (`IGD-TINDAKAN`), dan penutupan kunjungan (*Discharge*, *Redirect*, *Void*). |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan master identitas pasien resmi (`PAS-DATSOS`) bila pasien telah terdaftar, atau memvalidasi resolusi identitas sementara (*Visitor / Mr./Mrs. X*) menjadi Nomor Rekam Medis permanen. |
| **Admission** (`ADM`) | **Contributing Domain:** Menerbitkan nomor registrasi administratif resmi (`ADM-REG` / `RegId`) tipe IGD yang ditautkan ke kunjungan IGD untuk integrasi rekam medis institusional dan syarat pemulangan (*discharge*). |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master unit layanan IGD fisik (`ORG-LAYANAN`), master tempat tidur observasi IGD, serta daftar dokter jaga yang berwenang melalui `ORG-PPA`. |
| **Tata Rekening** (`TRK`) | **Contributing Domain:** Menyediakan master tarif layanan IGD (`TRK-TARIF`) dan mengonsumsi seluruh pembebanan tindakan serta BHP ke dalam akun rekening tagihan pasien (`TRK-BILLING`) setelah `RegId` terhubung. |
| **Rawat Inap** (`RNA`) | **Contributing Domain:** Menerima transfer pasien dari IGD yang memerlukan rawat inap lanjutan melalui pemesanan bangsal (`RNA-WAITLIST` / `RNA-BED`). |
| **Rawat Jalan** (`RJL`) | **Contributing Domain:** Menerima pengalihan pasien IGD kategori non-darurat (*Redirect Rawat Jalan*) menuju poliklinik rawat jalan (`RJL-ANTRIAN` / `RJL-KONSUL`). |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known | **Primary Capability:** Menerbitkan nomor kunjungan unik operasional (`IgdVisitId`), mengelola penugasan dokter jaga, mengatur alokasi dan perpindahan bed IGD, menautkan registrasi administratif, memelihara lini masa peristiwa (*event timeline*), dan mengeksekusi penutupan kunjungan (*Discharge*, *Redirect*, *Void*). |
| `IGD-TRIAGE` Triage | Gawat Darurat | Known | Melakukan penilaian kegawatdaruratan klinis (ATS1–ATS5) yang menjadi prasyarat mutlak (*triage gate*) sebelum alokasi tempat tidur IGD diperbolehkan. |
| `IGD-TINDAKAN` IGD Tindakan | Gawat Darurat | Known | Mencatat prosedur dan tindakan medis darurat yang diberikan kepada pasien selama kunjungan IGD untuk pembebanan biaya. |
| `IGD-RANAP` IGD Transfer Ranap | Gawat Darurat | Known | Mencatat keputusan klinis transfer pasien gawat darurat menuju perawatan rawat inap. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas resmi pasien (Nomor RM, nama, tanggal lahir, alamat) bila pasien telah terdaftar di rumah sakit. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan dan memvalidasi data dokter jaga IGD yang ditugaskan pada kunjungan. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Mengelola master unit IGD dan fasilitas fisik tempat tidur observasi IGD (`BedIgd`). |
| `ADM-REG` Registration | Admission | Known | Menerbitkan nomor registrasi resmi (`RegId`) yang ditautkan ke kunjungan IGD untuk legalitas administrasi dan penagihan. |
| `TRK-BILLING` Billing | Tata Rekening | Known | Mengonsumsi rincian pembebanan tindakan darurat dan BHP ke dalam rekening tagihan pasien setelah `RegId` terhubung. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Kunjungan Pasien Gawat Darurat (*Emergency Visit*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Nomor Kunjungan Unik Operasional**:
   - Terbit satu pengenal kunjungan unik (**`IgdVisitId`**, menggunakan penomoran sistem standar dengan prefiks `IGV`, contoh: `IGV-261010-0001`).
2. **Pencatatan Identitas Pengunjung Awal (*Visitor Data*)**:
   - Tercatat identitas awal pasien yang datang:
     - Nama pasien / subjek (dapat menggunakan identitas darurat seperti *Mr. X* atau *Mrs. X* bila belum teridentifikasi).
     - Jenis kelamin (*Gender*).
     - Tanggal lahir atau perkiraan usia.
     - Nomor kontak keluarga / pengantar (opsional saat situasi kritis).
3. **Penetapan Waktu Masuk Resmi (*Daftar Date Time*)**:
   - Tercatat tanggal dan waktu kedatangan pasien di IGD secara akurat.
4. **Penugasan Dokter Jaga IGD (*Active Attending Doctor*)**:
   - Teridentifikasi dokter jaga penanggung jawab awal (`PpaReff`) yang bertugas di instalasi gawat darurat.
5. **Pelaksanaan Gerbang Triase (*Triage Gate Fulfilled*)**:
   - Kunjungan mencatat status triase (`HasTriage`), tingkat kegawatan aktif (`TriageLevel`), dan kode warna (`TriageColor`).
   - Penilaian triase wajib diselesaikan sebelum pasien ditempatkan di tempat tidur observasi/tindakan.
6. **Alokasi dan Riwayat Tempat Tidur Tunggal (*Single Active Bed Occupancy*)**:
   - Pasien dapat berstatus tidak menempati bed (`BedId = "-"`) atau menempati tepat satu tempat tidur IGD aktif (`BedId` valid).
   - Terbentuk riwayat pemakaian tempat tidur (**`PakaiBedIgd`**) yang mencatat jam masuk (*check-in*) dan jam keluar (*check-out*).
   - Perpindahan tempat tidur (*transfer bed*) memindahkan okupansi dari satu bed ke bed lain dalam satu kesatuan transaksi tanpa mengakhiri episode kunjungan.
7. **Pencatatan Transaksi Layanan Medis Darurat**:
   - Selama kunjungan berlangsung, tindakan medis darurat (`IGD-TINDAKAN`) dan pemakaian BHP (`BhpIgd`) dapat dicatat langsung mengacu pada `IgdVisitId`.
8. **Penautan Registrasi Administratif (*Administrative Registration Linking*)**:
   - Kunjungan dapat berstatus belum terhubung `RegId` (saat awal kedatangan) dan kemudian ditautkan ke nomor registrasi resmi (**`RegId`**) dari modul Admisi (`ADM-REG`).
   - Penautan registrasi mengubah status administratif dari `Daftar` menjadi `Registered`.
9. **Lini Masa Peristiwa Operasional (*Operational Event Timeline*)**:
   - Setiap tahapan operasional menghasilkan rekaman peristiwa *append-only* (`IgdVisitEvent`) untuk keperluan audit medikolegal (Daftar, AssignDokter, AssessTriage, AssignBed, CheckOutBed, TransferBed, AssignRegister, AddTindakan, AddBhp, Redirect, Discharge, Void).
10. **Status Siklus Hidup Kunjungan yang Definitif**:
    - Kunjungan berada pada salah satu status administratif yang jelas:
      - **`Daftar`**: Kunjungan aktif, pelayanan medis berjalan, belum terhubung ke registrasi administratif `RegId`.
      - **`Registered`**: Kunjungan aktif, pelayanan medis berjalan, telah terhubung ke registrasi administratif `RegId`.
      - **`Redirected`**: Pasien dialihkan ke pelayanan rawat jalan poliklinik (status terminal).
      - **`Discharged`**: Pelayanan gawat darurat selesai, pasien dipulangkan, dirujuk, atau ditransfer ke rawat inap (status terminal).
      - **`Voided`**: Kunjungan dibatalkan secara sah sebelum transaksi klinis terjadi (status terminal via audit flag).

---

### 5.2 Required Recorded Information

Setiap transaksi `IgdVisit` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Kunjungan & Waktu:
- **`IgdVisitId`**: Nomor unik kunjungan operasional IGD.
- **`DaftarDateTime`**: Tanggal dan jam kedatangan pasien di IGD.
- **`AdministrativeState`**: Status administratif kunjungan (`Daftar`, `Registered`, `Redirected`, `Discharged`).

#### B. Identitas Pasien / Pengunjung (*Visitor*):
- **`VisitorName`**: Nama lengkap pasien / nama identitas darurat.
- **`VisitorGender`**: Jenis kelamin (*Laki-laki / Perempuan*).
- **`TglLahir`**: Tanggal lahir pasien (atau estimasi tahun lahir).
- **`VisitorKontak`**: Nomor telepon/kontak pasien atau pengantar.

#### C. Dokter Penanggung Jawab & Tenaga Medis:
- **`Dokter` (`PpaReff`)**:
  - `PpaId`: ID dokter penanggung jawab jaga IGD.
  - `PpaName`: Nama lengkap dokter jaga.

#### D. Status Triase Terkini (*Triage Snapshot*):
- **`HasTriage`**: Penanda apakah triase telah dilakukan (*true/false*).
- **`TriageMethod`**: Metode triase aktif (`ATS`).
- **`TriageLevel`**: Level triase aktif (`ATS1` s.d. `ATS5`).
- **`TriageColor`**: Kode warna aktif (`RED`, `YELLOW`, `GREEN`, `BLACK`).
- **`LastTriageAt`**: Waktu asesmen triase terakhir.
- **`NextReTriageAt`**: Batas waktu untuk evaluasi re-triase berikutnya.
- **`ListTriage`**: Koleksi seluruh riwayat penilaian triase (*append-only*).

#### E. Okupansi Tempat Tidur (*Bed Management*):
- **`BedId`**: ID tempat tidur observasi IGD yang sedang ditempati (atau `"-"` jika tidak menempati bed).
- **`HasObserved`**: Flag penanda apakah pasien sedang berada di tempat tidur observasi (`true` jika `BedId != "-"`).
- **Riwayat Penggunaan Bed (`PakaiBedIgd`)**: Rekam jejak `CheckInDateTime`, `CheckOutDateTime`, dan ID bed terkait.

#### F. Tautan Registrasi Administratif:
- **`Reg` (`RegReff`)**:
  - `RegId`: Nomor registrasi administratif resmi dari Admisi (`ADM-REG`).
  - `PasienId`: Nomor identitas master pasien / Nomor Rekam Medis (Nomor RM).
- **`HasReg`**: Flag penanda keterhubungan registrasi (`true` jika `RegId != "-"`).

#### G. Pengalihan Rawat Jalan (*Redirection*):
- **`Redirection`**:
  - `RedirectRajalId`: Nomor referensi transaksi pengalihan rawat jalan.
  - `RedirectDateTime`: Tanggal dan jam pengalihan.
  - `Reason`: Alasan klinis pengalihan ke rawat jalan (contoh: *Kategori ATS 5, keluhan non-emergensi, kuota IGD penuh*).

#### H. Audit Jejak Operasional & Penutupan:
- **`AuditTrail`**: Data audit pembuatan (`CrtUser`, `CrtDate`), pemutakhiran (`ModUser`, `ModDate`), dan pembatalan void (`VodUser`, `VodDate`, `IsVoided`).
- **`DischargeAudit`**: Identitas petugas dan tanggal/jam penyelesaian kepulangan pasien (`UserId`, `Timestamp`).
- **`ListEvent`**: Koleksi kronologis seluruh rekaman peristiwa operasional kunjungan.

---

### 5.3 Required Business Conditions

Untuk memastikan keselamatan pasien dan kepatuhan tata kelola operasional rumah sakit, kondisi bisnis berikut wajib dipenuhi:

1. **Prinsip Alur Klinis Utama (*Clinical Flow First - Core Invariant 1 & 2*)**:
   Kunjungan IGD dapat dibuat, aktif, dan menerima tindakan medis darurat sebelum nomor registrasi administratif (`RegId`) diterbitkan. Ketiadaan `RegId` di awal tidak boleh menghambat alur penyelamatan pasien.
2. **Kepatuhan Gerbang Triase terhadap Alokasi Tempat Tidur (DR-05)**:
   Penempatan pasien ke tempat tidur IGD (`AssignBed`) dilarang keras sebelum penilaian triase (`HasTriage = true`) tercatat di sistem. Pasien wajib dinilai derajat kegawatannya sebelum menempati fasilitas tempat tidur.
3. **Eksklusivitas Tempat Tidur Tunggal (DR-06 & DR-11)**:
   Satu kunjungan IGD hanya boleh menempati paling banyak satu tempat tidur aktif pada satu waktu (*no multi-bed occupancy*). Satu tempat tidur fisik IGD hanya boleh ditempati oleh tepat satu kunjungan aktif.
4. **Integritas Transaksi Pemindahan Tempat Tidur (*Transfer Bed*)**:
   Pemindahan pasien ke tempat tidur lain (`TransferBed`) hanya diizinkan jika pasien sedang menempati bed (`HasObserved = true`), bed tujuan berstatus kosong/tersedia, dan bed tujuan berbeda dari bed asal. Penutupan riwayat bed asal dan pembukaan riwayat bed tujuan wajib dieksekusi dalam satu transaksi atomik.
5. **Larangan Pengalihan Rawat Jalan saat Menempati Bed (DR-07)**:
   Pengalihan ke poliklinik rawat jalan (`RedirectToRawatJalan`) ditolak secara mutlak jika pasien masih berstatus menempati tempat tidur observasi (`HasObserved = true`). Tempat tidur harus dikosongkan terlebih dahulu sebelum pengalihan disahkan.
6. **Gerbang Pemulangan Pasien / Discharge Gate (DR-08)**:
   Penyelesaian kepulangan kunjungan IGD (`Discharge`) wajib memenuhi dua prasyarat mutlak:
   - Pasien telah memiliki nomor registrasi administratif resmi (`HasReg = true`).
   - Pasien tidak lagi menempati tempat tidur IGD (tempat tidur telah di-checkout sebelumnya, atau sistem melakukan pelepasan otomatis / *cascade clear bed* saat discharge dieksekusi).
7. **Gerbang Pembatalan Kunjungan / Void Gate (DR-09)**:
   Pembatalan kunjungan IGD (`Void`) hanya diizinkan jika belum terdapat transaksi tindakan medis (`IGD-TINDAKAN`) dan belum ada pemakaian barang habis pakai medis (`BhpIgd`). Jika transaksi klinis telah terjadi, pembatalan kunjungan ditolak untuk mencegah anomali inventori dan finansial.
8. **Gerbang Penagihan Tagihan / Billing Gate (DR-10)**:
   Posting transaksi tindakan dan BHP IGD ke akun penagihan Tata Rekening (`TRK-BILLING`) hanya dapat dieksekusi setelah kunjungan memiliki tautan `RegId` yang sah.

---

### 5.4 Completion Proof

Kunjungan Pasien Gawat Darurat dinyatakan selesai dan sah (*completed and established*) apabila bukti bisnis berikut dapat diverifikasi:

1. **Jalur Pemulangan (*Discharged*)**:
   - Status administratif bernilai **`Discharged`**.
   - Nomor registrasi administratif (`RegId`) terbukti ada dan valid.
   - Tempat tidur observasi telah dikosongkan dan status bed pada `ORG-LAYANAN` kembali siap pakai (*Active/Clean*).
   - Audit penyelesaian pemulangan (`DischargeAudit`) tercatat lengkap dengan identitas petugas dan waktu pemulangan.
   - Transaksi tindakan dan BHP darurat telah terkirim ke `TRK-BILLING` untuk penyelesaian pembayaran kasir atau klaim penjamin.
2. **Jalur Pengalihan Rawat Jalan (*Redirected*)**:
   - Status administratif bernilai **`Redirected`**.
   - Catatan pengalihan (`RedirectionType`) mencatat nomor pengalihan, waktu pengalihan, dan alasan klinis pengalihan secara lengkap.
   - Pasien terbukti tidak menempati tempat tidur IGD (`BedId = "-"`).
3. **Jalur Pembatalan (*Voided*)**:
   - Indikator audit `IsVoided` bernilai `true` dengan `VodDate` tercatat.
   - Terverifikasi tidak ada transaksi tindakan medis atau pemakaian BHP aktif yang menggantung pada kunjungan tersebut.

---

## 6. Outcome Boundary

### Start
Outcome dimulai ketika:
1. Pasien gawat darurat tiba di pintu Instalasi Gawat Darurat; DAN
2. Petugas pendaftaran IGD / perawat triase mencatat kedatangan pasien dan membuka entitas kunjungan baru (`Daftar`).

### End
Outcome berakhir ketika salah satu kondisi terminal berikut tercapai:
1. **Discharge Selesai**: Pasien selesai mendapatkan pelayanan darurat, `RegId` terhubung, tempat tidur dilepaskan, dan kunjungan ditutup untuk dipulangkan, dialihkan ke rawat inap (`IGD-RANAP`), atau dirujuk ke fasilitas kesehatan lain; ATAU
2. **Redirect Rawat Jalan Selesai**: Pasien non-darurat dialihkan ke poliklinik rawat jalan dan status kunjungan menjadi `Redirected`; ATAU
3. **Void Selesai**: Kunjungan dibatalkan secara sah (*Void*) karena kekeliruan input tanpa adanya transaksi klinis yang telah dicatat.

---

## 7. Business Constraints

Aturan mutlak yang wajib dipatuhi:

1. **Constraint Independensi Registrasi (Core Invariant 1 & 2)**: Sistem dilarang memblokir inisiasi kunjungan IGD, asesmen triase, penugasan dokter jaga, maupun tindakan penyelamatan jiwa hanya karena pasien belum memiliki nomor registrasi admisi (`RegId`).
2. **Constraint Gerbang Triase Sebelum Tempat Tidur (DR-05)**: Sistem dilarang mengalokasikan tempat tidur observasi/tindakan kepada pasien IGD yang belum memiliki rekaman penilaian triase yang valid.
3. **Constraint Batas Kapasitas & Okupansi Tempat Tidur (DR-06)**: Satu tempat tidur IGD tidak boleh ditempati lebih dari satu pasien secara bersamaan, dan satu kunjungan pasien dilarang menempati lebih dari satu tempat tidur secara bersamaan.
4. **Constraint Atomisitas Pemindahan Tempat Tidur (DR-11)**: Pemindahan pasien antar tempat tidur IGD (*transfer bed*) harus mengeksekusi penutupan baris pemakaian bed lama dan pembukaan baris pemakaian bed baru dalam satu kesatuan transaksi database guna mencegah inkonsistensi data okupansi.
5. **Constraint Prasyarat Discharge (DR-08)**: Status pemulangan (*Discharge*) tidak dapat diberikan kepada pasien yang belum memiliki nomor registrasi administratif (`RegId`) resmi.
6. **Constraint Proteksi Transaksi Finansial pada Void (DR-09)**: Pembatalan kunjungan IGD dilarang keras jika kunjungan tersebut telah memiliki catatan tindakan medis atau pemakaian obat/BHP.
7. **Constraint Immutabilitas Status Terminal**: Kunjungan IGD yang telah mencapai status terminal (`Discharged`, `Redirected`, atau `Voided`) dilarang menerima mutasi lebih lanjut seperti penugasan dokter baru, triase baru, alokasi tempat tidur baru, atau penambahan tindakan klinis baru.

---

## 8. Business Exceptions

| Kondisi Pengecualian | Perilaku Bisnis yang Diharapkan (*Expected Behavior*) |
|----------------------|------------------------------------------------------|
| **Pasien tiba tanpa identitas dan tanpa keluarga (*Unidentified / Mr./Mrs. X*)** | Kunjungan tetap dibuat dengan nama darurat (*Mr. X / Mrs. X*), estimasi jenis kelamin, dan usia perkiraan. Layanan medis langsung dimulai. Pemutakhiran nama resmi dan penautan `RegId` dilakukan setelah keluarga atau identitas kependudukan terverifikasi. |
| **Seluruh tempat tidur observasi IGD penuh saat pasien membutuhkan bed** | Sistem menolak alokasi tempat tidur baru dengan pemberitahuan kapasitas penuh. Penanganan darurat sementara dilakukan di ruang tindakan darurat/kursi triase, dan pasien dimasukkan ke dalam daftar tunggu pemindahan bed. |
| **Upaya alokasi bed pada pasien yang belum di-triase** | Sistem memblokir aksi `AssignBed` dan menampilkan instruksi wajib: *"Pasien belum melalui proses triase. Lakukan penilaian triase terlebih dahulu."* |
| **Upaya alokasi bed pada pasien yang sedang menempati bed lain** | Sistem menolak aksi `AssignBed` dan mengarahkan pengguna menggunakan fungsi `TransferBed` jika pasien hendak dipindahkan, atau melakukan `CheckOutBed` terlebih dahulu. |
| **Upaya redirect ke rawat jalan saat pasien masih menempati bed** | Sistem menolak aksi `RedirectToRawatJalan` dan memberikan peringatan bahwa tempat tidur observasi pasien harus dikosongkan terlebih dahulu. |
| **Upaya discharge pada kunjungan yang belum memiliki `RegId`** | Sistem menolak eksekusi `Discharge` dengan pesan: *"Visit belum memiliki registrasi administratif resmi. Hubungkan nomor registrasi (RegId) sebelum melakukan discharge."* |
| **Upaya void pada kunjungan yang telah mencatat tindakan medis / BHP** | Sistem menolak pembatalan kunjungan dengan pesan: *"Kunjungan memiliki transaksi tindakan atau BHP yang tercatat; pembatalan (void) tidak diperbolehkan."* |
| **Pasien pulang atas permintaan sendiri (APS) atau melarikan diri (*Walk Out*)** | Petugas menghubungkan `RegId`, mencatat berita acara kepulangan paksa/insiden pada catatan kepulangan, melepaskan tempat tidur, dan menyelesaikan status kunjungan menjadi `Discharged` dengan keterangan khusus. |
| **Penggantian nomor registrasi (`ReplaceRegister`) pada kunjungan yang salah tautan** | Sistem memvalidasi bahwa kunjungan belum terminal, memverifikasi `RegId` baru valid dan berbeda dari `RegId` lama, memperbarui referensi identitas pengunjung sesuai pasien baru, dan mencatat peristiwa `ReplaceRegister` pada linimasa audit. |

---

## 9. Acceptance Criteria

| # | Kriteria Penerimaan (*Criterion*) | Memvalidasi (*Validates*) |
|---|----------------------------------|---------------------------|
| **AC-01** | Sistem berhasil membuka kunjungan IGD baru dengan nomor pengenal operasional unik (`IgdVisitId`) dan status awal `Daftar` tanpa mewajibkan keberadaan `RegId` di muka. | Completeness |
| **AC-02** | Sistem berhasil menugaskan dokter jaga penanggung jawab yang berstatus aktif di unit IGD (`ORG-PPA`). | Correctness |
| **AC-03** | Sistem menolak penempatan tempat tidur (`AssignBed`) jika kunjungan belum memiliki asesmen triase (`HasTriage = false`), dan mengizinkannya setelah triase selesai dicatat. | Constraint |
| **AC-04** | Sistem berhasil menempatkan pasien pada tepat satu tempat tidur IGD yang berstatus kosong, dan mencegah penempatan pada tempat tidur yang sedang terisi oleh pasien lain (*concurrency guard*). | Constraint & Correctness |
| **AC-05** | Mekanisme `TransferBed` berhasil memindahkan pasien dari tempat tidur asal ke tempat tidur tujuan, menutup riwayat bed lama, dan membuka riwayat bed baru dalam satu transaksi atomik tanpa mengakhiri kunjungan. | Correctness |
| **AC-06** | Sistem mengizinkan pencatatan tindakan medis darurat (`IGD-TINDAKAN`) dan pemakaian BHP selama kunjungan berstatus aktif (`Daftar` atau `Registered`). | Completeness |
| **AC-07** | Sistem berhasil menautkan nomor registrasi administratif (`RegId`) resmi ke kunjungan IGD, mengubah status administratif menjadi `Registered`, dan mencatat peristiwa audit penautan. | Completeness & Correctness |
| **AC-08** | Sistem menolak pengalihan rawat jalan (`RedirectToRawatJalan`) apabila pasien masih menempati tempat tidur observasi (`HasObserved = true`). | Constraint |
| **AC-09** | Sistem menolak pelaksanaan `Discharge` jika kunjungan belum memiliki `RegId`, dan berhasil mengeksekusi `Discharge` secara tuntas dengan melepaskan seluruh tempat tidur ketika `RegId` telah terhubung. | Constraint & Completeness |
| **AC-10** | Sistem menolak pembatalan kunjungan (`Void`) jika kunjungan telah memiliki data tindakan medis atau pemakaian BHP aktif. | Exception & Constraint |

---

## 10. Out of Scope

Outcome ini secara tegas **TIDAK mencakup**:

1. **Pengelolaan Perawatan Rawat Inap Lanjutan**: Penempatan kamar bangsal reguler/ICU, sensus harian tempat tidur rawat inap, dan perhitungan biaya sewa kamar rawat inap dikelola oleh Rawat Inap Domain (`RNA-BED`, `RNA-CHARGE`).
2. **Penyelesaian Transaksi Finansial di Kasir**: Pelunasan kuitansi pembayaran, pembayaran tunai/non-tunai, dan penutupan kasir shift dikelola oleh modul Tata Rekening & Kasir (`TRK-KASIR`, `TRK-ALOKASI-PEMBAYARAN`).
3. **Dokumentasi Asesmen Medis Lengkap & CPPT (EMR)**: Lembar resume medis gawat darurat lengkap, formulir transfer internal, catatan perkembangan pasien terintegrasi, dan rekaman tanda vital digital mendalam dikelola oleh domain Rekam Medis Elektronik (EMR).
4. **Sistem Antrean Panggilan Fisik Display IGD**: Pengoperasian display layar televisi antrean publik dan mesin tiket antrean fisik dikelola oleh modul antrean rumah sakit terpadu.
5. **Verifikasi Eligibilitas Kepesertaan Jaminan Eksternal**: Penerbitan Surat Eligibilitas Peserta (SEP) BPJS Kesehatan dan validasi rujukan online dikelola oleh kapabilitas `BPJ-VCLAIM`.
