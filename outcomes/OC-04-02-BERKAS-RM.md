# OUTCOME: Manajemen Berkas Rekam Medis

| Field       | Value        |
|-------------|--------------|
| Code        | OC-04-02     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap pasien yang menerima pelayanan kesehatan di rumah sakit memiliki berkas rekam medis fisik sebagai dokumen medikolegal yang memuat riwayat asuhan kesehatan. Dalam operasional rumah sakit, berkas rekam medis fisik dikelola sebagai satu kesatuan utuh (*single physical folder/dossier*) per pasien yang beredar melintasi berbagai unit pelayanan (ruang penyimpanan rekam medis/filing, poliklinik rawat jalan, gawat darurat, bangsal rawat inap, kamar operasi, dan unit penunjang lainnya).

Rumah sakit harus mampu mencatat, memvalidasi, memelihara, dan mempersistensi status keberadaan, lokasi penyimpanan fisik, unit pemegang tanggung jawab terkini (*custodian unit*), status peredaran, serta seluruh riwayat perpindahan (*tracking log / chain of custody*) berkas fisik pasien sepanjang siklus penggunaannya sebagai *persisted business fact*.

Tanpa pengelolaan dan keterlacakan berkas rekam medis fisik yang terdefinisi secara otoritatif:
- Berkas fisik berisiko terselip, hilang, atau terlambat sampai di ruang periksa atau ruang tindakan, yang dapat menyebabkan penundaan pelayanan (*delay in care*) dan membahayakan keselamatan pasien (*patient safety*).
- Petugas Pemberi Asuhan (PPA) kehilangan akses tepat waktu terhadap riwayat medis masa lalu pasien yang tercatat pada berkas fisik sebelumnya.
- Rumah sakit kehilangan akuntabilitas hukum dan medikolegal terkait pihak yang bertanggung jawab atas penguasaan fisik berkas rekam medis pada setiap saat, melanggar ketentuan kerahasiaan dan keamanan dokumen rekam medis (Permenkes No. 24 Tahun 2022).
- Proses penyiapan dan pencarian berkas di ruang penyimpanan rekam medis (*filing*) menjadi lambat dan tidak efisien karena ketiadaan data lokasi dan status peredaran berkas yang akurat.

---

## 2. Outcome Statement

