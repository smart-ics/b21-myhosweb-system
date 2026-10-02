# OUTCOME: Antrian Rawat Jalan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Pengelolaan antrean pasien di poliklinik rawat jalan adalah mekanisme operasional untuk menempatkan, memanggil, dan memprogresikan pasien dalam suatu *service context* pelayanan rawat jalan secara teratur, tertib, dan transparan.

Antrean (*Queue*) merupakan instrumen pengaturan alur pelayanan pada titik layanan poliklinik tertentu dan secara tegas dibedakan dari Kunjungan (*Visit*). Nomor antrean (*queue number*) mencerminkan identitas posisi antrean pasien pada *service context* terkait dan bukan merupakan identitas dari *Visit*. Satu *Visit* dapat melibatkan lebih dari satu dokter atau poliklinik, di mana masing-masing *service context* memerlukan pengelolaan antrean tersendiri.

Dalam tata kelola rumah sakit, domain **Admission** bertanggung jawab atas pembentukan dan penerbitan nomor antrean, sedangkan domain **Rawat Jalan** bertanggung jawab menerima, menggunakan, mengelola urutan pemanggilan, serta memperbarui status antrean sepanjang tahapan pelayanan di poliklinik hingga pelayanan pada antrean tersebut dinyatakan selesai.

Tanpa adanya pengelolaan antrean rawat jalan yang terstandardisasi sebagai *persisted business fact*, urutan pemanggilan pasien tidak dapat dikendalikan secara andal, deviasi pemanggilan (seperti pasien dilewati atau dipanggil ulang) tidak dapat ditelusuri, dan kepastian penyelesaian pelayanan pada setiap unit poliklinik tidak dapat dibuktikan.

---

## 2. Outcome Statement

Antrean pasien pada suatu *service context* poliklinik rawat jalan **telah aktif, dikelola proses pemanggilannya, dan diproses status pelayanannya secara tertib hingga selesai, sebagai representasi persisted business fact atas pelaksanaan antrean pelayanan rawat jalan dalam episode kunjungan pasien**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Jalan | **Pemilik utama outcome**: mengelola antrean pasien di poliklinik, mengendalikan proses pemanggilan (*calling order*), memprogresikan status antrean selama pelayanan rawat jalan, dan mencatat penyelesaian antrean. |
| Admission | Bertanggung jawab atas pembentukan dan penerbitan nomor antrean (*queue number*) pada saat registrasi kunjungan, serta memelihara siklus hidup *Visit* sebagai konteks induk. |
| Pasien | Menyediakan data identitas resmi pasien (Nomor Rekam Medis dan data sosial) yang menjadi subjek antrean. |
| Organisasi | Menyediakan referensi unit layanan poliklinik (`ORG-LAYANAN`), data dokter pemeriksa (`ORG-PPA`), dan jadwal praktik dokter (`ORG-JADWAL`) sebagai konteks operasional antrean. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `RJL-ANTRIAN` Antrian Poli | Rawat Jalan | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-ANTRIAN` Antrian Registrasi | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ORG-JADWAL` Jadwal Praktek Dokter | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Antrean rawat jalan terikat pada suatu *service context* tertentu yang didefinisikan oleh kombinasi:
  - Referensi kunjungan rawat jalan aktif (*Visit ID* / Nomor Registrasi);
  - Poliklinik tujuan (*service unit*);
  - Dokter pemeriksa (*DPJP / PPA*);
  - Tanggal pelayanan (*service date*).
