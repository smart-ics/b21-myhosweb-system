# OUTCOME: Opname

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-07     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-09   |

---

## 1. Business Purpose

Rumah sakit mengelola persediaan barang medis dan non-medis di berbagai unit operasional, termasuk Bangsal Rawat Inap (SC-06). Untuk memastikan akurasi data dan keandalan informasi persediaan, rumah sakit memerlukan pencatatan operasional berkala maupun insidental untuk memeriksa keberadaan fisik barang secara langsung.

**Opname adalah pencatatan dan verifikasi jumlah fisik persediaan barang di Bangsal Rawat Inap, perbandingannya dengan saldo stok yang tercatat dalam sistem, serta dokumentasi hasil dan selisih pemeriksaan yang telah divalidasi atau disahkan.**

Fokus utama outcome ini adalah **pencatatan hasil penghitungan fisik, pembandingan terhadap catatan sistem, pendokumentasian selisih, serta validasi atau pengesahan hasil pemeriksaan**, bukan eksekusi penyesuaian saldo stok (*koreksi stok*).

Opname merupakan **Operational Service Event** (peristiwa operasional pemeriksaan dan verifikasi persediaan fisik), bukan Clinical Service Event. Alur sederhananya:

> **Barang dihitung fisik di bangsal → dibandingkan dengan saldo sistem & dihitung selisihnya → diajukan untuk validasi → diperiksa dan disahkan (atau dikembalikan untuk hitung ulang) → menjadi fakta operasional hasil pemeriksaan yang dapat dipertanggungjawabkan.**

Hasil pemeriksaan yang telah disahkan menjadi dasar faktual yang akuntabel bagi pengambilan keputusan atau tindak lanjut operasional lanjutan. Outcome ini dirancang secara **pragmatis, operasional, sederhana, dan terfokus pada kebutuhan MyHospital Web**, tanpa memperluas ruang lingkup menjadi sistem audit investigatif yang rumit, prosedur penghitungan ganda yang berbelit, maupun mekanisme persetujuan berlapis yang kaku.

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
| Inventory (`INV`) | **Domain Utama (Owner):** Menyediakan kapabilitas pencatatan dan verifikasi stok opname (`INV-OPNAME`), referensi saldo stok yang tercatat di sistem (`INV-STOK`), serta referensi item master barang (`INV-MASTER`). |
| Rawat Inap (`RNA`) | **Operational Context Domain:** Menyediakan konteks operasional lingkungan bangsal rawat inap sebagai unit operasional tempat pemeriksaan fisik barang berlangsung (khususnya untuk SC-06). |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan referensi unit layanan atau ruangan bangsal tempat persediaan diperiksa (`ORG-LAYANAN`), serta staf atau petugas yang melakukan penghitungan fisik, pencatatan, dan validasi/pengesahan (`ORG-PPA`). |

> **Catatan Batasan Domain:**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain dan Capability. Outcome ini tidak mengambil alih kepemilikan atas transaksi pemakaian barang (`INV-PAKAI`), mutasi barang (`INV-MUTASI`), pengadaan (`PUR`), pemusnahan barang (`INV-MUSNAH`), maupun tindakan klinis (`OC-06-01`).
>
> Outcome ini secara tegas memisahkan pencatatan opname dari tindakan **Koreksi Stok**; koreksi stok merupakan aktivitas logistik terpisah dalam domain Inventory yang memerlukan kewenangan dan kebijakan tersendiri, dan tidak dieksekusi secara otomatis oleh outcome Opname ini. Domain pendukung berpartisipasi murni sebagai penyedia konteks lokasi bangsal dan petugas pelaksana/validator.

---

## 4. Participating Capabilities

