# OUTCOME: Result Management

| Field       | Value                    |
|-------------|--------------------------|
| Code        | OC-08-05                 |
| Version     | 1.1                      |
| Status      | Final Draft              |
| LastUpdated | 2026-10-07               |

---

## 1. Business Purpose

Setelah pemeriksaan laboratorium diproses — baik setelah Sample Collection maupun langsung tanpa sample — unit laboratorium harus mampu mencatat hasil pemeriksaan, menjamin kualitasnya melalui proses Verify, mempublikasikannya kepada klinisi melalui proses Release, serta melakukan Amend apabila terjadi koreksi terhadap hasil yang telah tercatat.

OC-08-05 bertanggung jawab atas **Result Management** — yaitu pencatatan hasil pemeriksaan laboratorium (*Result*) dan pengelolaan status Order Laboratorium yang mencerminkan perkembangan kualitas hasil tersebut: dari **`Recorded`** (sudah terdapat Result yang dicatat pada Order), **`Verified`** (Order telah diverifikasi), hingga **`Released`** (Order telah dirilis kepada klinisi).

Status `Recorded`, `Verified`, dan `Released` berlaku pada **Order Laboratorium secara utuh** — bukan pada Result atau item pemeriksaan individual. Result dapat tersedia secara bertahap: Order tidak harus menunggu seluruh pemeriksaan selesai untuk dapat di-Verify atau di-Release.

Amend adalah command untuk mengoreksi Result yang telah tercatat, termasuk Result pada Order yang sudah berstatus `Verified` atau `Released`. Amend tidak menghasilkan status tersendiri dan tidak mengubah status Order secara otomatis. Amend wajib mencatat **siapa, kapan, dan alasan** perubahan, sedangkan Result hanya menyimpan **nilai terakhir** — nilai sebelum Amend tidak disimpan sebagai version atau history.

Apabila Result di-Amend setelah Order berstatus `Released`, nilai perubahan tersebut **belum dianggap sebagai hasil yang telah diverifikasi dan dirilis**. Agar perubahan tersebut menjadi hasil yang telah dirilis, Order harus melalui command **Verify** dan kemudian **Release** kembali secara eksplisit.

---

## 2. Outcome Statement

Hasil pemeriksaan laboratorium pada Order Laboratorium telah tercatat, dan Order Laboratorium mencerminkan status bisnis yang menggambarkan kemajuan kualitas hasilnya — **`Recorded`**, **`Verified`**, atau **`Released`** — beserta rekam jejak siapa yang melakukan Verify, Release, dan/atau Amend.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik utama outcome: mencatat Result, menjalankan command Verify, Release, dan Amend, serta memelihara status Order Laboratorium dalam lifecycle Result Management. |
| Master Data Laboratorium | Menyediakan definisi pemeriksaan laboratorium (termasuk nilai referensi/nilai normal) yang digunakan sebagai konteks pencatatan Result. |
| Organisasi | Menyediakan identitas actor terautentikasi yang memiliki kewenangan untuk mencatat Result, melakukan Verify, Release, dan Amend sesuai access-control policy yang berlaku. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `LAB-RESULT` Result Management | Laboratory | Known |
| `MDL-PEMERIKSAAN` Master Pemeriksaan Laboratorium | Master Data Laboratorium | Known |
| `ORG-USER` User & Petugas | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Order Laboratorium yang menjadi target Result Management valid, terdaftar, dan telah memenuhi eligibility untuk pencatatan Result (secara default: telah berstatus `SampleCollected`, atau untuk pemeriksaan tanpa sample, telah memenuhi eligibility yang berlaku).
- Setidaknya satu Result telah dicatat pada Order Laboratorium, menjadikan Order berstatus **`Recorded`**.
- Status **`Verified`** hanya dapat ditetapkan melalui command **Verify** yang dijalankan secara eksplisit terhadap Order. Verify bukan proses otomatis.
- Status **`Released`** hanya dapat ditetapkan melalui command **Release** yang dijalankan secara eksplisit terhadap Order, dan hanya terhadap Order yang sudah pernah melalui Verify (minimal sekali berstatus `Verified`).
- **Amend** adalah command koreksi terhadap Result yang telah tercatat, termasuk Result pada Order yang sudah berstatus `Verified` atau `Released`. Amend tidak menghasilkan status tersendiri pada Order dan tidak mengubah status Order secara otomatis. Amend wajib mencatat rekam jejak perubahan (`AmendedBy`, `AmendedDateTime`, `AmendReason`), sedangkan Result hanya menyimpan nilai terakhir. Apabila Result pada Order berstatus `Released` di-Amend, perubahan nilai tersebut belum dianggap sebagai hasil yang telah diverifikasi dan dirilis; Order harus melalui Verify dan Release kembali secara eksplisit agar perubahan tersebut menjadi hasil yang telah dirilis.
- Status Order Laboratorium (`Recorded`, `Verified`, `Released`) berlaku pada Order secara utuh, bukan per Result atau item pemeriksaan individual.

