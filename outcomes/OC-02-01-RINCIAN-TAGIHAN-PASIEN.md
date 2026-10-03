# OUTCOME: Rincian Tagihan Pasien

| Field       | Value        |
|-------------|--------------|
| Code        | OC-02-01     |
| Version     | 2.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Rumah sakit memerlukan jaminan bisnis bahwa tagihan satu episode pelayanan pasien telah diverifikasi secara lengkap dan ditetapkan berstatus **Final** oleh user Tata Rekening, sehingga tagihan tersebut terkunci dari penambahan billing baru dan dapat menjadi dasar yang sah bagi proses bisnis berikutnya.

Satu episode pelayanan pasien tidak selalu hanya terdiri dari satu registrasi tunggal, melainkan dapat mencakup satu No. Registrasi Utama beserta seluruh registrasi yang secara eksplisit telah dikaitkan kepadanya. Outcome ini memungkinkan Tata Rekening untuk mengonsolidasikan seluruh billing episode, menelusuri setiap transaksi ke registrasi sumbernya, meninjau recap/grouping dan histori pembayaran, serta menetapkan tagihan berstatus `Final` setelah verifikasi dinyatakan selesai.

---

## 2. Outcome Statement

Tagihan untuk satu episode pelayanan pasien — yang dibatasi oleh tepat satu No. Registrasi Utama beserta seluruh registrasi yang secara eksplisit telah dikaitkan kepadanya — **telah tersedia secara lengkap, dapat ditelusuri ke sumber registrasinya, telah diverifikasi oleh user Tata Rekening, dan ditetapkan berstatus `Final`; sehingga billing pada episode tersebut terkunci dari penambahan baru dan tagihan `Final` tersebut dapat menjadi prerequisite bagi OC-02-02 Alokasi Pembayaran dan OC-02-04 Reg-Out**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Tata Rekening | Pemilik business state tagihan: memelihara transaksi billing (`TRK-BILLING`), data penjamin/cara bayar (`TRK-JAMINAN`), dan transaksi pembayaran yang telah terjadi (`TRK-PAYMENT`). User Tata Rekening berwenang melakukan verifikasi dan menetapkan status tagihan menjadi `Final`. |
| Admission | Pemilik entitas registrasi dan relasi antar-registrasi: menetapkan No. Registrasi Utama dan memelihara hubungan registrasi yang menjadi penentu batasan bisnis (business boundary) satu episode tagihan (`ADM-REG`). |
| Pasien | Pemilik identitas pasien: menyediakan data sosial dan identitas sah pasien (Nomor Rekam Medis dan nama pasien) yang menjadi subjek pemilik episode tagihan (`PAS-DATSOS`). |

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

- Satu **No. Registrasi Utama** yang sah diakui sebagai master dan identitas tunggal atas satu episode pelayanan pasien.
- Seluruh registrasi yang secara eksplisit telah dikaitkan dengan No. Registrasi Utama diakui sebagai bagian integral dari episode tagihan tersebut.
- Batasan satu episode tagihan ditentukan murni oleh relasi registrasi terhadap No. Registrasi Utama, bukan oleh asumsi waktu, unit, maupun jenis pelayanan.
- Seluruh billing dari No. Registrasi Utama maupun registrasi-registrasi terkait terhimpun secara lengkap dan konsisten, dengan setiap billing dapat ditelusuri ke registrasi sumbernya.
- Rekapitulasi nilai tagihan dan pengelompokan (grouping) terhitung secara akurat dan konsisten secara matematis dengan rincian transaksi billing; recap/grouping tidak mengubah makna, nilai, atau status transaksi.
- Transaksi pembayaran yang sudah terjadi tersedia sebagai informasi pendukung verifikasi.
- **Business state tagihan ditetapkan `Final`** oleh user Tata Rekening yang berwenang setelah seluruh kondisi verifikasi terpenuhi.
- Setelah status `Final` ditetapkan, episode/register pelayanan tersebut terkunci sehingga proses atau user lain tidak dapat lagi menambahkan billing baru ke episode/register tersebut.
- Status `Final` menjadi prerequisite bagi OC-02-02 Alokasi Pembayaran dan OC-02-04 Reg-Out.

### 5.2 Required Recorded Information

**Identitas Episode (Master):**
- No. Registrasi Utama sebagai identitas master episode tagihan.
- Identitas Pasien (Nomor Rekam Medis, Nama Pasien).
- Jenis/konteks pelayanan registrasi utama (Rawat Jalan, Rawat Inap, atau IGD).
- Tanggal dan waktu registrasi utama dibuka.
- Status bisnis tagihan episode (`Final` atau belum Final).

