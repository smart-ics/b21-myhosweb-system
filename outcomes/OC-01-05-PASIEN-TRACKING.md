# OUTCOME: Patient Journey Tracking

| Field       | Value        |
|-------------|--------------|
| Code        | OC-01-05     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat dan menelusuri perjalanan pasien antar unit layanan selama satu kunjungan sebagai persisted business fact yang memberikan gambaran utuh mengenai seluruh titik layanan yang didatangi pasien — mulai dari pendaftaran hingga layanan terakhir sebelum pasien meninggalkan rumah sakit.

Patient Journey Tracking memastikan bahwa setiap perpindahan pasien dari satu unit layanan ke unit layanan berikutnya — baik yang direncanakan melalui order dokter maupun yang terjadi atas kebutuhan klinis — tercatat secara berurutan dan dapat ditelusuri dalam konteks satu kunjungan.

Tanpa catatan perjalanan pasien yang tersimpan dalam sistem, koordinasi antar unit layanan tidak dapat dilakukan secara informasional, kesinambungan pelayanan tidak dapat dijamin, dan gambaran lintas unit atas satu episode kunjungan pasien tidak dapat dibangun.

---

## 2. Outcome Statement

Perjalanan pasien antar unit layanan selama satu kunjungan **telah tercatat sebagai rangkaian titik layanan yang berurutan dan terverifikasi dalam sistem, dengan setiap perpindahan terdokumentasi, sehingga kunjungan dapat ditelusuri secara lintas unit dari pendaftaran hingga layanan terakhir**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome                                                                                                       |
|---------------|----------------------------------------------------------------------------------------------------------------------------|
| Admission     | Pemilik utama: mencatat dan mengelola perjalanan pasien antar layanan sebagai persisted fact melalui `ADM-TRACKER`         |
| Pasien        | Menyediakan identitas pasien (Nomor Rekam Medis) sebagai subjek perjalanan dalam kunjungan                                 |
| Organisasi    | Menyediakan referensi unit layanan yang menjadi titik-titik dalam perjalanan pasien                                        |
| Rawat Jalan   | Menjadi titik layanan dalam perjalanan pasien ketika pasien mengunjungi poliklinik rawat jalan                             |
| Rawat Inap    | Menjadi titik layanan dalam perjalanan pasien ketika pasien berpindah ke bangsal rawat inap                                |
| Gawat Darurat | Menjadi titik awal perjalanan pasien ketika kunjungan berasal dari jalur IGD                                               |
| Laboratory    | Menjadi titik layanan dalam perjalanan pasien ketika order laboratorium mengharuskan pasien mendatangi unit laboratorium    |
| Radiology     | Menjadi titik layanan dalam perjalanan pasien ketika order radiologi mengharuskan pasien mendatangi unit radiologi          |
| Apotek        | Menjadi titik layanan akhir dalam perjalanan pasien ketika pasien mengambil obat di apotek                                 |

---

## 4. Participating Capabilities

| Capability                             | Domain        | Status |
|----------------------------------------|---------------|--------|
| `ADM-TRACKER` Pasien Journey           | Admission     | Known  |
| `ADM-REG` Registration                 | Admission     | Known  |
| `PAS-DATSOS` Data Sosial Pasien        | Pasien        | Known  |
| `ORG-LAYANAN` Unit Layanan             | Organisasi    | Known  |
| `RJL-ANTRIAN` Antrian Poli             | Rawat Jalan   | Known  |
| `IGD-VISIT` IGD Visit                  | Gawat Darurat | Known  |
| `RNA-BED` Pakai Bed                    | Rawat Inap    | Known  |
| `LAB-ORDER` Order Lab                  | Laboratory    | Known  |
| `RAD-ORDER` Order Radiologi            | Radiology     | Known  |
| `APT-QUEUE` Antrian Apotek             | Apotek        | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Perjalanan pasien selama satu kunjungan telah tercatat sebagai rangkaian titik layanan yang berurutan.
- Setiap titik layanan dalam perjalanan memiliki status kedatangan dan keberangkatan yang tercatat.
- Kunjungan yang menjadi konteks perjalanan pasien harus telah terdaftar secara sah dalam sistem.
- Titik awal perjalanan pasien mengacu pada unit tempat pasien pertama kali masuk dalam kunjungan tersebut (loket pendaftaran, IGD, atau unit pertama yang relevan).
- Setiap titik layanan yang dimasuki pasien dapat diidentifikasi berdasarkan kunjungan, unit layanan, dan urutan waktu.

### 5.2 Required Recorded Information

**Informasi kunjungan sebagai konteks:**

- Nomor kunjungan (nomor registrasi) yang menjadi konteks perjalanan.
- Nomor Rekam Medis pasien.
- Jenis kunjungan: Rawat Jalan, Rawat Inap, atau IGD.

**Informasi per titik layanan (journey stop):**