### 5.2 Required Recorded Information

- Identitas Order Laboratorium (Order ID).
- Per Result yang dicatat:
  - Identitas pemeriksaan (Examination ID / referensi ke item Order).
  - **ResultValue** — nilai hasil pemeriksaan (nilai terakhir yang berlaku).
  - **ResultedDateTime** — waktu Result dicatat/diinput.
  - **ResultedBy** — user yang mencatat Result.
  - **ResultNote** *(opsional)* — catatan atau keterangan terkait Result.
- Per event Verify:
  - **VerifiedDateTime** — waktu Verify dilakukan.
  - **VerifiedBy** — user yang melakukan Verify.
- Per event Release:
  - **ReleasedDateTime** — waktu Release dilakukan.
  - **ReleasedBy** — user yang melakukan Release.
- Per event Amend:
  - **AmendedDateTime** — waktu Amend dilakukan.
  - **AmendedBy** — user yang melakukan Amend.
  - **AmendReason** — alasan perubahan.
  - *(Result hanya menyimpan nilai terakhir; nilai sebelum Amend tidak disimpan oleh OC ini).*
- Status Order Laboratorium terkini (`Recorded`, `Verified`, atau `Released`).

### 5.3 Required Business Conditions

- Order Laboratorium harus memenuhi eligibility sebelum Result dapat dicatat.
- Command **Verify** hanya dapat dijalankan terhadap Order yang memiliki status `Recorded` atau `Verified` (Order yang telah memiliki Result). Verify dapat dilakukan kembali sesuai kebutuhan operasional.
- Command **Release** hanya dapat dijalankan terhadap Order yang sudah pernah melalui Verify (pernah mencapai status `Verified` setidaknya sekali). Release dapat dilakukan kembali sesuai kebutuhan operasional.
- Pencatatan Result baru pada Order yang sudah berstatus `Verified` atau `Released` **tidak otomatis menurunkan status Order** kembali ke `Recorded`. Status Order hanya berubah melalui command yang dijalankan secara eksplisit.
- Lifecycle konseptual `Recorded → Verified → Released` adalah urutan yang diharapkan, namun **bukan state machine yang ketat**. Verify dan Release dapat dilakukan kembali selama memenuhi kondisi bisnis yang berlaku.
- Result dapat tersedia secara bertahap (partial result). Order tidak harus menunggu seluruh pemeriksaan selesai sebelum Verify atau Release dapat dijalankan.
- Partial result release diperbolehkan: Order dapat di-Release meskipun belum seluruh Result tersedia.
- Command Verify, Release, dan pencatatan Result hanya dapat dilakukan oleh actor yang memiliki kewenangan/permission sesuai access-control policy yang berlaku (tidak dikunci pada role tertentu di level Outcome ini).
- Command **Amend** dapat dijalankan terhadap Result yang telah tercatat, termasuk pada Order yang sudah berstatus `Verified` atau `Released`. Amend tidak mengubah status Order secara otomatis. Apabila Result pada Order berstatus `Released` di-Amend, perubahan nilai tersebut belum dianggap sebagai hasil yang telah diverifikasi dan dirilis; agar perubahan menjadi hasil yang telah dirilis, Order harus melalui Verify dan kemudian Release kembali secara eksplisit. AmendReason wajib disertakan.

### 5.4 Required Completion Conditions

Outcome ini dinyatakan terbentuk apabila:

- Setidaknya satu Result telah tercatat pada Order Laboratorium dan Order berstatus **`Recorded`**, **atau**
- Order Laboratorium berstatus **`Verified`** setelah command Verify berhasil dijalankan, **atau**
- Order Laboratorium berstatus **`Released`** setelah command Release berhasil dijalankan.

