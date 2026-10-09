# OUTCOME: Jadwal Praktek

| Field       | Value        |
|-------------|--------------|
| Code        | OC-ORG-JADWAL-PRAKTEK     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu mendefinisikan dan memelihara jadwal praktek dokter di poliklinik rawat jalan sebagai persisted business fact yang menjadi dasar operasional pelayanan rawat jalan.

Jadwal Praktek memastikan bahwa ketersediaan dokter di suatu poliklinik pada hari, sesi, dan slot waktu tertentu — beserta kuota pasien yang ditentukan — tercatat secara resmi dalam sistem dan dapat digunakan oleh proses Booking, Registrasi Rawat Jalan, dan Antrian sebagai referensi yang dapat diandalkan.

Tanpa Jadwal Praktek yang tersimpan dalam sistem, proses booking tidak dapat memverifikasi ketersediaan dokter, registrasi tidak dapat mengalokasikan pasien ke sesi praktek yang benar, dan pengelolaan kapasitas poliklinik tidak dapat dilakukan secara sistematis.

---

## 2. Outcome Statement

Jadwal praktek dokter di poliklinik rawat jalan pada periode berlaku tertentu **telah tercatat sebagai fact ketersediaan layanan dokter yang valid, aktif, dan dapat digunakan sebagai referensi oleh proses Booking, Registrasi Rawat Jalan, dan Antrian**.

---

## 3. Participating Domains

| Domain     | Role in this Outcome                                                                                                 |
|------------|----------------------------------------------------------------------------------------------------------------------|
| Organisasi | Pemilik utama: mendefinisikan dan mengelola jadwal praktek dokter di poliklinik sebagai persisted fact (`ORG-JADWAL`) |
| Organisasi | Menyediakan identitas dokter (PPA) yang dijadwalkan (`ORG-PPA`)                                                      |
| Organisasi | Menyediakan unit layanan / poliklinik tempat praktek berlangsung (`ORG-LAYANAN`)                                     |

---

## 4. Participating Capabilities

| Capability                              | Domain     | Status |
|-----------------------------------------|------------|--------|
| `ORG-JADWAL` Jadwal Praktek Dokter      | Organisasi | Known  |
| `ORG-PPA` Petugas Pemberi Asuhan        | Organisasi | Known  |
| `ORG-LAYANAN` Unit Layanan              | Organisasi | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Jadwal praktek dokter telah tercatat dan dikaitkan dengan dokter yang valid dan aktif dalam sistem.
- Jadwal praktek merujuk pada poliklinik (unit layanan) yang valid dan aktif dalam sistem.
- Jadwal praktek mendefinisikan hari dan/atau tanggal berlaku, sesi waktu, serta kuota pasien per sesi.
- Jadwal praktek memiliki status yang dapat dibedakan: **Aktif**, **Tidak Aktif**, atau **Libur / Ditutup Sementara**.
- Jadwal praktek yang berstatus **Aktif** tersedia sebagai referensi bagi proses Booking, Registrasi Rawat Jalan, dan Antrian.

### 5.2 Required Recorded Information

**Informasi identitas jadwal:**

- Dokter (PPA) yang dijadwalkan.
- Poliklinik (unit layanan) tempat dokter berpraktek.
- Periode berlaku jadwal (tanggal mulai dan tanggal berakhir, atau pola berulang mingguan).

**Informasi sesi praktek:**

- Hari praktek (untuk jadwal berulang mingguan) atau tanggal spesifik (untuk jadwal satu kali / tanggal tertentu).
- Sesi waktu praktek: misalnya Pagi, Siang, Sore — beserta jam mulai dan jam berakhir yang ditetapkan.
- Kuota pasien per sesi: jumlah maksimum pasien yang dapat dilayani dalam satu sesi.

**Informasi status:**

- Status jadwal: Aktif / Tidak Aktif / Libur / Ditutup Sementara.
- Keterangan atau alasan perubahan status (jika berlaku, misalnya dokter cuti atau hari libur nasional).
- Petugas dan waktu pencatatan / pembaruan jadwal.

