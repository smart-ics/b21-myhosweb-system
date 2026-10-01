# OUTCOME: Booking

| Field       | Value        |
|-------------|--------------|
| Code        | OC-01-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu menerima dan mencatat janji temu (appointment) pasien untuk pelayanan rawat jalan sebelum hari kunjungan.

Booking memungkinkan pasien untuk merencanakan kunjungan, memastikan ketersediaan jadwal dokter, dan memberikan kepastian layanan kepada pasien sebelum tiba di rumah sakit.

Tanpa Booking yang tercatat, proses registrasi kunjungan tidak dapat memanfaatkan data appointment yang sudah ada, dan manajemen kapasitas poliklinik tidak dapat dilakukan dengan efektif.

---

## 2. Outcome Statement

Appointment pasien dengan dokter dan poliklinik tujuan pada tanggal dan sesi tertentu **telah tercatat dan siap digunakan sebagai dasar registrasi kunjungan**.

---

## 3. Participating Domains

| Domain      | Role in this Outcome                                                                 |
|-------------|--------------------------------------------------------------------------------------|
| Admission   | Pemilik utama: mencatat dan mengelola booking sebagai persisted business fact        |
| Pasien      | Menyediakan identitas pasien yang menjadi subjek booking                             |
| Organisasi  | Menyediakan data dokter, poliklinik, dan jadwal praktek yang menjadi target booking  |

---

## 4. Participating Capabilities