---

## 6. Outcome Boundary

### Outcome Start

OC-08-05 dimulai ketika actor mencatat Result pertama pada Order Laboratorium yang telah memenuhi eligibility untuk Result Management.

### Outcome End

OC-08-05 berakhir ketika Order Laboratorium mencapai status **`Released`** dan tidak ada lagi kebutuhan bisnis untuk Amend, Verify ulang, atau Release ulang terhadap Order tersebut.

> **Catatan:** Status `Released` bukan terminal yang ketat. Verify dan Release dapat dijalankan kembali, dan Amend dapat dilakukan selama Order masih dalam scope Result Management. Batas praktis ditetapkan oleh kebijakan operasional rumah sakit.

---

## 7. Business Constraints

- **Status berlaku pada Order, bukan pada Result individual.** `Recorded`, `Verified`, dan `Released` adalah status Order Laboratorium secara utuh. Tidak ada status per-Result (`PartiallyVerified`, `PartiallyReleased`, `Amended`, dsb.).
- **Release hanya setelah Verify.** Order tidak dapat di-Release tanpa pernah melalui Verify terlebih dahulu.
- **Amend tidak mengubah status Order.** Amend adalah command koreksi terhadap Result yang telah tercatat, termasuk pada Order berstatus `Verified` atau `Released`. Amend tidak menghasilkan status tersendiri dan tidak mengubah status Order secara otomatis. Result hanya menyimpan nilai terakhir; nilai sebelum Amend tidak disimpan. `AmendedBy`, `AmendedDateTime`, dan `AmendReason` wajib dicatat.
- **Amend setelah Released memerlukan Verify dan Release ulang.** Apabila Result pada Order berstatus `Released` di-Amend, perubahan nilai tersebut belum dianggap sebagai hasil yang telah diverifikasi dan dirilis. Agar perubahan menjadi hasil yang telah dirilis, Order harus melalui command **Verify** dan kemudian **Release** kembali secara eksplisit.
- **Pencatatan Result baru tidak menurunkan status Order.** Result baru yang dicatat setelah Order berstatus `Verified` atau `Released` tidak otomatis mengembalikan status Order ke `Recorded`.
- **Partial result diperbolehkan.** Verify dan Release dapat dijalankan meskipun belum seluruh Result tersedia, sesuai pertimbangan operasional.
- **Verify dan Release dapat diulang.** Keduanya dapat dijalankan kembali sesuai kebutuhan operasional, selama memenuhi kondisi bisnis yang berlaku (khususnya Release hanya setelah Verify pernah dilakukan).
- **Lifecycle konseptual, bukan state machine ketat.** `Recorded → Verified → Released` adalah urutan yang diharapkan tetapi tidak diberlakukan secara kaku sebagai state machine.
- **Persistence sebelum perubahan status.** Status Order hanya diperbarui setelah pencatatan berhasil tersimpan secara persisten. Kegagalan penyimpanan tidak mengubah status Order.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| Order Laboratorium tidak ditemukan / ID tidak valid | Pencatatan Result, Verify, Release, dan Amend ditolak. Order harus valid dan terdaftar. |
| Order Laboratorium tidak memenuhi eligibility untuk pencatatan Result (belum mencapai status yang disyaratkan) | Pencatatan Result ditolak. Order harus memenuhi eligibility terlebih dahulu. |
| Order Laboratorium berstatus `Cancelled` | Semua command Result Management ditolak. Order yang telah dibatalkan tidak dapat diproses dalam OC ini. |
| Command Verify dijalankan pada Order yang belum memiliki Result (belum `Recorded`) | Verify ditolak. Order harus memiliki setidaknya satu Result yang tercatat. |
| Command Release dijalankan pada Order yang belum pernah melalui Verify | Release ditolak. Release hanya dapat dilakukan terhadap Order yang sudah pernah berstatus `Verified`. |
| Command Amend dijalankan tanpa menyertakan alasan perubahan (`AmendReason`) | Amend ditolak. `AmendReason` wajib dicatat sebagai bagian dari rekam jejak Amend. |
| Command Amend dijalankan terhadap Result pada Order berstatus `Released`, lalu tidak dilanjutkan dengan Verify dan Release ulang | Amend tetap diterima dan rekam jejak tersimpan, namun perubahan nilai belum dianggap sebagai hasil yang telah diverifikasi dan dirilis hingga Order melalui Verify dan Release kembali secara eksplisit. |
| Actor tidak memiliki kewenangan/permission untuk menjalankan command yang dimaksud | Command ditolak. Hanya actor yang berwenang sesuai access-control policy yang berlaku yang dapat menjalankan command Result Management. |
| Penyimpanan pencatatan Result, Verify, Release, atau Amend gagal | Status Order tidak berubah dan perubahan tidak tersimpan. Sistem mempertahankan kondisi sebelumnya. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------| 
| AC-01 | Ketika Result pertama berhasil dicatat pada Order Laboratorium yang memenuhi eligibility, Order berstatus **`Recorded`**. | Completeness |
| AC-02 | Pencatatan Result menyimpan informasi: identitas pemeriksaan, **ResultValue**, **ResultedDateTime**, **ResultedBy**, dan **ResultNote** (jika diisi). | Correctness |
| AC-03 | Command **Verify** yang berhasil dijalankan terhadap Order menghasilkan status Order **`Verified`** dan menyimpan **VerifiedDateTime** serta **VerifiedBy**. | Completeness |
| AC-04 | Command **Release** yang berhasil dijalankan terhadap Order menghasilkan status Order **`Released`** dan menyimpan **ReleasedDateTime** serta **ReleasedBy**. | Completeness |
| AC-05 | Command **Release** ditolak apabila Order belum pernah berstatus `Verified` (belum pernah melalui proses Verify). | Constraint |
| AC-06 | Command **Verify** ditolak apabila Order belum memiliki Result yang tercatat (belum `Recorded`). | Constraint |
| AC-07 | Pencatatan Result baru pada Order yang sudah berstatus `Verified` atau `Released` **tidak mengubah status Order**. Status Order tetap pada nilai terakhirnya. | Correctness |
| AC-08 | Command **Amend** dapat dijalankan terhadap Result yang telah tercatat, termasuk pada Order berstatus `Verified` atau `Released`. Amend berhasil mengoreksi nilai Result dan menyimpan rekam jejak perubahan: **AmendedDateTime**, **AmendedBy**, dan **AmendReason**. Result hanya menyimpan nilai terakhir setelah Amend; nilai sebelum Amend tidak disimpan. | Correctness |
| AC-09 | Command Amend ditolak apabila tidak menyertakan **AmendReason**. | Constraint |
| AC-10 | Order tidak memiliki status `Amended`, `PartiallyVerified`, `PartiallyReleased`, atau status turunan per-Result lainnya. Status Order hanya: `Recorded`, `Verified`, atau `Released`. | Correctness |
| AC-11 | Command **Verify** dan **Release** dapat dijalankan kembali terhadap Order yang sudah pernah `Verified` atau `Released`, selama memenuhi kondisi bisnis yang berlaku. | Correctness |
| AC-12 | Order dapat di-Verify atau di-Release meskipun belum seluruh Result pemeriksaan tersedia (partial result diperbolehkan). | Correctness |
| AC-13 | Status `Recorded`, `Verified`, dan `Released` berlaku pada Order Laboratorium secara utuh, bukan pada Result atau item pemeriksaan individual. | Correctness |
| AC-14 | Semua command Result Management ditolak apabila Order berstatus `Cancelled`. | Constraint |
| AC-15 | Status Order hanya diperbarui setelah pencatatan berhasil tersimpan secara persisten. Kegagalan penyimpanan tidak mengubah status Order. | Constraint |
| AC-16 | Semua command Result Management hanya dapat dijalankan oleh actor yang memiliki kewenangan/permission sesuai access-control policy yang berlaku. | Correctness |
| AC-17 | Apabila Result pada Order berstatus `Released` di-Amend, status Order **tidak berubah secara otomatis**. Perubahan nilai tersebut belum dianggap sebagai hasil yang telah diverifikasi dan dirilis hingga Order melalui command **Verify** dan kemudian **Release** kembali secara eksplisit. | Constraint |