| Capability | Domain | Status | Konteks Partisipasi |
|------------|--------|--------|---------------------|
| `INV-OPNAME` Stok Opname | Inventory | Known | Menyediakan kapabilitas pencatatan penghitungan fisik persediaan, pembandingan terhadap saldo sistem, dokumentasi selisih, serta pencatatan status validasi dan pengesahan hasil opname. |
| `INV-STOK` Stok | Inventory | Known | Menyediakan referensi catatan saldo stok persediaan yang tercatat di sistem pada saat pemeriksaan untuk pembandingan kuantitas. |
| `INV-MASTER` Item Master | Inventory | Known | Menyediakan referensi identitas item barang/persediaan yang sah di rumah sakit. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit kerja, bangsal rawat inap, atau ruangan tempat pemeriksaan fisik barang dilakukan. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi staf atau petugas operasional yang mencatat hasil penghitungan fisik dan petugas yang melakukan pemeriksaan/pengesahan hasil opname (sebagai data pendukung transaksi). |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Domain Catalog:**
> Seluruh capability yang tercantum berstatus **Known** dan mengacu pada Domain Catalog yang berlaku. OC-06-07 tidak membuat atau mengasumsikan capability baru. Detail kewenangan pengesahan mengikuti ketentuan dan kebijakan operasional rumah sakit yang berlaku tanpa mengasumsikan struktur organisasi atau hierarki persetujuan tertentu. Apabila di kemudian hari diperlukan capability tambahan, hal tersebut harus menjadi keputusan Product Owner melalui proses tata kelola yang berlaku.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Fakta Bisnis Utama:**
- Objek persediaan (barang) yang diperiksa teridentifikasi sebagai barang yang sah dalam pengelolaan rumah sakit.
- Lokasi persediaan yang diperiksa di Bangsal Rawat Inap teridentifikasi.
- Jumlah aktual hasil penghitungan fisik barang teridentifikasi dan bernilai non-negatif (≥ 0).
- Saldo stok sistem pada saat opname teridentifikasi untuk barang dan lokasi bersangkutan sebagai data pembanding.
- Selisih antara jumlah fisik dan saldo stok sistem teridentifikasi dan tercatat (dapat bernilai 0/cocok, positif/selisih lebih, atau negatif/selisih kurang).
- Status keabsahan hasil opname teridentifikasi secara jelas (*Draft*, *Menunggu Validasi*, *Disahkan*, atau *Dikembalikan*).
- Waktu pencatatan atau pelaksanaan opname teridentifikasi.
- Hasil opname telah dicatat sebagai fakta operasional yang dapat dipertanggungjawabkan tanpa mengubah saldo stok sistem secara otomatis.

### 5.2 Required Recorded Information

Pencatatan Opname mencatat informasi bisnis utama:
- **Lokasi / Bangsal:** Identitas unit atau ruangan bangsal rawat inap tempat persediaan diperiksa.
- **Barang yang Diperiksa:** Identitas barang persediaan yang dihitung.
- **Jumlah Fisik:** Kuantitas aktual hasil penghitungan fisik (≥ 0).
- **Saldo Stok Sistem:** Kuantitas saldo stok yang tercatat di sistem pada saat pemeriksaan.
- **Selisih Stok:** Selisih kuantitas antara jumlah fisik dan saldo sistem (`Jumlah Fisik - Saldo Sistem`).
- **Waktu Pemeriksaan / Opname:** Waktu dilakukannya penghitungan fisik atau pencatatan opname.
- **Petugas Pencatat / Penghitung:** Identitas petugas yang melakukan pencatatan atau penghitungan fisik.
- **Status Hasil Opname:** Status siklus pemeriksaan hasil opname:
  - **`Draft`:** Hasil opname masih dalam tahap pencatatan atau belum diajukan untuk validasi.
  - **`Menunggu Validasi`:** Hasil penghitungan fisik telah dicatat lengkap dan diajukan untuk pemeriksaan/pengesahan.
  - **`Disahkan`:** Hasil opname telah diperiksa dan dinyatakan sah/valid.
  - **`Dikembalikan`:** Hasil opname belum dapat diterima saat pemeriksaan dan dikembalikan untuk diperiksa atau dihitung ulang.

