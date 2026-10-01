# OUTCOME: Deposit

| Field       | Value        |
|-------------|--------------|
| Code        | OC-02-03     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu menerima, mencatat, dan memelihara uang titipan pasien — yang dikenal sebagai **deposit** — sebagai jaminan finansial yang dipegang rumah sakit selama episode perawatan, khususnya rawat inap. Deposit memastikan bahwa ada sumber dana yang tersedia untuk menutup kewajiban finansial pasien apabila tagihan kunjungan sudah difinalisasi.

Saldo deposit yang terpersistensi secara benar merupakan business fact yang memungkinkan pemakaian deposit sebagai salah satu sumber pembayaran dalam proses Alokasi Pembayaran (OC-02-02), sekaligus menjadi dasar perhitungan kelebihan deposit yang dikembalikan kepada pasien melalui proses Refund (OC-02-04).

Tanpa deposit yang terbentuk dan terpelihara secara akurat, tidak ada kepastian tentang ketersediaan dana jaminan pasien, dan pemakaian deposit sebagai sumber pembayaran tidak dapat dilakukan.

---

## 2. Outcome Statement

Uang jaminan yang diserahkan pasien atau keluarga kepada rumah sakit **telah diterima, dicatat, dan terpersistensi sebagai saldo deposit aktif atas nama pasien yang bersangkutan, sehingga saldo tersebut dapat digunakan sebagai sumber pembayaran terhadap tagihan kunjungan atau dikembalikan sebagai refund jika terdapat kelebihan.**

---

## 3. Participating Domains

| Domain        | Role in this Outcome |
|---------------|----------------------|
| Tata Rekening | Pemilik utama: mengelola penerimaan, pencatatan, dan pemeliharaan saldo deposit pasien, termasuk mutasi deposit akibat penerimaan setoran, pemakaian, dan pengembalian |
| Kasir         | Eksekutor penerimaan: menerima uang deposit secara fisik dari pasien atau keluarga dan mengonfirmasi transaksi penerimaan ke Tata Rekening untuk dicatat sebagai saldo deposit |
| Admission     | Menyediakan konteks kunjungan (nomor registrasi, jenis kunjungan) yang mengikat deposit kepada episode perawatan yang tepat |
| Pasien        | Subjek deposit: identitas pasien menentukan kepemilikan saldo deposit dan kunjungan mana yang diasosiasikan |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `TRK-DEPOSIT` Deposit | Tata Rekening | Known |
| `TRK-KASIR` Kasir | Tata Rekening | Known |
| `TRK-PAYMENT` Payment | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Saldo deposit atas nama pasien yang teridentifikasi telah terbentuk dan tercatat dalam sistem dengan nilai yang mencerminkan jumlah uang yang diterima.
- Setiap penerimaan setoran deposit (top-up) menghasilkan penambahan saldo deposit yang dapat diverifikasi.
- Setiap pemakaian deposit terhadap tagihan kunjungan menghasilkan pengurangan saldo deposit yang konsisten dan terhubung ke alokasi pembayaran yang bersangkutan (OC-02-02).
- Setiap pengembalian deposit kepada pasien (refund) menghasilkan pengurangan saldo deposit yang konsisten dan terhubung ke transaksi refund (OC-02-04).
- Saldo deposit yang tersisa (saldo aktif) selalu dapat dihitung dan diverifikasi kapan saja, mencerminkan keadaan aktual setelah semua mutasi yang terjadi.
- Deposit terhubung ke kunjungan atau pasien yang tepat, sehingga pemakaian deposit hanya dapat dilakukan terhadap tagihan kunjungan yang relevan.

### 5.2 Required Recorded Information

**Identitas Deposit:**
- Nomor deposit yang unik.
- Nomor registrasi kunjungan yang menjadi konteks deposit (jika deposit dikaitkan dengan kunjungan tertentu).
- Identitas pasien (Nomor Rekam Medis, nama pasien).
- Tanggal dan waktu deposit dibentuk.
- Status deposit: Aktif / Habis Terpakai / Dikembalikan / Dibatalkan.

**Detail Setiap Mutasi Deposit:**
- Jenis mutasi: Setoran (penerimaan), Pemakaian (penggunaan untuk tagihan), Pengembalian (refund), atau Koreksi.
- Nilai mutasi.
- Saldo deposit sebelum dan sesudah mutasi.
- Referensi transaksi: nomor transaksi kasir (untuk setoran), nomor alokasi pembayaran (untuk pemakaian), nomor transaksi refund (untuk pengembalian).
- Tanggal efektif mutasi.
- Petugas yang mencatat mutasi.

**Ringkasan Saldo Deposit:**
- Total nilai deposit yang pernah diterima (total setoran kumulatif).
- Total nilai deposit yang sudah terpakai (terhadap tagihan kunjungan).
- Total nilai deposit yang sudah dikembalikan (refund).
- Saldo deposit aktif yang tersisa (saldo yang dapat digunakan).

### 5.3 Required Business Conditions

