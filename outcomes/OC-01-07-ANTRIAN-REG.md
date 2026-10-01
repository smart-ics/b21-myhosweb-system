# OUTCOME: Antrian

| Field       | Value        |
|-------------|--------------|
| Code        | OC-01-07     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu mengelola dan mencatat antrian pasien secara resmi — baik di loket pendaftaran (antrian registrasi) maupun di poliklinik tujuan (antrian pelayanan poli) — sebagai persisted business fact yang memungkinkan pelayanan pasien berlangsung secara teratur, adil, dan terukur pada hari kunjungan.

Antrian Registrasi memastikan bahwa setiap pasien yang datang ke loket pendaftaran mendapatkan nomor antrean yang terdokumentasi, sehingga proses registrasi dapat dilakukan secara berurutan dan transparan. Antrian Poli memastikan bahwa pasien yang telah terdaftar pada suatu kunjungan rawat jalan memiliki posisi antrean tercatat di poliklinik tujuan, sehingga dokter dapat memanggil pasien sesuai urutan dan beban layanan dapat dipantau.

Tanpa catatan antrian yang tersimpan dalam sistem, urutan pelayanan tidak dapat dikendalikan, waktu tunggu tidak dapat dipantau, dan kepastian pelayanan kepada pasien tidak dapat dijamin.

---

## 2. Outcome Statement

Posisi antrian pasien — baik di loket pendaftaran maupun di poliklinik tujuan — **telah tercatat sebagai fact antrean yang valid dan aktif, memungkinkan pasien dipanggil dan dilayani sesuai urutan yang telah ditetapkan**.

---

## 3. Participating Domains

| Domain     | Role in this Outcome                                                                                                   |
|------------|------------------------------------------------------------------------------------------------------------------------|
| Admission  | Pemilik utama Antrian Registrasi: mencatat dan mengelola nomor antrian di loket pendaftaran sebagai persisted fact     |
| Rawat Jalan | Co-owner Antrian Poli: mencatat dan mengelola posisi antrian pasien di poliklinik sebagai persisted fact              |
| Pasien     | Menyediakan identitas pasien yang menjadi subjek antrean                                                               |
| Organisasi | Menyediakan data unit layanan dan poliklinik sebagai konteks antrean poli                                              |

---

## 4. Participating Capabilities

| Capability                              | Domain      | Status |
|-----------------------------------------|-------------|--------|
| `ADM-ANTRIAN` Antrian Registrasi        | Admission   | Known  |
| `RJL-ANTRIAN` Antrian Poli              | Rawat Jalan | Known  |
| `ADM-REG` Registration                  | Admission   | Known  |
| `PAS-DATSOS` Data Sosial Pasien         | Pasien      | Known  |
| `ORG-LAYANAN` Unit Layanan              | Organisasi  | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Antrian Registrasi (Loket Pendaftaran):**

- Nomor antrean loket telah diterbitkan dan dikaitkan dengan identitas atau konteks pasien yang datang.
- Nomor antrean loket memiliki status yang dapat dibedakan: **Menunggu**, **Dipanggil**, atau **Selesai**.
- Urutan pemanggilan antrean mengikuti nomor urut yang telah ditetapkan.

**Antrian Poli (Poliklinik Tujuan):**

- Nomor urut antrian poli telah tercatat dan dikaitkan dengan kunjungan rawat jalan yang sudah terdaftar.
- Antrean poli merujuk pada poliklinik dan dokter tujuan yang valid.
- Antrean poli memiliki status yang dapat dibedakan: **Menunggu**, **Dipanggil**, **Dalam Pelayanan**, atau **Selesai**.
- Posisi antrean poli mencerminkan urutan pendaftaran kunjungan atau urutan yang ditetapkan oleh petugas.

### 5.2 Required Recorded Information

**Antrian Registrasi:**

- Nomor antrean loket (nomor urut) yang unik untuk hari tersebut.
- Tanggal dan waktu penerbitan nomor antrean.
- Status antrean saat ini.
- Identitas pasien (jika sudah diketahui pada saat pengambilan nomor antrean).
- Waktu pemanggilan dan waktu penyelesaian antrean (jika tersedia).

**Antrian Poli:**

- Nomor urut antrian poli yang unik untuk poliklinik, dokter, dan tanggal pelayanan tersebut.
- Referensi kunjungan rawat jalan (nomor registrasi) yang berasosiasi dengan antrean ini.
- Poliklinik dan dokter tujuan.
- Tanggal pelayanan.
- Status antrean saat ini.
- Waktu pemanggilan dan waktu penyelesaian antrean (jika tersedia).

