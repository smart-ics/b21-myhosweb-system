# OUTCOME: Computerized Provider Order Entry (CPOE)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-04     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Setiap kebutuhan klinis pasien yang memerlukan pelayanan, intervensi medis, pemeriksaan diagnostik penunjang, terapi obat/nutrisi, konsultasi spesialistik, maupun observasi berkelanjutan membutuhkan penerjemahan terstruktur dari intensi klinis (*clinical intent*) menjadi instruksi resmi yang terotorisasi (*authorized prospective clinical instruction*). 

Kapabilitas **Computerized Provider Order Entry (CPOE)** menyediakan mekanisme terstandardisasi bagi rumah sakit untuk mengelola seluruh siklus hidup instruksi klinis tersebut—mulai dari penyusunan, pengesahan otorisasi, perutean (*routing*) ke unit pelaksana (*Destination*), koordinasi penerimaan dan klarifikasi, pelacakan proses pemenuhan (*fulfilment*), hingga penutupan resmi (*closure*) berdasarkan bukti hasil pelaksanaan yang dapat dipertanggungjawabkan.

Penggunaan istilah **Computerized Provider Order Entry** (bukan sekadar *Physician Order Entry*) menegaskan bahwa penyusun (*Order Author*) maupun pemberi otorisasi (*Order Authorizer*) instruksi klinis mencakup dokter serta Petugas Pemberi Asuhan (PPA) lain (seperti perawat, bidan, dietisien, atau apoteker klinis) sesuai lingkup kewenangan profesi, kompetensi, dan surat penugasan klinis (*clinical privileges*) yang sah di rumah sakit.

Pencatatan CPOE bukan sekadar fungsionalitas entri data ke dalam sistem komputer (*not just an entry feature*), melainkan fondasi tata kelola klinis yang menjamin lima pilar utama:
1. **Clinical Intent:** Kejelasan tujuan medis dan instruksi pelaksanaan yang aman bagi keselamatan pasien (*patient safety*).
2. **Accountability:** Ketertelusuran pihak yang menyusun (*Author*) dan pihak yang mengambil tanggung jawab medis formal (*Authorizer*).
3. **Fulfilment Coordination:** Pengarahan instruksi ke unit kerja yang tepat, dengan hak verifikasi, klarifikasi, atau penolakan oleh pihak penerima (*Receiver*).
4. **Traceability:** Pelacakan status pemenuhan secara transparan antar-unit sepanjang episode perawatan aktif.
5. **Separation of Concerns:** Pemisahan tegas antara instruksi prospektif (*Clinical Order*), pelaksanaan fisik (*Fulfilment*), bukti klinis resmi (*Result/Execution Documentation*), dan kelayakan pembebanan biaya (*Charge Eligibility*).

> **Prinsip Fundamental Domain:**  
> **Clinical Order merepresentasikan *clinical intent* yang akan dilaksanakan, bukan bukti bahwa pelayanan atau tindakan tersebut telah dilakukan.**  
> Clinical Order tidak secara otomatis menghasilkan biaya (*Order ≠ Charge*). Kelayakan pembebanan biaya hanya dapat muncul berdasarkan fakta pemenuhan aktual (*actual fulfilment*) yang sah sesuai kebijakan domain tata rekening.

---

## 2. Outcome Statement

