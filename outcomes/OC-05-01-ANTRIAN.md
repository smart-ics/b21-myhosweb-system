# OUTCOME: Antrian Rawat Jalan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-01     |
| Version     | 1.4          |
| Status      | Review       |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Pengelolaan antrean pasien di poliklinik rawat jalan adalah mekanisme operasional untuk menempatkan, memanggil, dan mengelola status pasien sepanjang lifecycle antrean dalam suatu *service context* pelayanan rawat jalan secara teratur, tertib, dan transparan.

Antrean (*Queue*) merupakan instrumen pengaturan alur pelayanan pada suatu *service context* dan secara tegas dibedakan dari Kunjungan (*Visit*). Nomor antrean (*queue number*) mencerminkan identitas posisi antrean pasien pada *service context* terkait dan bukan merupakan identitas dari *Visit*.

Adanya tata kelola antrean rawat jalan yang terstandardisasi sebagai *persisted business fact* memastikan urutan pemanggilan pasien dapat dikendalikan secara transparan, penyesuaian pemanggilan (seperti pasien dilewati atau dipanggil ulang) tercatat secara akurat, serta kepastian penyelesaian pelayanan pada setiap unit poliklinik dapat dibuktikan.

> **Definisi — Service Context:** Kombinasi unik antara poliklinik tujuan, dokter pemeriksa, dan tanggal pelayanan yang membentuk satu titik layanan klinis. Satu *Visit* dapat melewati lebih dari satu *service context* apabila pasien mendapatkan pelayanan di beberapa poliklinik atau dokter dalam satu episode kunjungan yang sama.

---

## 2. Outcome Statement

Antrean pasien pada suatu *service context* poliklinik rawat jalan **telah terbentuk sebagai fakta bisnis yang terpersistensi, mencatat posisi dan rekam jejak pemanggilan pasien, dan dinyatakan selesai ketika pelayanan pada *service context* tersebut telah dituntaskan atau diakhiri secara sah**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Jalan | **Pemilik utama outcome**: mengelola antrean pasien di poliklinik, mengendalikan proses pemanggilan (*calling order*), memperbarui status antrean sepanjang lifecycle pelayanan rawat jalan, dan mencatat penyelesaian antrean. |
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
- Nomor antrean (*queue number*) diterbitkan oleh Admission sebagai identitas posisi antrean pelayanan rawat jalan di poliklinik.
- Urutan pemanggilan (*calling order*) dapat disesuaikan secara operasional (*skip*, *recall*, prioritas) tanpa mengubah nomor antrean asli.
- Status antrean merepresentasikan tahapan operasional aktif (**Menunggu → Dipanggil → Dalam Pelayanan → Selesai**), atau status terminal alternatif (**Tidak Hadir** atau **Dibatalkan**).
- Satu *Visit* dapat memiliki lebih dari satu antrean apabila pasien menerima pelayanan pada *service context* yang berbeda. Namun, dalam *service context* yang identik (poliklinik, dokter, dan tanggal sama), satu *Visit* hanya boleh memiliki satu antrean aktif.
- Penyelesaian antrean (*Queue Selesai*) menandai berakhirnya pelayanan pada *service context* lokal tersebut, bukan menutup *Visit* pasien.

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
- Status antrean saat ini: **Menunggu**, **Dipanggil**, **Dalam Pelayanan**, **Selesai**, **Tidak Hadir**, atau **Dibatalkan**.

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
- Penyesuaian urutan pemanggilan (*calling order*) hanya dapat dilakukan oleh petugas poliklinik yang berwenang, serta wajib mencatat audit trail (petugas, waktu, alasan).
- Penanganan ketidakhadiran pasien saat dipanggil:
  1. Pasien yang tidak merespons panggilan dapat dilewati (*skip*);
  2. Pasien yang dilewati dapat dipanggil kembali (*recall*) sesuai diskresi operasional poliklinik;
  3. Jika pasien tetap tidak hadir setelah dipanggil kembali, status antrean ditetapkan menjadi **Tidak Hadir** dan memicu pengalihan kendali ke domain Admission.
