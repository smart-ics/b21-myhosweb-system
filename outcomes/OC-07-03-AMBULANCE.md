# OUTCOME: Ambulance

| Field       | Value        |
|-------------|--------------|
| Code        | OC-07-03     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Rumah sakit harus mampu menyediakan dan mencatat **pelayanan transportasi medis kepada pasien** sebagai *persisted business fact* yang menjamin keselamatan, kesinambungan asuhan medis (*continuity of care*), dan akuntabilitas pemindahan pasien antar lokasi.

Pelayanan Ambulance merepresentasikan **pelayanan transportasi medis terintegrasi yang diberikan kepada pasien**, bukan sekadar pengelolaan aset kendaraan (*fleet*) dan bukan sekadar catatan log perjalanan kendaraan (*trip log*). Pelayanan ini diselenggarakan untuk memindahkan pasien dari satu lokasi ke lokasi lain dengan disertai dukungan **pemantauan kondisi fisiologis dan/atau tindakan medis sesuai kebutuhan klinis pasien selama proses transportasi**.

Secara bisnis, Pelayanan Ambulance merupakan **pelayanan lintas-domain (*cross-domain service*)** yang dapat berkolaborasi dan digunakan oleh berbagai domain pelayanan, meliputi:
- Penjemputan pasien dari lokasi kejadian atau tempat tinggal menuju fasilitas kesehatan;
- Transportasi pasien dari rumah menuju rumah sakit atau fasilitas kesehatan;
- Rujukan atau transfer medis pasien antar-fasilitas kesehatan (faskes);
- Pemindahan pasien antar-unit atau fasilitas sesuai kebutuhan kontinuitas pelayanan;
- Kebutuhan transportasi medis bagi pasien Rawat Inap (misalnya pemeriksaan penunjang di luar RS, alih rawat, atau pemulangan dengan pendampingan medis);
- Kebutuhan transportasi medis bagi pasien Rawat Jalan (misalnya rujukan eksternal atau transfer khusus);
- Kebutuhan transportasi medis bagi pasien Instalasi Gawat Darurat (IGD);
- Kebutuhan transportasi medis lainnya yang memenuhi tujuan pelayanan medis ambulance.

Instalasi Gawat Darurat (IGD) adalah salah satu domain yang dapat berinteraksi dengan pelayanan Ambulance, namun **IGD bukan pemilik eksklusif (*exclusive owner*) maupun induk wajib (*mandatory parent*)** dari pelayanan Ambulance. Pelayanan Ambulance dapat berdiri dalam konteks episode IGD, Rawat Inap, Rawat Jalan, Rujukan, maupun permintaan pelayanan langsung tanpa harus memiliki keterikatan dengan episode kunjungan IGD (`IgdVisit`).

---

## 2. Outcome Statement

Satu pelayanan transportasi medis ambulance bagi pasien — mencakup pemindahan lokasi dengan alokasi armada kendaraan dan petugas pendamping, serta dukungan pemantauan dan/atau tindakan medis sesuai kebutuhan klinis — **telah tercatat dan terlaksana hingga status selesai atau dibatalkan, serta dapat diverifikasi bukti pemenuhannya dan keterkaitannya dengan konteks pelayanan yang relevan**.

---

## 3. Participating Domains

