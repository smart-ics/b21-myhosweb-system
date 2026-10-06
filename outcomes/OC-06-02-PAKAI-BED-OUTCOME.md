# OUTCOME: Pakai Bed

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-02     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Rumah sakit memerlukan kepastian operasional mengenai alokasi dan utilisasi sumber daya fisik tempat tidur (*bed*) bagi pasien yang menjalani rawat inap. Penggunaan tempat tidur adalah komponen operasional sentral dalam penyelenggaraan rawat inap, di mana ketersediaan fasilitas fisik harus selaras secara *real-time* dengan kehadiran aktual pasien di bangsal perawatan.

**Pakai Bed** adalah **Operasional Service Event** yang mencatat fakta bahwa seorang pasien menggunakan atau menempati **tempat tidur (*bed*) tertentu** pada pelayanan rawat inap dalam suatu periode penggunaan.

Fokus utama Outcome ini adalah **penggunaan aktual sebuah bed oleh pasien sebagai sumber daya operasional pelayanan rawat inap**. Pakai Bed bukan sekadar pencatatan administratif bahwa pasien telah terdaftar untuk dirawat pada suatu bangsal, bukan permohonan atau reservasi/pemesanan tempat tidur, dan bukan sekadar indikator ketersediaan tempat tidur secara umum.

Outcome ini harus merepresentasikan fakta bisnis bahwa:
> **seorang pasien benar-benar menggunakan suatu bed tertentu, mulai kapan penggunaan tersebut dimulai, dan kapan penggunaan tersebut berakhir.**

Pencatatan kejadian operasional ini berfungsi sebagai sumber kebenaran tunggal (*single source of truth*) yang menjawab pertanyaan operasional mendasar:
> **“Bed mana yang digunakan oleh pasien dan dalam periode kapan bed tersebut digunakan?”**

Fakta penggunaan bed aktual yang tercatat secara akuntabel menyediakan dasar yang sah bagi:
1. **Visibilitas Operasional Bangsal:** Mengetahui secara presisi keberadaan fisik pasien di tempat tidur tertentu dalam bangsal perawatan pada setiap saat;
2. **Koordinasi Pelayanan Asuhan Pasien:** Memastikan tenaga medis, perawat, dan tenaga penunjang mendatangi dan melayani pasien pada lokasi fisik tempat tidur yang tepat;
3. **Keterlacakan Siklus Sumber Daya Bed:** Mengetahui riwayat keterisian dan perputaran pemakaian setiap tempat tidur dari waktu ke waktu;
4. **Perspektif Finansial Downstream:** Menyediakan data durasi penggunaan dan kelas tempat tidur aktual sebagai dasar pembentukan biaya kamar/akomodasi (*room charge*) pada domain Tata Rekening;
5. **Perspektif Rekam Medis & Sensus:** Menyediakan fakta penempatan dan pelepasan bed sebagai sumber kompilasi sensus harian rawat inap dan perhitungan indikator efisiensi rumah sakit (seperti BOR, LOS, TOI, BTO) pada domain Berkas Rekam Medis.

---

## 2. Outcome Statement

Pakai Bed adalah **Operasional Service Event yang mencatat penggunaan atau penempatan aktual seorang pasien pada tempat tidur (bed) tertentu dalam konteks pelayanan rawat inap yang aktif, sejak penggunaan bed dimulai hingga penggunaan bed tersebut berakhir.**