- Antrean yang telah mencapai status terminal (**Selesai**, **Tidak Hadir**, **Dibatalkan**) tidak dapat dipanggil kembali atau diaktifkan ulang.

### 5.4 Completion Proof

- Antrean tercatat dengan status **Selesai**, disertai catatan waktu penyelesaian pelayanan oleh dokter/petugas poliklinik; ATAU
- Antrean tercatat dengan status **Tidak Hadir** setelah upaya pemanggilan ulang tidak dipenuhi pasien; ATAU
- Antrean tercatat dengan status **Dibatalkan** akibat pembatalan administratif oleh Admission.
- Rekam jejak waktu pemanggilan, waktu mulai pelayanan, dan waktu selesai terdokumentasi secara lengkap dan dapat diaudit.
- Pasien tidak lagi berstatus antre aktif pada daftar antrean poliklinik tersebut untuk hari yang bersangkutan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika nomor antrean untuk suatu *service context* rawat jalan telah diterbitkan oleh Admission (`OC-01-02` / `OC-01-07`) dan antrean tersebut tercatat dalam status **Menunggu** di poliklinik tujuan, siap untuk dikelola dan dipanggil oleh petugas atau dokter rawat jalan.

### End

Berakhir ketika salah satu dari tiga kondisi terpenuhi:
1. Status antrean berubah menjadi **Selesai**, yaitu saat dokter atau perawat di poliklinik menandai bahwa pelayanan klinis untuk antrean pada *service context* tersebut telah diselesaikan; ATAU
2. Status antrean berubah menjadi **Tidak Hadir**, yaitu setelah pasien tidak memenuhi pemanggilan kembali (*recall*) — kondisi ini memicu *boundary event* pengembalian kendali pasien ke domain Admission; ATAU
3. Status antrean berubah menjadi **Dibatalkan**, yaitu ketika Admission membatalkan *Visit* terkait sebelum antrean dilayani.

