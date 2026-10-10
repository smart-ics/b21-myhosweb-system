# OUTCOME: AntrianApotek

| Field       | Value        |
|-------------|--------------|
| Code        | OC-APT-ANTRIAN-APOTEK |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-10   |

---

## 1. Business Purpose

Rumah sakit harus mampu mengelola, mencatat, dan mengoordinasikan antrean pelayanan farmasi/apotek pasien secara tertib, transparan, dan terukur sebagai *persisted business fact*. Keberadaan antrean farmasi memastikan bahwa setiap pasien atau keluarga yang menunggu pelayanan obat (baik berasal dari resep rawat jalan, resep discharge rawat inap, resep instalasi gawat darurat, maupun pembelian obat bebas) memiliki nomor antrean yang sah, urutan pelayanan yang adil dan terkontrol, serta kepastian bahwa tiket antrean tersebut terpetakan secara akuntabel ke berkas permintaan obat yang bersangkutan.

Pencatatan antrean apotek yang persisten memungkinkan pemantauan waktu tunggu farmasi (*waiting time analytics*), koordinasi pemanggilan di loket farmasi, mitigasi risiko tertukarnya penyerahan obat antar pasien, serta pengelolaan penyelesaian administratif bagi pasien yang tidak hadir (*no-show*) tanpa mengacaukan integritas transaksi penyiapan obat fisik.

---

## 2. Outcome Statement

Tiket antrean farmasi pasien — baik diterbitkan secara mandiri di kiosk maupun melalui loket farmasi — **telah berstatus aktif dan terpetakan secara sah dengan permintaan obat pasien (`ResepKerja` atau `JualBebas`), memungkinkan progres pelayanan penyiapan obat dipantau dan pemanggilan serah obat dilakukan sesuai urutan layanan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Apotek** (Primary Owner) | Mengelola pemetaan antrean ke permintaan obat (`Outpatient Queue Mapping`), mengendalikan titik tolak operasional farmasi (`ServedAt` dan `DoneAt`), memanggil nomor antrean untuk penyerahan obat, dan mengeksekusi resolusi antrean (*Queue Close* / *No-Show Resolution*). |
| **Admission** | Bertindak sebagai otoritas infrastruktur antrean generik rumah sakit (`ADM-ANTRIAN`), menerbitkan nomor antrean, dan mengelola transisi siklus hidup entri antrean (`Waiting` → `In Service` → `Done` / `Withdrawn`). |
| **Pasien** | Menyediakan identitas pasien yang sah (`PAS-DATSOS`) sebagai subjek penerima layanan farmasi. |
| **Admission / Pelayanan** | Menyediakan konteks registrasi kunjungan aktif pasien (`ADM-REG`) untuk keperluan pemetaan antrean otomatis (*Tracker Mapping*). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `APT-QUEUE` Antrian Apotek | Apotek | Known |
| `ADM-ANTRIAN` Antrian Registrasi | Admission | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `APT-RESEP` Resep | Apotek | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Tiket antrean farmasi telah diterbitkan dengan nomor urut yang unik untuk unit depo farmasi dan tanggal pelayanan yang bersangkutan.
- Tiket antrean farmasi telah terasosiasi (*Outpatient Queue Mapping*) dengan tepat satu atau lebih permintaan obat yang sah milik pasien: `ResepKerja` (salinan operasional resep) atau `JualBebas` (permintaan obat bebas).
- Entri antrean farmasi dikelola di bawah siklus hidup antrean generik (`Waiting` → `In Service` → `Done` / `Withdrawn`) sesuai ketetapan arsitektur antrean (`ADR-APT-001`).
- Status antrean farmasi mencatat bukti awal pelayanan (*Pharmacy Service Start Evidence*): transisi ke `In Service` dan pencatatan timestamp `ServedAt` terjadi saat penyiapan obat pertama dimulai (*Medication Preparation Started*).
- Status antrean farmasi mencatat bukti penyelesaian layanan: transisi ke `Done` dan pencatatan timestamp `DoneAt` dipicu saat petugas melakukan panggilan serah obat terkoordinasi (*Pickup Call*) atau saat resolusi *No-Show* dieksekusi.

### 5.2 Required Recorded Information

- Nomor urut dan kode display tiket antrean farmasi (contoh: `A-042`).
- Referensi identitas tiket antrean kanonikal (`QueueEntryId`) pada otoritas antrean.
- Tanggal dan waktu penerbitan nomor antrean (`CreatedAt`).
- Referensi identitas pasien (`PasienId`) dan nama pasien (jika sudah teridentifikasi).
- Referensi dokumen permintaan obat yang dipetakan (`ResepKerjaId` atau `JualBebasId`).
- Metode pemetaan yang digunakan:
  - **Tracker Mapping**: Asosiasi otomatis berbasis kunjungan aktif atau bukti pendaftaran.
  - **Manual Mapping**: Asosiasi manual oleh staf farmasi di loket penerimaan.
