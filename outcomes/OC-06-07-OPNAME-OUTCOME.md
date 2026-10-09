# OUTCOME: Opname

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-07     |
| Version     | 1.4          |
| Status      | Draft        |
| LastUpdated | 2026-10-09   |

---

## 1. Business Purpose

Rumah sakit mengelola persediaan barang di berbagai unit operasional, termasuk Bangsal Rawat Inap (SC-06). Untuk memastikan keandalan informasi persediaan, diperlukan pencatatan operasional untuk memverifikasi kesesuaian antara fisik barang di bangsal dengan catatan saldo sistem.

**Opname adalah pencatatan hasil penghitungan fisik persediaan barang di Bangsal Rawat Inap, perbandingannya dengan saldo stok sistem, serta dokumentasi hasil dan selisih pemeriksaan yang telah melalui validasi.**

Fokus utama outcome ini adalah **pencatatan hasil fisik, pembandingan stok sistem, dokumentasi selisih, dan validasi hasil pemeriksaan** hingga mencapai status akhir (**`Disahkan`** atau **`Dikembalikan`**). Opname berfokus pada verifikasi fisik dan tidak mengubah saldo stok sistem secara otomatis; penyesuaian saldo, jika diperlukan, merupakan aktivitas Koreksi Stok yang terpisah (lihat Bagian 7).

Opname merupakan **Operational Service Event** (peristiwa operasional pemeriksaan fisik persediaan), bukan Clinical Service Event. Alur sederhananya:

> **Penghitungan fisik dicatat → dibandingkan dengan saldo sistem & dihitung selisihnya → diajukan untuk validasi → divalidasi hingga mencapai keputusan akhir (Disahkan atau Dikembalikan) → menjadi fakta operasional yang dapat dipertanggungjawabkan.**

Hasil pemeriksaan yang berstatus `Disahkan` membuktikan keabsahan hasil opname sebagai dasar faktual bagi tindak lanjut. Outcome ini dirancang pragmatis dan sederhana untuk kebutuhan MyHospital Web tanpa memperluas ruang lingkup ke audit investigatif atau persetujuan bertingkat.

---

## 2. Outcome Statement

> Pertanyaan bisnis utama:
> **“Business fact apa yang harus ada setelah Opname terjadi?”**
>
> Jawaban:
> **Terdapat catatan hasil penghitungan fisik persediaan di Bangsal Rawat Inap yang membandingkan jumlah fisik dengan saldo stok sistem beserta selisihnya, yang telah selesai divalidasi dan mencapai status akhir: Disahkan (hasil dinyatakan sah) atau Dikembalikan (hasil dikembalikan untuk ditindaklanjuti).**

Outcome ini merepresentasikan fakta operasional bahwa:
1. Objek dan lokasi persediaan barang yang diperiksa di Bangsal Rawat Inap teridentifikasi dan dihitung secara fisik;
2. Jumlah fisik barang dibandingkan dengan saldo stok sistem dan selisihnya (apabila ada) tercatat secara transparan;
3. Status proses opname terkelola secara tegas antara status proses berjalan (`Draft`, `Menunggu Validasi`) dan status akhir validasi (`Disahkan`, `Dikembalikan`), dengan rincian makna status mengacu pada Bagian 7.4;
4. Hasil opname berdiri sendiri dan **tidak secara otomatis mengubah saldo stok sistem** (lihat Bagian 7.2).

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Inventory (`INV`) | **Domain Utama (Owner):** Menyediakan kapabilitas pencatatan dan validasi stok opname (`INV-OPNAME`), referensi saldo stok sistem (`INV-STOK`), serta referensi item master barang (`INV-MASTER`). |
| Rawat Inap (`RNA`) | **Operational Context Domain:** Menyediakan konteks operasional lingkungan bangsal rawat inap sebagai unit tempat pemeriksaan fisik berlangsung (SC-06). |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan referensi unit layanan atau ruangan bangsal (`ORG-LAYANAN`), serta petugas pelaksana dan validator (`ORG-PPA`). |

> **Catatan Batasan Domain:**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain dan Capability. Outcome ini berfokus pada verifikasi fisik persediaan di bangsal dan tidak mengambil alih transaksi logistik lain (`INV-PAKAI`, `INV-MUTASI`, `PUR-DO`), tindakan klinis (`OC-06-01`), maupun aktivitas Koreksi Stok yang terpisah (lihat Bagian 7).

