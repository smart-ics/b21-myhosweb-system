# Admission Domain

## Purpose

Mengelola proses masuk pasien ke rumah sakit sejak booking/appointment, registrasi kunjungan, antrian pendaftaran, sampai pencatatan perjalanan pasien selama satu kunjungan.

## Definition

**Admission** adalah domain yang mengelola proses administratif pasien untuk memulai dan mencatat kunjungan pelayanan di rumah sakit.

Domain ini berfokus pada **entry dan movement pasien dalam konteks kunjungan**, bukan pada pelayanan klinis yang diberikan oleh unit pelayanan.

## Capabilities

### 1. Booking

Kemampuan untuk mengelola **booking / appointment** pasien untuk mendapatkan pelayanan rawat jalan.

Booking terjadi sebelum kunjungan dan menjadi dasar bagi proses registrasi ketika pasien datang.

### 2. Registration

Kemampuan untuk mencatat **registrasi kunjungan pasien ke rumah sakit**.

Registration menangani jenis kunjungan:

* Rawat Jalan
* Rawat Inap
* IGD

> Jenis registrasi tambahan belum ditentukan dalam model ini.

### 3. Queue

Kemampuan untuk mengelola **antrian pendaftaran rawat jalan**.

Queue mencatat posisi dan urutan pasien dalam proses pendaftaran rawat jalan.

### 4. Patient Journey

Kemampuan untuk mencatat **perjalanan pasien antar layanan selama satu kunjungan**.

Tujuannya adalah membentuk gambaran aktivitas perpindahan/transfer pasien, misalnya:

```text
Registrasi
    ↓
Poliklinik
    ↓
Laboratorium
    ↓
Radiologi
    ↓
Farmasi
```

Patient Journey mencatat layanan yang didatangi pasien dan hubungan perpindahan antar layanan dalam konteks satu kunjungan.

## Domain Boundary

### Owns

* Booking / appointment pasien
* Registrasi kunjungan
* Antrian pendaftaran rawat jalan
* Perjalanan pasien antar layanan dalam satu kunjungan

### Does Not Own

* Identitas dan master data pasien → **Pasien Domain**
* Master layanan, instalasi, dan organisasi rumah sakit → **Organisasi Domain**
* Pelaksanaan pelayanan klinis → domain pelayanan terkait
* Billing dan transaksi pembayaran → domain keuangan terkait

## Relationships

| Domain                   | Relationship                                                                                       |
| ------------------------ | -------------------------------------------------------------------------------------------------- |
| Pasien                   | Admission menggunakan identitas pasien untuk booking dan registration.                             |
| Organisasi               | Admission menggunakan layanan/unit tujuan untuk booking, registration, queue, dan patient journey. |
| Clinical Service Domains | Patient Journey mencatat perpindahan pasien menuju layanan yang dikelola oleh domain terkait.      |

## Capability Map

| Capability      | Business Ability                                              |
| --------------- | ------------------------------------------------------------- |
| Booking         | Mengelola appointment pasien sebelum kunjungan                |
| Registration    | Mencatat kunjungan pasien ke rumah sakit                      |
| Queue           | Mengelola antrian pendaftaran rawat jalan                     |
| Patient Journey | Mencatat perjalanan pasien antar layanan dalam satu kunjungan |
