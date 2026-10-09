# OUTCOME: Manajemen Berkas Rekam Medis

| Field       | Value        |
|-------------|--------------|
| Code        | OC-BRM-MUTASI-BERKAS     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap pasien yang menerima pelayanan kesehatan di rumah sakit memiliki berkas rekam medis fisik sebagai dokumen medikolegal yang memuat riwayat asuhan kesehatan. Dalam operasional rumah sakit, berkas rekam medis fisik dikelola sebagai satu kesatuan utuh per pasien — satu folder rekam medis yang dapat berpindah-pindah antar unit layanan sesuai dengan kebutuhan pelayanan dan kepentingan rumah sakit lainnya.

Rumah sakit harus selalu mengetahui di mana berkas fisik setiap pasien berada, unit mana yang saat ini bertanggung jawab atas keberadaannya, dan bagaimana riwayat perpindahannya sejak berkas pertama kali dibuat. Fakta ini harus terpersistensi secara otoritatif sebagai dasar akuntabilitas medikolegal dan kesinambungan pelayanan.

Tanpa keterlacakan berkas rekam medis fisik yang terdefinisi secara otoritatif:
- Berkas fisik berisiko terselip, tidak diketahui keberadaannya, atau terlambat tersedia saat pasien membutuhkan pelayanan, yang dapat mengganggu kesinambungan asuhan medis dan keselamatan pasien.
- Rumah sakit kehilangan akuntabilitas medikolegal terkait pihak yang saat ini bertanggung jawab atas penguasaan berkas fisik, melanggar ketentuan kerahasiaan dan keamanan dokumen rekam medis (Permenkes No. 24 Tahun 2022).
- Penyebab kehilangan berkas tidak dapat ditelusuri karena tidak ada jejak perpindahan yang terekam secara sah.

---

## 2. Outcome Statement

Keberadaan berkas rekam medis fisik pasien — mulai dari inisialisasi pertama kali hingga sepanjang masa aktifnya — **telah tercatat dan terpersistensi dalam sistem secara otoritatif: diketahui unit mana yang saat ini memegang tanggung jawab atas berkas fisik tersebut, dan dapat ditelusuri ke mana saja berkas itu pernah berpindah beserta siapa yang bertanggung jawab pada setiap perpindahan.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Berkas Rekam Medis** | **Pemilik Utama**: Memiliki tanggung jawab penuh atas registri berkas rekam medis fisik — mencatat keberadaan berkas, menetapkan unit pemegang terkini, dan memelihara seluruh riwayat perpindahan berkas fisik melalui kapabilitas `BRM-MUTASI`. |
| **Pasien** | **Penyedia Identitas Subjek**: Menyediakan identitas pasien yang valid dan Nomor Rekam Medis (No RM) unik seumur hidup melalui kapabilitas `PAS-DATSOS` sebagai jangkar identifikasi tunggal folder rekam medis fisik — satu pasien, satu berkas. |
| **Organisasi** | **Penyedia Referensi Unit & Petugas**: Menyediakan daftar unit layanan yang absah sebagai titik keberadaan berkas (`ORG-LAYANAN`) dan data petugas yang bertanggung jawab atas setiap perpindahan berkas (`ORG-PPA`). |
| **Admission** | **Penyedia Konteks Pelayanan**: Memberikan informasi kebutuhan berkas berdasarkan kunjungan terdaftar (`ADM-REG`) dan reservasi yang dijadwalkan (`ADM-BOOKING`), sehingga kebutuhan penyiapan berkas dapat diidentifikasi secara tepat waktu. |

> **Catatan**: Unit layanan klinis (Rawat Jalan, Rawat Inap, Gawat Darurat, dan unit lainnya) berperan sebagai **unit pemegang berkas** — mereka adalah pihak yang menerima, menggunakan, dan menyerahkan kembali berkas fisik. Tanggung jawab pencatatan perpindahan berkas tetap berada di Domain Berkas Rekam Medis.

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

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Setiap pasien terdaftar di rumah sakit memiliki tepat satu berkas rekam medis fisik yang terhubung permanen dengan Nomor Rekam Medis pasien.
- Sistem selalu mengetahui secara otoritatif unit mana yang saat ini bertanggung jawab atas keberadaan fisik berkas setiap pasien.
- Status peredaran berkas tercatat secara otoritatif, mencerminkan kondisi aktual berkas: apakah berkas tersimpan di ruang rekam medis, sedang berada di suatu unit layanan, atau sedang dalam proses perpindahan antar unit.
- Setiap perpindahan berkas fisik antara satu unit dan unit lainnya tercatat sebagai fakta yang dapat dibuktikan, dengan informasi unit asal, unit tujuan, waktu, dan petugas yang terlibat.
- Seluruh riwayat perpindahan berkas sejak berkas pertama kali dibuat tersimpan secara kronologis, tidak terputus, dan tidak dapat diubah — membentuk rantai pertanggungjawaban yang utuh.
- Kondisi berkas fisik diketahui: apakah berkas dalam keadaan baik, rusak, atau tidak dapat ditemukan (hilang).

