# OUTCOME: Triage

| Field       | Value        |
|-------------|--------------|
| Code        | OC-07-02     |
| Version     | 1.2          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Rumah sakit harus mampu melakukan penilaian kondisi awal pasien yang datang ke Instalasi Gawat Darurat (IGD) secara cepat, objektif, dan terstandar untuk menentukan tingkat kegawatan serta prioritas penanganan medisnya.

Triage merupakan *business assessment* yang terjadi dalam konteks satu episode kunjungan IGD (`IGD Visit`). Triage bukan sekadar atribut statis dari episode kunjungan, melainkan assessment yang dapat terjadi lebih dari satu kali selama satu episode IGD Visit berlangsung.

Keberadaan Triage menjamin bahwa prioritas penanganan pasien ditetapkan berdasarkan kondisi fisiologis objektif melalui penilaian Airway, Breathing, Circulation (ABC) dan Glasgow Coma Scale (GCS) yang menghasilkan klasifikasi Australasian Triage Scale (ATS). Selain itu, Triage menyediakan mekanisme penyesuaian (*override*) khusus pada kondisi klinis tertentu yang memungkinkan penetapan ATS Hitam, serta mengakomodasi penilaian ulang (*Re-Triage*) saat diperlukan atau terjadi perubahan kondisi pasien tanpa menghilangkan riwayat penilaian sebelumnya.

---

## 2. Outcome Statement

Penilaian kondisi pasien (meliputi ABC dan GCS) serta penetapan klasifikasi tingkat kegawatan dan prioritas penanganan (ATS normal atau penetapan ATS Hitam melalui override) **telah tercatat sebagai assessment yang sah dalam episode IGD Visit, dan Triage terakhir menjadi acuan kondisi serta prioritas pasien terkini dalam IGD Visit**.

---

## 3. Participating Domains

| Domain | Kategori | Role in this Outcome |
|---|---|---|
| Gawat Darurat (IGD) | **Core Domain — Owner** | Pemilik dan pengelola penuh assessment Triage: mencatat evaluasi ABC dan GCS, menetapkan hasil klasifikasi ATS atau override ATS Hitam, memelihara riwayat assessment, serta menyediakan acuan kondisi dan prioritas penanganan pasien terkini dalam episode IGD Visit. |
| Organisasi (ORG) | Domain Pendukung | Menyediakan data Petugas Pemberi Asuhan (PPA) — seperti perawat IGD atau dokter jaga IGD — yang berwenang dan bertugas saat assessment dilakukan, serta data unit layanan IGD tempat triage berlangsung. |
| Pasien (PAS) | Domain Pendukung | Menyediakan subjek pasien yang dinilai kondisinya (baik yang telah memiliki No. RM resmi maupun pengunjung dengan pengenal sementara) melalui episode IGD Visit yang menaunginya. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `IGD-TRIAGE` Triage | Gawat Darurat | Known |
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Assessment Triage tercatat dalam konteks satu episode kunjungan IGD (`IGD Visit`) yang sah dan aktif.
- Penilaian kondisi pasien mencakup evaluasi komponen ABC (*Airway*, *Breathing*, *Circulation*) dan GCS (*Eye*, *Verbal*, *Motor*).
- Hasil klasifikasi tingkat kegawatan dan prioritas penanganan pasien (ATS) telah ditetapkan:
  - Pada kondisi normal: hasil ATS ditentukan berdasarkan kombinasi hasil assessment ABC dan GCS (`ABC + GCS → ATS`).
  - Pada kondisi khusus: petugas IGD dapat melakukan *override* terhadap hasil triage normal dan menetapkan hasil **ATS Hitam** pada kondisi klinis tertentu yang memungkinkan penetapan ATS Hitam (`Kondisi klinis tertentu → Override → ATS Hitam`).
