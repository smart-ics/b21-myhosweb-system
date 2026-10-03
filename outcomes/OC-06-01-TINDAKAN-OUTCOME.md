# OUTCOME: Tindakan Rawat Inap

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-01     |
| Version     | 1.2          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat dan memelihara fakta pelaksanaan aktivitas pelayanan medis, keperawatan, dan pelayanan klinis lainnya yang benar-benar telah diberikan oleh tenaga kesehatan kepada pasien selama menjalani masa perawatan rawat inap.

Tindakan rawat inap merepresentasikan **fakta pelaksanaan pelayanan klinis aktual (Clinical Service Event)**, bukan sekadar instruksi medis/order atau ketersediaan master jenis tindakan. Pencatatan ini membuktikan bahwa pasien telah nyata-nyata menerima asuhan klinis dalam rangka pemeriksaan, diagnosis, pengobatan, perawatan luka, pemantauan kondisi, maupun pemulihan.

Pencatatan kejadian pelayanan ini menerapkan prinsip **One Clinical Event, Multiple Perspectives**, di mana satu fakta bahwa pelayanan telah dilakukan kepada pasien dapat menjadi sumber bagi beberapa perspektif bisnis:
1. **Perspektif Asuhan Klinis:** Memastikan kesinambungan pelayanan, kejelasan akuntabilitas tenaga kesehatan pelaksana, dan dokumentasi riwayat intervensi yang diterima pasien.
2. **Perspektif Finansial / Billing:** Menjadi dasar bagi pembentukan konsekuensi tagihan (*charge*) apabila tindakan memiliki konsekuensi tarif sesuai penjamin dan kelas rawat pasien, di mana proses penagihan dan penatausahaan keuangan dikelola sepenuhnya pada domain terkait (Tata Rekening).
3. **Perspektif Logistik / Pemakaian Barang:** Menjadi dasar keterkaitan apabila tindakan memerlukan bahan medis habis pakai (BMHP), di mana pencatatan penggunaan dan mutasi barang dikelola sepenuhnya pada domain terpisah (*Pakai Barang*).

Tanpa pencatatan pelaksanaan tindakan yang sah dan akuntabel, rumah sakit tidak dapat mempertanggungjawabkan pelayanan yang telah diberikan kepada pasien, kehilangan riwayat pelayanan yang valid, serta mengaburkan transparansi kinerja klinis tenaga kesehatan.

---

## 2. Outcome Statement

Pelayanan medis, keperawatan, atau prosedur klinis yang benar-benar dilakukan oleh tenaga kesehatan kepada pasien rawat inap **telah tercatat sebagai fakta pelaksanaan pelayanan (Clinical Service Event) yang sah, akuntabel, dan dapat ditelusuri untuk kebutuhan asuhan berkelanjutan. Pencatatan tindakan merupakan outcome tersendiri dan dapat menjadi sumber bagi proses downstream, termasuk pembentukan charge apabila berlaku, tetapi keberhasilan proses downstream tersebut bukan merupakan syarat tercapainya outcome Tindakan.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | Menyediakan konteks episode rawat inap aktif tempat pelayanan klinis diberikan kepada pasien |
| Pasien (`PAS`) | Menyediakan data identitas pasien sebagai subjek penerima pelayanan klinis |
| Organisasi (`ORG`) | Menyediakan data unit layanan tempat tindakan dilakukan serta identitas Petugas Pemberi Asuhan (PPA) pelaksana tindakan |
| Tata Rekening (`TRK`) | Domain downstream yang menerima fakta pelayanan tindakan sebagai sumber pembentukan konsekuensi finansial (*charge*) apabila tindakan memiliki tarif |

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
> Sesuai Domain Catalog (Versi 2.1 authoritative), Domain Rawat Inap (`RNA`) saat ini baru mendefinisikan: `RNA-ANTRIAN`, `RNA-BED`, `RNA-TRANSFER`, `RNA-CHARGE`, `RNA-DISCHARGE`, dan `RNA-HK`. Berbeda dengan Rawat Jalan yang memiliki `RJL-TINDAKAN` dan Gawat Darurat yang memiliki `IGD-TINDAKAN`, capability pencatatan tindakan klinis di Rawat Inap belum terdaftar di Domain Catalog.
> Mengikuti aturan tata kelola skill, tim analisis **tidak membuat capability baru secara sepihak** dan **tidak menganggap Capability Candidate sebagai capability yang telah disetujui**. Kebutuhan ini didokumentasikan sebagai **Capability Candidate** (`RNA-TINDAKAN`) dan **dieskalasikan kepada Product Owner** untuk keputusan penetapan scope capability resmi dalam Domain Catalog.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Fakta pelaksanaan tindakan pelayanan klinis/keperawatan nyata-nyata telah dilakukan kepada pasien rawat inap dan tersimpan secara persisten.
- Pelaksanaan tindakan terhubung dengan pasien yang memiliki episode rawat inap aktif yang valid pada saat tindakan berlangsung.
- Jenis tindakan klinis yang dilakukan dapat diidentifikasi secara jelas dan sah dalam katalog layanan rumah sakit.
- Pelaksana tindakan (PPA) dan waktu pelaksanaan aktual dapat ditelusuri.
- Pelaksanaan tindakan dapat diidentifikasi dan, apabila secara bisnis relevan, jumlah atau frekuensi pelaksanaannya dapat ditentukan.
- Catatan tindakan memiliki status bisnis yang dapat dibedakan: berstatus aktif (**Dilaksanakan / Performed**) atau berstatus koreksi (**Dibatalkan / Void**).
- Tindakan dapat dibedakan secara tegas dari instruksi/order medis yang belum dilaksanakan:
  - Jika tindakan dilakukan berdasarkan order dokter (CPOE), keterkaitan pemenuhan order tersebut dapat ditelusuri.
  - Tindakan tetap sah terbentuk tanpa order sebelumnya apabila berupa tindakan mandiri keperawatan atau prosedur klinis langsung.