Keberadaan, lokasi penyimpanan fisik terkini, unit pemegang tanggung jawab (*custodian unit*), serta riwayat perpindahan berkas rekam medis fisik pasien — mulai dari inisialisasi berkas baru, penyiapan dan distribusi dari ruang filing, penerimaan di unit pelayanan, transfer antar-unit, hingga pengembalian ke ruang filing — **telah tercatat, terverifikasi, dan terpersistensi dalam sistem sebagai representasi utuh dari satu folder rekam medis per pasien, menjamin kepastian lokasi dan akuntabilitas pemegang berkas fisik sepanjang siklus pelayanan di rumah sakit.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Berkas Rekam Medis** | **Pemilik Utama (*Primary Owner*)**: Mengelola registri berkas rekam medis fisik, pencatatan pembuatan folder berkas baru, status ketersediaan di ruang penyimpanan (*filing*), penyiapan berkas berdasarkan kebutuhan pelayanan, pencatatan ekspedisi/distribusi keluar, konfirmasi pengembalian berkas, serta pencatatan riwayat perpindahan berkas fisik melalui kapabilitas `BRM-MUTASI`. |
| **Pasien** | **Penyedia Identitas Subjek**: Menyediakan identitas pasien yang valid dan Nomor Rekam Medis (No RM) unik seumur hidup melalui kapabilitas `PAS-DATSOS` sebagai jangkar identifikasi tunggal folder rekam medis fisik (*One Patient, One Dossier*). |
| **Admission** | **Pemicu Kebutuhan Berkas**: Memberikan informasi kebutuhan berkas rekam medis fisik berdasarkan pendaftaran kunjungan aktif rawat jalan, rawat inap, dan IGD melalui `ADM-REG`, serta reservasi pelayanan di muka melalui `ADM-BOOKING`. |
| **Organisasi** | **Penyedia Referensi Wilayah & Petugas**: Menyediakan standarisasi master unit layanan yang menjadi titik asal, tujuan, atau pemegang berkas (`ORG-LAYANAN`), serta data petugas atau staf yang bertanggung jawab atas serah terima berkas (`ORG-PPA`). |
| **Rawat Jalan** | **Unit Konsumen & Pengguna Berkas**: Menerima berkas rekam medis fisik dari filing, menggunakan berkas selama pelayanan poliklinik, mengalihkan berkas ke poliklinik lain jika terjadi rujukan internal (`RJL-TRANSFER`), atau mengembalikan berkas ke filing rekam medis. |
| **Rawat Inap** | **Unit Pemegang & Transfer Berkas**: Menerima dan menyimpan berkas fisik selama pasien menjalani rawat inap di bangsal, mentransfer berkas saat pasien berpindah bangsal (`RNA-TRANSFER`), dan mengembalikan berkas ke filing rekam medis setelah pasien pulang (*discharge*). |
| **Gawat Darurat** | **Unit Penerima Berkas Emergensi**: Meminta dan menerima berkas fisik untuk kebutuhan penanganan darurat pasien, serta meneruskan berkas ke rawat inap atau mengembalikannya ke filing rekam medis. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `BRM-MUTASI` Mutasi Berkas | Berkas Rekam Medis | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-BOOKING` Booking | Admission | Known |
| `RJL-TRANSFER` Rujukan Internal | Rawat Jalan | Known |
| `RNA-TRANSFER` Transfer Ke Unit Lain | Rawat Inap | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Setiap pasien terdaftar di rumah sakit memiliki representasi satu berkas rekam medis fisik tunggal yang terhubung permanen dengan Nomor Rekam Medis (No RM) pasien.
- Status keberadaan fisik berkas terdata secara jelas: Berkas Fisik Tersedia (*Physical Folder Exists*) atau Berkas Fisik Baru Dibuat (*Newly Initialized*).
- Lokasi fisik dan unit pemegang tanggung jawab terkini (*current custodian*) atas berkas fisik selalu terdefinisi secara tunggal dan deterministik pada setiap waktu.
- Status peredaran berkas (*circulation status*) tercatat dan mencerminkan kondisi operasional aktual:
  - *In Filing*: Berkas berada di ruang penyimpanan rekam medis.
  - *Pulled / Prepared*: Berkas telah diambil dari rak dan disiapkan untuk distribusi.
  - *In Transit*: Berkas sedang dalam proses distribusi/pengiriman menuju unit tujuan.
  - *Received / In Use*: Berkas telah diterima dan sedang berada dalam penguasaan unit pelayanan terkait.
  - *Transferred*: Berkas sedang dialihkan langsung antar-unit pelayanan.
  - *Returned*: Berkas telah diterima kembali di ruang rekam medis.
- Setiap perpindahan berkas fisik melintasi batas unit layanan tercatat sebagai transaksi mutasi/ekspedisi yang memuat unit asal, unit tujuan, waktu, serta petugas penanggung jawab.
- Seluruh riwayat perpindahan berkas tersimpan secara kronologis dan tidak terputus (*continuous chain of custody*), membentuk jejak audit peredaran berkas yang dapat ditelusuri kembali kapan saja.
- Kebutuhan penyiapan berkas fisik terhubung dengan pemicu pelayanan (Registrasi Kunjungan atau Jadwal Booking) sehingga daftar pasien yang memerlukan berkas fisik dapat diidentifikasi secara tepat waktu.

### 5.2 Required Recorded Information

**Identitas Master Berkas Rekam Medis:**
- Nomor Rekam Medis (No RM) pasien.
- ID Pasien internal sistem.
- Nama lengkap pasien.
- Tanggal dan waktu pembuatan berkas rekam medis fisik pertama kali.
- Lokasi dasar penyimpanan di filing (*Home Filing Location* / Kode Rak / Lemari / Seksi Penyimpanan).
- Kondisi fisik folder (misal: Baik, Rusak, Duplikat Pengganti).

**Posisi & Status Terkini Berkas (*Current State*):**
- Unit pemegang terkini (*Current Custodian Unit*): Kode dan nama unit layanan yang saat ini menguasai berkas fisik.
- Petugas penanggung jawab terkini: ID dan nama petugas/staf yang menerima atau memegang berkas di unit tersebut.
- Status peredaran terkini (*Circulation Status*): *In Filing*, *Pulled*, *In Transit*, *Received / In Use*, *Transferred*, *Returned*, atau *Missing*.
- Waktu pemutakhiran status terkini (Timestamp perubahan posisi terakhir).

**Data Transaksi Perpindahan / Mutasi Berkas (*Movement Event*):**
- Nomor transaksi mutasi / ID ekspedisi berkas.
- Jenis perpindahan:
  - Penyiapan Berkas Baru (*New Folder Creation*).
  - Distribusi Keluar dari Filing (*Check-out / Distribution from Filing*).
  - Konfirmasi Penerimaan di Unit (*Check-in / Reception at Unit*).
  - Transfer Antar-Unit Pelayanan (*Unit-to-Unit Transfer*).
  - Pengembalian ke Filing (*Check-in / Return to Filing*).
- Unit asal (*Source Unit*).
- Petugas pengirim (*Sender Staff*).
- Unit tujuan (*Destination Unit*).
- Petugas penerima (*Receiver Staff*).
- Waktu pengiriman (*Dispatch Timestamp*).
- Waktu penerimaan konfirmasi (*Receipt Timestamp*).
- Referensi pemicu pelayanan (Nomor Registrasi Kunjungan atau Nomor Booking, jika perpindahan terkait episode pelayanan tertentu).
- Catatan / Keterangan perpindahan (misal: konsul poli lanjutan, pindah bangsal rawat inap, permintaan visum/penelitian, pengembalian berkas pasca discharge).

**Riwayat Pelacakan Berkas (*Chain of Custody / Tracking Log*):**
- Rangkaian historis seluruh pergerakan berkas dari awal pencatatan hingga saat ini, memuat urutan kronologis, stempel waktu, aktor penanggung jawab, unit asal-tujuan, dan perubahan status peredaran.

### 5.3 Required Business Conditions

- Satu pasien hanya memiliki satu folder berkas rekam medis fisik yang sah dan beredar di rumah sakit; tidak dibenarkan adanya dua folder berkas aktif yang beredar di dua unit berbeda pada waktu yang sama untuk satu pasien yang sama.
- Pada setiap titik waktu, berkas fisik harus memiliki tepat satu unit pemegang tanggung jawab (*single custodian rule*); tidak boleh ada status kepemilikan ganda atau lokasi yang tidak terdefinisi.
- Berkas fisik yang sedang beredar di suatu unit layanan tidak dapat didistribusikan ulang dari ruang filing; apabila unit lain memerlukan berkas tersebut, perpindahan dilakukan melalui transfer antar-unit (*Unit-to-Unit Transfer*) atau penarikan kembali terlebih dahulu ke filing.
- Konfirmasi penerimaan berkas di unit tujuan wajib memutakhirkan unit pemegang tanggung jawab aktif berkas tersebut secara real-time.
- Berkas rekam medis fisik baru diinisialisasi hanya jika pasien belum pernah memiliki berkas fisik sebelumnya (pasien baru).
- Pengembalian berkas fisik dari unit pelayanan ke ruang Rekam Medis wajib memutakhirkan status berkas kembali menjadi *In Filing* dan mengembalikan tanggung jawab penguasaan berkas kepada Unit Rekam Medis.
- Keterlacakan keberadaan dan status berkas fisik dapat diakses dan diketahui setiap saat oleh unit-unit yang berkepentingan untuk mendukung kesinambungan pelayanan medis.

### 5.4 Completion Proof

- Posisi unit pemegang terkini, status peredaran, dan lokasi fisik berkas rekam medis pasien dapat dicari dan ditampilkan secara cepat dan akurat melalui Nomor Rekam Medis atau nama pasien.
- Daftar riwayat perpindahan (*chain of custody log*) berkas fisik menampilkan seluruh jejak pergerakan secara lengkap dan kronologis dari awal hingga akhir siklus penggunaan.
- Berkas yang telah didistribusikan dari filing terverifikasi statusnya: tercatat *In Transit* saat proses kirim, atau *Received / In Use* saat telah diterima di unit pelayanan tujuan.
- Berkas yang telah selesai digunakan dalam episode pelayanan pasien tercatat telah dikembalikan ke ruang filing dengan status *In Filing* dan unit pemegang kembali ke Unit Rekam Medis.

---

## 6. Outcome Boundary

### Start

Dimulai ketika timbul kebutuhan terhadap berkas rekam medis fisik pasien — yang dipicu oleh pendaftaran kunjungan aktif (`ADM-REG`), daftar reservasi pelayanan (`ADM-BOOKING`), kebutuhan berkas baru bagi pasien yang belum memiliki folder fisik, atau permintaan peminjaman internal rumah sakit — dan petugas Rekam Medis mulai mengidentifikasi serta menyiapkan berkas fisik tersebut.

### End

Outcome ini berlangsung sebagai siklus berkelanjutan sepanjang masa aktif berkas rekam medis fisik di rumah sakit. Untuk satu siklus episode pelayanan, batas akhir tercapai ketika seluruh unit pelayanan yang merawat pasien telah selesai menggunakan berkas, berkas fisik telah diserahkan dan diterima kembali oleh unit Rekam Medis, serta status berkas terkonfirmasi tersimpan kembali di ruang penyimpanan (*filing*).

---

## 7. Business Constraints

- **Prinsip Kesatuan Folder Berkas (*Single Dossier Principle*)**: Satu pasien diwakili oleh tepat satu folder rekam medis fisik terpadu. Objek yang dikelola dan dilacak adalah folder berkas fisik secara utuh, bukan formulir atau lembaran individual di dalamnya.
- **Prinsip Kepemilikan Tunggal Terkini (*Single Custodian Principle*)**: Pada suatu waktu, berkas fisik hanya boleh berada di bawah tanggung jawab satu unit layanan tertentu. Tidak diperbolehkan adanya catatan ambiguitas lokasi atau kepemilikan ganda.
- **Rantai Pertanggungjawaban Tidak Terputus (*Unbroken Chain of Custody*)**: Setiap perubahan unit pemegang dan lokasi berkas fisik wajib menghasilkan entri riwayat perpindahan dengan mencatat unit asal, unit tujuan, tanggal-waktu, dan petugas yang terlibat.
- **Larangan Pemisahan Berkas Fisik**: Berkas rekam medis fisik dilarang dipisah atau dipecah menjadi beberapa bagian untuk dikirimkan secara parsial ke unit yang berbeda pada waktu bersamaan.
- **Kekekalan Riwayat Pelacakan (*Immutability of Movement Log*)**: Log riwayat pergerakan berkas yang telah tercatat dan tersimpan tidak dapat diedit secara retrospektif atau dihapus dari sistem guna menjaga keaslian jejak medikolegal.
- **Pencegahan Distribusi Ganda dari Filing**: Sistem melarang penerbitan instruksi distribusi baru dari filing apabila berkas fisik yang bersangkutan tercatat masih berada di unit pelayanan lain (belum kembali ke filing).
- **Keterlacakan Real-Time**: Status berkas (apakah sedang di filing, dalam transit pengiriman, sedang digunakan di poli/bangsal, atau dikembalikan) harus dapat diverifikasi secara langsung oleh staf yang berkepentingan.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Berkas fisik tidak ditemukan di rak penyimpanan (*Missing / Misplaced at Filing*)** | Petugas rekam medis menandai status berkas sebagai *Missing / Dalam Pencarian*. Jika pelayanan mendesak, petugas dapat menyiapkan map folder sementara (*temporary folder*) dengan penandaan khusus yang terhubung ke No RM pasien, dan mencatat riwayat insiden untuk investigasi pencarian. |
| **Berkas fisik masih berada di unit pelayanan sebelumnya saat pasien terdaftar di unit baru** | Sistem menampilkan informasi bahwa berkas fisik saat ini berada di unit lama beserta nama pemegang aktif. Sistem memfasilitasi pencatatan transfer langsung antar-unit (*Unit-to-Unit Transfer*) dari unit lama ke unit baru tanpa harus dikembalikan terlebih dahulu ke ruang filing rekam medis. |
| **Berkas fisik telah dikirimkan tetapi belum diterima/dikonfirmasi oleh unit tujuan (*In-Transit Delay / Selisih Ekspedisi*)** | Berkas mempertahankan status *In Transit* dengan identitas unit pengirim dan unit tujuan yang jelas. Unit pengirim atau penerima dapat melakukan konfirmasi penerimaan fisik atau membatalkan pengiriman apabila berkas ditarik kembali sebelum sampai. |
| **Pasien baru belum memiliki berkas rekam medis fisik** | Sistem mendeteksi ketiadaan folder fisik sebelumnya dan memfasilitasi inisialisasi berkas rekam medis fisik baru yang langsung diasosiasikan dengan Nomor Rekam Medis pasien, kemudian melanjutkan proses distribusi. |
| **Kunjungan atau booking pasien dibatalkan saat berkas fisik sudah disiapkan atau dikirim** | Petugas rekam medis atau unit pelayanan melakukan transaksi pembatalan distribusi dan pengembalian berkas fisik (*Return to Filing*), sehingga status berkas kembali menjadi *In Filing*. |
| **Folder berkas fisik mengalami kerusakan fisik berat** | Petugas rekam medis mencatat tindakan penggantian map/sampul fisik baru (*re-foldering*) dengan mempertahankan seluruh riwayat pelacakan, Nomor Rekam Medis, dan isi berkas yang lama. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Setiap berkas rekam medis fisik terasosiasi secara unik dengan satu Nomor Rekam Medis pasien dan memiliki catatan lokasi awal penyimpanan (*home filing location*). | Completeness |
| **AC-02** | Berkas rekam medis fisik baru dapat diinisialisasi dan dicatat keberadaannya saat pasien baru pertama kali terdaftar dalam sistem. | Completeness |
| **AC-03** | Posisi unit pemegang terkini (*current custodian*), status peredaran, dan lokasi fisik berkas dapat dicari dan ditampilkan secara tepat berdasarkan pencarian No RM atau nama pasien. | Correctness |
| **AC-04** | Pencatatan pengeluaran berkas dari filing ke unit tujuan mencatat unit asal, unit tujuan, tanggal/waktu kirim, petugas pengirim, dan mengubah status peredaran menjadi *In Transit*. | Completeness |
| **AC-05** | Konfirmasi penerimaan berkas oleh unit tujuan berhasil memperbarui status peredaran menjadi *Received / In Use* dan menetapkan unit tersebut sebagai pemegang tanggung jawab aktif berkas. | Correctness |
| **AC-06** | Perpindahan berkas fisik langsung antar-unit pelayanan (misal antar-poliklinik atau dari poliklinik ke bangsal rawat inap) berhasil tercatat dalam riwayat mutasi tanpa keharusan kembali ke ruang filing. | Correctness |
| **AC-07** | Pengembalian berkas fisik ke Unit Rekam Medis berhasil mengembalikan status berkas menjadi *In Filing* dan menetapkan Unit Rekam Medis kembali sebagai pemegang aktif. | Completeness |
| **AC-08** | Seluruh riwayat perpindahan berkas fisik tersimpan dalam log pelacakan kronologis (*chain of custody log*) yang memuat stempel waktu, unit asal, unit tujuan, dan petugas penanggung jawab. | Completeness |
| **AC-09** | Sistem memastikan satu berkas fisik hanya memiliki tepat satu unit pemegang tanggung jawab pada satu waktu tertentu (*single custodian rule*). | Constraint |
| **AC-10** | Sistem menolak pengeluaran berkas dari filing jika status berkas fisik tercatat masih aktif berada di unit pelayanan lain, serta mengarahkan pada opsi transfer antar-unit. | Constraint |
| **AC-11** | Catatan log riwayat pergerakan berkas bersifat permanen (*immutable*) dan tidak dapat dihapus atau dimanipulasi secara sepihak. | Constraint |
| **AC-12** | Berkas fisik yang ditandai tidak ditemukan di rak (*missing*) mencatat status pencarian dan tidak menghalangi pencatatan riwayat berkas saat kemudian ditemukan. | Exception |
| **AC-13** | Berkas yang dikirimkan tetapi belum dikonfirmasi oleh unit tujuan tetap teridentifikasi berstatus *In Transit* beserta identitas petugas pengirimnya hingga dikonfirmasi terima. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Manajemen Dokumen & Formulir Individual di Dalam Berkas**: Pengelolaan lembaran formulir, pengurutan halaman rekam medis, atau pengindeksan dokumen klinis spesifik di dalam map folder rekam medis.
- **Pencatatan Rekam Medis Elektronik (RME / CPPT / Asuhan Medis)**: Pengisian resume klinis, catatan perkembangan pasien terintegrasi, anamnesis, dan tindakan medis secara digital → domain pelayanan klinis terkait (**Rawat Jalan**, **Rawat Inap**, **Gawat Darurat**).
- **Registrasi Kunjungan Pasien**: Pencatatan pendaftaran kedatangan pasien ke loket pendaftaran atau unit pelayanan → **OC-01-02 Registrasi Rawat Jalan dan IGD** dan **OC-01-03 Registrasi Rawat Inap**.
- **Booking & Reservasi Pelayanan**: Pengelolaan reservasi dan jadwal perjanjian pasien sebelum hari H → **OC-01-01 Booking**.
- **Master Data Pasien & Data Sosial**: Pengelolaan profil master pasien, NIK, alamat, dan data sosial demografi → **OC-04-01 Data Sosial Pasien**.
- **Kodifikasi Penyakit & Prosedur Medis**: Pengkodean diagnosis (ICD-10) dan tindakan medis (ICD-9-CM) untuk keperluan casemix dan penjaminan → **OC-04-03 Casemix dan Coding**.
- **Pelaporan Statistik Rumah Sakit**: Penyusunan laporan Rekapitulasi Laporan Rumah Sakit (RL 1 s/d RL 5) → **OC-04-04 Pelaporan RL**, serta sensus harian → **OC-04-05 Pelaporan Index dan Sensus**.
- **Mekanisme Fisik / Transportasi Pengantaran Berkas**: Pengaturan kurir/porter pengantar berkas, alur pengantaran fisik, atau operasional lift/pneumatic tube rumah sakit.
- **Penyusutan, Retensi, dan Pemusnahan Berkas Fisik**: Kebijakan pemilahan berkas inaktif, jadwal retensi arsip (JRA), dan berita acara pemusnahan berkas fisik secara hukum.