### 5.2 Required Recorded Information

**Identitas Master Berkas Rekam Medis:**
- Nomor Rekam Medis (No RM) pasien — sebagai pengenal tunggal berkas fisik.
- Nomor Pasien internal sistem.
- Nama lengkap pasien.
- Tanggal berkas rekam medis fisik pertama kali dibuat.
- Lokasi penyimpanan dasar di ruang rekam medis (nomor rak, lemari, atau seksi penyimpanan).
- Kondisi fisik berkas saat ini.

**Posisi & Penanggung Jawab Terkini:**
- Unit yang saat ini memegang tanggung jawab atas berkas fisik.
- Petugas yang menerima atau memegang berkas di unit tersebut.
- Status peredaran berkas yang berlaku saat ini.
- Waktu terakhir posisi dan penanggung jawab berkas diperbarui.

**Fakta Setiap Perpindahan Berkas:**
- Jenis peristiwa perpindahan: inisialisasi berkas baru, pengeluaran dari ruang rekam medis, penerimaan di unit tujuan, perpindahan langsung antar unit, atau pengembalian ke ruang rekam medis.
- Unit asal.
- Unit tujuan.
- Petugas yang menyerahkan berkas.
- Petugas yang menerima berkas.
- Waktu perpindahan terjadi.
- Konteks perpindahan: referensi kunjungan atau alasan lain (keperluan audit, penelitian, medikolegal, klaim asuransi, dsb.).

**Riwayat Perpindahan Berkas:**
- Daftar kronologis seluruh peristiwa perpindahan berkas sejak pertama kali dibuat, memuat setiap fakta perpindahan di atas secara berurutan.

### 5.3 Required Business Conditions

- Satu pasien hanya memiliki satu berkas rekam medis fisik yang sah; tidak dibenarkan adanya dua folder berkas aktif untuk pasien yang sama beredar secara bersamaan.
- Pada setiap titik waktu, harus ada tepat satu unit yang tercatat sebagai penanggung jawab berkas fisik. Tidak boleh ada kondisi di mana berkas tidak memiliki penanggung jawab yang jelas.
- Berkas yang sedang berada di suatu unit tidak dapat dikeluarkan kembali dari ruang rekam medis. Apabila unit lain memerlukan berkas tersebut, perpindahan dilakukan secara langsung dari unit pemegang ke unit yang membutuhkan, tanpa melalui ruang rekam medis sebagai perantara.
- Berkas rekam medis fisik baru hanya dibuat apabila pasien belum pernah memiliki berkas fisik sebelumnya.
- Pengembalian berkas dari unit layanan ke ruang rekam medis menetapkan kembali unit rekam medis sebagai penanggung jawab aktif berkas.
- **Berkas dinyatakan hilang** apabila berkas tidak dapat ditemukan secara fisik di unit yang tercatat sebagai penanggung jawab terkini, dan tidak ada catatan perpindahan resmi yang menjelaskan keberadaannya di unit lain. Dalam kondisi ini: (a) unit yang tercatat sebagai penanggung jawab terkini tetap dianggap sebagai custodian terakhir yang sah hingga berkas ditemukan atau diserahkan secara formal; (b) rantai pertanggungjawaban harus tetap utuh — tidak ada entri riwayat yang boleh dihapus meskipun berkas dalam status hilang; (c) status hilang dicatat sebagai fakta tersendiri dalam sistem.
- Keterlacakan posisi dan status berkas dapat diverifikasi kapan saja oleh unit yang berkepentingan untuk mendukung kesinambungan pelayanan dan pemenuhan kewajiban medikolegal.

### 5.4 Completion Proof

- Posisi unit penanggung jawab terkini dan kondisi berkas dapat ditemukan berdasarkan Nomor Rekam Medis atau nama pasien.
- Riwayat perpindahan berkas menampilkan seluruh peristiwa perpindahan secara kronologis lengkap sejak berkas pertama kali dibuat.
- Setiap perpindahan berkas yang terjadi menghasilkan entri riwayat yang dapat dibuktikan dengan unit asal, unit tujuan, waktu, dan petugas yang terlibat.
- Apabila berkas dinyatakan hilang, kondisi tersebut tercatat dalam sistem dengan unit penanggung jawab terakhir yang jelas.

---

