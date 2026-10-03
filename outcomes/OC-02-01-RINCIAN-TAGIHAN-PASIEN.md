# OUTCOME: Rincian Tagihan Pasien

| Field       | Value        |
|-------------|--------------|
| Code        | OC-02-01     |
| Version     | 2.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Rumah sakit memerlukan kepastian bisnis bahwa tagihan satu episode pelayanan pasien — yang dapat mencakup beberapa registrasi di bawah satu No. Registrasi Utama — telah terkonsolidasi secara lengkap, dapat ditelusuri ke sumber registrasinya, telah diverifikasi, dan dapat ditetapkan berstatus `Final`.

Status `Final` merupakan business state yang memiliki konsekuensi bisnis: setelah tagihan berstatus `Final`, episode tersebut tidak lagi menerima billing baru sebagai bagian dari episode tersebut. Status `Final` menjadi prerequisite bagi proses bisnis berikutnya yang memerlukan tagihan yang telah diverifikasi dan difinalisasi.

Interaksi user Tata Rekening — berupa pemeriksaan rincian billing, verifikasi kelengkapan dan konsistensi tagihan, verifikasi histori pembayaran, serta pelaksanaan Finalisasi — merupakan mekanisme interaksi (Use Case) yang berkontribusi terhadap terbentuknya Outcome ini, bukan Outcome itu sendiri.

---

## 2. Outcome Statement