- Waktu mulai pelayanan peracikan (`ServedAt`).
- Waktu penyelesaian antrean (`DoneAt`) atau waktu penarikan antrean (`WithdrawnAt`).
- Identitas petugas farmasi yang melakukan pemanggilan atau pemetaan.

### 5.3 Required Business Conditions

- Sesuai `ADR-APT-001`, status operasional internal peracikan farmasi (`Preparing`, `Prepared`, `Reviewed`, `Completed`, dsb.) **tidak boleh ditambahkan ke dalam enum status antrean generik (`AntrianStatusEnum`)**. Siklus antrean pada tabel antrean murni merepresentasikan posisi antrean fisik (`Waiting`, `In Service`, `Done`, `Withdrawn`).
- Pemetaan antrean farmasi (`Outpatient Queue Mapping`) **hanya boleh menargetkan sumber permintaan awal (`ResepKerja` atau `JualBebas`)**, dan dilarang memetakan langsung ke `SalesOrder`, `Invoice`, atau `Dispensing`.
- Satu tiket antrean farmasi diperbolehkan memetakan lebih dari satu resep/permintaan obat untuk pasien yang sama dalam satu episode kunjungan, tanpa menggabungkan dokumen `SalesOrder`, `Invoice`, atau `Dispensing` dari masing-masing resep tersebut.
- Pemanggilan antrean untuk penyerahan obat (*Coordinated Pickup Call*) hanya boleh dilakukan setelah seluruh pesanan dispensing yang ditujukan untuk penyerahan tersebut telah mencapai status siap serah (`Prepared`) atau telah menerima keputusan terminasi pengecualian yang akuntabel.
- Penutupan antrean farmasi yang tidak dilanjutkan (*Pharmacy Queue Close*) dari status `Waiting` wajib mencatat alasan penutupan resmi dan meminta status `Withdrawn` pada otoritas antrean tanpa mencatat `ServedAt` atau `DoneAt`.

### 5.4 Completion Proof

- Entri antrean farmasi aktif dapat ditemukan pada worklist loket penerimaan dan worklist serah obat farmasi.
- Tampilan display antrean farmasi menampilkan pemanggilan nomor tiket yang bersangkutan.
- Riwayat entri antrean mencatat timestamp `DoneAt` yang permanen setelah pemanggilan serah obat atau eksekusi resolusi no-show berhasil dilakukan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika pasien mengambil nomor antrean farmasi di kiosk/loket antrean atau ketika sistem pendaftaran/pelayanan menerbitkan tiket antrean farmasi untuk kunjungan tersebut, dan entri antrean berhasil disimpan dengan status awal `Waiting`.

### End

Berakhir ketika:
1. Petugas farmasi memanggil nomor antrean untuk penyerahan obat yang telah selesai disiapkan, mencatat timestamp `DoneAt`, dan mengubah status antrean menjadi `Done`; **atau**
2. Petugas farmasi mengeksekusi resolusi *No-Show* (pasien tidak hadir) sebelum panggilan serah obat, yang menandai antrean menjadi `Done` dengan timestamp `DoneAt`; **atau**
3. Petugas farmasi mencatat *Pharmacy Queue Close* sebelum pelayanan obat dimulai, yang mengubah status antrean menjadi `Withdrawn`.