---

## 4. Participating Capabilities

| Capability | Domain | Status | Konteks Partisipasi |
|------------|--------|--------|---------------------|
| `INV-OPNAME` Stok Opname | Inventory | Known | Menyediakan kapabilitas pencatatan penghitungan fisik persediaan, pembandingan terhadap saldo stok sistem, dokumentasi selisih, dan proses validasi hasil opname. |
| `INV-STOK` Stok | Inventory | Known | Menyediakan referensi saldo stok persediaan yang tercatat di sistem pada saat pemeriksaan untuk pembandingan kuantitas. |
| `INV-MASTER` Item Master | Inventory | Known | Menyediakan referensi identitas item barang/persediaan yang sah di rumah sakit. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit kerja, bangsal rawat inap, atau ruangan tempat pemeriksaan fisik barang dilakukan. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi staf atau petugas operasional yang mencatat hasil penghitungan fisik dan petugas yang melakukan validasi hasil opname (sebagai data pendukung transaksi). |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Domain Catalog:**
> Seluruh capability yang tercantum berstatus **Known** dan mengacu pada Domain Catalog yang berlaku. OC-06-07 tidak membuat atau mengasumsikan capability baru. Detail kewenangan validasi mengikuti ketentuan dan kebijakan operasional rumah sakit yang berlaku tanpa mengasumsikan struktur organisasi atau hierarki persetujuan tertentu. Apabila di kemudian hari diperlukan capability tambahan, hal tersebut harus menjadi keputusan Product Owner melalui proses tata kelola yang berlaku.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Fakta Bisnis Utama:**
- Objek persediaan (barang) yang diperiksa teridentifikasi sebagai barang yang sah dalam pengelolaan rumah sakit.
- Lokasi persediaan yang diperiksa di Bangsal Rawat Inap teridentifikasi.
- Jumlah aktual hasil penghitungan fisik barang teridentifikasi dan bernilai non-negatif (≥ 0).
- Saldo stok sistem pada saat opname teridentifikasi untuk barang dan lokasi bersangkutan sebagai data pembanding.
- Selisih antara jumlah fisik dan saldo stok sistem teridentifikasi dan tercatat (0/cocok, positif/selisih lebih, atau negatif/selisih kurang).
- Status hasil opname teridentifikasi secara jelas (`Draft`, `Menunggu Validasi`, `Disahkan`, atau `Dikembalikan`).
- Waktu pencatatan atau pelaksanaan opname teridentifikasi.
- Catatan hasil opname berdiri sendiri dan tidak mengubah saldo stok sistem secara otomatis.

### 5.2 Required Recorded Information

Pencatatan Opname mencatat informasi bisnis utama:
- **Lokasi / Bangsal:** Identitas unit atau ruangan bangsal rawat inap tempat persediaan diperiksa.
- **Barang yang Diperiksa:** Identitas barang persediaan yang dihitung.
- **Jumlah Fisik:** Kuantitas aktual hasil penghitungan fisik (≥ 0).
- **Saldo Stok Sistem:** Kuantitas saldo stok yang tercatat di sistem pada saat pemeriksaan.
- **Selisih Stok:** Selisih kuantitas antara jumlah fisik dan saldo sistem (`Jumlah Fisik - Saldo Stok Sistem`).
- **Waktu Pemeriksaan / Opname:** Waktu dilakukannya penghitungan fisik atau pencatatan opname.
- **Petugas Pencatat / Penghitung:** Identitas petugas yang melakukan pencatatan atau penghitungan fisik.
- **Status Hasil Opname:** Status siklus pemeriksaan hasil opname (definisi lengkap mengacu pada Bagian 7.4):
  - **`Draft`:** Masih dalam tahap pencatatan data fisik.
  - **`Menunggu Validasi`:** Telah dicatat lengkap dan diajukan untuk proses validasi.
  - **`Disahkan`:** Telah divalidasi dan dinyatakan sah.
  - **`Dikembalikan`:** Divalidasi dengan keputusan pengembalian agar ditindaklanjuti (bukan pengesahan).

