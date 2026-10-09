# OUTCOME: Kasir (Terima/Keluar Kas)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-TRK-KASIR     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Setiap penerimaan uang dari pasien atau keluarga — baik sebagai pembayaran tagihan maupun sebagai setoran deposit — serta setiap pengeluaran uang dari kas rumah sakit kepada pasien — baik sebagai pengembalian kelebihan pembayaran (refund) maupun pengembalian sisa deposit — harus dieksekusi, dicatat, dan dipersistensi melalui loket kasir sebagai **transaksi kas yang sah**.

Transaksi Kasir adalah business fact yang membuktikan bahwa perpindahan uang antara pasien/keluarga dan kas rumah sakit telah terjadi secara nyata: setiap penerimaan menghasilkan bukti terima kas yang terdokumentasi, dan setiap pengeluaran menghasilkan bukti keluar kas yang terdokumentasi. Bukti transaksi kasir inilah yang menjadi referensi sah untuk proses-proses hilir, termasuk Alokasi Pembayaran (OC-TRK-ALOKASI-PEMBAYARAN), pencatatan Deposit (OC-TRK-DEPOSIT), dan penyelesaian Reg-Out (OC-TRK-REG-OUT).

Tanpa transaksi kasir yang terpersistensi secara benar, tidak ada sumber pembayaran yang sah yang dapat digunakan dalam alokasi pembayaran, saldo deposit tidak dapat dibentuk, dan pengembalian uang kepada pasien tidak dapat dieksekusi secara teraudit.

---

## 2. Outcome Statement

Perpindahan uang antara pasien atau keluarga dan kas rumah sakit — baik berupa penerimaan (pembayaran tagihan, setoran deposit) maupun pengeluaran (refund kelebihan bayar, pengembalian deposit) — **telah dieksekusi, dicatat, dan terpersistensi sebagai transaksi kas yang sah dengan bukti yang dapat dilacak, sehingga transaksi tersebut dapat dijadikan referensi untuk alokasi pembayaran, mutasi deposit, dan rekonsiliasi kas.**

---

## 3. Participating Domains

