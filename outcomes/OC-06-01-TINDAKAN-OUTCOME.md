# OUTCOME: Tindakan Rawat Inap

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-01     |
| Version     | 2.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Rumah sakit harus memiliki kemampuan operasional untuk mengelola dan mencatat seluruh siklus pelayanan atau prosedur klinis pasien rawat inap, mulai dari saat pelayanan tersebut direncanakan, dijadwalkan, sedang diproses, telah selesai dilaksanakan, hingga kemungkinan dibatalkan atau dikoreksi.

Tindakan rawat inap merepresentasikan **Operational Service Event**, yaitu kejadian pelayanan operasional yang mengelola dan melacak status pelaksanaan suatu pelayanan atau prosedur klinis kepada pasien rawat inap. Tindakan bukan sekadar pencatatan retrospektif atas histori pelayanan yang telah selesai, melainkan entitas operasional yang memungkinkan organisasi rumah sakit:
1. Mengetahui pelayanan atau prosedur apa saja yang sedang aktif dikelola untuk pasien rawat inap;
2. Mengetahui status operasional pelaksanaan pelayanan/prosedur tersebut secara transparan (apakah belum dilakukan, sedang diproses, telah selesai dilakukan, atau dibatalkan);
3. Mengetahui siapa tenaga kesehatan yang bertanggung jawab atau terlibat dalam penanganan tindakan sesuai konteks bisnis;
4. Mengetahui dimensi waktu yang relevan terhadap siklus operasional tindakan (kapan direncanakan, dijadwalkan, dilaksanakan, dibatalkan, atau dikoreksi);
5. Menyediakan fakta operasional yang terverifikasi dan akuntabel sebagai sumber bagi proses klinis lanjutan serta proses downstream lainnya (termasuk pembentukan *charge* tagihan pasien apabila tindakan telah berstatus *Performed* dan memiliki tarif).

Pencatatan kejadian operasional ini menerapkan prinsip **One Operational Event, Multiple Perspectives**, di mana satu fakta operasional tindakan menjadi sumber tunggal bagi berbagai kebutuhan bisnis:
- **Perspektif Asuhan Klinis:** Mengkoordinasikan pelaksanaan asuhan pasien, memastikan kesinambungan perawatan, serta membuktikan pelaksanaan intervensi saat tindakan mencapai status *Performed*.
- **Perspektif Finansial / Billing:** Menjadi pemicu downstream bagi pembentukan *charge* tagihan pada domain Tata Rekening ketika tindakan telah berstatus *Performed* dan memenuhi kriteria penjaminan/tarif, di mana proses billing dan pembayaran dikelola sepenuhnya di luar Tindakan.
- **Perspektif Logistik / Pemakaian Barang:** Menjadi dasar penelusuran jika tindakan memerlukan bahan medis habis pakai (BMHP), di mana pencatatan penggunaan dan mutasi barang dikelola sepenuhnya pada domain terpisah (*Pakai Barang*).

---

## 2. Outcome Statement

Tindakan merupakan **Operational Service Event yang merepresentasikan pelayanan atau prosedur yang perlu, sedang, atau telah dilakukan kepada pasien dalam konteks pelayanan rawat inap, serta mencatat status operasional pelaksanaannya sehingga dapat diketahui apakah Tindakan belum dilakukan, sedang diproses, telah dilakukan, dibatalkan, atau dikoreksi sesuai aturan bisnis.**

Ketika status Tindakan mencapai **Performed**, Tindakan menjadi fakta bahwa pelayanan/prosedur tersebut benar-benar telah dilakukan kepada pasien dan dapat digunakan sebagai sumber bagi proses klinis dan konsekuensi bisnis downstream, termasuk pembentukan charge apabila berlaku. Keberhasilan proses downstream tersebut bukan merupakan syarat tercapainya outcome Tindakan.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | Menyediakan konteks episode rawat inap aktif tempat pelayanan operasional tindakan dikelola dan dilaksanakan |
| Pasien (`PAS`) | Menyediakan data identitas pasien sebagai subjek penerima pelayanan atau prosedur klinis |
| Organisasi (`ORG`) | Menyediakan data unit layanan tempat tindakan dikelola/dilaksanakan serta data Petugas Pemberi Asuhan (PPA) yang bertanggung jawab atau bertindak sebagai pelaksana |
| Tata Rekening (`TRK`) | Domain downstream yang menerima fakta tindakan yang telah berstatus *Performed* sebagai sumber pembentukan konsekuensi finansial (*charge*) apabila tindakan memiliki tarif |