| Domain | Kategori | Role in this Outcome |
|---|---|---|
| Gawat Darurat (IGD) | **Hosting Capability & Interacting Domain** | Menampung capability `IGD-AMBULANCE` berdasarkan katalog kapabilitas sistem. Bertindak sebagai domain peminta atau penerima pasien dalam skenario transportasi medis darurat, tanpa menjadi pemilik eksklusif yang membatasi pelayanan ambulance hanya untuk kasus IGD. |
| Pasien (PAS) | Domain Pendukung | Menyediakan data sosial dan identitas subjek/pasien yang menerima pelayanan transportasi medis (Nomor Rekam Medis), atau memfasilitasi identifikasi pasien dengan pengenal sementara pada kondisi darurat pra-faskes. |
| Organisasi (ORG) | Domain Pendukung | Menyediakan data unit layanan pengelola operasional ambulance (`ORG-LAYANAN`) serta data Petugas Pemberi Asuhan (PPA) / tenaga kesehatan pendamping (`ORG-PPA`) yang bertugas memberikan asuhan medis selama perjalanan. |
| Rawat Inap (RNA) | Domain Berinteraksi (*Interacting Domain*) | Berinteraksi sebagai peminta atau konteks pelayanan ketika pasien rawat inap memerlukan transportasi medis (misalnya rujukan keluar, transfer antar-fasilitas, atau pemulangan dengan pendampingan medis). |
| Rawat Jalan (RJL) | Domain Berinteraksi (*Interacting Domain*) | Berinteraksi sebagai peminta atau konteks pelayanan ketika pasien rawat jalan memerlukan transportasi rujukan medis atau penanganan antar-faskes. |
| Admission (ADM) | Domain Berinteraksi (*Interacting Domain*) | Berinteraksi dalam penyelarasan registrasi atau pelacakan perjalanan pasien (*patient journey tracking*) bila transportasi medis melibatkan proses admisi faskes formal. |
| Tata Rekening (TRK) | Domain Pendukung | Berinteraksi dalam penyediaan komponen tarif dan pencatatan tagihan (*billing*) atas pemanfaatan pelayanan transportasi medis ambulance. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `IGD-AMBULANCE` Ambulance | Gawat Darurat | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known |
| `RNA-TRANSFER` Transfer Ke Unit Lain | Rawat Inap | Known |
| `RJL-TRANSFER` Rujukan Internal | Rawat Jalan | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate  
> *Catatan Tata Kelola:* Seluruh kapabilitas yang digunakan berstatus **Known** dan mengacu langsung pada Domain Catalog yang sah. Tidak ada kapabilitas baru yang dibuat di luar katalog resmi.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Satu pelayanan transportasi medis ambulance atas nama seorang pasien telah dibuka dan tercatat sebagai pelayanan aktif yang diakui sistem.
- Pelayanan memiliki pasien/subjek yang dapat diidentifikasi: Nomor Rekam Medis resmi bila sudah terdaftar, atau nama/pengenal sementara bila identitas resmi belum dapat dipastikan pada saat penjemputan darurat.
- Pelayanan memiliki sumber atau konteks permintaan yang jelas (berasal dari unit IGD, Rawat Inap, Rawat Jalan, rujukan internal/eksternal, atau panggilan layanan medis masyarakat).
- Pelayanan memiliki titik lokasi asal penjemputan (*origin*) dan titik lokasi tujuan transportasi (*destination*) yang definitif.
- Pelayanan mencatat tingkat kebutuhan transportasi medis pasien (tingkat kegawatan klinis dan kebutuhan peralatan/pendampingan medis selama perjalanan).
- Pelayanan mencatat alokasi sumber daya pendukung: armada kendaraan ambulance yang digunakan serta petugas/crew yang ditugaskan (tenaga medis pendamping dan pengemudi).
- Pelayanan mencatat dukungan medis yang diberikan selama proses transportasi, mencakup pemantauan kondisi pasien dan/atau tindakan medis darurat/stabilisasi bila dibutuhkan.
- Pelayanan memiliki status siklus hidup yang tegas: aktif berjalan, selesai dilaksanakan, atau dibatalkan sebelum selesai.
- Pelayanan tidak mensyaratkan adanya episode `IGD Visit` sebagai prasyarat keberadaannya, namun dapat menautkan referensi ke `IGD Visit` apabila pelayanan diselenggarakan dalam konteks episode IGD.

### 5.2 Required Recorded Information