- Urutan / nomor urut titik layanan dalam perjalanan.
- Kode dan nama unit layanan tujuan.
- Waktu pasien tiba (check-in) di unit layanan.
- Waktu pasien selesai dan meninggalkan unit layanan (check-out), jika berlaku.
- Status titik layanan: Menunggu, Sedang Dilayani, Selesai, Batal.
- Referensi order atau tindakan yang menjadi alasan kunjungan ke unit tersebut (jika ada).
- Petugas atau PPA yang bertanggung jawab di unit layanan terkait (jika tercatat).

**Informasi jalur perpindahan:**

- Asal unit layanan (dari mana pasien datang).
- Tujuan unit layanan berikutnya (jika ada).

### 5.3 Required Business Conditions

- Kunjungan yang menjadi konteks perjalanan pasien harus sudah terdaftar dan berstatus aktif dalam sistem.
- Setiap unit layanan yang dicatat sebagai titik perjalanan harus merupakan unit yang valid dan aktif dalam sistem (`ORG-LAYANAN`).
- Setiap titik layanan dalam perjalanan harus terhubung ke satu kunjungan yang sama; satu titik layanan tidak dapat dikaitkan ke lebih dari satu kunjungan.
- Urutan titik layanan dalam perjalanan harus konsisten secara kronologis berdasarkan waktu check-in.
- Titik layanan tidak dapat dimasukkan ke kunjungan yang sudah selesai atau ditutup, kecuali melalui prosedur koreksi yang berlaku.

### 5.4 Completion Proof

- Perjalanan pasien dapat ditemukan dan ditampilkan berdasarkan nomor kunjungan atau nomor rekam medis pasien.
- Seluruh unit layanan yang didatangi pasien selama kunjungan tersebut tercantum dalam urutan kronologis yang benar.
- Setiap titik layanan memiliki waktu check-in yang tercatat.
- Status setiap titik layanan mencerminkan keadaan aktual terakhir pasien di unit tersebut.
- Titik awal perjalanan tercatat dan terhubung dengan nomor kunjungan yang valid.

---

## 6. Outcome Boundary

### Start

Dimulai ketika kunjungan pasien telah terdaftar secara sah dalam sistem dan titik layanan pertama dalam perjalanan mulai dicatat — baik secara otomatis saat registrasi kunjungan diselesaikan, maupun saat petugas atau sistem secara eksplisit mendaftarkan pasien ke unit layanan pertama dalam kunjungan tersebut.

> Perjalanan pasien adalah konsekuensi langsung dari kunjungan yang aktif. Outcome ini tidak dapat dimulai tanpa kunjungan aktif yang menjadi konteksnya.

### End

Berakhir ketika seluruh titik layanan yang direncanakan dalam kunjungan telah memiliki status Selesai, atau ketika kunjungan itu sendiri ditutup (pasien pulang, dirujuk keluar, atau meninggal), sehingga tidak ada lagi titik layanan baru yang akan ditambahkan ke perjalanan tersebut.

