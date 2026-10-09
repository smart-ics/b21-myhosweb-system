# OUTCOME: Reg-Out

| Field       | Value        |
|-------------|--------------|
| Code        | OC-TRK-REG-OUT     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Ketika seluruh kewajiban finansial pasien atas satu episode kunjungan telah diselesaikan — baik melalui pembayaran, alokasi penjamin, maupun pemakaian deposit — rumah sakit harus mampu mengeksekusi dan mempersistensi penyelesaian administrasi kepulangan pasien yang dikenal sebagai **Reg-Out**.

Reg-Out adalah business fact yang membuktikan bahwa episode kunjungan pasien secara finansial dan administratif telah ditutup secara resmi: tagihan telah dilunasi atau diselesaikan sesuai ketentuan, sisa deposit (jika ada) telah diidentifikasi untuk dikembalikan, dan status kunjungan berubah menjadi **Selesai** sehingga tidak ada lagi aktivitas finansial yang dapat diposting ke episode tersebut.

Tanpa Reg-Out yang terpersistensi, kunjungan tetap dianggap aktif, kapasitas pelayanan tidak dapat dibebaskan (untuk rawat inap: tempat tidur tidak dapat dikembalikan ke pool tersedia), dan posisi piutang serta pendapatan rumah sakit tidak dapat ditentukan secara definitif.

---

## 2. Outcome Statement

Seluruh kewajiban finansial pasien atas episode kunjungan **telah diselesaikan dan administrasi kepulangan telah dieksekusi secara resmi, sehingga status kunjungan berubah menjadi Selesai, tagihan dinyatakan tertutup, dan sisa kewajiban maupun kelebihan pembayaran — termasuk sisa deposit — telah diidentifikasi dan tercatat sebagai dasar tindak lanjut yang diperlukan.**

---

## 3. Participating Domains

