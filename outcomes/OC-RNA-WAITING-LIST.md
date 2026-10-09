# OUTCOME: WaitingList (Inpatient Bed Waiting Queue)

| Field       | Value                |
|-------------|----------------------|
| Code        | OC-RNA-WAITING-LIST  |
| Version     | 1.0                  |
| Status      | Draft                |
| LastUpdated | 2026-10-10           |

---

## 1. Business Purpose

Rumah sakit memerlukan mekanisme formal untuk mencatat, mengelola, dan memantau antrean tunggu pasien yang telah diarahkan ke unit rawat inap tetapi belum menempati tempat tidur secara definitif (*inpatient bed waiting queue*) sebagai fakta bisnis persisten (*persisted business fact*).

Fakta antrean tunggu bangsal ini memisahkan secara tegas antara penetapan tujuan administratif rawat inap (*destination assignment*) dengan penerimaan dan penempatan fisik aktual di tempat tidur (*actual ward admission and bed placement*). Hal ini didasarkan pada prinsip tata kelola rumah sakit bahwa wewenang untuk menempatkan pasien ke dalam tempat tidur spesifik berada mutlak pada staf/perawat unit bangsal penerima, bukan pada loket pendaftaran admisi maupun unit perujuk.

Keberadaan fakta `WaitingList` esensial untuk:
1. **Visibilitas dan Kesiapan Bangsal**: Memberikan visibilitas waktu-nyata (*real-time visibility*) bagi perawat unit bangsal mengenai daftar pasien yang sedang dalam perjalanan menuju bangsal mereka, baik dari admisi baru (Instalasi Gawat Darurat, Poliklinik Rawat Jalan, atau Direct Admission) maupun antrean alih rawat internal (*inter-ward transfer*, seperti dari bangsal umum ke ICU).
2. **Prioritas Klinis & Alokasi Terbimbing**: Memastikan pasien dengan tingkat kegawatan klinis lebih tinggi (*Cito / Emergency* atau *Urgent*) mendapatkan prioritas penempatan tempat tidur yang sesuai dengan kebutuhan medis spesifik (seperti fasilitas isolasi, oksigen sentral, atau pemantauan ketat).
3. **Pencatatan Rencana Penempatan Non-Locking**: Memungkinkan staf mencatat rencana/anjuran alokasi bed sementara (*pre-allocated advisory bed*) tanpa mengunci bed fisik secara sepihak sebelum pasien tiba dan diverifikasi secara langsung.
4. **Pelacakan Waktu Tunggu Admisi**: Menyediakan data historis yang akurat mengenai lama waktu tunggu pasien (*admission wait time*) dari saat diputuskan rawat inap hingga mendapatkan tempat tidur fisik untuk peningkatan mutu pelayanan rumah sakit.

---

## 2. Outcome Statement