- Triage mencatat identitas tenaga medis yang sedang bertugas di IGD pada saat assessment dilakukan.
- Setiap Triage dan Re-Triage tercatat secara kronologis dan dipertahankan sebagai histori assessment yang tidak dihapus atau ditimpa.
- Triage terakhir menjadi acuan kondisi dan prioritas pasien terkini dalam IGD Visit.

### 5.2 Required Recorded Information

**Konteks Episode & Pelaksana:**
- Referensi unik episode kunjungan IGD (`IGD Visit`) yang menjadi naungan assessment.
- Identitas tenaga medis penilai (PPA: dokter jaga IGD atau perawat IGD yang sedang bertugas).
- Waktu pelaksanaan assessment (tanggal dan jam penilaian).
- Indikator urutan/jenis assessment: Triage awal (saat kedatangan) atau Re-Triage (penilaian ulang).

**Komponen Penilaian Kondisi Pasien:**
- Komponen ABC:
  - *Airway* (kondisi jalan napas).
  - *Breathing* (kondisi pernapasan).
  - *Circulation* (kondisi sirkulasi).
- Komponen GCS:
  - *Eye response* (respons pembukaan mata).
  - *Verbal response* (respons verbal/bicara).
  - *Motor response* (respons motorik/gerakan).

**Hasil Klasifikasi & Prioritas:**
- Hasil klasifikasi tingkat kegawatan/prioritas penanganan pasien (ATS).
- Indikator *Override* ATS Hitam: Penanda eksplisit apabila hasil ATS Hitam ditetapkan melalui mekanisme override atas dasar kondisi klinis tertentu.

### 5.3 Required Business Conditions

- Triage hanya dapat dilakukan dan dicatat pada pasien yang memiliki episode IGD Visit yang sah dan aktif.
- Triage pertama dilakukan saat pasien tiba di IGD.
- Re-Triage dapat dilakukan kapan saja selama episode IGD Visit berlangsung apabila tenaga medis IGD menilai perlu dilakukan penilaian ulang terhadap kondisi pasien, termasuk ketika terdapat perubahan kondisi pasien.
- Pencatatan Re-Triage tidak boleh menghapus, menimpa, atau mengubah catatan Triage atau Re-Triage sebelumnya.
- Hubungan Triage dalam IGD Visit membentuk rantai penilaian: `IGD Visit → Triage → Re-Triage → Re-Triage → ...`
- Dalam kondisi normal, penentuan ATS wajib diturunkan secara objektif dari hasil assessment ABC dan GCS (`ABC + GCS → ATS`).
- Mekanisme override hanya berlaku untuk penetapan **ATS Hitam** pada kondisi klinis tertentu. Tidak ada mekanisme override untuk kategori prioritas ATS selain Hitam.
- Apabila satu IGD Visit memiliki lebih dari satu Triage, maka Triage terakhir menjadi acuan kondisi dan prioritas pasien terkini dalam IGD Visit.
- Setelah IGD Visit ditutup, tidak dapat dilakukan Triage/Re-Triage baru pada IGD Visit tersebut.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Terdapat rekaman assessment Triage yang menautkan referensi IGD Visit, identitas tenaga medis penilai, waktu penilaian, rincian ABC, rincian GCS, dan hasil klasifikasi ATS.
- Jika berlaku mekanisme override, tercatat penetapan hasil ATS Hitam beserta penanda override klinis.
- Catatan assessment tersimpan permanen dalam riwayat kunjungan pasien dan Triage terakhir menjadi acuan kondisi dan prioritas pasien terkini dalam IGD Visit.

---

## 6. Outcome Boundary

### Start

Dimulai ketika tenaga medis yang bertugas di IGD (perawat IGD atau dokter jaga IGD) mulai melakukan penilaian kondisi triage pertama terhadap pasien yang datang ke IGD dalam konteks episode kunjungan IGD (`IGD Visit`).

### End