> Outcome ini bersifat akumulatif: setiap penambahan titik layanan baru ke kunjungan yang masih aktif merupakan perluasan Outcome yang sama, bukan Outcome baru.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Perjalanan pasien hanya dapat dicatat dalam konteks kunjungan yang aktif. Kunjungan yang sudah ditutup tidak dapat menerima penambahan titik layanan baru, kecuali melalui prosedur koreksi yang berlaku.
- Setiap titik layanan dalam perjalanan harus mengacu pada unit layanan yang valid dan aktif dalam sistem. Referensi ke unit layanan yang tidak dikenal atau tidak aktif tidak diizinkan.
- Satu titik layanan dalam perjalanan hanya boleh terkait dengan satu kunjungan. Satu titik layanan tidak dapat dibagi atau dirujuk silang ke kunjungan lain.
- Urutan kronologis titik layanan dalam perjalanan tidak boleh bertentangan: waktu check-in titik layanan berikutnya tidak boleh lebih awal dari waktu check-in titik layanan sebelumnya dalam rangkaian yang sama.
- Titik layanan yang sudah berstatus Selesai tidak dapat diubah kembali menjadi Menunggu atau Sedang Dilayani tanpa prosedur koreksi yang berlaku.
- Patient Journey Tracking tidak mencatat pelayanan klinis itu sendiri (tindakan, diagnosa, order); hanya mencatat fakta kehadiran dan perpindahan pasien antar unit layanan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                               | Expected Behavior                                                                                                                                                             |
|-----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kunjungan yang dijadikan konteks tidak ditemukan atau tidak berstatus aktif             | Titik layanan tidak dapat dicatat. Petugas harus memverifikasi nomor kunjungan dan status kunjungan sebelum melanjutkan.                                                      |
| Unit layanan tujuan tidak ditemukan atau tidak aktif dalam sistem                      | Titik layanan ke unit tersebut tidak dapat dicatat. Petugas harus memilih unit layanan yang valid dan aktif.                                                                  |
| Pasien tidak dapat diidentifikasi melalui nomor rekam medis yang terkait dengan kunjungan | Perjalanan tidak dapat dikaitkan ke pasien yang benar. Verifikasi identitas pasien harus dilakukan sebelum pencatatan perjalanan dapat dilanjutkan.                          |
| Kunjungan sudah ditutup dan tidak dalam prosedur koreksi                               | Penambahan titik layanan baru ditolak. Sistem menginformasikan bahwa kunjungan sudah selesai dan tidak dapat menerima catatan perjalanan baru.                                |
| Terdapat konflik urutan waktu (waktu check-in titik baru lebih awal dari titik sebelumnya) | Sistem menolak pencatatan titik layanan dengan timestamp yang tidak konsisten. Petugas harus memverifikasi dan mengoreksi waktu check-in sebelum data dapat disimpan.        |
| Order atau tindakan yang menjadi dasar kunjungan ke unit tidak ditemukan               | Titik layanan dapat tetap dicatat tanpa referensi order jika tidak wajib; namun jika unit layanan mensyaratkan referensi order, catatan tanpa order ditolak hingga order tersedia. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                  | Validates    |
|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Perjalanan pasien dapat ditemukan dan ditampilkan berdasarkan nomor kunjungan, menampilkan seluruh titik layanan yang telah dikunjungi dalam urutan kronologis yang benar. | Completeness |
| AC-02 | Setiap titik layanan dalam perjalanan mencatat unit layanan, waktu check-in, dan status yang akurat sesuai keadaan aktual.                                                 | Correctness  |
| AC-03 | Perjalanan pasien dapat ditemukan berdasarkan nomor rekam medis pasien dengan memilih kunjungan yang relevan.                                                              | Completeness |
| AC-04 | Titik layanan yang ditambahkan ke kunjungan aktif tercermin dalam perjalanan pasien secara real-time atau segera setelah data disimpan.                                    | Completeness |
| AC-05 | Urutan kronologis titik layanan dalam perjalanan konsisten: setiap titik check-in berikutnya tidak lebih awal dari titik check-in sebelumnya dalam rangkaian yang sama.    | Correctness  |
| AC-06 | Status setiap titik layanan mencerminkan kondisi aktual terakhir pasien di unit tersebut: Menunggu, Sedang Dilayani, Selesai, atau Batal.                                  | Correctness  |
| AC-07 | Titik layanan tidak dapat dicatat ke kunjungan yang sudah ditutup tanpa prosedur koreksi yang berlaku.                                                                    | Constraint   |
| AC-08 | Setiap titik layanan hanya mengacu pada unit layanan yang valid dan aktif dalam sistem; referensi ke unit tidak aktif ditolak.                                              | Constraint   |
| AC-09 | Pencatatan titik layanan dengan timestamp yang bertentangan secara kronologis ditolak oleh sistem.                                                                         | Constraint   |
| AC-10 | Kunjungan yang tidak aktif atau tidak ditemukan tidak dapat menjadi konteks bagi pencatatan titik layanan baru.                                                            | Exception    |
| AC-11 | Perjalanan pasien tidak memuat informasi klinis (diagnosa, tindakan, order); hanya mencatat kehadiran dan perpindahan pasien antar unit layanan.                           | Constraint   |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Registrasi kunjungan rawat jalan atau IGD yang menjadi konteks perjalanan → **OC-01-02 Registrasi Rawat Jalan dan IGD**.
- Registrasi rawat inap yang menjadi titik awal kunjungan rawat inap → **OC-01-03 Registrasi Rawat Inap**.
- Pengelolaan antrian fisik pendaftaran rawat jalan di loket → **OC-01-07 Antrian**.
- Antrian pasien di poliklinik rawat jalan → **Rawat Jalan Domain** (`RJL-ANTRIAN`).
- Antrian pasien di apotek → **Apotek Domain** (`APT-QUEUE`).
- Pelaksanaan tindakan klinis dan pelayanan medis di setiap unit layanan → domain pelayanan klinis terkait.
- Order pemeriksaan laboratorium atau radiologi (CPOE) → **OC-05-04 CPOE**.
- Transfer pasien rawat inap antar bangsal atau antar unit → **Rawat Inap Domain** (`RNA-TRANSFER`).
- Transfer pasien IGD ke rawat inap → **Gawat Darurat Domain** (`IGD-RANAP`).
- Pencatatan data klinis, diagnosa, dan rekam medis → domain klinis terkait.
- Pembentukan tagihan dan proses pembayaran atas layanan yang dikunjungi → **Tata Rekening Domain** (`TRK-BILLING`).
- Pengelolaan master data pasien dan identitas pasien → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan master unit layanan dan organisasi → **Organisasi Domain** (`ORG-LAYANAN`).
