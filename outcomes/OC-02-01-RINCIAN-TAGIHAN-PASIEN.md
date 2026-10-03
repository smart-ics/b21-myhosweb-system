# OUTCOME: Rincian Tagihan Pasien

| Field       | Value        |
|-------------|--------------|
| Code        | OC-02-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Rumah sakit memerlukan satu kesatuan informasi bisnis yang utuh, konsisten, dan dapat ditelusuri mengenai seluruh rincian tagihan serta transaksi pembayaran yang telah terjadi selama satu kunjungan atau episode pelayanan pasien.

Satu kunjungan atau episode pelayanan pasien tidak selalu hanya terdiri dari satu registrasi tunggal, melainkan dapat mencakup beberapa registrasi atau episode pelayanan yang saling berkaitan di bawah satu No. Registrasi Utama sebagai master kunjungan/episode.

Outcome ini memenuhi kebutuhan penyediaan informasi rincian tagihan dan pembayaran yang lengkap, akurat, dan transparan — baik disajikan secara kronologis detail transaksi, rekapitulasi nilai, maupun pengelompokan berdasarkan atribut bisnis yang relevan — sebagai dasar evaluasi finansial pelayanan pasien dan ketertelusuran biaya, tanpa mengubah atau memutasi transaksi yang mendasarinya (read-only).

---

## 2. Outcome Statement

