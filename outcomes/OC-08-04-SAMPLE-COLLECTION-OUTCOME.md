# OUTCOME: Sample Collection

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-04          |
| Version     | 1.0               |
| Status      | Final Draft       |
| LastUpdated | 2026-10-05        |

---

## 1. Business Purpose

Setelah Order Laboratorium berstatus `Charged`, pelayanan klinis pemeriksaan laboratorium dapat dilanjutkan ke tahap pengambilan sample biologis pasien. Namun tidak semua pemeriksaan membutuhkan sample — kebutuhan sample ditentukan oleh **Master Pemeriksaan Laboratorium**.

OC-08-04 bertanggung jawab atas proses **Sample Collection** — yaitu pengambilan dan pencatatan sample biologis pasien yang diperlukan untuk memproses satu atau lebih pemeriksaan laboratorium dalam suatu Laboratory Order. Outcome ini menghasilkan Order Laboratorium berstatus **`SampleCollected`**, yang membuktikan bahwa seluruh required sample untuk pemeriksaan yang membutuhkan sample telah berhasil dikumpulkan dan pencatatannya telah tersimpan secara persisten oleh sistem.

Sample Collection hanya berlaku untuk pemeriksaan yang memiliki kebutuhan sample berdasarkan Master Pemeriksaan Laboratorium. Pemeriksaan yang tidak membutuhkan sample tidak melewati tahapan ini dan dapat langsung dilanjutkan ke Result Management.

OC-08-04 bukan merupakan Sample Management System. Outcome ini tidak mengelola jenis/spesimen, volume, kondisi, atau lifecycle sampel secara teknis. Scope OC-08-04 adalah pencatatan fakta bisnis bahwa pengambilan sample telah dilakukan.

---

## 2. Outcome Statement

Order Laboratorium yang memenuhi eligibility untuk Sample Collection telah dilakukan pengambilan seluruh required sample-nya, sehingga tercatat dengan status bisnis **`SampleCollected`** — membuktikan bahwa seluruh required sample untuk pemeriksaan dalam order yang membutuhkan sample telah berhasil dikumpulkan dan pencatatan Sample Collection telah berhasil disimpan oleh sistem.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik utama outcome: mengevaluasi eligibility untuk Sample Collection, mencatat Sample Collection, memperbarui status Order Laboratorium menjadi `SampleCollected`, dan memelihara lifecycle order laboratorium. |
| Master Data Laboratorium | Menyediakan fakta bisnis kebutuhan sample per pemeriksaan (required sample) melalui Master Pemeriksaan Laboratorium. |
| Organisasi | Menyediakan identitas actor terautentikasi yang memiliki kewenangan/permission untuk melakukan Sample Collection sesuai access-control policy yang berlaku. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `LAB-SAMPLE-COLLECTION` Sample Collection | Laboratory | Known |
| `MDL-PEMERIKSAAN` Master Pemeriksaan Laboratorium | Master Data Laboratorium | Known |
| `ORG-USER` User & Petugas | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Order Laboratorium yang menjadi target Sample Collection valid, terdaftar, dan memenuhi eligibility untuk Sample Collection.
- Secara default, Order Laboratorium yang telah berstatus `Charged` memenuhi eligibility untuk Sample Collection. Business rule lain yang secara eksplisit memperbolehkan Sample Collection juga diakui sebagai pemenuhan eligibility.
- Order Laboratorium memiliki setidaknya satu pemeriksaan yang membutuhkan sample berdasarkan Master Pemeriksaan Laboratorium.
- Seluruh required sample dari pemeriksaan yang membutuhkan sample dalam order telah terpenuhi.
- Status Order Laboratorium tercatat secara persisten sebagai **`SampleCollected`** setelah pencatatan Sample Collection berhasil disimpan oleh sistem.
- Status `SampleCollected` hanya ditetapkan setelah pencatatan Sample Collection berhasil tersimpan; jika penyimpanan gagal, status order tidak berubah.
- Identitas actor yang melakukan/mengkonfirmasi Sample Collection dan waktu pelaksanaan Sample Collection tercatat.

### 5.2 Required Recorded Information

- Identitas Order Laboratorium (Order ID).
- **Collected DateTime** — waktu Sample Collection dilakukan.
- **Collected By** — user yang melakukan/mengkonfirmasi Sample Collection.
- Status Order Laboratorium terbaru (**`SampleCollected`**).

### 5.3 Required Business Conditions