> **Batasan Penting:** Berakhirnya antrean pada suatu *service context* **TIDAK** mengakhiri Kunjungan (*Visit*) pasien. Kunjungan tetap berada di bawah domain Admission dan dapat memiliki *service context* / antrean lain dalam episode pelayanan yang sama.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Pemisahan Konseptual Visit dan Queue:** *Queue* bukan *Visit*. *Queue* adalah instrumen tata kelola pemanggilan pasien pada *service context* tertentu.
- **Kardinalitas Service Context:** Satu *Visit* dapat memiliki beberapa *Queue* pada *service context* yang berbeda. Namun, untuk *service context* yang identik (poliklinik, dokter, dan tanggal sama), satu *Visit* hanya boleh memiliki maksimal satu antrean aktif.
- **Keunikan Nomor Antrean:** Dalam *service context* yang sama (poliklinik, dokter, tanggal), nomor antrean (*queue number*) bersifat unik dan tidak boleh ada dua antrean aktif ber-nomor antrean sama.
- **Pemisahan Queue Number vs Calling Order:** *Queue number* bersifat imutabel sebagai identitas posisi antrean pelayanan di poliklinik; *calling order* bersifat operasional dan dinamis. Tindakan *skip* atau *recall* dilarang mengubah *queue number* asli.
- **Imutabilitas Status Terminal:** Antrean berstatus **Selesai**, **Tidak Hadir**, atau **Dibatalkan** bersifat final dan tidak dapat diaktifkan kembali.
- **Batas Kewenangan Domain:** Domain Rawat Jalan mengelola lifecycle antrean poliklinik, tetapi tidak berwenang menerbitkan nomor antrean kunjungan awal (kewenangan Admission) atau membuat rujukan internal baru (kewenangan `OC-05-03`).

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or encounters an exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak merespons saat nomor antrean dipanggil pertama kali | Antrean ditandai dilewati (*skip*). Petugas dapat melanjutkan pemanggilan antrean berikutnya tanpa membatalkan antrean pasien. Nomor antrean pasien tetap dipertahankan. |
| Pasien tetap tidak hadir setelah dilakukan pemanggilan kembali (*recall*) | Status antrean ditetapkan menjadi **Tidak Hadir**. Antrean keluar dari daftar aktif dan domain Admission menerima *boundary event* untuk menindaklanjuti kondisi pasien. |
| Referensi *Visit* pasien telah dibatalkan di loket pendaftaran sebelum dipanggil | Status antrean ditetapkan menjadi **Dibatalkan**. Antrean tidak dapat diproses lebih lanjut dan dikeluarkan dari daftar antrean aktif poliklinik. |
| Dokter pemeriksa berhalangan hadir atau sesi praktik dihentikan mendadak saat antrean masih berstatus Menunggu | Antrean tetap dalam status **Menunggu** selama diupayakan pengalihan ke dokter pengganti pada hari yang sama. Jika pengalihan tidak dapat dilakukan, status antrean ditetapkan menjadi **Dibatalkan** sesuai koordinasi dengan Admission. |
| Duplikasi antrean untuk *Visit* yang sama pada poliklinik, dokter, dan tanggal yang sama | Sistem menolak pembentukan antrean aktif kedua. Antrean aktif yang sudah ada tetap dipertahankan dan ditampilkan kepada petugas. |
| Percobaan pemanggilan pada antrean yang sudah berstatus **Selesai** atau diakhiri | Sistem menolak pemanggilan. Antrean yang sudah mencapai status terminal tidak dapat dipanggil kembali. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------| 
| AC-01 | Setiap antrean rawat jalan tercatat dengan konteks lengkap: nomor antrean, referensi *Visit* aktif, poliklinik tujuan, dokter pemeriksa, tanggal pelayanan, dan status antrean. | Completeness |
| AC-02 | Status antrean bertransisi mengikuti urutan siklus hidup yang sah: **Menunggu → Dipanggil → Dalam Pelayanan → Selesai**, atau berakhir pada status terminal **Tidak Hadir** maupun **Dibatalkan** sesuai skenario operasional dan administratif yang berlaku. | Correctness |
| AC-03 | Satu *Visit* dapat terhubung ke lebih dari satu antrean rawat jalan pada poliklinik atau dokter yang berbeda, memvalidasi bahwa sistem tidak membatasi 1 Visit = 1 Queue. | Constraint |
| AC-04 | Dalam satu poliklinik, dokter, dan tanggal pelayanan yang sama, nomor antrean bersifat unik dan tidak terdapat dua antrean aktif untuk nomor antrean yang sama. | Constraint |
| AC-05 | Penyesuaian urutan pemanggilan (*skip* atau *recall*) tidak mengubah nomor antrean (*queue number*) yang telah diterbitkan untuk pasien, dan setiap penyesuaian tercatat bersama identitas petugas yang melakukannya. | Correctness |
| AC-06 | Pasien yang tidak hadir saat dipanggil dapat dilewati (*skip*), dan antrean pasien berikutnya dapat dipanggil tanpa membatalkan antrean pasien yang dilewati. | Exception |
| AC-07 | Pasien yang tetap tidak hadir setelah pemanggilan kembali (*recall*) diubah statusnya menjadi **Tidak Hadir** dan domain Admission menerima *boundary event* untuk menindaklanjuti kondisi pasien. | Exception |
| AC-08 | Antrean yang berstatus **Selesai** mencatat waktu penyelesaian pelayanan oleh dokter/petugas dan dikeluarkan dari daftar antrean aktif poliklinik. | Completeness |
| AC-09 | Perubahan status antrean menjadi **Selesai** pada suatu *service context* tidak mengubah status *Visit* pasien menjadi selesai / tutup secara keseluruhan. | Constraint |
| AC-10 | Antrean yang telah berstatus **Selesai**, **Tidak Hadir**, atau **Dibatalkan** ditolak ketika dicoba untuk dipanggil atau diaktifkan kembali. | Constraint |
| AC-11 | Pembatalan kunjungan (*Visit*) pada domain Admission secara otomatis mengubah status antrean poliklinik terkait yang belum dilayani menjadi **Dibatalkan**. | Exception |

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