**Daftar Registrasi yang Termasuk Episode:**
- Daftar nomor registrasi yang secara eksplisit dikaitkan dengan No. Registrasi Utama.
- Jenis pelayanan dan unit/instalasi asal untuk masing-masing registrasi terkait.
- Tanggal dan waktu masing-masing registrasi terkait dibuka.

**Rincian Billing (Billing Details):**
- No. registrasi sumber yang menghasilkan transaksi billing (No. Registrasi Utama atau salah satu registrasi terkait).
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

**Payment Information (Informasi Pendukung Verifikasi):**
- Referensi transaksi pembayaran dan nomor bukti bayar.
- Tanggal dan waktu transaksi pembayaran dilakukan.
- Metode/channel pembayaran dan kasir.
- Nilai pembayaran per transaksi.
- Histori seluruh pembayaran yang sudah terjadi untuk episode tersebut.
- Total akumulasi pembayaran yang telah diterima.

**Ringkasan Posisi Finansial Episode:**
- Total akumulasi nilai billing.
- Total akumulasi nilai pembayaran yang telah terjadi.
- Selisih antara total billing dan total pembayaran yang telah dilakukan.

### 5.3 Required Business Conditions

**Kondisi untuk Konsolidasi Billing Episode:**
- No. Registrasi Utama harus valid dan terdaftar resmi dalam sistem Admission (`ADM-REG`).
- Keterkaitan antara registrasi-registrasi dengan No. Registrasi Utama harus telah terbentuk secara eksplisit melalui mekanisme yang berwenang; billing dari suatu registrasi hanya diikutsertakan ke dalam episode apabila relasi tersebut telah aktif secara sah.
- Setiap baris billing harus dapat ditelusuri ke registrasi sumber asalnya.
- Rekapitulasi/grouping harus mempertahankan integritas matematis mutlak terhadap detail billing.

**Kondisi untuk Finalisasi:**
- Seluruh billing episode telah terkonsolidasi dari No. Registrasi Utama dan seluruh registrasi terkait.
- Setiap billing dapat ditelusuri ke registrasi sumbernya.
- Data billing memenuhi business conditions untuk Finalisasi sebagaimana dinilai oleh user Tata Rekening.
- User Tata Rekening telah melakukan verifikasi dan menyatakan tagihan layak untuk difinalisasi.
- Tidak terdapat kondisi bisnis yang memblokir Finalisasi (lihat Seksi 8 Business Exceptions).

**Kondisi setelah status `Final` ditetapkan:**
- Tidak ada billing baru yang dapat ditambahkan ke episode/register tersebut.
- Status `Final` menjadi kondisi yang dapat diverifikasi secara independen oleh OC-02-02 dan OC-02-04.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Tagihan episode memiliki business state `Final` yang dapat diverifikasi.
- Status `Final` diakui sebagai fakta bisnis oleh OC-02-02 Alokasi Pembayaran dan OC-02-04 Reg-Out sebagai prerequisite untuk memulai prosesnya.
- Episode/register pelayanan tersebut tidak dapat menerima penambahan billing baru setelah `Final` ditetapkan.
- Seluruh billing episode tercantum lengkap, tanpa ada yang terlewat atau terduplikasi, dan setiap billing memuat referensi registrasi sumber yang dapat diverifikasi secara independen.
- Nilai rekapitulasi tagihan terverifikasi tepat sama dengan total penjumlahan seluruh rincian billing.
- User Tata Rekening yang berwenang tercatat sebagai pihak yang melakukan Finalisasi.

---

## 6. Outcome Boundary

### Start

Dimulai ketika user Tata Rekening perlu memverifikasi tagihan episode pelayanan pasien berdasarkan No. Registrasi Utama, sehingga seluruh billing dari No. Registrasi Utama beserta registrasi yang secara eksplisit telah dikaitkan kepadanya perlu dikonsolidasikan, ditelusuri ke sumber registrasinya, dan siap untuk diverifikasi.

### End

Berakhir ketika:
1. Seluruh billing episode telah terkonsolidasi dan dapat ditelusuri ke registrasi sumbernya.
2. Seluruh billing memenuhi business conditions untuk Finalisasi.
3. User Tata Rekening telah melakukan verifikasi.
4. Tagihan episode ditetapkan berstatus `Final`.
5. Konsekuensi locking berlaku — episode/register tidak dapat menerima penambahan billing baru.