| Domain        | Role in this Outcome |
|---------------|----------------------|
| Tata Rekening | Pemilik utama: mengelola verifikasi penyelesaian tagihan, eksekusi Reg-Out, identifikasi sisa kewajiban dan kelebihan pembayaran (termasuk sisa deposit), serta perubahan status kunjungan menjadi Selesai |
| Admission     | Pemilik konteks kunjungan: menerima notifikasi Reg-Out untuk memperbarui status registrasi kunjungan menjadi Selesai dan membebaskan alokasi sumber daya (tempat tidur untuk rawat inap) |
| Kasir         | Eksekutor pembayaran terakhir: memproses pembayaran sisa kewajiban pasien (jika masih ada outstanding balance) dan/atau menerbitkan pembayaran keluar (disbursement) untuk kelebihan pembayaran yang harus dikembalikan kepada pasien |
| Pasien        | Subjek kepulangan: identitas pasien dan nomor registrasi kunjungan yang sah diperlukan untuk mengeksekusi Reg-Out |
| Rawat Inap    | Penerima notifikasi (untuk kunjungan rawat inap): membebaskan tempat tidur yang ditempati pasien setelah Reg-Out selesai, sehingga tempat tidur dapat kembali tersedia |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-PAYMENT` Payment | Tata Rekening | Known |
| `TRK-DEPOSIT` Deposit | Tata Rekening | Known |
| `TRK-KASIR` Kasir | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `RNA-BED` Pakai Bed | Rawat Inap | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Episode kunjungan pasien yang diidentifikasi dengan nomor registrasi yang valid telah berstatus **Selesai** dalam sistem.
- Tagihan kunjungan yang bersangkutan (OC-TRK-BILLING) telah berstatus **Final** sebelum Reg-Out dapat dieksekusi.
- Seluruh alokasi pembayaran (OC-TRK-ALOKASI-PEMBAYARAN) atas tagihan kunjungan telah dicatat dan saldo tagihan yang tersisa (outstanding balance) telah ditentukan secara definitif.
- Kondisi penyelesaian kewajiban finansial terdokumentasi secara eksplisit: **Lunas** (outstanding = 0), **Piutang** (outstanding > 0 dan diizinkan sesuai ketentuan, misalnya untuk tagihan penjamin yang belum diklaim), atau **Lebih Bayar** (outstanding < 0 yang menjadi dasar pengembalian ke pasien).
- Sisa deposit aktif pasien (jika ada) telah diidentifikasi pada saat Reg-Out dan tercatat sebagai dasar tindak lanjut — baik dikembalikan kepada pasien (refund), ditransfer ke kunjungan berikutnya (sesuai kebijakan), atau diproses sesuai prosedur yang berlaku.
- Tanggal dan waktu Reg-Out telah terpersistensi sebagai penanda resmi penutupan episode kunjungan.
- Tidak ada lagi posting item biaya baru, alokasi pembayaran baru, atau transaksi deposit baru yang dapat dilakukan terhadap kunjungan yang sudah di-Reg-Out, kecuali dengan otorisasi khusus melalui mekanisme koreksi yang terkontrol.

### 5.2 Required Recorded Information

**Identitas Reg-Out:**
- Nomor Reg-Out yang unik.
- Nomor registrasi kunjungan yang menjadi target Reg-Out.
- Identitas pasien (Nomor Rekam Medis, nama pasien).
- Jenis kunjungan: Rawat Jalan, IGD, atau Rawat Inap.
- Tanggal dan waktu Reg-Out dieksekusi.
- Petugas yang mengeksekusi Reg-Out.

**Status Penyelesaian Finansial:**
- Nomor tagihan kunjungan yang diselesaikan.
- Total nilai tagihan kunjungan (gross amount).
- Total nilai yang telah dialokasikan dari seluruh sumber pembayaran.
- Saldo tagihan yang tersisa (outstanding balance) pada saat Reg-Out.
- Status penyelesaian finansial: Lunas / Piutang / Lebih Bayar.
- Referensi alokasi pembayaran terakhir yang menghasilkan kondisi penyelesaian.

**Status Deposit saat Reg-Out:**
- Saldo deposit aktif pasien pada saat Reg-Out (jika pasien memiliki deposit).
- Tindak lanjut saldo deposit: Dikembalikan (Refund) / Ditransfer / Tidak Ada Saldo.
- Referensi transaksi tindak lanjut deposit (jika ada).

**Untuk Rawat Inap:**
- Nomor bed/kamar yang dibebaskan.
- Tanggal dan waktu bed dinyatakan kosong (checkout dari kamar).

### 5.3 Required Business Conditions

- Tagihan kunjungan harus berstatus **Final** (OC-TRK-BILLING) sebelum Reg-Out dapat dieksekusi; Reg-Out tidak dapat dilakukan terhadap tagihan yang masih berstatus Aktif.
- Seluruh alokasi pembayaran atas tagihan kunjungan harus telah dicatat (OC-TRK-ALOKASI-PEMBAYARAN) sebelum Reg-Out dieksekusi; outstanding balance harus dapat ditentukan secara definitif.
- Untuk kunjungan dengan status **Lunas** (outstanding = 0): Reg-Out dapat langsung dieksekusi.
- Untuk kunjungan dengan outstanding balance > 0 (**Piutang**): Reg-Out hanya dapat dieksekusi jika diizinkan secara eksplisit sesuai kebijakan rumah sakit (misalnya untuk tagihan penjamin yang sedang dalam proses klaim, atau atas otorisasi pejabat yang berwenang); sisa kewajiban harus tercatat sebagai piutang.
- Untuk kunjungan dengan outstanding balance < 0 (**Lebih Bayar**): Reg-Out hanya dapat dieksekusi setelah kelebihan pembayaran diidentifikasi dan tindak lanjutnya dicatat (pengembalian kepada pasien melalui kasir atau mekanisme lain yang berlaku).
- Sisa deposit aktif pasien pada saat Reg-Out harus diidentifikasi dan tindak lanjutnya ditetapkan; Reg-Out tidak dapat meninggalkan saldo deposit aktif tanpa kejelasan tindak lanjut.
- Setelah Reg-Out dikonfirmasi, status kunjungan berubah menjadi **Selesai** dan tidak dapat diubah kembali menjadi Aktif tanpa otorisasi reopening yang terkontrol.

### 5.4 Completion Proof

- Nomor Reg-Out yang unik telah diterbitkan dan terhubung ke nomor registrasi kunjungan yang benar.
- Status kunjungan dalam sistem Admission terpersistensi sebagai **Selesai**.
- Status tagihan kunjungan terpersistensi sebagai **Tertutup** (closed) setelah Reg-Out.
- Kondisi penyelesaian finansial (Lunas / Piutang / Lebih Bayar) tersaji dengan jelas berdasarkan data alokasi yang terdokumentasi.
- Untuk rawat inap: tempat tidur yang dibebaskan tercatat sebagai tersedia kembali di sistem Rawat Inap.
- Saldo deposit aktif pada saat Reg-Out dan tindak lanjutnya terdokumentasi.
- Tidak ada lagi item biaya baru yang dapat diposting atau alokasi pembayaran baru yang dapat dicatat terhadap kunjungan tersebut tanpa otorisasi reopening.

---

## 6. Outcome Boundary

### Start

Dimulai ketika tagihan kunjungan telah berstatus **Final** (OC-TRK-BILLING) dan petugas Tata Rekening memulai proses verifikasi penyelesaian finansial dengan tujuan mengeksekusi Reg-Out — yaitu mengonfirmasi bahwa seluruh kewajiban finansial pasien untuk episode kunjungan tersebut telah ditentukan kondisinya (Lunas, Piutang, atau Lebih Bayar) dan siap ditutup secara administratif.

### End

Berakhir ketika Reg-Out berhasil dieksekusi dan dikonfirmasi: status kunjungan berubah menjadi **Selesai**, tagihan dinyatakan **Tertutup**, kondisi penyelesaian finansial terdokumentasi, saldo deposit diidentifikasi dan tindak lanjutnya dicatat, serta — untuk rawat inap — tempat tidur pasien dinyatakan kosong dan tersedia kembali.

Kunjungan yang sudah dalam status **Selesai** tidak dapat menerima aktivitas finansial baru tanpa mekanisme reopening yang terkontrol dan berotorisasi.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Reg-Out hanya dapat dieksekusi terhadap kunjungan yang tagihannya berstatus **Final**; kunjungan dengan tagihan masih Aktif tidak boleh di-Reg-Out.
- Reg-Out hanya dapat dieksekusi setelah seluruh entri alokasi pembayaran yang diperlukan telah dicatat dan outstanding balance dapat ditentukan secara definitif.
- Kunjungan dengan outstanding balance > 0 hanya dapat di-Reg-Out dengan otorisasi eksplisit sesuai kebijakan yang berlaku; sisa kewajiban harus dicatat sebagai piutang yang terdokumentasi.
- Kunjungan dengan outstanding balance < 0 (lebih bayar) hanya dapat di-Reg-Out setelah kelebihan pembayaran teridentifikasi dan tindak lanjutnya ditetapkan.
- Sisa deposit aktif pasien pada saat Reg-Out tidak boleh diabaikan; tindak lanjut deposit harus terdokumentasi sebagai bagian dari proses Reg-Out.
- Setelah Reg-Out dikonfirmasi, tidak ada item biaya baru, alokasi pembayaran baru, atau transaksi deposit baru yang boleh dieksekusi terhadap kunjungan tersebut tanpa otorisasi reopening yang terkontrol.
- Setiap Reg-Out harus meninggalkan jejak audit lengkap: nomor Reg-Out, waktu eksekusi, petugas yang mengeksekusi, dan kondisi finansial saat penutupan.
- Untuk kunjungan rawat inap, pembebasan tempat tidur (bed release) merupakan bagian yang tidak terpisahkan dari penyelesaian Reg-Out; Reg-Out dianggap belum lengkap jika bed belum dibebaskan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Tagihan kunjungan belum berstatus Final | Reg-Out ditolak. Petugas Tata Rekening harus memastikan tagihan difinalisasi (OC-TRK-BILLING) terlebih dahulu sebelum Reg-Out dapat dieksekusi. |
| Outstanding balance > 0 tanpa otorisasi kepulangan berpiutang | Reg-Out ditangguhkan. Petugas harus mendapatkan otorisasi dari pejabat yang berwenang atau menyelesaikan sisa kewajiban terlebih dahulu melalui tambahan alokasi pembayaran (OC-TRK-ALOKASI-PEMBAYARAN). |
| Outstanding balance < 0 (lebih bayar) tanpa tindak lanjut yang ditetapkan | Reg-Out ditangguhkan hingga kelebihan pembayaran diidentifikasi dan tindak lanjutnya dicatat (dikembalikan ke pasien melalui kasir atau mekanisme lain yang berlaku). |
| Sisa deposit aktif pasien belum memiliki tindak lanjut yang jelas | Reg-Out tidak dapat dikonfirmasi tanpa kejelasan tindak lanjut deposit; petugas harus menetapkan apakah sisa deposit dikembalikan atau diproses sesuai kebijakan. |
| Masih terdapat item biaya dari unit pelayanan yang menunggu verifikasi sebelum tagihan Final | Tagihan tidak dapat difinalisasi dan Reg-Out tidak dapat dimulai. Unit pelayanan terkait harus menyelesaikan verifikasi terlebih dahulu (OC-TRK-BILLING). |
| Untuk rawat inap: bed belum dikosongkan secara fisik dan data sistem belum diperbarui | Proses Reg-Out berjalan namun pembebasan bed harus dikonfirmasi; tanpa konfirmasi bed release, tempat tidur tidak dapat ditawarkan kembali ke pasien lain. |
| Reg-Out dicoba dilakukan oleh petugas yang tidak berwenang | Eksekusi Reg-Out ditolak. Hanya petugas dengan otorisasi Reg-Out yang dapat mengeksekusi penutupan kunjungan. |
| Kunjungan sudah berstatus Selesai dan Reg-Out dicoba dieksekusi ulang | Duplikasi Reg-Out ditolak. Sistem harus mendeteksi bahwa kunjungan sudah dalam status Selesai dan mencegah eksekusi Reg-Out kedua tanpa otorisasi reopening. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Reg-Out memiliki nomor unik yang terhubung ke nomor registrasi kunjungan yang benar dan identitas pasien yang valid. | Completeness |
| AC-02 | Status kunjungan berubah menjadi **Selesai** setelah Reg-Out dikonfirmasi, dan perubahan ini terpersistensi dalam sistem Admission. | Correctness |
| AC-03 | Status tagihan kunjungan berubah menjadi **Tertutup** setelah Reg-Out dikonfirmasi, mencegah posting item biaya baru tanpa otorisasi reopening. | Correctness |
| AC-04 | Kondisi penyelesaian finansial (Lunas / Piutang / Lebih Bayar) tercatat dengan nilai outstanding balance yang benar pada saat Reg-Out. | Completeness |
| AC-05 | Reg-Out tidak dapat dieksekusi terhadap kunjungan dengan tagihan yang belum berstatus Final; percobaan menghasilkan penolakan. | Constraint |
| AC-06 | Reg-Out dengan outstanding balance > 0 hanya dapat dieksekusi dengan otorisasi eksplisit; tanpa otorisasi, Reg-Out ditolak. | Constraint |
| AC-07 | Reg-Out dengan outstanding balance < 0 (lebih bayar) hanya dapat dikonfirmasi setelah tindak lanjut kelebihan pembayaran ditetapkan dan tercatat. | Constraint |
| AC-08 | Sisa deposit aktif pasien pada saat Reg-Out teridentifikasi dan tindak lanjutnya tercatat; Reg-Out tidak dapat dikonfirmasi jika sisa deposit aktif tidak memiliki kejelasan tindak lanjut. | Constraint |
| AC-09 | Untuk kunjungan rawat inap: tempat tidur yang ditempati pasien dibebaskan dan statusnya berubah menjadi tersedia setelah Reg-Out dikonfirmasi. | Correctness |
| AC-10 | Setelah Reg-Out dikonfirmasi, percobaan posting item biaya baru atau alokasi pembayaran baru terhadap kunjungan tersebut ditolak oleh sistem tanpa otorisasi reopening. | Constraint |
| AC-11 | Jejak audit Reg-Out mencatat nomor Reg-Out, tanggal dan waktu eksekusi, petugas yang mengeksekusi, dan kondisi finansial saat penutupan. | Completeness |
| AC-12 | Duplikasi Reg-Out terhadap kunjungan yang sudah berstatus Selesai ditolak oleh sistem. | Exception |
| AC-13 | Reg-Out yang dieksekusi oleh petugas yang tidak berwenang ditolak oleh sistem. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembentukan dan konsolidasi rincian item biaya tagihan kunjungan — **OC-TRK-BILLING Rincian Tagihan Pasien**.
- Pencatatan alokasi sumber pembayaran terhadap tagihan kunjungan — **OC-TRK-ALOKASI-PEMBAYARAN Alokasi Pembayaran** (alokasi harus selesai sebelum Reg-Out dimulai, namun mekanisme alokasi adalah tanggung jawab OC-TRK-ALOKASI-PEMBAYARAN).
- Pengelolaan saldo deposit pasien dan mutasinya — **OC-TRK-DEPOSIT Deposit** (Reg-Out hanya mengidentifikasi saldo deposit yang tersisa dan menetapkan tindak lanjutnya; transaksi deposit itu sendiri dikelola oleh OC-TRK-DEPOSIT).
- Eksekusi pengembalian kelebihan pembayaran (disbursement refund) kepada pasien secara fisik di kasir — **OC-TRK-KASIR Kasir (Terima/Keluar Kas)** (Reg-Out mencatat kondisi Lebih Bayar, namun eksekusi fisik pengembalian uang adalah tanggung jawab Kasir).
- Eksekusi penutupan shift kasir dan rekonsiliasi kas — **OC-TRK-CLOSING-SHIFT Closing Shift**.
- Proses klaim elektronik ke BPJS (e-Klaim) untuk tagihan penjamin — **BPJS Domain** (`BPJ-EKLAIM`); Reg-Out hanya mencatat kondisi piutang penjamin, bukan proses klaim itu sendiri.
- Pencatatan tindak lanjut administratif rekam medis setelah kepulangan (coding, pengelolaan berkas) — **SC-04 Rekam Medis**.
- Rekonsiliasi dan pelaporan keuangan atas pendapatan dan piutang rumah sakit — domain Finance/Akuntansi (di luar scope MYHOSWEB saat ini).
- Manajemen tarif dan aturan manfaat penjamin — `TRK-TARIF` dan `TRK-JAMINAN`.
