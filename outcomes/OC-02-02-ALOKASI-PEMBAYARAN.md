# OUTCOME: Alokasi Pembayaran

| Field       | Value        |
|-------------|--------------|
| Code        | OC-02-02     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Setelah tagihan kunjungan pasien berstatus **Final** (OC-02-01), rumah sakit harus mampu mencatat dan mempersistensi seluruh alokasi pembayaran yang digunakan untuk melunasi atau mengurangi saldo tagihan tersebut — baik yang berasal dari pembayaran tunai/non-tunai oleh pasien, klaim kepada penjamin (BPJS, asuransi swasta, atau jaminan lain), maupun pemakaian deposit yang sudah ada.

Alokasi Pembayaran merupakan business fact yang membuktikan bagaimana kewajiban finansial pasien terhadap tagihan kunjungan diselesaikan: setiap sumber dana yang digunakan untuk menutup tagihan harus tercatat secara eksplisit, terhubung ke tagihan yang bersangkutan, dan menghasilkan saldo tagihan yang selalu dapat diverifikasi kapan saja.

Tanpa Alokasi Pembayaran yang terpersistensi secara benar, proses Reg-Out (OC-02-05) tidak dapat diselesaikan, dan posisi piutang rumah sakit tidak dapat ditentukan secara akurat.

---

## 2. Outcome Statement

