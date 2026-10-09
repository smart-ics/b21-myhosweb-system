# OUTCOME: Opname

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-07     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-09   |

---

## 1. Business Purpose

Rumah sakit mengelola persediaan di berbagai unit operasional, termasuk Bangsal Rawat Inap (SC-06). Untuk memastikan akurasi data dan keandalan informasi persediaan, diperlukan pencatatan operasional berkala maupun insidental untuk memeriksa keberadaan fisik barang secara langsung.

**Opname adalah pencatatan hasil penghitungan fisik persediaan barang di Bangsal Rawat Inap, perbandingannya dengan saldo stok yang tercatat dalam sistem, serta dokumentasi hasil dan selisih pemeriksaan yang telah melalui validasi.**

Fokus utama outcome ini adalah **pencatatan hasil penghitungan fisik, pembandingan dengan stok sistem, pendokumentasian selisih, dan validasi hasil pemeriksaan** hingga mencapai status akhir (**`Disahkan`** atau **`Dikembalikan`**), bukan eksekusi penyesuaian saldo stok (*koreksi stok*).

Opname merupakan **Operational Service Event** (peristiwa operasional pemeriksaan fisik persediaan), bukan Clinical Service Event. Alur sederhananya:

> **Penghitungan fisik dicatat → dibandingkan dengan saldo sistem & dihitung selisihnya → diajukan untuk validasi → divalidasi hingga berstatus Disahkan (atau Dikembalikan untuk diperiksa kembali) → menjadi fakta operasional yang dapat dipertanggungjawabkan.**

Hasil pemeriksaan yang berstatus `Disahkan` menjadi dasar faktual yang akuntabel bagi tindak lanjut operasional. Outcome ini dirancang secara **pragmatis, operasional, dan sederhana untuk MyHospital Web**, tanpa memperluas ruang lingkup ke sistem audit investigatif, prosedur hitung berulang yang rumit, maupun alur persetujuan bertingkat.

---

## 2. Outcome Statement

> Pertanyaan bisnis utama:
> **“Business fact apa yang harus ada setelah Opname terjadi?”**
>
> Jawaban:
> **Terdapat catatan hasil pemeriksaan fisik persediaan di Bangsal Rawat Inap yang membandingkan jumlah fisik dengan saldo stok sistem beserta selisihnya, dan telah diverifikasi status keabsahannya (Draft, Menunggu Validasi, Disahkan, atau Dikembalikan untuk periksa ulang) sebagai fakta operasional yang dapat dipertanggungjawabkan.**

**Opname adalah pencatatan dan verifikasi jumlah fisik persediaan barang di Bangsal Rawat Inap, perbandingannya dengan saldo stok yang tercatat dalam sistem, serta dokumentasi hasil dan selisih pemeriksaan.**

Outcome ini merepresentasikan fakta operasional bahwa:
1. Objek dan lokasi persediaan barang yang diperiksa di Bangsal Rawat Inap teridentifikasi dan dihitung secara fisik;
2. Jumlah fisik barang telah dibandingkan dengan saldo stok yang tercatat di sistem pada saat pemeriksaan, dan selisih stok (apabila ada) tercatat secara transparan;
3. Hasil pemeriksaan fisik dan perbandingannya telah melalui proses verifikasi dengan status yang jelas (*Draft*, *Menunggu Validasi*, *Disahkan*, atau *Dikembalikan* untuk diperiksa/dihitung ulang) sehingga dapat dipertanggungjawabkan secara operasional;
4. Pencatatan dan pengesahan hasil opname berdiri sendiri dan **tidak secara otomatis mengubah atau mengoreksi saldo stok sistem**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Inventory (`INV`) | **Domain Utama (Owner):** Menyediakan kapabilitas pencatatan dan validasi stok opname (`INV-OPNAME`), referensi saldo stok sistem (`INV-STOK`), serta referensi item master barang (`INV-MASTER`). |
| Rawat Inap (`RNA`) | **Operational Context Domain:** Menyediakan konteks operasional lingkungan bangsal rawat inap sebagai unit operasional tempat pemeriksaan fisik berlangsung (khususnya untuk SC-06). |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan referensi unit layanan atau ruangan bangsal tempat persediaan diperiksa (`ORG-LAYANAN`), serta staf atau petugas yang melakukan penghitungan fisik, pencatatan, dan validasi (`ORG-PPA`). |