Keberadaan rekaman penggunaan bed membuktikan secara sah bahwa pasien menempati bed fisik tertentu pada periode waktu tertentu, dan dapat dijadikan sumber bagi proses klinis lanjutan maupun proses downstream (seperti pembentukan *room charge* dan pelaporan sensus harian rawat inap), di mana keberhasilan proses downstream tersebut bukan merupakan syarat tercapainya outcome Pakai Bed.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | Pemilik operasional: mengelola penempatan fisik pasien ke bed tertentu serta mencatat pengakhiran/pelepasan penggunaan bed di bangsal rawat inap |
| Admission (`ADM`) | Menyediakan konteks episode registrasi rawat inap aktif tempat penempatan bed dilakukan |
| Pasien (`PAS`) | Menyediakan data identitas pasien sebagai subjek yang menggunakan tempat tidur |
| Organisasi (`ORG`) | Menyediakan data master fasilitas tempat tidur fisik, ruangan/kamar, kelas perawatan, serta unit layanan/bangsal tempat bed berada |
| Tata Rekening (`TRK`) | Domain downstream yang menerima fakta periode dan kelas penggunaan bed sebagai sumber pembentukan biaya kamar/akomodasi (*room charge*) |
| Berkas Rekam Medis (`BRM`) | Domain downstream yang menerima fakta penempatan dan durasi penggunaan bed sebagai sumber data penyusunan sensus harian rawat inap dan indikator utilisasi fasilitas |

