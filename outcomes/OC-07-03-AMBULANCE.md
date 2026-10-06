# OUTCOME: Ambulance

| Field       | Value        |
|-------------|--------------|
| Code        | OC-07-03     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Rumah sakit harus mampu menyediakan dan mencatat **pelayanan transportasi medis kepada pasien** sebagai *persisted business fact* yang menjamin keselamatan, kesinambungan asuhan medis (*continuity of care*), dan akuntabilitas pemindahan pasien antar-lokasi.

Pelayanan Ambulance merepresentasikan **pelayanan transportasi medis kepada pasien**, bukan pengelolaan armada kendaraan (*fleet management*) dan bukan sekadar pencatatan perjalanan kendaraan (*trip log*). Pelayanan ini diselenggarakan untuk memindahkan pasien dari satu lokasi ke lokasi lain dengan dukungan pemantauan dan/atau asuhan medis sesuai kebutuhan pasien selama transportasi.

Secara bisnis, Pelayanan Ambulance merupakan **pelayanan lintas-domain (*cross-domain service*)** yang dapat digunakan oleh berbagai domain atau konteks pelayanan, meliputi:
- Penjemputan pasien dari lokasi kejadian atau tempat tinggal menuju fasilitas kesehatan;
- Transportasi pasien dari rumah menuju rumah sakit atau fasilitas kesehatan;
- Rujukan atau transfer medis pasien antar-fasilitas kesehatan (faskes);
- Pemindahan pasien antar-unit atau fasilitas sesuai kebutuhan kontinuitas pelayanan;
- Kebutuhan transportasi medis pasien Rawat Inap;
- Kebutuhan transportasi medis pasien Rawat Jalan;
- Kebutuhan transportasi medis pasien Instalasi Gawat Darurat (IGD);
- Kebutuhan transportasi medis lainnya yang memenuhi tujuan pelayanan Ambulance.

Instalasi Gawat Darurat (IGD) adalah salah satu domain yang dapat berinteraksi dengan pelayanan Ambulance, namun **IGD bukan owner maupun parent wajib dari Ambulance**. Pelayanan Ambulance dapat diselenggarakan secara mandiri dan dapat berdiri sendiri tanpa harus memiliki keterikatan atau ketergantungan pada episode kunjungan IGD (`IgdVisit`). `IgdVisit` bersifat opsional dan **bukan prerequisite** untuk membuat maupun menyelesaikan pelayanan Ambulance.

---

## 2. Outcome Statement

Satu pelayanan transportasi medis ambulance bagi pasien — mencakup pemindahan lokasi dengan ketersediaan sumber daya transportasi serta dukungan pemantauan atau asuhan medis sesuai kebutuhan pasien — **telah tercatat dan terlaksana hingga mencapai status final (Selesai atau Dibatalkan), serta dapat diverifikasi bukti penyelesaiannya**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| Gawat Darurat (IGD) | Domain yang menaungi capability `IGD-AMBULANCE` dalam Capability Catalog repositori saat ini. Bertanggung jawab atas pembentukan (*establishing*), pemutakhiran (*modifying*), dan penyelesaian (*completing*) outcome pelayanan transportasi medis ambulance. Domain pelayanan lain (seperti Rawat Inap, Rawat Jalan, atau IGD Visit) bertindak sebagai *service context* peminta atau tujuan rujukan, bukan domain yang memiliki lifecycle outcome ini. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `IGD-AMBULANCE` Ambulance | Gawat Darurat | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate  
> *Catatan Validasi:* Mengacu langsung pada Domain Catalog resmi repository (`domain/DOMAIN-CATALOG.md`). Domain pendukung/konsumen (seperti Pasien, Organisasi, Admission, dan Tata Rekening) maupun konteks peminta (seperti Rawat Inap dan Rawat Jalan) tidak dicantumkan sebagai Participating Capabilities karena tidak berperan langsung dalam establishing, modifying, atau completing outcome Ambulance.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Satu pelayanan transportasi medis ambulance tercatat sebagai pelayanan aktif yang diakui sistem.
- Terdapat subjek/pasien yang diangkut (dapat diidentifikasi melalui Nomor Rekam Medis terdaftar atau pengenal sementara pada kondisi darurat).
- Terdapat kebutuhan transportasi medis yang melandasi diselenggarakannya pelayanan.
- Terdapat lokasi asal (*origin*) dan lokasi tujuan (*destination*) transportasi medis yang jelas.
- Terdapat konteks atau sumber permintaan pelayanan.
- Terdapat alokasi sumber daya transportasi yang digunakan (armada kendaraan ambulance dan petugas pelaksana yang bertugas).
- Terdapat dukungan pemantauan dan/atau asuhan medis selama transportasi bila diperlukan sesuai kebutuhan pasien.
- Pelayanan memiliki status lifecycle yang jelas: `Active`, `Selesai`, atau `Dibatalkan`.
- Terdapat bukti serah terima (*handover*) atau bukti bahwa transportasi telah selesai pada tujuan yang valid, atau rekaman alasan yang sah bila dibatalkan.
- Pelayanan ambulance dapat berdiri sendiri tanpa mensyaratkan adanya episode `IgdVisit`.