## 11. Perbandingan Baseline & Cross-Outcome Dependencies

> **Catatan Penyelarasan:** Section ini merupakan suplemen dokumentasi penyesuaian baseline dan tidak memengaruhi definisi spesifikasi inti Outcome.

### 11.1 Perbandingan dengan Baseline OC-01-07

| Aspek | Baseline `OC-01-07 Antrian` (Admission) | Definisi `OC-05-01 Antrian Rawat Jalan` | Catatan Penyelarasan |
|---|---|---|---|
| **Cakupan Outcome** | Menggabungkan Antrian Registrasi Loket dan Antrian Poli dalam satu outcome di bawah Admission (`SC-01`). | Dikhususkan untuk Antrian Poliklinik Rawat Jalan di bawah Rawat Jalan (`SC-05`). | `OC-05-01` memfokuskan tata kelola antrean pada fase pelayanan klinis poli. |
| **Relasi Visit & Queue** | Menyebutkan "satu kunjungan hanya boleh memiliki satu entri antrian poli aktif di poliklinik dan dokter yang sama". | Menegaskan model konseptual: **1 Visit dapat memiliki N Queue** (berbeda *service context*). Tidak menerapkan "1 Visit = 1 Queue". | Menghilangkan kerancuan bahwa 1 Visit hanya boleh punya 1 antrean. |
| **Queue Number vs Calling Order** | Belum secara eksplisit membedakan nomor identitas antrean dan urutan pemanggilan fisik. | Secara tegas membedakan: *Queue number* adalah identitas/posisi antrean tetap; *Calling order* dinamis dan dapat diatur (*skip/recall*). | Menjaga integritas data nomor antrean saat terjadi penyesuaian operasional di lapangan. |
| **Penyelesaian Antrean** | Mengindikasikan antrean selesai saat dokter/perawat menyelesaikan kunjungan. | Mengklarifikasi bahwa *Queue Selesai* hanya menyelesaikan *service context* terkait, bukan menyelesaikan *Visit*. | Konsisten dengan *patient journey* multi-poli / rujukan internal. |

### 11.2 Cross-Outcome Dependencies & Follow-Up

Poin berikut bukan merupakan open question yang memblokir OC-05-01, melainkan tindak lanjut lintas-outcome yang perlu diselesaikan secara terpisah:

| # | Item | Outcome/Artefak Terkait | Tindak Lanjut |
|---|------|--------------------------|---------------|
| D-01 | **Penyelarasan Cakupan OC-01-07** — `OC-01-07` berpotensi redundan karena kini mendefinisikan antrian poli yang sudah dicakup `OC-05-01`. Perlu konfirmasi apakah `OC-01-07` difokuskan hanya pada Antrian Registrasi Loket. | `OC-01-07` (Admission SC-01) | Review `OC-01-07` pada sesi Admission domain; tidak memblokir `OC-05-01`. |
| D-02 | **Mekanisme Boundary Event ke ADM-TRACKER** — Ketika status antrean menjadi **Tidak Hadir**, apakah sistem rawat jalan menerbitkan event langsung ke `ADM-TRACKER` atau memerlukan konfirmasi manual dari petugas loket? | `ADM-TRACKER` (Patient Journey Tracking) | Definisikan dalam spesifikasi integrasi `ADM-TRACKER`; tidak memblokir lifecycle antrean `OC-05-01`. |

