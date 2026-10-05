# OUTCOME: Order Operasi

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-10-01          |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-05        |

---

## 1. Business Purpose

Rumah sakit harus mampu menerima dan mencatat keputusan klinis serta instruksi formal dari Dokter Penanggung Jawab Pelayanan (Dokter DPJP / Dokter Spesialis Bedah) bahwa seorang pasien direncanakan untuk menjalani tindakan pembedahan operatif.

Order Operasi mendokumentasikan alasan klinis (indikasi), rencana prosedur pembedahan, tingkat urgensi, perkiraan durasi, target waktu tindakan, serta kebutuhan sumber daya dan pertimbangan perioperatif khusus yang diperlukan.

Order Operasi menjadi dasar bisnis otoritatif bagi instalasi kamar operasi (Instalasi Bedah Sentral / IBS) untuk memproses penjadwalan kamar operasi (**OC-10-02 Scheduling**) serta mengoordinasikan persiapan pra-bedah dan keselamatan pasien (**OC-10-03 Pre-Operative Clearance**). Tanpa Order Operasi yang terbit secara resmi, alokasi kamar operasi, penugasan tim bedah, penyediaan sumber daya khusus, dan verifikasi kelaikan medis tidak memiliki landasan instruksi klinis.

---

## 2. Outcome Statement

Instruksi formal rencana tindakan operatif dari Dokter DPJP untuk pasien yang teridentifikasi **telah tercatat dan berstatus terbit (Submitted), memuat indikasi klinis, rencana tindakan pembedahan, lateralisasi, tingkat urgensi, target waktu, dan kebutuhan sumber daya khusus, serta siap diproses untuk penjadwalan kamar operasi dan persiapan perioperatif**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome                                                                                                            |
|---------------|---------------------------------------------------------------------------------------------------------------------------------|
| Kamar Operasi | Pemilik utama: mencatat, mengelola, dan memvalidasi Order Operasi sebagai persisted business fact melalui capability `KMO-ORDER` |
| Pasien        | Menyediakan identitas pasien yang menjadi subjek rencana tindakan pembedahan melalui `PAS-DATSOS`                              |
| Organisasi    | Menyediakan data Dokter DPJP (Petugas Pemberi Asuhan / PPA) yang berwenang menerbitkan order, serta unit layanan asal order     |
| Admission     | Menyediakan konteks registrasi kunjungan rumah sakit yang aktif (episode perawatan pasien)                                      |
| Rawat Jalan   | Menyediakan konteks episode layanan asal jika order operasi elektif diterbitkan dari poliklinik rawat jalan                     |
| Rawat Inap    | Menyediakan konteks episode layanan asal jika order operasi diterbitkan saat pasien sedang dirawat di bangsal rawat inap         |
| Gawat Darurat | Menyediakan konteks episode layanan asal jika order operasi darurat (CITO) diterbitkan dari Instalasi Gawat Darurat            |

---

## 4. Participating Capabilities

| Capability                     | Domain        | Status |
|--------------------------------|---------------|--------|
| `KMO-ORDER` Order Operasi      | Kamar Operasi | Known  |
| `PAS-DATSOS` Data Sosial Pasien | Pasien       | Known  |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi   | Known  |
| `ORG-LAYANAN` Unit Layanan     | Organisasi    | Known  |
| `ADM-REG` Registration         | Admission     | Known  |
| `RJL-KONSUL` Konsultasi        | Rawat Jalan   | Known  |
| `RNA-BED` Pakai Bed            | Rawat Inap    | Known  |
| `IGD-VISIT` IGD Visit          | Gawat Darurat | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Order Operasi atas nama pasien yang teridentifikasi telah tercatat dalam sistem.
- Order Operasi diterbitkan oleh Dokter DPJP yang aktif dan memiliki kewenangan klinis pembedahan yang valid.
- Order Operasi merujuk pada episode registrasi kunjungan pasien yang aktif (Rawat Jalan, Rawat Inap, atau Gawat Darurat).
- Order Operasi memiliki identifikasi tingkat urgensi yang jelas: **Elektif** (terencana) atau **CITO** (darurat/segera).
- Rencana prosedur pembedahan, indikasi klinis pra-bedah, lokasi anatomis (*surgical site*), dan sisi lateralisasi (jika berlaku) telah ditetapkan secara definitif oleh DPJP.
- Kebutuhan sumber daya khusus yang diantisipasi (implan, alat khusus, penunjang intraoperatif, darah, ruang rawat intensif) tercatat sebagai deklarasi kebutuhan klinis.
- Order Operasi memiliki status siklus hidup yang tegas:
  - **Draft**: Rencana order sedang disusun atau dilengkapi oleh DPJP, belum bersifat instruksi resmi bagi kamar operasi, dan belum dapat dijadwalkan.
  - **Submitted (Terbit)**: Order telah divalidasi kelengkapannya dan disahkan oleh DPJP, menerbitkan nomor referensi unik, dan siap diproses oleh proses penjadwalan kamar operasi (**OC-10-02**).
  - **Dibatalkan (Cancelled)**: Order dibatalkan secara formal oleh DPJP sebelum tindakan dilaksanakan, dengan alasan pembatalan yang tercatat.