### 5.2 Required Recorded Information

- Identifikasi unik pelayanan ambulance.
- Identifikasi subjek/pasien yang diangkut (Nomor Rekam Medis atau pengenal sementara).
- Konteks atau sumber permintaan pelayanan.
- Kebutuhan transportasi medis.
- Lokasi asal dan lokasi tujuan transportasi medis.
- Alokasi sumber daya transportasi yang digunakan (kendaraan dan petugas).
- Informasi waktu pelaksanaan transportasi (waktu mulai/keberangkatan dan waktu selesai/tiba).
- Keterangan pemantauan atau asuhan medis selama perjalanan (bila terdapat kebutuhan klinis).
- Status akhir pelayanan (`Selesai` atau `Dibatalkan`).
- Bukti penyelesaian atau serah terima (*handover*) pada tujuan yang valid, atau alasan pembatalan bila pelayanan dihentikan/dibatalkan.

### 5.3 Required Business Conditions

- Pelayanan ambulance merupakan layanan lintas-domain yang dapat digunakan oleh IGD, Rawat Inap, Rawat Jalan, Rujukan, maupun kebutuhan pra-faskes.
- `IgdVisit` bukan prerequisite; pelayanan ambulance dapat dibuat, dijalankan, dan diselesaikan tanpa adanya episode `IgdVisit`.
- Ketiadaan Nomor Rekam Medis resmi pada kondisi darurat tidak menghalangi dimulainya pelayanan ambulance; pengenal sementara sah digunakan.
- Sumber daya transportasi (armada kendaraan dan petugas pelaksana) harus tersedia dan teralokasi untuk pelaksanaan transportasi medis.
- Kendaraan dan petugas berkedudukan sebagai sumber daya pendukung (*resources*), bukan sebagai Outcome itu sendiri.
- Status pelayanan mengikuti lifecycle bisnis yang tegas:
  - `Active`: Pelayanan transportasi medis sedang aktif dipersiapkan atau dalam proses perjalanan.
  - `Selesai`: Pelayanan transportasi medis berhasil memenuhi kebutuhan transportasi pasien sampai tujuan yang valid dan proses serah terima (*handover*) atau penyelesaian transportasi telah terjadi.
  - `Dibatalkan`: Pelayanan tidak mencapai penyelesaian transportasi yang dimaksud dan secara sah dihentikan atau dibatalkan.
- Pengalihan rute (*rerouting*) akibat kondisi darurat ke tujuan alternatif yang valid tidak otomatis berarti Dibatalkan; outcome tetap berstatus `Selesai` selama kebutuhan transportasi pasien terpenuhi.
- Setelah outcome mencapai status final (`Selesai` atau `Dibatalkan`), tidak ada lagi perubahan operasional terhadap outcome.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Pelayanan ambulance tercatat dengan identifikasi unik yang valid.
- Pasien telah berhasil ditransportasikan sampai tujuan yang valid dan terdapat bukti serah terima (*handover*) atau bukti penyelesaian transportasi; **ATAU**
- Pelayanan secara sah dibatalkan sebelum selesai dengan rekaman alasan pembatalan bisnis.
- Status pelayanan tercatat secara final sebagai **Selesai** atau **Dibatalkan**.

---

## 6. Outcome Boundary

### Start

Dimulai ketika permintaan atau kebutuhan pelayanan transportasi medis ambulance diterima, dicatat, dan ditetapkan untuk dilaksanakan bagi pasien/subjek yang bersangkutan — baik diminta oleh unit di dalam faskes (IGD, Rawat Inap, Rawat Jalan) maupun dari pihak eksternal (panggilan penjemputan, rujukan faskes lain).

