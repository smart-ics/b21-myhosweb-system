# OUTCOME: TelaahResep

| Field       | Value        |
|-------------|--------------|
| Code        | OC-APT-TELAAH-RESEP |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-10   |

---

## 1. Business Purpose

Setiap pesanan obat resep dokter yang masuk ke instalasi farmasi harus melalui pengkajian dan penelaahan profesional oleh Apoteker yang berwenang sebelum obat dapat disetujui, ditagihkan, dan disiapkan untuk pasien. Rumah sakit harus mampu mencatat dan memelihara hasil pengkajian tersebut sebagai *persisted business fact* untuk menjamin keselamatan pasien (*patient safety*), mencegah kesalahan pengobatan (*medication error*), serta memastikan kepatuhan terhadap standar pelayanan kefarmasian.

Telaah resep memastikan verifikasi komprehensif atas:
1. **Aspek Administratif**: Keabsahan identitas dokter penulis resep, identitas pasien, tanggal resep, dan unit layanan asal.
2. **Aspek Farmasetik**: Bentuk sediaan, dosis, kekuatan, potensi, stabilitas, dan aturan serta rute pemberian obat.
3. **Aspek Klinis**: Ketepatan indikasi, ketepatan dosis dan waktu penggunaan, duplikasi terapi, alergi obat, potensi interaksi obat, serta kontraindikasi klinis.
4. **Aspek Regulasi & Kebijakan**: Kesesuaian dengan Formularium Nasional (Fornas) BPJS dan Formularium Rumah Sakit.

Hasil telaah resep merupakan satu-satunya gerbang profesional yang mengotorisasi pembentukan pesanan penjualan farmasi (*Sales Order*). Tanpa telaah resep yang tercatat, tidak ada obat dari resep yang boleh diracik atau diserahkan kepada pasien.

---

## 2. Outcome Statement

Hasil penelaahan profesional administratif, farmasetik, dan klinis oleh Apoteker atas salinan kerja resep dokter (`ResepKerja`) **telah selesai dilaksanakan dan terekam secara persisten dengan keputusan definitif pada setiap baris obat, menjadi dasar otorisasi pembentukan pesanan farmasi (`SalesOrder`)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Apotek** (Primary Owner) | Mengelola penerimaan salinan kerja resep (`APT-RESEP`), melaksanakan proses telaah resep (`APT-TELAAH`), mencatat keputusan dan substitusi obat per baris resep, menetapkan status hasil telaah terminal, serta membentuk entri pesanan farmasi (`APT-ORDER`). |
| **Organisasi** | Menyediakan profil dan kewenangan klinis Apoteker (`ORG-PPA`) yang bertugas melakukan telaah resep. |
| **Pasien** | Menyediakan data demografi, berat badan, umur, dan riwayat alergi pasien (`PAS-DATSOS`) sebagai rujukan keselamatan telaah klinis. |
| **Rawat Jalan / Rawat Inap / IGD** | Bertindak sebagai unit asal penulisan resep klinis dokter (*Prescription Source Context*). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `APT-TELAAH` Telaah Resep | Apotek | Known |
| `APT-RESEP` Resep | Apotek | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Salinan kerja resep (`ResepKerja`) telah berhasil dibuat dan terhubung ke dokumen resep klinis asli dokter tanpa mengubah isi resep asli tersebut.
- Apoteker yang bertugas telah memeriksa seluruh baris permintaan obat pada resep tersebut.
- Setiap baris obat pada resep telah menerima keputusan profesional final yang eksplisit:
  - **Approved**: Disetujui sesuai resep asli.
  - **Approved with Substitute**: Disetujui dengan substitusi obat (merek, bentuk sediaan, atau kekuatan setara) yang sah.
  - **Rejected**: Ditolak karena alasan klinis, administratif, atau regulasi.
- Dokumen hasil telaah resep telah mencapai status terminal:
  - **Approved**: Seluruh baris obat disetujui.
  - **Partially Approved**: Sebagian baris obat disetujui dan sebagian lainnya ditolak.
  - **Rejected**: Seluruh baris obat ditolak.
- Resep yang berstatus *Approved* atau *Partially Approved* telah mengotorisasi pembentukan dokumen pesanan penjualan farmasi (`SalesOrder`) yang hanya memuat item-item obat yang disetujui (*Accepted Medication Items*).

### 5.2 Required Recorded Information