- Order Laboratorium harus memenuhi eligibility untuk Sample Collection. Secara default, status `Charged` merupakan pemenuhan eligibility. Business rule lain yang secara eksplisit memperbolehkan Sample Collection juga diakui.
- Order Laboratorium yang berstatus `Cancelled` tidak dapat dilakukan Sample Collection.
- Order Laboratorium yang telah berstatus `SampleCollected` tidak dapat dilakukan Sample Collection kembali melalui OC ini. Sample Collection hanya dapat dilakukan satu kali untuk setiap Laboratory Order.
- Sample Collection dilakukan oleh user yang memiliki kewenangan/permission untuk melakukan Sample Collection sesuai access-control policy yang berlaku. OC-08-04 tidak mengunci business rule ini pada role tertentu.
- Sample Collection dapat dilakukan secara partial/bertahap. Namun status `SampleCollected` hanya ditetapkan setelah seluruh required sample dari pemeriksaan yang membutuhkan sample telah terpenuhi.
- Pemeriksaan yang tidak membutuhkan sample berdasarkan Master Pemeriksaan Laboratorium tidak memerlukan Sample Collection dan tidak menjadi blocker terhadap proses Sample Collection.
- Jika satu order memiliki pemeriksaan yang membutuhkan sample dan pemeriksaan yang tidak membutuhkan sample, Sample Collection hanya diperlukan untuk pemeriksaan yang membutuhkan sample.
- Status `SampleCollected` merupakan boundary setelah order tidak dapat dibatalkan.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Order Laboratorium tersimpan dengan status bisnis **`SampleCollected`**.
- Catatan Sample Collection tersimpan dengan informasi minimum: Collected DateTime dan Collected By.
- Seluruh required sample dari pemeriksaan yang membutuhkan sample dalam order telah terpenuhi sebelum status `SampleCollected` ditetapkan.
- Order Laboratorium tidak dapat dibatalkan setelah berstatus `SampleCollected`.

---

## 6. Outcome Boundary

### Start

Dimulai ketika proses Sample Collection diinisiasi terhadap Order Laboratorium yang memenuhi eligibility untuk Sample Collection (secara default: berstatus `Charged`, atau memenuhi business rule lain yang secara eksplisit memperbolehkan Sample Collection).

### End

Berakhir ketika seluruh required sample dari pemeriksaan yang membutuhkan sample dalam order telah terpenuhi, pencatatan Sample Collection berhasil disimpan oleh sistem, dan Order Laboratorium berhasil bertransisi status menjadi **`SampleCollected`** secara persisten.

### Batas Tanggung Jawab

- **Batas terhadap Master Pemeriksaan Laboratorium:** OC-08-04 tidak mendefinisikan atau mengelola kebutuhan sample per pemeriksaan. OC-08-04 hanya mengonsumsi fakta bisnis kebutuhan sample (required sample) dari Master Pemeriksaan Laboratorium.
- **Batas terhadap Charge (OC-08-03):** OC-08-04 tidak mengelola aspek pembiayaan order. OC-08-04 hanya mengonsumsi fakta bahwa order memenuhi eligibility untuk Sample Collection (secara default: status `Charged`).
- **Batas terhadap Result Management (OC-08-05):** OC-08-04 tidak mengelola proses pengujian, pencatatan hasil, atau validasi hasil laboratorium. Order yang telah berstatus `SampleCollected` dapat dilanjutkan ke Result Management. Pemeriksaan yang tidak membutuhkan sample dapat langsung dilanjutkan ke Result Management tanpa melalui OC-08-04.
- **Batas operasional sample:** OC-08-04 tidak mengelola jenis/spesimen, volume, kondisi sample, rejected/invalid sample, recollection, sample processing, sample tracking, barcode/labeling, atau analyzer/LIS processing. Detail teknis tersebut berada di luar scope OC-08-04.

---

## 7. Business Constraints