- Deposit hanya dapat dikaitkan dengan pasien yang terdaftar dan teridentifikasi dalam sistem; deposit tidak dapat dibentuk tanpa identitas pasien yang valid.
- Setiap setoran deposit harus memiliki referensi transaksi penerimaan dari kasir yang sah; setoran tanpa referensi transaksi kasir tidak dapat menghasilkan saldo deposit.
- Pemakaian deposit hanya dapat dilakukan jika saldo deposit aktif pasien mencukupi; pemakaian tidak dapat melebihi saldo yang tersedia.
- Pemakaian deposit hanya dapat dilakukan untuk menutup tagihan kunjungan yang terhubung ke pasien yang bersangkutan; deposit satu pasien tidak dapat digunakan untuk tagihan pasien lain.
- Setiap mutasi deposit harus menghasilkan saldo aktual yang selalu konsisten dengan perhitungan kumulatif seluruh mutasi sebelumnya.
- Pengembalian deposit (refund) hanya dapat dilakukan terhadap saldo deposit aktif yang tersisa setelah seluruh kewajiban kunjungan diselesaikan, atau atas kelebihan deposit yang tidak terpakai.
- Pembatalan atau koreksi mutasi deposit hanya dapat dilakukan oleh petugas yang memiliki otorisasi, dan harus meninggalkan jejak audit yang lengkap.

### 5.4 Completion Proof

- Saldo deposit aktif atas nama pasien telah terbentuk dan memiliki nilai yang mencerminkan seluruh setoran yang diterima dikurangi seluruh pemakaian dan pengembalian yang terjadi.
- Setiap mutasi deposit memiliki nomor referensi unik dan dapat ditelusuri ke transaksi sumber (kasir, alokasi pembayaran, atau refund).
- Saldo deposit dapat ditampilkan dan diverifikasi kapan saja berdasarkan identitas pasien atau nomor deposit.
- Saldo deposit yang aktif dapat dijadikan sumber pembayaran dalam proses Alokasi Pembayaran (OC-02-02).
- Saldo deposit yang tersisa setelah tagihan terselesaikan dapat dijadikan dasar proses Refund (OC-02-04).

---

## 6. Outcome Boundary

### Start

Dimulai ketika pasien atau keluarga menyerahkan uang jaminan kepada kasir rumah sakit dan kasir mengonfirmasi penerimaan uang tersebut — menghasilkan transaksi penerimaan kasir yang sah sebagai dasar pembentukan saldo deposit.

Untuk rawat inap, deposit umumnya diterima pada saat atau segera setelah pasien terdaftar dan ditempatkan di bangsal. Namun secara bisnis, deposit dapat diterima kapan saja selama episode kunjungan aktif, termasuk top-up tambahan jika saldo awal tidak mencukupi.

### End

Berakhir ketika saldo deposit pasien mencapai nilai nol — baik karena seluruh saldo terpakai untuk melunasi tagihan kunjungan (melalui OC-02-02 Alokasi Pembayaran), maupun karena saldo yang tersisa telah dikembalikan kepada pasien melalui proses Refund (OC-02-04).