### 5.3 Required Business Conditions

- Antrian Registrasi dapat diterbitkan kepada pasien yang datang ke loket, bahkan sebelum identitas pasien sepenuhnya terverifikasi.
- Antrian Poli hanya dapat diterbitkan setelah kunjungan rawat jalan pasien ke poliklinik yang bersangkutan telah berhasil terdaftar (`OC-01-02 Registrasi Rawat Jalan dan IGD`).
- Satu kunjungan rawat jalan hanya boleh memiliki satu entri antrian poli aktif di poliklinik dan dokter yang sama pada tanggal yang sama.
- Nomor urut antrean — baik loket maupun poli — harus bersifat unik dalam lingkup loket/poli, dokter (jika relevan), dan tanggal pelayanan.
- Status antrean harus mengikuti urutan yang valid: **Menunggu → Dipanggil → Dalam Pelayanan → Selesai** (dengan kemungkinan status **Dibatalkan** jika pasien tidak hadir atau membatalkan antrean).

### 5.4 Completion Proof

- Nomor antrean loket dapat ditemukan dan ditampilkan berdasarkan tanggal dan nomor urut.
- Nomor antrian poli dapat ditemukan dan ditampilkan berdasarkan poliklinik, dokter, tanggal, dan nomor kunjungan pasien.
- Status antrean mencerminkan kondisi aktual pelayanan pada saat itu.
- Pasien dapat dipanggil berdasarkan nomor urut antrean yang tercatat.
- Antrian poli yang berstatus **Menunggu** atau **Dipanggil** dapat digunakan sebagai dasar pemanggilan pasien oleh dokter atau perawat di poliklinik.

---

## 6. Outcome Boundary

### Start

**Antrian Registrasi:** Dimulai ketika pasien mengambil nomor antrean loket — baik melalui mesin antrean otomatis, petugas, maupun kanal lain yang tersedia — dan sistem menerbitkan serta menyimpan nomor urut antrean tersebut.

**Antrian Poli:** Dimulai ketika registrasi kunjungan rawat jalan pasien berhasil diselesaikan (`OC-01-02`) dan sistem secara otomatis atau manual menerbitkan nomor urut antrian poli untuk poliklinik dan dokter tujuan.

### End

**Antrian Registrasi:** Berakhir ketika status antrean loket pasien berubah menjadi **Selesai** — yaitu saat registrasi kunjungan pasien di loket telah diselesaikan oleh petugas — atau menjadi **Dibatalkan** jika pasien tidak hadir.

**Antrian Poli:** Berakhir ketika status antrian poli pasien berubah menjadi **Selesai** — yaitu saat dokter atau perawat menandai pelayanan untuk kunjungan tersebut selesai — atau menjadi **Dibatalkan** jika pasien tidak hadir di poliklinik.