Instruksi klinis prospektif (*Clinical Order*) yang merepresentasikan *clinical intent* atas kebutuhan pelayanan pasien **telah disahkan secara akuntabel oleh Ordering PPA yang berwenang, diarahkan secara terstruktur ke Destination pelaksana, dapat ditelusuri dan diklarifikasi sepanjang siklus fulfilment, serta memiliki fulfilment outcome terverifikasi yang siap dirujuk oleh dokumentasi klinis resmi dan diserahkan kelayakan biayanya (*Charge Eligibility*) ke domain Tata Rekening**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Jalan | **Konteks Asal & Koordinasi Order Rawat Jalan**: Tempat perumusan konsultasi klinis, penerbitan instruksi pemeriksaan, rujukan internal antar-poliklinik, dan evaluasi hasil order dalam episode rawat jalan (`RJL-KONSUL`, `RJL-TRANSFER`). |
| Laboratory | **Unit Pelaksana Pemeriksaan Spesimen**: Menerima order lab, melakukan telaah dan pengambilan spesimen, melaksanakan analisis, memvalidasi hasil diagnostik, dan melaporkan fulfilment outcome (`LAB-ORDER`, `LAB-COLLECT`, `LAB-RESULT`). |
| Radiology | **Unit Pelaksana Pencitraan Diagnostik**: Menerima order radiologi, mengatur jadwal dan protokol penyinaran/akuisisi citra, membuat ekspertise radiologis, dan melaporkan fulfilment outcome (`RAD-ORDER`, `RAD-JADWAL`, `RAD-EXAM`, `RAD-EXPERTISE`). |
| Kamar Operasi | **Unit Pelaksana Bedah & Anestesi**: Menerima order pembedahan/tindakan invasif, mengoordinasikan penjadwalan kamar operasi dan asesmen pra-bedah, melaksanakan prosedur operatif, serta menerbitkan laporan operasi (`KMO-ORDER`, `KMO-JADWAL`, `KMO-PREOP`, `KMO-OPR`). |
| Apotek | **Unit Pelaksana Terapi Medikasi**: Menerima order terapi/resep, melakukan telaah kelayakan farmasi/klinis, peracikan/dispensing obat, dan penyerahan obat beserta edukasi (`APT-RESEP`, `APT-TELAAH`, `APT-DISPENSING`, `APT-SERAH`). |
| Rawat Inap | **Konteks Asal & Pelaksana Bangsal**: Tempat penerbitan order rawat inap oleh DPJP/PPJA, koordinasi instruksi harian, monitoring terapi, dan transfer tanggung jawab antar-ruangan atau antar-shift (`RNA-BED`, `RNA-TRANSFER`). |
| Gawat Darurat | **Konteks Asal & Pelaksana Darurat**: Menerbitkan order gawat darurat (cito/stat), mengoordinasikan tindakan resusitasi/intervensi kritis, dan mengelola order luar biasa (*Exceptional Orders*) (`IGD-VISIT`, `IGD-TRIAGE`, `IGD-TINDAKAN`). |
| Tata Rekening | **Konsumen Finansial**: Mengonsumsi fakta pemenuhan aktual yang berstatus *Charge Eligible* dari CPOE untuk membentuk tagihan pada rincian billing pasien, memvalidasi tarif, dan memproses penjaminan (`TRK-BILLING`, `TRK-TARIF`, `TRK-JAMINAN`). |
| Admission | **Konteks Kunjungan & Perjalanan Pasien**: Memelihara keabsahan registrasi/kunjungan (*Visit*) yang menjadi wadah induk seluruh Clinical Order, serta memperbarui riwayat perjalanan pasien antar-unit (`ADM-REG`, `ADM-TRACKER`). |
| Pasien | **Identitas Subjek Layanan**: Menyediakan data identitas resmi pasien (Nomor Rekam Medis, identitas sosial, dan data demografi) (`PAS-DATSOS`). |
| Organisasi | **Master Struktur & Tenaga Medis**: Menyediakan referensi unit layanan tujuan (`ORG-LAYANAN`) dan master data tenaga kesehatan serta kewenangan PPA (`ORG-PPA`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `CPOE-ORDER` Pengelolaan Clinical Order Terintegrasi | Rawat Jalan / Cross-Domain | Capability Candidate |
| `RJL-KONSUL` Konsultasi | Rawat Jalan | Known |
| `RJL-TRANSFER` Rujukan Internal | Rawat Jalan | Known |
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `LAB-COLLECT` Specimen Collection | Laboratory | Known |
| `LAB-RESULT` Lab Result Management | Laboratory | Known |
| `RAD-ORDER` Order Radiologi | Radiology | Known |
| `RAD-EXAM` Examination | Radiology | Known |
| `RAD-EXPERTISE` Expertise | Radiology | Known |
| `KMO-ORDER` Order Operasi | Kamar Operasi | Known |
| `KMO-PREOP` Persiapan Operasi | Kamar Operasi | Known |
| `KMO-OPR` Operative Procedure | Kamar Operasi | Known |
| `APT-RESEP` Resep | Apotek | Known |
| `APT-TELAAH` Telaah Resep | Apotek | Known |
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

### 5.1 Required Business Facts

#### A. Clinical Order sebagai Core Domain Object
1. **Pusat Interaksi Klinis Prospektif:** Clinical Order adalah representasi instruksi klinis prospektif tunggal yang mengikat secara hukum dan operasional. Setiap Clinical Order membawa sekurang-kurangnya:
   - Identitas Pasien (Nomor RM, nama, data demografi esensial).
   - Konteks Asuhan (*Care Context* / Nomor Registrasi Kunjungan aktif, unit/lokasi asal).
   - Kategori Instruksi (*Order Type*).
   - Indikasi Klinis (*Clinical Indication*) yang membenarkan perlunya instruksi.
   - Derajat Urgensi (*Priority*: Rutin, Urgent, Cito/Stat).
   - Waktu Permintaan Pelaksanaan (*Requested Timing*: Segera, Terjadwal tanggal/jam tertentu, atau Berkala).
   - Rincian Instruksi Medis (*Order Instruction*: parameter spesifik, dosis, modalitas, atau bagian anatomis).
   - Identitas Penyusun (*Order Author*) dan Pengesah (*Order Authorizer*).
   - Unit Kerja Tujuan (*Destination*).
   - Akuntabilitas Klinis Saat Ini (*Current Responsibility*).
   - Status Siklus Hidup (*Lifecycle State*).
2. **Kemandirian Item dalam Order Set:** Apabila beberapa order digabungkan dalam satu paket klinis (*Order Set* / *Clinical Bundle*), pengelompokan tersebut hanya berfungsi mempermudah penulisan. Setiap Clinical Order di dalam bundle tetap berdiri sendiri (*atomic entity*), memiliki nomor identifikasi unik, status otorisasi mandiri, siklus hidup masing-masing, serta disposisi penolakan/pembatalan yang terisolasi.

#### B. Pemisahan Empat Pilar Rantai Nilai Layanan
Arsitektur CPOE menegakkan pemisahan tegas tanpa kompromi antara empat domain fakta bisnis:
```text
[1. Clinical Order] ──(Instruksi Klinis)──> [2. Fulfilment] ──(Eksekusi Nyata)──> [3. Result / Execution Doc]
         │                                          │
         │ (Order ≠ Charge)                         └──(Fakta Pemenuhan Selesai)──> [4. Billing / Charge Eligibility]
```
- **Clinical Order:** Menyatakan apa yang *diminta* secara klinis prospektif. Bukan bukti bahwa tindakan telah terjadi.
- **Fulfilment:** Proses koordinasi, persiapan, dan pengerjaan aktual yang membuktikan apa yang *dilaksanakan*.
- **Result / Execution Documentation:** Menyimpan *temuan, hasil diagnostik, atau laporan prosedur authoritative* (misal hasil lab numerik, ekspertise radiologi, laporan operasi).
- **Billing / Charge Eligibility:** Konsekuensi finansial atas pelayanan yang *hanya boleh diakui* apabila didukung bukti pemenuhan aktual yang sah.

#### C. Model Aktor dan Akuntabilitas
Tanggung jawab klinis dalam CPOE didistribusikan secara transparan kepada peran-peran berikut:
1. **Order Author:** Tenaga kesehatan yang menyusun draf instruksi klinis (misal: dokter residen, perawat poliklinik, petugas triage).
2. **Order Authorizer:** Tenaga kesehatan yang memiliki wewenang klinis formal (*clinical privilege*) untuk menandatangani dan mengesahkan instruksi klinis menjadi berstatus *Authorized*.
3. **Ordering PPA:** Petugas Pemberi Asuhan (dokter, perawat, apoteker klinis, dietisien) yang bertindak sebagai pencetus dan penanggung jawab instruksi dalam batas kewenangannya.
4. **Responsible Clinician:** Dokter Penanggung Jawab Pelayanan (DPJP) atau klinisi yang saat ini memegang kendali atas kesinambungan asuhan pasien dan tindak lanjut terhadap *Outstanding Orders*.
5. **Receiver:** Petugas atau sistem pada unit kerja pelaksana (*Destination*) yang bertugas menerima, memvalidasi kelayakan, dan merespons instruksi yang masuk.
6. **Fulfilment Coordinator:** Koordinator pelayanan di unit tujuan yang mengatur penjadwalan, alokasi sumber daya, dan urutan pengerjaan order.
7. **Clinical Verifier:** Tenaga klinis ahli (seperti apoteker penelaah resep atau radiografer verifikator) yang melakukan penapisan aspek keselamatan pasien (*patient safety check*), interaksi obat, atau kontraindikasi klinis sebelum pelaksanaan dimulai.
8. **Performer:** Tenaga kesehatan atau tim teknis yang secara fisik melaksanakan instruksi klinis kepada pasien.
9. **Result Author / Validator:** Profesional kesehatan yang menerbitkan atau memvalidasi hasil diagnostik resmi (misal: Dokter Spesialis Patologi Klinik, Dokter Spesialis Radiologi).
10. **Discharge Actor:** Klinisi atau tim medis yang melakukan telaah dan rekonsiliasi akhir terhadap seluruh order aktif saat pasien bersiap pulang (*Discharge Reconciliation*).

> **Pemisahan Tegas Authorship vs. Authorization:**  
> Sistem wajib memisahkan pencatatan *Order Author* (siapa yang mengetik/menyiapkan draf) dan *Order Authorizer* (siapa yang mengambil tanggung jawab medikolegal formal), meskipun dalam banyak kasus rutin kedua peran tersebut dilakukan oleh orang yang sama.

#### D. Siklus Hidup Instruksi (Order Lifecycle)
Siklus hidup utama (*Primary Lifecycle*) bergerak melalui tahapan:
```text
Draft ──> Authorized ──> Dispatched ──> Accepted ──> In Fulfilment ──> Fulfilled ──> Closed
  │           │              │             │              │               │
  └──(Batal)  └──(Cancel)    └──(Cancel)   ├──(Reject)    ├──(Discontinue)└──(Selesai Koordinasi)
                                           └──(Clarify)   └──(Not Fulfilled)
                                                                 │
                                                       (Entered in Error)
```

1. **Primary States:**
   - **Draft:** Instruksi sedang disusun, bersifat tentatif, dan belum *actionable* bagi unit mana pun.
   - **Authorized:** Tanggung jawab klinis formal telah diambil oleh Authorizer; instruksi sah secara medikolegal namun belum dikirim.
   - **Dispatched:** Instruksi telah dikirimkan secara resmi ke antrean kerja unit pelaksana (*Destination*).
   - **Accepted:** Unit tujuan telah menelaah instruksi dan menyatakan komitmen untuk mengoordinasikan pemenuhannya.
   - **In Fulfilment:** Tahapan persiapan teknis, pengambilan bahan/sampel, penjadwalan meja periksa, atau pelaksanaan fisik instruksi telah dimulai di unit tujuan.
   - **Fulfilled:** Seluruh kriteria penyelesaian (*Completion Criterion*) untuk kategori order tersebut telah terpenuhi secara lengkap.
   - **Closed:** Tanggung jawab koordinasi CPOE atas order ini telah selesai sepenuhnya (pada fase ini tidak lagi memerlukan tindak lanjut koordinasi aktif).
2. **Terminal / Exceptional States:**
   - **Rejected:** Instruksi ditolak oleh Receiver di unit tujuan disertai alasan penolakan klinis atau operasional yang sah.
   - **Cancelled:** Instruksi dibatalkan atas inisiatif pihak pemesan (*Ordering PPA*) sebelum tahapan pelaksanaan fisik dimulai di unit tujuan.
   - **Discontinued:** Instruksi yang sedang aktif berjalan dihentikan untuk porsi pelaksanaan di masa depan (misal: terapi berkala/rutin yang dihentikan karena kondisi pasien membaik atau timbul efek samping). Porsi yang telah terpenuhi tetap sah sebagai fakta historis.
   - **Not Fulfilled:** Instruksi tidak dapat diselesaikan karena kendala eksternal atau kondisi klinis pasien (misal: pasien menolak tindakan invasif, pasien mangkir/hilang dari antrean, atau kondisi fisiologis pasien tidak memungkinkan).
   - **Entered in Error:** Instruksi dianulir karena cacat mendasar sejak awal pembuatan (misal: salah memilih pasien atau duplikasi klik yang fatal). Data fisik tidak dihapus, melainkan ditandai secara permanen dengan jejak audit lengkap.

> **Anti-Pola Status Pelaksanaan:**  
> Status `Accepted`, `Scheduled`, `Prepared`, atau `Started` **TIDAK BOLEH** disamakan dengan status `Fulfilled`. Instruksi hanya berhak berstatus `Fulfilled` apabila kriteria penyelesaian substantif telah dibuktikan.

#### E. Keputusan Penerima (Receiver Decisions) dan Tata Kelola Klarifikasi
Pihak penerima pada unit kerja tujuan (*Destination*) memiliki hak otoritatif untuk mengambil salah satu dari tiga keputusan operasional:
1. **Accept:** Menerima order untuk diproses lebih lanjut ke tahap fulfilment.
2. **Reject:** Menolak order secara permanen apabila instruksi tidak memenuhi syarat teknis, fasilitas tidak tersedia, atau terdapat kontraindikasi mutlak yang tidak dapat diperbaiki. Penolakan wajib mencantumkan alasan penolakan dan identitas Receiver.
3. **Request Clarification:** Meminta penjelasan atau perbaikan data kepada Ordering PPA apabila ditemukan ambiguitas, ketidaklengkapan informasi pendukung, inkonsistensi klinis, atau isu keselamatan pasien.
   - **Kondisi On Hold for Clarification:** Order yang meminta klarifikasi ditempatkan dalam status penangguhan (*On Hold for Clarification*). Selama masa penangguhan, pemenuhan fisik atas order ini tidak boleh dilanjutkan.
   - **Prinsip Isolasi Dampak:** Penangguhan suatu order akibat permintaan klarifikasi **TIDAK BOLEH** membekukan atau menunda order lain milik pasien yang sama (termasuk order lain di dalam paket *Order Set* yang sama), kecuali order lain tersebut secara eksplisit memiliki ketergantungan klinis langsung (*clinical dependency*).

#### F. Pengendalian Perubahan (Order Change Control)
Perubahan terhadap instruksi klinis dikelompokkan secara ketat berdasarkan status siklus hidupnya:
- **Modifikasi Draft:** Perubahan data pada draf sebelum disahkan (*pre-authorization*) tidak memerlukan registrasi formal amendment.
- **Amendment:** Perubahan instruksi yang dilakukan setelah order berstatus *Authorized*. Setiap amandemen wajib mencatat: identitas instruksi sebelumnya, alasan amandemen klinis, PPA pengotorisasi amandemen, serta evaluasi dampaknya terhadap progres di unit pelaksana.
- **Cancellation:** Pembatalan total instruksi yang hanya diizinkan apabila unit pelaksana belum memulai eksekusi fisik. Jika unit tujuan telah memulai eksekusi, pembatalan harus melalui komunikasi pembatalan bilateral.
- **Discontinuation:** Penghentian instruksi berkelanjutan (misal pemberian obat harian atau fisioterapi serial). Eksekusi yang telah lalu tetap tercatat sah, sedangkan eksekusi masa depan dibatalkan.
- **Entered in Error:** Penandaan koreksi medikolegal atas kesalahan administratif berat. Mengharuskan pencatatan alasan kesalahan dan identitas klinisi pengoreksi tanpa menghapus jejak data asli (*audit trail immutable*).

#### G. Tata Kelola Instruksi Luar Biasa (Exceptional Order Governance)
Dalam situasi klinis tertentu di mana otorisasi elektronik prospektif tidak memungkinkan atau membahayakan keselamatan nyawa pasien, sistem mengakomodasi mekanisme *Exceptional Order*:
1. **Verbal Order (Instruksi Lisan / Telepon):** Diterbitkan pada situasi steril (kamar operasi) atau darurat. Draf disiapkan oleh penerima instruksi (Author) dengan menandai dokter pemberi instruksi lisan, wajib melalui proses konfirmasi ulang (*read-back / repeat-back*), dan memerlukan otorisasi susulan (*Subsequent Authorization*).
2. **Emergency Action (Tindakan Kegawatdaruratan):** Tindakan penyelamatan jiwa (*life-saving*) yang dieksekusi seketika sebelum order sempat diinput ke sistem.
3. **Protocol-Based Action (Instruksi Berbasis Protokol):** Tindakan yang dieksekusi secara mandiri oleh PPA berdasarkan instruksi tetap (*standing order*), panduan praktik klinis (*clinical pathway*), atau protokol resmi rumah sakit yang telah disetujui komite medis.
4. **Retrospective Order (Pencatatan Retrospektif):** Perekaman data order ke dalam sistem setelah tindakan darurat selesai dilaksanakan.

> **Integritas Kronologi & Larangan Backdating:**  
> Tata kelola Exceptional Order **DILARANG KERAS memalsukan kronologi waktu**. Sistem wajib memisahkan empat penanda waktu (*timestamps*):  
> - `instruction_time`: Waktu instruksi lisan atau keputusan darurat diberikan.  
> - `execution_time`: Waktu tindakan fisik secara nyata dilaksanakan.  
> - `recording_time`: Waktu data order diketik dan disimpan ke dalam sistem.  
> - `subsequent_authorization_time`: Waktu otorisasi susulan disahkan oleh klinisi penanggung jawab.  
>  
> *Subsequent Authorization* adalah bentuk akuntabilitas retrospektif pasca-tindakan; bukan bukti fiktif bahwa otorisasi prospektif telah terjadi sebelumnya.

#### H. Tanggung Jawab dan Transisi Asuhan (Care Transition & Outstanding Orders)
1. **Kemandirian Tanggung Jawab dari Penulis Asal:** Tanggung jawab klinis untuk menindaklanjuti order yang masih aktif (*Outstanding Order*) tidak melekat secara kaku pada Author awal.
2. **Evaluasi Saat Transisi:** Ketika terjadi perpindahan ruangan (*ward transfer*), pergantian DPJP, alih rawat antar-disiplin, atau pergantian shift jaga:
   - Seluruh *Outstanding Orders* harus dievaluasi kembali (*reassessed*).
   - Hak dan kewajiban tindak lanjut (*clinical responsibility*) dialihkan ke klinisi atau tim penanggung jawab yang baru (*Transfer of Responsibility*), tanpa mengubah catatan sejarah mengenai siapa yang menyusun (*Author*) dan mengesahkan (*Authorizer*) order di awal.
3. **Rekonsiliasi Pemulangan (Discharge Reconciliation):**
   - Pemulangan pasien (*discharge*) dari rumah sakit **TIDAK BOLEH** secara otomatis membatalkan seluruh *Outstanding Orders* secara buta.
   - Seluruh order yang masih aktif wajib melalui proses rekonsiliasi pemulangan oleh *Discharge Actor*, dengan menetapkan disposisi yang jelas:
     - **Carried Forward / Converted:** Dialihkan menjadi rencana kontrol rawat jalan atau instruksi *home care*.
     - **Discontinued / Closed:** Ditutup secara resmi karena tujuan rawat inap telah berakhir.
     - **Continuing Responsibility:** Diberikan penugasan tanggung jawab kepada klinisi rawat jalan untuk memantau hasil yang masih tertunda (*pending diagnostic results*).

#### I. Kriteria Penyelesaian (Completion Criterion) dan Model Pemenuhan (Fulfilment)
1. **Completion Criterion per Order Type:** Setiap kategori instruksi klinis wajib memiliki kriteria penyelesaian objektif agar sah berstatus *Fulfilled*:
   - **Laboratorium:** Spesimen telah selesai diuji dan hasil uji numerik/tekstual resmi telah divalidasi oleh analis/patolog klinis (`LAB-RESULT`).
   - **Radiologi:** Citra radiologis telah selesai diakuisisi dan laporan ekspertise dokter spesialis radiologi telah diverifikasi (`RAD-EXPERTISE`).
   - **Kamar Operasi:** Prosedur pembedahan selesai dilaksanakan dan laporan operasi resmi telah disimpan secara persisten (`KMO-OPR`).
   - **Farmasi / Apotek:** Telaah resep selesai dan obat telah diserahkan kepada pasien/perawat disertai bukti serah terima (`APT-SERAH`).
   - **Konsultasi / Rujukan Internal:** Pasien telah selesai diperiksa dan jawaban konsultasi klinis telah dicatat oleh dokter konsulen (`RJL-KONSUL`).
   - **Prosedur / Tindakan Poliklinik:** Intervensi telah selesai dilaksanakan dan bukti pelaksanaan (*service record*) telah diterbitkan (`RJL-TINDAKAN`).
2. **Kedaulatan Executing Domain vs. Generic Fulfilment:**
   - Apabila rumah sakit telah memiliki sistem/domain pelaksana khusus (Laboratorium, Radiologi, Bedah, Apotek), domain-domain tersebut memegang kedaulatan penuh (*authoritative ownership*) atas detail workflow pengerjaan teknisnya. CPOE hanya menyimpan ringkasan pemenuhan (*Fulfilment Summary*).
   - Apabila domain pelaksana khusus belum diimplementasikan secara sistem, CPOE menyediakan mekanisme **Generic Fulfilment** secara transisional untuk mencatat fakta pemenuhan dasar (siapa pelaksana, kapan selesai, dan catatan hasil ringkas) tanpa menghilangkan batas konseptual antara instruksi dan eksekusi.

---

### 5.2 Required Recorded Information

Struktur data Clinical Order wajib mencakup komponen informasi terstruktur berikut:

#### A. Identitas Konteks Kunjungan & Pasien
- **Patient Identifiers:** Nomor Rekam Medis (No. RM), Nama Pasien, Tanggal Lahir, Jenis Kelamin.
- **Care Context Identifiers:** Nomor Registrasi Kunjungan (*Visit ID*), *Encounter ID*, Jenis Kunjungan (Rawat Jalan, Rawat Inap, Gawat Darurat), Unit/Poliklinik Asal Penerbit Order.

#### B. Atribut Inti Clinical Order
- **Order Identifiers:** Kode Unik Clinical Order (*Order ID*), Nomor Referensi Transaksi Bisnis, Kode Hubungan Paket (*Order Set ID*, opsional).
- **Order Type:** Klasifikasi instruksi (Laboratorium, Radiologi, Konsultasi/Rujukan, Prosedur Poliklinik, Terapi Medikasi, Nutrisi/Diet, Monitoring Keperawatan).
- **Clinical Indication:** Indikasi/alasan klinis, diagnosis kerja, atau pertanyaan klinis yang mendasari penerbitan instruksi.
- **Priority:** Skala prioritas pelayanan (`Rutin`, `Urgent`, `Cito / Stat`).
- **Requested Timing:** Jadwal permintaan pelaksanaan (`Segera`, `Spesifik Tanggal & Jam`, `Berkala / Interval Waktu`).
- **Order Instruction Details:** Teks instruksi spesifik, kode katalog tindakan/pemeriksaan master, parameter klinis, lokasi anatomi, atau dosis/frekuensi.

#### C. Akuntabilitas Kepengarangan & Otorisasi
- **Order Author:** Identitas tenaga kesehatan penyusun draf (ID Pegawai, Nama, Peran Profesi), Waktu Penyusunan Draf.
- **Order Authorizer:** Identitas tenaga kesehatan pengesah (ID Dokter/PPA, Nama, Nomor Izin Praktik/SIP), Waktu Otorisasi (*Authorization Timestamp*), Metode Otorisasi (Elektronik Langsung, PIN/Tanda Tangan Digital).
- **Ordering PPA Responsibility:** Unit kerja dan disiplin klinis asal pemesan.

#### D. Perutean, Penerimaan, dan Koordinasi (Routing & Receiver)
- **Destination:** Kode dan Nama Unit Kerja Pelaksana Tujuan (`ORG-LAYANAN`).
- **Receiver Information:** Identitas petugas penerima order di unit tujuan, Waktu Penerimaan (*Dispatch/Receive Timestamp*).
- **Receiver Decision:** Status keputusan (`Accepted`, `Rejected`, `Clarification Requested`).
- **Rejection / Hold Details:** Kode alasan penolakan, catatan justifikasi penolakan, identitas penolak, atau catatan permintaan klarifikasi keselamatan pasien.

#### E. Status Siklus Hidup & Jejak Perubahan (Lifecycle & Change Control)
- **Current Lifecycle State:** Status aktif terkini (`Draft`, `Authorized`, `Dispatched`, `Accepted`, `In Fulfilment`, `Fulfilled`, `Closed`, `Rejected`, `Cancelled`, `Discontinued`, `Not Fulfilled`, `Entered in Error`).
- **Change Control Records:** Riwayat amandemen (instruksi sebelum vs sesudah, alasan amandemen, identitas pengamandemen, waktu), riwayat pembatalan/penghentian, dan alasan kesalahan entri (*Entered in Error*).

#### F. Perekaman Kasus Luar Biasa (Exceptional Order Data)
- **Exceptional Category:** Penanda jenis (`Verbal Order`, `Emergency Action`, `Protocol-Based Action`, `Retrospective Order`).
- **Pemberi Instruksi Lisan:** Identitas dokter pemberi instruksi via telepon/lisan, bukti verifikasi *read-back/repeat-back*.
- **Empat Penanda Waktu Mutlak:**
  - `instruction_time` (waktu instruksi diberikan).
  - `execution_time` (waktu pelaksanaan fisik dilakukan).
  - `recording_time` (waktu data direkam ke sistem).
  - `subsequent_authorization_time` (waktu otorisasi susulan disahkan).
- **Subsequent Authorizer:** Identitas DPJP yang menandatangani otorisasi susulan beserta batas waktu masa berlakunya (*time limit validity*).

#### G. Alih Tanggung Jawab & Rekonsiliasi (Responsibility & Discharge)
- **Current Responsible Clinician:** Identitas klinisi yang saat ini bertanggung jawab memantau tindak lanjut order.
- **Transfer History:** Riwayat pengalihan tanggung jawab (klinisi lama, klinisi baru, alasan pengalihan, waktu pengalihan).
- **Discharge Reconciliation Status:** Disposisi pemulangan (`Carried Forward`, `Converted to Outpatient`, `Discontinued`, `Closed`), Petugas Rekonsiliasi (*Discharge Actor*), Waktu Rekonsiliasi.

#### H. Ringkasan Pemenuhan, Tautan Bukti Klinis & Finansial
- **Fulfilment Summary:** Model pemenuhan (`Executing Domain Authoritative` vs `Generic Fulfilment`), Identitas Pelaksana (*Performer*), Waktu Selesai Pelaksanaan (*Fulfilment Completion Timestamp*).
- **Authoritative Clinical References:** Tautan/referensi dokumen hasil resmi (Nomor Pemeriksaan Lab / *Result ID*, Nomor Ekspertise Radiologi, Nomor Dokumen Rekam Medis / EMR).
- **Charge Eligibility Handover:** Penanda kelayakan biaya (`Charge Eligible: Ya / Tidak`), Dasar Kelayakan Pembebanan (porsi tindakan yang tuntas dilaksanakan), Referensi transaksi penyerahan ke Tata Rekening (`TRK-BILLING`).

---

### 5.3 Required Business Conditions

1. **Keabsahan Pasien dan Kunjungan:** Pasien harus terdaftar secara sah (`PAS-DATSOS`) dan nomor registrasi kunjungan (*Care Context*) berstatus aktif di bawah kendali Admission (`ADM-REG`).
2. **Kewenangan dan Privilese Klinis:** Order Authorizer wajib memiliki kredensial dan kewenangan klinis (*clinical privileges*) yang sah sesuai master tenaga medis (`ORG-PPA`) untuk jenis tindakan/pemeriksaan yang diotorisasi.
3. **Validitas Unit Tujuan:** Unit pelaksana yang dipilih sebagai *Destination* harus merupakan unit kerja aktif yang tercatat resmi dalam struktur organisasi rumah sakit (`ORG-LAYANAN`) serta memiliki kemampuan teknis melayani kategori order tersebut.
4. **Keberadaan Indikasi Klinis:** Setiap Clinical Order yang diotorisasi wajib mencantumkan indikasi klinis atau pertanyaan diagnostik; dilarang menerbitkan order kosong tanpa alasan medis.
5. **Independensi Otorisasi:** Tanggung jawab otorisasi tidak dapat didelegasikan secara anonim. Identitas Authorizer wajib tercatat secara eksplisit dan terpisah dari pembuat draf (Author).
6. **Kesesuaian Urgensi Cito/Stat:** Penggunaan skala prioritas `Cito / Stat` wajib memenuhi kriteria kegawatdaruratan dan memicu notifikasi prioritas tinggi pada antrean unit tujuan.
7. **Batas Waktu Otorisasi Susulan:** Instruksi darurat atau verbal (*Verbal / Retrospective Order*) wajib disahkan melalui *Subsequent Authorization* oleh DPJP dalam batas waktu medikolegal rumah sakit (maksimal 1x24 jam sejak waktu pelaksanaan).
8. **Kemandirian Evaluasi Penolakan/Klarifikasi:** Permintaan klarifikasi atau penolakan oleh Receiver di unit tujuan harus menyertakan alasan spesifik agar Ordering PPA dapat segera mengambil tindakan korektif.
9. **Kondisi Penghentian Terjadwal:** Instruksi berkala hanya dapat dihentikan (*Discontinued*) untuk siklus pelaksanaan berikutnya; tindakan yang telah selesai dilaksanakan pada siklus sebelumnya tidak boleh dibatalkan secara retroaktif.
10. **Kondisi Penyerahan Charge Eligibility:** Penyerahan kelayakan pembebanan biaya ke Tata Rekening hanya boleh dipicu apabila status pemenuhan fisik telah terkonfirmasi sah memenuhi *Completion Criterion* (atau porsi terukur yang dapat dibenarkan secara regulasi).

---

### 5.4 Completion Proof

Suatu Clinical Order dinyatakan telah tuntas dan dapat dialihkan ke status `Closed` apabila memenuhi bukti-bukti objektif berikut:
1. **Verifikasi Bukti Penyelesaian:** Terdapat rekaman pemenuhan fisik (*Fulfilment Record*) yang terverifikasi memenuhi *Completion Criterion* sesuai kategori order yang bersangkutan.
2. **Tautan Hasil / Dokumentasi Resmi:** Telah terbentuk tautan permanen yang valid ke dokumen hasil klinis resmi (*Result Reference*) pada domain pelaksana (misal: hasil uji lab yang tervalidasi atau ekspertise radiologi) atau ke dokumen rekam medis pelaksanaan (*Execution Documentation Reference*).
3. **Penyelesaian Handover Finansial:** Fakta kelayakan pembebanan biaya (*Charge Eligibility*) atas tindakan yang terlaksana telah diserahkan secara tidak ambigu ke domain Tata Rekening (`TRK-BILLING`), atau dinyatakan secara eksplisit tidak memungut biaya (*non-chargeable*) sesuai aturan penjaminan.
4. **Penyelesaian Seluruh Kewajiban Koordinasi CPOE:** Tidak ada lagi proses klarifikasi yang tertunda (*no unresolved clarifications*), tidak ada sisa siklus pemenuhan yang belum ditindaklanjuti, dan tidak ada sengketa tanggung jawab klinis yang belum terselesaikan.
5. **Jejak Audit Utuh dan Tidak Terhapus:** Seluruh riwayat perubahan, catatan persetujuan, kronologi timestamp, dan identitas para aktor tersimpan secara persisten dalam catatan audit yang tidak dapat dimanipulasi (*immutable audit record*).

---

## 6. Outcome Boundary

### Start

Dimulai ketika Petugas Pemberi Asuhan (PPA) mengidentifikasi adanya kebutuhan klinis pada pasien dan mulai menyusun formulasi instruksi prospektif (*clinical intent*) ke dalam draf Clinical Order, atau ketika instruksi darurat/verbal pertama kali diberikan dalam konteks kegawatdaruratan.

### End

Berakhir ketika Clinical Order mencapai status akhir (*Terminal State*):
- Berstatus **Closed** setelah tahapan pemenuhan fisik selesai, *Completion Criterion* terpenuhi, tautan ke hasil/dokumentasi resmi terbentuk, dan serah terima kelayakan tagihan (*Charge Eligibility*) ke Tata Rekening telah diselesaikan; ATAU
- Berstatus akhir melalui terminasi resmi yang sah (**Rejected**, **Cancelled**, **Discontinued**, **Not Fulfilled**, atau **Entered in Error**) dengan seluruh catatan pertanggungjawaban terekam permanen.

---

### Ruang Lingkup Formal

#### In Scope (Tercakup Penuh dalam Domain CPOE)
1. **Clinical Order Definition:** Standardisasi struktur objek dan siklus hidup instruksi klinis prospektif.
2. **Order Authoring dan Authorization:** Pengelolaan peran penyusun draf dan pengesah wewenang klinis.
3. **Order Type dan Informasi Klinis Wajib:** Klasifikasi kategori order dan validasi data pendukung minimal.
4. **Clinical Indication:** Perekaman indikasi klinis dan diagnosis kerja pembenaran order.
5. **Priority dan Requested Timing:** Pengaturan skala urgensi (Rutin, Urgent, Cito) dan waktu pelaksanaan yang diminta.
6. **Order Instruction:** Standardisasi rincian instruksi teknis dan dosis medis.
7. **Order Routing kepada Destination:** Mekanisme pengiriman dan perutean instruksi ke unit kerja tujuan yang berwenang.
8. **Receiver Work Management:** Manajemen antrean kerja penerimaan instruksi pada unit pelaksana.
9. **Acceptance, Rejection, dan Clarification:** Tata kelola keputusan penerima (terima, tolak, atau minta klarifikasi) dan status penangguhan (*On Hold*).
10. **Fulfilment Coordination:** Pengawasan dan koordinasi tahapan pelaksanaan order antar-unit.
11. **Fulfilment Outcome:** Standardisasi pencatatan hasil pemenuhan instruksi.
12. **Amendment, Cancellation, Discontinuation, dan Entered in Error:** Tata kelola perubahan dan pembatalan instruksi berizin medikolegal.
13. **Order Responsibility dan Transfer of Responsibility:** Manajemen penugasan klinisi yang memegang kendali atas *Outstanding Orders* saat terjadi transisi perawatan.
14. **Association terhadap Fulfilment, Result, dan Execution Documentation:** Pemeliharaan tautan referensi antara order, proses eksekusi, dokumen hasil, dan rekam medis resmi.
15. **Exceptional Order Governance:** Tata kelola instruksi lisan (*Verbal Order*), tindakan darurat (*Emergency Action*), berbasis protokol (*Protocol-Based*), dan retrospektif (*Retrospective Order*) dengan pelestarian 4 penanda waktu (*no backdating*).
16. **Auditability:** Pelacakan menyeluruh atas seluruh keputusan, pengesahan, perubahan, dan disposisi bisnis.
17. **Discharge Reconciliation terhadap Outstanding Orders:** Telaah dan rekonsiliasi seluruh order aktif saat episode perawatan berakhir.
18. **Handover Charge Eligibility:** Penyerahan fakta kelayakan pembebanan biaya dari tindakan yang nyata terlaksana kepada domain Tata Rekening.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Clinical Order Bukan Bukti Pelaksanaan:** Clinical Order adalah instruksi prospektif (*intent*), bukan bukti bahwa pelayanan atau intervensi klinis telah selesai dilaksanakan. Bukti pelaksanaan merupakan domain tersendiri (*Fulfilment / Execution Documentation*).
2. **Order Bukan Biaya (*Order ≠ Charge*):** Pembuatan draf, otorisasi, pengiriman (*dispatch*), penerimaan (*acceptance*), penjadwalan (*scheduling*), maupun persiapan teknis (*preparation*) **DILARANG MENGHASILKAN BIAYA**. Kelayakan pembebanan biaya (*Charge Eligibility*) hanya dapat muncul dari fakta pemenuhan aktual yang telah diselesaikan.
3. **Pemisahan Tegas Antara Pembuat dan Pengesah:** Sistem wajib membedakan secara tegas antara identitas penyusun draf (*Order Author*) dan pemberi otorisasi klinis formal (*Order Authorizer*), guna mendukung akuntabilitas medikolegal dan supervisi klinis (misal: residen/perawat terhadap DPJP).
4. **Kedaulatan Unit Pelaksana (*Executing Domain Sovereignty*):** Domain pelaksana khusus (Laboratorium, Radiologi, Kamar Operasi, Apotek) memegang kedaulatan mutlak atas detail teknis pelaksanaan, pengujian, dan validasi klinis di areanya. CPOE tidak boleh mengintervensi alur kerja internal unit pelaksana melampaui kebutuhan koordinasi pemenuhan.
5. **Transisional Generic Fulfilment:** Pemanfaatan *Generic Fulfilment* oleh CPOE hanya diperkenankan secara transisional apabila unit kerja pelaksana belum memiliki sistem eksekusi domain khusus. Mekanisme ini tidak boleh mengaburkan perbedaan antara instruksi order dan bukti pelaksanaan.
6. **Isolasi Dampak Penangguhan Klarifikasi:** Order yang terdampak permintaan klarifikasi (*On Hold for Clarification*) ditangguhkan proses pengerjaannya, namun penangguhan ini **DILARANG MEMBEKUKAN** order lain milik pasien yang sama yang tidak berkaitan secara klinis.
7. **Kemandirian Status Fulfilled terhadap Status Persiapan:** Status `Accepted`, `Scheduled`, `Prepared`, atau `Started` dilarang keras dianggap sebagai `Fulfilled`. Status `Fulfilled` mutlak menuntut tercapainya *Completion Criterion*.
8. **Imutabilitas Riwayat Keputusan Klinis (*History Preservation*):** Dilarang keras melakukan penghapusan fisik (*hard delete*) terhadap Clinical Order yang telah diotorisasi, keputusan Receiver, maupun riwayat klarifikasi. Setiap koreksi wajib melalui mekanisme *Amendment*, *Cancellation*, *Discontinuation*, atau *Entered in Error* dengan jejak audit permanen.
9. **Integritas Kronologi Exceptional Orders (*No Backdating*):** Perekaman order luar biasa (verbal, darurat, retrospektif) dilarang keras memalsukan waktu pencatatan. Sistem wajib mencatat dan menampilkan secara terpisah antara waktu instruksi, waktu pelaksanaan, waktu entri sistem, dan waktu otorisasi susulan.
10. **Larangan Pembatalan Buta Saat Discharge:** Pemulangan pasien (*discharge*) dilarang membatalkan seluruh *Outstanding Orders* secara otomatis. Seluruh order yang masih aktif wajib melalui penelaahan rekonsiliasi (*Discharge Reconciliation*) dengan disposisi resmi.
11. **Kewenangan PPA Berdasarkan Clinical Privilege:** Penyusunan dan otorisasi order oleh PPA selain dokter (perawat, bidan, dietisien, apoteker) dibatasi secara ketat hanya pada lingkup kewenangan klinis (*clinical privileges*) yang sah sesuai ketetapan regulasi dan kredensial rumah sakit.
12. **Bukan Rekam Medis Authoritative:** CPOE bukan tempat penyimpanan narasi klinis mendalam (seperti lembar CPPT, laporan operasi lengkap, atau ekspertise diagnostik lengkap). CPOE hanya menyimpan instruksi, ringkasan pemenuhan, dan tautan referensi ke dokumen rekam medis otoritatif.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or encounters an operational exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Registrasi kunjungan (*Care Context*) pasien tidak aktif atau telah ditutup | Penyusunan dan otorisasi Clinical Order baru ditolak. Instruksi klinis hanya dapat diterbitkan dalam konteks kunjungan yang berstatus aktif. |
| Authorizer tidak memiliki kewenangan klinis (*clinical privilege*) untuk jenis order yang diminta | Proses otorisasi ditolak oleh sistem. Pengguna diminta mengalihkan draf kepada PPA/DPJP yang memiliki kewenangan sah. |
| Order ditolak (*Rejected*) oleh Receiver di unit kerja tujuan | Status order berubah menjadi `Rejected`. Alasan penolakan dicatat permanen dalam audit trail. Unit asal menerima notifikasi penolakan; proses pemenuhan dihentikan tanpa menghasilkan Charge Eligibility. |
| Receiver menemukan keraguan atau masalah keselamatan pasien dan meminta klarifikasi | Status order berubah menjadi `On Hold for Clarification`. Pemenuhan fisik ditunda hingga Ordering PPA memberikan klarifikasi atau revisi instruksi. Order lain milik pasien yang tidak berkorelasi tetap berjalan normal. |
| Ordering PPA membatalkan order (*Cancelled*) sebelum eksekusi fisik dimulai | Status order berubah menjadi `Cancelled`. Unit tujuan menerima notifikasi pembatalan; reservasi sumber daya/antrean di unit tujuan dihapus tanpa pembebanan biaya. |
| Pembatalan diajukan saat unit tujuan telah memulai proses pelaksanaan (*In Fulfilment*) | Pembatalan otomatis ditolak oleh sistem. Sistem mengarahkan pengguna melakukan komunikasi bilateral dengan unit pelaksana untuk menyepakati penghentian (*Discontinuation*) atau penyelesaian sebagian. |
| Kondisi klinis pasien berubah sehingga terapi serial/berkala harus dihentikan | Order dialihkan ke status `Discontinued`. Tindakan yang telah terlaksana tetap sah sebagai fakta historis; seluruh jadwal pengerjaan di masa mendatang dibatalkan. |
| Kesalahan fatal administratif teridentifikasi pasca-otorisasi (salah pasien/salah perutean) | Order dialihkan ke status `Entered in Error` dengan catatan justifikasi lengkap. Seluruh proses di unit tujuan dianulir seketika tanpa menghapus rekaman fisik audit trail. |
| Otorisasi susulan (*Subsequent Authorization*) pada Verbal Order melewati batas waktu medikolegal (misal > 24 jam) | Sistem menandai order sebagai *Unsigned / Overdue Authorization*, menerbitkan eskalasi kepatuhan medikolegal kepada komite medis, dan membekukan hak pembuatan verbal order berikutnya bagi pihak terkait hingga diselesaikan. |
| Terjadi perpindahan ruangan (*ward transfer*) atau pergantian DPJP saat masih ada *Outstanding Orders* | Sistem mempertahankan integritas Author awal, menyajikan daftar seluruh *Outstanding Orders* kepada DPJP/tim penerima baru untuk dievaluasi, dan mencatat alih tanggung jawab klinis (*Transfer of Responsibility*). |
| Pasien dipulangkan sementara masih memiliki order diagnostik aktif yang hasilnya belum terbit | Sistem mewajibkan proses *Discharge Reconciliation*; order tidak dibatalkan melainkan ditandai sebagai *Pending Result Post-Discharge* dengan penugasan tanggung jawab monitoring kepada DPJP rawat jalan. |
| Pelaksanaan fisik gagal diselesaikan akibat kondisi fisiologis pasien atau penolakan pasien | Order dialihkan ke status `Not Fulfilled` disertai catatan kendala klinis. Kelayakan tagihan hanya diperkenankan atas bahan/tindakan persiapan yang sah menurut kebijakan rumah sakit. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Sistem berhasil mencatat objek Clinical Order terstruktur yang memuat secara lengkap: data pasien, nomor registrasi kunjungan aktif, kategori order, indikasi klinis, prioritas, waktu pelaksanaan yang diminta, instruksi teknis, identitas Author, identitas Authorizer, unit tujuan, dan status siklus hidup. | Completeness |
| AC-02 | Perekaman pembuatan draf, otorisasi, pengiriman, penerimaan, maupun penjadwalan order terbukti tidak membentuk transaksi pembebanan biaya (*Charge Eligibility*) pada domain Tata Rekening. | Constraint |
| AC-03 | Sistem mencatat dan membedakan secara tegas identitas pembuat draf (*Order Author*) dan pengesah (*Order Authorizer*) sebagai dua entitas aktor yang mandiri dalam rekaman order. | Correctness |
| AC-04 | Pembuatan beberapa order secara bersamaan dalam satu paket (*Order Set*) menghasilkan record Clinical Order yang terisolasi secara mandiri, dengan identitas, siklus hidup, dan disposisi pembatalan masing-masing. | Correctness |
| AC-05 | Siklus hidup Clinical Order berhasil bertransisi sesuai urutan standar: `Draft` → `Authorized` → `Dispatched` → `Accepted` → `In Fulfilment` → `Fulfilled` → `Closed`. | Completeness |
| AC-06 | Sistem menolak perubahan status order menjadi `Fulfilled` apabila kriteria penyelesaian (*Completion Criterion*) untuk kategori order tersebut belum terbukti terpenuhi. | Constraint |
| AC-07 | Status `Accepted`, `Scheduled`, atau `In Fulfilment` tidak pernah dianggap setara atau memicu efek yang sama dengan status `Fulfilled`. | Constraint |
| AC-08 | Receiver pada unit kerja tujuan dapat melakukan tindakan `Accept`, `Reject` (disertai alasan penolakan), atau `Request Clarification` (disertai catatan klarifikasi). | Completeness |
| AC-09 | Permintaan klarifikasi oleh Receiver berhasil menempatkan order terkait pada kondisi `On Hold for Clarification`, sementara order lain milik pasien yang sama tetap berjalan tanpa terhambat. | Correctness |
| AC-10 | Setiap amandemen (*Amendment*) terhadap order yang telah berstatus `Authorized` berhasil mencatat riwayat instruksi lama, teks instruksi baru, alasan amandemen klinis, identitas pengotorisasi, dan penanda waktu. | Correctness |
| AC-11 | Pembatalan (*Cancellation*) order oleh pemesan berhasil membatalkan penugasan pada unit tujuan jika eksekusi fisik belum dimulai. | Correctness |
| AC-12 | Penghentian order serial (*Discontinuation*) berhasil membatalkan porsi eksekusi masa depan tanpa menganulir rekaman tindakan yang telah selesai dilaksanakan sebelumnya. | Correctness |
| AC-13 | Koreksi order berstatus `Entered in Error` berhasil menonaktifkan order secara administratif dengan audit trail permanen tanpa melakukan penghapusan data fisik. | Exception |
| AC-14 | Perekaman Exceptional Order (Verbal, Darurat, Retrospektif) mencatat empat penanda waktu secara terpisah (`instruction_time`, `execution_time`, `recording_time`, dan `subsequent_authorization_time`) tanpa pemalsuan kronologi (*no backdating*). | Constraint |
| AC-15 | Pelaksanaan instruksi verbal mewajibkan adanya rekaman otorisasi susulan (*Subsequent Authorization*) oleh klinisi penanggung jawab dalam batas waktu yang ditentukan. | Completeness |
| AC-16 | Saat terjadi perpindahan ruangan (*ward transfer*) atau pergantian DPJP, sistem berhasil mengalihkan kendali klinis atas seluruh *Outstanding Orders* kepada klinisi penanggung jawab baru tanpa mengubah identitas Author awal. | Correctness |
| AC-17 | Proses pemulangan pasien (*discharge*) tidak membatalkan *Outstanding Orders* secara otomatis dan mewajibkan eksekusi telaah *Discharge Reconciliation*. | Constraint |
| AC-18 | Penyerahan kelayakan biaya (*Charge Eligibility*) ke domain Tata Rekening (`TRK-BILLING`) hanya terpicu setelah pemenuhan aktual terbukti selesai secara sah. | Correctness |
| AC-19 | Apabila unit pelaksana belum memiliki domain sistem khusus, mekanisme *Generic Fulfilment* berhasil mencatat identitas pelaksana, waktu selesai, dan catatan ringkas tanpa menghilangkan batas antara order dan eksekusi. | Correctness |
| AC-20 | Seluruh riwayat transaksi order, pengesahan, keputusan penerima, klarifikasi, amandemen, dan pembatalan tersimpan dalam catatan audit permanen yang tidak dapat dimanipulasi (*immutable audit record*). | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pelayanan Keperawatan Rutin (*Routine Nursing Care*):** Intervensi keperawatan standar yang berada dalam lingkup tugas mandiri perawat sehari-hari (seperti memandikan pasien, reposisi posisi tidur, pemantauan tanda vital rutin berkala tanpa instruksi khusus) → Lingkup operasional keperawatan bangsal rawat inap (`RNA-*`).
- **Alur Kerja Teknis Internal Departemen Pelaksana (*Internal Fulfilment Workflow*):** Pengaturan kalibrasi alat laboratorium, manajemen reagen, pengaturan protokol radiasi mesin pencitraan, manajemen sterilisasi instrumen kamar operasi, dan teknik peracikan puyer apotek → Domain spesifik pelaksana (`LAB-*`, `RAD-*`, `KMO-*`, `APT-*`).
- **Penyimpanan Dokumentasi Hasil Medis Authoritative (*Authoritative Clinical Results*):** Penyimpanan narasi ekspertise diagnostik lengkap, arsip citra DICOM/PACS, grafik kurva lab, rekaman EKG/EEG, dan dokumen CPPT/resume medis EMR → Domain Penunjang Terkait dan Domain Rekam Medis Elektronik (EMR).
- **Laporan dan Dokumentasi Prosedur Pembedahan Resmi (*Authoritative Execution Documentation*):** Penyusunan lembar laporan pembedahan detail, laporan anestesi, lembar *surgical safety checklist*, dan lembar monitoring pasca-anestesi (PACU) → Domain Kamar Operasi (`KMO-OPR`, `KMO-RECOVERY`) dan EMR.
- **Konfigurasi Master Tarif dan Kebijakan Finansial:** Penentuan besaran tarif tindakan/pemeriksaan, tarif cito, matriks kelas perawatan, aturan selisih biaya, dan penjaminan asuransi → Domain Tata Rekening (`TRK-TARIF`, `TRK-JAMINAN`).
- **Kalkulasi Tagihan, Invoice, dan Pembayaran Kasir:** Pembentukan invoice tagihan akhir pasien, penerimaan pembayaran kasir, pencetakan kuitansi, dan alokasi pelunasan piutang → Domain Tata Rekening (`TRK-BILLING`, `TRK-PAYMENT`, `TRK-KASIR`).
- **Manajemen Persediaan dan Kontrol Stok Fisik (*Inventory & Stock Control*):** Pengurangan stok fisik obat/BMHP di gudang, *buffer stock*, pencatatan *batch number/expired date*, dan pengadaan barang → Domain Inventory (`INV-*`) dan Apotek (`APT-*`).
- **Tindak Lanjut Klinis Terhadap Hasil Diagnostik (*Clinical Review of Results*):** Pengambilan keputusan medis lanjutan, interpretasi hasil terhadap prognosis pasien, dan formulasi rencana terapi baru pasca-terbitnya hasil diagnostik pada Phase 1 → Domain Klinis / EMR.