- Referensi unik dokumen telaah resep (`TelaahResepId`).
- Referensi dokumen salinan resep (`ResepKerjaId`) dan nomor resep klinis dokter.
- Identitas Apoteker penelaah (ID PPA dan nama lengkap Apoteker ber-STRA/SIP).
- Tanggal dan waktu telaah dimulai (`StartedAt`) dan diselesaikan (`CompletedAt`).
- Rincian hasil telaah per baris obat:
  - Nomor baris resep asal (*Baris Resep Reference*).
  - Nama dan kode obat yang diresepkan.
  - Status keputusan baris: Disetujui / Disetujui dengan Penggantian / Ditolak.
  - Kode dan nama obat pengganti (jika dilakukan substitusi).
  - Alasan penolakan atau alasan substitusi (contoh: interaksi obat, alergi, restriksi formularium, kekosongan pabrikan).
  - Kuantitas obat yang disetujui.
- Catatan telaah administratif, farmasetik, dan klinis.
- Referensi dokumen pesanan farmasi (`SalesOrderId`) yang dibentuk dari hasil telaah ini.

### 5.3 Required Business Conditions

- **Kewenangan Eksklusif**: Hanya tenaga profesional Apoteker terdaftar (`ORG-PPA`) yang berwenang menetapkan dan mengesahkan keputusan akhir telaah resep. Asisten Apoteker/Tenaga Teknis Kefarmasian tidak memiliki kewenangan menandatangani keputusan telaah resep.
- **Integritas Resep Asli**: Apotek tidak boleh mengubah dokumen resep klinis asli dokter. Klarifikasi dengan dokter penulis resep berlangsung di luar sistem dan selama klarifikasi berlangsung status telaah tetap berada dalam `Under Review`.
- **Independensi Klinis dari Stok**: Keputusan klinis telaah resep tidak boleh dipengaruhi atau dibatasi oleh ketersediaan stok fisik barang pada saat telaah dilakukan (*clinical acceptance is independent of stock levels*). Penilaian kelayakan obat murni berbasis medis dan farmakoterapi.
- **Kemandirian Waktu Telaah**: Apoteker dapat melakukan telaah resep segera setelah resep elektronik tersedia di sistem; kehadiran fisik pasien dan kepemilikan nomor antrean farmasi bukan prasyarat untuk memulai telaah resep.
- **Larangan Sales Order pada Resep Ditolak**: Resep yang berstatus *Rejected* secara keseluruhan dilarang keras membentuk `SalesOrder`.

### 5.4 Completion Proof

- Berkas hasil telaah resep tersimpan permanen dan memiliki status terminal (`Approved`, `Partially Approved`, atau `Rejected`).
- Baris obat yang disetujui secara otomatis terpetakan menjadi *Sales Order Items* pada dokumen `SalesOrder` farmasi.
- Dokumen telaah mencatat stempel waktu pengesahan dan identitas Apoteker penelaah.

---

## 6. Outcome Boundary

### Start

Dimulai ketika resep obat dari unit pelayanan klinis diterima oleh instalasi farmasi, salinan operasional `ResepKerja` terbentuk, dan Apoteker membuka berkas resep tersebut untuk memulai evaluasi telaah resep (status beralih dari `Available` ke `Under Review`).

### End