**Informasi Pendukung Operasional (Sesuai Kebutuhan):**
- **Petugas Validator / Pengesah:** Identitas petugas yang melakukan verifikasi, pengesahan, atau pengembalian hasil opname.
- **Waktu Validasi / Pengesahan:** Waktu saat penetapan status validasi/pengesahan dilakukan.
- **Catatan / Alasan Pengembalian (Kondisional):** Keterangan alasan pengembalian apabila hasil opname dikembalikan untuk dihitung ulang atau diperiksa kembali.
- **Keterangan Tambahan (Opsional):** Catatan operasional terkait kondisi fisik barang atau catatan khusus pemeriksaan.

### 5.3 Required Business Conditions

- Barang yang diperiksa terdaftar sah dalam master barang rumah sakit (`INV-MASTER`).
- Lokasi pemeriksaan merupakan unit/bangsal yang sah di lingkungan rumah sakit (`ORG-LAYANAN`).
- Jumlah fisik hasil penghitungan bernilai non-negatif (≥ 0).
- Saldo stok sistem tersedia sebagai pembanding pada saat opname dilakukan.
- Pengajuan validasi hanya dapat dilakukan dari status *Draft* apabila data penghitungan fisik telah terisi.
- Pengesahan atau pengembalian hasil opname hanya dapat dilakukan terhadap hasil opname yang sedang berstatus *Menunggu Validasi*.
- Hasil opname yang *Dikembalikan* dapat diperiksa atau dihitung ulang dan diperbarui catatannya sebelum diajukan kembali untuk validasi.
- **Pencatatan, validasi, dan pengesahan hasil opname tidak secara otomatis mengubah saldo stok sistem.**

### 5.4 Completion Proof

Outcome ini dinyatakan terpenuhi (*established*) apabila:

- Terdapat catatan operasional yang sah mengenai hasil penghitungan fisik persediaan di Bangsal Rawat Inap, perbandingannya dengan saldo sistem, dan selisihnya.
- Catatan hasil opname memiliki status keabsahan yang jelas (*Draft*, *Menunggu Validasi*, *Disahkan*, atau *Dikembalikan*).
- Hasil opname yang berstatus *Disahkan* telah diverifikasi dan diakui sebagai dokumen operasional yang valid dan dapat dipertanggungjawabkan untuk dasar tindak lanjut.
- Keabsahan catatan hasil opname berdiri sendiri dan tidak bergantung pada transaksi penyesuaian/koreksi saldo stok otomatis, penyesuaian nilai buku akuntansi (*stock valuation*), alur persetujuan audit bertingkat yang rumit, atau mekanisme investigasi selisih mendalam.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas menginisiasi pencatatan pemeriksaan fisik persediaan barang pada lokasi Bangsal Rawat Inap.

### End

Berakhir ketika hasil penghitungan fisik, perbandingan dengan saldo sistem, dan selisih stok telah tercatat serta memiliki status hasil pemeriksaan yang sah (*Disahkan* sebagai hasil yang valid dan dapat dipertanggungjawabkan, atau *Dikembalikan* untuk diperiksa ulang).

> **Catatan Batasan Boundary:**
> Boundary Opname berfokus pada pencatatan, perbandingan stok, dan validasi/pengesahan hasil pemeriksaan fisik persediaan di bangsal. Boundary secara tegas **tidak mencakup pelaksanaan penyesuaian saldo stok (*Koreksi Stok*)**, jurnal pembukuan akuntansi atas selisih persediaan, investigasi forensik persediaan, maupun tindakan administratif/disipliner.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Fokus pada Verifikasi dan Dokumentasi Fisik:** Opname berfokus pada pencatatan dan verifikasi kesesuaian stok fisik dengan catatan saldo stok dalam sistem, serta dokumentasi hasil dan selisih pemeriksaan.
2. **Pemisahan Eksplisit antara Opname dan Koreksi Stok (Opname ≠ Koreksi Stok):**
   - Opname **tidak secara otomatis mengubah saldo stok sistem** berdasarkan hasil penghitungan fisik.
   - Koreksi Stok merupakan aktivitas atau proses terpisah yang dapat menggunakan hasil opname yang telah disahkan sebagai dasar tindak lanjut, sesuai kewenangan dan ketentuan yang berlaku.
   - Pengesahan hasil opname **tidak sama dengan** persetujuan atau pelaksanaan Koreksi Stok.