**Identifikasi Pelayanan & Pasien:**
- Nomor referensi unik pelayanan ambulance.
- Waktu pencatatan/permintaan pelayanan diterima.
- Identitas subjek/pasien yang menerima pelayanan (Nomor Rekam Medis atau pengenal sementara).
- Konteks atau sumber permintaan pelayanan (asal unit/ruangan peminta, faskes perujuk, atau kontak pelapor panggilan darurat).
- Kaitan konteks episode pelayanan (opsional, dapat merujuk ke episode IGD Visit, registrasi Rawat Inap, registrasi Rawat Jalan, atau rujukan faskes lain sesuai konteksnya).

**Perencanaan & Kebutuhan Transportasi Medis:**
- Lokasi asal penjemputan/keberangkatan (*origin*).
- Lokasi tujuan transportasi (*destination*).
- Indikasi klinis / alasan kebutuhan transportasi medis (misalnya: rujukan kegawatdaruratan, alih rawat inap intensif, pemeriksaan diagnostik lanjutan, transfer intra-faskes, atau transportasi kepulangan pasien dengan bantuan medis).
- Kebutuhan dukungan peralatan/medis khusus selama perjalanan (misalnya: oksigen transport, monitor vital sign, ventilator transport, suction, infus, atau pemantauan standar).

**Alokasi Sumber Daya Pendukung (*Resources*):**
- Identitas kendaraan ambulance yang ditugaskan (nomor polisi / identifikasi nomor armada).
- Identitas petugas pelaksana/crew:
  - Tenaga medis pendamping (dokter dan/atau perawat pendamping dari PPA).
  - Pengemudi ambulance yang bertugas.

**Pelaksanaan Transportasi & Asuhan Medis Selama Perjalanan:**
- Waktu keberangkatan dari lokasi asal.
- Waktu tiba di lokasi tujuan.
- Catatan kondisi klinis pasien selama perjalanan (pemantauan tanda vital dan perkembangan kondisi).
- Tindakan medis dan/atau pemberian obat/cairan yang dilakukan selama transportasi (bila ada indikasi kegawatan di jalan).

**Penyelesaian atau Pembatalan Pelayanan:**
- Status akhir pelayanan: tepat salah satu dari **Selesai** atau **Dibatalkan**.
- Waktu penetapan penyelesaian atau pembatalan pelayanan.
- Keterangan penyelesaian pelayanan (fakta serah terima pasien kepada pihak penerima di lokasi tujuan beserta kondisi serah terima pasien).
- Alasan pembatalan yang sah apabila pelayanan dibatalkan sebelum selesai.
- Identitas petugas yang memvalidasi penutupan pelayanan.

### 5.3 Required Business Conditions

- Pelayanan ambulance dapat dipicu dari domain mana pun yang membutuhkan transportasi medis pasien dan tidak terikat kepemilikan eksklusif pada IGD.
- Ketiadaan nomor rekam medis definitif pada situasi darurat pra-faskes tidak boleh menghalangi dimulainya pelayanan ambulance; pengenal sementara sah digunakan untuk mencatat pelayanan.
- Pelayanan ambulance wajib mengalokasikan armada kendaraan dan petugas pendamping/pengemudi sebelum pelaksanaan perjalanan medis dilakukan.
- Kendaraan ambulance (*Ambulance Vehicle*) dan crew bertindak sebagai sumber daya (*supporting resources*), bukan sebagai Outcome itu sendiri.
- Perjalanan fisik (*trip*) adalah instrumen pelaksanaan pemindahan, sedangkan inti bisnis outcome adalah pemenuhan pelayanan transportasi medis pasien yang aman.
- Pelayanan ambulance dapat diselesaikan secara independen tanpa harus menghasilkan episode `IGD Visit` baru.
- Pelayanan ambulance yang terhubung dengan episode IGD Visit hanya mencatat referensi timbal-balik, tanpa menempatkan ambulance sebagai subordinat yang tidak bisa eksis tanpa IGD.
- Satu pelayanan ambulance hanya dapat memiliki satu status akhir definitif: **Selesai** atau **Dibatalkan**.
- Pelayanan yang telah berstatus Selesai atau Dibatalkan bersifat final dan tidak dapat menerima perubahan operasional perjalanan baru.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Pelayanan ambulance tercatat dengan nomor referensi unik yang valid dan dapat ditelusuri.
- Pasien telah berhasil ditransportasikan ke lokasi tujuan yang sah, dibuktikan dengan fakta serah terima pasien kepada pihak/fasilitas penerima, waktu kedatangan, serta catatan kondisi akhir pasien; **ATAU**
- Pelayanan ambulance dinyatakan dibatalkan sebelum selesai dengan rekaman alasan pembatalan bisnis yang sah dan waktu pembatalan.
- Seluruh sumber daya pendukung (armada kendaraan dan crew pendamping) serta pemantauan/tindakan medis selama perjalanan (bila dilakukan) tercatat secara terverifikasi.
- Status pelayanan tercatat secara definitif sebagai **Selesai** atau **Dibatalkan**.