- Tindakan dapat dibedakan secara tegas dari pemakaian barang; bahan atau obat yang digunakan tidak menjadi bagian dari definisi tindakan.
- Jika tindakan memiliki konsekuensi finansial, fakta tindakan dapat menjadi sumber bagi pembentukan *charge* di domain Tata Rekening. Namun, keberhasilan pembentukan *charge* adalah konsekuensi downstream dan **bukan merupakan syarat utama terbentuknya fakta Tindakan**.

### 5.2 Required Recorded Information

Pencatatan pelaksanaan tindakan harus memuat informasi bisnis esensial berikut secara implementation-independent:

- **Identitas Tindakan:** Identifikasi unik atas kejadian pelayanan tindakan yang bersangkutan.
- **Subjek Pasien:** Identitas pasien yang menerima pelayanan tindakan.
- **Konteks Rawat Inap:** Identifikasi episode rawat inap aktif tempat tindakan berlangsung.
- **Layanan Klinis:** Jenis pelayanan atau prosedur klinis yang dilakukan.
- **Pelaksana Pelayanan:** Identitas tenaga kesehatan (PPA) yang bertanggung jawab dan melaksanakan tindakan.
- **Waktu Pelaksanaan:** Waktu aktual dilaksanakannya tindakan kepada pasien.
- **Unit Pelayanan:** Unit kerja atau bangsal tempat tindakan dilaksanakan.
- **Jumlah / Frekuensi Pelaksanaan:** Kuantitas atau frekuensi pelaksanaan tindakan, apabila relevan dengan karakteristik jenis tindakan tersebut.
- **Catatan Pelayanan:** Keterangan klinis atau informasi tambahan yang relevan terkait pelaksanaan tindakan.
- **Keterkaitan Order (Kondisional):** Keterkaitan dengan instruksi/order medis sebelumnya, apabila tindakan dilakukan atas dasar order.
- **Keterkaitan Finansial (Kondisional):** Penelusuran ke konsekuensi tagihan (*charge*) di domain Tata Rekening, apabila tindakan memiliki konsekuensi tarif.
- **Informasi Pembatalan (Kondisional - jika Void):** Alasan bisnis pembatalan dan akuntabilitas pihak yang membatalkan.

### 5.3 Required Business Conditions

- Pasien memiliki episode rawat inap aktif pada saat tindakan dilakukan (tidak berada dalam status belum dirawat atau sudah dinyatakan pulang/discharged).
- Pelayanan klinis benar-benar telah selesai atau nyata-nyata dilakukan kepada pasien, bukan sekadar rencana atau instruksi.
- Tenaga kesehatan yang tercatat sebagai pelaksana adalah pihak yang sah dan berwenang sesuai aturan rumah sakit.
- Jenis tindakan merupakan layanan yang sah dan diizinkan pada unit rawat inap bersangkutan.
- Waktu pelaksanaan tindakan dapat dipertanggungjawabkan secara klinis (tidak berada di masa depan dan berada dalam rentang episode rawat inap pasien).
- Kuantitas atau frekuensi tindakan, apabila relevan ditentukan, harus merepresentasikan volume pelayanan yang rasional dan terukur.