**Informasi Pendukung Operasional (Sesuai Kebutuhan):**
- **Petugas Validator:** Identitas petugas yang melakukan validasi hasil opname.
- **Waktu Validasi:** Waktu saat validasi diselesaikan dan status akhir ditetapkan (*Disahkan* atau *Dikembalikan*).
- **Catatan / Alasan Pengembalian (Kondisional):** Keterangan alasan pengembalian apabila hasil opname berstatus `Dikembalikan`.
- **Keterangan Tambahan (Opsional):** Catatan operasional terkait kondisi fisik barang atau catatan khusus pemeriksaan.

### 5.3 Required Business Conditions

- Barang yang diperiksa terdaftar sah dalam master barang rumah sakit (`INV-MASTER`).
- Lokasi pemeriksaan merupakan unit/bangsal yang sah di lingkungan rumah sakit (`ORG-LAYANAN`).
- Jumlah fisik hasil penghitungan bernilai non-negatif (≥ 0).
- Saldo stok sistem tersedia sebagai pembanding pada saat opname dilakukan.
- Pengajuan validasi hanya dapat dilakukan dari status *Draft* apabila data penghitungan fisik telah terisi.
- Validasi (penetapan status *Disahkan* atau *Dikembalikan*) hanya dapat dilakukan terhadap hasil opname yang sedang berstatus *Menunggu Validasi*.
- Hasil opname yang berstatus *Dikembalikan* dapat diperiksa atau dihitung ulang dan diperbarui catatannya sebelum diajukan kembali untuk validasi.
- Hasil opname dan penetapan statusnya tidak secara otomatis mengubah saldo stok sistem.

### 5.4 Completion Proof

Outcome ini dinyatakan mencapai hasil akhir (*established*) apabila proses Opname telah selesai divalidasi dan mencapai salah satu status akhir berikut:

1. **`Disahkan`:** Hasil penghitungan fisik persediaan di Bangsal Rawat Inap telah divalidasi dan dinyatakan sah sebagai fakta operasional yang dapat dipertanggungjawabkan (menjadi dasar tindak lanjut terpisah).
2. **`Dikembalikan`:** Siklus validasi berakhir dengan keputusan pengembalian agar hasil opname ditindaklanjuti (diperiksa atau diperbaiki kembali). Status ini bukan pengesahan hasil opname dan tidak dapat dijadikan dasar perubahan saldo stok.

> **Catatan Status Proses Berjalan (In-Progress):**
> Status `Draft` dan `Menunggu Validasi` mencerminkan tahapan proses pencatatan dan pengajuan yang masih berjalan (*in-progress*) dan **bukan** merupakan bukti bahwa outcome Opname telah mencapai hasil akhir.

**Kemandirian Hasil Opname:**
Keabsahan bukti ketercapaian outcome ini berdiri sendiri dan tidak bergantung pada transaksi koreksi saldo stok sistem otomatis, penyesuaian nilai buku akuntansi (*stock valuation*), alur persetujuan bertingkat yang rumit, maupun mekanisme investigasi selisih mendalam.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas menginisiasi pencatatan penghitungan fisik persediaan barang pada lokasi Bangsal Rawat Inap.

### End

Berakhir ketika hasil penghitungan fisik persediaan dan perbandingannya dengan saldo stok sistem telah selesai divalidasi serta mencapai status akhir: **`Disahkan`** (hasil dinyatakan sah) atau **`Dikembalikan`** (hasil dikembalikan untuk ditindaklanjuti).

> **Catatan Batasan Boundary:**
> Boundary Opname berfokus pada pencatatan, perbandingan stok, dan validasi hasil pemeriksaan fisik persediaan di bangsal. Boundary secara tegas tidak mencakup pelaksanaan penyesuaian saldo stok (*Koreksi Stok*), jurnal pembukuan akuntansi selisih persediaan, maupun audit investigatif.

---

## 7. Business Constraints

> Bagian ini merupakan **acuan utama** bagi batasan bisnis, pemisahan aktivitas logistik, dan makna status Opname.

1. **Definisi dan Fokus Opname:**
   Opname adalah pencatatan hasil penghitungan fisik persediaan barang di Bangsal Rawat Inap dan perbandingannya dengan stok sistem, serta dokumentasi selisih dan hasil validasinya.