### 5.2 Required Recorded Information

**Identitas Pasien dan Konteks Kunjungan:**
- Nomor referensi Order Operasi yang unik.
- Identitas pasien (Nomor Rekam Medis, nama pasien, tanggal lahir/umur, dan jenis kelamin).
- Nomor registrasi kunjungan (episode perawatan aktif).
- Unit layanan asal order (Poliklinik, Bangsal Rawat Inap, atau IGD).
- Dokter DPJP pembuat order (identitas PPA).
- Tanggal dan waktu pencatatan order (waktu draft dan waktu submit).

**Rencana Klinis dan Prosedur Pembedahan:**
- Diagnosis kerja pra-bedah / indikasi klinis yang mendasari keputusan pembedahan.
- Rencana tindakan pembedahan (nama tindakan/prosedur operasi).
- Lokasi anatomis pembedahan (*surgical site*).
- Lateralisasi (*laterality*): Kanan (*Right*), Kiri (*Left*), Bilateral, atau Tidak Berlaku (*Not Applicable*).
- Tingkat urgensi / prioritas: Elektif atau CITO.
- Target tanggal operasi yang diharapkan oleh DPJP.
- Perkiraan durasi pembedahan (dalam menit atau jam).

**Kebutuhan Sumber Daya Khusus (Resource Requirements):**
- Kebutuhan implan / prostesis khusus (deskripsi jenis, spesifikasi/tipe implan, jika diperlukan).
- Kebutuhan instrumen bedah khusus (misal: set laparoskopi, arthroskopi, mikro-bedah).
- Kebutuhan alat penunjang intra-operatif (misal: C-Arm, USG intraoperatif, electrosurgical unit khusus, mesin phaco).
- Kebutuhan produk darah / transfusi (golongan darah, jenis komponen darah seperti PRC/TC/FFP, dan jumlah kantong yang diantisipasi).
- Kebutuhan keterlibatan personel / dokter spesialis tambahan (misal: operasi bersama lintas disiplin spesialis).
- Kebutuhan ruang perawatan intensif pasca-operasi (antisipasi kebutuhan tempat tidur ICU / HCU / PICU / NICU).

> *Catatan Batas Bisnis:* Informasi kebutuhan sumber daya di atas mencatat **kebutuhan klinis yang diminta oleh DPJP**, bukan konfirmasi ketersediaan fisik barang atau reservasi tempat tidur. Ketersediaan dan alokasi fisik dikelola pada proses berikutnya (**OC-10-02 Scheduling** dan domain inventori/rawat inap).

**Pertimbangan Klinis dan Risiko Khusus (Clinical Considerations):**
- Kategori risiko pembedahan atau kondisi umum pasien yang relevan.
- Risiko perdarahan tinggi (jika diantisipasi oleh operator).
- Riwayat alergi obat atau bahan tertentu yang relevan untuk tindakan perioperatif.
- Penggunaan obat-obatan khusus yang memerlukan perhatian perioperatif (misal: antikoagulan, antiplatelet, insulin, kortikosteroid).
- Komorbiditas penting atau pertimbangan klinis khusus lainnya (merujuk pada catatan rekam medis pasien tanpa menduplikasi seluruh isi asesmen medis).

**Usulan Rencana Anestesi (Suggested Anesthesia Approach — Opsional):**
- Usulan teknik anestesi dari DPJP bedah (misal: Anestesi Umum / General Anesthesia, Regional / Spinal, Blok Perifer, Lokal, atau Sedasi).

> *Catatan Batas Bisnis:* Usulan ini bersifat **rekomendasi klinis dari dokter operator** dan bukan merupakan keputusan final anestesi. Keputusan dan rencana akhir anestesi menjadi wewenang dokter spesialis anestesiologi pada evaluasi pra-anestesi (**OC-10-03 Pre-Operative Clearance**).

### 5.3 Required Business Conditions