### End

Selesai ketika:
1. Kebutuhan transportasi medis pasien terpenuhi sampai lokasi tujuan yang valid (termasuk tujuan alternatif hasil *rerouting* darurat) dan proses serah terima (*handover*) pasien telah dicatat; **ATAU**
2. Pelayanan ambulance dibatalkan secara sah sebelum penyelesaian transportasi tercapai (misalnya pembatalan permintaan oleh unit peminta atau penolakan oleh pasien/keluarga).

> **Catatan Boundary:** Boundary ini sepenuhnya berakar pada lifecycle pelayanan transportasi ambulance itu sendiri, dan sama sekali tidak bergantung pada apakah pasien masuk ke IGD, dirawat inap, atau dipulangkan dari rumah sakit.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Pelayanan Transportasi Medis Lintas Domain**: Ambulance adalah pelayanan transportasi medis kepada pasien, bukan pengelolaan armada kendaraan (*fleet management*) dan bukan sekadar pencatatan perjalanan (*trip log*).
- **Kemandirian Domain terhadap IGD (Non-Exclusive Ownership)**: IGD bukan owner maupun parent wajib dari Ambulance. `IgdVisit` bukan prerequisite bagi pembentukan maupun penyelesaian pelayanan Ambulance. Ambulance dapat berdiri sendiri tanpa `IgdVisit`.
- **Aksesibilitas Multi-Domain**: Pelayanan Ambulance dapat digunakan oleh berbagai konteks pelayanan (Rawat Inap, Rawat Jalan, IGD, rujukan antar-faskes, maupun pelayanan pra-faskes).
- **Pemisahan Konsep Layanan vs Sumber Daya vs Pemicu**:
  - `Ambulance Service` adalah business outcome (pelayanan transportasi medis kepada pasien).
  - `Ambulance Vehicle` & `Crew` adalah sumber daya transportasi (*supporting resources*) yang digunakan.
  - `Request` adalah pemicu atau interaksi awal yang meminta pelayanan.
  - `Patient` adalah subjek yang menerima pelayanan.
  - `IGD / Rawat Inap / Rawat Jalan / Rujukan` adalah service context peminta atau tujuan.
- **Dukungan Asuhan Medis Berorientasi Kebutuhan Pasien**: Pemantauan dan asuhan medis selama transportasi diberikan sesuai dengan kebutuhan klinis pasien dan konteks pelayanan.
- **Keabsahan Subjek Tanpa Prasyarat No. RM**: Pada kondisi darurat pra-faskes, ketiadaan Nomor Rekam Medis definitif tidak menghalangi pelaksanaan pelayanan ambulance; pengenal sementara sah digunakan.
- **Kemandirian Status Akhir (Finality)**: Setelah outcome mencapai status final (`Selesai` atau `Dibatalkan`), tidak ada lagi perubahan operasional terhadap outcome.

---

## 8. Business Exceptions

> Conditions under which the Outcome is established or handled under abnormal circumstances.