> **Catatan Batasan Domain:**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain dan Capability. Outcome ini tidak mengambil alih kepemilikan atas transaksi pemakaian barang (`INV-PAKAI`), mutasi barang (`INV-MUTASI`), pengadaan (`PUR`), pemusnahan barang (`INV-MUSNAH`), maupun tindakan klinis (`OC-06-01`).
>
> Outcome ini secara tegas memisahkan pencatatan opname dari tindakan **Koreksi Stok**; koreksi stok merupakan aktivitas logistik terpisah dalam domain Inventory yang memerlukan kewenangan tersendiri dan tidak dieksekusi secara otomatis oleh outcome Opname. Domain pendukung berpartisipasi murni sebagai penyedia konteks lokasi bangsal dan petugas pelaksana/validator.

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
- Status hasil opname teridentifikasi secara jelas (*Draft*, *Menunggu Validasi*, *Disahkan*, atau *Dikembalikan*).
- Waktu pencatatan atau pelaksanaan opname teridentifikasi.
- Hasil opname telah dicatat sebagai fakta operasional yang dapat dipertanggungjawabkan tanpa mengubah saldo stok sistem secara otomatis.

### 5.2 Required Recorded Information

Pencatatan Opname mencatat informasi bisnis utama:
- **Lokasi / Bangsal:** Identitas unit atau ruangan bangsal rawat inap tempat persediaan diperiksa.
- **Barang yang Diperiksa:** Identitas barang persediaan yang dihitung.
- **Jumlah Fisik:** Kuantitas aktual hasil penghitungan fisik (≥ 0).
- **Saldo Stok Sistem:** Kuantitas saldo stok yang tercatat di sistem pada saat pemeriksaan.
- **Selisih Stok:** Selisih kuantitas antara jumlah fisik dan saldo sistem (`Jumlah Fisik - Saldo Stok Sistem`).
- **Waktu Pemeriksaan / Opname:** Waktu dilakukannya penghitungan fisik atau pencatatan opname.
- **Petugas Pencatat / Penghitung:** Identitas petugas yang melakukan pencatatan atau penghitungan fisik.
- **Status Hasil Opname:**
  - **`Draft`:** Hasil opname masih dalam tahap pencatatan atau belum diajukan untuk validasi.
  - **`Menunggu Validasi`:** Hasil penghitungan fisik telah dicatat lengkap dan diajukan untuk proses validasi.
  - **`Disahkan`:** Status hasil opname yang telah divalidasi dan dinyatakan valid.
  - **`Dikembalikan`:** Status hasil opname yang belum dapat diterima saat validasi dan perlu diperiksa atau diperbaiki kembali.

**Informasi Pendukung Operasional (Sesuai Kebutuhan):**
- **Petugas Validator:** Identitas petugas yang melakukan validasi hasil opname.
- **Waktu Validasi:** Waktu saat validasi diselesaikan dan status hasil opname ditetapkan (*Disahkan* atau *Dikembalikan*).
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
- **Pencatatan opname dan penetapan status Disahkan tidak secara otomatis mengubah saldo stok sistem.**

### 5.4 Completion Proof

Outcome ini dinyatakan mencapai hasil akhir (*established*) apabila proses Opname telah selesai divalidasi dan mencapai salah satu status akhir berikut:

1. **`Disahkan`:** Hasil penghitungan fisik persediaan di Bangsal Rawat Inap telah divalidasi dan dinyatakan valid sebagai fakta operasional yang dapat dipertanggungjawabkan (menjadi dasar tindak lanjut).
2. **`Dikembalikan`:** Hasil Opname belum dapat diterima saat validasi dan ditetapkan perlu diperiksa atau diperbaiki kembali. Status `Dikembalikan` menandakan selesainya proses validasi tahap berjalan dengan keputusan pengembalian (bukan berarti hasil telah disahkan).

> **Catatan Status Proses Berjalan (In-Progress):**
> Status `Draft` dan `Menunggu Validasi` mencerminkan proses pencatatan dan pengajuan yang masih berjalan (*in-progress*) dan **bukan** merupakan bukti bahwa outcome Opname telah mencapai hasil akhir.

**Kemandirian Hasil Opname:**
Keabsahan bukti ketercapaian outcome ini berdiri sendiri dan tidak bergantung pada pelaksanaan transaksi koreksi saldo stok sistem otomatis, penyesuaian nilai buku akuntansi (*stock valuation*), alur persetujuan audit bertingkat yang rumit, maupun mekanisme investigasi selisih mendalam.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas menginisiasi pencatatan penghitungan fisik persediaan barang pada lokasi Bangsal Rawat Inap.

### End

Berakhir ketika hasil penghitungan fisik persediaan dan perbandingannya dengan saldo stok sistem telah selesai divalidasi serta mencapai status akhir: **`Disahkan`** (hasil dinyatakan valid) atau **`Dikembalikan`** (hasil perlu diperiksa atau diperbaiki kembali).