- Pasien yang menjadi subjek order harus terdaftar aktif dalam sistem dengan Nomor Rekam Medis yang valid.
- Dokter yang menerbitkan dan menandatangani order harus merupakan DPJP aktif dengan kewenangan klinis pembedahan yang sah.
- Data klinis mandatori (indikasi/diagnosis pra-bedah, jenis rencana tindakan, lokasi bedah, lateralisasi untuk organ berpasangan, urgensi, target tanggal, dan estimasi durasi) wajib terisi lengkap sebelum order dapat diubah statusnya menjadi **Submitted**.
- Target tanggal operasi tidak boleh berada di masa lampau (*past date*).
- Untuk organ atau bagian tubuh berpasangan (*paired organs/structures*), lateralisasi wajib ditentukan secara eksplisit (Kanan, Kiri, atau Bilateral); nilai 'Tidak Berlaku' hanya diperbolehkan untuk struktur tubuh tunggal di garis tengah (*midline*) atau non-lateral.
- Order Operasi dalam status **Draft** belum dianggap sebagai instruksi resmi dan tidak dapat ditarik oleh unit kamar operasi untuk dijadwalkan.
- Permintaan dengan urgensi **CITO** dapat diajukan secara langsung untuk memicu prioritas penjadwalan tinggi, tetapi tetap wajib memuat kelengkapan identitas pasien, diagnosis, dan rencana prosedur demi keselamatan pasien.
- Satu Order Operasi yang telah berstatus **Submitted** tidak boleh diubah langsung isi klinisnya; setiap perubahan mendasar harus dilakukan melalui mekanisme revisi klinis resmi atau pembatalan order.

### 5.4 Completion Proof

- Nomor referensi unik Order Operasi telah diterbitkan dan tersimpan dalam sistem.
- Status Order Operasi tercatat sebagai **Submitted (Terbit)**.
- Order Operasi dapat ditelusuri dan diakses oleh petugas kamar operasi (Kepala Ruangan/Admin IBS) berdasarkan nomor order, nomor rekam medis, DPJP, tanggal target, atau tingkat urgensi.
- Order Operasi tersedia dan siap dikonsumsi sebagai input resmi bagi proses penjadwalan kamar operasi (**OC-10-02 Scheduling**) dan persiapan perioperatif (**OC-10-03 Pre-Operative Clearance**).

---

## 6. Outcome Boundary

### Start

Dimulai ketika Dokter DPJP menetapkan keputusan klinis bahwa pasien memerlukan tindakan pembedahan operatif dan memulai pencatatan rencana pembedahan (Order Operasi) dari konteks poliklinik rawat jalan, bangsal rawat inap, atau instalasi gawat darurat.

### End

Berakhir ketika Order Operasi telah lengkap, divalidasi terhadap seluruh aturan bisnis dan keselamatan klinis, disahkan oleh Dokter DPJP, dan tersimpan secara permanen dalam sistem dengan status **Submitted (Terbit)** serta nomor referensi unik yang siap diproses oleh alur kerja kamar operasi.