| Domain        | Role in this Outcome |
|---------------|----------------------|
| Kasir         | Pemilik utama: mengeksekusi penerimaan dan pengeluaran kas secara fisik, mengonfirmasi transaksi, dan mempersistensi bukti transaksi kas yang sah |
| Tata Rekening | Konsumen transaksi: menerima referensi transaksi kasir yang sah sebagai dasar Alokasi Pembayaran (OC-TRK-ALOKASI-PEMBAYARAN) dan pencatatan mutasi Deposit (OC-TRK-DEPOSIT) |
| Pasien        | Subjek transaksi: identitas pasien menentukan tagihan atau deposit mana yang menjadi konteks transaksi kas |
| Admission     | Menyediakan konteks kunjungan (nomor registrasi) yang menghubungkan transaksi kasir ke episode yang tepat, sehingga pembayaran dapat dialokasikan ke tagihan yang benar |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `KSR-TERIMA-KAS` Penerimaan Kas | Kasir | Known |
| `KSR-KELUAR-KAS` Pengeluaran Kas | Kasir | Known |
| `KSR-ORDER` Order Bayar | Kasir | Known |
| `KSR-SHIFT` Manajemen Shift Kasir | Kasir | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-ALOKASI` Alokasi Pembayaran | Tata Rekening | Known |
| `TRK-DEPOSIT` Deposit | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Setiap penerimaan uang dari pasien atau keluarga (pembayaran tagihan atau setoran deposit) telah terdaftar sebagai transaksi **Terima Kas** yang terhubung ke Order Bayar atau konteks deposit yang valid.
- Setiap pengeluaran uang kepada pasien atau keluarga (refund kelebihan bayar atau pengembalian sisa deposit) telah terdaftar sebagai transaksi **Keluar Kas** yang terhubung ke perintah pengeluaran yang sah.
- Setiap transaksi kas — baik Terima maupun Keluar — memiliki nomor transaksi yang unik yang dapat dijadikan referensi oleh proses-proses hilir.
- Total kas yang diterima dan kas yang dikeluarkan oleh setiap kasir pada setiap shift dapat dihitung dan diverifikasi kapan saja.
- Metode pembayaran yang digunakan oleh pasien (tunai, kartu debit, kartu kredit, transfer, QRIS, atau metode lain) tercatat secara eksplisit pada setiap transaksi.
- Transaksi Terima Kas dari pasien menghasilkan bukti penerimaan (kwitansi) yang dapat disampaikan kepada pasien sebagai konfirmasi.
- Transaksi Keluar Kas kepada pasien menghasilkan bukti pengeluaran yang ditandatangani atau dikonfirmasi oleh penerima.

### 5.2 Required Recorded Information

**Identitas Transaksi Kas:**
- Nomor transaksi kas yang unik.
- Jenis transaksi: Terima Kas atau Keluar Kas.
- Tanggal dan waktu transaksi dieksekusi.
- Shift kasir dan nomor loket tempat transaksi terjadi.
- Kasir (petugas) yang mengeksekusi transaksi.

**Konteks Transaksi:**
- Nomor registrasi kunjungan yang menjadi konteks transaksi (jika berlaku).
- Identitas pasien: Nomor Rekam Medis dan nama pasien.
- Nomor Order Bayar yang menjadi dasar transaksi Terima Kas (untuk pembayaran tagihan).
- Nomor referensi deposit yang menjadi dasar transaksi (untuk setoran atau pengembalian deposit).
- Nomor referensi refund atau perintah pengeluaran yang sah (untuk transaksi Keluar Kas refund).
- Tujuan/keterangan transaksi: pembayaran tagihan, setoran deposit, refund, atau pengembalian deposit.

**Detail Pembayaran:**
- Nilai total transaksi.
- Metode pembayaran: Tunai, Kartu Debit, Kartu Kredit, Transfer Bank, QRIS, atau metode lain.
- Untuk transaksi tunai Terima Kas: nilai uang yang diserahkan pasien dan kembalian yang diberikan kasir.
- Untuk transaksi non-tunai: nomor referensi pembayaran elektronik (nomor otorisasi kartu, nomor referensi transfer, nomor transaksi QRIS).
- Status transaksi: Berhasil / Dibatalkan / Pending (untuk metode non-tunai yang memerlukan konfirmasi).

### 5.3 Required Business Conditions

- Transaksi Terima Kas untuk pembayaran tagihan hanya dapat dieksekusi jika terdapat Order Bayar yang valid dan dikonfirmasi dari Tata Rekening; kasir tidak dapat menerima pembayaran tagihan tanpa dasar Order Bayar yang sah.
- Transaksi Terima Kas untuk setoran deposit hanya dapat dieksekusi jika pasien teridentifikasi dengan valid dan ada kunjungan aktif yang menjadi konteks deposit.
- Transaksi Keluar Kas hanya dapat dieksekusi berdasarkan perintah pengeluaran yang sah (refund yang disetujui atau perintah pengembalian deposit yang dikonfirmasi); kasir tidak dapat mengeluarkan uang tanpa otorisasi yang tercatat.
- Nilai transaksi Keluar Kas tidak boleh melebihi nilai yang tertera pada perintah pengeluaran yang sah.
- Untuk transaksi non-tunai, konfirmasi pembayaran dari sistem pembayaran elektronik (EDC, payment gateway) harus diperoleh sebelum transaksi dinyatakan berhasil.
- Setiap transaksi kas harus diasosiasikan dengan shift kasir yang sedang aktif; transaksi tidak dapat dicatat di luar shift aktif tanpa mekanisme koreksi yang berotorisasi.
- Pembatalan transaksi kasir hanya dapat dilakukan oleh petugas yang berwenang selama shift yang sama; pembatalan meninggalkan jejak audit dan menghasilkan reversal yang konsisten.

### 5.4 Completion Proof

- Setiap transaksi kas memiliki nomor unik yang terpersistensi dan dapat ditelusuri ke Order Bayar atau perintah pengeluaran yang mendasarinya.
- Transaksi Terima Kas yang berhasil dapat dijadikan referensi sah oleh Alokasi Pembayaran (OC-TRK-ALOKASI-PEMBAYARAN) atau pencatatan mutasi Deposit (OC-TRK-DEPOSIT).
- Transaksi Keluar Kas yang berhasil tercatat sebagai bukti pengeluaran uang yang dapat dijadikan dasar rekonsiliasi kas.
- Bukti penerimaan (kwitansi) dapat diterbitkan berdasarkan transaksi Terima Kas yang berhasil.
- Saldo kas yang dipegang kasir pada setiap titik waktu dapat dihitung berdasarkan akumulasi transaksi Terima Kas dikurangi transaksi Keluar Kas dalam shift yang berjalan.
- Transaksi kasir yang terpersistensi dapat diikutsertakan dalam rekonsiliasi Closing Shift (OC-TRK-CLOSING-SHIFT).

---

## 6. Outcome Boundary

### Start

Dimulai ketika seorang kasir menerima Order Bayar yang valid dari sistem Tata Rekening — atau perintah pengeluaran yang sah — dan pasien atau keluarga hadir di loket kasir untuk mengeksekusi pembayaran atau penerimaan uang. Untuk transaksi setoran deposit, dimulai ketika pasien atau keluarga menyerahkan uang kepada kasir dengan permohonan setoran deposit yang terhubung ke kunjungan yang aktif.

### End

Berakhir ketika transaksi kas telah dieksekusi dan dikonfirmasi secara penuh: uang telah diterima atau dikeluarkan secara fisik, nilai transaksi telah tercatat dengan benar, status transaksi berubah menjadi **Berhasil**, dan nomor transaksi yang unik telah diterbitkan sehingga proses-proses hilir (alokasi pembayaran, mutasi deposit) dapat menggunakannya sebagai referensi yang sah.

Untuk transaksi non-tunai, transaksi dianggap selesai setelah konfirmasi elektronik diterima dari sistem pembayaran pihak ketiga (EDC/payment gateway) dan terpersistensi dalam sistem.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Transaksi Terima Kas untuk pembayaran tagihan wajib terhubung ke Order Bayar yang valid; tidak ada penerimaan pembayaran tanpa dasar Order Bayar yang terdaftar.
- Transaksi Keluar Kas wajib terhubung ke perintah pengeluaran yang diotorisasi (approved refund atau perintah pengembalian deposit); tidak ada pengeluaran uang tanpa otorisasi yang tercatat.
- Nilai transaksi Keluar Kas tidak boleh melebihi nilai yang tertera pada perintah pengeluaran yang diotorisasi.
- Setiap transaksi kas harus dikaitkan dengan shift kasir yang sedang aktif; tidak ada transaksi yang dapat diposting ke shift yang sudah ditutup tanpa otorisasi reopening.
- Untuk pembayaran non-tunai, transaksi hanya dapat dinyatakan berhasil setelah konfirmasi dari sistem pembayaran elektronik diterima; konfirmasi yang tidak tersedia menyebabkan transaksi dalam status Pending.
- Pembatalan transaksi kasir yang sudah berhasil hanya dapat dilakukan oleh kasir yang bersangkutan atau supervisor selama shift yang sama, dan hanya jika transaksi tersebut belum direferensikan oleh proses hilir (alokasi pembayaran atau mutasi deposit yang sudah dikonfirmasi).
- Setiap transaksi kasir harus meninggalkan jejak audit lengkap: nomor transaksi, jenis transaksi, nilai, metode, waktu, kasir, dan status.
- Satu Order Bayar tidak boleh diselesaikan oleh lebih dari satu transaksi Terima Kas yang sah secara bersamaan; duplikasi transaksi terhadap Order Bayar yang sama harus terdeteksi dan dicegah.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Order Bayar tidak ditemukan atau tidak valid | Transaksi Terima Kas untuk pembayaran tagihan ditolak. Kasir harus memastikan Order Bayar dari Tata Rekening telah diterbitkan dan valid sebelum menerima pembayaran. |
| Order Bayar sudah diselesaikan oleh transaksi sebelumnya | Transaksi ditolak sebagai duplikat. Sistem harus mendeteksi bahwa Order Bayar sudah berstatus Selesai dan mencegah pembayaran ulang. |
| Konfirmasi pembayaran non-tunai tidak diterima (timeout / gagal EDC) | Transaksi dinyatakan gagal atau Pending. Kasir harus meminta pasien mengulang dengan metode pembayaran lain, atau menunggu konfirmasi manual dari sistem non-tunai. |
| Nilai yang dibayar tidak sesuai dengan nilai Order Bayar (untuk tunai: nilai lebih rendah tanpa otorisasi cicilan) | Transaksi tidak dapat dikonfirmasi sebagai Berhasil-Lunas. Sistem memperingatkan perbedaan nilai; kasir harus menyelesaikan seluruh nilai atau mendapatkan otorisasi untuk partial payment jika kebijakan mengizinkan. |
| Perintah Keluar Kas tidak ditemukan, tidak valid, atau belum diotorisasi | Transaksi Keluar Kas ditolak. Kasir tidak dapat mengeluarkan uang tanpa perintah yang sah dan berotorisasi. |
| Nilai Keluar Kas melebihi nilai yang diotorisasi | Transaksi Keluar Kas ditolak. Kasir hanya dapat mengeluarkan uang sebesar nilai yang tercantum dalam perintah yang diotorisasi. |
| Shift kasir tidak aktif (belum dibuka atau sudah ditutup) | Transaksi kasir tidak dapat dieksekusi. Kasir harus memastikan shift aktif sebelum melayani transaksi. |
| Pembatalan transaksi dilakukan setelah transaksi sudah direferensikan oleh alokasi pembayaran atau mutasi deposit yang dikonfirmasi | Pembatalan ditolak. Pembatalan hanya dapat dilakukan melalui mekanisme koreksi yang berotorisasi dan melibatkan reversal di proses hilir yang terdampak. |
| Transaksi dicoba dieksekusi oleh petugas yang tidak terdaftar sebagai kasir pada shift tersebut | Transaksi ditolak. Hanya kasir yang terdaftar aktif pada shift tersebut yang dapat mengeksekusi transaksi. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------| 
| AC-01 | Setiap transaksi Terima Kas memiliki nomor unik, terhubung ke Order Bayar yang valid atau konteks deposit yang teridentifikasi, dan mencatat identitas pasien serta kasir yang mengeksekusi. | Completeness |
| AC-02 | Setiap transaksi Keluar Kas memiliki nomor unik, terhubung ke perintah pengeluaran yang diotorisasi, dan mencatat identitas penerima serta kasir yang mengeksekusi. | Completeness |
| AC-03 | Metode pembayaran tercatat secara eksplisit pada setiap transaksi; untuk non-tunai, nomor referensi konfirmasi elektronik tersimpan. | Correctness |
| AC-04 | Untuk transaksi tunai Terima Kas: nilai yang dibayar pasien dan nilai kembalian yang diberikan kasir tercatat dan konsisten dengan nilai transaksi. | Correctness |
| AC-05 | Transaksi Terima Kas yang berstatus Berhasil dapat dijadikan referensi sah untuk entri Alokasi Pembayaran (OC-TRK-ALOKASI-PEMBAYARAN) atau mutasi Deposit (OC-TRK-DEPOSIT). | Correctness |
| AC-06 | Transaksi Keluar Kas yang berstatus Berhasil dapat dijadikan referensi sah untuk pencatatan pengembalian deposit atau refund. | Correctness |
| AC-07 | Transaksi Terima Kas untuk pembayaran tagihan tanpa Order Bayar yang valid ditolak oleh sistem. | Constraint |
| AC-08 | Transaksi Keluar Kas tanpa perintah pengeluaran yang diotorisasi ditolak oleh sistem. | Constraint |
| AC-09 | Nilai Keluar Kas yang melebihi nilai pada perintah pengeluaran yang diotorisasi ditolak oleh sistem. | Constraint |
| AC-10 | Duplikasi transaksi terhadap Order Bayar yang sudah berstatus Selesai terdeteksi dan ditolak oleh sistem. | Constraint |
| AC-11 | Transaksi yang dieksekusi di luar shift aktif ditolak oleh sistem; tidak ada transaksi yang dapat diposting ke shift yang sudah ditutup tanpa otorisasi. | Constraint |
| AC-12 | Transaksi non-tunai hanya dapat berstatus Berhasil setelah konfirmasi elektronik dari sistem pembayaran diterima dan terpersistensi. | Constraint |
| AC-13 | Pembatalan transaksi yang sudah direferensikan oleh alokasi pembayaran atau mutasi deposit yang dikonfirmasi ditolak tanpa mekanisme koreksi yang berotorisasi. | Exception |
| AC-14 | Transaksi yang dieksekusi oleh petugas yang tidak terdaftar sebagai kasir aktif pada shift tersebut ditolak oleh sistem. | Constraint |
| AC-15 | Seluruh transaksi kasir pada satu shift dapat diikutsertakan dalam rekonsiliasi Closing Shift (OC-TRK-CLOSING-SHIFT) dengan saldo yang dapat diverifikasi. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembentukan dan finalisasi rincian tagihan kunjungan pasien — **OC-TRK-BILLING Rincian Tagihan Pasien**.
- Pencatatan alokasi sumber pembayaran terhadap tagihan kunjungan — **OC-TRK-ALOKASI-PEMBAYARAN Alokasi Pembayaran** (OC-TRK-KASIR menghasilkan referensi transaksi kasir yang digunakan sebagai dasar alokasi, namun mekanisme alokasi adalah tanggung jawab OC-TRK-ALOKASI-PEMBAYARAN).
- Pengelolaan saldo deposit pasien (pencatatan mutasi saldo, perhitungan saldo aktual) — **OC-TRK-DEPOSIT Deposit** (OC-TRK-KASIR mengeksekusi penerimaan atau pengembalian uang deposit secara fisik; pencatatan mutasi saldo adalah tanggung jawab OC-TRK-DEPOSIT).
- Penyelesaian administrasi kepulangan pasien — **OC-TRK-REG-OUT Reg-Out** (kasir mengeksekusi pembayaran yang mendasari Reg-Out, tetapi proses penutupan episode adalah tanggung jawab OC-TRK-REG-OUT).
- Penutupan shift kasir dan rekonsiliasi kas harian — **OC-TRK-CLOSING-SHIFT Closing Shift** (OC-TRK-KASIR menghasilkan data transaksi yang direkonsiliasi dalam Closing Shift; proses penutupan shift adalah tanggung jawab OC-TRK-CLOSING-SHIFT).
- Pengelolaan master metode pembayaran dan konfigurasi terminal pembayaran non-tunai — **SC-14 Mastering** (`KSR-MASTER-PEMBAYARAN`).
- Rekonsiliasi dan pelaporan keuangan atas kas yang diterima atau dikeluarkan — domain Finance/Akuntansi (di luar scope MYHOSWEB saat ini).
- Pengelolaan kas kecil (petty cash) operasional rumah sakit yang tidak terhubung ke transaksi pasien — di luar scope modul Kasir MYHOSWEB.
- Proses klaim elektronik ke BPJS (e-Klaim) — **BPJS Domain** (`BPJ-EKLAIM`); transaksi kasir untuk pasien BPJS mencatat pembayaran selisih biaya tambahan (jika ada), bukan proses klaim itu sendiri.