| Capability            | Domain      | Status |
|-----------------------|-------------|--------|
| `ADM-BOOKING` Booking | Admission   | Known  |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-JADWAL` Jadwal Praktek Dokter | Organisasi | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known  |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Booking atas nama pasien yang teridentifikasi telah tercatat dalam sistem.
- Booking merujuk pada dokter dan poliklinik tujuan yang valid.
- Booking merujuk pada jadwal praktek dokter yang aktif pada tanggal dan sesi yang dipilih.
- Booking memiliki status yang dapat dibedakan: **Terjadwal**, **Dibatalkan**, atau **Sudah Digunakan**.

### 5.2 Required Recorded Information

- Identitas pasien (Nomor Rekam Medis atau identitas yang dapat digunakan untuk menemukan atau mendaftarkan pasien).
- Dokter tujuan.
- Poliklinik tujuan.
- Tanggal booking.
- Sesi praktek (pagi / siang / sore atau slot waktu sesuai jadwal dokter).
- Nomor urut atau slot booking dalam sesi tersebut.
- Status booking pada saat pencatatan.
- Sumber booking (datang langsung, telepon, atau kanal lain yang digunakan).
- Waktu pencatatan booking.
- Petugas yang mencatat booking (jika berlaku).

### 5.3 Required Business Conditions

- Pasien yang menjadi subjek booking harus dapat diidentifikasi (sudah terdaftar sebagai pasien, atau dapat didaftarkan melalui proses pendaftaran pasien baru).
- Jadwal praktek dokter pada tanggal dan sesi yang dipilih harus aktif dan tersedia.
- Slot atau kuota booking pada sesi tersebut harus masih tersedia.
- Satu booking hanya boleh merujuk pada satu dokter dan satu poliklinik untuk satu tanggal dan satu sesi.

### 5.4 Completion Proof

- Booking tercatat dalam sistem dengan nomor atau referensi booking yang unik.
- Status booking adalah **Terjadwal**.
- Booking dapat ditemukan berdasarkan identitas pasien, dokter, tanggal, dan sesi.
- Booking dapat digunakan sebagai dasar proses registrasi kunjungan rawat jalan pada hari kunjungan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika ada permintaan booking dari pasien atau atas nama pasien, yaitu saat informasi pasien, dokter tujuan, dan tanggal serta sesi yang diinginkan telah dinyatakan.

### End

Berakhir ketika booking telah berhasil tercatat dalam sistem dengan status **Terjadwal** dan referensi booking yang unik telah diterbitkan.

Outcome ini juga dianggap selesai (dengan status terminal) ketika booking dibatalkan (**Dibatalkan**) atau sudah digunakan sebagai dasar registrasi (**Sudah Digunakan**).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Pasien harus dapat diidentifikasi sebelum booking dapat dicatat. Booking tidak boleh dibuat tanpa identitas pasien yang dapat diverifikasi atau didaftarkan.
- Booking hanya dapat dibuat terhadap jadwal praktek dokter yang aktif dan tersedia pada tanggal dan sesi yang diminta.
- Slot atau kuota dalam satu sesi praktek bersifat terbatas; booking baru tidak boleh melebihi kuota yang tersedia.
- Satu pasien tidak boleh memiliki lebih dari satu booking aktif (**Terjadwal**) untuk dokter yang sama pada tanggal dan sesi yang sama.
- Booking yang sudah berstatus **Sudah Digunakan** tidak dapat dibatalkan atau dimodifikasi.
- Pembatalan booking hanya dapat dilakukan selama booking masih berstatus **Terjadwal**.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                   | Expected Behavior                                                                                       |
|-------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| Pasien tidak dapat diidentifikasi                           | Booking ditolak. Identitas pasien harus diselesaikan terlebih dahulu sebelum booking dapat dilanjutkan. |
| Jadwal praktek dokter tidak aktif pada tanggal yang diminta | Booking ditolak. Informasikan bahwa dokter tidak praktek pada tanggal dan sesi tersebut.                |
| Kuota booking pada sesi tersebut sudah penuh                | Booking ditolak. Informasikan bahwa slot tidak tersedia dan tawarkan alternatif tanggal atau sesi lain.  |
| Pasien sudah memiliki booking aktif untuk dokter dan sesi yang sama | Booking ditolak. Informasikan bahwa booking sebelumnya masih aktif.                            |
| Data dokter atau poliklinik tujuan tidak valid              | Booking ditolak. Informasikan bahwa referensi dokter atau poliklinik tidak dapat ditemukan.             |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                 | Validates    |
|-------|-------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Booking yang tercatat memiliki nomor referensi unik yang dapat digunakan untuk menemukan booking tersebut.                                | Completeness |
| AC-02 | Booking yang tercatat merujuk pada pasien, dokter, poliklinik, tanggal, dan sesi yang sesuai dengan permintaan.                           | Correctness  |
| AC-03 | Status booking setelah pencatatan adalah **Terjadwal**.                                                                                   | Completeness |
| AC-04 | Booking dapat ditemukan berdasarkan identitas pasien, dokter, tanggal, dan sesi.                                                          | Correctness  |
| AC-05 | Booking dapat digunakan sebagai dasar untuk memulai proses registrasi kunjungan rawat jalan pada hari kunjungan.                          | Correctness  |
| AC-06 | Booking tidak dapat dibuat jika kuota sesi praktek sudah penuh.                                                                           | Constraint   |
| AC-07 | Booking tidak dapat dibuat jika jadwal praktek dokter tidak aktif pada tanggal dan sesi yang diminta.                                     | Constraint   |
| AC-08 | Booking tidak dapat dibuat jika pasien sudah memiliki booking aktif untuk dokter dan sesi yang sama.                                      | Constraint   |
| AC-09 | Booking yang sudah berstatus **Sudah Digunakan** tidak dapat dibatalkan atau dimodifikasi.                                                | Constraint   |
| AC-10 | Booking yang berhasil dibatalkan berstatus **Dibatalkan** dan slot yang dibebaskan dapat digunakan oleh pasien lain.                      | Exception    |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Proses registrasi kunjungan rawat jalan yang menggunakan booking sebagai dasar → **OC-01-02 Registrasi Rawat Jalan dan IGD**.
- Pengelolaan antrian pendaftaran rawat jalan → **OC-01-07 Antrian**.
- Pengelolaan jadwal praktek dokter (pembuatan dan perubahan jadwal) → Organisasi Domain (`ORG-JADWAL`).
- Pengelolaan identitas dan data sosial pasien → Pasien Domain (`PAS-DATSOS`).
- Proses pembayaran atau deposit terkait booking → Tata Rekening Domain.
- Notifikasi atau pengingat booking kepada pasien (kanal komunikasi eksternal).
- Integrasi dengan sistem antrian eksternal BPJS (Antrol) → BPJS Domain (`BPJ-ANTROL`).
