# OUTCOME: Closing Shift

| Field       | Value        |
|-------------|--------------|
| Code        | OC-TRK-CLOSING-SHIFT     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Setiap shift kerja kasir harus ditutup secara formal sebelum giliran kerja berikutnya dimulai. Penutupan shift adalah tindakan bisnis yang memastikan bahwa seluruh transaksi kas yang terjadi selama satu shift — penerimaan pembayaran tagihan, setoran deposit, pengeluaran refund, dan pengembalian deposit — telah direkonsiliasi, kas fisik yang dipegang kasir telah dihitung dan diverifikasi, serta selisih antara kas yang diharapkan dan kas aktual telah diidentifikasi dan dicatat secara eksplisit.

Closing Shift menghasilkan **Laporan Penutupan Shift** yang menjadi bukti sah bahwa aktivitas kas kasir pada periode shift tersebut telah diselesaikan secara terkontrol, terdokumentasi, dan dapat dipertanggungjawabkan. Tanpa Closing Shift yang terpersistensi, tidak ada batas yang jelas antara periode kerja kasir, saldo kas tidak dapat diverifikasi per shift, dan akuntabilitas petugas kasir tidak dapat ditegakkan.

---

## 2. Outcome Statement

Seluruh transaksi kas yang terjadi selama satu shift kasir **telah direkonsiliasi antara catatan sistem dan kas fisik yang dipegang kasir, selisih kas telah diidentifikasi dan dicatat, dan shift kasir telah ditutup secara formal sehingga menghasilkan Laporan Penutupan Shift yang terpersistensi dan dapat dipertanggungjawabkan.**

---

## 3. Participating Domains

| Domain        | Role in this Outcome |
|---------------|----------------------|
| Tata Rekening | Pemilik utama: menyediakan capability `TRK-KASIR` yang mencakup manajemen shift kasir dan proses penutupan shift. Laporan Penutupan Shift adalah output yang terpersistensi dalam domain ini. |
| Pasien        | Subjek konteks transaksi: identitas pasien yang tercatat pada transaksi kasir diikutsertakan dalam ringkasan Closing Shift sebagai referensi verifikasi. |
| Admission     | Menyediakan konteks kunjungan (nomor registrasi) yang dikaitkan pada transaksi kasir; data ini diikutsertakan dalam agregasi transaksi per shift untuk keperluan rekonsiliasi. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `TRK-KASIR` Kasir (termasuk Manajemen Shift dan Closing) | Tata Rekening | Known |
| `KSR-SHIFT` Manajemen Shift Kasir | Kasir | Known |
| `KSR-TERIMA-KAS` Penerimaan Kas | Kasir | Known |
| `KSR-KELUAR-KAS` Pengeluaran Kas | Kasir | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Shift kasir yang akan ditutup telah berada dalam status aktif dan tidak dalam kondisi sudah ditutup sebelumnya.
- Seluruh transaksi kas (Terima Kas dan Keluar Kas) yang terjadi dalam shift tersebut telah dihimpun dan dapat diidentifikasi sebagai bagian dari shift yang bersangkutan.
- Sistem telah menghitung **saldo kas yang diharapkan** berdasarkan saldo awal shift ditambah total Terima Kas dikurangi total Keluar Kas selama shift.
- Kasir telah menginputkan **nilai kas fisik aktual** yang dihitung secara manual dari uang tunai yang ada di loket.
- **Selisih kas** antara saldo yang diharapkan dan kas fisik aktual telah dihitung dan dicatat — baik nilai nol (balance), nilai positif (kas lebih), maupun nilai negatif (kas kurang).
- Shift kasir telah berubah status dari **Aktif** menjadi **Tutup**, sehingga tidak ada transaksi baru yang dapat diposting ke shift tersebut setelah Closing dilakukan.
- Laporan Penutupan Shift telah terpersistensi sebagai dokumen formal yang dapat diakses dan dicetak.

### 5.2 Required Recorded Information