- **Eligibility Constraint:** Sample Collection hanya dapat dilakukan apabila Laboratory Order memenuhi eligibility. Secara default, status `Charged` memenuhi eligibility. Business rule lain yang secara eksplisit memperbolehkan Sample Collection juga diakui tanpa mengecualikan kemungkinan tersebut.
- **Required Sample Source:** Kebutuhan sample ditentukan sepenuhnya oleh Master Pemeriksaan Laboratorium. OC-08-04 tidak mendefinisikan atau mengelola required sample.
- **Single Collection per Order:** Sample Collection hanya dapat dilakukan satu kali untuk setiap Laboratory Order. Setelah order berstatus `SampleCollected`, Sample Collection tidak dapat dilakukan kembali melalui OC ini.
- **Partial Collection Allowed, But Status Gated:** Sample Collection dapat dilakukan secara partial/bertahap, namun status `SampleCollected` hanya ditetapkan setelah seluruh required sample terpenuhi.
- **Persistence Before Status Transition:** Status `SampleCollected` hanya boleh ditetapkan setelah pencatatan Sample Collection berhasil disimpan oleh sistem. Jika penyimpanan gagal, order tidak boleh berubah menjadi `SampleCollected`.
- **No-Sample Examinations Are Not Blocked:** Pemeriksaan yang tidak membutuhkan sample tidak memerlukan Sample Collection dan tidak menjadi blocker. Dalam mixed order, pemeriksaan tanpa sample tidak menghalangi proses Sample Collection untuk pemeriksaan yang membutuhkan sample.
- **Cancellation Boundary:** Order Laboratorium yang telah berstatus `SampleCollected` tidak dapat dibatalkan. `SampleCollected` adalah titik batas setelah pembatalan order tidak diperbolehkan.
- **Authorized Actor Execution:** Sample Collection dilakukan oleh user yang memiliki kewenangan/permission sesuai access-control policy yang berlaku. OC-08-04 tidak mengunci aturan ini pada role tertentu.
- **No Sample Management:** OC-08-04 tidak mengelola jenis, kondisi, volume, atau lifecycle teknis sampel. OC-08-04 hanya mencatat fakta bisnis bahwa Sample Collection telah dilakukan.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| Order Laboratorium tidak ditemukan / ID tidak valid | Sample Collection ditolak. Order harus valid dan terdaftar. |
| Order Laboratorium tidak memenuhi eligibility untuk Sample Collection (misal: status masih `Ordered`, bukan `Charged` atau status yang secara eksplisit memperbolehkan Sample Collection) | Sample Collection ditolak. Order harus memenuhi eligibility terlebih dahulu. |
| Order Laboratorium berstatus `Cancelled` | Sample Collection ditolak. Order yang telah dibatalkan tidak dapat dilakukan Sample Collection. |
| Order Laboratorium sudah berstatus `SampleCollected` | Sample Collection ditolak. Sample Collection hanya dapat dilakukan satu kali untuk setiap Laboratory Order. |
| Actor tidak memiliki kewenangan/permission untuk melakukan Sample Collection | Sample Collection ditolak. Hanya actor yang berwenang sesuai access-control policy yang berlaku yang dapat melakukan Sample Collection. |
| Masih terdapat required sample yang belum terpenuhi | Status order tidak berubah menjadi `SampleCollected`. Order tetap dalam proses Sample Collection (partial) hingga seluruh required sample terpenuhi. |
| Penyimpanan pencatatan Sample Collection gagal | Status order tidak berubah menjadi `SampleCollected`. Order tetap pada status sebelumnya. |
| Pembatalan order setelah berstatus `SampleCollected` | Pembatalan ditolak. `SampleCollected` merupakan batas setelah order tidak dapat dibatalkan. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------| 
| AC-01 | Order Laboratorium yang memenuhi eligibility untuk Sample Collection dan memiliki seluruh required sample terpenuhi berhasil beralih status menjadi **`SampleCollected`** setelah pencatatan Sample Collection berhasil disimpan. | Completeness |
| AC-02 | Status `SampleCollected` hanya ditetapkan setelah **pencatatan Sample Collection berhasil tersimpan** oleh sistem. Jika penyimpanan gagal, status order tidak berubah. | Constraint |
| AC-03 | Pencatatan Sample Collection menyimpan informasi minimum: **Collected DateTime** dan **Collected By**. | Correctness |
| AC-04 | Sample Collection ditolak apabila Order Laboratorium tidak memenuhi eligibility (misal: masih berstatus `Ordered`). | Constraint |
| AC-05 | Sample Collection ditolak apabila Order Laboratorium berstatus `Cancelled`. | Constraint |
| AC-06 | Order Laboratorium yang telah berstatus `SampleCollected` tidak dapat dilakukan Sample Collection kembali melalui OC ini. | Constraint |
| AC-07 | Sample Collection dapat dilakukan secara partial/bertahap, namun status `SampleCollected` hanya ditetapkan setelah **seluruh** required sample dari pemeriksaan yang membutuhkan sample terpenuhi. | Correctness |
| AC-08 | Pemeriksaan dalam order yang tidak membutuhkan sample (berdasarkan Master Pemeriksaan Laboratorium) tidak memerlukan Sample Collection dan tidak menjadi blocker terhadap proses Sample Collection. | Boundary |
| AC-09 | Dalam mixed order (ada pemeriksaan dengan sample dan tanpa sample), Sample Collection hanya diperlukan untuk pemeriksaan yang membutuhkan sample. | Correctness |
| AC-10 | Pemeriksaan yang tidak membutuhkan sample dapat langsung dilanjutkan ke Result Management tanpa melalui tahapan Sample Collection. | Boundary |
| AC-11 | Order Laboratorium yang telah berstatus `SampleCollected` tidak dapat dibatalkan. | Constraint |
| AC-12 | Sample Collection hanya dapat dilakukan oleh actor yang memiliki kewenangan/permission sesuai access-control policy yang berlaku. | Correctness |
| AC-13 | Kebutuhan sample per pemeriksaan dikonsumsi dari Master Pemeriksaan Laboratorium; OC-08-04 tidak mendefinisikan atau mengelola required sample secara mandiri. | Boundary |
| AC-14 | OC-08-04 tidak mencatat detail teknis sampel seperti jenis spesimen, volume, kondisi, rejected/invalid, atau recollection. | Boundary |