2. **Batasan Opname dan Koreksi Stok (Acuan Utama):**
   - Opname **tidak mengubah saldo stok sistem secara otomatis** berdasarkan hasil penghitungan fisik.
   - Perubahan saldo stok, jika diperlukan berdasarkan hasil pemeriksaan opname, merupakan aktivitas **Koreksi Stok yang terpisah** sesuai kewenangan dan ketentuan yang berlaku.
   - Penetapan status `Disahkan` pada hasil Opname tidak sama dengan persetujuan atau pelaksanaan Koreksi Stok.
3. **Pemisahan dari Aktivitas Persediaan Lainnya:**
   - **Bukan Pakai Barang (`OC-06-05`):** Opname memeriksa kuantitas fisik persediaan yang ada di lokasi, bukan mencatat pemakaian atau konsumsi barang dalam pelayanan.
   - **Bukan Mutasi Barang (`OC-06-06`):** Opname memverifikasi stok di lokasi tertentu, bukan memindahkan fisik barang antar-lokasi/unit.
   - **Bukan Penerimaan Barang (`PUR-DO`):** Opname bukan penerimaan barang baru dari pemasok/supplier.
4. **Makna dan Pembedaan Status Opname (Acuan Utama):**
   - **Status Proses Berjalan:**
     - **`Draft`:** Hasil opname masih dalam tahap pengisian atau pencatatan data fisik dan belum diajukan untuk validasi.
     - **`Menunggu Validasi`:** Hasil penghitungan fisik telah dicatat lengkap dan diajukan untuk proses validasi. Status ini masih merupakan proses berjalan, bukan bukti ketercapaian akhir outcome.
   - **Status Akhir Validasi:**
     - **`Disahkan`:** Menunjukkan bahwa hasil opname telah divalidasi dan dinyatakan sah sebagai dokumen operasional yang akuntabel. Tindak lanjut berupa Koreksi Stok tetap merupakan aktivitas terpisah dan tidak dilakukan otomatis oleh Opname.
     - **`Dikembalikan`:** Menandai berakhirnya siklus validasi tersebut dengan keputusan pengembalian agar hasil opname ditindaklanjuti (diperiksa atau diperbaiki kembali). Status ini **bukan pengesahan hasil opname**, dan hasil opname berstatus `Dikembalikan` **tidak boleh diperlakukan sebagai hasil opname yang telah disahkan maupun sebagai dasar perubahan saldo stok**.
5. **Pragmatis dan Bebas dari Kompleksitas Berlebihan:**
   - Tidak mencakup sistem audit investigatif forensik, prosedur hitung ganda kompleks (*double-blind counting*), maupun persetujuan bertingkat (*multi-tier approval*). Detail kewenangan validasi mengikuti kebijakan rumah sakit yang berlaku tanpa mengasumsikan struktur organisasi tertentu.
6. **Kemandirian dari Akuntansi Finansial:**
   - Catatan hasil opname bersifat mandiri dan tidak mensyaratkan valuasi moneter selisih (nilai rupiah), perhitungan harga pokok persediaan (FIFO/FEFO/Average), atau pembuatan jurnal akuntansi.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Barang tidak valid atau tidak terdaftar dalam master barang rumah sakit | **Pencatatan ditolak.** Pemeriksaan opname hanya dapat dicatat untuk barang yang sah dalam pengelolaan rumah sakit. |