**Identitas Shift:**
- Nomor shift yang ditutup (identifikasi unik shift).
- Nomor loket kasir.
- Tanggal dan periode waktu shift (jam buka hingga jam tutup).
- Nama kasir (petugas) yang membuka shift.
- Nama kasir (petugas) yang menutup shift (boleh sama atau berbeda jika ada serah terima).
- Tanggal dan waktu Closing Shift dilakukan.

**Ringkasan Transaksi Shift:**
- Jumlah transaksi Terima Kas yang terjadi selama shift.
- Total nilai Terima Kas selama shift (dipecah per metode pembayaran: Tunai, Kartu Debit, Kartu Kredit, Transfer Bank, QRIS, dan metode lain).
- Jumlah transaksi Keluar Kas yang terjadi selama shift.
- Total nilai Keluar Kas selama shift (dipecah per jenis pengeluaran: Refund, Pengembalian Deposit).
- Daftar nomor transaksi kas yang termasuk dalam shift (sebagai referensi audit).

**Rekonsiliasi Kas Tunai:**
- Saldo awal kas tunai pada saat shift dibuka (uang pangkal/float).
- Total penerimaan tunai selama shift.
- Total pengeluaran tunai selama shift.
- Saldo kas tunai yang diharapkan oleh sistem.
- Nilai kas fisik aktual yang dihitung oleh kasir.
- Selisih kas: nilai dan kode selisih (Balance / Kas Lebih / Kas Kurang).
- Keterangan selisih (wajib diisi jika selisih bukan nol).

**Status Penutupan:**
- Status shift: Tutup.
- Nama supervisor atau pejabat yang menyetujui penutupan shift (jika diperlukan otorisasi).

### 5.3 Required Business Conditions

- Closing Shift hanya dapat dieksekusi oleh kasir yang terdaftar aktif pada shift tersebut, atau oleh supervisor yang memiliki kewenangan menutup shift.
- Closing Shift tidak dapat dieksekusi jika shift belum dibuka (status bukan Aktif).
- Closing Shift tidak dapat dieksekusi jika terdapat transaksi kas dalam status **Pending** yang belum diselesaikan atau dibatalkan; semua transaksi dalam shift harus memiliki status final (Berhasil atau Dibatalkan) sebelum shift dapat ditutup.
- Nilai kas fisik aktual yang diinputkan oleh kasir harus merupakan angka yang valid (tidak boleh kosong atau negatif).
- Setelah shift ditutup, status shift berubah secara permanen menjadi **Tutup**; tidak ada transaksi baru yang dapat diposting ke shift yang sudah ditutup tanpa mekanisme reopening yang berotorisasi.
- Jika terdapat selisih kas, kasir wajib mengisi keterangan selisih sebelum Closing Shift dapat dikonfirmasi.

### 5.4 Completion Proof

- Shift kasir yang bersangkutan berstatus **Tutup** dan tidak menerima transaksi baru.
- Laporan Penutupan Shift dengan nomor shift yang unik telah terpersistensi dan dapat dicetak.
- Ringkasan transaksi per metode pembayaran selama shift dapat ditampilkan dan diverifikasi.
- Selisih kas (balance, lebih, atau kurang) beserta keterangannya tercatat secara eksplisit pada Laporan Penutupan Shift.
- Laporan Penutupan Shift dapat dijadikan dasar rekonsiliasi kas harian oleh manajemen atau bagian keuangan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika kasir atau supervisor menginisiasi proses Closing Shift untuk shift yang sedang aktif — setelah seluruh antrian pelayanan pasien pada shift tersebut selesai dilayani dan tidak ada transaksi kas baru yang akan ditambahkan ke shift tersebut.

### End

Berakhir ketika:
1. Nilai kas fisik aktual telah diinputkan oleh kasir,
2. Keterangan selisih telah diisi (jika ada selisih),
3. Closing Shift dikonfirmasi dan disetujui (oleh kasir dan/atau supervisor sesuai kebijakan),
4. Status shift berubah menjadi **Tutup**, dan
5. Laporan Penutupan Shift telah terpersistensi dengan nomor unik yang dapat dicetak atau diakses.