> **Catatan Batasan Domain:**
> Outcome ini tidak mengambil alih kepemilikan atas proses penagihan (*billing*), transaksi pembayaran (*payment*), pengelolaan logistik/barang (*inventory*), maupun pengelolaan tempat tidur (*bed management*). Domain-domain tersebut berpartisipasi sesuai batas tanggung jawab bisnisnya masing-masing.

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `RNA-TINDAKAN` Tindakan Rawat Inap | Rawat Inap | Capability Candidate |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Eskalasi Scope (Governance Rule):**
> Sesuai Domain Catalog (Versi 2.1 authoritative), Domain Rawat Inap (`RNA`) saat ini mendefinisikan: `RNA-ANTRIAN`, `RNA-BED`, `RNA-TRANSFER`, `RNA-CHARGE`, `RNA-DISCHARGE`, dan `RNA-HK`. Berbeda dengan Rawat Jalan yang memiliki `RJL-TINDAKAN` dan Gawat Darurat yang memiliki `IGD-TINDAKAN`, capability pengelolaan tindakan klinis di Rawat Inap belum terdaftar di Domain Catalog.
> Mengikuti aturan tata kelola skill, tim analisis **tidak membuat capability baru secara sepihak** dan **tidak menganggap Capability Candidate sebagai capability yang telah disetujui**. Kebutuhan ini didokumentasikan sebagai **Capability Candidate** (`RNA-TINDAKAN`) dan **dieskalasikan kepada Product Owner** untuk keputusan penetapan scope capability resmi dalam Domain Catalog.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Keberadaan suatu **Operational Service Event** yang sah, dapat diidentifikasi, dan terhubung dengan pasien yang memiliki episode rawat inap aktif.
- Tindakan merujuk pada jenis pelayanan atau prosedur klinis yang valid dalam katalog layanan rumah sakit.
- Tindakan memiliki status operasional pelaksanaan yang jelas dan dapat dipertanggungjawabkan (misalnya: belum dilakukan / direncanakan, dijadwalkan, sedang dalam proses, telah dilakukan, dibatalkan, atau dikoreksi).
- Tindakan mencatat informasi waktu yang relevan sesuai tahap siklus hidupnya (waktu inisiasi/rencana, waktu penjadwalan, waktu mulai, waktu pelaksanaan aktual, waktu pembatalan, atau waktu koreksi).
- Status **Dilaksanakan (Performed)** merepresentasikan fakta bisnis bahwa pelayanan/prosedur tersebut benar-benar telah selesai dilakukan kepada pasien oleh tenaga kesehatan yang berwenang. Informasi pelaksana aktual dan waktu pelaksanaan aktual menjadi wajib dipenuhi ketika tindakan mencapai status *Performed*.
- Status **Dibatalkan (Cancelled)** merepresentasikan pembatalan yang sah sebelum pelayanan dilakukan, dan tidak boleh dianggap sebagai pelayanan yang telah diberikan kepada pasien.
- Status **Dibatalkan Pasca Pencatatan (Void)** merepresentasikan koreksi bisnis atas pencatatan tindakan yang sudah ada sebelumnya tanpa menghapus rekam historisnya.
- Keterkaitan dengan instruksi/order medis (CPOE) dapat ditelusuri apabila tindakan berasal dari order. Order yang belum menghasilkan event Tindakan tidak dianggap sebagai Tindakan yang telah dilakukan, dan Order bukan merupakan Tindakan (Order ≠ Tindakan).
- Keterkaitan dengan pemakaian barang (jika menggunakan BMHP) dapat ditelusuri ke outcome terpisah (*Pakai Barang*), di mana konsumsi barang bukan bagian dari definisi inti Tindakan.
- Keterkaitan dengan konsekuensi finansial (jika tindakan bertarif dan berstatus *Performed*) dapat ditelusuri ke domain Tata Rekening untuk pembentukan *charge*. Keberhasilan pembentukan *charge* adalah konsekuensi downstream dan **bukan merupakan syarat keberadaan atau pembentukan Outcome Tindakan**.

### 5.2 Required Recorded Information

Pencatatan Operational Service Event tindakan harus memuat informasi bisnis esensial berikut secara implementation-independent:

- **Identitas Event Tindakan:** Identifikasi unik atas Operational Service Event tindakan yang bersangkutan.
- **Subjek Pasien:** Identitas pasien yang menjadi sasaran atau penerima pelayanan.
- **Konteks Episode Rawat Inap:** Identifikasi episode rawat inap aktif tempat tindakan dikelola.
- **Jenis Pelayanan/Prosedur:** Identifikasi jenis tindakan atau prosedur klinis yang dikelola.
- **Status Operasional Tindakan:** Status pelaksanaan saat ini yang merepresentasikan posisi tindakan dalam siklus hidup operasionalnya.
- **Informasi Waktu Siklus Hidup:** Waktu yang relevan sesuai status tindakan (misalnya: waktu inisiasi/rencana, waktu terjadwal, waktu pelaksanaan aktual jika telah dilakukan, waktu pembatalan jika dibatalkan, atau waktu koreksi jika di-void).
- **Pelaksana Pelayanan (Kondisional sesuai status):** Identitas tenaga kesehatan yang bertanggung jawab atas rencana tindakan, atau tenaga kesehatan pelaksana aktual (wajib dipenuhi apabila tindakan berstatus *Performed*).
- **Unit Pelayanan:** Unit kerja, bangsal, atau ruangan tempat tindakan direncanakan, dikelola, atau dilaksanakan.
- **Jumlah / Frekuensi Pelayanan (Kondisional):** Kuantitas atau frekuensi pelaksanaan tindakan, apabila relevan dengan karakteristik jenis tindakan tersebut.
- **Catatan / Keterangan Pelayanan:** Keterangan klinis atau operasional yang relevan terkait rencana, proses, atau hasil pelaksanaan tindakan.
- **Keterkaitan Inisiasi / Order (Kondisional):** Penelusuran ke instruksi atau order medis sebelumnya, apabila tindakan berakar dari order dokter.
- **Keterkaitan Finansial Downstream (Kondisional):** Penelusuran ke konsekuensi tagihan (*charge*) di Tata Rekening, apabila tindakan berstatus *Performed* dan memiliki konsekuensi tarif.
- **Informasi Pembatalan / Koreksi (Kondisional):** Alasan bisnis pembatalan (*Cancelled*) atau alasan koreksi (*Void*) beserta akuntabilitas pihak yang membatalkan/mengoreksi.

### 5.3 Required Business Conditions

- Pasien memiliki episode rawat inap aktif pada saat event tindakan dibuat dan dikelola (tidak berada dalam status belum dirawat atau sudah dinyatakan pulang/discharged).
- Jenis tindakan merupakan layanan yang sah dan diizinkan pada unit rawat inap bersangkutan.
- Status operasional tindakan harus merepresentasikan kondisi bisnis yang sah.
- Transisi status operasional tindakan harus mematuhi aturan bisnis yang sah (misalnya: tindakan yang sudah *Performed* tidak dapat diubah langsung menjadi *Cancelled*; pembatalan pasca *Performed* harus melalui mekanisme koreksi *Void*).
- Apabila tindakan berstatus *Performed*, pelayanan/prosedur harus benar-benar telah selesai dilakukan kepada pasien oleh tenaga kesehatan yang berwenang, dengan waktu pelaksanaan aktual yang valid (tidak berada di masa depan dan berada dalam rentang episode rawat inap pasien).
- Apabila tindakan berstatus *Cancelled*, tindakan tidak boleh diperlakukan sebagai pelayanan yang telah terjadi.
- Apabila tindakan berstatus *Void*, tindakan tidak lagi dianggap aktif/valid untuk proses downstream, namun riwayat pencatatan dan koreksinya tetap dapat ditelusuri secara akuntabel.
- Penetapan jumlah atau frekuensi tindakan (apabila secara bisnis relevan ditentukan) harus rasional dan terukur sesuai karakteristik tindakan.

### 5.4 Completion Proof

Outcome ini dinyatakan established apabila:

- **Operational Service Event Tindakan telah tercatat secara sah dalam sistem** dengan identitas jenis tindakan, pasien, episode rawat inap yang relevan, serta status operasional yang dapat dipertanggungjawabkan (baik dalam status belum dilakukan, sedang diproses, telah dilakukan, maupun dibatalkan).
- Event tindakan dapat diidentifikasi, ditelusuri, dan diverifikasi dalam riwayat operasional pelayanan pasien rawat inap.
- Status **Dilaksanakan (Performed)** merupakan bukti pencapaian kondisi bisnis spesifik (*business state*) yang membuktikan bahwa pelayanan atau prosedur tersebut benar-benar telah selesai dilakukan kepada pasien, dan siap menjadi sumber bagi proses klinis lanjutan serta proses downstream (seperti pembentukan *charge* di Tata Rekening apabila bertarif).

---

## 6. Outcome Boundary

### Start

Dimulai ketika terdapat kebutuhan, instruksi/order dokter, atau dasar pelayanan klinis yang sah untuk mengelola suatu Tindakan terhadap pasien rawat inap dan Tindakan tersebut perlu dicatat sebagai Operational Service Event dalam sistem operasional bangsal (baik yang berasal dari order dokter maupun inisiatif asuhan klinis mandiri).

### End

Berakhir ketika Operational Service Event Tindakan mencapai kondisi terminal yang dapat dipertanggungjawabkan secara bisnis dalam siklus hidup operasionalnya:
1. Tindakan telah selesai dilaksanakan kepada pasien dengan status **Dilaksanakan (Performed)**; ATAU
2. Tindakan dibatalkan secara sah sebelum pelaksanaan dengan status **Dibatalkan (Cancelled)** disertai alasan pembatalan bisnis yang valid; ATAU
3. Tindakan yang telah dicatat kemudian dikoreksi melalui proses koreksi bisnis yang sah dengan status **Dibatalkan Pasca Pencatatan (Void)**.

Penegasan: Pembentukan *Charge*, penerbitan *Tagihan*, maupun penerimaan *Pembayaran* **bukan merupakan bagian dari completion condition OC-06-01**.

Tindakan yang telah dicatat dapat kemudian dibatalkan melalui proses koreksi bisnis yang sah. Setelah berstatus Void, tindakan tersebut tidak lagi dianggap sebagai tindakan aktif/valid untuk proses downstream. Riwayat bahwa tindakan tersebut pernah dicatat dan kemudian dikoreksi harus tetap dapat ditelusuri secara akuntabel.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