---

## 10. Out of Scope

- Definisi dan pengelolaan kebutuhan sample per pemeriksaan → **Master Pemeriksaan Laboratorium**.
- Jenis/spesimen, wadah/tabung, volume, dan kondisi sample secara operasional → di luar scope OC-08-04.
- Rejected, invalid, insufficient sample, dan recollection → di luar scope OC-08-04.
- Sample processing, sample tracking, barcode/labeling sampel → di luar scope OC-08-04.
- Analyzer dan LIS processing → di luar scope OC-08-04.
- Pengelolaan aspek pembiayaan order laboratorium → **OC-08-03 Charge**.
- Pembuatan dan pemeliharaan Order Laboratorium → **OC-08-02 Order Laboratorium**.
- Pengelolaan hasil pemeriksaan laboratorium → **OC-08-05 Result Management**.

---

## 11. Business Decisions & Open Questions

### Confirmed Decisions

1. **Definisi Sample Collection:** Sample Collection adalah proses pengambilan dan pencatatan sample biologis pasien yang diperlukan untuk memproses satu atau lebih pemeriksaan laboratorium dalam suatu Laboratory Order.
2. **Outcome State:** Menghasilkan Order Laboratorium berstatus **`SampleCollected`**.
3. **Eligibility Default:** Secara default, Order Laboratorium berstatus `Charged` memenuhi eligibility untuk Sample Collection. Business rule lain yang secara eksplisit memperbolehkan Sample Collection juga diakui.
4. **Required Sample Source:** Kebutuhan sample ditentukan sepenuhnya oleh Master Pemeriksaan Laboratorium. OC-08-04 hanya mengonsumsi fakta tersebut.
5. **Partial Collection:** Sample Collection dapat dilakukan secara partial/bertahap. Status `SampleCollected` hanya ditetapkan setelah seluruh required sample terpenuhi.
6. **Examination Without Sample:** Pemeriksaan yang tidak membutuhkan sample tidak memerlukan Sample Collection dan dapat langsung dilanjutkan ke Result Management.
7. **Mixed Order:** Dalam order yang memiliki pemeriksaan dengan dan tanpa sample, Sample Collection hanya berlaku untuk pemeriksaan yang membutuhkan sample. Pemeriksaan tanpa sample bukan blocker.
8. **Collection Actor:** Sample Collection dilakukan oleh user yang memiliki kewenangan/permission sesuai access-control policy. OC-08-04 tidak mengunci pada role tertentu.
9. **Collection Record:** HIS mencatat informasi minimum: Collected DateTime dan Collected By. Detail teknis sample tidak dicatat di OC ini.
10. **Single Collection:** Sample Collection hanya dapat dilakukan satu kali untuk setiap Laboratory Order.
11. **Cancellation Boundary:** Order yang telah berstatus `SampleCollected` tidak dapat dibatalkan.
12. **Result Management Gateway:** Order/pemeriksaan yang membutuhkan sample dapat dilanjutkan ke Result Management setelah berstatus `SampleCollected`. Order/pemeriksaan yang tidak membutuhkan sample dapat langsung ke Result Management.
13. **Persistence Before Status:** Status `SampleCollected` hanya ditetapkan setelah pencatatan berhasil tersimpan. Kegagalan penyimpanan tidak mengubah status order.

### Open Questions

*Tidak ada Open Question yang belum terselesaikan. Seluruh business rule telah diputuskan secara definitif dan diintegrasikan ke dalam spesifikasi Outcome ini.*