Apabila verifikasi tidak dapat menghasilkan `Final` karena terdapat ketidaksesuaian bisnis yang tidak dapat diselesaikan oleh Tata Rekening, Outcome ini tidak dianggap selesai (failed completion) — lihat Seksi 8 Business Exceptions.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. Satu episode tagihan memiliki tepat satu No. Registrasi Utama sebagai master dan identitas episode.
2. Registrasi lain hanya diikutsertakan ke dalam episode apabila memiliki hubungan bisnis eksplisit dengan No. Registrasi Utama; registrasi yang tidak secara eksplisit terkait tidak boleh dimasukkan.
3. OC-02-01 tidak memiliki tanggung jawab untuk menentukan, membuat, mengubah, atau menghapus relasi antar-registrasi — tanggung jawab tersebut berada pada `ADM-REG` (Admission Domain).
4. Setiap rincian billing harus tetap dapat ditelusuri (traceable) ke registrasi/episode pelayanan yang menjadi sumber transaksi.
5. Recap/grouping tidak boleh mengubah makna, nilai nominal, tanggal/waktu, atau status transaksi billing, dan total recap harus konsisten dengan detail billing.
6. **Rincian billing dan histori pembayaran yang ditampilkan oleh OC-02-01 bersifat read-only terhadap transaksi sumber:**
   - Tidak melakukan pembuatan, pengubahan, atau penghapusan transaksi billing.
   - Tidak melakukan pembuatan, pengubahan, atau penghapusan transaksi pembayaran.
7. **OC-02-01 memiliki business action Finalisasi yang mengubah business state:**
   - User Tata Rekening berwenang melakukan verifikasi dan Finalisasi tagihan.
   - Finalisasi menetapkan status tagihan menjadi `Final`.
   - Status `Final` menyebabkan billing pada episode/register tersebut terkunci dari penambahan baru.