---

## 6. Outcome Boundary

### Start

Dimulai ketika permintaan atau kebutuhan pelayanan transportasi medis ambulance diterima, diverifikasi, dan ditetapkan untuk dilaksanakan bagi pasien/subjek yang bersangkutan — baik dipicu dari dalam faskes (IGD, Rawat Inap, Rawat Jalan) maupun dari luar faskes (panggilan darurat, rujukan antar-faskes).

### End

Selesai ketika:
1. Pasien telah tiba di lokasi tujuan yang ditentukan, pemantauan/asuhan medis transportasi telah tuntas, dan proses serah terima pasien di lokasi tujuan telah dicatat; **ATAU**
2. Pelayanan ambulance dibatalkan secara sah sebelum proses pemindahan/pelayanan selesai dilaksanakan (misalnya pasien menolak diangkut, terjadi pembatalan permintaan oleh unit peminta, atau kondisi klinis membatalkan kelayakan transportasi).

> **Catatan Boundary:** Boundary ini sepenuhnya berakar pada lifecycle pelayanan ambulance itu sendiri, dan sama sekali tidak bergantung pada apakah pasien masuk ke IGD, dirawat inap, atau dipulangkan dari rumah sakit.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Pelayanan Medis Lintas Domain, Bukan Sekadar Pengantar Fisik**: Ambulance merupakan pelayanan transportasi medis yang menyertakan dukungan observasi, pemantauan kondisi, dan/atau tindakan klinis selama perjalanan, bukan sekadar operasional kendaraan pengantar logistik atau moda transportasi umum.
- **Kemandirian Domain terhadap IGD (Non-Exclusive Ownership)**: Hubungan antara Ambulance dan IGD bersifat kolaborasi dan interaksi (*participating / interacting*), bukan kepemilikan hierarkis (*ownership*). `IGD Visit` bukan prasyarat universal (*mandatory parent*) bagi terbentuknya maupun selesainya pelayanan ambulance.
- **Aksesibilitas Multi-Domain**: Pelayanan ambulance dapat digunakan oleh pasien Rawat Inap, Rawat Jalan, IGD, rujukan antar-faskes, maupun pelayanan penjemputan masyarakat luas tanpa membatasi peruntukannya hanya pada kasus kegawatdaruratan IGD.
- **Pemisahan Tegas Konsep Domain**:
  - `Ambulance Service` adalah business outcome (pelayanan transportasi medis kepada pasien).
  - `Ambulance Vehicle` adalah resource fisik (kendaraan/armada) yang digunakan untuk mendukung pelayanan.
  - `Crew / Petugas` adalah resource personal (PPA/tenaga medis dan pengemudi) yang memberikan asuhan dan operasional.
  - `Request` adalah pemicu atau interaksi awal yang meminta diadakannya pelayanan.
  - `Trip / Transport Execution` adalah pelaksanaan konkret pergerakan fisik dari lokasi asal ke tujuan.
  - `Patient` adalah subjek manusia yang menerima asuhan dan pemindahan medis.
  - `IGD / Rawat Inap / Rawat Jalan / Rujukan` adalah service context atau domain peminta/berinteraksi.