Seluruh sumber pembayaran yang digunakan untuk menutup tagihan kunjungan pasien — baik dari pembayaran kasir, pemakaian deposit, maupun klaim penjamin — **telah dialokasikan, tercatat, dan terpersistensi terhadap tagihan yang dimaksud, sehingga saldo tagihan yang tersisa dapat ditentukan dan diverifikasi sebagai dasar penyelesaian administrasi kepulangan**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome |
|---------------|----------------------|
| Tata Rekening | Pemilik utama: mengelola pencatatan dan persistensi seluruh alokasi pembayaran terhadap tagihan pasien, serta memelihara saldo tagihan yang tersisa |
| Kasir         | Sumber pembayaran: mengeksekusi penerimaan pembayaran tunai/non-tunai dari pasien dan mengirimkan konfirmasi pembayaran ke Tata Rekening untuk dialokasikan |
| Admission     | Menyediakan konteks kunjungan (nomor registrasi, jenis kunjungan) yang menghubungkan alokasi pembayaran ke episode yang tepat |
| Pasien        | Subjek kewajiban finansial: identitas pasien menentukan tagihan mana yang menjadi target alokasi |
| Jaminan/BPJS  | Sumber pembayaran penjamin: klaim yang disetujui oleh penjamin (BPJS atau asuransi) merupakan alokasi pembayaran yang mengurangi porsi tagihan penjamin |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-ALOKASI` Alokasi Pembayaran | Tata Rekening | Known |
| `TRK-DEPOSIT` Deposit | Tata Rekening | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `KSR-PEMBAYARAN` Penerimaan Pembayaran | Kasir | Known |
| `KSR-ORDER` Order Bayar | Kasir | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Setiap sumber pembayaran yang digunakan untuk menutup tagihan kunjungan telah terdaftar sebagai satu entri alokasi yang terhubung ke nomor tagihan yang bersangkutan.
- Total nilai yang dialokasikan dari semua sumber pembayaran dapat dihitung dan ditampilkan sebagai angka yang dapat diverifikasi.
- Saldo tagihan yang tersisa (outstanding balance) — yaitu selisih antara porsi kewajiban pasien dan total nilai yang sudah dialokasikan — terhitung dengan benar dan selalu mencerminkan keadaan aktual.
- Setiap entri alokasi mencatat dengan jelas sumber dananya: pembayaran kasir (tunai/non-tunai), pemakaian deposit, atau klaim penjamin (BPJS/asuransi).
- Alokasi yang berasal dari pembayaran kasir terhubung ke transaksi pembayaran yang sah dari modul Kasir.
- Alokasi yang berasal dari pemakaian deposit terhubung ke saldo deposit pasien yang berlaku dan mengurangi saldo deposit secara konsisten.
- Alokasi yang berasal dari klaim penjamin terhubung ke jenis jaminan yang terdaftar pada kunjungan dan dibatasi maksimal sebesar porsi yang ditanggung penjamin.

### 5.2 Required Recorded Information

**Identitas Alokasi:**
- Nomor alokasi yang unik.
- Nomor tagihan kunjungan yang menjadi target alokasi.
- Nomor registrasi kunjungan yang bersangkutan.
- Identitas pasien (Nomor Rekam Medis, nama pasien).
- Tanggal dan waktu alokasi dicatat.
- Status alokasi (Aktif / Dibatalkan).

**Detail Setiap Entri Alokasi:**
- Sumber pembayaran: Kasir (tunai / non-tunai / metode pembayaran tertentu), Deposit, atau Penjamin (BPJS / Asuransi / Jaminan lain).
- Nilai yang dialokasikan dari sumber tersebut.
- Referensi transaksi sumber: nomor transaksi kasir, atau nomor referensi klaim penjamin, atau nomor referensi pemakaian deposit.
- Tanggal efektif alokasi.
- Petugas yang mencatat alokasi.

**Ringkasan Alokasi terhadap Tagihan:**
- Total nilai yang telah dialokasikan dari seluruh sumber.
- Perincian alokasi per sumber pembayaran (kasir, deposit, penjamin).
- Saldo tagihan yang tersisa (outstanding balance) setelah semua alokasi diterapkan.
- Status pelunasan: Lunas (outstanding = 0), Sebagian Terbayar (outstanding > 0), atau Lebih Bayar (outstanding < 0).

### 5.3 Required Business Conditions

- Tagihan yang menjadi target alokasi harus berstatus **Final** (OC-02-01); alokasi tidak dapat dilakukan terhadap tagihan yang masih berstatus Aktif atau Dibatalkan.
- Total nilai yang dialokasikan dari seluruh sumber tidak boleh melebihi total kewajiban yang tersisa pada tagihan, kecuali dalam kondisi yang secara eksplisit diizinkan (kelebihan bayar yang menghasilkan status Lebih Bayar dan berpotensi menjadi refund).
- Alokasi dari sumber Deposit hanya dapat dilakukan jika pasien memiliki saldo deposit yang cukup; alokasi tidak dapat melebihi saldo deposit yang tersedia.
- Alokasi dari sumber Penjamin hanya dapat dilakukan terhadap porsi tagihan yang memang ditanggung oleh penjamin tersebut, sesuai aturan manfaat yang berlaku; alokasi penjamin tidak dapat melebihi porsi penjamin yang tercatat pada tagihan.
- Setiap entri alokasi dari kasir harus memiliki referensi transaksi kasir yang sah dan terverifikasi; alokasi tanpa referensi transaksi yang valid tidak dapat disimpan.
- Pembatalan entri alokasi hanya dapat dilakukan oleh petugas yang berwenang dan harus menghasilkan pemulihan saldo tagihan secara konsisten.

### 5.4 Completion Proof

- Setiap sumber pembayaran yang digunakan terhadap tagihan memiliki entri alokasi yang terdaftar dengan nomor unik dan referensi transaksi sumber yang valid.
- Total nilai yang dialokasikan dapat dihitung dan saldo tagihan yang tersisa (outstanding balance) tersaji dengan benar.
- Status pelunasan tagihan (Lunas / Sebagian Terbayar / Lebih Bayar) dapat ditentukan berdasarkan data alokasi yang ada.
- Alokasi dapat ditelusuri kembali ke transaksi sumber (kasir, deposit, klaim penjamin) dan ke tagihan kunjungan yang bersangkutan.
- Tagihan yang berstatus Lunas dapat dijadikan dasar penyelesaian administrasi kepulangan (OC-02-05 Reg-Out).

---

## 6. Outcome Boundary

### Start

Dimulai ketika tagihan kunjungan pasien telah berstatus **Final** (OC-02-01) dan setidaknya satu sumber pembayaran — baik dari kasir, deposit, maupun konfirmasi klaim penjamin — siap dicatat sebagai alokasi terhadap tagihan tersebut.

Untuk kasus kunjungan dengan jaminan penuh (misalnya BPJS non-COB tanpa biaya tambahan), alokasi dapat langsung dicatat setelah konfirmasi porsi penjamin tersedia, tanpa harus menunggu pembayaran kasir.

### End

Berakhir ketika seluruh entri alokasi pembayaran atas tagihan kunjungan telah tercatat dan saldo tagihan yang tersisa (outstanding balance) dapat ditentukan secara definitif — baik dalam status Lunas, Sebagian Terbayar, maupun Lebih Bayar.

Tagihan dengan outstanding balance = 0 (Lunas) menjadi prasyarat untuk penyelesaian Reg-Out (OC-02-05). Kondisi Lebih Bayar yang tersisa menjadi dasar untuk proses Refund (OC-02-04).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Alokasi pembayaran hanya dapat dilakukan terhadap tagihan yang berstatus **Final**; tagihan yang masih berstatus Aktif tidak boleh menerima alokasi pembayaran.
- Setiap entri alokasi harus memiliki referensi yang dapat dilacak ke sumber asalnya: nomor transaksi kasir, nomor referensi pemakaian deposit, atau nomor referensi klaim penjamin.
- Total alokasi dari sumber Penjamin tidak boleh melebihi porsi penjamin yang tercatat pada tagihan; porsi kelebihan harus jatuh ke saldo kewajiban pasien atau diproses sebagai lebih bayar penjamin.
- Total alokasi dari sumber Deposit tidak boleh melebihi saldo deposit aktif pasien; pemakaian deposit yang melebihi saldo harus ditolak.
- Pembatalan atau koreksi entri alokasi hanya dapat dilakukan oleh petugas yang memiliki otorisasi pembatalan; setiap pembatalan harus meninggalkan jejak audit yang lengkap.
- Saldo tagihan yang tersisa (outstanding balance) harus selalu dihitung ulang secara konsisten setiap kali entri alokasi ditambahkan, diubah, atau dibatalkan — tidak boleh ada inkonsistensi antara entri alokasi dan outstanding balance.
- Satu entri alokasi hanya dapat dialokasikan ke satu tagihan; alokasi tidak dapat dibagi ke lebih dari satu tagihan sekaligus dalam satu entri.
- Alokasi pembayaran kasir tidak dapat dicatat tanpa adanya Order Bayar yang telah dibuat dan dikonfirmasi oleh kasir (OC-03-01 Order Bayar → OC-03-02 Pembayaran).

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Tagihan belum berstatus Final (masih Aktif atau Dibatalkan) | Alokasi tidak dapat dilakukan. Petugas harus memastikan tagihan telah difinalisasi (OC-02-01) sebelum alokasi dapat dicatat. |
| Nilai alokasi melebihi saldo kewajiban pasien yang tersisa (outstanding balance) | Sistem memperingatkan kondisi lebih bayar. Jika dikonfirmasi, dicatat sebagai Lebih Bayar dan menjadi dasar proses Refund (OC-02-04). Jika tidak dikonfirmasi, alokasi ditolak. |
| Saldo deposit pasien tidak mencukupi untuk alokasi yang diminta | Alokasi dari deposit ditolak. Petugas dapat mengalokasikan hanya sejumlah saldo deposit yang tersedia, dengan selisihnya dilunasi dari sumber lain. |
| Nilai alokasi penjamin melebihi porsi penjamin yang tercatat pada tagihan | Alokasi penjamin melebihi batas ditolak. Petugas harus memastikan nilai klaim penjamin sesuai dengan porsi yang terdefinisi pada tagihan. |
| Referensi transaksi kasir tidak valid atau tidak ditemukan | Entri alokasi dari kasir tidak dapat disimpan. Petugas kasir harus memastikan transaksi pembayaran telah dikonfirmasi sebelum alokasi dicatat. |
| Entri alokasi dibatalkan oleh petugas yang tidak berwenang | Pembatalan ditolak. Hanya petugas dengan otorisasi pembatalan alokasi yang dapat membatalkan entri yang sudah ada. |
| Tagihan sudah berstatus Lunas namun alokasi tambahan coba ditambahkan | Sistem menolak penambahan alokasi baru terhadap tagihan yang sudah Lunas, kecuali ada otorisasi supervisor untuk membuka kembali status tagihan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Setiap entri alokasi memiliki nomor unik yang terhubung ke nomor tagihan kunjungan yang benar dan nomor registrasi yang valid. | Completeness |
| AC-02 | Setiap entri alokasi mencatat sumber pembayaran secara eksplisit (Kasir / Deposit / Penjamin) beserta nilai yang dialokasikan dan referensi transaksi sumber yang valid. | Correctness |
| AC-03 | Total nilai yang dialokasikan dari seluruh sumber pembayaran dihitung dengan benar dan konsisten dengan penjumlahan semua entri alokasi yang aktif. | Correctness |
| AC-04 | Saldo tagihan yang tersisa (outstanding balance) dihitung dengan benar sebagai selisih antara total kewajiban pasien dan total nilai yang dialokasikan — dan diperbarui secara konsisten setiap kali entri alokasi berubah. | Correctness |
| AC-05 | Status pelunasan tagihan (Lunas / Sebagian Terbayar / Lebih Bayar) mencerminkan nilai outstanding balance secara akurat. | Completeness |
| AC-06 | Alokasi tidak dapat dilakukan terhadap tagihan yang berstatus selain Final; percobaan alokasi terhadap tagihan Aktif menghasilkan penolakan. | Constraint |
| AC-07 | Alokasi dari sumber Deposit tidak dapat melebihi saldo deposit aktif pasien; percobaan alokasi melebihi saldo menghasilkan penolakan. | Constraint |
| AC-08 | Alokasi dari sumber Penjamin tidak dapat melebihi porsi penjamin yang tercatat pada tagihan; percobaan alokasi melebihi porsi menghasilkan penolakan. | Constraint |
| AC-09 | Alokasi dari kasir hanya dapat dicatat jika memiliki referensi transaksi kasir yang sah; alokasi tanpa referensi valid ditolak. | Constraint |
| AC-10 | Pembatalan entri alokasi hanya dapat dilakukan oleh petugas yang berwenang; percobaan pembatalan oleh petugas yang tidak berwenang ditolak. | Constraint |
| AC-11 | Setiap pembatalan entri alokasi menyebabkan outstanding balance dipulihkan secara konsisten dan jejak audit pembatalan tersimpan. | Constraint |
| AC-12 | Kondisi lebih bayar (outstanding balance < 0) teridentifikasi dan ditandai sebagai Lebih Bayar, yang kemudian dapat menjadi dasar proses Refund (OC-02-04). | Exception |
| AC-13 | Tagihan dengan status Lunas dapat dijadikan prasyarat penyelesaian administrasi kepulangan (OC-02-05 Reg-Out). | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembentukan dan konsolidasi rincian item biaya tagihan kunjungan — **OC-02-01 Rincian Tagihan Pasien**.
- Eksekusi penerimaan pembayaran tunai/non-tunai di loket kasir — **OC-03-01 Order Bayar** dan **OC-03-02 Pembayaran**.
- Pengelolaan saldo deposit pasien (penerimaan dan pengisian deposit) — **OC-02-03 Deposit**.
- Proses pengembalian kelebihan pembayaran (refund) kepada pasien — **OC-02-04 Refund**.
- Penyelesaian administrasi kepulangan pasien — **OC-02-05 Reg-Out**.
- Proses klaim elektronik ke BPJS (e-Klaim) — **BPJS Domain** (`BPJ-EKLAIM`); alokasi penjamin di sini hanya mencatat porsi yang diklaim, bukan proses klaim itu sendiri.
- Rekonsiliasi dan laporan keuangan atas pembayaran yang diterima — domain Finance/Akuntansi (di luar scope MYHOSWEB saat ini).
- Pengelolaan master tarif dan aturan manfaat penjamin — `TRK-TARIF` dan `TRK-JAMINAN`.
- Closing shift kasir dan rekonsiliasi kas harian — **OC-03-03 Closing Shift**.