| Exception | Expected Behavior |
|---|---|
| Permintaan ambulance dibatalkan sebelum pelaksanaan perjalanan (misalnya pembatalan oleh unit peminta, atau kondisi pasien tidak stabil untuk dipindahkan) | Pelayanan ambulance ditutup dengan status **Dibatalkan** disertai alasan bisnis pembatalan. |
| Pembatalan terjadi saat armada sudah menuju lokasi penjemputan atau pasien menolak diangkut (Penolakan Tindakan Medis / Pulang Paksa) | Pelayanan dihentikan dan ditutup dengan status **Dibatalkan** dengan catatan alasan pembatalan operasional. |
| Terjadi perburukan kondisi klinis yang memerlukan pengalihan rute darurat (*emergency rerouting*) ke fasilitas tujuan alternatif yang valid | Pengalihan rute darurat tidak otomatis berarti Dibatalkan. Jika pasien tetap berhasil ditransportasikan dan kebutuhan pelayanan terpenuhi melalui tujuan alternatif yang valid, outcome tetap berstatus **Selesai** dengan pencatatan tujuan akhir yang disesuaikan. |
| Pasien meninggal dunia selama perjalanan (*death in transit*) | Kejadian pasien meninggal selama perjalanan menjadi bagian dari penyelesaian pelayanan transportasi. Tujuan dan proses serah terima (*handover*) akhir tetap ditentukan dan dicatat sesuai konteks pelayanan. Detail klinis dan pelaporan kematian merupakan tanggung jawab domain/capability terkait di luar scope Ambulance. |
| Pelayanan ambulance selesai tanpa pernah berinteraksi dengan IGD (misalnya pemulangan pasien rawat inap, transfer antar-bangsal luar, atau rujukan poli langsung ke faskes lain) | Pelayanan ambulance diselesaikan secara sah pada konteksnya masing-masing. Sistem tidak boleh mewajibkan pembentukan episode `IgdVisit` untuk menyelesaikan pelayanan tersebut. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Pelayanan Ambulance dapat diselenggarakan secara mandiri tanpa mensyaratkan adanya episode `IgdVisit` sebagai prasyarat. | Constraint |
| AC-02 | Pelayanan Ambulance dapat digunakan lintas domain oleh berbagai service context (seperti Rawat Inap, Rawat Jalan, Rujukan, IGD, maupun penjemputan eksternal). | Constraint |
| AC-03 | Subjek/pasien yang diangkut dan kebutuhan transportasi medis dapat diidentifikasi secara jelas (menggunakan Nomor Rekam Medis terdaftar atau pengenal sementara pada kondisi darurat). | Completeness |
| AC-04 | Pelayanan mencatat lokasi asal (*origin*) dan lokasi tujuan (*destination*) transportasi medis yang jelas. | Completeness |
| AC-05 | Sumber daya transportasi (armada kendaraan dan petugas pelaksana) teralokasi dan tersedia untuk mendukung pelaksanaan pelayanan. | Completeness |
| AC-06 | Status pelayanan secara definitif merefleksikan lifecycle: `Active`, `Selesai`, atau `Dibatalkan`. | Correctness |
| AC-07 | Pelayanan berstatus `Selesai` memiliki bukti penyelesaian atau serah terima (*handover*) pasien pada lokasi tujuan yang valid. | Completeness |
| AC-08 | Pengalihan rute (*rerouting*) akibat kondisi darurat ke tujuan alternatif yang valid tetap menghasilkan status `Selesai` selama kebutuhan transportasi pasien terpenuhi. | Correctness |
| AC-09 | Pembatalan pelayanan sebelum tercapainya tujuan transportasi menghasilkan status `Dibatalkan` disertai rekaman alasan pembatalan bisnis yang sah. | Exception |
| AC-10 | Kejadian pasien meninggal dalam perjalanan (*death in transit*) ditangani sebagai bagian dari penyelesaian transportasi dengan pencatatan serah terima akhir, tanpa mengambil alih dokumentasi klinis atau pelaporan kematian dari domain terkait. | Exception |
| AC-11 | Setelah mencapai status final (`Selesai` atau `Dibatalkan`), outcome tidak dapat menerima perubahan operasional lebih lanjut. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pengelolaan fisik armada kendaraan, jadwal perawatan mesin, penggantian suku cadang, dan konsumsi BBM → Dikelola oleh **Manajemen Fasilitas & Aset / Logistik Umum (*Fleet Management*)**.
- Penyelenggaraan episode kunjungan IGD, penentuan prioritas triage di IGD, serta tindakan klinis di dalam ruangan IGD → Diatur dalam **OC-07-01 IGD Visit**, **OC-07-02 Triage**, dan **OC-07-04 Tindakan**.
- Pengelolaan kamar/bed, tindakan bangsal, dan admisi kepulangan rawat inap → Diatur dalam **OC-01-03 Registrasi Rawat Inap**, **OC-06-02 Pakai Bed**, dan **OC-06-04 Discharge**.
- Penghitungan rinci tarif sewa kendaraan, pembuatan faktur/kuitansi, dan pemrosesan pembayaran di kasir → Diatur dalam **Domain Tata Rekening** (`TRK-TARIF`, `TRK-BILLING`, `TRK-KASIR`).
- Dokumentasi rekam medis lengkap, formulir CPPT, dan resume medis komprehensif pasien di luar catatan pemantauan transportasi → Dikelola oleh **Domain Rekam Medis / EMR**.
- Detail teknis sistem telemetri GPS, antarmuka peta/rute digital, skema basis data relational, kontrak API antarsistem, dan tata letak UI aplikasi mobile/desktop → Menjadi ranah Arsitektur dan Desain Implementasi Teknis.