| Lokasi bangsal/unit tidak valid dalam sistem | **Pencatatan ditolak.** Lokasi pemeriksaan harus merupakan unit layanan atau bangsal yang sah. |
| Jumlah fisik bernilai negatif (< 0) | **Pencatatan ditolak.** Kuantitas fisik hasil penghitungan harus bernilai non-negatif (≥ 0). |
| Pengajuan validasi dilakukan saat data penghitungan fisik belum terisi | **Pengajuan ditolak.** Data hasil penghitungan fisik wajib terisi sebelum diajukan ke status *Menunggu Validasi*. |
| Tindakan validasi (penetapan status *Disahkan* atau *Dikembalikan*) dilakukan pada hasil opname yang masih berstatus Draft | **Aksi ditolak.** Validasi hanya dapat diproses terhadap hasil opname yang berstatus *Menunggu Validasi*. |
| Hasil penghitungan fisik belum dapat diterima saat validasi atau memerlukan perbaikan | **Hasil opname dikembalikan.** Status diubah menjadi *Dikembalikan* agar ditindaklanjuti (diperiksa atau diperbaiki kembali), disertai catatan alasan pengembalian jika diperlukan. |
| Terdapat selisih antara jumlah fisik dan saldo stok sistem | **Kondisi bisnis yang sah (bukan exception teknis).** Selisih (positif atau negatif) tetap dicatat sebagaimana adanya; hasil opname tetap dapat divalidasi dan disahkan tanpa otomatis mengubah saldo sistem. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Opname telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Sistem dapat mencatat objek barang, lokasi Bangsal Rawat Inap, hasil penghitungan fisik persediaan, perbandingannya dengan saldo stok sistem, serta selisih stok yang ditemukan sebagai fakta operasional. | Completeness |
| AC-02 | Status proses opname dapat dikelola secara jelas (*Draft* dan *Menunggu Validasi* sebagai status proses berjalan). | Completeness |
| AC-03 | Outcome mencapai hasil akhir ketika hasil opname berstatus *Disahkan* (hasil dinyatakan sah) atau *Dikembalikan* (hasil dikembalikan untuk ditindaklanjuti). | Completeness |
| AC-04 | Status *Dikembalikan* secara eksplisit dimaknai sebagai akhir siklus validasi untuk pengembalian hasil opname agar ditindaklanjuti, bukan pengesahan hasil opname, dan tidak dapat dijadikan dasar perubahan saldo stok. | Constraint |
| AC-05 | Status *Disahkan* membuktikan bahwa hasil opname telah disahkan secara operasional, sedangkan tindak lanjut Koreksi Stok tetap merupakan aktivitas terpisah dan tidak dilakukan otomatis oleh Opname. | Correctness |
| AC-06 | Hasil opname yang belum dapat diterima saat validasi dapat ditetapkan berstatus *Dikembalikan* dengan pencatatan alasan pengembalian jika diperlukan. | Completeness |
| AC-07 | Penetapan status *Disahkan* pada hasil opname secara tegas tidak otomatis mengubah atau memutakhirkan saldo stok sistem (Opname ≠ Koreksi Stok). | Constraint |
| AC-08 | Opname dapat dibedakan secara tegas dari transaksi Pakai Barang (`OC-06-05`), Mutasi Barang (`OC-06-06`), dan Penerimaan Barang (`PUR-DO`). | Constraint |
| AC-09 | Spesifikasi outcome bersifat pragmatis tanpa alur persetujuan audit bertingkat yang rumit, investigasi forensik, atau hierarki kewenangan di luar kebijakan yang berlaku. | Constraint |
| AC-10 | Catatan hasil opname bersifat mandiri dan tidak mensyaratkan atribut valuasi moneter persediaan, jurnal akuntansi, atau metode kalkulasi costing. | Constraint |
| AC-11 | Hasil penghitungan fisik dengan kuantitas bernilai negatif (< 0) ditolak oleh sistem. | Exception |
| AC-12 | Spesifikasi Outcome Opname tetap *implementation-independent* tanpa bergantung pada skema tabel database, endpoint API, format UI, atau mekanisme sistem. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pelaksanaan dan eksekusi transaksi Koreksi Stok / penyesuaian saldo persediaan dalam sistem (*stock balance adjustment*).
- Penggunaan atau konsumsi barang dalam pelayanan klinis atau operasional bangsal (`OC-06-05 Pakai Barang` / `INV-PAKAI`).
- Mutasi atau perpindahan fisik barang antar-lokasi/unit di rumah sakit (`OC-06-06 Mutasi Barang` / `INV-MUTASI`).
- Penerimaan barang pertama kali dari supplier atau pengadaan eksternal (`PUR-DO`).
- Penghapusan, pembuangan, atau pemusnahan barang rusak/kedaluwarsa (`INV-MUSNAH`).
- Sistem investigasi audit persediaan lanjutan, audit investigatif kecurangan (*fraud*), atau audit forensik kerugian aset.
- Mekanisme persetujuan hierarkis berjenjang (*multi-tier hierarchical approval workflow*) yang rumit.
- Prosedur penghitungan fisik ganda yang kompleks (*double-blind audit counting*).
- Valuasi moneter persediaan, penyesuaian nilai buku, dan penjurnalan akuntansi keuangan/buku besar (*general ledger*).
- Skema tabel database, rancangan endpoint API, format penomoran dokumen internal sistem, dan tata letak antarmuka pengguna (UI).