> **Catatan Batasan Boundary:**
> Boundary Opname berfokus pada pencatatan, perbandingan stok, dan validasi hasil pemeriksaan fisik persediaan di bangsal. Boundary secara tegas **tidak mencakup pelaksanaan penyesuaian saldo stok (*Koreksi Stok*)**, jurnal pembukuan akuntansi atas selisih persediaan, maupun audit investigatif.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Definisi dan Fokus Opname:** Opname adalah pencatatan hasil penghitungan fisik persediaan dan perbandingannya dengan stok sistem di Bangsal Rawat Inap, serta dokumentasi selisihnya.
2. **Pemisahan Tegas dari Koreksi Stok (Opname ≠ Koreksi Stok):**
   - Opname **tidak otomatis mengubah saldo stok sistem** berdasarkan hasil penghitungan fisik.
   - Koreksi Stok merupakan aktivitas terpisah yang dapat menggunakan hasil Opname yang telah disahkan sebagai dasar tindak lanjut, sesuai kewenangan dan ketentuan yang berlaku.
   - Penetapan status `Disahkan` pada hasil Opname tidak sama dengan persetujuan atau pelaksanaan Koreksi Stok.
3. **Pemisahan dari Aktivitas Persediaan Lainnya:**
   - **Bukan Pakai Barang (`OC-06-05`):** Opname memeriksa kuantitas fisik persediaan yang ada, bukan mencatat pemakaian atau konsumsi barang dalam pelayanan.
   - **Bukan Mutasi Barang (`OC-06-06`):** Opname memverifikasi stok di lokasi tertentu, bukan memindahkan fisik barang antar-lokasi/unit.
   - **Bukan Penerimaan Barang (`PUR-DO`):** Opname bukan penerimaan barang baru dari pemasok/supplier.
4. **Pragmatis dan Bebas dari Kompleksitas Audit Berlebihan:**
   - Tidak mencakup sistem audit persediaan yang rumit, investigasi forensik kecurangan, prosedur hitung berulang kompleks (*double-blind counting*), maupun persetujuan bertingkat (*multi-tier approval*).
   - Detail kewenangan validasi mengikuti kebijakan rumah sakit yang berlaku tanpa mengasumsikan struktur hierarki khusus.
5. **Kemandirian dari Akuntansi Finansial:**
   - Catatan hasil opname bersifat mandiri dan tidak mensyaratkan valuasi moneter selisih (nilai rupiah), penentuan harga pokok persediaan (FIFO/FEFO/Average), atau pembuatan jurnal akuntansi.
6. **Kejelasan Status dan Validasi:**
   - Status `Draft` dan `Menunggu Validasi` merupakan status proses berjalan (*in-progress*).
   - Hasil akhir opname dicapai saat berstatus `Disahkan` (hasil dinyatakan valid) atau `Dikembalikan` (hasil perlu diperiksa atau diperbaiki kembali).

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
| Hasil penghitungan fisik belum dapat diterima saat validasi atau memerlukan perbaikan | **Hasil opname dikembalikan.** Status diubah menjadi *Dikembalikan* untuk diperiksa atau diperbaiki kembali, disertai catatan alasan pengembalian jika diperlukan. |
| Terdapat selisih antara jumlah fisik dan saldo stok sistem | **Kondisi bisnis yang sah (bukan exception teknis).** Selisih (positif atau negatif) tetap dicatat sebagaimana adanya; hasil opname tetap dapat divalidasi dan disahkan tanpa otomatis mengubah saldo sistem. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Opname telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Sistem dapat mencatat objek barang, lokasi Bangsal Rawat Inap, hasil penghitungan fisik persediaan, perbandingannya dengan saldo stok sistem, serta selisih stok yang ditemukan sebagai fakta operasional. | Completeness |
| AC-02 | Status proses opname dapat dikelola secara jelas (*Draft* dan *Menunggu Validasi* sebagai proses berjalan). | Completeness |
| AC-03 | Outcome mencapai hasil akhir ketika hasil opname berstatus *Disahkan* (hasil dinyatakan valid) atau *Dikembalikan* (hasil perlu diperiksa atau diperbaiki kembali). | Completeness |
| AC-04 | Hasil opname yang belum dapat diterima saat validasi dapat ditetapkan berstatus *Dikembalikan* dengan pencatatan alasan pengembalian jika diperlukan. | Completeness |
| AC-05 | Hasil opname yang telah *Disahkan* menjadi dokumen operasional yang valid dan dapat dipertanggungjawabkan sebagai dasar tindak lanjut. | Correctness |
| AC-06 | Penetapan status *Disahkan* pada hasil opname secara tegas tidak otomatis mengubah atau memutakhirkan saldo stok sistem (Opname ≠ Koreksi Stok). | Constraint |
| AC-07 | Koreksi Stok ditegaskan sebagai aktivitas terpisah yang dapat menggunakan hasil opname yang telah disahkan sebagai dasar, bukan bagian dari pembentukan outcome Opname. | Constraint |
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