Kesatuan rincian tagihan dan riwayat pembayaran pasien untuk satu kunjungan/episode pelayanan — yang dibatasi oleh satu No. Registrasi Utama beserta seluruh registrasi yang secara eksplisit telah dikaitkan kepadanya — **tersedia secara lengkap, konsisten, dapat ditelusuri ke registrasi sumbernya, dan tersaji dalam bentuk detail transaksi kronologis, rekapitulasi nilai, serta pengelompokan atribut bisnis yang valid sebagai dasar informasi finansial pelayanan pasien**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Tata Rekening | Pemilik representasi finansial tagihan dan pembayaran: memelihara dan menyediakan data transaksi tagihan (`TRK-BILLING`), rekapitulasi nilai tagihan, serta data transaksi pembayaran yang telah terjadi (`TRK-PAYMENT`). |
| Admission | Pemilik entitas registrasi dan relasi antar-registrasi: menetapkan No. Registrasi Utama dan memelihara hubungan registrasi terkait yang menjadi penentu batasan bisnis (business boundary) satu kunjungan/episode tagihan (`ADM-REG`). |
| Pasien | Pemilik identitas pasien: menyediakan data sosial dan identitas sah pasien (Nomor Rekam Medis dan nama pasien) yang menjadi subjek pemilik kunjungan/episode tagihan (`PAS-DATSOS`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-PAYMENT` Payment | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Satu **No. Registrasi Utama** yang sah diakui sebagai master dan identitas tunggal atas satu kunjungan/episode pelayanan pasien.
- Seluruh registrasi yang memiliki hubungan bisnis yang telah dibentuk secara eksplisit terhadap No. Registrasi Utama diakui sebagai bagian integral dari kesatuan kunjungan/episode tagihan tersebut.
- Batasan satu kunjungan/episode tagihan ditentukan murni oleh relasi registrasi terhadap No. Registrasi Utama, bukan oleh asumsi waktu, asumsi unit, maupun asumsi jenis pelayanan.
- Seluruh rincian transaksi tagihan (tindakan klinis, farmasi/obat, barang/alat medis, pemeriksaan laboratorium, pemeriksaan radiologi, akomodasi/kamar, dan komponen biaya pelayanan lainnya) yang bersumber dari No. Registrasi Utama maupun registrasi-registrasi terkait terhimpun secara lengkap dan konsisten.
- Setiap baris rincian tagihan mempertahankan ketertelusuran (traceability) ke registrasi/episode pelayanan yang menjadi sumber timbulnya transaksi.
- Rekapitulasi nilai tagihan (nilai bruto/gross, subtotal kelompok biaya, dan total nilai tagihan episode) terhitung secara akurat dan konsisten secara matematis dengan penjumlahan rincian transaksi tagihan.
- Seluruh transaksi pembayaran yang telah sah terjadi untuk kunjungan/episode tersebut tercatat secara faktual beserta rincian transaksinya (waktu transaksi, metode/instrumen pembayaran, referensi bukti bayar, dan nilai nominal).
- Posisi ringkasan finansial kunjungan/episode (akumulasi nilai tagihan versus akumulasi nilai pembayaran yang telah terjadi) terhitung secara akurat dan konsisten.
- Outcome ini bersifat **read-only**: tidak melakukan pembuatan, pengubahan, atau penghapusan transaksi tagihan, transaksi pembayaran, maupun hubungan keterkaitan antar-registrasi.

### 5.2 Required Recorded Information

**Identitas Kunjungan/Episode (Master):**
- Nomor Registrasi Utama sebagai identitas master kunjungan/episode.
- Identitas Pasien (Nomor Rekam Medis, Nama Pasien).
- Jenis/konteks pelayanan registrasi utama (Rawat Jalan, Rawat Inap, atau IGD).
- Tanggal dan waktu registrasi utama dibuka.
- Status operasional registrasi utama.

**Daftar Registrasi Terkait (Linked Registrations):**
- Daftar nomor registrasi yang secara eksplisit dikaitkan dengan No. Registrasi Utama.
- Jenis pelayanan dan unit/instalasi pelayanan asal untuk masing-masing registrasi terkait.
- Tanggal dan waktu masing-masing registrasi terkait dibuka.
- Tautan relasi bisnis yang menghubungkan registrasi terkait dengan No. Registrasi Utama.

**Rincian Transaksi Tagihan (Billing Details):**
- Identifikasi unik transaksi tagihan (ID transaksi tagihan).
- Nomor registrasi sumber yang menghasilkan transaksi (apakah No. Registrasi Utama atau salah satu registrasi terkait).
- Tanggal dan waktu pelaksanaan/pencatatan transaksi pelayanan.
- Unit/instalasi dan bagian pelayanan asal transaksi.
- Item pelayanan/barang (kode item, nama tindakan/obat/alat/pemeriksaan/kamar).
- Klasifikasi/kategori biaya bisnis (tindakan medis, farmasi, laboratorium, radiologi, akomodasi, biaya administrasi, dsb.).
- Volume/kuantitas transaksi dan satuan ukuran.
- Nilai tarif satuan dan total nilai transaksi tagihan.
- Atribut penjamin/jenis jaminan yang berlaku pada saat transaksi dicatat.

**Bentuk Penyajian & Rekapitulasi Tagihan:**
- Penyajian detail kronologis berdasarkan urutan tanggal dan waktu transaksi pelayanan.
- Rekapitulasi nilai tagihan berdasarkan pengelompokan atribut bisnis yang relevan (misal: per kelompok jenis biaya, per unit pelayanan, per registrasi sumber).
- Total nilai tagihan kumulatif dari seluruh transaksi yang tergabung dalam kunjungan/episode.

**Rincian Transaksi Pembayaran yang Telah Terjadi:**
- Daftar transaksi pembayaran yang telah sah terjadi untuk kunjungan/episode tersebut.
- Nomor bukti pembayaran / referensi transaksi kasir.
- Tanggal dan waktu transaksi pembayaran dilakukan.
- Kanal / kasir dan metode/instrumen pembayaran yang digunakan (tunai, transfer, kartu debit/kredit, dsb.).
- Nilai nominal transaksi pembayaran.
- Total akumulasi pembayaran yang telah diterima untuk kunjungan/episode tersebut.

**Ringkasan Posisi Finansial Kunjungan/Episode:**
- Total akumulasi nilai tagihan.
- Total akumulasi nilai pembayaran yang telah terjadi.
- Selisih antara total tagihan dan total pembayaran yang telah dilakukan.

### 5.3 Required Business Conditions

- No. Registrasi Utama harus valid dan terdaftar resmi dalam sistem Admission (`ADM-REG`).
- Keterkaitan antara registrasi-registrasi dengan No. Registrasi Utama harus telah terbentuk secara eksplisit melalui mekanisme/subsistem yang mengelola relasi registrasi; transaksi dari suatu registrasi hanya diikutsertakan ke dalam kunjungan/episode apabila relasi tersebut telah aktif secara sah.
- Seluruh transaksi tagihan yang dihimpun berasal dari transaksi sah yang tercatat pada `TRK-BILLING` untuk registrasi utama maupun registrasi-registrasi terkait.
- Seluruh data pembayaran yang dihimpun berasal dari transaksi pembayaran sah yang telah terjadi dan tercatat pada `TRK-PAYMENT`.
- Setiap bentuk pengelompokan (grouping) atau rekapitulasi yang diterapkan harus mempertahankan integritas matematis mutlak; jumlah total dari seluruh kelompok/rekapitulasi harus selalu tepat sama dengan jumlah total seluruh rincian transaksi individual tagihan.
- Bentuk pengelompokan atau rekapitulasi tidak boleh mengubah nilai transaksi, tanggal/waktu transaksi, status, maupun makna bisnis dari rincian transaksi tagihan.
- Setiap rincian transaksi tagihan harus dapat ditelusuri kembali ke registrasi sumber asalnya.
- Kondisi kunjungan tunggal (tanpa registrasi terkait yang dikaitkan) tetap sah sebagai satu episode pelayanan tagihan yang hanya memuat transaksi dari No. Registrasi Utama.

### 5.4 Completion Proof

- Kesatuan rincian tagihan terbentuk lengkap di bawah No. Registrasi Utama dengan identitas pasien yang konsisten.
- Seluruh rincian transaksi tagihan dari No. Registrasi Utama dan seluruh registrasi yang terhubung tercantum lengkap tanpa ada transaksi yang terlewat atau terduplikasi.
- Setiap baris transaksi tagihan memuat referensi registrasi asal yang dapat diverifikasi secara independen.
- Nilai rekapitulasi tagihan terverifikasi tepat sama dengan total penjumlahan seluruh rincian transaksi tagihan.
- Seluruh riwayat transaksi pembayaran yang telah terjadi untuk kunjungan/episode tersebut terdaftar dan total nilai pembayaran terverifikasi secara akurat.
- Seluruh informasi disajikan secara read-only tanpa adanya mutasi data terhadap transaksi tagihan, transaksi pembayaran, maupun hubungan antar-registrasi.

---

## 6. Outcome Boundary

### Start

Dimulai ketika No. Registrasi Utama ditentukan/diakses untuk satu kunjungan/episode pelayanan pasien, sehingga rincian transaksi tagihan dan pembayaran dari registrasi utama beserta seluruh registrasi yang secara sah telah dikaitkan kepadanya dapat dihimpun dan dikonsolidasikan.

### End

Berakhir ketika kesatuan informasi bisnis mengenai rincian tagihan, rekapitulasi nilai tagihan, dan rincian transaksi pembayaran yang telah terjadi telah berhasil dikonsolidasikan secara lengkap, konsisten, dapat ditelusuri ke registrasi sumbernya, dan siap disajikan secara read-only kepada pemangku kepentingan atau dikonsumsi oleh proses bisnis berikutnya (seperti OC-02-02 Alokasi Pembayaran atau OC-02-04 Reg-Out).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. Satu kunjungan/episode tagihan memiliki tepat satu No. Registrasi Utama sebagai master dan identitas kunjungan/episode.
2. Registrasi lain hanya dianggap sebagai bagian dari kunjungan/episode apabila memiliki hubungan bisnis eksplisit dengan No. Registrasi Utama tersebut.
3. Batasan satu kunjungan/episode ditentukan oleh hubungan registrasi terhadap No. Registrasi Utama, bukan oleh asumsi sistem berdasarkan rentang waktu, unit pelayanan, atau jenis pelayanan.
4. Seluruh transaksi tagihan dari seluruh registrasi yang tergabung menjadi bagian dari kesatuan rincian tagihan kunjungan/episode.
5. Setiap rincian transaksi tagihan harus tetap dapat ditelusuri (traceable) ke registrasi/episode pelayanan yang menjadi sumber transaksi.
6. Informasi pembayaran yang ditampilkan hanya merepresentasikan transaksi pembayaran yang telah terjadi secara faktual beserta rincian transaksinya.
7. OC-02-01 bersifat read-only terhadap business state tagihan: tidak membuat, mengubah, atau menghapus transaksi tagihan.
8. OC-02-01 bersifat read-only terhadap business state pembayaran: tidak membuat, mengubah, atau menghapus transaksi pembayaran.
9. OC-02-01 tidak memiliki tanggung jawab untuk menentukan, membuat, mengubah, atau menghapus relasi antara No. Registrasi Utama dengan registrasi-registrasi terkait (tanggung jawab berada pada subsistem manajemen registrasi Admission).
10. OC-02-01 tidak mengambil alih business responsibility OC-02-02 Alokasi Pembayaran (menentukan bagaimana pembayaran dialokasikan terhadap tagihan), OC-02-03 Deposit (pengelolaan saldo uang jaminan), maupun OC-02-04 Reg-Out (penutupan administrasi kepulangan).
11. Penyajian informasi dalam bentuk rekapitulasi atau pengelompokan atribut bisnis hanya merupakan cara penyajian informasi yang sama dan tidak boleh mengubah makna, nilai nominal, status, atau rincian transaksi individual tagihan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Nomor Registrasi Utama tidak ditemukan atau tidak valid dalam sistem | Pembentukan kesatuan rincian tagihan ditolak. Sistem menginformasikan bahwa No. Registrasi Utama tidak terdaftar sehingga rincian tagihan kunjungan/episode tidak dapat dikonsolidasikan. |
| Inkonsistensi identitas pasien pada registrasi terkait | Terjadi pelanggaran integritas bisnis apabila registrasi yang dikaitkan ke No. Registrasi Utama memiliki Nomor Rekam Medis yang berbeda. Sistem menolak penggabungan rincian tagihan dan memberikan penandaan anomali data untuk diselesaikan oleh pengelola relasi registrasi (Admission). |
| Belum ada transaksi tagihan yang tercatat pada kunjungan/episode | Outcome tetap terbentuk secara sah dengan menyajikan identitas kunjungan/episode, daftar registrasi yang terlibat, nilai rekapitulasi tagihan sebesar nol (0), dan daftar rincian transaksi yang kosong. |
| Belum ada transaksi pembayaran yang terjadi pada kunjungan/episode | Outcome tetap menyajikan rincian tagihan secara utuh, dengan daftar riwayat transaksi pembayaran kosong dan total nilai pembayaran tercatat sebesar nol (0). |
| Relasi registrasi terkait telah dicabut atau diubah pada subsistem registrasi | Transaksi tagihan dari registrasi yang telah diputus atau diubah relasinya secara otomatis tidak lagi diikutsertakan ke dalam kesatuan rincian tagihan kunjungan/episode pada saat konsolidasi dilakukan. |
| Terjadi inkonsistensi matematis antara nilai rekapitulasi dengan rincian transaksi | Sistem mendeteksi adanya ketidaksesuaian integritas finansial dan memblokir penyajian data rekapitulasi yang tidak valid hingga rekonsiliasi data internal terselesaikan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Rincian tagihan merepresentasikan tepat satu No. Registrasi Utama yang valid sebagai identitas master kunjungan/episode beserta identitas pasien yang berkesesuaian. | Completeness |
| AC-02 | Seluruh registrasi yang telah secara eksplisit dikaitkan dengan No. Registrasi Utama teridentifikasi dan diakui sebagai bagian dari kesatuan kunjungan/episode tagihan. | Completeness |
| AC-03 | Seluruh rincian transaksi tagihan (tindakan, obat, barang, pemeriksaan, akomodasi, dsb.) dari No. Registrasi Utama dan seluruh registrasi terkait terhimpun secara utuh tanpa ada yang terlewat atau terduplikasi. | Completeness |
| AC-04 | Setiap baris transaksi rincian tagihan dapat ditelusuri secara akurat ke registrasi sumber dan unit pelayanan asal transaksi. | Correctness |
| AC-05 | Nilai total tagihan kumulatif dan subtotal per kelompok/kategori bisnis tepat sama secara matematis dengan hasil penjumlahan seluruh rincian transaksi tagihan individual. | Correctness |
| AC-06 | Seluruh transaksi pembayaran yang telah terjadi untuk kunjungan/episode tersebut disajikan secara lengkap dengan nomor referensi/bukti, tanggal/waktu, metode, dan nilai nominalnya. | Completeness |
| AC-07 | Rincian tagihan dapat disajikan dalam bentuk kronologis detail waktu, rekapitulasi nilai, serta pengelompokan atribut bisnis yang relevan tanpa mengubah nilai atau makna transaksi tagihan. | Correctness |
| AC-08 | Outcome OC-02-01 tidak melakukan penambahan, pengubahan, atau penghapusan data transaksi tagihan (read-only verification). | Constraint |
| AC-09 | Outcome OC-02-01 tidak melakukan penambahan, pengubahan, atau penghapusan data transaksi pembayaran (read-only verification). | Constraint |
| AC-10 | Outcome OC-02-01 tidak membentuk, mengubah, atau menghapus hubungan keterkaitan antara No. Registrasi Utama dengan registrasi-registrasi terkait. | Constraint |
| AC-11 | Outcome OC-02-01 tidak melakukan alokasi dana pembayaran terhadap komponen atau item tagihan tertentu (tanggung jawab OC-02-02 tetap terpisah). | Constraint |
| AC-12 | Permintaan konsolidasi rincian tagihan untuk No. Registrasi Utama yang tidak terdaftar ditolak dengan pemberitahuan bahwa registrasi tidak valid. | Exception |
| AC-13 | Apabila terdapat registrasi terkait dengan Nomor Rekam Medis yang berbeda dari No. Registrasi Utama, sistem menolak penggabungan rincian dan menandai inkonsistensi identitas pasien. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penentuan, pembuatan, pengubahan, atau pemutusan relasi keterkaitan antara No. Registrasi Utama dengan registrasi-registrasi terkait — merupakan tanggung jawab subsistem pendaftaran/relasi kunjungan (`ADM-REG` / Admission Domain).
- Pembuatan, pembaruan, pembatalan, atau penghapusan transaksi tagihan pelayanan — merupakan tanggung jawab `TRK-BILLING` dan domain-domain klinis/operasional penghasil charge.
- Penerimaan, pencatatan, pembaruan, atau pembatalan transaksi pembayaran kasir — merupakan tanggung jawab `TRK-PAYMENT` dan `TRK-KASIR`.
- Penentuan dan pencatatan alokasi pembayaran terhadap komponen atau saldo tagihan pasien — merupakan tanggung jawab penuh **OC-02-02 Alokasi Pembayaran**.
- Pengelolaan penerimaan, mutasi, pemakaian, dan pengembalian uang jaminan pasien — merupakan tanggung jawab **OC-02-03 Deposit**.
- Pelaksanaan penyelesaian administrasi kepulangan pasien dan penutupan episode kunjungan — merupakan tanggung jawab **OC-02-04 Reg-Out**.
- Pemeliharaan struktur master tarif, jenis tarif, dan harga layanan — merupakan tanggung jawab `TRK-TARIF`.
- Pemeliharaan data master penjamin, grup jaminan, dan polis keanggotaan — merupakan tanggung jawab `TRK-JAMINAN`.
- Desain antarmuka pengguna (UI), tata letak layar (screen layout), tata letak cetak faktur, interaksi filter, tombol drill-down, atau alur navigasi layar — merupakan ranah **Use Case** dan Interaction Design.