- **Dukungan Asuhan Medis Berorientasi Kebutuhan Pasien**: Tingkat pemantauan tanda vital dan tindakan medis selama perjalanan diberikan secara proporsional sesuai kondisi klinis pasien dan indikasi transportasi medis.
- **Keabsahan Subjek Tanpa Harus Nomor RM Definitif**: Pada penjemputan darurat di lapangan, ketiadaan Nomor Rekam Medis resmi tidak boleh menunda pemberian pelayanan ambulance; pengenal sementara sah digunakan sampai identifikasi resmi dapat dilengkapi.
- **Status Akhir Saling Meniadakan**: Satu pelayanan ambulance hanya dapat berakhir dengan salah satu status definitif: Selesai atau Dibatalkan.

---

## 8. Business Exceptions

> Conditions under which the Outcome is established or handled under abnormal circumstances.

| Exception | Expected Behavior |
|---|---|
| Permintaan ambulance dibatalkan sebelum armada berangkat (misalnya keluarga menolak dirujuk, kondisi pasien mendadak tidak stabil untuk dipindahkan, atau faskes tujuan penuh) | Pelayanan ambulance ditutup dengan status **Dibatalkan** disertai alasan bisnis pembatalan dan identitas petugas yang membatalkan. |
| Pembatalan terjadi saat armada sudah dalam perjalanan menuju lokasi penjemputan (misalnya pasien telah dievakuasi mandiri oleh warga, atau panggilan palsu) | Pelayanan dihentikan dan ditutup dengan status **Dibatalkan** dengan catatan kronologi pembatalan operasional lapangan. |
| Pasien atau keluarga menolak diangkut saat tim ambulance tiba di lokasi asal (Penolakan Tindakan Medis / Pulang Paksa) | Pelayanan ditutup dengan status **Dibatalkan** disertai catatan penolakan tindakan medis dan dokumentasi pernyataan penolakan. |
| Terjadi perburukan drastis kondisi pasien di tengah perjalanan yang memerlukan pengalihan tujuan (*Emergency Re-routing*) | Tim medis pendamping melakukan tindakan resusitasi/stabilisasi darurat dan berhak mengalihkan tujuan ke fasilitas kesehatan terdekat yang mampu menangani. Perubahan lokasi tujuan dan alasan medis dicatat dalam riwayat perjalanan tanpa membatalkan pelayanan. |
| Pelayanan ambulance diselesaikan tanpa pernah berinteraksi dengan IGD (misalnya pemulangan pasien rawat inap ke rumah, atau rujukan poli langsung ke RS lain) | Pelayanan ambulance diselesaikan secara sah pada konteksnya masing-masing. Sistem tidak boleh mewajibkan pembentukan episode `IGD Visit` untuk menyelesaikan pelayanan tersebut. |
| Pasien meninggal dunia dalam perjalanan ambulance (*Death in Transit*) | Pelayanan ambulance tetap diselesaikan hingga tiba di fasilitas tujuan yang ditunjuk, dengan catatan eksplisit mengenai waktu henti sirkulasi, tindakan resusitasi yang telah diupayakan, dan fakta kematian dalam perjalanan (*DOA / Death in Transit*) pada berkas serah terima. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Pelayanan ambulance memiliki subjek/pasien penerima pelayanan yang dapat diidentifikasi (baik menggunakan Nomor Rekam Medis terdaftar maupun pengenal sementara pada kondisi darurat). | Completeness |
| AC-02 | Pelayanan ambulance mencatat tujuan transportasi medis serta titik lokasi asal (*origin*) dan tujuan (*destination*) yang relevan. | Completeness |
| AC-03 | Pelayanan ambulance mencatat keterlibatan sumber daya pendukung yang meliputi armada kendaraan ambulance dan petugas/crew (tenaga medis pendamping dan pengemudi). | Completeness |
| AC-04 | Pelayanan ambulance mencatat kebutuhan transportasi medis serta bukti pemantauan kondisi dan/atau tindakan medis yang diberikan kepada pasien selama perjalanan sesuai kebutuhan klinis. | Completeness |
| AC-05 | Pelayanan ambulance dapat dikaitkan dengan domain atau service context peminta (seperti IGD, Rawat Inap, Rawat Jalan, Rujukan, atau Panggilan Eksternal) apabila konteks tersebut ada. | Correctness |
| AC-06 | Pelayanan ambulance dapat berinteraksi dan digunakan oleh IGD tanpa menjadikan IGD sebagai pemilik mutlak (*mandatory owner*) atau parent wajib bagi pelayanan ambulance. | Constraint |
| AC-07 | Pelayanan ambulance dapat diselenggarakan dan diselesaikan oleh Rawat Inap, Rawat Jalan, Rujukan antar-faskes, atau layanan eksternal tanpa mensyaratkan adanya episode `IGD Visit`. | Constraint |
| AC-08 | Kendaraan ambulance dan petugas/crew terverifikasi berkedudukan sebagai sumber daya pendukung (*resources*), bukan sebagai Outcome itu sendiri. | Constraint |
| AC-09 | Status akhir pelayanan secara eksplisit dan definitif membuktikan apakah pelayanan berstatus **Selesai** (dengan bukti serah terima pasien di tujuan) atau **Dibatalkan** (dengan rekaman alasan bisnis yang sah). | Correctness |
| AC-10 | Bukti penyelesaian pelayanan diverifikasi berdasarkan fakta bisnis (*business facts*) yang dapat diobservasi, bukan berdasarkan asumsi atau mekanisme implementasi teknis. | Correctness |
| AC-11 | Apabila terjadi pembatalan atau perubahan tujuan darurat (*emergency re-routing*) di perjalanan, pelayanan ambulance dapat mengakomodasi kondisi tersebut dengan pencatatan alasan bisnis tanpa merusak riwayat pelayanan. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pengelolaan fisik armada kendaraan, jadwal perawatan mesin, penggantian suku cadang, pengurusan pajak kendaraan, dan konsumsi bahan bakar minyak (BBM) → Dikelola oleh **Manajemen Fasilitas & Aset / Logistik Umum (*Fleet Management*)**.
- Penyelenggaraan episode kunjungan IGD, penentuan prioritas triage di IGD, serta tindakan medis yang berlangsung di dalam ruangan IGD → Diatur dalam **OC-07-01 IGD Visit**, **OC-07-02 Triage**, dan **OC-07-04 Tindakan**.
- Pengelolaan kamar/bed dan admisi kepulangan di bangsal rawat inap → Diatur dalam **OC-01-03 Registrasi Rawat Inap**, **OC-06-02 Pakai Bed**, dan **OC-06-04 Discharge**.
- Penghitungan rinci tarif sewa kendaraan, penetapan biaya jasa medis petugas pendamping, dan pemrosesan pembayaran di kasir → Diatur dalam **Domain Tata Rekening** (`TRK-TARIF`, `TRK-BILLING`, `TRK-KASIR`).
- Dokumentasi rekam medis lengkap, formulir CPPT, dan resume medis komprehensif pasien di luar catatan pemantauan transportasi → Dikelola oleh **Domain Rekam Medis / EMR**.
- Detail teknis sistem telemetri GPS, antarmuka peta/rute digital, skema basis data relational, kontrak API antarsistem, dan tata letak UI aplikasi mobile/desktop → Menjadi ranah Arsitektur dan Desain Implementasi Teknis.