> Outcome ini juga dapat berakhir dengan status terminal **Dibatalkan (Cancelled)** apabila Dokter DPJP secara resmi membatalkan instruksi rencana operasi sebelum tindakan dijadwalkan atau dilaksanakan, disertai pencatatan alasan pembatalan klinis/operasional.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Otoritas Klinis Pembuat Order:** Order Operasi hanya sah apabila diterbitkan dan disetujui oleh Dokter DPJP / Dokter Spesialis Bedah yang memiliki kewenangan klinis (*clinical privileges*) pembedahan yang aktif.
2. **Pemisahan Order dan Jadwal Definitif:** Order Operasi adalah instruksi klinis dan pernyataan kebutuhan tindakan, bukan jadwal definitif. Target tanggal operasi yang dinyatakan oleh DPJP merupakan target klinis yang diharapkan, bukan penetapan waktu pasti pemakaian kamar bedah.
3. **Pemisahan Permintaan Sumber Daya dan Alokasi Fisik:** Pencatatan kebutuhan implan, peralatan bedah khusus, C-Arm, darah, dan bed ICU merupakan pencatatan kebutuhan klinis yang diminta, bukan bukti ketersediaan atau alokasi fisik sumber daya. Alokasi dan konfirmasi ketersediaan fisik menjadi tanggung jawab proses penjadwalan (**OC-10-02**) dan unit pengelola terkait.
4. **Pemisahan Pertimbangan Risiko dan Kelaikan Pra-Bedah:** Pencatatan risiko operasi dan pertimbangan klinis pada Order Operasi tidak menggantikan dan tidak setara dengan izin kelaikan medis perioperatif (*Pre-Operative Medical Clearance* pada **OC-10-03**).
5. **Independensi Keputusan Anestesi:** Usulan pendekatan anestesi dari DPJP bedah bersifat rekomendasi klinis dan tidak mengikat keputusan final dari dokter spesialis anestesiologi.
6. **Integritas Lateralisasi dan Keselamatan Pasien:** Untuk seluruh prosedur pada organ atau struktur tubuh berpasangan, lateralisasi (Kanan, Kiri, Bilateral) wajib dideklarasikan secara tegas guna memenuhi standar keselamatan pasien bedah (*pencegahan salah sisi / wrong-site surgery*).
7. **Prinsip Urgensi CITO:** Penetapan urgensi CITO menandai prioritas penanganan tinggi pada alur penjadwalan berikutnya, namun tidak membatalkan atau mengabaikan kewajiban identifikasi pasien yang benar dan prinsip dasar keselamatan pasien.
8. **Integritas Rekam Medis dan Keterlacakan:** Setiap Order Operasi yang terbit harus dapat diaudit (*traceable*), mencatat identitas DPJP yang mengesahkan serta stempel waktu penerbitan, dan tidak boleh dimanipulasi tanpa jejak riwayat audit.
9. **Kemandirian Terhadap Implementasi Teknis:** Outcome ini berlaku secara independen dari bentuk tampilan antarmuka (UI), struktur tabel database, atau protokol API teknis yang digunakan untuk mengimplementasikannya.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak teridentifikasi atau Nomor Rekam Medis tidak valid | Pembuatan Order Operasi ditolak. Identitas pasien harus diverifikasi dan diselesaikan melalui Pasien Domain (`PAS-DATSOS`) sebelum order dapat dibuat. |
| Dokter pembuat order tidak memiliki kewenangan klinis pembedahan yang valid | Submit Order Operasi ditolak. Sistem menginformasikan bahwa dokter yang dipilih tidak memiliki kewenangan untuk menerbitkan order tindakan bedah. |
| Registrasi kunjungan pasien sudah ditutup atau tidak aktif | Pembuatan Order Operasi ditolak. Order hanya dapat dikaitkan dengan episode kunjungan yang berstatus aktif. |
| Lateralisasi tidak diisi pada tindakan pembedahan organ berpasangan | Submit Order Operasi ditahan dalam status Draft. Sistem mewajibkan DPJP untuk menentukan sisi lateralisasi (Kanan / Kiri / Bilateral) sebelum order dapat disubmit. |
| Target tanggal operasi berada di masa lampau (*past date*) | Submit Order Operasi ditolak. Sistem meminta DPJP untuk memasukkan target tanggal yang valid (hari ini untuk CITO/segera, atau tanggal mendatang untuk elektif). |
| Data klinis mandatori (indikasi diagnosis atau rencana tindakan) belum diisi | Submit Order Operasi ditahan dalam status Draft. Sistem meminta DPJP melengkapi seluruh data klinis wajib sebelum melakukan submit. |
| Terdapat Order Operasi aktif untuk prosedur dan pasien yang sama yang belum selesai diproses | Sistem memberikan peringatan konfirmasi bisnis kepada DPJP untuk mencegah duplikasi order pembedahan yang tidak disengaja. |
| Pembatalan diajukan terhadap Order Operasi yang sudah selesai atau sedang dalam pelaksanaan operasi | Pembatalan ditolak. Order yang tindakannya sedang atau telah dilaksanakan tidak dapat dibatalkan melalui mekanisme pembatalan order. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Order Operasi yang disubmit memiliki nomor referensi unik dan tercatat dengan status **Submitted**. | Completeness |
| AC-02 | Order Operasi terbit merujuk secara valid pada Nomor Rekam Medis pasien, nomor registrasi kunjungan aktif, dan Dokter DPJP yang berwenang. | Correctness |
| AC-03 | Diagnosis pra-bedah/indikasi klinis, rencana tindakan pembedahan, target tanggal, dan perkiraan durasi tercatat secara lengkap pada Order Operasi terbit. | Completeness |
| AC-04 | Untuk prosedur pada organ atau struktur tubuh berpasangan, pilihan lateralisasi (Kanan, Kiri, atau Bilateral) terverifikasi terisi sebelum status menjadi Submitted. | Constraint |
| AC-05 | Tingkat urgensi tercatat secara eksplisit sebagai Elektif atau CITO, dan order CITO dapat diidentifikasi secara khusus untuk penanganan prioritas tinggi pada alur kerja berikutnya. | Correctness |
| AC-06 | Kebutuhan sumber daya khusus (implan, instrumen khusus, C-Arm, darah, dan ICU) tercatat sebagai daftar kebutuhan klinis tanpa mengubah status ketersediaan atau alokasi fisik barang/fasilitas. | Constraint |
| AC-07 | Usulan rencana anestesi tercatat sebagai rekomendasi opsional dari DPJP bedah dan tidak menetapkan keputusan final anestesi. | Constraint |
| AC-08 | Order Operasi yang masih berstatus **Draft** tidak dapat dikonsumsi atau dijadwalkan oleh proses penjadwalan kamar operasi (**OC-10-02**). | Constraint |
| AC-09 | Order Operasi yang berstatus **Submitted** dapat ditemukan dan dikonsumsi oleh proses penjadwalan kamar operasi (**OC-10-02**) serta persiapan pra-bedah (**OC-10-03**). | Correctness |
| AC-10 | Upaya submit Order Operasi tanpa kelengkapan diagnosis, rencana tindakan, lateralisasi mandatori, atau tanpa kewenangan DPJP yang sah ditolak oleh sistem. | Exception |
| AC-11 | Pembatalan Order Operasi mencatat waktu pembatalan, DPJP yang membatalkan, dan alasan pembatalan klinis/operasional, serta mengubah status order menjadi **Dibatalkan**. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Penjadwalan Definitif Kamar Operasi:** Penentuan alokasi fisik nomor kamar bedah, tanggal dan jam pasti pelaksanaan operasi, serta durasi slot jadwal kamar operasi → **OC-10-02 Scheduling**.
- **Penugasan Tim Kamar Operasi:** Penetapan perawat instrumen, perawat asisten, perawat sirkuler, serta dokter spesialis anestesiologi yang bertugas → **OC-10-02 Scheduling**.
- **Konfirmasi Ketersediaan dan Alokasi Peralatan Fisik:** Pengecekan ketersediaan fisik dan reservasi alat bedah khusus, laparoskopi, atau C-Arm → **OC-10-02 Scheduling** dan **Inventory Domain (`INV-PAKAI`)**.
- **Penyediaan dan Pemesanan Implan:** Verifikasi stok, sterilisasi, atau pemesanan implan/prostesis ke pihak ketiga → **Inventory Domain (`INV-STOK`)** dan **Purchasing Domain**.
- **Penyediaan dan Uji Silang Darah:** Pengelolaan stok darah, pemeriksaan serologi, dan uji silang serasi (*crossmatch*) di Bank Darah/UTD → **Pelayanan Darah / Laboratorium (`LAB-RESULT`)**.
- **Konfirmasi dan Reservasi Tempat Tidur ICU/HCU:** Alokasi dan reservasi fisik bed intensif pasca-operasi → **Rawat Inap Domain (`RNA-BED`)**.
- **Izin Kelaikan Medis Pra-Bedah (Clearance):** Evaluasi klinis menyeluruh, asesmen pra-anestesi, penentuan status fisik ASA, dan penerbitan izin medis kelaikan operasi → **OC-10-03 Pre-Operative Clearance**.
- **Informed Consent Tindakan Medis:** Pelaksanaan edukasi dan penandatanganan surat persetujuan/penolakan tindakan medis pembedahan dan anestesi → **EMR / Pelayanan Medis**.
- **Eksekusi Surgical Safety Checklist:** Pelaksanaan tahapan *Sign In*, *Time Out*, dan *Sign Out* di kamar operasi → **OC-10-03** dan **OC-10-04 Post-Operative Management**.
- **Pencatatan Laporan Operasi:** Dokumentasi jalannya tindakan pembedahan, temuan intra-operatif, jaringan/spesimen patologi, dan instruksi pasca-bedah → **OC-10-04 Post-Operative Management** / **EMR**.
- **Pemulihan Pasca-Bedah di PACU:** Pemantauan kondisi pasien dan kriteria pemulangan dari ruang pemulihan (*Aldrete score*, dsb.) → **OC-10-04 Post-Operative Management**.
- **Tarif dan Penagihan:** Perhitungan biaya tindakan, penetapan tarif, pembebanan billing pasien, dan klaim asuransi/BPJS → **Tata Rekening Domain (`TRK-BILLING`, `TRK-TARIF`)** dan **BPJS Domain (`BPJ-EKLAIM`)**.
- **Implementasi Teknis:** Desain skema tabel database, model data relasional, kontrak antarmuka API, tata letak formulir UI/layar, dan alur navigasi web/aplikasi.
