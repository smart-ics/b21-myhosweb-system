# OUTCOME: Computerized Provider Order Entry (CPOE)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-04     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Setiap kebutuhan klinis pasien yang memerlukan pelayanan, pemeriksaan diagnostik, intervensi medis, terapi obat/nutrisi, maupun konsultasi antar-disiplin memerlukan penerjemahan dari intensi klinis (*clinical intent*) menjadi instruksi resmi yang terotorisasi (*authorized prospective clinical instruction*).

Kapabilitas **Computerized Provider Order Entry (CPOE)** menyediakan mekanisme terstandardisasi bagi rumah sakit untuk mengelola siklus hidup instruksi klinis secara terstruktur—mencakup penyusunan, otorisasi, perutean ke unit pelaksana (*Destination*), koordinasi penerimaan dan klarifikasi, pelacakan proses pemenuhan (*fulfilment*), hingga penutupan resmi (*closure*) setelah tanggung jawab koordinasi klinis selesai.

Penggunaan istilah **Computerized Provider Order Entry** menegaskan bahwa penyusun (*Order Author*) maupun pemberi otorisasi (*Order Authorizer*) mencakup dokter serta Petugas Pemberi Asuhan (PPA) lain (seperti perawat, bidan, dietisien, atau apoteker klinis) sesuai lingkup kewenangan profesi dan penugasan klinis (*clinical privileges*) yang sah di rumah sakit.

CPOE bukan sekadar fungsionalitas entri data ke komputer, melainkan fondasi tata kelola klinis yang menjaga kejelasan *clinical intent*, akuntabilitas otorisasi, koordinasi pemenuhan, dan ketertelusuran instruksi sepanjang episode perawatan pasien.

> **Prinsip Fundamental Domain:**  
> **Clinical Order merepresentasikan *clinical intent* yang akan dilaksanakan, bukan bukti bahwa pelayanan atau tindakan tersebut telah dilakukan.**  
> Clinical Order tidak secara otomatis menghasilkan biaya (*Order ≠ Charge*). Kelayakan pembebanan biaya hanya muncul dari fakta pemenuhan aktual (*actual fulfilment*) yang sah.

---

## 2. Outcome Statement

Clinical Order yang merepresentasikan *clinical intent* atas kebutuhan pelayanan pasien **telah disahkan oleh Ordering PPA yang berwenang, diarahkan ke Destination yang bertanggung jawab, dapat ditelusuri proses pemenuhannya, dan ditutup secara akuntabel setelah seluruh tanggung jawab koordinasi klinis selesai**.

---

## 3. Participating Domains

Sebagai kapabilitas lintas domain (*cross-domain capability*), CPOE berinteraksi dengan:

| Kelompok Domain | Domain Terkait | Peran dalam Outcome |
|-----------------|----------------|---------------------|
| **Ordering Context** | Rawat Jalan, Rawat Inap, Gawat Darurat | Wadah pelayanan asal tempat kebutuhan klinis dirumuskan, instruksi diotorisasi, dan hasil pemenuhan dievaluasi (`RJL-KONSUL`, `RJL-TRANSFER`, `RNA-TRANSFER`, `IGD-VISIT`). |
| **Executing Domains** | Laboratory, Radiology, Kamar Operasi, Apotek, Unit Penunjang | Unit kerja tujuan (*Destination*) yang menerima instruksi, melakukan telaah dan klarifikasi, melaksanakan aktivitas klinis, menerbitkan hasil resmi, dan melaporkan ringkasan pemenuhan (`LAB-ORDER`, `RAD-ORDER`, `KMO-ORDER`, `APT-RESEP`). |
| **Financial Consumer** | Tata Rekening | Mengonsumsi fakta pemenuhan aktual yang layak dibebankan (*Charge Eligibility*) untuk pembentukan tagihan pasien (`TRK-BILLING`, `TRK-TARIF`). |
| **Care Context & Identity** | Admission, Pasien, Organisasi | Menyediakan keabsahan kunjungan aktif (`ADM-REG`), pelacakan alur pasien (`ADM-TRACKER`), data identitas pasien (`PAS-DATSOS`), unit layanan (`ORG-LAYANAN`), serta data kewenangan PPA (`ORG-PPA`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `CPOE-ORDER` Pengelolaan Clinical Order Terintegrasi | Cross-Domain | Capability Candidate |
| `RJL-KONSUL` Konsultasi | Rawat Jalan | Known |
| `RJL-TRANSFER` Rujukan Internal | Rawat Jalan | Known |
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `RAD-ORDER` Order Radiologi | Radiology | Known |
| `KMO-ORDER` Order Operasi | Kamar Operasi | Known |
| `APT-RESEP` Resep | Apotek | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

### 5.1 Required Business Facts

#### A. Clinical Order sebagai Core Domain Object
- Clinical Order merupakan representasi instruksi klinis prospektif tunggal yang membawa atribut esensial: identitas pasien, konteks kunjungan aktif (*Care Context*), kategori instruksi (*Order Type*), indikasi klinis (*Clinical Indication*), skala prioritas (Rutin, Urgent, Cito/Stat), jadwal permintaan pelaksanaan (*Requested Timing*), rincian instruksi klinis (*Order Instruction*), identitas penyusun (*Order Author*), pengesah (*Order Authorizer*), unit kerja pelaksana (*Destination*), serta penanggung jawab klinis aktif (*Current Responsibility*).
- Pengelompokan beberapa order dalam paket klinis (*Order Set*) berfungsi memudahkan penulisan instruksi; setiap item order di dalamnya tetap berdiri sendiri dengan siklus hidup, otorisasi, dan disposisi masing-masing.

#### B. Pemisahan Rantai Nilai Layanan
Arsitektur CPOE memisahkan empat domain fakta bisnis:
$$\text{Clinical Order} \longrightarrow \text{Fulfilment} \longrightarrow \text{Fulfilment Outcome} \longrightarrow \text{Result / Execution Documentation}$$
- **Clinical Order:** Menyatakan apa yang diminta secara klinis prospektif (*intent*).
- **Fulfilment:** Menunjukkan proses persiapan dan pengerjaan aktivitas klinis aktual.
- **Result / Execution Documentation:** Menyimpan temuan diagnostik atau laporan prosedur resmi di bawah yurisdiksi domain pelaksana/EMR.
- **Billing / Charge Eligibility:** Konsekuensi finansial yang bersumber dari fakta pemenuhan aktual yang diserahkan ke Tata Rekening.

#### C. Aktor dan Akuntabilitas
Tanggung jawab klinis dikelola melalui peran-peran utama berikut:
- **Order Author:** Tenaga kesehatan yang menyusun draf instruksi klinis.
- **Order Authorizer:** Tenaga kesehatan yang memiliki wewenang klinis formal (*clinical privileges*) untuk mengesahkan instruksi.
- **Responsible Clinician:** Dokter penanggung jawab pelayanan (DPJP) atau klinisi yang bertanggung jawab atas kesinambungan asuhan pasien dan tindak lanjut terhadap *Outstanding Orders*.
- **Receiver:** Pihak pada Destination yang bertugas menerima, menelaah kelayakan, dan merespons instruksi.
- **Performer / Executing Domain:** Pihak yang melaksanakan aktivitas klinis dan menerbitkan bukti pemenuhan resmi.
- **Tata Rekening:** Pihak yang mengelola konsekuensi finansial berdasarkan fakta pemenuhan.

> **Pemisahan Authorship vs. Authorization:**  
> Identitas penyusun instruksi (*Author*) dan pengambil tanggung jawab medikolegal formal (*Authorizer*) dicatat secara terpisah, meskipun dilakukan oleh individu yang sama.

#### D. Siklus Hidup Instruksi (Order Lifecycle)
Siklus hidup instruksi klinis bergerak melalui tahapan:
$$\text{Draft} \longrightarrow \text{Authorized} \longrightarrow \text{Dispatched} \longrightarrow \text{Accepted} \longrightarrow \text{In Fulfilment} \longrightarrow \text{Fulfilled} \longrightarrow \text{Closed}$$

- **Draft:** Instruksi sedang disiapkan dan belum dapat ditindaklanjuti.
- **Authorized:** Tanggung jawab klinis formal telah diambil oleh Authorizer.
- **Dispatched:** Instruksi telah diserahkan kepada antrean kerja Destination.
- **Accepted:** Destination menyatakan komitmen untuk mengoordinasikan pemenuhan.
- **In Fulfilment:** Persiapan teknis atau pelaksanaan aktivitas klinis telah dimulai di Destination.
- **Fulfilled:** Seluruh kriteria penyelesaian (*Completion Criterion*) untuk kategori order tersebut terpenuhi.
- **Closed:** Tanggung jawab koordinasi klinis CPOE selesai. Penutupan klinis ini berdiri sendiri dan tidak bergantung pada status penyelesaian penagihan finansial (*Billing*).

**Terminal / Exceptional States:**
- **Rejected:** Instruksi ditolak oleh Destination disertai alasan penolakan yang sah.
- **Cancelled:** Instruksi dibatalkan oleh pihak pemesan sebelum pelaksanaan fisik dimulai.
- **Discontinued:** Instruksi berkala/serial dihentikan untuk jadwal pelaksanaan masa depan; pelaksanaan yang telah lalu tetap sah.
- **Not Fulfilled:** Instruksi tidak dapat diselesaikan karena kendala operasional atau kondisi klinis pasien.
- **Entered in Error:** Instruksi dianulir karena kekeliruan mendasar sejak pembuatan tanpa menghapus riwayat data asli.

> **Pembedaan Status:**  
> Status penerimaan atau persiapan (`Accepted`, `Scheduled`, `In Fulfilment`) tidak sama dengan status `Fulfilled`. Status `Fulfilled` mensyaratkan tercapainya *Completion Criterion* objektif.

#### E. Keputusan Penerima dan Tata Kelola Klarifikasi
Destination memiliki kewenangan untuk:
1. **Accept:** Menerima instruksi untuk diproses ke tahap pemenuhan.
2. **Reject:** Menolak instruksi yang tidak memenuhi syarat teknis atau memiliki kontraindikasi mutlak, disertai alasan penolakan.
3. **Request Clarification:** Meminta penjelasan atas ambiguitas, inkonsistensi, atau isu keselamatan pasien.
   - Instruksi yang memerlukan klarifikasi berada dalam kondisi **On Hold for Clarification** hingga klarifikasi diselesaikan.
   - Penangguhan instruksi yang membutuhkan klarifikasi **tidak boleh menahan instruksi lain** milik pasien yang tidak berkaitan secara klinis (*impact isolation*).

#### F. Pengendalian Perubahan (Change Control)
- Perubahan pada draf pra-otorisasi dilakukan langsung tanpa pencatatan amandemen.
- Perubahan setelah otorisasi dicatat sebagai **Amendment** dengan mempertahankan instruksi sebelumnya, alasan perubahan, otorisasi perubahan, dan evaluasi dampak terhadap pemenuhan.
- **Cancellation** hanya berlaku sebelum pelaksanaan fisik dimulai. Jika pelaksanaan telah berjalan, penghentian dilakukan melalui **Discontinuation**.
- Riwayat keputusan dan instruksi klinis yang telah disahkan bersifat permanen dan tidak boleh dihapus.

#### G. Tata Kelola Exceptional Order
Pada situasi klinis luar biasa di mana otorisasi elektronik prospektif tidak memungkinkan:
- **Verbal Order, Emergency Action, Protocol-Based Action, dan Retrospective Order** dapat digunakan sesuai kewenangan klinis.
- Kronologi peristiwa tidak boleh dipalsukan (*no backdating*). Waktu instruksi, waktu pelaksanaan, waktu pencatatan, dan waktu otorisasi susulan (*Subsequent Authorization*) tetap dapat dibedakan.
- Otorisasi susulan wajib diselesaikan oleh klinisi penanggung jawab dalam batas periode yang diatur oleh kebijakan rumah sakit (*governed policy period*).

#### H. Transisi Asuhan dan Rekonsiliasi Pemulangan
- Tanggung jawab memantau instruksi yang masih aktif (*Outstanding Orders*) dapat dialihkan saat perpindahan ruangan, alih rawat, atau pergantian DPJP (*Transfer of Responsibility*), tanpa mengubah data kepengarangan awal (*Author* dan *Authorizer*).
- Pemulangan pasien (*Discharge*) tidak membatalkan Outstanding Orders secara otomatis. Seluruh order aktif wajib melalui **Discharge Reconciliation** untuk menetapkan disposisi: dialihkan ke rawat jalan (*carried forward/converted*), ditutup (*discontinued*), atau diberikan penugasan tanggung jawab pemantauan hasil (*continuing responsibility*).

#### I. Model Pemenuhan dan Kriteria Penyelesaian
- Setiap kategori order memiliki kriteria penyelesaian objektif (*Completion Criterion*) yang menentukan kapan order dinyatakan sah *Fulfilled* (misal: validasi hasil lab, verifikasi ekspertise radiologi, pengesahan laporan operasi, serah terima obat, atau jawaban konsultasi).
- Domain pelaksana khusus (Lab, Rad, Kamar Operasi, Apotek) berdaulat atas detail pelaksanaan teknisnya. CPOE hanya menyimpan ringkasan pemenuhan (*Fulfilment Summary*).
- Apabila domain pelaksana khusus belum tersedia, CPOE menyediakan **Generic Fulfilment** secara transisional untuk mencatat fakta dasar pelaksanaan tanpa mengaburkan perbedaan antara order dan bukti pemenuhan.

---

### 5.2 Required Recorded Information

- **Konteks Kunjungan & Pasien:** Identitas pasien (No. RM dan identitas sosial) serta konteks kunjungan aktif (*Care Context*).
- **Atribut Instruksi Klinis:** Kategori order (*Order Type*), indikasi klinis, skala prioritas, waktu permintaan pelaksanaan, rincian instruksi teknis, dan relasi paket order (*Order Set*, bila ada).
- **Akuntabilitas Kepengarangan & Otorisasi:** Identitas penyusun (*Order Author*), pengesah (*Order Authorizer*), waktu otorisasi, serta penanggung jawab klinis aktif (*Current Responsibility*).
- **Perutean & Respons Destination:** Unit kerja tujuan (*Destination*), identitas penerima (*Receiver*), status keputusan (Accept, Reject, Request Clarification), dan catatan justifikasi penolakan/klarifikasi.
- **Siklus Hidup & Jejak Perubahan:** Status siklus hidup terkini, riwayat amandemen (instruksi sebelum vs sesudah, alasan, dan pengotorisasi), alasan pembatalan/penghentian, atau catatan *Entered in Error*.
- **Informasi Exceptional Order (bila berlaku):** Kategori order luar biasa, pencatatan kronologi waktu (waktu instruksi, pelaksanaan, pencatatan, dan otorisasi susulan), serta identitas pengotorisasi susulan.
- **Ringkasan Pemenuhan & Tautan Bukti:** Ringkasan pemenuhan (*Fulfilment Summary*), waktu penyelesaian, tautan ke hasil klinis resmi atau dokumen rekam medis pelaksanaan, dan penyerahan fakta kelayakan biaya (*Charge Eligibility*) ke Tata Rekening.
- **Disposisi Rekonsiliasi:** Catatan rekonsiliasi pemulangan (*Discharge Reconciliation*) dan alih tanggung jawab klinis (*Transfer of Responsibility*).

---

### 5.3 Required Business Conditions

- Registrasi kunjungan pasien berstatus aktif dalam pengelolaan Admission (`ADM-REG`).
- Authorizer memiliki kewenangan klinis (*clinical privileges*) yang sah untuk kategori order yang diotorisasi (`ORG-PPA`).
- Destination merupakan unit kerja aktif yang berwenang melayani kategori order terkait (`ORG-LAYANAN`).
- Setiap instruksi klinis mencantumkan indikasi medis yang jelas.
- Otorisasi susulan pada Exceptional Order diselesaikan dalam batas periode kebijakan rumah sakit.

---

### 5.4 Completion Proof

Clinical Order dinyatakan selesai dan mencapai status **Closed** apabila:
1. Seluruh kriteria penyelesaian (*Completion Criterion*) untuk kategori order tersebut terpenuhi secara sah dan terekam dalam ringkasan pemenuhan, ATAU order mencapai disposisi terminasi yang sah (Rejected, Cancelled, Discontinued, Not Fulfilled, atau Entered in Error).
2. Tautan ke hasil klinis resmi (*Result Reference*) atau dokumentasi pelaksanaan resmi (*Execution Documentation Reference*) telah terbentuk (pada order yang berhasil dipenuhi).
3. Seluruh tanggung jawab koordinasi klinis CPOE atas order ini telah tuntas, tanpa bergantung pada penyelesaian siklus penagihan di Tata Rekening.
4. Fakta pemenuhan aktual yang layak dibebankan (*Charge Eligibility*) telah diserahkan ke Tata Rekening (apabila terdapat porsi layanan yang terlaksana).

---

## 6. Outcome Boundary

### Start
Dimulai ketika Petugas Pemberi Asuhan (PPA) mengidentifikasi kebutuhan klinis pasien dan mulai menyusun instruksi prospektif (*clinical intent*), atau ketika instruksi darurat/verbal pertama kali diberikan pada situasi kegawatdaruratan.

### End
Berakhir ketika Clinical Order mencapai status akhir:
- Berstatus **Closed** setelah pemenuhan terkonfirmasi, kriteria penyelesaian terpenuhi, tautan hasil terbentuk, dan tanggung jawab koordinasi klinis tuntas; ATAU
- Berstatus akhir melalui terminasi resmi (**Rejected**, **Cancelled**, **Discontinued**, **Not Fulfilled**, atau **Entered in Error**) dengan seluruh alasan pertanggungjawaban tercatat permanen.

---

### Ruang Lingkup Formal

#### In Scope
1. Pengelolaan struktur dan siklus hidup Clinical Order prospektif.
2. Tata kelola kepengarangan (*Authoring*) dan otorisasi (*Authorization*) berbasis kewenangan klinis PPA.
3. Penetapan kategori order, indikasi klinis, skala prioritas, jadwal pelaksanaan, dan instruksi teknis.
4. Perutean instruksi ke Destination pelaksana.
5. Manajemen penerimaan oleh Destination (Accept, Reject, Request Clarification) dan penangguhan (*On Hold*).
6. Koordinasi pemenuhan (*Fulfilment*) dan pencatatan ringkasan pemenuhan (*Fulfilment Summary*).
7. Pengendalian perubahan (Amendment, Cancellation, Discontinuation, Entered in Error).
8. Tata kelola tanggung jawab klinis (*Responsibility*) dan pengalihan tanggung jawab saat transisi asuhan.
9. Tautan referensi ke hasil klinis resmi dan dokumentasi pelaksanaan di domain eksekusi/EMR.
10. Tata kelola Exceptional Order (Verbal, Darurat, Protokol, Retrospektif) dengan pemisahan kronologi waktu.
11. Rekonsiliasi pemulangan (*Discharge Reconciliation*) terhadap Outstanding Orders.
12. Penyerahan kelayakan pembebanan biaya (*Charge Eligibility*) dari pemenuhan aktual ke domain finansial.
13. Penyediaan *Generic Fulfilment* transisional apabila domain eksekusi khusus belum tersedia.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Clinical Order Bukan Bukti Pelaksanaan:** Clinical Order adalah instruksi prospektif, bukan bukti bahwa pelayanan klinis telah selesai dilakukan.
2. **Order Bukan Biaya (*Order ≠ Charge*):** Penyusunan, otorisasi, pengiriman, penerimaan, maupun persiapan order tidak menghasilkan beban biaya. Biaya hanya dapat muncul dari fakta pemenuhan aktual.
3. **Pemisahan Penulis dan Pengesah:** Identitas pembuat draf (*Author*) dan pengesah (*Authorizer*) dicatat terpisah untuk menjamin akuntabilitas medikolegal.
4. **Kedaulatan Domain Pelaksana:** Domain pelaksana khusus berdaulat atas alur kerja teknis internalnya. CPOE hanya mengoordinasikan instruksi dan ringkasan pemenuhan.
5. **Transisional Generic Fulfilment:** Pemanfaatan Generic Fulfilment bersifat transisional dan tidak boleh mengaburkan batas antara instruksi dan bukti pelaksanaan.
6. **Isolasi Dampak Klarifikasi:** Penangguhan order akibat permintaan klarifikasi tidak boleh menahan order lain milik pasien yang tidak berkaitan secara klinis.
7. **Pembedaan Status Fulfilled:** Status persiapan atau penerimaan tidak boleh disamakan dengan status Fulfilled.
8. **Imutabilitas Riwayat Keputusan:** Riwayat instruksi yang telah disahkan, keputusan penerima, dan amandemen tidak boleh dihapus.
9. **Integritas Kronologi Exceptional Order:** Kronologi order luar biasa tidak boleh dipalsukan (*no backdating*). Otorisasi susulan diselesaikan dalam batas periode kebijakan rumah sakit.
10. **Larangan Pembatalan Otomatis Saat Discharge:** Pemulangan pasien tidak membatalkan Outstanding Orders secara otomatis; rekonsiliasi pemulangan (*Discharge Reconciliation*) wajib dilakukan.
11. **Kemandirian Siklus Koordinasi dari Billing:** Penutupan koordinasi klinis (*Closed*) pada CPOE tidak bergantung pada penyelesaian siklus penagihan di Tata Rekening.

---

## 8. Business Exceptions

> Conditions under which the Outcome encounters an operational exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Registrasi kunjungan pasien tidak aktif atau telah ditutup | Penyusunan dan otorisasi Clinical Order ditolak. |
| Pengesah tidak memiliki kewenangan klinis untuk kategori order terkait | Otorisasi ditolak; instruksi dialihkan kepada klinisi yang berwenang. |
| Order ditolak oleh Receiver di unit kerja tujuan | Status order menjadi `Rejected` disertai alasan penolakan; pemenuhan dihentikan tanpa menghasilkan beban biaya. |
| Receiver meminta klarifikasi atas keselamatan atau kelengkapan klinis | Status order menjadi `On Hold for Clarification`; pemenuhan ditunda hingga klarifikasi selesai tanpa menahan order lain yang tidak berkaitan. |
| Pemesan membatalkan order sebelum pelaksanaan fisik dimulai | Status order menjadi `Cancelled`; koordinasi di unit tujuan dihentikan tanpa beban biaya. |
| Pembatalan diajukan saat pelaksanaan fisik telah berjalan | Pembatalan otomatis tidak diizinkan; dialihkan ke mekanisme komunikasi penghentian (*Discontinuation*) atau penyelesaian sebagian. |
| Terapi serial dihentikan karena perubahan kondisi klinis | Status order menjadi `Discontinued`; pelaksanaan yang telah lalu tetap sah, porsi masa depan dibatalkan. |
| Teridentifikasi kesalahan mendasar pasca-otorisasi (salah pasien/salah perutean) | Status order menjadi `Entered in Error` dengan alasan lengkap; order dinonaktifkan tanpa menghapus riwayat data asli. |
| Otorisasi susulan pada Exceptional Order belum diselesaikan dalam periode kebijakan | Order ditandai membutuhkan perhatian kepatuhan klinis dan dilaporkan untuk tindak lanjut medikolegal. |
| Pasien berpindah ruangan atau berganti DPJP saat memiliki Outstanding Orders | Tanggung jawab klinis (*Responsibility*) dialihkan kepada penanggung jawab baru tanpa mengubah data kepengarangan awal. |
| Pasien dipulangkan saat masih memiliki order diagnostik aktif yang hasilnya belum terbit | Dilakukan Discharge Reconciliation; order ditandai untuk pemantauan hasil pasca-pulang oleh penanggung jawab rawat jalan. |
| Pelaksanaan fisik gagal akibat kendala klinis atau penolakan pasien | Status order menjadi `Not Fulfilled` disertai catatan kendala; kelayakan biaya hanya berlaku atas porsi persiapan yang sah menurut kebijakan rumah sakit. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Sistem mencatat Clinical Order terstruktur yang memuat identitas pasien, konteks kunjungan aktif, kategori order, indikasi klinis, prioritas, waktu permintaan, instruksi teknis, Author, Authorizer, Destination, dan penanggung jawab aktif. | Completeness |
| AC-02 | Pembuatan draf, otorisasi, perutean, penerimaan, maupun persiapan order tidak membentuk kelayakan pembebanan biaya (*Charge Eligibility*) pada domain Tata Rekening. | Constraint |
| AC-03 | Sistem membedakan secara tegas identitas pembuat draf (*Order Author*) dan pengesah (*Order Authorizer*) sebagai dua peran mandiri dalam pencatatan instruksi. | Correctness |
| AC-04 | Siklus hidup Clinical Order bergerak melalui tahapan yang sah (`Draft` → `Authorized` → `Dispatched` → `Accepted` → `In Fulfilment` → `Fulfilled` → `Closed`), dan tidak menyamakan status persiapan dengan `Fulfilled`. | Correctness |
| AC-05 | Destination dapat menerima (*Accept*), menolak (*Reject* dengan alasan), atau meminta klarifikasi (*Request Clarification*), di mana penangguhan klarifikasi hanya berdampak pada order terkait tanpa menahan order lain. | Completeness |
| AC-06 | Setiap perubahan terhadap instruksi yang telah diotorisasi tercatat sebagai *Amendment* dengan mempertahankan riwayat instruksi awal, alasan perubahan, dan otorisasi perubahan. | Constraint |
| AC-07 | Perekaman Exceptional Order (Verbal, Darurat, Protokol, Retrospektif) mempertahankan kronologi waktu nyata tanpa *backdating*, serta mencatat otorisasi susulan dalam batas periode kebijakan rumah sakit. | Constraint |
| AC-08 | Transisi perawatan (pindah ruangan, pergantian DPJP) mengalihkan tanggung jawab klinis atas Outstanding Orders kepada klinisi penanggung jawab baru tanpa mengubah data kepengarangan awal. | Correctness |
| AC-09 | Pemulangan pasien tidak membatalkan Outstanding Orders secara otomatis dan mewajibkan penetapan disposisi melalui rekonsiliasi pemulangan (*Discharge Reconciliation*). | Constraint |
| AC-10 | Status `Closed` dapat dicapai setelah seluruh tanggung jawab koordinasi klinis CPOE selesai, tanpa bergantung pada penyelesaian siklus penagihan di Tata Rekening. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pelayanan Keperawatan Rutin (*Routine Nursing Care*):** Tindakan keperawatan mandiri reguler (seperti memandikan pasien atau pemantauan tanda vital rutin berkala) → Lingkup operasional keperawatan bangsal (`RNA-*`).
- **Alur Kerja Teknis Internal Departemen Pelaksana:** Kalibrasi alat laboratorium, manajemen reagen, pengaturan radiasi mesin pencitraan, sterilisasi instrumen operasi, dan teknik peracikan obat → Domain pelaksana terkait (`LAB-*`, `RAD-*`, `KMO-*`, `APT-*`).
- **Penyimpanan Dokumentasi Hasil Medis Authoritative:** Penyimpanan narasi ekspertise diagnostik lengkap, arsip citra radiologi, grafik lab, dan resume medis CPPT → Domain Penunjang Terkait dan Rekam Medis Elektronik (EMR).
- **Laporan Dokumentasi Pembedahan Resmi:** Penyusunan lembar laporan operasi lengkap, laporan anestesi, dan *surgical safety checklist* → Domain Kamar Operasi (`KMO-OPR`) dan EMR.
- **Konfigurasi Master Tarif dan Kebijakan Finansial:** Penentuan besaran tarif, aturan kelas perawatan, dan penjaminan asuransi → Domain Tata Rekening (`TRK-TARIF`, `TRK-JAMINAN`).
- **Kalkulasi Tagihan dan Pembayaran Kasir:** Pembentukan rincian invoice tagihan, penerimaan pembayaran, dan alokasi kasir → Domain Tata Rekening (`TRK-BILLING`, `TRK-PAYMENT`, `TRK-KASIR`).
- **Manajemen Persediaan dan Stok Fisik:** Pengurangan stok fisik obat/BMHP di depo/gudang, *batch number*, dan kadaluwarsa → Domain Inventory (`INV-*`) dan Apotek (`APT-*`).
- **Tindak Lanjut Klinis Terhadap Hasil Diagnostik:** Pengambilan keputusan medis lanjutan dan formulasi terapi baru pasca-terbitnya hasil diagnostik pada Phase 1 → Domain Klinis / EMR.