8. OC-02-01 hanya merepresentasikan payment transaction yang sudah terjadi sebagai informasi pendukung verifikasi; OC-02-01 tidak melakukan alokasi pembayaran (tanggung jawab OC-02-02).
9. OC-02-02 Alokasi Pembayaran hanya dapat bekerja terhadap tagihan yang berstatus `Final`.
10. OC-02-04 Reg-Out hanya dapat diproses apabila tagihan episode berstatus `Final`.
11. Kondisi kunjungan tunggal (tanpa registrasi terkait yang dikaitkan) tetap sah sebagai satu episode tagihan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| No. Registrasi Utama tidak ditemukan atau tidak valid | Konsolidasi billing episode ditolak. Sistem menginformasikan bahwa No. Registrasi Utama tidak terdaftar sehingga episode tagihan tidak dapat dikonsolidasikan. |
| Inkonsistensi identitas pasien pada registrasi terkait | Terjadi pelanggaran integritas bisnis apabila registrasi yang dikaitkan memiliki Nomor Rekam Medis berbeda dari No. Registrasi Utama. Sistem menolak penggabungan billing dan menandai inkonsistensi untuk diselesaikan oleh Admission. Outcome tidak dapat mencapai `Final` selama anomali ini belum diselesaikan. |
| Terdapat ketidaksesuaian bisnis yang teridentifikasi saat verifikasi yang tidak dapat diselesaikan oleh Tata Rekening | User Tata Rekening tidak dapat melakukan Finalisasi. Outcome dianggap failed completion. Ketidaksesuaian harus dirujuk kepada pihak yang berwenang (pemilik registrasi sumber atau domain penghasil billing). |
| Terjadi inkonsistensi matematis antara nilai recap dengan rincian billing | Sistem mendeteksi adanya ketidaksesuaian integritas finansial dan memblokir penetapan status `Final` hingga rekonsiliasi internal terselesaikan. |
| Belum ada billing yang tercatat pada episode | Outcome tidak dapat mencapai `Final` karena tidak ada billing yang dapat diverifikasi. Sistem menyajikan episode dengan daftar billing kosong dan nilai nol (0). |
| Relasi registrasi terkait telah dicabut atau diubah oleh Admission | Billing dari registrasi yang telah diputus relasinya secara otomatis tidak lagi diikutsertakan ke dalam episode pada saat konsolidasi dilakukan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------| 
| AC-01 | Tepat satu No. Registrasi Utama yang valid digunakan sebagai master episode tagihan, disertai identitas pasien yang berkesesuaian. | Completeness |
| AC-02 | Seluruh registrasi yang telah secara eksplisit dikaitkan dengan No. Registrasi Utama teridentifikasi dan diakui sebagai bagian dari episode tagihan. | Completeness |
| AC-03 | Registrasi yang tidak secara eksplisit dikaitkan dengan No. Registrasi Utama tidak diikutsertakan ke dalam episode tagihan. | Correctness |
| AC-04 | Seluruh billing dari No. Registrasi Utama dan seluruh registrasi terkait terhimpun secara utuh tanpa ada yang terlewat atau terduplikasi. | Completeness |
| AC-05 | Setiap baris billing dapat ditelusuri secara akurat ke registrasi sumber dan unit pelayanan asal transaksi. | Correctness |
| AC-06 | Nilai total tagihan kumulatif dan subtotal per kelompok/kategori bisnis tepat sama secara matematis dengan penjumlahan seluruh rincian billing individual; recap/grouping tidak mengubah makna transaksi. | Correctness |
| AC-07 | Transaksi pembayaran yang sudah terjadi tersedia sebagai informasi pendukung verifikasi, lengkap dengan referensi, tanggal/waktu, metode, kasir, dan nilai nominal. | Completeness |
| AC-08 | User Tata Rekening dapat melakukan verifikasi terhadap rincian billing, recap/grouping, dan histori pembayaran sebelum melakukan Finalisasi. | Completeness |
| AC-09 | Tagihan episode dapat ditetapkan berstatus `Final` oleh user Tata Rekening yang berwenang apabila seluruh kondisi Finalisasi terpenuhi. | Correctness |
| AC-10 | Setelah tagihan ditetapkan `Final`, episode/register pelayanan tidak dapat menerima penambahan billing baru dari proses atau user manapun. | Constraint |
| AC-11 | Tagihan yang berstatus `Final` dapat dikenali sebagai prerequisite yang sah oleh OC-02-02 Alokasi Pembayaran. | Correctness |
| AC-12 | Tagihan yang berstatus `Final` dapat dikenali sebagai prerequisite yang sah oleh OC-02-04 Reg-Out. | Correctness |
| AC-13 | OC-02-01 tidak membentuk, mengubah, atau menghapus relasi keterkaitan antara No. Registrasi Utama dengan registrasi-registrasi terkait. | Constraint |
| AC-14 | OC-02-01 tidak melakukan alokasi pembayaran terhadap komponen atau item billing tertentu (tanggung jawab OC-02-02 tetap terpisah). | Constraint |
| AC-15 | OC-02-01 tidak membuat, mengubah, atau menghapus transaksi billing. | Constraint |
| AC-16 | OC-02-01 tidak membuat, mengubah, atau menghapus transaksi pembayaran. | Constraint |
| AC-17 | Permintaan konsolidasi untuk No. Registrasi Utama yang tidak terdaftar ditolak dengan pemberitahuan bahwa registrasi tidak valid. | Exception |
| AC-18 | Apabila terdapat registrasi terkait dengan Nomor Rekam Medis yang berbeda dari No. Registrasi Utama, sistem menolak penggabungan billing dan menandai inkonsistensi identitas pasien; Finalisasi tidak dapat dilakukan selama anomali ini belum diselesaikan. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penentuan, pembuatan, pengubahan, atau pemutusan relasi keterkaitan antara No. Registrasi Utama dengan registrasi-registrasi terkait — merupakan tanggung jawab `ADM-REG` (Admission Domain).
- Pembuatan, pembaruan, pembatalan, atau penghapusan transaksi billing pelayanan — merupakan tanggung jawab `TRK-BILLING` dan domain-domain klinis/operasional penghasil charge.
- Penerimaan, pencatatan, pembaruan, atau pembatalan transaksi pembayaran — merupakan tanggung jawab `TRK-PAYMENT` dan `TRK-KASIR`.
- Penentuan dan pencatatan alokasi pembayaran terhadap komponen atau saldo tagihan pasien — merupakan tanggung jawab penuh **OC-02-02 Alokasi Pembayaran**.
- Pengelolaan penerimaan, mutasi, pemakaian, dan pengembalian uang jaminan pasien — merupakan tanggung jawab **OC-02-03 Deposit**.
- Pelaksanaan penyelesaian administrasi kepulangan pasien dan penutupan episode kunjungan — merupakan tanggung jawab **OC-02-04 Reg-Out**.
- Pemeliharaan struktur master tarif, jenis tarif, dan harga layanan — merupakan tanggung jawab `TRK-TARIF`.
- Pemeliharaan data master penjamin, grup jaminan, dan polis keanggotaan — merupakan tanggung jawab `TRK-JAMINAN`.
- Desain antarmuka pengguna (UI), tata letak layar (screen layout), alur navigasi, atau interaksi layar — merupakan ranah **Use Case** dan Interaction Design.
- Mekanisme locking teknis pada level database atau infrastruktur — merupakan tanggung jawab Technical Architecture.