3. **Pemisahan dari Transaksi Logistik Lainnya:**
   - **Opname Berbeda dari Pakai Barang (`OC-06-05`):** Opname memeriksa kuantitas fisik persediaan yang ada di lokasi, bukan mencatat peristiwa penggunaan atau konsumsi barang dalam pelayanan.
   - **Opname Berbeda dari Mutasi Barang (`OC-06-06`):** Opname tidak memindahkan barang antar lokasi atau unit, melainkan memverifikasi stok di lokasi tertentu.
   - **Opname Berbeda dari Penerimaan Barang (`PUR-DO`):** Opname bukan penerimaan barang baru dari pemasok/supplier.
4. **Pragmatis dan Bebas dari Kompleksitas Audit Berlebihan:**
   - Formalisasi dirancang sederhana dan sesuai kebutuhan operasional MyHospital Web.
   - Tidak mencakup sistem audit persediaan yang kompleks, mekanisme audit investigatif, prosedur penghitungan berulang (*blind count / multi-count*), atau persetujuan bertingkat (*multi-tier approval workflow*).
   - Detail kewenangan pengesahan mengikuti ketentuan dan kebijakan rumah sakit yang berlaku tanpa mengasumsikan struktur organisasi atau hierarki persetujuan tertentu.
5. **Kemandirian dari Detail Teknis dan Akuntansi Finansial:**
   - Catatan hasil opname bersifat mandiri dan tidak mensyaratkan atribut valuasi finansial (nilai rupiah selisih), metode kalkulasi harga pokok persediaan (FIFO/FEFO/Average), atau pembuatan jurnal akuntansi downstream.