### 5.3 Required Business Conditions

- Dokter yang dijadwalkan harus merupakan PPA yang valid dan aktif dalam sistem (`ORG-PPA`).
- Poliklinik yang menjadi tempat praktek harus merupakan unit layanan yang valid dan aktif dalam sistem (`ORG-LAYANAN`).
- Satu sesi jadwal tidak boleh mendefinisikan kuota pasien yang melebihi kapasitas operasional poliklinik yang berlaku.
- Tidak boleh ada dua entri jadwal yang aktif untuk dokter yang sama, di poliklinik yang sama, pada hari / tanggal dan sesi yang sama secara bersamaan.
- Jadwal yang berstatus Tidak Aktif tidak dapat dijadikan referensi untuk Booking atau Registrasi baru.

### 5.4 Completion Proof

- Jadwal praktek dapat ditemukan dan ditampilkan berdasarkan dokter, poliklinik, hari/tanggal, dan sesi.
- Status jadwal mencerminkan keadaan aktual ketersediaan dokter pada sesi tersebut.
- Kuota pasien per sesi tercatat dan dapat digunakan untuk memvalidasi permintaan Booking maupun Registrasi baru.
- Jadwal dengan status **Aktif** dapat dirujuk oleh proses Booking, Registrasi Rawat Jalan, dan Antrian tanpa hambatan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas administrasi atau manajemen poliklinik mendefinisikan ketersediaan dokter di suatu poliklinik pada hari/tanggal dan sesi tertentu dengan menetapkan informasi dokter, poliklinik, sesi waktu, kuota, dan periode berlaku — lalu menyimpannya dalam sistem sebagai jadwal praktek.

### End

Berakhir ketika jadwal praktek telah tersimpan dalam sistem dengan status **Aktif** dan siap dirujuk oleh proses Booking, Registrasi Rawat Jalan, dan Antrian.