> **Catatan Batasan Domain:**
> Outcome ini tidak mengambil alih kepemilikan atas proses pendaftaran rawat inap (*admission*), pengelolaan antrian masuk bangsal (*ward queue*), perpindahan pasien antar-unit layanan (*transfer unit*), pemulangan pasien (*discharge*), pembersihan/sanitasi fasilitas tempat tidur (*housekeeping*), penentuan tarif dan penagihan biaya kamar (*room billing*), maupun master data fasilitas fisik (*facility management*). Domain-domain tersebut berpartisipasi sesuai batas tanggung jawab bisnisnya masing-masing.

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `RNA-BED` Pakai Bed | Rawat Inap | Known |
| `RNA-ANTRIAN` Antrian Masuk Bangsal | Rawat Inap | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-BANGSAL` Room Bangsal Management | Organisasi | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `BRM-RPT` Sensus dan Index | Berkas Rekam Medis | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Domain Catalog (Governance Rule):**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain Capability. OC-06-02 tidak menetapkan, membuat, atau mengusulkan capability baru secara sepihak. Penambahan atau perubahan capability Domain merupakan keputusan tata kelola yang menjadi wewenang Product Owner.
>
> Apabila pada tahap implementasi ditemukan kebutuhan capability Domain yang belum tercantum dalam Domain Catalog, kebutuhan tersebut harus dieskalasikan kepada Product Owner untuk persetujuan ruang lingkup (*scope approval*). Hal tersebut bukan merupakan bagian dari outcome definition OC-06-02 dan tidak boleh diperlakukan sebagai capability yang sudah ditetapkan.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Keberadaan Operational Service Event Penggunaan Bed:** Keberadaan suatu rekaman kejadian operasional yang sah, dapat diidentifikasi secara unik, dan mengikat hubungan konseptual:
  $$\text{Pakai Bed} \longrightarrow \text{Pasien} \longrightarrow \text{Episode/Registrasi Rawat Inap Aktif} \longrightarrow \text{Bed Tertentu}$$
- **Konteks Rawat Inap yang Sah:** Pasien yang menggunakan bed terikat secara sah pada episode registrasi rawat inap yang sedang aktif (bukan pasien rawat jalan biasa, bukan pengunjung umum, dan bukan pasien yang telah selesai dirawat/discharged).
- **Identitas Bed Fisik yang Valid:** Tempat tidur yang digunakan merujuk pada identitas tempat tidur fisik yang valid, terdaftar, dan berada dalam status operasional aktif pada master fasilitas ruangan/bangsal rumah sakit.
- **Periode Penggunaan Bed:** Penggunaan bed memiliki dimensi waktu yang jelas:
  1. *Waktu Mulai Penggunaan:* Waktu (tanggal dan jam) aktual saat pasien mulai menempati bed tertentu, yang wajib tercatat saat penempatan dimulai;
  2. *Waktu Berakhir Penggunaan:* Waktu (tanggal dan jam) aktual saat pasien mengakhiri penempatan bed tersebut, yang wajib tercatat saat penggunaan selesai.
- **Status Siklus Hidup (Lifecycle) Penggunaan Bed:** Rekaman penggunaan bed memiliki status operasional yang secara tegas membedakan kondisi penggunaan:
  - **Sedang Digunakan (*Ongoing / In-Use*):** Pasien sedang menempati tempat tidur secara aktual;
  - **Selesai Digunakan (*Ended / Released*):** Penggunaan tempat tidur oleh pasien telah berakhir;
  - **Dibatalkan Pasca Pencatatan (*Void*):** Rekaman penggunaan bed dikoreksi karena kekeliruan pencatatan administratif tanpa menghapus jejak audit historis.
- **Ketunggalan Hunian Bed (*Single Occupancy Constraint*):** Suatu tempat tidur fisik pada satu titik waktu hanya dapat ditempati oleh satu pasien aktif (tidak boleh ada *double-occupancy* pada bed yang sama).
- **Ketunggalan Penempatan Pasien (*Single Active Bed per Patient Constraint*):** Seorang pasien rawat inap pada satu titik waktu hanya dapat menempati satu tempat tidur aktif (tidak boleh ada penempatan ganda simultan untuk pasien yang sama dalam satu episode perawatan).
- **Independensi Dampak Downstream:** Fakta operasional penggunaan bed dapat menjadi pemicu bagi pembentukan biaya kamar/akomodasi (*room charge*) pada domain Tata Rekening dan pencatatan mutasi sensus pada domain Berkas Rekam Medis. Keberhasilan atau kegagalan pembentukan proses downstream tersebut **bukan merupakan syarat keberadaan atau keabsahan Outcome Pakai Bed**.

### 5.2 Required Recorded Information

Pencatatan Operational Service Event Pakai Bed harus memuat informasi bisnis esensial berikut secara *implementation-independent*:

- **Identifikasi Unik Event Penggunaan Bed:** Identitas unik atas rekaman penempatan/penggunaan tempat tidur yang bersangkutan.
- **Subjek Pasien:** Identitas pasien yang menggunakan tempat tidur (Nomor Rekam Medis dan identitas pengenal pasien).
- **Konteks Episode Rawat Inap:** Identifikasi nomor episode/registrasi rawat inap aktif yang menjadi konteks perawatan pasien.
- **Identifikasi Tempat Tidur (Bed):** Nomor atau kode identitas fisik tempat tidur yang digunakan.
- **Konteks Lokasi Fasilitas:** Identifikasi ruangan/kamar, bangsal/unit layanan rawat inap, serta kelas pelayanan tempat tidur tersebut berada.
- **Status Operasional Penggunaan Bed:** Status lifecycle penggunaan saat ini (*Ongoing*, *Ended*, atau *Void*).
- **Waktu Mulai Penggunaan:** Tanggal dan jam aktual saat pasien mulai menempati tempat tidur.
- **Waktu Berakhir Penggunaan (Kondisional):** Tanggal dan jam aktual saat pasien berhenti menempati tempat tidur (wajib terisi ketika status mencapai *Ended*).
- **Alasan Pengakhiran Penggunaan (Kondisional):** Kategori kondisi bisnis yang menyebabkan pelepasan bed saat berstatus *Ended* (misalnya: pindah ke bed lain dalam unit yang sama, transfer ke unit rawat inap lain, pemulangan pasien / discharge, atau alasan operasional lainnya).
- **Petugas Pencatat Penempatan:** Identitas petugas yang mencatat atau mengonfirmasi penempatan awal pasien pada bed.
- **Petugas Pencatat Pelepasan (Kondisional):** Identitas petugas yang mencatat atau mengonfirmasi pelepasan bed saat penggunaan berakhir.
- **Informasi Koreksi / Void (Kondisional):** Alasan bisnis koreksi administratif serta identitas pihak yang melakukan pembatalan pencatatan jika rekaman di-void.

### 5.3 Required Business Conditions

- **Episode Rawat Inap Aktif:** Pasien harus memiliki episode registrasi rawat inap berstatus aktif pada saat penempatan bed dicatat.
- **Kesiapan dan Ketersediaan Bed:** Tempat tidur yang dipilih harus terdaftar aktif dalam master fasilitas dan tidak sedang ditempati oleh pasien lain (tidak ada event penggunaan lain yang berstatus *Ongoing* pada bed tersebut).
- **Ketiadaan Penempatan Aktif Lain untuk Pasien:** Pasien yang bersangkutan tidak sedang menempati tempat tidur lain yang masih berstatus *Ongoing*. Jika pasien sebelumnya telah menempati bed lain, event penggunaan bed sebelumnya harus diselesaikan (*Ended*) terlebih dahulu sebelum event penggunaan bed baru dimulai.
- **Keabsahan Waktu Mulai:** Waktu mulai penggunaan bed harus berada dalam rentang masa berlaku episode rawat inap pasien dan tidak boleh berada di masa depan (*future date/time*).
- **Keabsahan Waktu Berakhir:** Waktu berakhir penggunaan bed harus sama dengan atau lebih lambat dari waktu mulai penggunaan bed, dan tidak boleh berada di masa depan.
- **Integritas Transisi Status:**
  - Status hanya dapat berpindah dari *Ongoing* menjadi *Ended* ketika penggunaan fisik telah selesai dan waktu berakhir tercatat;
  - Rekaman penempatan yang keliru dicatat hanya dapat dikoreksi melalui status *Void* dengan menyertakan alasan bisnis yang sah;
  - Rekaman yang telah berstatus *Ended* atau *Void* tidak dapat diaktifkan kembali (*re-opened*) menjadi *Ongoing*; kebutuhan penempatan baru harus membentuk event baru.

### 5.4 Completion Proof

Outcome ini dinyatakan terpenuhi (*established*) apabila:

- **Fakta Penempatan Awal Tercatat:** Operational Service Event penempatan bed telah tercatat secara sah dengan identitas pasien, episode rawat inap aktif, nomor bed fisik, waktu mulai penggunaan aktual, dan berstatus **Ongoing**.
- **Fakta Keterisian Bed Terverifikasi:** Tempat tidur fisik yang bersangkutan terbukti secara operasional sedang ditempati oleh pasien, dan pasien teridentifikasi berada di tempat tidur tersebut.
- **Fakta Pelepasan Bed Tercatat (Saat Selesai):** Ketika pasien berhenti menggunakan tempat tidur, rekaman penggunaan bed diperbarui dengan mencatat waktu berakhir penggunaan aktual dan status bertransisi menjadi **Ended**, membuktikan bahwa periode penggunaan telah selesai dan tempat tidur telah dilepaskan.
- **Keterlacakan Historis Terpelihara:** Seluruh riwayat penggunaan bed (siapa pasiennya, bed mana yang digunakan, kapan mulai, dan kapan selesai) dapat ditelusuri dan diaudit secara transparan per pasien, per episode rawat inap, maupun per fasilitas tempat tidur.

---

## 6. Outcome Boundary

### Start

Dimulai ketika pasien secara aktual mulai menempati tempat tidur tertentu di bangsal rawat inap, dan peristiwa penempatan tersebut dicatat ke dalam sistem operasional bangsal dengan merekam identitas pasien, episode rawat inap aktif, nomor bed fisik, waktu mulai penggunaan, serta menetapkan status penggunaan menjadi **Ongoing**.

> Penempatan bed dapat dipicu oleh kedatangan pasien baru dari admisi/antrian masuk bangsal (`RNA-ANTRIAN`), kepindahan pasien dari bed lain, perpindahan dari unit layanan lain (`RNA-TRANSFER`), atau rujukan dari instalasi gawat darurat (`IGD-RANAP`). Namun, proses pemicu tersebut berada di luar batasan Start OC-06-02.

### End

Berakhir ketika peristiwa penggunaan tempat tidur oleh pasien tersebut mencapai titik akhir operasional:
1. Pasien berhenti menempati tempat tidur secara aktual, ditandai dengan pencatatan waktu berakhir penggunaan aktual dan status penggunaan bertransisi menjadi **Selesai Digunakan (*Ended*)**; ATAU
2. Pencatatan penempatan bed dikoreksi melalui mekanisme pembatalan bisnis yang sah dengan status **Dibatalkan Pasca Pencatatan (*Void*)** disertai pencatatan alasan koreksi.

> **Penegasan Batasan Selesai (Boundary Clarity):**
> - Berakhirnya penggunaan bed dapat disebabkan oleh berbagai kondisi operasional: pasien pindah ke bed lain dalam unit yang sama, pasien ditransfer ke unit layanan lain (`OC-06-03`), pasien dipulangkan/meninggal (`OC-06-04`), atau alasan operasional lainnya.
> - Kondisi-kondisi tersebut adalah *penyebab operasional* berakhirnya pemakaian bed, **tetapi bukan merupakan inti definisi dari Pakai Bed**. Pakai Bed hanya bertanggung jawab mencatat fakta awal dan berakhirnya penggunaan tempat tidur tertentu.
> - Alur proses perpindahan antar-unit, proses pemulangan pasien, proses pembersihan tempat tidur oleh tim sanitasi/housekeeping (`RNA-HK`), serta pembentukan tagihan sewa kamar (*room charge*) **bukan merupakan bagian dari completion condition OC-06-02**.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Representasi Operational Service Event:** Pakai Bed adalah representasi kejadian operasional penggunaan fasilitas fisik pelayanan rawat inap, bukan clinical service event, bukan tindakan medis/asuhan klinis, bukan pemesanan/reservasi bed, dan bukan sekadar pengelolaan data master tempat tidur.
2. **Keterikatan Mutlak pada Episode Rawat Inap Aktif:** Penggunaan bed hanya sah apabila dikaitkan dengan pasien yang memiliki episode registrasi rawat inap aktif. Sistem tidak mengizinkan pencatatan pemakaian bed bagi individu tanpa episode rawat inap aktif.
3. **Model Konseptual yang Mengikat:** Hubungan entitas harus selalu mematuhi hierarki konseptual:
   $$\text{Pakai Bed} \longrightarrow \text{Pasien} \longrightarrow \text{Episode/Registrasi Rawat Inap} \longrightarrow \text{Bed}$$
4. **Ketunggalan Okupansi Tempat Tidur (*No Simultaneous Double Occupancy*):** Suatu tempat tidur fisik yang sedang berstatus *Ongoing* tidak boleh dialokasikan atau dicatat untuk ditempati oleh pasien lain sebelum status penggunaan pasien sebelumnya beralih menjadi *Ended* atau *Void*.
5. **Ketunggalan Tempat Tidur per Pasien (*No Simultaneous Multi-Bed per Patient*):** Seorang pasien rawat inap dalam satu episode perawatan tidak boleh memiliki lebih dari satu event penggunaan bed yang berstatus *Ongoing* pada waktu yang bersamaan.
6. **Pemisahan Tegas dari Transfer Unit:**
   - **Pakai Bed bukan Transfer Unit.** Keduanya adalah Outcome yang berbeda dengan tujuan bisnis yang berbeda.
   - Pakai Bed menjawab pertanyaan: *“Bed mana yang digunakan oleh pasien dan dalam periode kapan bed tersebut digunakan?”*
   - Transfer Unit menjawab pertanyaan: *“Apakah pasien berpindah dari satu unit pelayanan ke unit pelayanan lainnya?”*
   - **Kasus Perpindahan Bed Internal:** Pasien berpindah dari Bed 01 ke Bed 02 di dalam Bangsal yang sama menghasilkan: penyelesaian penggunaan Bed 01 (status *Ended*) dan dimulainya penggunaan Bed 02 (status *Ongoing*). Perubahan ini **tidak otomatis menjadi Transfer Unit** dan tidak boleh diperlakukan sebagai Transfer Unit.
   - **Kasus Perpindahan Antar-Unit:** Pasien berpindah dari Bangsal Mawar/Bed 01 ke Bangsal Melati/Bed 05 menghasilkan: penyelesaian penggunaan Bed 01 (status *Ended*), dimulainya penggunaan Bed 05 (status *Ongoing*), dan peristiwa perpindahan unit layanannya dicatat serta dikelola oleh **OC-06-03 Transfer Unit**.
7. **Pemisahan Tegas dari Registrasi Rawat Inap:**
   - Mengacu pada `OC-01-03 REG-INAP`, Registrasi Rawat Inap bertanggung jawab menetapkan episode opname resmi, tujuan pelayanan, kelas hak, dan jenis jaminan pasien.
   - **OC-06-02 Pakai Bed bertanggung jawab atas fakta penempatan fisik dan durasi penggunaan bed aktual.**
   - Proses registrasi rawat inap tidak boleh dimasukkan kembali ke dalam ruang lingkup OC-06-02.
8. **Pemisahan dari Status Kesiapan Fasilitas / Housekeeping:** Status fisik tempat tidur (kotor, sedang dibersihkan, siap pakai) dikelola oleh kapabilitas penunjang housekeeping (`RNA-HK`). OC-06-02 berfokus pada fakta penempatan pasien pada tempat tidur yang telah siap pakai.
9. **Independensi dari Perhitungan Finansial Downstream:** Fakta operasional penggunaan bed menjadi dasar penghitungan biaya sewa kamar/akomodasi pada domain Tata Rekening. Namun, keberhasilan pembentukan *charge*, ketersediaan konfigurasi tarif kamar, atau penyelesaian pembayaran kasir tidak mempengaruhi keabsahan fakta operasional Pakai Bed.
10. **Integritas Koreksi Administratif (*Void*):** Rekaman penggunaan bed yang keliru dicatat (misalnya salah memilih nomor bed saat input) dapat dikoreksi menjadi *Void*. Void merupakan koreksi bisnis terhadap pencatatan dan bukan penghapusan fisik rekaman (*hard delete*). Jejak audit historis atas siapa yang mencatat dan siapa yang membatalkan harus tetap terpelihara demi akuntabilitas rekam medis dan operasional.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak memiliki episode registrasi rawat inap aktif saat penempatan diajukan | **Pencatatan penempatan bed ditolak.** Pasien harus memiliki registrasi rawat inap yang sah dan aktif terlebih dahulu sebelum dapat ditempatkan pada tempat tidur bangsal. |
| Tempat tidur tujuan sedang digunakan oleh pasien lain (berstatus *Ongoing*) | **Pencatatan penempatan bed ditolak.** Tempat tidur tidak dapat digunakan secara ganda. Petugas harus memilih tempat tidur lain yang kosong atau menunggu pelepasan bed oleh pasien sebelumnya. |
| Pasien terdeteksi masih memiliki penggunaan bed lain yang berstatus *Ongoing* | **Pencatatan penempatan bed baru ditolak.** Pasien tidak dapat menempati dua bed sekaligus. Penggunaan bed sebelumnya harus diakhiri (*Ended*) terlebih dahulu sebelum penempatan pada bed baru dapat dicatat. |
| Tempat tidur tujuan berstatus tidak aktif, diblokir, atau dalam perbaikan pada master fasilitas | **Pencatatan penempatan bed ditolak.** Penempatan hanya diizinkan pada tempat tidur yang aktif dan siap digunakan. |
| Waktu mulai penggunaan berada di masa depan (*future date/time*) | **Pencatatan penempatan bed ditolak.** Waktu mulai harus mencerminkan waktu aktual pasien menempati bed dan tidak boleh mendahului waktu saat ini. |
| Waktu mulai penggunaan mendahului waktu registrasi rawat inap pasien | **Pencatatan penempatan bed ditolak.** Penempatan bed tidak boleh terjadi sebelum episode rawat inap pasien resmi terbentuk. |
| Waktu berakhir penggunaan mendahului waktu mulai penggunaan saat pelepasan bed | **Pencatatan pelepasan bed ditolak.** Waktu berakhir harus sama dengan atau lebih lambat dari waktu mulai penggunaan bed. |
| Waktu berakhir penggunaan berada di masa depan (*future date/time*) | **Pencatatan pelepasan bed ditolak.** Waktu berakhir harus mencerminkan waktu pelepasan aktual dan tidak boleh berupa waktu di masa depan. |
| Permintaan koreksi (*Void*) diajukan tanpa alasan bisnis yang sah | **Koreksi pencatatan ditolak.** Alasan koreksi wajib disertakan untuk keperluan akuntabilitas audit rumah sakit. |
| Rekaman penggunaan bed yang sudah berstatus *Ended* atau *Void* diminta diaktifkan kembali | **Pengaktifan kembali ditolak.** Siklus penempatan yang telah selesai atau batal tidak dapat dibuka ulang. Kebutuhan penempatan baru harus dicatat sebagai event penggunaan bed yang baru. |
| Pembentukan *room charge* downstream gagal atau konfigurasi tarif belum tersedia | **Fakta penggunaan bed tetap sah dan berstatus valid (tidak membatalkan outcome Pakai Bed).** Kendala teknis atau konfigurasi tarif dieskalasikan ke domain Tata Rekening tanpa membatalkan fakta operasional penempatan bed pasien. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Pakai Bed telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Sistem dapat membuktikan bahwa identitas pasien yang menggunakan tempat tidur teridentifikasi secara jelas dan sah. | Completeness |
| AC-02 | Sistem dapat membuktikan bahwa tempat tidur fisik yang digunakan teridentifikasi secara spesifik beserta konteks ruangan/kamar dan bangsalnya. | Completeness |
| AC-03 | Sistem dapat membuktikan bahwa penggunaan tempat tidur terikat pada episode registrasi rawat inap aktif yang sah dari pasien bersangkutan. | Correctness |
| AC-04 | Waktu mulai penggunaan tempat tidur aktual dapat diketahui dan tercatat secara valid saat pasien mulai menempati bed. | Completeness |
| AC-05 | Penggunaan tempat tidur yang masih berlangsung (status *Ongoing*) dapat dibedakan secara tegas dan konsisten dari penggunaan tempat tidur yang telah berakhir (status *Ended*). | Correctness |
| AC-06 | Waktu berakhir penggunaan tempat tidur aktual dapat diketahui dan tercatat secara valid saat pasien selesai menggunakan tempat tidur. | Completeness |
| AC-07 | Perubahan penempatan bed oleh pasien menghasilkan siklus hidup yang sesuai: penggunaan bed lama bertransisi menjadi *Ended* dengan waktu selesai tercatat, dan penggunaan bed baru dimulai dengan status *Ongoing*. | Correctness |
| AC-08 | Perubahan penempatan bed di dalam unit pelayanan/bangsal yang sama hanya mengelola siklus penggunaan bed (End bed lama, Start bed baru) dan tidak dengan sendirinya diperlakukan atau dicatat sebagai Transfer Unit. | Constraint |
| AC-09 | Perpindahan pasien antar-unit pelayanan yang berbeda tidak diambil alih oleh OC-06-02; OC-06-02 hanya mencatat akhir penggunaan bed di unit asal dan awal penggunaan bed di unit tujuan, sedangkan perpindahan antar-unit tetap menjadi tanggung jawab OC-06-03 Transfer Unit. | Constraint |
| AC-10 | Sistem menolak pencatatan penempatan pasien pada tempat tidur yang sedang aktif ditempati oleh pasien lain (*single occupancy rule*). | Constraint |
| AC-11 | Sistem menolak pencatatan penempatan baru bagi pasien yang masih memiliki catatan penggunaan tempat tidur aktif (*Ongoing*) yang belum diselesaikan. | Constraint |
| AC-12 | Rekaman penggunaan bed yang salah dicatat dapat dikoreksi melalui mekanisme *Void* dengan menyertakan alasan bisnis yang sah, dan riwayat rekaman historisnya tetap dapat ditelusuri untuk keperluan audit. | Correctness |
| AC-13 | Fakta operasional penggunaan bed dapat dijadikan sumber informasi yang dapat diandalkan bagi proses downstream (seperti pembentukan *room charge* pada Tata Rekening dan sensus harian pada Rekam Medis) tanpa ketergantungan status kelulusan terhadap proses downstream tersebut. | Correctness |
| AC-14 | Spesifikasi Outcome Pakai Bed didefinisikan secara murni berorientasi pada fakta bisnis yang *implementation-independent* tanpa bergantung pada skema database, tabel, kolom, API endpoint, form antarmuka pengguna, atau enum teknis tertentu. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pendaftaran pasien rawat inap, penetapan DPJP utama, penentuan kelas hak jaminan, dan penerbitan nomor registrasi rawat inap → **OC-01-03 Registrasi Rawat Inap** (`ADM-REG`).
- Pengelolaan antrian pasien masuk bangsal sebelum penempatan bed fisik dilakukan → **RNA-ANTRIAN Antrian Masuk Bangsal** (Rawat Inap Domain).
- Pengelolaan alur perpindahan administratif, konfirmasi penerimaan, dan serah terima perawatan pasien antar-unit rawat inap → **OC-06-03 Transfer Unit** (`RNA-TRANSFER`).
- Pengelolaan keputusan medis pemulangan, pembuatan ringkasan pulang, dan alur administrasi pelepasan pasien dari rawat inap → **OC-06-04 Discharge** (`RNA-DISCHARGE`).
- Pengelolaan status kesiapan, alur pembersihan, sanitasi, dan sterilisasi tempat tidur pasca pelepasan → **RNA-HK Housekeeping Bed Readiness** (Rawat Inap Domain).
- Pengelolaan master data fisik fasilitas, denah bangsal, kapasitas kamar, penomoran tempat tidur, dan pemeliharaan fasilitas → **Organisasi Domain** (`ORG-BANGSAL`).
- Penentuan struktur tarif kamar/akomodasi, formulasi perhitungan biaya harian, dan penyusunan rincian tagihan pasien → **Tata Rekening Domain** (`TRK-TARIF`, `TRK-BILLING`, `OC-02-01 Rincian Tagihan Pasien`).
- Pengelolaan sensus harian rumah sakit, perhitungan hari perawatan, dan kalkulasi indikator efisiensi rawat inap (BOR, ALOS, TOI, BTO) → **OC-04-05 Sensus dan Index** (`BRM-RPT`).
- Perencanaan, penjadwalan, pelaksanaan, dan pencatatan tindakan medis atau prosedur klinis pada pasien rawat inap → **OC-06-01 Tindakan Rawat Inap** (`RNA-*`).
- Pendokumentasian rekam medis elektronik lengkap, asesmen asuhan keperawatan, dan Catatan Perkembangan Pasien Terintegrasi (CPPT) → **Domain EMR / Rekam Medis Klinis**.
- Desain antarmuka pengguna (UI), *bed board view*, denah grafis ruangan, formulir input penempatan bed, endpoint API, skema tabel database, atau penetapan tipe data teknis.