> Outcome ini bersifat harian: setiap nomor antrean hanya berlaku untuk tanggal pelayanan yang bersangkutan dan tidak dibawa ke hari berikutnya.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Nomor urut antrean harus bersifat unik dalam konteks loket/poli, dokter (jika relevan), dan tanggal pelayanan. Tidak boleh ada dua antrean aktif dengan nomor urut yang sama dalam konteks yang sama pada hari yang sama.
- Antrian Poli hanya dapat diterbitkan untuk pasien yang memiliki kunjungan rawat jalan aktif (`Terdaftar`) di poliklinik dan dokter yang bersangkutan. Pasien tanpa registrasi kunjungan yang valid tidak dapat masuk antrian poli.
- Satu kunjungan rawat jalan hanya boleh memiliki satu entri antrian poli aktif untuk poliklinik dan dokter yang sama pada tanggal yang sama.
- Pemanggilan antrean harus mengikuti nomor urut yang telah ditetapkan. Penyimpangan (skip atau prioritas) harus tercatat sebagai tindakan eksplisit oleh petugas yang berwenang.
- Antrean yang sudah berstatus **Selesai** atau **Dibatalkan** tidak dapat diaktifkan kembali. Jika diperlukan, antrean baru harus diterbitkan.
- Antrean Poli terikat pada kunjungan rawat jalan: pembatalan kunjungan harus disertai pembatalan antrean poli yang bersangkutan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                                          | Expected Behavior                                                                                                                                                              |
|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kunjungan rawat jalan pasien tidak ditemukan atau belum terdaftar (untuk Antrian Poli)             | Antrian Poli tidak dapat diterbitkan. Pasien harus menyelesaikan proses registrasi kunjungan terlebih dahulu sebelum mendapatkan nomor antrian poli.                           |
| Kunjungan rawat jalan pasien sudah memiliki antrian poli aktif di poliklinik dan dokter yang sama  | Antrian Poli baru ditolak. Sistem menginformasikan bahwa pasien sudah memiliki nomor antrian aktif dan menampilkan nomor antrian yang sudah ada.                               |
| Poliklinik atau dokter tujuan tidak aktif atau tidak tersedia pada hari pelayanan                  | Antrian Poli tidak dapat diterbitkan untuk poliklinik/dokter tersebut. Petugas diarahkan untuk menyelesaikan permasalahan ketersediaan layanan terlebih dahulu.                |
| Pasien tidak hadir saat dipanggil (tidak merespons pemanggilan)                                    | Antrean dapat ditandai sebagai **Dilewati** (skip) dan pemanggilan dilanjutkan ke nomor berikutnya. Pasien yang dilewati dapat dipanggil kembali sesuai prosedur yang berlaku. |
| Sistem antrean tidak tersedia (gangguan teknis)                                                    | Nomor antrean tidak dapat diterbitkan secara otomatis. Pengelolaan antrean dilakukan secara manual sesuai prosedur fallback yang berlaku; catatan antrean diselesaikan setelah sistem pulih. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                  | Validates    |
|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Nomor antrean loket yang diterbitkan dapat ditemukan berdasarkan tanggal dan nomor urut.                                                                                   | Completeness |
| AC-02 | Nomor antrian poli yang diterbitkan dapat ditemukan berdasarkan poliklinik, dokter, tanggal, dan nomor kunjungan pasien.                                                   | Completeness |
| AC-03 | Setiap nomor antrian — loket maupun poli — mencatat tanggal, nomor urut, dan status antrean secara lengkap.                                                                | Correctness  |
| AC-04 | Status antrean dapat diperbarui mengikuti urutan yang valid (Menunggu → Dipanggil → Dalam Pelayanan → Selesai / Dibatalkan).                                               | Correctness  |
| AC-05 | Tidak terdapat dua antrean aktif dengan nomor urut yang sama dalam konteks poliklinik, dokter, dan tanggal yang sama.                                                      | Constraint   |
| AC-06 | Antrian Poli tidak dapat diterbitkan untuk pasien yang tidak memiliki kunjungan rawat jalan aktif (`Terdaftar`) di poliklinik dan dokter yang bersangkutan.                | Constraint   |
| AC-07 | Satu kunjungan rawat jalan hanya memiliki satu entri antrian poli aktif untuk poliklinik dan dokter yang sama pada tanggal yang sama.                                      | Constraint   |
| AC-08 | Antrian poli yang sudah berstatus **Selesai** atau **Dibatalkan** tidak dapat diaktifkan kembali.                                                                          | Constraint   |
| AC-09 | Sistem menolak penerbitan antrian poli baru jika kunjungan pasien sudah memiliki antrian poli aktif di poliklinik dan dokter yang sama pada hari yang sama.                | Exception    |
| AC-10 | Daftar antrean poli untuk suatu poliklinik dan dokter pada hari tertentu dapat ditampilkan secara berurutan berdasarkan nomor urut antrean.                                | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Registrasi kunjungan rawat jalan pasien yang menghasilkan nomor antrian poli → **OC-01-02 Registrasi Rawat Jalan dan IGD**.
- Pengelolaan jadwal praktek dokter yang menjadi referensi kapasitas poli → **OC-01-06 Jadwal Praktek**.
- Proses booking/appointment sebelum hari kunjungan → **OC-01-01 Booking**.
- Pencatatan tindakan klinis atau pelayanan medis yang dilakukan setelah pasien dipanggil → **Rawat Jalan Domain** (`RJL-TINDAKAN`).
- Antrean farmasi / apotek → **OC-11-01 Antrian Apotek**.
- Antrean laboratorium atau radiologi → domain terkait masing-masing.
- Antrean IGD (triase dan urutan penanganan gawat darurat) → **Gawat Darurat Domain** (`IGD-TRIAGE`).
- Pelaporan kinerja antrian (waktu tunggu rata-rata, utilisasi poli) → domain pelaporan terkait.
- Desain fisik sistem mesin antrean atau tampilan display antrean → tanggung jawab teknis implementasi.