Deposit yang tidak diklaim setelah kunjungan selesai tetap tercatat sebagai saldo aktif sampai diproses secara eksplisit.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Saldo deposit harus selalu mencerminkan nilai aktual berdasarkan seluruh mutasi yang terjadi — tidak boleh ada inkonsistensi antara riwayat mutasi dan saldo aktif yang ditampilkan.
- Setiap setoran deposit harus memiliki referensi transaksi kasir yang terverifikasi; saldo deposit tidak dapat ditambah tanpa bukti penerimaan kas yang sah.
- Pemakaian deposit tidak boleh melebihi saldo deposit aktif pasien; saldo negatif tidak diperbolehkan.
- Deposit satu pasien tidak dapat digunakan untuk membayar tagihan pasien lain; kepemilikan deposit bersifat per-pasien.
- Setiap mutasi deposit harus meninggalkan jejak audit lengkap yang mencatat jenis mutasi, nilai, saldo sebelum, saldo sesudah, referensi transaksi, dan petugas yang mencatat.
- Pembatalan atau koreksi atas mutasi deposit yang sudah terjadi hanya dapat dilakukan oleh petugas yang memiliki otorisasi khusus; koreksi harus menghasilkan pemulihan saldo secara konsisten.
- Deposit yang terkait dengan kunjungan yang sudah di-Reg-Out tidak dapat digunakan kembali untuk kunjungan lain secara otomatis; sisa deposit pasca Reg-Out harus diproses melalui mekanisme Refund atau transfer deposit yang eksplisit.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Identitas pasien tidak ditemukan atau tidak valid | Deposit tidak dapat dibentuk. Petugas harus memastikan pasien terdaftar dalam sistem (OC-04-01 Data Sosial Pasien) sebelum deposit dapat dicatat. |
| Transaksi penerimaan kasir tidak valid atau tidak dikonfirmasi | Saldo deposit tidak dapat ditambah. Petugas kasir harus memastikan transaksi penerimaan dikonfirmasi dengan bukti yang sah sebelum saldo deposit diperbarui. |
| Pemakaian deposit melebihi saldo aktif yang tersedia | Pemakaian ditolak. Petugas harus menggunakan nilai pemakaian yang tidak melebihi saldo tersedia, dengan selisih kewajiban dipenuhi dari sumber pembayaran lain. |
| Pasien tidak memiliki saldo deposit aktif saat pemakaian diminta | Pemakaian deposit tidak dapat dilakukan. Petugas harus melakukan setoran deposit terlebih dahulu, atau menggunakan sumber pembayaran lain yang tersedia. |
| Refund deposit diminta namun tagihan kunjungan belum terselesaikan | Pengembalian deposit ditangguhkan hingga tagihan diselesaikan dan saldo deposit yang benar-benar tersisa dapat ditentukan (OC-02-02 Alokasi Pembayaran harus selesai terlebih dahulu). |
| Koreksi atau pembatalan mutasi deposit dilakukan oleh petugas yang tidak berwenang | Koreksi ditolak. Hanya petugas dengan otorisasi khusus yang dapat melakukan koreksi atau pembatalan mutasi deposit. |
| Deposit coba dilakukan untuk kunjungan yang sudah di-Reg-Out dan diselesaikan | Setoran deposit baru untuk kunjungan yang sudah selesai ditolak. Petugas harus memproses melalui mekanisme yang sesuai (misalnya kunjungan baru atau proses khusus). |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------| 
| AC-01 | Saldo deposit aktif atas nama pasien terbentuk setelah setoran dikonfirmasi, dengan nomor deposit unik dan referensi transaksi kasir yang valid. | Completeness |
| AC-02 | Nilai saldo deposit aktif sesuai dengan total setoran kumulatif dikurangi total pemakaian dan total pengembalian yang sudah terjadi. | Correctness |
| AC-03 | Setiap mutasi deposit (setoran, pemakaian, pengembalian) mencatat jenis mutasi, nilai, saldo sebelum, saldo sesudah, referensi transaksi sumber, dan petugas yang mencatat. | Completeness |
| AC-04 | Saldo deposit dapat ditemukan dan ditampilkan berdasarkan identitas pasien atau nomor deposit kapan saja. | Correctness |
| AC-05 | Setoran deposit tanpa referensi transaksi kasir yang terverifikasi ditolak dan tidak menghasilkan perubahan saldo. | Constraint |
| AC-06 | Pemakaian deposit tidak dapat melebihi saldo deposit aktif pasien; percobaan pemakaian melebihi saldo menghasilkan penolakan. | Constraint |
| AC-07 | Deposit satu pasien tidak dapat digunakan untuk tagihan pasien lain; percobaan pemakaian lintas pasien menghasilkan penolakan. | Constraint |
| AC-08 | Setiap pemakaian deposit terhubung ke entri Alokasi Pembayaran (OC-02-02) yang valid dan menghasilkan pengurangan saldo yang konsisten. | Correctness |
| AC-09 | Saldo deposit yang tersisa setelah tagihan diselesaikan dapat dijadikan dasar proses Refund (OC-02-04). | Correctness |
| AC-10 | Koreksi atau pembatalan mutasi deposit hanya dapat dilakukan oleh petugas yang berwenang; percobaan oleh petugas yang tidak berwenang ditolak. | Constraint |
| AC-11 | Setiap koreksi atau pembatalan mutasi deposit menghasilkan pemulihan saldo yang konsisten dan menyimpan jejak audit lengkap. | Constraint |
| AC-12 | Riwayat seluruh mutasi deposit dapat ditelusuri secara kronologis dari setoran pertama hingga status saldo terkini. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penerimaan pembayaran tunai/non-tunai di loket kasir untuk keperluan selain deposit — **OC-03-02 Pembayaran** dan `TRK-KASIR`.
- Pembentukan dan konsolidasi rincian item biaya tagihan kunjungan — **OC-02-01 Rincian Tagihan Pasien**.
- Pencatatan alokasi deposit terhadap tagihan kunjungan sebagai sumber pembayaran — **OC-02-02 Alokasi Pembayaran** (deposit digunakan sebagai sumber dalam alokasi, tetapi mekanisme alokasi itu sendiri adalah milik OC-02-02).
- Proses pengembalian kelebihan deposit kepada pasien — **OC-02-04 Refund** (OC-02-03 hanya memastikan saldo deposit tersedia; proses refund adalah tanggung jawab OC-02-04).
- Penyelesaian administrasi kepulangan pasien — **OC-02-05 Reg-Out**.
- Pengelolaan voucher pembayaran yang diterbitkan rumah sakit — `TRK-VOUCHER`.
- Pengelolaan master jaminan dan aturan manfaat penjamin — `TRK-JAMINAN`.
- Klaim ke BPJS melalui e-Klaim — **BPJS Domain** (`BPJ-EKLAIM`).
- Rekonsiliasi dan pelaporan keuangan atas uang deposit — domain Finance/Akuntansi (di luar scope MYHOSWEB saat ini).
- Closing shift kasir dan rekonsiliasi kas harian — **OC-03-03 Closing Shift**.