---

## 10. Out of Scope

- Pengambilan dan pencatatan sample biologis pasien → **OC-08-04 Sample Collection**.
- Pemrosesan fisik sampel, komunikasi analyzer/LIS, dan Sample Management → **Sample Management / LIS Interface**.
- Pembuatan dan pengelolaan Order Laboratorium → **OC-08-02 Order Laboratorium**.
- Pembebanan biaya pemeriksaan laboratorium → **OC-08-03 Charge**.
- Penyimpanan nilai Result historis sebelum Amend (nilai sebelum koreksi) → di luar cakupan OC ini; audit trail teknis bukan tanggung jawab OC-08-05.
- Pengelolaan nilai referensi/nilai normal pemeriksaan → **Master Data Laboratorium** (`MDL-PEMERIKSAAN`).
- Distribusi atau pengiriman hasil kepada pasien/keluarga, atau ke sistem eksternal → di luar cakupan OC ini.
- Pengelolaan identitas dan data sosial pasien → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan data dokter dan PPA → **Organisasi Domain** (`ORG-PPA`).
- Pemakaian barang/reagen oleh unit laboratorium → **OC-08-06 Pakai Barang**.

---

## 11. Business Decisions & Open Questions

### Confirmed Decisions

1. **Status berlaku pada Order, bukan per Result:** `Recorded`, `Verified`, dan `Released` adalah status Order Laboratorium secara utuh. Tidak ada status per-Result atau status turunan seperti `PartiallyVerified`, `PartiallyReleased`, atau `Amended`.
2. **Semantik `Recorded`:** Order berstatus `Recorded` berarti sudah terdapat minimal satu Result yang dicatat pada Order tersebut.
3. **Semantik Verify:** Verify adalah command eksplisit terhadap Order yang menghasilkan status `Verified`. Verify bukan proses otomatis.
4. **Semantik Release:** Release adalah command eksplisit terhadap Order yang menghasilkan status `Released`. Release hanya dapat dilakukan terhadap Order yang sudah pernah melalui Verify (pernah berstatus `Verified` minimal sekali).
5. **Semantik Amend:** Amend adalah command koreksi terhadap Result yang telah tercatat, termasuk pada Order yang sudah berstatus `Verified` atau `Released`. Amend bukan status — Order tidak memiliki status `Amended`. Amend tidak mengubah status Order secara otomatis. Amend wajib mencatat `AmendedBy`, `AmendedDateTime`, dan `AmendReason`; Result hanya menyimpan nilai terakhir; nilai sebelum Amend tidak disimpan sebagai version atau history.
6. **Lifecycle konseptual, bukan state machine ketat:** Urutan `Recorded → Verified → Released` adalah urutan yang diharapkan, tetapi tidak diberlakukan sebagai state machine yang kaku. Verify dan Release dapat dijalankan kembali sesuai kebutuhan operasional.
7. **Pencatatan Result baru tidak menurunkan status Order:** Result baru yang dicatat pada Order berstatus `Verified` atau `Released` tidak otomatis mengembalikan status Order ke `Recorded`.
8. **Partial result diperbolehkan:** Order dapat di-Verify atau di-Release meskipun belum seluruh Result tersedia. Partial result release diperbolehkan.
9. **Tidak ada status tambahan:** Tidak dibuat status `PartiallyVerified`, `PartiallyReleased`, `Amended`, atau status per-Result apapun.
10. **AmendReason wajib:** Rekam jejak Amend wajib menyertakan alasan perubahan. Amend tanpa AmendReason ditolak.
11. **Persistence sebelum status:** Status Order hanya diperbarui setelah pencatatan berhasil tersimpan. Kegagalan penyimpanan tidak mengubah status Order.
12. **Actor Authorization:** Kewenangan menjalankan command Result Management diatur oleh access-control policy. OC-08-05 tidak mengunci pada role tertentu di level Outcome.
13. **Konsekuensi Amend setelah Released:** Apabila Result pada Order berstatus `Released` di-Amend, perubahan nilai tersebut belum dianggap sebagai hasil yang telah diverifikasi dan dirilis. Agar perubahan menjadi hasil yang telah dirilis, Order harus melalui command Verify dan kemudian Release kembali secara eksplisit. Status Order tidak berubah secara otomatis akibat Amend.

### Open Questions

*Tidak ada Open Question yang belum terselesaikan. Seluruh keputusan bisnis telah dikonfirmasi oleh Product Owner dan diintegrasikan ke dalam spesifikasi Outcome ini.*