### 5.4 Completion Proof

Outcome ini dinyatakan established apabila:

- Fakta bahwa tindakan telah dilakukan kepada pasien telah tercatat secara persisten dan sah dalam sistem.
- Status bisnis tindakan adalah **Dilaksanakan (Performed)**.
- Tindakan dapat ditelusuri, diidentifikasi, dan diverifikasi dalam riwayat pelayanan klinis pasien.
- Tindakan siap digunakan oleh tenaga kesehatan sebagai referensi asuhan klinis lanjutan dan siap menjadi sumber bagi proses bisnis downstream (seperti pembentukan *charge* di Tata Rekening apabila bertarif).

---

## 6. Outcome Boundary

### Start

Dimulai ketika terdapat pelayanan klinis aktual yang dilakukan oleh tenaga kesehatan kepada pasien rawat inap dan fakta pelaksanaan pelayanan tersebut perlu dicatat, baik yang didasarkan pada instruksi/order dokter sebelumnya maupun sebagai inisiatif asuhan klinis mandiri.

### End

Berakhir ketika fakta bahwa tindakan telah dilakukan telah tercatat secara persisten, sah, dapat ditelusuri, dan dapat diverifikasi sebagai pelayanan yang benar-benar telah diberikan kepada pasien rawat inap.

Pembentukan *Charge*, penerbitan *Tagihan*, maupun penerimaan *Pembayaran* **bukan merupakan bagian dari completion condition OC-06-01**.

Tindakan yang telah dicatat dapat kemudian dibatalkan melalui proses koreksi bisnis yang sah. Setelah berstatus Void, tindakan tersebut tidak lagi dianggap sebagai tindakan aktif/valid untuk proses downstream. Riwayat bahwa tindakan tersebut pernah dicatat dan kemudian dikoreksi harus tetap dapat ditelusuri secara akuntabel.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