> Tiket antrean farmasi bersifat harian: nomor urut berlaku spesifik pada tanggal pelayanan dan depo farmasi terkait.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Nomor urut tiket antrean harus unik dalam lingkup tanggal pelayanan dan depo farmasi terkait.
- Pemetaan tiket antrean ke resep bersifat *update-in-place*: jika petugas salah memetakan resep, koreksi dilakukan langsung pada tautan pemetaan aktif tanpa memerlukan pencatatan riwayat perubahan terpisah.
- Kedatangan pasien dan penerbitan tiket antrean farmasi **bukan merupakan prasyarat mutlak untuk pelaksanaan telaah resep klinis (`OC-APT-TELAAH-RESEP`)**. Apoteker berhak melakukan telaah resep segera setelah resep elektronik tersedia di sistem, mendahului kedatangan fisik pasien di apotek.
- Nilai timestamp `DoneAt` yang sudah tercatat pada tiket antrean **tidak boleh dibatalkan atau dibalikkan (*never reversed*)**, bahkan jika obat kemudian dinyatakan *No-Show* atau dikembalikan ke stok.
- Tiket antrean farmasi yang telah berstatus `Done` atau `Withdrawn` tidak dapat diaktifkan kembali. Pelayanan baru memerlukan tiket antrean baru.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|---|---|
| Pemetaan otomatis (*Tracker Mapping*) gagal menemukan resep aktif | Antrean tetap berstatus `Waiting` dalam kondisi belum terpetakan (*Unmapped*). Sistem mengarahkan staf farmasi untuk melakukan pencarian dan *Manual Mapping*. |
| Resep dokter yang dipetakan ditolak secara total pada telaah resep (*Rejected*) | Tiket antrean farmasi tidak dapat diproses ke tahap peracikan. Petugas memberikan penjelasan kepada pasien dan melakukan *Pharmacy Queue Close* dengan alasan telaah ditolak. |
| Pasien tidak hadir di loket farmasi setelah antrean diterbitkan (*Abandoned in Waiting*) | Petugas farmasi mencatat *Pharmacy Queue Close* dengan alasan pasien tidak hadir. Otoritas antrean menandai tiket sebagai `Withdrawn`. |
| Pasien tidak merespons saat dipanggil serah obat (*No-Show*) | Obat tetap disimpan di *Dispensing Temporary Custody*. Tiket antrean tetap mencatat `DoneAt` saat panggilan serah obat telah dilakukan. Penyelesaian obat yang tidak diambil diproses melalui prosedur *No-Show Resolution* setelah jendela waktu tunggu (*Collection Window*) terlampaui. |
| Gangguan teknis pada display antrean farmasi | Sistem antrean tetap mencatat status operasional data secara persisten; pemanggilan fisik dilakukan secara manual oleh petugas loket sesuai urutan nomor tiket. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Tiket antrean farmasi yang diterbitkan tercatat dengan tanggal, nomor urut, dan status awal `Waiting`. | Completeness |
| AC-02 | Tiket antrean farmasi dapat dipetakan secara sah ke dokumen `ResepKerja` atau `JualBebas` melalui Tracker Mapping atau Manual Mapping. | Correctness |
| AC-03 | Satu tiket antrean farmasi dapat memetakan lebih dari satu resep aktif milik pasien yang sama tanpa menggabungkan Sales Order atau Dispensing masing-masing. | Completeness |
| AC-04 | Transisi status antrean generik tidak mengandung status peracikan internal farmasi (*Preparing*, *Prepared*, dsb.) sesuai `ADR-APT-001`. | Constraint |
| AC-05 | Saat peracikan obat pertama dimulai (*Medication Preparation Started*), tiket antrean farmasi secara otomatis mencatat `ServedAt` dan bertransisi ke `In Service`. | Correctness |
| AC-06 | Saat panggilan serah obat dilakukan, tiket antrean farmasi secara otomatis mencatat `DoneAt` dan bertransisi ke `Done`. | Correctness |
| AC-07 | Staf farmasi dapat melakukan *Pharmacy Queue Close* dari status `Waiting` dengan menyertakan alasan penutupan wajib, menghasilkan status antrean `Withdrawn`. | Exception |
| AC-08 | Timestamp `DoneAt` yang telah tercatat tidak dapat dibalikkan atau dihapus saat proses resolusi *No-Show* dieksekusi. | Constraint |
| AC-09 | Sistem menolak upaya pemetaan tiket antrean farmasi secara langsung ke dokumen `SalesOrder`, `Invoice`, atau `Dispensing`. | Constraint |
| AC-10 | Worklist farmasi mampu menyajikan daftar antrean pasien secara berurutan beserta status pemetaan resep dan progres peracikan obatnya. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penerbitan tiket antrean pendaftaran loket umum dan antrean poliklinik rawat jalan → **`OC-ADM-ANTRIAN` (Antrian)**.
- Penelaahan profesional administratif, farmasetik, dan klinis atas resep → **`OC-APT-TELAAH-RESEP` (TelaahResep)**.
- Penyiapan fisik, peracikan, telaah akhir, dan penyerahan obat → **`OC-APT-ORDER-DISPENSING` (OrderDispensing)**.
- Pembentukan tagihan komersial penjualan obat → **`OC-APT-PENJUALAN` (Penjualan)**.
- Pelacakan seluruh tahapan perjalanan pasien di rumah sakit secara makro → **`OC-ADM-PASIEN-TRACKER` (PasienTracker)**.
- Desain arsitektur fisik mesin cetak nomor antrean, layar TV display, atau sistem pemanggil suara (*voice synthesizer*) → Tanggung jawab teknis infrastruktur.