## 6. Outcome Boundary

### Start

Dimulai ketika berkas rekam medis fisik pasien pertama kali dibuat dan keberadaannya dicatat dalam sistem. Sejak saat itu, berkas memiliki identitas yang terhubung ke Nomor Rekam Medis pasien dan unit rekam medis sebagai penanggung jawab pertama.

> Outcome ini tidak bergantung pada adanya kunjungan atau booking yang aktif. Selama berkas fisik itu ada dan belum dimusnahkan secara sah, keterlacabannya tetap merupakan tanggung jawab yang harus dipenuhi — termasuk untuk keperluan audit, penelitian, medikolegal, dan klaim.

### End

Outcome ini berlangsung sepanjang masa aktif berkas rekam medis fisik di rumah sakit. Tidak ada titik akhir tunggal per episode pelayanan; setiap pengembalian berkas ke ruang rekam medis menyelesaikan satu siklus peredaran, tetapi berkas tetap aktif dan wajib dilacak untuk siklus peredaran berikutnya.

---

## 7. Business Constraints

- **Prinsip Satu Berkas per Pasien**: Satu pasien diwakili oleh tepat satu folder rekam medis fisik. Objek yang dilacak adalah folder secara utuh, bukan lembaran atau formulir individual di dalamnya.
- **Prinsip Penanggung Jawab Tunggal**: Pada setiap waktu, berkas fisik berada di bawah tanggung jawab tepat satu unit layanan. Tidak diperbolehkan ada kondisi di mana kepemilikan berkas tidak terdefinisi atau diklaim oleh lebih dari satu unit.
- **Rantai Pertanggungjawaban Tidak Terputus**: Setiap perpindahan berkas fisik harus menghasilkan catatan perpindahan yang memuat unit asal, unit tujuan, waktu, dan petugas yang terlibat. Tidak ada perpindahan berkas yang sah tanpa pencatatan.
- **Kekekalan Riwayat Perpindahan**: Riwayat perpindahan berkas yang telah tercatat tidak dapat diubah atau dihapus. Koreksi atas kesalahan pencatatan dilakukan melalui entri koreksi yang terpisah, bukan dengan mengubah entri yang ada.
- **Larangan Pemisahan Berkas Fisik**: Berkas rekam medis fisik tidak boleh dipisah menjadi beberapa bagian dan dikirimkan ke unit yang berbeda secara bersamaan.
- **Keberlakuan Tanggung Jawab Terakhir saat Berkas Hilang**: Apabila berkas tidak dapat ditemukan, unit yang terakhir tercatat sebagai penanggung jawab tetap menanggung status custodian hingga ada penyelesaian resmi — baik berkas ditemukan dan dikembalikan, atau status hilang dikonfirmasi secara formal.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Berkas fisik tidak dapat ditemukan di unit yang tercatat sebagai penanggung jawab** | Berkas dinyatakan hilang dan dicatat sebagai fakta dalam sistem. Unit yang terakhir tercatat sebagai penanggung jawab tetap menjadi custodian terakhir yang sah. Riwayat perpindahan berkas tetap utuh dan tidak boleh diubah. Apabila pelayanan mendesak, berkas pengganti sementara dapat dibuat dengan penanda khusus yang terhubung ke No RM pasien; hal ini dicatat sebagai peristiwa tersendiri. |
| **Berkas fisik sedang berada di suatu unit ketika unit lain membutuhkannya** | Perpindahan berkas dilakukan langsung dari unit pemegang ke unit yang membutuhkan, tanpa dikembalikan terlebih dahulu ke ruang rekam medis. Perpindahan ini dicatat sebagai peristiwa perpindahan antar unit yang sah. |
| **Berkas telah diserahkan oleh unit pengirim tetapi belum dikonfirmasi oleh unit penerima** | Berkas berada dalam kondisi sedang berpindah. Unit pengirim masih tercatat sebagai penanggung jawab terakhir yang sah hingga unit penerima mengkonfirmasi penerimaan secara formal. |
| **Pasien baru belum memiliki berkas rekam medis fisik** | Berkas rekam medis fisik baru diinisialisasi dan dicatat dalam sistem dengan unit rekam medis sebagai penanggung jawab pertama, kemudian proses peredaran berkas dapat dimulai. |
| **Kunjungan atau booking pasien dibatalkan setelah berkas sudah diserahkan ke unit layanan** | Berkas dikembalikan ke ruang rekam medis dan peristiwa pengembalian dicatat. Unit rekam medis kembali menjadi penanggung jawab aktif. |
| **Berkas fisik mengalami kerusakan berat dan diganti wadahnya** | Penggantian map/sampul fisik dicatat sebagai peristiwa tersendiri dalam riwayat berkas. Seluruh riwayat perpindahan sebelumnya, Nomor Rekam Medis, dan isi berkas dipertahankan. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Setiap berkas rekam medis fisik terasosiasi secara unik dengan tepat satu Nomor Rekam Medis pasien. | Completeness |
| **AC-02** | Berkas rekam medis fisik baru dapat dibuat dan dicatat keberadaannya beserta unit penanggung jawab pertama pada saat pasien baru terdaftar. | Completeness |
| **AC-03** | Unit yang saat ini bertanggung jawab atas berkas fisik setiap pasien dapat diketahui berdasarkan Nomor Rekam Medis atau nama pasien. | Correctness |
| **AC-04** | Setiap peristiwa perpindahan berkas menghasilkan catatan yang memuat unit asal, unit tujuan, waktu, dan petugas yang terlibat. | Completeness |
| **AC-05** | Perpindahan berkas langsung antar unit layanan dapat dicatat tanpa keharusan berkas dikembalikan ke ruang rekam medis terlebih dahulu. | Correctness |
| **AC-06** | Pengembalian berkas ke ruang rekam medis menetapkan unit rekam medis sebagai penanggung jawab aktif berkas. | Completeness |
| **AC-07** | Riwayat perpindahan berkas menampilkan seluruh peristiwa perpindahan secara kronologis lengkap sejak berkas pertama kali dibuat. | Completeness |
| **AC-08** | Berkas fisik pada setiap saat hanya memiliki tepat satu unit penanggung jawab; tidak ada kondisi di mana berkas tidak memiliki penanggung jawab yang terdefinisi. | Constraint |
| **AC-09** | Berkas yang sedang berada di suatu unit tidak dapat dikeluarkan ulang dari ruang rekam medis sebelum dikembalikan secara resmi. | Constraint |
| **AC-10** | Riwayat perpindahan berkas bersifat permanen dan tidak dapat dihapus atau diubah oleh pihak manapun. | Constraint |
| **AC-11** | Berkas yang dinyatakan hilang dicatat kondisinya dalam sistem dengan unit penanggung jawab terakhir yang jelas; riwayat perpindahan tetap utuh. | Exception |
| **AC-12** | Berkas yang telah diserahkan oleh unit pengirim tetapi belum dikonfirmasi penerimaan oleh unit penerima tetap tercatat sebagai tanggung jawab unit pengirim. | Exception |
| **AC-13** | Keterlacakan berkas berlaku untuk semua alasan perpindahan — pelayanan, audit, penelitian, medikolegal, dan klaim — bukan hanya perpindahan yang dipicu oleh kunjungan aktif. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Manajemen Dokumen & Formulir Individual di Dalam Berkas**: Pengelolaan lembaran formulir, pengurutan halaman rekam medis, atau pengindeksan dokumen klinis spesifik di dalam folder rekam medis.
- **Pencatatan Rekam Medis Elektronik (Asuhan Medis)**: Pengisian catatan klinis, resume medis, tindakan, dan asuhan yang dilakukan secara digital → domain pelayanan klinis terkait (Rawat Jalan, Rawat Inap, Gawat Darurat).
- **Registrasi Kunjungan Pasien**: Pencatatan pendaftaran kedatangan pasien ke loket atau unit pelayanan → **OC-ADM-REGISTRASI Registrasi** (Unified REGISTRASI Outcome, mengonsolidasikan registrasi Rawat Jalan, IGD, dan Rawat Inap).
- **Booking & Reservasi Pelayanan**: Pengelolaan reservasi dan jadwal perjanjian pasien → **OC-ADM-BOOKING Booking**.
- **Master Data Pasien & Data Sosial**: Pengelolaan profil master pasien dan identitas kependudukan → **OC-PAS-DATA-SOSIAL-PASIEN Data Sosial Pasien**.
- **Kodifikasi Penyakit & Prosedur Medis**: Pengkodean diagnosis dan tindakan untuk keperluan casemix → **OC-BRM-CASEMIX-CODING Casemix dan Coding**.
- **Pelaporan Statistik Rumah Sakit**: Laporan RL dan sensus harian → **OC-BRM-PELAPORAN-RL Pelaporan RL** dan **OC-BRM-SENSUS-INDEX Pelaporan Index dan Sensus**.
- **Mekanisme Fisik Pengantaran Berkas**: Pengaturan kurir, porter, atau sarana transportasi fisik pengantaran berkas antar unit.
- **Penyusutan, Retensi, dan Pemusnahan Berkas Fisik**: Kebijakan pemilahan berkas inaktif, jadwal retensi arsip, dan berita acara pemusnahan berkas fisik secara hukum.