- **Fakta Aktual vs Rencana:** Tindakan hanya boleh dicatat apabila pelayanan klinis telah benar-benar dilakukan. Rencana pelayanan atau keberadaan instruksi dokter (order) tidak dapat dianggap sebagai Outcome Tindakan.
- **Konteks Episode Aktif:** Pasien harus memiliki episode rawat inap aktif pada saat tindakan dilakukan. Tindakan tidak boleh dicatat untuk pasien yang belum terdaftar rawat inap atau telah selesai masa perawatannya (*discharged*).
- **Independensi dari Status Tempat Tidur:** Keberadaan atau status fisik tempat tidur (*bed*) bukan merupakan prasyarat mutlak pencatatan tindakan, melainkan dikelola oleh capability terpisah (*Pakai Bed*).
- **Keabsahan Pelaksana:** Tenaga kesehatan yang tercatat sebagai pelaksana tindakan harus dapat diidentifikasi dan sah sesuai aturan kompetensi rumah sakit.
- **Validitas Waktu:** Waktu pelaksanaan tindakan tidak boleh berada di masa mendatang (*future time*) dan harus berada dalam rentang waktu episode rawat inap pasien.
- **Independensi dari Billing:** Keberhasilan pencatatan tindakan tidak bergantung pada keberhasilan proses pembentukan charge atau penagihan. Charge adalah konsekuensi downstream dari tindakan.
- **Pemisahan dari Pemakaian Barang:** Tindakan tidak mencatat pengurangan stok atau konsumsi fisik bahan medis habis pakai; penggunaan barang merupakan tanggung jawab outcome terpisah (*Pakai Barang*).
- **Akuntabilitas Pembatalan (Void):** Tindakan yang telah dicatat dapat dibatalkan melalui proses koreksi bisnis yang sah. Void merupakan koreksi terhadap pencatatan dan bukan penghapusan riwayat pencatatan. Setelah berstatus *Void*, tindakan tersebut tidak lagi dianggap sebagai tindakan aktif/valid untuk proses downstream, namun riwayat bahwa tindakan tersebut pernah dicatat dan kemudian dikoreksi harus tetap dapat ditelusuri secara akuntabel.
- **Pencegahan Dampak Pembatalan Finansial:** Tindakan yang telah menghasilkan konsekuensi finansial tidak boleh dibatalkan tanpa mempertimbangkan dan merekonsiliasi konsekuensi finansial tersebut melalui proses bisnis yang bertanggung jawab di domain Tata Rekening.
- **Pencatatan Ulang:** Apabila suatu pelayanan yang telah di-void ternyata benar-benar perlu diberikan kembali kepada pasien, peristiwa tersebut harus dicatat sebagai fakta tindakan baru.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak memiliki episode rawat inap aktif pada waktu tindakan | Pencatatan tindakan ditolak. Pasien harus memiliki episode rawat inap yang sah pada saat tindakan dilakukan. |
| Tenaga kesehatan pelaksana tidak teridentifikasi atau tidak sah | Pencatatan tindakan ditolak. Pelaksana tindakan harus merupakan tenaga kesehatan yang valid dan berwenang. |
| Waktu pelaksanaan tidak valid (di masa depan atau di luar rentang rawat inap) | Pencatatan tindakan ditolak. Waktu pelaksanaan harus dapat dipertanggungjawabkan secara klinis. |
| Jenis tindakan tidak valid atau tidak diizinkan pada unit rawat inap bersangkutan | Pencatatan tindakan ditolak. Jenis tindakan harus aktif dan sesuai dengan ruang lingkup unit pelayanan. |
| Pembentukan charge downstream gagal atau tarif belum terkonfigurasi (untuk tindakan bertarif) | **Fakta pelaksanaan tindakan tetap sah terbentuk dan tercatat (Established).** Penanganan ketidaksesuaian tarif atau keterlambatan pembentukan charge dieskalasikan ke domain Tata Rekening sebagai isu downstream tanpa membatalkan fakta klinis. |
| Permintaan pembatalan (*Void*) diajukan tanpa alasan bisnis yang sah | Pembatalan ditolak. Pembatalan tindakan wajib disertai alasan bisnis yang jelas demi kepentingan audit klinis. |
| Permintaan pembatalan (*Void*) atas tindakan yang konsekuensi finansialnya telah terkunci/selesai | Pembatalan fakta tindakan tidak dapat dilakukan secara sepihak sebelum dilakukan koordinasi dan rekonsiliasi administratif dengan domain Tata Rekening. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Tindakan telah terbentuk sesuai spesifikasi.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Tindakan merepresentasikan pelayanan medis, keperawatan, atau klinis yang benar-benar telah dilaksanakan kepada pasien, bukan sekadar rencana atau instruksi. | Completeness |
| AC-02 | Tindakan terhubung secara sah dengan pasien yang memiliki episode rawat inap aktif pada saat tindakan berlangsung. | Correctness |
| AC-03 | Jenis tindakan yang dilaksanakan dapat diidentifikasi secara jelas dan valid dalam katalog layanan rumah sakit. | Completeness |
| AC-04 | Tenaga kesehatan pelaksana (PPA) dan waktu pelaksanaan aktual dapat ditelusuri dan dipertanggungjawabkan secara klinis. | Correctness |
| AC-05 | Fakta pelaksanaan tindakan tersimpan secara persisten dan dapat diverifikasi dalam riwayat pelayanan pasien. | Completeness |
| AC-06 | Tindakan dapat dibedakan secara tegas dari instruksi medis/order yang belum dilaksanakan; apabila tindakan berasal dari order, keterkaitan pemenuhan order dapat ditelusuri. | Correctness |
| AC-07 | Tindakan dapat dibedakan secara tegas dari pemakaian barang; pencatatan tindakan tidak mencakup pengurangan fisik bahan medis habis pakai. | Correctness |
| AC-08 | Apabila tindakan berstatus bertarif, hubungan ke konsekuensi tagihan (*charge*) dapat ditelusuri, namun **keberhasilan pembentukan charge bukan merupakan prerequisite terbentuknya Outcome Tindakan**. | Correctness |
| AC-09 | Tindakan yang dibatalkan (*Void*) dapat dibedakan dari tindakan yang sah/aktif (*Performed*), memiliki alasan bisnis yang sah, dapat diaudit, dan tidak lagi dihitung sebagai pelayanan aktif. | Exception |

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