- **Representasi Operational Service Event:** Tindakan merepresentasikan event operasional pelayanan yang mengelola status pelaksanaan tindakan, bukan hanya histori pelayanan yang sudah selesai. Tindakan sah tercatat dalam status operasional sebelum, selama, atau setelah tindakan dilakukan.
- **Konteks Episode Rawat Inap Aktif:** Pasien harus memiliki episode rawat inap aktif yang valid pada saat event tindakan dibuat dan dikelola. Tindakan tidak boleh dikelola untuk pasien yang belum terdaftar rawat inap atau telah selesai masa perawatannya (*discharged*).
- **Independensi dari Status Tempat Tidur:** Keberadaan atau status fisik tempat tidur (*bed*) bukan merupakan prasyarat mutlak keberadaan Tindakan; pengelolaan tempat tidur dikelola oleh capability terpisah (*Pakai Bed*).
- **Keabsahan Jenis Tindakan:** Jenis tindakan yang dikelola harus terdaftar aktif dan sah dalam katalog layanan rumah sakit.
- **Keabsahan Status Bisnis:** Status tindakan harus merepresentasikan kondisi operasional yang sah (misalnya: *Planned*, *Scheduled*, *In Progress*, *Performed*, *Cancelled*, atau *Void*).
- **Integritas Status Performed:** Tindakan yang berstatus *Performed* harus membuktikan bahwa pelayanan benar-benar telah selesai dilakukan kepada pasien oleh tenaga kesehatan yang sah, dengan waktu pelaksanaan aktual yang valid (tidak berada di masa depan dan berada dalam rentang episode rawat inap).
- **Pembedaan dari Order:** Order adalah instruksi/rencana, sedangkan Tindakan adalah event operasional yang mengelola pelaksanaan. Keberadaan order yang belum diikuti oleh event tindakan tidak boleh dianggap sebagai tindakan yang telah dilakukan (Order ≠ Tindakan).
- **Integritas Status Cancelled:** Tindakan yang berstatus *Cancelled* tidak boleh dianggap atau diperlakukan sebagai pelayanan yang pernah dilaksanakan kepada pasien.
- **Integritas Status Void:** Tindakan yang telah dicatat dapat dibatalkan melalui proses koreksi bisnis yang sah (*Void*). Void merupakan koreksi terhadap pencatatan dan bukan penghapusan riwayat pencatatan. Setelah berstatus *Void*, tindakan tersebut tidak lagi dianggap sebagai tindakan aktif/valid untuk proses downstream, namun riwayat bahwa tindakan tersebut pernah dicatat dan kemudian dikoreksi harus tetap dapat ditelusuri secara akuntabel.
- **Pencegahan Dampak Pembatalan Finansial:** Tindakan yang telah menghasilkan konsekuensi finansial downstream tidak boleh dibatalkan/di-void tanpa mempertimbangkan dan merekonsiliasi konsekuensi finansial tersebut melalui proses bisnis yang bertanggung jawab di domain Tata Rekening.
- **Pemisahan dari Pemakaian Barang:** Tindakan tidak mencatat pengurangan stok atau konsumsi fisik bahan medis habis pakai; penggunaan barang dikelola sepenuhnya melalui outcome terpisah (*Pakai Barang*).
- **Independensi dari Billing:** Keberhasilan pencatatan tindakan tidak bergantung pada keberhasilan proses pembentukan charge atau penagihan. Charge adalah konsekuensi downstream yang dapat terbentuk setelah tindakan berstatus *Performed* dan memenuhi kriteria tarif.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Tindakan tercatat tetapi belum dilakukan (status *Planned* / *Scheduled*) | **Kondisi operasional yang sah (bukan error).** Tindakan menunggu proses pelaksanaan pelayanan kepada pasien sesuai rencana klinis. |
| Tindakan dibatalkan secara sah sebelum pelaksanaan (status *Cancelled*) | Tindakan dinyatakan batal dengan alasan pembatalan bisnis yang valid. Tindakan tidak diperlakukan sebagai pelayanan yang telah terjadi. |
| Tindakan telah tercatat namun kemudian dikoreksi (*Void*) | Tindakan diubah statusnya menjadi Void dengan alasan koreksi yang jelas dan dapat diaudit. Tindakan tidak lagi aktif untuk proses downstream, dan riwayat pencatatan tetap terpelihara. |
| Tindakan telah berstatus *Performed* namun pembentukan charge downstream gagal atau tarif belum terkonfigurasi | **Fakta tindakan tetap sah terbentuk dan berstatus Performed (tidak membatalkan Outcome Tindakan).** Masalah konfigurasi tarif atau keterlambatan pembentukan charge dieskalasikan ke domain Tata Rekening sebagai isu downstream tanpa membatalkan fakta klinis. |
| Pasien tidak memiliki episode rawat inap aktif pada waktu tindakan dikelola | Pencatatan event tindakan ditolak. Pasien harus memiliki episode rawat inap yang sah. |
| Tenaga kesehatan pelaksana tidak teridentifikasi atau tidak sah saat tindakan dinyatakan *Performed* | Penetapan status *Performed* ditolak. Pelaksana tindakan harus merupakan tenaga kesehatan yang valid dan berwenang. |
| Waktu pelaksanaan aktual tidak valid (di masa depan atau di luar rentang rawat inap) | Penetapan status *Performed* ditolak. Waktu pelaksanaan harus dapat dipertanggungjawabkan secara klinis. |
| Jenis tindakan tidak valid atau tidak diizinkan pada unit rawat inap bersangkutan | Pencatatan event tindakan ditolak. Jenis tindakan harus aktif dan sesuai ruang lingkup unit pelayanan. |
| Transisi status tidak sah (misalnya membatalkan langsung tindakan yang sudah *Performed* tanpa mekanisme *Void*) | Perubahan status ditolak. Pembatalan tindakan yang sudah dilakukan harus melalui prosedur koreksi *Void*. |
| Permintaan pembatalan (*Cancelled*) atau koreksi (*Void*) diajukan tanpa alasan bisnis yang sah | Perubahan status ditolak. Alasan pembatalan/koreksi wajib disertakan demi akuntabilitas audit bisnis. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Tindakan telah terbentuk sesuai spesifikasi.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Operational Service Event Tindakan dapat tercatat dan teridentifikasi secara sah dalam sistem sebelum pelayanan/prosedur dilakukan kepada pasien (misalnya berstatus *Planned* atau *Scheduled*). | Completeness |
| AC-02 | Tindakan dapat memiliki status operasional yang dapat dibedakan untuk menunjukkan apakah pelayanan/prosedur belum dilakukan, sedang diproses, telah dilakukan, dibatalkan, atau dikoreksi. | Correctness |
| AC-03 | Keberadaan instruksi atau order medis (CPOE) tidak secara otomatis dianggap sebagai Tindakan yang sudah dilakukan; Order diakui sebagai inisiasi/pemicu yang terpisah dari pelaksanaan Tindakan (Order ≠ Tindakan). | Constraint |
| AC-04 | Tindakan yang berstatus **Dilaksanakan (Performed)** membuktikan bahwa pelayanan atau prosedur klinis benar-benar telah selesai dilakukan kepada pasien rawat inap oleh tenaga kesehatan yang sah pada waktu yang dapat dipertanggungjawabkan. | Completeness |
| AC-05 | Tindakan yang berstatus **Dibatalkan (Cancelled)** tidak dianggap atau diperlakukan sebagai pelayanan klinis yang pernah dilakukan kepada pasien. | Correctness |
| AC-06 | Tindakan yang telah dicatat dapat dikoreksi menjadi berstatus **Void** melalui proses bisnis yang sah dan tidak lagi diperlakukan sebagai tindakan aktif/valid untuk proses downstream. | Correctness |
| AC-07 | Riwayat bahwa suatu tindakan pernah dicatat dan kemudian dikoreksi/di-void tetap dapat ditelusuri secara akuntabel untuk kebutuhan audit bisnis. | Completeness |
| AC-08 | Tindakan yang telah berstatus *Performed* dapat menjadi sumber bagi pembentukan *charge* tagihan pada domain Tata Rekening apabila tindakan tersebut memiliki konsekuensi tarif yang berlaku. | Correctness |
| AC-09 | Tindakan tetap sah terbentuk dan valid sebagai Outcome meskipun pembentukan *charge* di Tata Rekening belum terjadi, tertunda, atau mengalami kendala konfigurasi tarif. | Correctness |
| AC-10 | Penggunaan dan pengurangan bahan medis habis pakai (BMHP) saat tindakan dipisahkan dari pencatatan tindakan dan dikelola melalui Outcome Pakai Barang (`OC-06-05`). | Constraint |
| AC-11 | Keterisian atau penempatan fisik tempat tidur (*bed management*) bukan merupakan prasyarat mutlak keberadaan Tindakan; yang menjadi konteks adalah episode rawat inap aktif pasien. | Constraint |
| AC-12 | Spesifikasi Outcome Tindakan dinyatakan secara murni dalam konsep dan aturan bisnis yang *implementation-independent* tanpa bergantung pada skema database, tabel, kolom, API endpoint, UI form, atau enum teknis. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Penerbitan instruksi medis, order resep, atau order pemeriksaan penunjang (CPOE) → **SC-05 / SC-06 CPOE / Medical Order**.
- Pendokumentasian rekam medis elektronik lengkap, asesmen medis, dan catatan perkembangan pasien terintegrasi (CPPT) → **Domain EMR / Rekam Medis Klinis**.
- Pencatatan pemakaian, mutasi, dan pengurangan stok bahan medis habis pakai (BMHP) atau obat yang digunakan saat tindakan → **OC-06-05 Pakai Barang** (`INV-PAKAI`).
- Penentuan dan pengelolaan struktur tarif rumah sakit → **Tata Rekening Domain** (`TRK-TARIF`).
- Pengelolaan rincian tagihan, kalkulasi total biaya, dan penyesuaian diskon pasien → **OC-02-01 Rincian Tagihan Pasien** (`TRK-BILLING`).
- Penerimaan pembayaran, penyelesaian tagihan kasir, refund/restitusi, dan penutupan shift kasir → **SC-03 Kasir** (`TRK-PAYMENT`, `TRK-KASIR`).
- Pengelolaan penempatan tempat tidur, status ketersediaan bed, dan perpindahan fisik bed/kamar → **OC-06-02 Pakai Bed** (`RNA-BED`).
- Pengelolaan alur pemulangan operasional pasien dari bangsal → **OC-06-04 Discharge** (`RNA-DISCHARGE`).
- Desain antarmuka pengguna (UI), formulir isian teknis, endpoint API, skema tabel database, atau penetapan tipe data/enum teknis.
