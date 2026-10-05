# OUTCOME: Telaah Resep

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-02     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-05   |

---

## 1. Business Purpose

Telaah Resep adalah proses pengambilan keputusan profesional oleh Apoteker terhadap setiap item obat dalam resep dokter sebelum obat tersebut dapat dilayani oleh rumah sakit.

Tujuan bisnis Telaah Resep adalah memastikan bahwa setiap item resep memiliki kepastian keputusan profesional yang jelas dan akuntabel, sehingga berfungsi sebagai gerbang kelaikan klinis dan pelayanan (*clinical/serviceability gate*) bagi proses bisnis berikutnya.

Hasil Telaah Resep menentukan **apa yang boleh dilayani** (*serviceable*) oleh rumah sakit, tanpa menetapkan transaksi finansial/tagihan dan tanpa melakukan penyiapan fisik obat.

---

## 2. Outcome Statement

Keputusan telaah profesional atas setiap item resep dokter beserta Serviceable Item Set **telah tercatat secara persisten dan sah, akuntabel oleh Apoteker penanggung jawab, serta siap digunakan sebagai dasar pelayanan downstream pada proses Penjualan dan Dispensing**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Apotek (`APT`) | Pemilik utama: mencatat dan mengelola telaah profesional resep, menetapkan keputusan per item dan agregasi resep, memelihara integritas keputusan telaah, dan menghasilkan Serviceable Item Set. |
| Pasien (`PAS`) | Menyediakan identitas pasien yang menjadi subjek penerima resep dan pelayanan obat. |
| Organisasi (`ORG`) | Menyediakan identitas Petugas Pemberi Asuhan (PPA) yaitu Dokter penulis resep dan Apoteker penanggung jawab telaah resep (`ORG-PPA`), serta unit layanan farmasi (`ORG-LAYANAN`). |
| Rawat Jalan (`RJL`) / Rawat Inap (`RNA`) / Gawat Darurat (`IGD`) | Menyediakan konteks pelayanan klinis asal yang menerbitkan instruksi resep dokter (*clinical-order source*). |
| Inventory (`INV`) | Menyediakan katalog master obat (`INV-MASTER`) yang sah untuk verifikasi identitas obat asli resep maupun obat pengganti (substitusi). |
| Admission (`ADM`) | Menyediakan konteks episode kunjungan/registrasi aktif pasien yang terkait dengan resep. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-TELAAH` Telaah Resep | Apotek | Known |
| `APT-RESEP` Resep | Apotek | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Keputusan Telaah Tingkat Item (*Item-Level Review Decision*):**
  - Setiap baris/item obat pada resep memiliki catatan evaluasi profesional.
  - Setiap baris/item obat wajib akhirnya memiliki tepat satu dari tiga keputusan final:
    1. **Disetujui Sesuai Resep** (*Approved as Prescribed*): obat dilayani sesuai instruksi dokter, dengan kuantitas yang disetujui tidak melebihi kuantitas resep dokter.
    2. **Disetujui dengan Penggantian / Substitusi Obat** (*Approved with Substitution*): obat pada resep diganti dengan obat alternatif yang disetujui secara profesional oleh Apoteker, dengan penelusuran obat asli, obat pengganti, kuantitas disetujui, dan alasan substitusi.
    3. **Ditolak** (*Rejected*): obat tidak dilayani (kuantitas disetujui = 0) dan alasan penolakan tercatat secara wajib.
- **Kondisi Item yang Belum Final:**
  - Item yang belum dinilai, sedang dalam proses telaah, atau masih menunggu klarifikasi dokter berstatus **Belum Final** (*Pending / Menunggu Klarifikasi*).
  - Selama masih ada minimal satu item berstatus Belum Final, resep secara keseluruhan **belum boleh memperoleh keputusan akhir** dan tetap berstatus **Sedang Ditelaah**.
- **Keputusan Telaah Tingkat Resep (*Prescription-Level Decision*):**
  - Setelah dan hanya setelah **seluruh item** memiliki keputusan final, resep memperoleh keputusan agregat:
    - **Disetujui Penuh** (*Fully Approved*): seluruh item resep disetujui untuk dilayani (baik sesuai resep maupun substitusi).
    - **Disetujui Sebagian** (*Partially Approved*): sebagian item disetujui untuk dilayani dan sebagian item lainnya ditolak, setelah seluruh item berstatus final.
    - **Ditolak Penuh** (*Fully Rejected*): seluruh item resep ditolak, tidak ada item yang dapat dilayani.
- **Serviceable Item Set:**
  - Terbentuknya himpunan item obat yang secara profesional dinyatakan dapat dilayani beserta kuantitas yang disetujui (*Approved Quantity*).
  - Serviceable Item Set hanya beranggotakan item yang **Disetujui Sesuai Resep** dan item **Hasil Substitusi** (menggunakan identitas obat pengganti).
  - Item yang **Ditolak** dan item yang masih **Belum Final** tidak termasuk dalam Serviceable Item Set.
  - Resep yang Ditolak Penuh menghasilkan Serviceable Item Set kosong.
- **Integritas dan Pemisahan Fakta Resep Asli vs Fakta Telaah:**
  - Instruksi resep asli dokter (identitas obat resep dan *Prescription Quantity*) tetap utuh, tidak diubah atau ditimpa oleh hasil telaah.
  - Kuantitas hasil telaah (*Approved Quantity*) dan obat pengganti merupakan fakta pelayanan hasil keputusan Apoteker.
  - Selisih kuantitas (*Remaining Quantity* = *Prescription Quantity* - *Approved Quantity*) tercatat sebagai fakta kuantitas yang belum terpenuhi.
- **Integritas Keputusan (*Decision Freeze*):**
  - Keputusan telaah yang telah difinalisasi dan menjadi dasar proses downstream terkunci dari perubahan terselubung.
  - Setiap perubahan terhadap keputusan telaah harus melalui telaah ulang yang sah dan dapat dipertanggungjawabkan.
- **Proses Klarifikasi Dokter:**
  - Klarifikasi dokter tercatat sebagai bagian dari proses pengambilan keputusan telaah, bukan sebagai hasil akhir telaah. Selama klarifikasi berlangsung, item belum final.

### 5.2 Required Recorded Information

- **Identitas Telaah Resep:**
  - Nomor referensi telaah unik.
  - Waktu penetapan keputusan telaah.
  - Status keseluruhan telaah resep (**Sedang Ditelaah**, **Disetujui Penuh**, **Disetujui Sebagian**, **Ditolak Penuh**).
- **Konteks Resep Asal dan Pasien:**
  - Referensi nomor dan versi resep dokter yang menjadi dasar telaah.
  - Tanggal dan waktu resep dokter.
  - Dokter penulis resep dan unit pelayanan asal.
  - Identitas pasien (Nomor Rekam Medis dan nama pasien).
- **Akuntabilitas Apoteker:**
  - Identitas Apoteker penanggung jawab telaah resep.
- **Rincian Keputusan Setiap Item Resep:**
  - Referensi baris/item resep asli dokter.
  - Identitas obat asli pada resep dokter.
  - Kuantitas resep asli (*Prescription Quantity*).
  - Status keputusan item (**Menunggu Klarifikasi / Pending**, **Disetujui Sesuai Resep**, **Disetujui dengan Penggantian / Substitusi**, **Ditolak**).
  - Kuantitas yang disetujui untuk pelayanan (*Approved Quantity*).
  - Kuantitas yang belum terpenuhi (*Remaining Quantity*).
  - Alasan penyesuaian kuantitas (jika *Approved Quantity* < *Prescription Quantity*).
  - Atribut khusus substitusi (jika keputusan adalah substitusi):
    - Identitas obat pengganti.
    - Aturan pakai / instruksi obat pengganti.
    - Kuantitas disetujui untuk obat pengganti.
    - Alasan profesional penggantian obat.
    - Apoteker penanggung jawab substitusi.
  - Alasan penolakan (jika keputusan adalah Ditolak, misalnya: kontraindikasi klinis, stok kosong permanen, atau penolakan pasien saat telaah).
- **Serviceable Item Set:**
  - Daftar item yang dinyatakan serviceable (identitas obat yang dilayani, kuantitas disetujui, dan aturan pakai).
- **Catatan Klarifikasi Dokter (jika ada):**
  - Masalah/isu klinis yang diklarifikasi.
  - Waktu klarifikasi.
  - Dokter yang dikonfirmasi dan hasil instruksi konfirmasi dokter.

### 5.3 Required Business Conditions

- **Kelengkapan Keputusan Final:** Keputusan akhir resep (**Disetujui Penuh**, **Disetujui Sebagian**, **Ditolak Penuh**) HANYA boleh ditetapkan apabila seluruh item resep telah memiliki keputusan final.
- **Larangan Penetapan Prematur Disetujui Sebagian:** Resep yang masih memiliki minimal satu item pending/menunggu klarifikasi dilarang berstatus Disetujui Sebagian dan harus tetap berstatus **Sedang Ditelaah**.
- **Batasan Kuantitas Persetujuan:** Kuantitas yang disetujui wajib memenuhi batasan bisnis:  
  `0 <= Approved Quantity <= Prescription Quantity`  
  Apoteker tidak diperbolehkan menyetujui kuantitas melebihi kuantitas pada resep dokter tanpa adanya resep/instruksi baru dari dokter.
- **Alasan Penyesuaian Kuantitas yang Sah:** Penyesuaian kuantitas (*Approved Quantity* < *Prescription Quantity*) harus memiliki alasan klinis atau operasional yang sah (misalnya: pembatasan jaminan/asuransi, permintaan/kemampuan pasien, keterbatasan ketersediaan stok, penyesuaian klinis pasca klarifikasi dokter, atau aturan kemasan obat).
- **Obat Pengganti Menjadi Acuan Pelayanan:** Pada item yang disetujui dengan substitusi, obat pengganti menjadi dasar pelayanan downstream, bukan obat asli resep dokter.
- **Pemisahan Momentum Penolakan Pasien:**
  - Jika pasien menolak item sebelum atau saat proses telaah berlangsung, item tersebut dapat ditetapkan sebagai **Ditolak** dengan alasan penolakan/permintaan pasien.
  - Jika pasien membatalkan item setelah telaah selesai difinalisasi (misalnya saat di kasir atau saat penyerahan), keputusan telaah tetap **Disetujui**; pembatalan dicatat dan ditangani oleh proses downstream terkait transaksi/pelayanan.
- **Dampak Perubahan / Revisi Resep:** Apabila resep dokter mengalami revisi atau perubahan setelah hasil telaah ditetapkan, keputusan telaah lama tidak boleh digunakan untuk bagian resep yang berubah. Item yang terdampak revisi wajib melalui proses telaah ulang berdasarkan resep yang berlaku.
- **Gatekeeper bagi Proses Downstream:** Penjualan (OC-11-03) dan Dispensing (OC-11-04) hanya boleh memproses item yang telah berstatus telaah final dan termasuk ke dalam Serviceable Item Set.

### 5.4 Completion Proof

- Rekaman keputusan telaah resep tersimpan dalam sistem dengan nomor referensi unik dan dapat ditelusuri ke resep dokter terkait.
- Seluruh item resep memiliki salah satu dari tiga keputusan final (tidak ada item yang berstatus pending atau menunggu klarifikasi).
- Status telaah resep berada pada kondisi terminal yang sah: **Disetujui Penuh**, **Disetujui Sebagian**, atau **Ditolak Penuh**.
- Serviceable Item Set telah terbentuk dan tersedia secara persisten bagi proses Penjualan (OC-11-03) dan Dispensing (OC-11-04).
- Identitas Apoteker penanggung jawab dan waktu pengesahan keputusan telaah tercatat dan dapat ditelusuri.

---

## 6. Outcome Boundary

### Start

Dimulai ketika resep obat yang diterbitkan dari unit pelayanan klinis (Rawat Jalan, Rawat Inap, atau Gawat Darurat) diterima oleh Apotek dan siap dilakukan pengkajian profesional oleh Apoteker.

### End

Berakhir ketika:
1. Seluruh item obat pada resep telah memperoleh keputusan profesional final;
2. Keputusan akhir resep ditetapkan secara definitif (**Disetujui Penuh**, **Disetujui Sebagian**, atau **Ditolak Penuh**); dan
3. Serviceable Item Set telah difinalisasi dan tersimpan secara persisten sebagai acuan pelayanan downstream.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Keputusan Final per Item Wajib Lengkap:** Setiap item resep wajib memiliki keputusan final sebelum resep memperoleh keputusan akhir.
2. **Item Pending Bukan Keputusan Final:** Item yang belum dinilai atau sedang menunggu klarifikasi dokter bukan merupakan keputusan final.
3. **Eksklusi Item Ditolak:** Item yang Ditolak tidak boleh dimasukkan ke dalam Serviceable Item Set.
4. **Inklusi Item Sesuai Resep:** Item yang Disetujui Sesuai Resep dimasukkan ke dalam Serviceable Item Set sesuai dengan *Approved Quantity*.
5. **Inklusi Item Substitusi:** Item hasil substitusi dimasukkan ke dalam Serviceable Item Set menggunakan identitas obat pengganti dan *Approved Quantity* yang telah ditetapkan.
6. **Batas Atas Kuantitas:** *Approved Quantity* tidak boleh melebihi *Prescription Quantity* (`0 <= Approved Quantity <= Prescription Quantity`).
7. **Integritas Resep Asli:** *Prescription Quantity* dan identitas obat asli pada resep dokter tidak boleh diubah atau ditimpa oleh hasil telaah.
8. **Makna Remaining Quantity:** *Remaining Quantity* semata-mata mencerminkan selisih kuantitas yang belum terpenuhi (`Prescription Quantity - Approved Quantity`) dan tidak secara otomatis menciptakan hak tebus tanpa verifikasi aturan domain terkait.
9. **Larangan Disetujui Sebagian saat Item Pending:** Resep yang masih memiliki item pending/menunggu klarifikasi dilarang berstatus Disetujui Sebagian.
10. **Syarat Disetujui Sebagian:** Status Disetujui Sebagian hanya dapat ditetapkan setelah seluruh item final, di mana sebagian item serviceable dan sebagian lainnya tidak serviceable (ditolak).
11. **Resep Ditolak Penuh Tanpa Serviceable Set:** Resep yang Ditolak Penuh menghasilkan Serviceable Item Set kosong (*empty set*).
12. **Penolakan Pasien Pre-Finalisasi:** Penolakan oleh pasien sebelum atau saat telaah berlangsung dapat ditetapkan sebagai item Ditolak dengan alasan permintaan/penolakan pasien.
13. **Imunitas Keputusan Klinis Pasca-Finalisasi:** Pembatalan atau penolakan oleh pasien setelah telaah selesai tidak boleh mengubah hasil keputusan telaah klinis Apoteker.
14. **Kewajiban Telaah Ulang atas Revisi Resep:** Perubahan atau revisi resep dokter yang berdampak pada item atau kuantitas mewajibkan telaah ulang terhadap item yang terdampak.
15. **Akuntabilitas Substitusi:** Setiap keputusan substitusi obat wajib memiliki Apoteker penanggung jawab yang tercatat secara eksplisit.
16. **Keterlacakan Deviasi:** Setiap keputusan yang menyimpang dari resep dokter (baik penyesuaian kuantitas maupun substitusi obat) wajib memiliki alasan dan pihak yang bertanggung jawab yang dapat ditelusuri.
17. **Larangan Kelaikan Otomatis Resep Mentah:** Tidak ada item yang boleh menjadi serviceable hanya karena item tersebut tertulis di resep dokter; setiap item wajib memiliki keputusan telaah final yang valid.
18. **Kemandirian Alur Downstream:** Baik Penjualan maupun Dispensing hanya boleh memproses item yang telah berstatus telaah final dan tercatat dalam Serviceable Item Set.

---

## 8. Business Exceptions

> Conditions under which the Outcome deviates from normal flow or cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Dosis tidak lazim, kontraindikasi, atau interaksi obat teridentifikasi | Apoteker menunda penetapan keputusan item, mencatat catatan klarifikasi klinis, dan menghubungi dokter penulis resep. Item tetap berstatus **Menunggu Klarifikasi** dan resep tetap berstatus **Sedang Ditelaah** sampai klarifikasi tuntas. |
| Klarifikasi dokter tidak berhasil diperoleh / dokter tidak merespons | Selama Apoteker belum dapat mengambil keputusan professional atas item tersebut: item tetap berstatus **Menunggu Klarifikasi** dan resep tetap berstatus **Sedang Ditelaah** — ini bukan keputusan final. Jika kemudian Apoteker secara profesional memutuskan bahwa item tidak dapat dilayani karena klarifikasi tidak diperoleh dan keamanan pasien tidak dapat dijamin: Apoteker menetapkan item sebagai **Ditolak** dengan alasan yang tercatat eksplisit (contoh: "Klarifikasi dokter tidak diperoleh — item tidak dapat dilayani secara aman"). Transisi dari Pending ke Rejected hanya terjadi melalui keputusan aktif Apoteker, bukan secara otomatis karena dokter tidak merespons. |
| Stok obat pada resep tidak tersedia atau tidak mencukupi | Apoteker dapat: (a) melakukan substitusi obat sejenis/ekuivalen dan mencatat data substitusi; (b) menyetujui kuantitas yang tersedia (*Approved Quantity* < *Prescription Quantity*) dengan mencatat alasan keterbatasan stok; atau (c) menolak item jika alternatif tidak tersedia. |
| Pasien menyatakan tidak ingin menebus item obat sebelum telaah difinalisasi | Apoteker menetapkan item tersebut sebagai **Ditolak** dengan alasan "Permintaan / Penolakan Pasien". Item tidak masuk ke Serviceable Item Set. |
| Pasien membatalkan pembelian obat setelah telaah selesai difinalisasi | Keputusan telaah resep tetap **Disetujui** (tidak diubah menjadi Ditolak). Pembatalan dicatat dan ditangani pada proses transaksi downstream (Kasir / Penjualan) atau pengembalian dispensing. |
| Dokter membatalkan atau merevisi resep saat telaah sedang berlangsung atau setelah selesai | Keputusan telaah yang merujuk pada versi resep lama dinyatakan batal/tidak berlaku untuk bagian yang berubah. Diterbitkan sesi telaah ulang berdasarkan versi resep baru. |
| Permintaan pelayanan kuantitas melebihi kuantitas resep dokter | Permintaan ditolak. Kuantitas disetujui dibatasi maksimal sebesar *Prescription Quantity*. Penambahan kuantitas wajib melalui penerbitan resep baru atau revisi resep resmi oleh dokter. |
| Seluruh item pada resep ditolak | Resep ditetapkan berstatus **Ditolak Penuh**. Serviceable Item Set bernilai kosong. Proses downstream (Penjualan dan Dispensing) tidak dapat dilanjutkan untuk resep tersebut. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Setiap baris/item pada resep tercatat memiliki evaluasi keputusan telaah dan Apoteker penanggung jawab yang teridentifikasi. | Completeness |
| AC-02 | Resep yang memiliki minimal satu item berstatus **Menunggu Klarifikasi** atau belum dinilai tetap berstatus **Sedang Ditelaah** dan tidak dapat difinalisasi. | Constraint |
| AC-03 | Resep yang seluruh itemnya telah memiliki keputusan final berstatus disetujui (sesuai resep maupun substitusi) ditetapkan berstatus akhir **Disetujui Penuh**. | Correctness |
| AC-04 | Resep yang seluruh itemnya telah memiliki keputusan final, dengan sebagian item disetujui dan sebagian item ditolak, ditetapkan berstatus akhir **Disetujui Sebagian**. | Correctness |
| AC-05 | Resep yang seluruh itemnya berstatus ditolak ditetapkan berstatus akhir **Ditolak Penuh**, dan Serviceable Item Set yang dihasilkan adalah kosong. | Correctness |
| AC-06 | Item resep yang berstatus **Ditolak** tidak tercantum di dalam Serviceable Item Set, memiliki kuantitas disetujui = 0, serta memiliki alasan penolakan yang tercatat. | Constraint |
| AC-07 | Item yang berstatus **Disetujui dengan Penggantian / Substitusi** tercantum dalam Serviceable Item Set menggunakan identitas obat pengganti, aturan pakai pengganti, kuantitas disetujui, alasan substitusi, dan Apoteker penanggung jawab yang tercatat. | Correctness |
| AC-08 | Nilai *Approved Quantity* pada setiap item tidak pernah melebihi nilai *Prescription Quantity* (`Approved Quantity <= Prescription Quantity`). | Constraint |
| AC-09 | Nilai *Prescription Quantity* dan identitas obat asli pada resep dokter tetap tersimpan utuh dan tidak berubah setelah telaah resep selesai. | Correctness |
| AC-10 | Nilai *Remaining Quantity* pada setiap item terhitung secara akurat sebagai selisih antara *Prescription Quantity* dan *Approved Quantity*. | Correctness |
| AC-11 | Penolakan obat oleh pasien yang dikonfirmasi sebelum atau saat telaah berlangsung menghasilkan item berstatus **Ditolak** dengan alasan penolakan pasien dan tidak masuk Serviceable Item Set. | Exception |
| AC-12 | Pembatalan pembelian/penerimaan obat oleh pasien setelah telaah berstatus final tidak mengubah status klinis telaah item dari Disetujui menjadi Ditolak. | Constraint |
| AC-13 | Terjadinya revisi atau perubahan pada resep dokter menyebabkan item yang terdampak wajib ditelaah ulang dan tidak dapat menggunakan hasil telaah versi sebelumnya. | Constraint |
| AC-14 | Proses downstream Penjualan (OC-11-03) dan Dispensing (OC-11-04) hanya dapat mengakses dan memproses item-item yang terdaftar dalam Serviceable Item Set yang sah. | Constraint |
| AC-15 | Setiap item yang disetujui dengan kuantitas lebih kecil dari resep dokter (*Approved Quantity* < *Prescription Quantity*) memiliki catatan alasan penyesuaian yang sah dan dapat diverifikasi. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Transaksi Finansial & Billing Farmasi:** Penentuan harga obat, diskon, tuslah, embalase, penerbitan tagihan/kuitansi, serta penagihan klaim asuransi/BPJS → **OC-11-03 Penjualan** (`APT-BILL`, `TRK-BILLING`), **OC-03-01 Kasir**, **OC-01-04 VCLAIM BPJS**.
- **Penyiapan & Peracikan Fisik Obat:** Pengambilan fisik obat dari rak, peracikan puyer/kapsul/sirup, pembuatan etiket obat, dan pengemasan fisik → **OC-11-04 Dispensing** (`APT-DISPENSING`).
- **Penyerahan & Edukasi Obat:** Penyerahan fisik obat kepada pasien, verifikasi identitas penerima obat, serta pemberian edukasi/KIE kefarmasian → **OC-11-05 Serah Obat** (`APT-SERAH`).
- **Pencatatan Stok & Pengurangan Fisik:** Pemotongan saldo stok apotek dan pencatatan kartu stok → **Inventory Domain** (`INV-STOK`, `INV-MUTASI`).
- **Penerbitan Resep Medis Asli:** Perumusan terapi, diagnosis klinis, dan penulisan resep asli dokter melalui CPOE / EMR → **Rawat Jalan / Rawat Inap / IGD Domain** (`RJL-KONSUL`, `RNA-TINDAKAN`, dsb.).
- **Mekanisme Salinan Resep (*Copy Recipe* / Iterasi):** Pengelolaan iterasi penebusan sisa resep di waktu yang akan datang pada tingkat administratif pelayanan resep.
- **SOP Komunikasi Lapangan:** Prosedur teknis tata cara menelepon dokter, format percakapan interkom, atau etika komunikasi interpersonal di rumah sakit.
- **Rancangan Teknis Sistem:** Desain skema database, nama tabel/kolom, struktur endpoint API, arsitektur microservices, antarmuka layar pengguna (UI layout), atau komponen formulir.