Berakhir ketika Apoteker menetapkan keputusan profesional definitif untuk setiap baris obat, membubuhkan stempel persetujuan, dan status telaah beralih menjadi salah satu dari status terminal:
1. **`Approved`**: Seluruh baris obat disetujui dan dokumen `SalesOrder` penuh terbentuk.
2. **`Partially Approved`**: Hanya baris obat yang memenuhi syarat yang disetujui dan dokumen `SalesOrder` parsial terbentuk.
3. **`Rejected`**: Seluruh baris obat ditolak, tidak ada `SalesOrder` yang terbentuk, dan alasan penolakan terdokumentasi untuk diinformasikan kepada dokter pengirim dan pasien.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Setiap baris resep harus memiliki satu keputusan profesional yang jelas (tidak boleh ada baris resep yang berstatus menggantung saat dokumen telaah diselesaikan).
- Setiap tindakan substitusi obat wajib mencatat obat pengganti yang disetujui, alasan farmakoterapi, dan identitas Apoteker yang bertanggung jawab.
- Kewenangan substitusi obat oleh Apoteker berakhir pada saat dokumen pesanan farmasi (`SalesOrder`) telah terbentuk. Penggantian obat setelah `SalesOrder` terbentuk wajib dilakukan melalui pembatalan item pesanan dan penelaahan ulang.
- Dokumen hasil telaah resep yang telah berstatus terminal bersifat *immutable* (tidak dapat diubah secara diam-diam). Koreksi hasil telaah hanya dapat dilakukan dengan membuka berkas telaah baru atau mencatat riwayat pembatalan secara akuntabel.
- Resep yang mengandung zat narkotika atau psikotropika wajib melalui verifikasi keabsahan identitas dokter penulis resep (nomor SIP) dan kelengkapan alamat pasien sesuai ketentuan perundang-undangan farmasi.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|---|---|
| Ditemukan interaksi obat berbahaya atau kontraindikasi fatal | Apoteker menahan proses telaah dalam status `Under Review` dan melakukan konfirmasi kepada dokter penulis resep di luar sistem. Jika dokter setuju mengganti, obat disetujui dengan substitusi. Jika tidak dapat diselesaikan, baris resep ditolak (*Rejected*). |
| Resep tidak terbaca, dosis tidak lazim, atau rute pemberian tidak jelas | Proses telaah tetap berada dalam `Under Review` hingga konfirmasi dokter diperoleh. Jika dokter tidak dapat dihubungi dalam batas waktu operasional, resep dapat diputuskan *Rejected* dengan catatan alasan ketidakjelasan dosis. |
| Obat yang diresepkan tidak tercantum dalam Formularium Rumah Sakit | Apoteker mengusulkan obat substitusi formularium yang setara terapeutik. Jika dokter/regulasi menyetujui, dicatat sebagai *Approved with Substitute*. Jika tidak diizinkan, baris obat ditolak (*Rejected*). |
| Pasien teridentifikasi memiliki riwayat alergi berat terhadap obat yang diresepkan | Apoteker menolak baris obat tersebut (*Rejected*) dengan mencatat peringatan alergi, dan menginformasikan kepada dokter penanggung jawab pelayanan (DPJP) untuk pemilihan terapi alternatif. |
| Resep telah kedaluwarsa sesuai kebijakan masa berlaku resep rumah sakit | Resep ditolak (*Rejected*) dengan alasan masa berlaku resep telah habis. Pasien diarahkan untuk melakukan konsultasi ulang dengan dokter. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Setiap resep yang masuk ke farmasi dapat dibuatkan salinan kerja `ResepKerja` tanpa mengubah resep klinis asli dokter. | Completeness |
| AC-02 | Hanya pengguna dengan peran Apoteker (`ORG-PPA`) yang dapat mengesahkan keputusan telaah resep. | Constraint |
| AC-03 | Seluruh baris obat dalam satu resep memiliki keputusan eksplisit (*Approved*, *Approved with Substitute*, atau *Rejected*). | Correctness |
| AC-04 | Setiap baris obat yang disetujui dengan substitusi mencatat obat pengganti yang sah dan alasan substitusi. | Correctness |
| AC-05 | Dokumen telaah resep yang berstatus *Approved* atau *Partially Approved* secara otomatis menghasilkan dokumen `SalesOrder` berisi item obat yang diterima. | Completeness |
| AC-06 | Sistem menolak pembentukan `SalesOrder` apabila status akhir telaah resep adalah *Rejected*. | Constraint |
| AC-07 | Baris obat yang berstatus *Rejected* pada telaah parsial tidak disertakan dalam `SalesOrder`. | Correctness |
| AC-08 | Apoteker dapat melakukan telaah resep sebelum pasien mengambil nomor antrean farmasi. | Constraint |
| AC-09 | Telaah resep yang belum selesai dapat dipertahankan dalam status `Under Review` selama proses klarifikasi dengan dokter berlangsung. | Exception |
| AC-10 | Riwayat telaah resep mencatat timestamp mulai, selesai, dan identitas Apoteker secara lengkap dan tidak dapat dimodifikasi setelah final. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penulisan instruksi medikasi dan resep elektronik oleh dokter → **CPOE / Rawat Jalan / Rawat Inap / IGD Domain**.
- Pengelolaan antrean loket farmasi pasien → **`OC-APT-ANTRIAN-APOTEK` (AntrianApotek)**.
- Pembentukan tagihan komersial penjualan obat → **`OC-APT-PENJUALAN` (Penjualan)**.
- Penyiapan fisik, pencadangan stok, peracikan, dan penyerahan obat → **`OC-APT-ORDER-DISPENSING` (OrderDispensing)**.
- Master katalog obat dan restriksi formularium → **Master Obat / Farmasi Catalog Authority**.
- Pengadaan dan penerimaan obat dari distributor → **Purchasing Domain (`PUR`)**.