Antrean tunggu penempatan tempat tidur rawat inap telah tercatat sebagai fakta antrean aktif atau riwayat penyelesaian yang sah (`Inpatient Bed Waiting Queue exists`), menetapkan relasi antara pasien rawat inap terdaftar atau pasien dalam proses alih rawat dengan bangsal dan kelas perawatan tujuan, disertai tingkat urgensi klinis dan rencana kebutuhan fasilitas, sebelum dilakukan penempatan fisik definitif ke tempat tidur oleh perawat unit bangsal penerima.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Rawat Inap** (`RNA`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pengelolaan antrean tunggu bangsal (`RNA-WAITLIST`), pemantauan status antrean, penerimaan pasien ke bangsal, dan transisi menuju penempatan tempat tidur fisik (`RNA-BED`). |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks administratif resmi episode rawat inap pasien (`RegId` aktif tipe Rawat Inap melalui `ADM-REG`) serta tujuan bangsal awal saat admisi baru. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data struktural instalasi rawat inap, unit bangsal, kamar/ruangan, kelas perawatan, dan referensi tempat tidur melalui `ORG-BANGSAL`. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data identitas demografi resmi, penjamin, dan nomor rekam medis pasien yang sah melalui `PAS-DATSOS`. |
| **Gawat Darurat / Rawat Jalan** (`IGD` / `RJL`) | **Contributing Domains:** Bertindak sebagai unit pengirim/perujuk awal yang memicu kebutuhan rawat inap dan mengindikasikan tingkat urgensi klinis kedatangan pasien. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md), [`domain/05-RAWAT-INAP-DOMAIN.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/05-RAWAT-INAP-DOMAIN.md), dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `RNA-WAITLIST` Waiting List | Rawat Inap | Known | **Primary Capability:** Mencatat entri antrean masuk bangsal, memelihara status tunggu, mengurutkan prioritas antrean, dan memfasilitasi panggilan/penerimaan pasien ke bangsal. |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks registrasi aktif rawat inap (`RegId`) dan penjamin pembiayaan sebagai prasyarat otorisasi pembentukan antrean. |
| `ORG-BANGSAL` Bangsal | Organisasi | Known | Menyediakan referensi unit bangsal tujuan, kamar, nomor bed, dan kelas perawatan fisik tempat tidur. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan data verifikasi identitas pasien (Nomor Rekam Medis, nama, jenis kelamin, usia/tanggal lahir). |
| `RNA-TRANSFER` Patient Transfer | Rawat Inap | Known | Menyediakan konteks alih rawat internal ketika antrean tunggu dipicu oleh perpindahan pasien antar-bangsal (misal bangsal reguler ke ICU). |
| `RNA-BED` Pakai Bed | Rawat Inap | Known | Menerima pasien dari antrean saat perawat bangsal melakukan penempatan fisik definitif ke tempat tidur, yang menyelesaikan entri antrean tunggu ini. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Antrean Tunggu Penempatan Tempat Tidur Rawat Inap (*WaitingList*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Entri Antrean Unik**:
   - Terbentuk satu catatan antrean dengan identifikasi unik (`WaitListId`) yang merekam subjek pasien dan waktu masuk antrean (*queue entry timestamp*).
2. **Keterikatan Konteks Kunjungan / Episode Rawat Inap**:
   - Entri terikat secara valid pada nomor registrasi rawat inap aktif (`RegId`).
3. **Penetapan Sasaran Bangsal & Kelas Perawatan**:
   - Terdefinisi unit bangsal tujuan (misal: Bangsal Anggrek, Ruang ICU, Bangsal Melati).
   - Terdefinisi kelas perawatan yang diminta / dialokasikan sesuai hak kepesertaan atau persetujuan pasien (misal: VIP, Kelas 1, Kelas 2, Kelas 3).
4. **Pencatatan Sumber Kedatangan (Entry Source)**:
   - Teridentifikasi asal kedatangan pasien: Admisi Baru dari IGD (`IGD`), Rujukan Rawat Jalan (`RJL`), Admisi Terencana/Langsung (`ADM`), atau Alih Rawat Antar Bangsal (`RNA-TRANSFER`).
5. **Klasifikasi Prioritas Klinis & Kebutuhan Khusus**:
   - Tercatat tingkat urgensi klinis pasien: **Cito / Emergency**, **Urgent**, atau **Elektif / Rutin**.
   - Tercatat indikator kebutuhan khusus kamar bila ada (seperti Ruang Isolasi, Oksigen Sentral, Ruang Khusus Anak/Kebidanan, dsb.).
6. **Rencana Alokasi Bed Sementara Bersifat Advisory**:
   - Sistem dapat mencatat nomor bed rencana (*planned/tentative bed*), namun bersifat anjuran non-locking (*advisory only*) dan **tidak mengunci** ketersediaan fisik tempat tidur sebelum serah terima aktual dilakukan.
7. **Status Siklus Hidup Antrean Definitif**:
   - Entri antrean memiliki status operasional yang tegas: **Menunggu (Waiting / Queued)**, **Ditempatkan (Admitted / Placed)**, **Dibatalkan (Cancelled)**, atau **Dialihkan (Rerouted)**.

---

### 5.2 Required Recorded Information

Setiap entri `WaitingList` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Antrean & Konteks Pasien:
- **`WaitListId`**: Identitas unik entri antrean tunggu bangsal.
- **`RegId`**: Nomor unik registrasi rawat inap aktif pasien (`ADM-REG`).
- **Nomor Rekam Medis & Nama Pasien**: Identitas sah pasien (`PAS-DATSOS`).
- **Penjamin Pembiayaan**: Skema pembiayaan pasien (BPJS, Asuransi, Umum/Pribadi).

#### B. Destinasi Bangsal & Kelas:
- **Unit Bangsal Tujuan**: Kode dan nama bangsal penerima tempat tidur.
- **Kelas Perawatan Tujuan**: Kelas kamar rawat yang diminta/dituju.
- **Rencana Bed (Advisory)**: Kode/nomor tempat tidur yang direncanakan sementara (opsional, tidak mengunci bed fisik).

#### C. Sumber Kedatangan & Rujukan:
- **Tipe Sumber Kedatangan**:
  - `IGD` (Transfer dari Instalasi Gawat Darurat)
  - `RJL` (Rujukan Rawat Inap dari Poli Rawat Jalan)
  - `ADM` (Admisi Langsung / Pendaftaran Rawat Inap Elektif)
  - `TRANSFER_INTERNAL` (Alih rawat dari bangsal lain di rawat inap)
- **Unit / Ruang Asal**: Kode unit pengirim (misal: Ruang Resusitasi IGD, Poli Penyakit Dalam, Bangsal Mawar).
- **DPJP Pengirim / Penanggung Jawab**: Identitas dokter yang merekomendasikan/menginstruksikan rawat inap.

#### D. Urgensi & Kebutuhan Klinis:
- **Tingkat Prioritas**:
  - `Cito / Emergency` (Prioritas utama antrean bangsal)
  - `Urgent` (Prioritas menengah dengan pengawasan ketat)
  - `Elektif / Rutin` (Antrean standar berurutan)
- **Kebutuhan Fasilitas Khusus**:
  - `Isolasi Airborne / Droplet`
  - `Oksigen Sentral / Ventilator`
  - `Dekat Nurse Station`
  - `Fasilitas Khusus Lainnya`

#### E. Siklus Waktu & Status Antrean:
- **Waktu Masuk Antrean**: Tanggal dan jam antrean dibentuk.
- **Status Antrean**:
  - `Waiting / Queued`: Pasien sedang dalam antrean tunggu bangsal.
  - `Reserved (Advisory)`: Pasien antre dengan catatan rencana nomor bed tertentu.
  - `Placed / Admitted`: Pasien telah diterima secara fisik dan ditempatkan ke bed oleh perawat bangsal (memicu pembentukan fakta `PakaiBed`).
  - `Cancelled`: Antrean dibatalkan.
  - `Rerouted`: Antrean dialihkan ke bangsal lain karena kondisi kapasitas atau perubahan kebutuhan klinis.
- **Waktu Penyelesaian / Pembatalan**: Tanggal dan jam status antrean ditutup atau dialihkan.

#### F. Akuntabilitas Petugas & Alasan:
- **Petugas Pendaftar Antrean**: Identitas petugas admisi/perawat pengirim yang mencatat antrean.
- **Perawat Penerima Bangsal**: Identitas staf/perawat bangsal penerima yang memproses penempatan pasien.
- **Alasan Pembatalan / Pengalihan**: Keterangan resmi jika antrean berstatus `Cancelled` atau `Rerouted` (misal: "Pasien Pulang APS dari IGD", "Bangsal Penuh - Dialihkan ke Bangsal Teratai", "Kondisi Pasien Memburuk - Dialihkan Langsung ke ICU").

---

### 5.3 Required Business Conditions

1. **Prasyarat Registrasi Rawat Inap**:
   - Pasien wajib memiliki registrasi aktif bertipe **Rawat Inap** dengan status **Terdaftar** pada `ADM-REG` atau dalam proses transfer resmi dari rawat inap (`RNA-TRANSFER`).
2. **Keterbatasan Satu Antrean Aktif**:
   - Seorang pasien dengan registrasi rawat inap yang sama tidak boleh memiliki lebih dari satu entri `WaitingList` berstatus aktif (`Waiting` atau `Reserved`) secara bersamaan.
3. **Wewenang Penempatan Mutlak Unit Penerima**:
   - Penutupan antrean menjadi status `Placed / Admitted` hanya sah apabila dilakukan oleh staf/perawat yang memiliki otorisasi pada unit bangsal tujuan penerima. Loket admisi maupun unit pengirim tidak memiliki wewenang mengeksekusi penempatan bed langsung.
4. **Sifat Advisory dari Alokasi Bed**:
   - Rencana bed fisik yang dicantumkan pada antrean bersifat advisory; apabila saat pasien tiba bed tersebut tidak dapat digunakan (misal masih kotor/`RNA-HK` belum selesai atau ada kendala fisik), perawat bangsal penerima berhak memilihkan bed alternatif yang setara tanpa membatalkan antrean.

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan antrean tunggu tersimpan secara persisten dengan identitas unik `WaitListId`.
2. Pasien muncul dalam daftar pantau antrean masuk (*Inpatient Ward Waiting Dashboard*) pada unit bangsal tujuan terkait dengan urutan prioritas yang tepat.
3. Saat pasien diterima di bangsal dan ditempatkan ke bed fisik (`RNA-BED`), status entri antrean terbukti bertransisi menjadi **`Placed / Admitted`** dengan waktu realisasi dan identitas perawat penerima tercatat secara lengkap.
4. Apabila terjadi pembatalan atau pengalihan, catatan riwayat antrean tetap tersimpan sebagai jejak audit (*audit trail*) dengan alasan pembatalan yang terverifikasi.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)

- **Dimulai saat:** Registrasi rawat inap diterbitkan oleh admisi (`ADM-REG`) atau permintaan transfer antar-bangsal diajukan oleh bangsal asal (`RNA-TRANSFER`), yang menetapkan unit bangsal tujuan rawat inap bagi pasien.
- **Catatan:** Booking tempat tidur jauh hari sebelum hari rawat inap (`OC-ADM-BOOKING`) berada sebelum batasan ini. `WaitingList` aktif saat episode rawat inap pasien telah dibuka secara administratif dan pasien siap atau sedang bergerak menuju bangsal.

### 6.2 End Boundary (Titik Akhir)

- **Berakhir saat salah satu dari kondisi berikut terpenuhi:**
  1. **Realisasi Masuk Kamar:** Perawat unit bangsal penerima mengonfirmasi kedatangan fisik pasien dan mendaftarkan pasien ke tempat tidur tertentu melalui kapabilitas `RNA-BED` (yang secara langsung membentuk fakta awal `PakaiBed`).
  2. **Pembatalan Pelayanan:** Pasien membatalkan rencana rawat inap (misal: menolak rawat, pulang atas permintaan sendiri / APS dari IGD, atau meninggal dunia sebelum masuk bangsal).
  3. **Pengalihan Bangsal (Rerouted):** Entri ditutup dan dialihkan ke entri antrean baru di bangsal tujuan yang baru karena ketidaksediaan fasilitas atau eskalasi kondisi medis.

---

## 7. Business Constraints

1. **Non-Locking Advisory Bed Allocation**:
   - Pemilihan atau pencatatan nomor tempat tidur pada antrean tunggu bersifat anjuran operasional (*advisory note*) dan **tidak mengunci (*non-locking*)** ketersediaan fisik tempat tidur pada master `ORG-BANGSAL`. Bed fisik hanya terkunci menjadi terisi (*Occupied*) saat perawat bangsal penerima mencatat penempatan definitif pada `RNA-BED` (`PakaiBed`).
2. **Aturan Pengurutan Antrean Berbasis Urgensi Klinis & Waktu**:
   - Pengurutan daftar tunggu bangsal diprioritaskan pertama berdasarkan **Tingkat Urgensi Klinis** (`Cito / Emergency` mendahului `Urgent`, dan `Urgent` mendahului `Elektif/Rutin`), kemudian berdasarkan waktu kedatangan antrean (*First-In, First-Out* / FIFO).
3. **Kemandirian Kepemilikan Bangsal (Ward Authority Invariant)**:
   - Loket pendaftaran admisi dan perujuk hanya berwenang menentukan tujuan bangsal dan merekomendasikan kelas rawat; hanya perawat berwenang di bangsal penerima yang berhak mengubah status antrean menjadi `Placed / Admitted` dan memasukkan pasien ke bed fisik.
4. **Integritas Jejak Audit Pembatalan & Pengalihan**:
   - Seluruh pembatalan dan pengalihan bangsal wajib mencatat tanggal/jam, identitas petugas yang melakukan tindakan, serta alasan terstruktur. Data tidak boleh dihapus secara fisik (*hard delete*).
5. **Transisi Bersih Menuju PakaiBed**:
   - Penyelesaian antrean dengan status `Placed` harus secara atomik atau konsisten memicu pencatatan interval awal pada Outcome `PakaiBed` (`OC-RNA-PAKAI-BED`) dengan mencantumkan nomor bed fisik aktual yang ditempati.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Seluruh Bed di Bangsal Tujuan Penuh** | Pasien tiba di antrean bangsal, namun seluruh kapasitas tempat tidur aktif pada bangsal dan kelas terkait sedang terisi penuh (*100% Occupancy*). | Sistem menampilkan status bangsal penuh (*No Available Bed*), mempertahankan pasien dalam status `Waiting`, serta memberikan opsi kepada perawat/admisi untuk: (a) menunggu bed siap via Housekeeping (`RNA-HK`), (b) menempatkan dengan status Titip Kelas pada kelas lain yang tersedia, atau (c) mengalihkan (*Reroute*) pasien ke bangsal lain yang setara. |
| **EX-02: Pasien Batal Rawat Inap (APS / Meninggal / Rujuk Keluar)** | Pasien yang sedang mengantre memutuskan pulang atas permintaan sendiri (APS), kondisi memburuk dan meninggal dunia di IGD sebelum sempat dipindahkan, atau dirujuk ke rumah sakit lain. | Petugas membatalkan antrean dengan status `Cancelled`, mencatat alasan pembatalan secara wajib, dan melepaskan seluruh rencana bed advisory. Status registrasi admisi rawat inap disesuaikan secara konsisten. |
| **EX-03: Bed Rencana Ditempati Pasien Lain Saat Pasien Tiba** | Bed yang dicatat sebagai rencana advisory telah terisi oleh pasien darurat lain atau sedang mengalami kerusakan/perbaikan mendadak. | Karena rencana bed bersifat *non-locking advisory*, sistem tidak menghentikan proses; perawat bangsal diarahkan untuk memilih bed alternatif lain yang siap pakai di bangsal yang sama. |
| **EX-04: Pengalihan Bangsal Akibat Perubahan Kondisi Klinis** | Pasien di antrean bangsal umum tiba-tiba mengalami perburukan kondisi (misal syok anafilaktik atau gagal napas) dan membutuhkan penanganan intensif (ICU). | Entri antrean ditutup dengan status `Rerouted` (alasan: Eskalasi Klinis ke ICU), dan sistem membentuk entri antrean baru pada bangsal ICU dengan tingkat prioritas `Cito / Emergency`. |
| **EX-05: Upaya Penempatan Tanpa Otorisasi Bangsal Penerima** | Pengguna dari unit non-bangsal (misal loket admisi atau kasir) mencoba menekan tombol check-in penempatan bed bangsal. | Sistem menolak tindakan dengan pesan otorisasi bahwa penempatan bed hanya dapat dilakukan oleh staf/perawat yang bertugas di bangsal penerima. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat entri antrean tunggu bangsal baru dengan identifier unik (`WaitListId`), waktu masuk antrean, status 'Waiting', dan menghubungkannya dengan `RegId` rawat inap yang sah. | Completeness |
| **AC-02** | Bangsal tujuan, kelas perawatan yang diminta, sumber kedatangan (IGD, Poli, Admisi Langsung, atau Transfer Bangsal), dan DPJP tercatat secara lengkap pada entri antrean. | Completeness |
| **AC-03** | Entri antrean dengan prioritas 'Cito / Emergency' secara konsisten ditampilkan di urutan teratas pada daftar antrean bangsal penerima mendahului antrean 'Urgent' dan 'Elektif/Rutin'. | Business Rule (Priority Sorting) |
| **AC-04** | Pencatatan nomor bed rencana pada antrean tersimpan sebagai informasi advisory tanpa mengunci status bed fisik menjadi 'Occupied' pada master tempat tidur organisasi. | Business Rule (Non-Locking Advisory) |
| **AC-05** | Hanya staf/perawat dengan hak akses unit bangsal penerima yang dapat mengeksekusi konfirmasi penerimaan dan penempatan bed fisik pasien. | Security & Invariant |
| **AC-06** | Eksekusi penerimaan pasien oleh perawat bangsal berhasil mengubah status antrean menjadi 'Placed / Admitted' serta secara langsung memicu pembuatan rekaman penempatan tempat tidur baru pada `PakaiBed` (`OC-RNA-PAKAI-BED`). | Boundary (End Boundary & Handoff) |
| **AC-07** | Pembatalan antrean berhasil mengubah status menjadi 'Cancelled' dengan mencatat alasan pembatalan dan identitas petugas pembatal tanpa menghapus fisik rekaman data. | Constraint & Audit Trail |
| **AC-08** | Pengalihan pasien ke bangsal lain berhasil mengubah status antrean awal menjadi 'Rerouted' dan membentuk entri antrean baru di bangsal tujuan yang baru dengan mempertahankan keterikatan pada `RegId` yang sama. | Exception Handling & Traceability |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `WaitingList`:

- **Penempatan Fisik & Interval Okupansi Tempat Tidur:** Pengelolaan interval waktu okupansi aktif, check-in bed definitif, dan pembebanan kelas sewa kamar (merupakan wewenang `OC-RNA-PAKAI-BED` melalui `RNA-BED`).
- **Pembersihan dan Kesiapan Tempat Tidur:** Pemeliharaan siklus pembersihan kasur, sterilisasi ruangan, dan kesiapan bed paska-checkout (merupakan wewenang `RNA-HK`).
- **Reservasi Janji Temu Admisi Terjadwal:** Booking elektif jangka panjang sebelum episode admisi dibuka di loket admisi (merupakan wewenang `OC-ADM-BOOKING`).
- **Kalkulasi & Tarif Kamar Rawat Inap:** Penentuan besaran tarif kamar harian dan pembebanan tagihan (merupakan wewenang `OC-RNA-ROOM-CHARGE`, `TRK-TARIF`, dan `TRK-BILLING`).
- **Integrasi Ketersediaan Kamar Eksternal:** Pelaporan dan pembaruan kuota tempat tidur ke platform eksternal seperti BPJS Mobile JKN atau SIRANAP Kementerian Kesehatan (merupakan wewenang domain BPJS / integrasi pelaporan terpisah).
- **Dokumentasi Klinis & Tindakan Medis:** Rekam medis asuhan keperawatan, instruksi medis dokter, dan penanganan tindakan klinis selama menunggu (merupakan wewenang Domain EMR dan unit pelayanan klinis).