6. **Siklus Status Hasil Opname yang Terkendali:**
   - Pengelolaan status hasil opname menggunakan alur sederhana: *Draft* → *Menunggu Validasi* → *Disahkan* (atau *Dikembalikan* dengan catatan alasan jika belum dapat diterima).

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Barang tidak valid atau tidak terdaftar dalam master barang rumah sakit | **Pencatatan ditolak.** Pemeriksaan opname hanya dapat dicatat untuk barang yang sah dalam pengelolaan rumah sakit. |
| Lokasi bangsal/unit tidak valid dalam sistem | **Pencatatan ditolak.** Lokasi pemeriksaan harus merupakan unit layanan atau bangsal yang sah. |
| Jumlah fisik bernilai negatif (< 0) | **Pencatatan ditolak.** Kuantitas fisik hasil penghitungan harus bernilai non-negatif (≥ 0). |
| Pengajuan validasi dilakukan saat data penghitungan fisik belum terisi | **Pengajuan ditolak.** Data hasil penghitungan fisik wajib terisi sebelum diajukan ke status *Menunggu Validasi*. |
| Tindakan pengesahan atau pengembalian dilakukan pada hasil opname yang masih berstatus Draft | **Aksi ditolak.** Pengesahan atau pengembalian hanya dapat diproses terhadap hasil opname yang berstatus *Menunggu Validasi*. |
| Hasil penghitungan fisik belum dapat diterima atau diragukan keabsahannya | **Hasil opname dikembalikan.** Status diubah menjadi *Dikembalikan* untuk diperiksa atau dihitung ulang, disertai catatan alasan pengembalian jika diperlukan. |
| Terdapat selisih antara jumlah fisik dan saldo stok sistem | **Kondisi bisnis yang sah (bukan exception teknis).** Selisih (positif atau negatif) tetap dicatat dan didokumentasikan sebagaimana adanya; hasil opname tetap dapat divalidasi dan disahkan tanpa mengubah saldo sistem. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Opname telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Sistem dapat mencatat objek barang, lokasi Bangsal Rawat Inap, hasil penghitungan fisik persediaan, perbandingannya dengan saldo stok sistem, serta selisih stok yang ditemukan sebagai fakta operasional yang dapat ditelusuri. | Completeness |
| AC-02 | Hasil opname dapat dikelola dan dilacak status siklusnya secara jelas (*Draft*, *Menunggu Validasi*, *Disahkan*, atau *Dikembalikan*). | Completeness |
| AC-03 | Hasil opname yang belum dapat diterima saat proses pemeriksaan dapat dikembalikan untuk diperiksa atau dihitung ulang dengan pencatatan alasan pengembalian jika diperlukan. | Completeness |
| AC-04 | Hasil opname yang telah disahkan menjadi dokumen operasional yang sah, akuntabel, dan dapat dipertanggungjawabkan sebagai dasar tindak lanjut. | Correctness |
| AC-05 | Pengesahan hasil opname secara tegas tidak secara otomatis mengubah atau memutakhirkan saldo stok sistem (Opname ≠ Koreksi Stok). | Constraint |
| AC-06 | Koreksi Stok ditegaskan sebagai proses atau aktivitas terpisah yang memerlukan kewenangan dan ketentuan tersendiri, bukan bagian dari pembentukan outcome Opname. | Constraint |
| AC-07 | Pencatatan opname dapat dibedakan secara tegas dari transaksi Pakai Barang (`OC-06-05`), Mutasi Barang (`OC-06-06`), dan Penerimaan Barang (`PUR-DO`). | Constraint |
| AC-08 | Spesifikasi outcome bersifat pragmatis tanpa mengasumsikan alur persetujuan audit bertingkat yang rumit, aturan investigasi forensik, prosedur hitung berulang kompleks, atau hierarki kewenangan organisasi di luar kebijakan yang berlaku. | Constraint |
| AC-09 | Catatan hasil opname bersifat mandiri dan tidak mensyaratkan atribut valuasi moneter persediaan, jurnal akuntansi, atau metode kalkulasi costing (FIFO/FEFO/Average). | Constraint |
| AC-10 | Hasil penghitungan fisik dengan kuantitas bernilai negatif (< 0) ditolak oleh sistem. | Exception |
| AC-11 | Spesifikasi Outcome Opname tetap *implementation-independent* tanpa bergantung pada skema tabel database, endpoint API, format teknis formulir UI, atau mekanisme sistem. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pelaksanaan dan eksekusi transaksi Koreksi Stok / penyesuaian saldo persediaan dalam sistem (*stock balance adjustment*).
- Penggunaan atau konsumsi barang dalam pelayanan klinis atau operasional bangsal (`OC-06-05 Pakai Barang` / `INV-PAKAI`).
- Mutasi atau perpindahan fisik barang antar lokasi/unit di rumah sakit (`OC-06-06 Mutasi Barang` / `INV-MUTASI`).
- Penerimaan barang pertama kali dari supplier atau pengadaan eksternal (`PUR-DO`).
- Penghapusan, pembuangan, atau pemusnahan barang rusak/kedaluwarsa (`INV-MUSNAH`).
- Sistem investigasi audit persediaan lanjutan, audit investigatif kecurangan (*fraud*), atau audit forensik kerugian aset.
- Mekanisme persetujuan hierarkis berjenjang (*multi-tier hierarchical approval workflow*) yang rumit.
- Prosedur penghitungan fisik ganda yang kompleks (*double-blind audit counting*).
- Valuasi nilai moneter persediaan, penyesuaian nilai buku persediaan, dan penjurnalan akuntansi keuangan/buku besar (*general ledger*).
- Skema tabel database, rancangan endpoint API, format penomoran dokumen internal sistem, dan tata letak antarmuka pengguna (UI).