Selesai ketika penilaian komponen ABC dan GCS telah dilakukan, dan hasil klasifikasi prioritas penanganan (ATS normal atau penetapan override ATS Hitam) telah ditetapkan oleh tenaga medis yang bertugas.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Ketergantungan Konteks Episode**: Triage tidak dapat berdiri sendiri tanpa adanya episode IGD Visit yang sah dan aktif. IGD Visit menjadi konteks dan batas tempat Triage berlangsung.
- **Pemisahan Konsep Domain**:
  - `IGD Visit` adalah konteks/episode pasien mendapatkan pelayanan di IGD.
  - `Triage` adalah assessment kondisi dan penentuan prioritas pasien dalam episode tersebut.
  - `Re-Triage` adalah pengulangan assessment Triage dalam IGD Visit yang sama (bukan Outcome terpisah).
  - `ATS` adalah hasil klasifikasi tingkat kegawatan/prioritas dari Triage.
  - `ATS Hitam Override` adalah pengecualian bisnis khusus yang memungkinkan petugas menetapkan ATS Hitam berdasarkan kondisi klinis tertentu.
- **Independensi Lifecycle Terhadap Penutupan Kunjungan**: Penutupan episode IGD Visit bukan merupakan bagian dari proses penyelesaian satu Triage. Triage tidak menentukan pembukaan maupun penutupan IGD Visit.
- **Larangan Triage Setelah Episode Ditutup**: Setelah IGD Visit ditutup, tidak dapat dilakukan Triage/Re-Triage baru pada IGD Visit tersebut.
- **Integritas Riwayat Penilaian (Immutability)**: Setiap Triage dan Re-Triage harus dipertahankan sebagai histori assessment. Assessment sebelumnya tidak boleh dihapus atau ditimpa oleh Re-Triage.
- **Acuan Prioritas Terkini**: Apabila satu IGD Visit memiliki lebih dari satu Triage, maka Triage terakhir menjadi acuan kondisi dan prioritas pasien terkini dalam IGD Visit.
- **Aturan Formula ATS Normal**: Dalam kondisi normal, klasifikasi ATS wajib diturunkan secara langsung dari penilaian ABC dan GCS (`ABC + GCS → ATS`). Tidak boleh mendefinisikan kondisi klinis lain sebagai faktor umum dalam perhitungan ATS normal.
- **Restriksi Ketat Override**: Mekanisme override hanya berlaku secara khusus untuk penetapan **ATS Hitam**. Tidak diizinkan membuat mekanisme override untuk kategori ATS lainnya.
- **Bebas Pembatasan Tunggal Profesi Aktor**: Triage dilakukan oleh tenaga medis yang sedang ditempatkan atau bertugas di IGD pada saat assessment dilakukan (dapat berupa perawat IGD atau dokter jaga IGD, tanpa membatasi outcome hanya kepada salah satu profesi tersebut).
- **Kebebasan dari Prasyarat Identitas Definitif Pasien**: Ketiadaan identitas resmi pasien (No. RM) tidak boleh menghalangi pelaksanaan Triage; Triage dapat dilakukan pada episode IGD Visit yang menggunakan identitas sementara.

---

## 8. Business Exceptions

> Conditions under which the Outcome is established or handled under abnormal circumstances.