Setelah boundary End tercapai, shift tidak dapat digunakan untuk transaksi baru tanpa mekanisme reopening yang berotorisasi.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Closing Shift hanya dapat dilakukan pada shift yang berstatus **Aktif**; shift yang sudah berstatus **Tutup** tidak dapat ditutup kembali tanpa proses reopening yang berotorisasi.
- Tidak ada transaksi kas (Terima Kas atau Keluar Kas) yang dapat diposting ke shift setelah shift berstatus **Tutup**.
- Semua transaksi dalam shift harus berstatus final (Berhasil atau Dibatalkan) sebelum Closing Shift dapat dilakukan; transaksi berstatus Pending mencegah eksekusi Closing Shift.
- Nilai kas fisik aktual yang diinputkan tidak boleh kosong; kasir wajib menginputkan hasil penghitungan fisik sebelum Closing dapat dikonfirmasi.
- Keterangan selisih wajib diisi oleh kasir jika selisih kas bukan nol; Closing Shift tidak dapat dikonfirmasi tanpa keterangan selisih yang tercatat.
- Laporan Penutupan Shift adalah dokumen final; isi ringkasan transaksi dan nilai rekonsiliasi tidak dapat dimodifikasi setelah shift berstatus Tutup.
- Selisih kas yang melebihi ambang batas yang ditetapkan oleh kebijakan rumah sakit harus mendapatkan persetujuan supervisor sebelum Closing dapat dikonfirmasi.
- Satu shift hanya dapat ditutup satu kali; sistem harus mencegah eksekusi Closing Shift ganda terhadap shift yang sama.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Shift tidak ditemukan atau berstatus bukan Aktif | Closing Shift ditolak. Sistem menginformasikan bahwa shift yang dimaksud tidak aktif atau sudah ditutup. |
| Terdapat transaksi berstatus Pending dalam shift | Closing Shift tidak dapat dilanjutkan. Sistem menampilkan daftar transaksi Pending yang harus diselesaikan atau dibatalkan terlebih dahulu sebelum shift dapat ditutup. |
| Kasir tidak terdaftar aktif pada shift yang akan ditutup dan bukan supervisor | Closing Shift ditolak. Hanya kasir yang terdaftar pada shift tersebut atau supervisor yang berwenang dapat menutup shift. |
| Nilai kas fisik aktual tidak diinputkan | Closing Shift tidak dapat dikonfirmasi. Sistem mewajibkan inputan nilai kas fisik aktual sebelum proses Closing dapat diselesaikan. |
| Selisih kas bukan nol namun keterangan selisih tidak diisi | Closing Shift tidak dapat dikonfirmasi. Sistem mewajibkan keterangan selisih jika ditemukan perbedaan antara saldo yang diharapkan dan kas fisik aktual. |
| Selisih kas melebihi ambang batas kebijakan tanpa persetujuan supervisor | Closing Shift ditunda. Sistem memerlukan konfirmasi supervisor sebelum penutupan shift dapat dikonfirmasi. |
| Closing Shift dieksekusi ulang pada shift yang sudah berstatus Tutup | Closing Shift kedua ditolak. Sistem mendeteksi bahwa shift sudah dalam status Tutup dan mencegah duplikasi penutupan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------| 
| AC-01 | Shift kasir yang telah melewati proses Closing berstatus **Tutup** dan tidak menerima transaksi kas baru. | Completeness |
| AC-02 | Laporan Penutupan Shift memuat ringkasan transaksi per metode pembayaran (Tunai, Kartu Debit, Kartu Kredit, Transfer, QRIS) selama shift dengan nilai yang konsisten terhadap akumulasi transaksi yang terpersistensi dalam OC-TRK-KASIR. | Correctness |
| AC-03 | Laporan Penutupan Shift mencatat saldo awal shift, total Terima Kas, total Keluar Kas, saldo yang diharapkan, kas fisik aktual, dan selisih kas — semua nilainya konsisten satu sama lain secara aritmetika. | Correctness |
| AC-04 | Selisih kas (positif, negatif, atau nol) tercatat secara eksplisit pada Laporan Penutupan Shift beserta keterangannya jika selisih bukan nol. | Completeness |
| AC-05 | Closing Shift yang dieksekusi terhadap shift yang memiliki transaksi berstatus Pending ditolak oleh sistem; sistem menampilkan daftar transaksi Pending yang menghambat penutupan. | Constraint |
| AC-06 | Closing Shift yang dieksekusi oleh petugas yang tidak terdaftar aktif pada shift tersebut dan bukan supervisor ditolak oleh sistem. | Constraint |
| AC-07 | Closing Shift pada shift yang sudah berstatus Tutup (duplikasi penutupan) ditolak oleh sistem. | Constraint |
| AC-08 | Closing Shift tidak dapat dikonfirmasi jika nilai kas fisik aktual tidak diinputkan. | Constraint |
| AC-09 | Closing Shift tidak dapat dikonfirmasi jika selisih kas bukan nol dan keterangan selisih belum diisi. | Constraint |
| AC-10 | Selisih kas yang melebihi ambang batas kebijakan memerlukan konfirmasi supervisor sebelum Closing Shift dapat dikonfirmasi. | Constraint |
| AC-11 | Laporan Penutupan Shift yang telah terpersistensi dapat dicetak dan memuat identitas shift, identitas kasir, periode shift, ringkasan transaksi, dan hasil rekonsiliasi kas. | Completeness |
| AC-12 | Isi Laporan Penutupan Shift (nilai rekonsiliasi dan ringkasan transaksi) tidak dapat dimodifikasi setelah shift berstatus Tutup tanpa mekanisme koreksi yang berotorisasi. | Constraint |
| AC-13 | Seluruh transaksi kasir dari OC-TRK-KASIR yang tercatat dalam shift dapat diidentifikasi dan diikutsertakan dalam rekonsiliasi Closing Shift tanpa ada transaksi yang tertinggal. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Eksekusi transaksi penerimaan dan pengeluaran kas per pasien — **OC-TRK-KASIR Kasir (Terima/Keluar Kas)** (OC-TRK-CLOSING-SHIFT menggunakan data transaksi yang dihasilkan OC-TRK-KASIR sebagai input rekonsiliasi, namun tidak mengelola eksekusi transaksi itu sendiri).
- Pembukaan (opening) shift kasir — termasuk penetapan saldo awal (float) dan pendaftaran kasir pada shift — adalah aktivitas inisiasi shift yang mendahului Closing Shift dan merupakan bagian dari manajemen shift dalam `TRK-KASIR` / `KSR-SHIFT`, bukan outcome tersendiri dalam cakupan OC-TRK-CLOSING-SHIFT.
- Rekonsiliasi dan pelaporan keuangan tingkat rumah sakit (konsolidasi kas harian lintas loket, jurnal akuntansi) — domain Finance/Akuntansi (di luar scope MYHOSWEB saat ini); OC-TRK-CLOSING-SHIFT menghasilkan Laporan Penutupan Shift sebagai sumber data, namun proses konsolidasi akuntansi adalah tanggung jawab domain di luar MYHOSWEB.
- Pengelolaan kas kecil (petty cash) operasional yang tidak terhubung ke transaksi pasien — di luar scope modul Kasir MYHOSWEB.
- Pembentukan rincian tagihan kunjungan pasien — **OC-TRK-BILLING Rincian Tagihan Pasien**.
- Alokasi sumber pembayaran terhadap tagihan kunjungan — **OC-TRK-ALOKASI-PEMBAYARAN Alokasi Pembayaran**.
- Pengelolaan saldo deposit pasien — **OC-TRK-DEPOSIT Deposit**.
- Penyelesaian administrasi kepulangan pasien — **OC-TRK-REG-OUT Reg-Out**.