Tagihan untuk satu episode pelayanan pasien — yang dibatasi oleh satu No. Registrasi Utama beserta seluruh registrasi yang secara eksplisit telah dikaitkan kepadanya — **tersedia secara lengkap, dapat ditelusuri ke sumber registrasinya, telah diverifikasi, dan dapat ditetapkan berstatus `Final`**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Tata Rekening | Pemilik business state tagihan episode. Memelihara transaksi billing (`TRK-BILLING`), data penjamin/cara bayar (`TRK-JAMINAN`), dan transaksi pembayaran (`TRK-PAYMENT`). Domain yang berwenang atas penetapan status tagihan menjadi `Final`. |
| Admission | Pemilik entitas registrasi dan relasi antar-registrasi. Menetapkan No. Registrasi Utama dan memelihara hubungan registrasi yang menjadi penentu batasan bisnis (business boundary) satu episode tagihan (`ADM-REG`). |
| Pasien | Pemilik identitas pasien. Menyediakan data sosial dan identitas sah pasien (Nomor Rekam Medis dan nama pasien) yang menjadi subjek episode tagihan (`PAS-DATSOS`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-PAYMENT` Payment | Tata Rekening | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Identitas Episode:**

- Satu **No. Registrasi Utama** yang sah diakui sebagai master dan identitas tunggal atas satu episode pelayanan pasien.
- Identitas pasien (Nomor Rekam Medis, Nama Pasien) terkait dengan No. Registrasi Utama tersebut.
- Seluruh registrasi yang secara eksplisit telah dikaitkan dengan No. Registrasi Utama diakui sebagai bagian integral dari episode tagihan tersebut.
- Batasan satu episode tagihan ditentukan murni oleh relasi registrasi terhadap No. Registrasi Utama yang telah ditetapkan oleh Admission, bukan oleh asumsi waktu, unit, maupun jenis pelayanan.

**Billing:**

- Seluruh billing yang valid dari No. Registrasi Utama maupun registrasi-registrasi terkait terhimpun secara lengkap dan konsisten tanpa omission maupun duplikasi.
- Setiap billing mempertahankan ketertelusuran (traceability) ke registrasi sumber yang menghasilkan transaksi tersebut.
- Rincian billing mencakup informasi transaksi yang diperlukan untuk verifikasi: sumber registrasi, tanggal/waktu, unit/pelayanan, item/tagihan, kategori, quantity, tarif, nilai tagihan, dan jenis penjamin/cara bayar yang berlaku.
- Rekapitulasi dan pengelompokan (recap/grouping) terhitung secara akurat dan konsisten secara matematis dengan rincian billing; recap/grouping tidak mengubah makna, nilai, atau status transaksi.

**Payment:**

- Seluruh transaksi pembayaran yang telah terjadi untuk episode tersebut tersedia sebagai informasi pendukung verifikasi.
- Informasi pembayaran mencakup: referensi transaksi, tanggal/waktu, metode/channel pembayaran, kasir, dan nilai nominal.
- Histori seluruh pembayaran dan total akumulasi pembayaran tersedia dan dapat diverifikasi.

**Verification:**

- Rincian billing dapat diverifikasi kelengkapannya terhadap seluruh registrasi dalam episode.
- Rincian billing dapat diverifikasi konsistensinya: setiap billing dapat ditelusuri ke sumbernya, recap konsisten dengan detail.
- Histori pembayaran dapat diverifikasi terhadap episode.

**Finalization:**

- Tagihan episode dapat ditetapkan berstatus `Final` setelah seluruh kondisi bisnis untuk verifikasi terpenuhi.
- `Final` merupakan business state, bukan sekadar informasi tampilan.
- Setelah tagihan berstatus `Final`, episode tersebut tidak lagi menerima billing baru sebagai bagian dari episode tersebut.
- Status `Final` dapat dikenali sebagai prerequisite oleh OC-02-02 Alokasi Pembayaran dan OC-02-04 Reg-Out.

### 5.2 Required Recorded Information

**Identitas Episode (Master):**
- No. Registrasi Utama sebagai identitas master episode tagihan.
- Identitas Pasien (Nomor Rekam Medis, Nama Pasien).
- Jenis/konteks pelayanan registrasi utama (Rawat Jalan, Rawat Inap, atau IGD).
- Tanggal dan waktu registrasi utama dibuka.
- Business state tagihan episode (belum Final / `Final`).

**Daftar Registrasi yang Termasuk Episode:**
- Daftar nomor registrasi yang secara eksplisit dikaitkan dengan No. Registrasi Utama.
- Jenis pelayanan dan unit/instalasi asal untuk masing-masing registrasi terkait.
- Tanggal dan waktu masing-masing registrasi terkait dibuka.

**Rincian Billing:**
- Registrasi sumber yang menghasilkan transaksi billing.
- Tanggal dan waktu pencatatan transaksi pelayanan/billing.
- Unit/instalasi dan bagian pelayanan asal transaksi.
- Item pelayanan/barang (nama tindakan, obat, alat, pemeriksaan, kamar, dsb.).
- Klasifikasi/kategori biaya bisnis (tindakan medis, farmasi, laboratorium, radiologi, akomodasi, administrasi, dsb.).
- Quantity dan satuan.
- Nilai tarif satuan dan total nilai transaksi billing.
- Jenis penjamin/cara bayar yang berlaku pada saat transaksi dicatat.

**Recap/Grouping Tagihan:**
- Rekapitulasi nilai tagihan berdasarkan pengelompokan atribut bisnis yang relevan (per kelompok jenis biaya, per unit pelayanan, per registrasi sumber, dsb.).
- Total nilai tagihan kumulatif dari seluruh billing yang tergabung dalam episode.

**Informasi Pembayaran (Pendukung Verifikasi):**
- Referensi transaksi pembayaran.
- Tanggal dan waktu transaksi pembayaran.
- Metode/channel pembayaran dan kasir.
- Nilai nominal pembayaran per transaksi.
- Histori seluruh pembayaran yang telah terjadi untuk episode.
- Total akumulasi pembayaran yang telah diterima.

**Ringkasan Posisi Finansial Episode:**
- Total akumulasi nilai billing.
- Total akumulasi nilai pembayaran yang telah terjadi.
- Selisih antara total billing dan total pembayaran.

### 5.3 Required Business Conditions

**Kondisi untuk Konsolidasi Billing Episode:**
- No. Registrasi Utama harus valid dan terdaftar dalam Admission (`ADM-REG`).
- Keterkaitan registrasi dengan No. Registrasi Utama harus telah terbentuk secara eksplisit oleh domain yang berwenang; billing dari suatu registrasi hanya diikutsertakan ke dalam episode apabila relasi tersebut telah aktif secara sah.
- Setiap billing harus dapat ditelusuri ke registrasi sumber asalnya.
- Rekapitulasi/grouping harus mempertahankan integritas matematis mutlak terhadap detail billing.

**Kondisi untuk Finalisasi:**
- Seluruh billing episode telah terkonsolidasi dari No. Registrasi Utama dan seluruh registrasi terkait.
- Seluruh billing dapat ditelusuri ke registrasi sumbernya.
- Recap/grouping konsisten secara matematis dengan detail billing.
- Verifikasi telah dilakukan dan menyatakan tagihan layak untuk difinalisasi.
- Tidak terdapat kondisi bisnis yang memblokir Finalisasi (lihat Seksi 8 Business Exceptions).

**Kondisi setelah status `Final` ditetapkan:**
- Episode tersebut tidak lagi menerima billing baru sebagai bagian dari episode tersebut.
- Status `Final` menjadi kondisi yang dapat diverifikasi secara independen oleh OC-02-02 dan OC-02-04 sebagai prerequisite.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Tagihan episode memiliki business state `Final` yang dapat diverifikasi secara independen.
- Episode tersebut tidak lagi menerima billing baru sebagai bagian dari episode tersebut.
- Seluruh billing episode tercantum lengkap tanpa omission maupun duplikasi, dan setiap billing memuat referensi registrasi sumber yang dapat ditelusuri.
- Nilai rekapitulasi tagihan terverifikasi tepat sama dengan total penjumlahan seluruh rincian billing.
- Status `Final` dapat dikenali sebagai prerequisite yang sah oleh OC-02-02 Alokasi Pembayaran dan OC-02-04 Reg-Out.

---

## 6. Outcome Boundary

### Start

Dimulai ketika No. Registrasi Utama telah ditentukan dan data billing serta payment untuk episode tersebut dapat dikonsolidasikan untuk dilakukan verifikasi.

### End

Berakhir ketika rincian billing episode telah lengkap, konsisten, dan dapat ditelusuri, telah diverifikasi, dan tagihan telah ditetapkan berstatus `Final`, sehingga episode tersebut tidak lagi menerima billing baru sebagai bagian dari episode tersebut.

Apabila verifikasi tidak dapat menghasilkan `Final` karena terdapat ketidaksesuaian bisnis yang tidak dapat diselesaikan, Outcome ini tidak dianggap selesai (failed completion) — lihat Seksi 8 Business Exceptions.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. Satu episode tagihan memiliki tepat satu No. Registrasi Utama sebagai master dan identitas episode.
2. Registrasi lain hanya diikutsertakan ke dalam episode apabila memiliki hubungan bisnis eksplisit dengan No. Registrasi Utama yang telah ditetapkan oleh Admission; registrasi yang tidak secara eksplisit terkait tidak boleh dimasukkan.
3. Seluruh billing yang valid dari registrasi-registrasi dalam episode harus termasuk dalam konsolidasi tagihan.
4. Setiap rincian billing harus tetap dapat ditelusuri (traceable) ke registrasi sumber yang menghasilkan transaksi tersebut.
5. Recap/grouping tidak boleh mengubah makna, nilai nominal, tanggal/waktu, atau status transaksi billing; total recap harus konsisten secara matematis dengan detail billing.
6. Informasi pembayaran yang disajikan hanya merepresentasikan transaksi pembayaran yang telah terjadi secara faktual.
7. Billing dan payment transaction yang menjadi sumber rincian tagihan bersifat read-only terhadap transaksi sumber: OC-02-01 tidak membuat, mengubah, atau menghapus transaksi billing maupun transaksi pembayaran.
8. OC-02-01 menghasilkan perubahan business state melalui Finalisasi, yaitu menetapkan status tagihan menjadi `Final`. Finalisasi hanya dapat ditetapkan setelah seluruh kondisi bisnis untuk verifikasi terpenuhi.
9. Setelah tagihan berstatus `Final`, episode tersebut tidak lagi menerima billing baru sebagai bagian dari episode tersebut.
10. OC-02-01 tidak memiliki tanggung jawab untuk menentukan, membuat, mengubah, atau menghapus relasi antar-registrasi — tanggung jawab tersebut berada pada `ADM-REG` (Admission Domain).
11. OC-02-01 tidak memiliki tanggung jawab melakukan alokasi pembayaran terhadap tagihan — tanggung jawab tersebut berada pada OC-02-02 Alokasi Pembayaran.
12. OC-02-01 tidak mengambil alih proses Reg-Out — tanggung jawab tersebut berada pada OC-02-04 Reg-Out.
13. Kondisi episode tunggal (tanpa registrasi terkait yang dikaitkan) tetap sah sebagai satu episode tagihan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| No. Registrasi Utama tidak valid atau tidak terdaftar | Konsolidasi billing episode tidak dapat dilakukan. Episode tagihan tidak terbentuk. |
| Hubungan registrasi tidak valid atau tidak konsisten | Registrasi yang memiliki relasi tidak sah tidak diikutsertakan ke dalam episode. Konsolidasi hanya mencakup registrasi yang relasinya valid. |
| Identitas pasien pada registrasi terkait tidak konsisten dengan No. Registrasi Utama | Terjadi pelanggaran integritas bisnis. Penggabungan billing ditolak dan inkonsistensi ditandai untuk diselesaikan oleh domain yang berwenang (Admission). Outcome tidak dapat mencapai `Final` selama anomali ini belum diselesaikan. |
| Billing yang seharusnya termasuk episode tidak dapat ditelusuri ke registrasi sumbernya | Outcome tidak dapat mencapai `Final` karena traceability tidak terpenuhi. Ketidaksesuaian harus dirujuk kepada domain penghasil billing. |
| Terdapat ketidaksesuaian antara detail billing dan recap | Integritas matematis tidak terpenuhi. Penetapan status `Final` diblokir hingga konsistensi antara detail dan recap terverifikasi. |
| Informasi pembayaran tidak valid atau tidak dapat diverifikasi | Informasi pembayaran yang tidak valid tidak disertakan dalam verifikasi. Ketidaksesuaian dirujuk kepada domain yang berwenang (`TRK-PAYMENT`). |
| Kondisi bisnis untuk Finalisasi belum terpenuhi | Tagihan tidak dapat ditetapkan berstatus `Final`. Outcome dianggap failed completion hingga seluruh kondisi bisnis yang diperlukan terpenuhi. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | No. Registrasi Utama yang digunakan sebagai master episode tagihan adalah valid dan disertai identitas pasien yang berkesesuaian. | Completeness |
| AC-02 | Episode mencakup seluruh registrasi yang secara eksplisit telah dikaitkan dengan No. Registrasi Utama. | Completeness |
| AC-03 | Seluruh billing yang valid dari registrasi-registrasi dalam episode tercakup tanpa ada yang hilang atau terduplikasi. | Completeness |
| AC-04 | Setiap billing dapat ditelusuri secara akurat ke registrasi sumber yang menghasilkan transaksi tersebut. | Correctness |
| AC-05 | Recap/grouping billing konsisten secara matematis dengan detail transaksi billing; total recap tepat sama dengan akumulasi detail. | Correctness |
| AC-06 | Histori pembayaran yang telah terjadi untuk episode tersedia dan dapat diverifikasi, lengkap dengan referensi, tanggal/waktu, metode, kasir, dan nilai nominal. | Completeness |
| AC-07 | Total billing dan total pembayaran dapat dihitung secara konsisten. | Correctness |
| AC-08 | Rincian billing, recap/grouping, dan histori pembayaran dapat diverifikasi sebelum Finalisasi dilakukan. | Completeness |
| AC-09 | Tagihan episode dapat ditetapkan berstatus `Final` apabila seluruh kondisi bisnis untuk Finalisasi terpenuhi. | Correctness |
| AC-10 | Setelah tagihan berstatus `Final`, episode tersebut tidak lagi menerima billing baru sebagai bagian dari episode tersebut. | Constraint |
| AC-11 | OC-02-01 tidak membuat, mengubah, atau menghapus transaksi billing maupun transaksi pembayaran sumber. | Constraint |
| AC-12 | OC-02-01 tidak membentuk, mengubah, atau menghapus relasi keterkaitan antar-registrasi. | Constraint |
| AC-13 | OC-02-01 tidak melakukan alokasi pembayaran terhadap tagihan (tanggung jawab OC-02-02). | Constraint |
| AC-14 | OC-02-01 tidak mengambil alih proses Reg-Out (tanggung jawab OC-02-04). | Constraint |
| AC-15 | Tagihan yang berstatus `Final` dapat dikenali sebagai prerequisite yang sah oleh OC-02-02 Alokasi Pembayaran dan OC-02-04 Reg-Out. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penentuan, pembuatan, pengubahan, atau pemutusan relasi keterkaitan antara No. Registrasi Utama dengan registrasi-registrasi terkait — merupakan tanggung jawab `ADM-REG` (Admission Domain).
- Pembuatan, pembaruan, pembatalan, atau penghapusan transaksi billing pelayanan — merupakan tanggung jawab `TRK-BILLING` dan domain-domain klinis/operasional penghasil charge.
- Penerimaan, pencatatan, pembaruan, atau pembatalan transaksi pembayaran — merupakan tanggung jawab `TRK-PAYMENT` dan `TRK-KASIR`.
- Penentuan dan pencatatan alokasi pembayaran terhadap komponen atau saldo tagihan pasien — merupakan tanggung jawab **OC-02-02 Alokasi Pembayaran**.
- Pengelolaan penerimaan, mutasi, pemakaian, dan pengembalian uang jaminan pasien — merupakan tanggung jawab **OC-02-03 Deposit**.
- Pelaksanaan penyelesaian administrasi kepulangan pasien dan penutupan episode kunjungan — merupakan tanggung jawab **OC-02-04 Reg-Out**.
- Pemeliharaan struktur master tarif, jenis tarif, dan harga layanan — merupakan tanggung jawab `TRK-TARIF`.
- Pemeliharaan data master penjamin, grup jaminan, dan polis keanggotaan — merupakan tanggung jawab `TRK-JAMINAN`.
- Desain antarmuka pengguna, tata letak layar, alur navigasi, dan interaksi layar — merupakan ranah Use Case dan Interaction Design.
- Mekanisme teknis untuk mencegah penambahan billing setelah `Final` — merupakan tanggung jawab Architecture dan Implementation.