- Nomor antrean (*queue number*) telah diterbitkan oleh Admission sebagai identitas/posisi antrean pasien yang bersifat tetap dan tidak berubah selama operasional antrean.
- Urutan pemanggilan (*calling order*) dapat disesuaikan secara operasional (dapat terjadi *skip*, pemanggilan ulang/*recall*, atau prioritas) tanpa mengubah nomor antrean (*queue number*) pasien.
- Status antrean bergerak mengikuti siklus hidup operasional yang sah: **Menunggu → Dipanggil → Dalam Pelayanan → Selesai** (atau status penghentian antrean karena pasien tidak hadir setelah pemanggilan ulang dan dikembalikan ke Admission).
- Hubungan antara *Visit* dan *Queue* bersifat *one-to-many* (1 Visit : N Queue). Satu episode *Visit* dapat memiliki beberapa *Queue* pada *service context* yang berbeda.
- Penyelesaian suatu antrean (*Queue Selesai*) menandai berakhirnya pelayanan pada *service context* bersangkutan, dan tidak otomatis menyebabkan *Visit* pasien berakhir.

### 5.2 Required Recorded Information

**Konteks Antrean:**
- Referensi nomor kunjungan rawat jalan (*Visit Registration Number*).
- Nomor Rekam Medis (Nomor RM) dan nama pasien.
- Poliklinik tujuan (kode dan nama unit layanan rawat jalan).
- Dokter pemeriksa (DPJP / kode dan nama dokter).
- Tanggal pelayanan (*service date*).
- Sesi praktik / jadwal layanan dokter terkait.

**Identitas & Status Antrean:**
- Nomor antrean (*queue number*) yang unik dalam konteks poliklinik, dokter, dan tanggal pelayanan.
- Status antrean saat ini (**Menunggu**, **Dipanggil**, **Dalam Pelayanan**, **Selesai**, atau **Dikembalikan ke Admission / Tidak Hadir**).

**Informasi Perjalanan Pemanggilan (Audit Operasional):**
- Waktu penerbitan / masuk antrean poli.
- Waktu pemanggilan pertama.
- Catatan status pemanggilan (apakah pasien hadir atau dilewati/*skip*).
- Waktu pemanggilan kembali (*recall*), jika pasien sebelumnya dilewati.
- Waktu mulai pelayanan klinis (saat pasien masuk ruang periksa / status **Dalam Pelayanan**).
- Waktu penyelesaian pelayanan (status **Selesai**).
- Identitas petugas / dokter yang melakukan pemanggilan atau pembaruan status.

### 5.3 Required Business Conditions

- Kunjungan rawat jalan yang menjadi referensi antrean harus berstatus aktif (**Terdaftar**) dalam sistem (`OC-01-02`).
- Nomor antrean diterbitkan oleh Admission (`ADM-REG` / `ADM-ANTRIAN`) dan tersedia untuk digunakan oleh Rawat Jalan.
- Nomor antrean harus unik dalam ruang lingkup poliklinik, dokter, dan tanggal pelayanan yang sama.
- Pada *service context* yang identik (poliklinik sama, dokter sama, tanggal sama), satu *Visit* hanya boleh memiliki satu entri antrean yang berstatus aktif.
- Perbedaan antara nomor antrean (*queue number*) dan urutan pemanggilan (*calling order*) harus dipertahankan:
  - *Queue number* adalah nomor urut identitas pendaftaran antrean;
  - *Calling order* adalah urutan fisik pemanggilan yang dapat dipengaruhi oleh ketidakhadiran pasien atau diskresi operasional poliklinik.
- Siklus hidup status antrean harus mematuhi urutan:
  `Menunggu` → `Dipanggil` → `Dalam Pelayanan` → `Selesai`
- Penanganan kondisi pasien tidak hadir saat dipanggil:
  1. Pasien yang tidak merespons panggilan dapat dilewati (*skip*); nomor antrean tidak berubah dan sistem/petugas dapat melanjutkan pemanggilan antrean berikutnya;
  2. Pasien yang dilewati dapat dipanggil kembali (*recall*) sesuai ketentuan operasional poliklinik;
  3. Jika setelah dipanggil kembali pasien tetap tidak hadir, kondisi tersebut ditetapkan sebagai pasien yang tidak melanjutkan pemeriksaan di poliklinik tersebut dan status antrean diakhiri serta dikembalikan ke kendali domain Admission.
- Antrean yang telah berstatus **Selesai** atau telah diakhiri (terminal) tidak dapat dipanggil kembali atau diaktifkan ulang.
- Status **Selesai** pada antrean hanya berlaku lokal bagi *service context* yang bersangkutan dan tidak menutup *Visit* pasien secara keseluruhan.

### 5.4 Completion Proof

- Antrean tercatat dengan status **Selesai**, disertai catatan waktu penyelesaian pelayanan oleh dokter/petugas poliklinik; ATAU
- Antrean tercatat diakhiri dengan status tidak hadir/dikembalikan ke Admission setelah upaya pemanggilan ulang tidak dipenuhi pasien.
- Rekam jejak waktu pemanggilan, waktu mulai pelayanan, dan waktu selesai terdokumentasi secara lengkap dan dapat diaudit.
- Pasien tidak lagi berstatus antre aktif pada daftar antrean poliklinik tersebut untuk hari yang bersangkutan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika nomor antrean untuk suatu *service context* rawat jalan telah diterbitkan oleh Admission (`OC-01-02` / `OC-01-07`) dan antrean tersebut tercatat dalam status **Menunggu** di poliklinik tujuan, siap untuk dikelola dan dipanggil oleh petugas atau dokter rawat jalan.

### End

Berakhir ketika salah satu dari dua kondisi terpenuhi:
1. Status antrean berubah menjadi **Selesai**, yaitu saat dokter atau perawat di poliklinik menandai bahwa pelayanan klinis untuk antrean pada *service context* tersebut telah diselesaikan; ATAU
2. Antrean diakhiri karena pasien tidak hadir setelah pemanggilan kembali (*recall*), dan tanggung jawab kelanjutan pasien dialihkan/dikembalikan ke boundary Admission sebagai pasien yang tidak melanjutkan pemeriksaan.

> **Batasan Penting:** Berakhirnya antrean pada suatu *service context* **TIDAK** mengakhiri Kunjungan (*Visit*) pasien. Kunjungan tetap berada di bawah domain Admission dan dapat memiliki *service context* / antrean lain dalam episode pelayanan yang sama.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Pemisahan Konseptual Visit dan Queue:** *Queue* bukan *Visit* dan nomor antrean bukan nomor identitas kunjungan. *Queue* adalah mekanisme penempatan dan pemanggilan pasien pada suatu *service context* tertentu.
- **Kardinalitas Layanan (Bukan 1 Visit = 1 Queue):** Satu *Visit* dapat memiliki lebih dari satu antrean aktif atau berurutan pada *service context* yang berbeda (misalnya Poli Penyakit Dalam dan Poli Gizi). Aturan "1 Visit = 1 Queue" dilarang diterapkan. Namun, untuk *service context* yang identik (poli sama, dokter sama, tanggal sama), satu *Visit* hanya boleh memiliki maksimal satu antrean aktif.
- **Pemisahan Nomor Antrean vs Urutan Pemanggilan:** Nomor antrean (*queue number*) merupakan identitas/posisi antrean yang bersifat tetap. Urutan pemanggilan (*calling order*) bersifat operasional dan dinamis. Tindakan melewati (*skip*) atau memanggil ulang (*recall*) pasien tidak boleh mengubah nomor antrean asli pasien.
- **Integritas Konteks Antrean:** Setiap entri antrean wajib memiliki referensi yang valid terhadap *Visit* rawat jalan yang aktif, unit poliklinik yang valid, dokter yang bertugas, dan tanggal pelayanan yang bersangkutan.
- **Keunikan Nomor Antrean:** Tidak boleh ada dua antrean aktif dengan nomor antrean yang sama untuk kombinasi poliklinik, dokter, dan tanggal pelayanan yang sama.
- **Imutabilitas Status Terminal:** Antrean yang sudah berstatus **Selesai** atau diakhiri (dikembalikan ke Admission) tidak dapat diaktifkan kembali. Jika pasien memerlukan pelayanan tambahan di luar rencana awal, hal tersebut harus mengikuti alur penerbitan antrean baru sesuai mekanisme rujukan internal atau registrasi.
- **Batas Kewenangan Antar Domain:** Domain Rawat Jalan tidak berwenang menerbitkan nomor antrean kunjungan awal (kewenangan Admission) dan tidak berwenang menetapkan alasan medis terbentuknya *service context* baru (kewenangan `OC-05-03 Rujuk Internal`).

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or encounters an exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak merespons saat nomor antrean dipanggil pertama kali | Antrean ditandai dilewati (*skip*). Petugas dapat melanjutkan pemanggilan antrean berikutnya tanpa membatalkan antrean pasien. Nomor antrean pasien tetap dipertahankan. |
| Pasien tetap tidak hadir setelah dilakukan pemanggilan kembali (*recall*) | Pasien ditetapkan sebagai tidak melanjutkan pemeriksaan di poliklinik tersebut. Status antrean diakhiri dan status pasien dikembalikan ke boundary Admission sesuai prosedur operasional yang berlaku. |
| Referensi *Visit* pasien telah dibatalkan di loket pendaftaran sebelum dipanggil | Antrean poli tidak dapat diproses lebih lanjut dan otomatis ditandai batal/dikeluarkan dari daftar antrean aktif poliklinik. |
| Dokter pemeriksa berhalangan hadir atau sesi praktik dihentikan mendadak saat antrean masih berstatus Menunggu | Antrean yang belum dilayani tidak dapat diselesaikan secara normal. Status antrean ditangguhkan dan dialihkan ke dokter pengganti atau dijadwalkan ulang sesuai koordinasi dengan Admission. |
| Duplikasi antrean untuk *Visit* yang sama pada poliklinik, dokter, dan tanggal yang sama | Sistem menolak pembentukan antrean aktif kedua. Antrean aktif yang sudah ada tetap dipertahankan dan ditampilkan kepada petugas. |
| Percobaan pemanggilan pada antrean yang sudah berstatus **Selesai** atau diakhiri | Sistem menolak pemanggilan. Antrean yang sudah mencapai status terminal tidak dapat dipanggil kembali. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Setiap antrean rawat jalan tercatat dengan konteks lengkap: nomor antrean, referensi *Visit* aktif, poliklinik tujuan, dokter pemeriksa, tanggal pelayanan, dan status antrean. | Completeness |
| AC-02 | Status antrean dapat diprogresikan mengikuti urutan siklus hidup yang sah: **Menunggu → Dipanggil → Dalam Pelayanan → Selesai**. | Correctness |
| AC-03 | Satu *Visit* dapat terhubung ke lebih dari satu antrean rawat jalan pada poliklinik atau dokter yang berbeda, memvalidasi bahwa sistem tidak membatasi 1 Visit = 1 Queue. | Constraint |
| AC-04 | Dalam satu poliklinik, dokter, dan tanggal pelayanan yang sama, nomor antrean bersifat unik dan tidak terdapat dua antrean aktif untuk nomor antrean yang sama. | Constraint |
| AC-05 | Penyesuaian urutan pemanggilan (*skip* atau *recall*) tidak mengubah nomor antrean (*queue number*) yang telah diterbitkan untuk pasien. | Correctness |
| AC-06 | Pasien yang tidak hadir saat dipanggil dapat dilewati (*skip*), dan antrean pasien berikutnya dapat dipanggil tanpa membatalkan antrean pasien yang dilewati. | Exception |
| AC-07 | Pasien yang tetap tidak hadir setelah pemanggilan kembali (*recall*) diubah statusnya menjadi tidak melanjutkan pemeriksaan pada poliklinik tersebut dan dikembalikan ke boundary Admission. | Exception |
| AC-08 | Antrean yang berstatus **Selesai** mencatat waktu penyelesaian pelayanan oleh dokter/petugas dan dikeluarkan dari daftar antrean aktif poliklinik. | Completeness |
| AC-09 | Perubahan status antrean menjadi **Selesai** pada suatu *service context* tidak mengubah status *Visit* pasien menjadi selesai / tutup secara keseluruhan. | Constraint |
| AC-10 | Antrean yang telah berstatus **Selesai** atau telah diakhiri (terminal) ditolak ketika dicoba untuk dipanggil atau diaktifkan kembali. | Constraint |
| AC-11 | Pembatalan kunjungan (*Visit*) pada boundary Admission secara otomatis membatalkan seluruh antrean poliklinik terkait yang belum selesai. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Registrasi Kunjungan & Pembentukan Visit:** Pencatatan kunjungan rawat jalan dan penerbitan nomor registrasi kunjungan induk → **OC-01-02 Registrasi Rawat Jalan dan IGD** (`ADM-REG`).
- **Penerbitan Antrian Loket Registrasi:** Pengelolaan nomor antrean loket fisik pendaftaran di Admission → **OC-01-07 Antrian** (`ADM-ANTRIAN`).
- **Keputusan & Pembentukan Rujukan Internal:** Evaluasi klinis dan pembentukan *service context* baru untuk poliklinik/dokter tujuan berikutnya dalam *Visit* yang sama → **OC-05-03 Rujuk Internal** (`RJL-TRANSFER`).
- **Pelayanan Klinis & Konsultasi Medis:** Pelaksanaan konsultasi dokter, pencatatan tindakan medis, dan asuhan keperawatan di ruang periksa → **OC-05-02 Tindakan** (`RJL-TINDAKAN`, `RJL-KONSUL`).
- **Pengelolaan Jadwal Praktik Dokter:** Penyusunan dan penutupan jadwal praktik dokter serta kuota layanan → **OC-01-06 Jadwal Praktek** (`ORG-JADWAL`).
- **Booking / Reservasi Kunjungan:** Penjadwalan janji temu pasien sebelum hari pelayanan → **OC-01-01 Booking** (`ADM-BOOKING`).
- **Antrean Layanan Penunjang:** Pengelolaan antrean farmasi/apotek (`OC-11-01 Antrian Apotek`), laboratorium (`LAB-ORDER`), atau radiologi (`RAD-ORDER`).
- **Penyelesaian Administratif Kunjungan (Reg-Out):** Penutupan episode kunjungan pasien secara menyeluruh dan finalisasi administrasi kepulangan → **OC-02-04 Reg-Out** (`TRK-BILLING`, `ADM-REG`).
- **Infrastruktur Fisik & Hardware Display:** Spesifikasi monitor display ruang tunggu, mesin pencetak nomor antrean fisik, speaker audio pemanggil suara → implementasi teknis & infrastruktur perangkat keras.

---

## 11. Open Business Questions / Perbandingan dengan OC-01-07

> Bagian ini mencatat perbandingan dengan baseline existing `OC-01-07` serta poin-poin yang memerlukan konfirmasi bisnis lebih lanjut.

### 11.1 Perbandingan dengan Baseline OC-01-07

| Aspek | Baseline `OC-01-07 Antrian` (Admission) | Definisi `OC-05-01 Antrian Rawat Jalan` | Catatan Penyelarasan |
|---|---|---|---|
| **Cakupan Outcome** | Menggabungkan Antrian Registrasi Loket dan Antrian Poli dalam satu outcome di bawah Admission (`SC-01`). | Dikhususkan untuk Antrian Poliklinik Rawat Jalan di bawah Rawat Jalan (`SC-05`). | `OC-05-01` memfokuskan tata kelola antrean pada fase pelayanan klinis poli. |
| **Relasi Visit & Queue** | Menyebutkan "satu kunjungan hanya boleh memiliki satu entri antrian poli aktif di poliklinik dan dokter yang sama". | Menegaskan model konseptual: **1 Visit dapat memiliki N Queue** (berbeda *service context*). Tidak menerapkan "1 Visit = 1 Queue". | Menghilangkan kerancuan bahwa 1 Visit hanya boleh punya 1 antrean. |
| **Queue Number vs Calling Order** | Belum secara eksplisit membedakan nomor identitas antrean dan urutan pemanggilan fisik. | Secara tegas membedakan: *Queue number* adalah identitas/posisi antrean tetap; *Calling order* dinamis dan dapat diatur (*skip/recall*). | Menjaga integritas data nomor antrean saat terjadi penyesuaian operasional di lapangan. |
| **Penyelesaian Antrean** | Mengindikasikan antrean selesai saat dokter/perawat menyelesaikan kunjungan. | Mengklarifikasi bahwa *Queue Selesai* hanya menyelesaikan *service context* terkait, bukan menyelesaikan *Visit*. | Konsisten dengan *patient journey* multi-poli / rujukan internal. |

### 11.2 Open Business Questions untuk Konfirmasi

1. **Nomenklatur Status Terminal Pasien Tidak Hadir:**
   - Pada saat pasien tidak hadir setelah pemanggilan ulang (*recall*), proses bisnis menetapkan kondisi ini sebagai "tidak melanjutkan pemeriksaan dan dikembalikan ke boundary Admission".
   - *Pertanyaan Bisnis:* Apakah nama status bisnis resmi pada record antrean rawat jalan adalah `Tidak Hadir`, `Batal Pelayanan Poli`, atau `Dikembalikan ke Admission`?
2. **Penyelarasan Batas OC-01-07:**
   - Karena `OC-05-01` kini secara mandiri dan komprehensif mengelola Antrian Poli Rawat Jalan, apakah `OC-01-07` di `SC-01 Admisi` akan disesuaikan menjadi murni `Antrian Registrasi Loket` untuk menghindari redundansi definisi antrean poli?
3. **Mekanisme Notifikasi Pengembalian ke Admission:**
   - Ketika antrean poli diakhiri karena pasien tidak hadir dan dikembalikan ke boundary Admission, apakah sistem rawat jalan langsung menerbitkan event status ke `ADM-TRACKER` (Patient Journey Tracking) atau memerlukan konfirmasi manual dari petugas loket pendaftaran / kasir?