| Exception | Expected Behavior |
|---|---|
| Pasien tiba di IGD dengan kondisi klinis tertentu yang memungkinkan penetapan ATS Hitam | Petugas IGD yang bertugas dapat melakukan **override** terhadap formula triage normal dan menetapkan hasil **ATS Hitam**. |
| Kondisi pasien mengalami perburukan atau perbaikan klinis saat menunggu penanganan atau selama berada di IGD | Tenaga medis IGD melakukan **Re-Triage**. Penilaian baru dicatat sebagai assessment lanjutan tanpa menimpa assessment sebelumnya. Triage terakhir menjadi acuan kondisi dan prioritas pasien terkini dalam IGD Visit. |
| Pasien datang tanpa identitas dan tidak sadar (Mr./Mrs. X) | Triage tetap dilaksanakan dan dicatat mengacu pada episode IGD Visit sementara pasien, memastikan prioritas penanganan medis darurat segera terdefinisi tanpa menunggu identifikasi data sosial. |
| Terjadi kekeliruan pencatatan data assessment Triage | Koreksi tidak boleh dilakukan dengan menghapus atau menimpa catatan yang keliru. Petugas berwenang mencatat assessment baru (Re-Triage) atau melakukan anotasi koreksi administratif sesuai tata kelola audit klinis yang sah. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Assessment Triage awal berhasil dicatat dalam konteks episode IGD Visit aktif saat pasien tiba di IGD. | Completeness |
| AC-02 | Catatan Triage mencatat evaluasi lengkap komponen ABC (*Airway*, *Breathing*, *Circulation*) dan GCS (*Eye*, *Verbal*, *Motor*). | Completeness |
| AC-03 | Dalam kondisi normal, hasil klasifikasi kegawatan/prioritas pasien (ATS) ditentukan berdasarkan kombinasi hasil assessment ABC dan GCS. | Correctness |
| AC-04 | Pada kondisi klinis tertentu yang memungkinkan penetapan ATS Hitam, petugas IGD dapat menetapkan hasil ATS Hitam melalui mekanisme override. | Correctness |
| AC-05 | Mekanisme override tidak dapat digunakan untuk menetapkan klasifikasi prioritas selain ATS Hitam. | Constraint |
| AC-06 | Catatan Triage dapat mencatat dokter jaga IGD maupun perawat IGD yang bertugas sebagai tenaga medis pelaksana assessment. | Constraint |
| AC-07 | Re-Triage dapat dicatat berulang kali selama episode IGD Visit berlangsung tanpa menghapus atau menimpa data Triage/Re-Triage sebelumnya. | Constraint |
| AC-08 | Apabila terdapat lebih dari satu catatan Triage pada satu episode IGD Visit, Triage terakhir menjadi acuan kondisi dan prioritas pasien terkini dalam IGD Visit. | Correctness |
| AC-09 | Seluruh riwayat penilaian Triage dan Re-Triage dapat ditelusuri secara kronologis dalam episode IGD Visit. | Completeness |
| AC-10 | Triage dapat dicatat pada episode IGD Visit yang dibuka dengan identitas pengunjung sementara tanpa mensyaratkan ketersediaan No. RM definitif terlebih dahulu. | Exception |
| AC-11 | Setelah IGD Visit ditutup, tidak ada Triage/Re-Triage baru yang dapat dilakukan pada IGD Visit tersebut. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembukaan episode kunjungan IGD, penutupan episode, dan penetapan disposisi kelanjutan pelayanan (Pulang, Rawat Inap, Rawat Jalan) → Diatur dalam **OC-07-01 IGD Visit** (`IGD-VISIT`).
- Pelaksanaan tindakan medis, resusitasi darurat, dan pencatatan tindakan klinis yang dilakukan berdasarkan prioritas triage → Diatur dalam **OC-07-04 Tindakan** (`IGD-TINDAKAN`).
- Dokumentasi klinis mendalam, catatan perkembangan pasien terintegrasi (CPPT), anamnesis dokter, dan rekam medis elektronik → Dikelola oleh **Domain EMR / Rekam Medis Elektronik**.
- Pencatatan pemakaian obat darurat, alkes, dan cairan habis pakai selama penanganan di IGD → Diatur dalam **OC-07-05 Pakai Barang** (`INV-PAKAI`).
- Pelayanan transportasi ambulans untuk penjemputan/rujukan gawat darurat → Diatur dalam **OC-07-03 Ambulance** (`IGD-AMBULANCE`).
- Daftar spesifik kondisi klinis yang memungkinkan penetapan override ATS Hitam → Belum ditetapkan dalam domain ini; menjadi kewenangan komite medis/kebijakan klinis rumah sakit.
- Detail implementasi teknis, formula komputasi kode sumber, skema tabel basis data, kontrak API, atau tata letak antarmuka (UI/UX) Triage → Menjadi domain Arsitektur dan Implementasi Teknis.