> Outcome ini bersifat persisten dan dapat diperbarui: perubahan kuota, penangguhan sementara, atau penutupan jadwal merupakan pembaruan terhadap Outcome yang sama. Jadwal yang dinonaktifkan secara permanen mencapai status terminal **Tidak Aktif**.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Jadwal praktek hanya dapat didefinisikan untuk dokter yang telah terdaftar dan aktif dalam sistem (`ORG-PPA`). Dokter yang tidak dikenal sistem tidak dapat dijadwalkan.
- Jadwal praktek hanya dapat didefinisikan untuk poliklinik yang telah terdaftar dan aktif dalam sistem (`ORG-LAYANAN`). Poliklinik yang tidak dikenal sistem tidak dapat menjadi tempat praktek.
- Tidak boleh ada konflik jadwal aktif: satu dokter hanya boleh memiliki satu entri jadwal aktif di satu poliklinik pada hari/tanggal dan sesi yang sama.
- Kuota pasien per sesi harus bernilai positif dan tidak melebihi batas kapasitas operasional yang ditetapkan.
- Jadwal yang sedang digunakan sebagai referensi aktif oleh Booking yang belum digunakan (status Terjadwal) tidak dapat dihapus secara langsung; harus dinonaktifkan atau diubah status terlebih dahulu, dengan mekanisme yang menjaga konsistensi booking yang sudah ada.
- Jadwal dengan status **Libur / Ditutup Sementara** tidak dapat digunakan sebagai referensi Booking atau Registrasi baru untuk periode yang ditangguhkan tersebut.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                                          | Expected Behavior                                                                                                                                                |
|----------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Dokter yang akan dijadwalkan tidak ditemukan atau tidak aktif dalam sistem                         | Jadwal tidak dapat dibuat. Petugas harus memverifikasi data dokter dan memastikan dokter terdaftar aktif dalam sistem sebelum penjadwalan dapat dilanjutkan.     |
| Poliklinik yang dituju tidak ditemukan atau tidak aktif dalam sistem                               | Jadwal tidak dapat dibuat. Petugas harus memilih poliklinik yang valid dan aktif.                                                                                |
| Terdapat konflik jadwal aktif untuk dokter yang sama di poliklinik yang sama pada hari/sesi yang sama | Jadwal baru ditolak. Sistem menginformasikan adanya konflik dan meminta petugas untuk menyelesaikan konflik sebelum jadwal baru dapat disimpan.              |
| Kuota pasien yang dimasukkan bernilai nol atau negatif                                             | Jadwal tidak dapat disimpan. Sistem menolak nilai kuota yang tidak valid dan meminta petugas untuk memasukkan kuota yang bernilai positif.                        |
| Periode berlaku jadwal tidak valid (tanggal berakhir lebih awal dari tanggal mulai)                | Jadwal tidak dapat disimpan. Sistem menolak definisi periode yang tidak konsisten dan meminta koreksi.                                                           |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                   | Validates    |
|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Jadwal praktek yang tersimpan dapat ditemukan berdasarkan dokter, poliklinik, hari/tanggal, dan sesi.                                                                       | Completeness |
| AC-02 | Jadwal yang tersimpan mencatat dokter, poliklinik, hari/tanggal praktek, sesi waktu (jam mulai dan jam berakhir), kuota per sesi, dan periode berlaku secara lengkap.       | Correctness  |
| AC-03 | Status jadwal yang aktif adalah **Aktif** dan dapat dirujuk oleh proses Booking dan Registrasi Rawat Jalan.                                                                 | Completeness |
| AC-04 | Kuota pasien per sesi yang tercatat mencerminkan nilai yang ditetapkan oleh petugas dan bernilai positif.                                                                   | Correctness  |
| AC-05 | Tidak terdapat dua entri jadwal aktif untuk dokter yang sama di poliklinik yang sama pada hari/tanggal dan sesi yang sama secara bersamaan.                                 | Constraint   |
| AC-06 | Jadwal dengan status **Tidak Aktif** atau **Libur / Ditutup Sementara** tidak dapat digunakan sebagai referensi Booking atau Registrasi baru pada periode yang bersangkutan. | Constraint   |
| AC-07 | Jadwal tidak dapat dibuat untuk dokter yang tidak dikenal atau tidak aktif dalam sistem.                                                                                    | Constraint   |
| AC-08 | Jadwal tidak dapat dibuat untuk poliklinik yang tidak dikenal atau tidak aktif dalam sistem.                                                                                | Constraint   |
| AC-09 | Sistem menolak penyimpanan jadwal apabila terdapat konflik jadwal aktif yang sudah ada untuk dokter, poliklinik, hari/sesi yang sama.                                       | Exception    |
| AC-10 | Sistem menolak penyimpanan jadwal dengan kuota nol, negatif, atau periode berlaku yang tidak valid.                                                                         | Exception    |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pencatatan appointment / booking pasien berdasarkan jadwal ini → **OC-ADM-BOOKING Booking**.
- Proses registrasi kunjungan rawat jalan yang merujuk jadwal ini → **OC-ADM-REGISTRASI Registrasi** (Unified REGISTRASI Outcome).
- Pengelolaan antrian pasien di poliklinik pada hari pelayanan → **OC-ADM-ANTRIAN Antrian**.
- Pengelolaan master data dokter (PPA) — termasuk identitas, spesialisasi, dan kompetensi → Organisasi Domain (`ORG-PPA`).
- Pengelolaan master unit layanan dan poliklinik → Organisasi Domain (`ORG-LAYANAN`).
- Penjadwalan tindakan operasi atau prosedur invasif → Kamar Operasi Domain.
- Penjadwalan pemeriksaan radiologi → Radiologi Domain (`RAD-SCHEDULING`).
- Manajemen cuti atau absensi dokter di luar sistem jadwal praktek — keputusan operasional ini tecermin sebagai perubahan status jadwal, bukan sebagai absensi yang dikelola sistem ini.
- Pelaporan kinerja dokter atau utilisasi poliklinik → domain pelaporan terkait.
