# OUTCOME: Rujuk Internal Rawat Jalan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-03     |
| Version     | 1.3          |
| Status      | Review       |
| LastUpdated | 2026-10-05   |

---

## 1. Business Purpose

Dalam proses pelayanan rawat jalan, pasien dapat memerlukan konsultasi spesialistik lanjutan atau penanganan medis tambahan oleh dokter lain di dalam fasilitas rumah sakit yang sama pada hari pelayanan yang sama (*same-day*) dalam satu episode kunjungan (*same-Visit*).

**Rujuk Internal** adalah mekanisme pengalihan pelayanan medis pasien dari dokter asal ke dokter tujuan lain di rumah sakit yang sama. Pencatatan dilakukan oleh dokter pemeriksa asal atau petugas poliklinik terotorisasi berdasarkan keputusan klinis dokter. Outcome ini menjamin kesinambungan pelayanan medis (*continuity of care*) tanpa membebani pasien melakukan registrasi ulang di loket pendaftaran (Admission) maupun membuat nomor kunjungan baru.

Terbitnya rujukan internal sebagai *persisted business fact* secara otomatis menyelesaikan pelayanan pada *Origin Service Context* dan langsung memicu permintaan pembentukan antrean (*Destination Queue*) pada unit tujuan tanpa memerlukan tahapan persetujuan (*approval-free*). Rujuk Internal secara tegas dibedakan dari Rujuk Eksternal (pengalihan ke fasilitas pelayanan kesehatan di luar rumah sakit).

---

## 2. Outcome Statement

Pelayanan pasien pada *Origin Service Context* **telah diselesaikan dan dialihkan ke *Destination Service Context* dalam satu *Visit* yang sama pada hari yang sama (*same-day*), dengan permintaan pembentukan *Destination Queue* lanjutan langsung dipicu dan dipersistensikan bersama indikasi rujukan klinis, siap dikelola oleh kapabilitas Antrian Rawat Jalan pada tujuan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Jalan | **Pemilik utama outcome**: mencatat rujukan internal (`RJL-TRANSFER`), menyelesaikan *origin service context*, serta mengelola antrean lanjutan pada poliklinik tujuan (`RJL-ANTRIAN`). |
| Admission | Memelihara keutuhan dan siklus hidup *Visit* aktif pasien, memastikan *Visit* tidak dibuat ulang atau ditutup saat terjadi rujukan internal (`ADM-REG`, `ADM-TRACKER`). |
| Organisasi | Menyediakan master unit layanan poliklinik (`ORG-LAYANAN`), master dokter pemeriksa (`ORG-PPA`), dan jadwal praktik aktif dokter tujuan (`ORG-JADWAL`). |
| Pasien | Menyediakan data identitas sah pasien (Nomor RM dan data sosial) yang menjadi subjek rujukan (`PAS-DATSOS`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `RJL-TRANSFER` Rujukan Internal | Rawat Jalan | Known |
| `RJL-ANTRIAN` Antrian Poli | Rawat Jalan | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ORG-JADWAL` Jadwal Praktek Dokter | Organisasi | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Keutuhan Visit & Batasan Same-Day:** Rujuk Internal menghubungkan Origin Service Context dan Destination Service Context dalam wadah satu *Visit* yang sama pada hari kalender yang sama (*same-day*). Tidak ada *Visit* baru yang dibuat dan status *Visit* tidak ditutup.
- **Penyelesaian Otomatis Origin Context:** Persistensi rujukan internal secara otomatis menyelesaikan pelayanan klinis dan antrean pada *Origin Service Context*.
- **Pemicuan Destination Queue (Zero Approval):** Rujukan internal langsung memicu pembentukan antrean lanjutan (*Destination Queue*) pada poliklinik tujuan ke kapabilitas `RJL-ANTRIAN` tanpa memerlukan konfirmasi atau *approval* dari unit tujuan.
- **Karakteristik Antrean Reguler:** Antrean di destination merupakan antrean reguler (tidak mendapat hak loncatan antrean/prioritas khusus otomatis) dengan nomor antrean diterbitkan oleh `RJL-ANTRIAN`, dilengkapi penanda sumber *Rujuk Internal*, poliklinik asal, dokter asal, dan alasan klinis rujukan.
- **Pemisahan Pengawasan (Decoupled Visibility):** Pengguna di unit asal hanya mengetahui fakta bahwa rujukan telah dialihkan ke dokter/poli tujuan, tanpa memantau atau mengelola progres antrean di unit tujuan.
- **Diferensiasi Dokter & Singularitas:** Dokter tujuan wajib berbeda dari dokter asal (meski di poliklinik yang sama). Dalam satu *Visit*, hanya diperbolehkan satu rujukan internal aktif yang sedang berjalan pada satu waktu.

### 5.2 Required Recorded Information

**Identitas Visit & Rujukan:**
- Nomor Registrasi Kunjungan (*Visit ID*) yang aktif.
- Nomor referensi transaksi unik Rujuk Internal.
- Nomor Rekam Medis (No. RM) dan nama pasien.
- Tanggal dan waktu pencatatan rujukan internal.
- Identitas pencatat (dokter pemeriksa asal atau petugas poliklinik terotorisasi).

**Konteks Layanan Asal (Origin):**
- Poliklinik asal (kode dan nama unit layanan rawat jalan asal).
- Dokter pemeriksa asal (kode dan nama dokter asal / DPJP).

**Konteks Layanan Tujuan (Destination):**
- Poliklinik tujuan (kode dan nama unit layanan rawat jalan tujuan).
- Dokter tujuan (kode dan nama dokter tujuan yang valid).
- Sesi praktik / jadwal layanan dokter tujuan pada hari yang sama.

**Konteks Klinis & Pemicuan Antrean:**
- Alasan / indikasi klinis rujukan internal (catatan wajib dokter asal).
- Referensi pemicuan antrean tujuan: penanda sumber *Rujuk Internal* dan status pemicuan antrean ke `RJL-ANTRIAN`.

### 5.3 Required Business Conditions

- Kunjungan rawat jalan pasien berstatus aktif (**Terdaftar**) dan berada pada tanggal pelayanan yang sama (*same-day*).
- Keputusan rujukan ditetapkan oleh dokter pemeriksa yang sedang menangani pasien; pencatatan dilakukan oleh dokter asal atau petugas poli yang terotorisasi.
- Poliklinik tujuan dan dokter tujuan wajib dipilih secara eksplisit; dokter tujuan wajib berbeda dari dokter asal.
- Dokter tujuan wajib memiliki jadwal praktik aktif pada hari yang sama (`ORG-JADWAL`). Aturan ketersediaan kuota mengikuti konfigurasi SOP rumah sakit pada `ORG-JADWAL` dan `RJL-ANTRIAN` (penolakan saat kuota penuh atau penerbitan antrean *over-quota*).
- Tidak ada rujukan internal lain yang sedang aktif berjalan dalam *Visit* yang sama.
- Setelah validasi berhasil, pembentukan antrean tujuan dipicu langsung tanpa tahapan *approval* dari dokter/petugas tujuan.

### 5.4 Completion Proof

- Transaksi Rujuk Internal tersimpan secara persisten dengan nomor referensi unik terhubung ke *Visit* aktif dan data pasien.
- Pelayanan dan status antrean pada *Origin Service Context* tercatat berstatus **Selesai**.
- Permintaan antrean lanjutan pada *Destination Service Context* berhasil dipicu dan nomor antrean diterbitkan oleh `RJL-ANTRIAN`.
- Antrean pada unit tujuan menampilkan penanda sumber *Rujuk Internal*, poliklinik asal, dokter asal, dan alasan rujukan.
- *Visit* pasien tetap berstatus aktif (tidak ditutup oleh proses rujukan internal).

---

## 6. Outcome Boundary

### Start

Dimulai ketika dokter pemeriksa asal memutuskan perlunya rujukan internal dan dokter atau petugas poliklinik terotorisasi menginisiasi pencatatan rujukan dengan menentukan poliklinik tujuan, dokter tujuan berjadwal aktif pada hari yang sama, serta alasan/indikasi klinis rujukan.

### End

Berakhir ketika transaksi Rujuk Internal tersimpan secara persisten, pelayanan pada *Origin Service Context* (dan antrean asal) tercatat selesai, serta permintaan antrean lanjutan pada *Destination Service Context* telah berhasil dipicu ke `RJL-ANTRIAN`.

> **Batasan Penting:** Terbitnya Rujuk Internal **TIDAK** menyelesaikan Kunjungan (*Visit*) pasien. *Visit* tetap aktif di bawah domain Admission untuk melanjutkan pelayanan di unit tujuan.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Batasan Same-Day dan Same-Visit:** Rujuk Internal hanya berlaku pada hari kalender yang sama dan dalam satu *Visit* yang sama. Pengalihan layanan ke hari berikutnya wajib melalui mekanisme Booking Kunjungan (`OC-01-01`).
- **Integritas Identitas Visit:** Dilarang membuat registrasi kunjungan baru atau mengganti *Visit ID* untuk proses rujukan internal; episode kunjungan tetap tunggal di bawah domain Admission (`ADM-REG`).
- **Larangan Penutupan Visit oleh Rujukan:** Penyelesaian pelayanan pada *Origin Service Context* tidak boleh mengubah status *Visit* menjadi selesai. Penutupan *Visit* merupakan wewenang domain Admission / Reg-Out (`OC-02-04`).
- **Diferensiasi Wajib Dokter:** Dokter tujuan wajib berbeda dari dokter asal. Pengalihan ke dokter yang sama (meski beda poli atau beda jam) bukan merupakan rujukan internal.
- **Kedaulatan Antrean pada RJL-ANTRIAN:** Rujuk Internal hanya memicu pembentukan antrean lanjutan. Penerbitan nomor antrean, pemanggilan, dan tata kelola antrean di destination dikelola sepenuhnya oleh kapabilitas Antrian Rawat Jalan (`OC-05-01`).
- **Perilaku Antrean Reguler (Tanpa Prioritas Otomatis):** Antrean rujukan internal mengikuti antrean reguler tujuan dan tidak memperoleh prioritas loncatan antrean otomatis.
- **Tanpa Mekanisme Persetujuan (Approval-Free):** Unit tujuan tidak memiliki langkah *approval* untuk menolak atau menerima rujukan; antrean langsung dipicu setelah data rujukan tervalidasi.
- **Pemisahan Pengawasan Antrean (Decoupled Visibility):** Petugas/dokter di unit asal tidak menampilkan atau mengelola progres antrean di unit tujuan (*Menunggu*, *Dipanggil*, *Dalam Pelayanan*).
- **Singularitas Rujukan Aktif:** Satu *Visit* dilarang memiliki lebih dari satu rujukan internal yang aktif berjalan bersamaan. Rujukan berikutnya hanya dapat dibuat setelah rujukan sebelumnya selesai dilayani.
- **Imutabilitas Operasional Reguler:** Transaksi Rujuk Internal yang telah tersimpan tidak dapat dibatalkan atau diubah melalui antarmuka operasional reguler rawat jalan. Koreksi administratif dilakukan melalui wewenang supervisor/back-office.
- **Delegasi Penanganan Dokter Berhalangan:** Apabila dokter tujuan berhalangan hadir mendadak setelah antrean terbentuk di destination, transaksi rujukan tetap sah; penyesuaian operasional antrean didelegasikan ke tata kelola Antrian Rawat Jalan (`OC-05-01`).
- **Pemisahan Klinis & Finansial:** Outcome ini tidak mentransfer dokumen rekam medis (EMR) secara otomatis dan tidak membentuk transaksi tagihan (*billing*) tersendiri saat rujukan diterbitkan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or encounters an exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Dokter tujuan yang dipilih identik dengan dokter asal | Rujuk Internal ditolak. Pengguna diwajibkan memilih dokter tujuan yang berbeda. |
| Dokter tujuan tidak memiliki jadwal praktik aktif pada hari yang sama | Rujuk Internal ditolak. Pengguna diminta memilih dokter tujuan lain yang memiliki jadwal aktif. |
| Kuota pelayanan dokter tujuan telah penuh | Perilaku mengikuti konfigurasi SOP rumah sakit: rujukan ditolak atau diterbitkan antrean *over-quota* sesuai aturan `ORG-JADWAL` / `RJL-ANTRIAN`. |
| Alasan / indikasi klinis rujukan tidak diisi | Rujuk Internal ditolak. Alasan rujukan bersifat wajib sebagai konteks klinis bagi dokter tujuan. |
| Masih terdapat rujukan internal lain yang sedang aktif berjalan pada *Visit* tersebut | Rujuk Internal ditolak. Pasien harus menyelesaikan pelayanan pada rujukan sebelumnya terlebih dahulu. |
| Kunjungan (*Visit*) pasien tidak berstatus aktif atau sudah berstatus keluar/tutup | Rujuk Internal ditolak. Rujuk internal hanya sah pada kunjungan yang sedang aktif berjalan. |
| Tanggal rujukan berbeda dengan tanggal kalender *Visit* (*bukan same-day*) | Rujuk Internal ditolak. Pengalihan ke hari lain diarahkan ke alur Booking Kunjungan (`OC-01-01`). |
| Upaya pembatalan atau perubahan rujukan melalui antarmuka operasional reguler rawat jalan | Sistem menolak aksi pembatalan/perubahan. Koreksi diarahkan melalui prosedur supervisor/back-office. |
| Dokter tujuan berhalangan hadir mendadak setelah antrean terbentuk di destination | Rujuk Internal yang sudah tercatat tetap sah; tata kelola antrean didelegasikan ke kapabilitas Antrian Rawat Jalan (`OC-05-01`). |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Rujuk Internal berhasil dicatat dengan menghubungkan Visit aktif, poliklinik asal, dokter asal, poliklinik tujuan, dokter tujuan berjadwal aktif, serta alasan klinis rujukan. | Completeness |
| AC-02 | Nomor Registrasi Kunjungan (*Visit ID*) pasien tetap sama dan tidak dibuat ulang selama maupun setelah proses rujukan internal berlangsung. | Constraint |
| AC-03 | Pelayanan klinis dan status antrean pada *Origin Service Context* otomatis berubah menjadi **Selesai** saat rujukan internal berhasil dipersistensikan. | Correctness |
| AC-04 | Permintaan antrean lanjutan pada *Destination Service Context* langsung dipicu ke `RJL-ANTRIAN` secara otomatis tanpa memerlukan tahapan persetujuan (*approval*) dari pihak tujuan. | Completeness |
| AC-05 | Antrean pada destination memperoleh nomor antrean reguler yang diterbitkan oleh `RJL-ANTRIAN` dan tidak memperoleh prioritas pemanggilan khusus. | Constraint |
| AC-06 | Antrean pasien pada unit tujuan memuat penanda sumber *Rujuk Internal*, poliklinik asal, nama dokter asal, dan alasan rujukan klinis. | Completeness |
| AC-07 | Pengguna pada unit asal hanya dapat melihat status bahwa pasien telah dirujuk ke poliklinik dan dokter tujuan, serta tidak dapat melihat atau mengelola status progres antrean di unit tujuan. | Constraint |
| AC-08 | Sistem menolak pembuatan Rujuk Internal apabila dokter tujuan yang dipilih sama dengan dokter pemeriksa asal. | Constraint |
| AC-09 | Sistem menolak pembuatan Rujuk Internal apabila dokter tujuan tidak memiliki jadwal praktik aktif pada hari yang sama. | Exception |
| AC-10 | Sistem menolak pembuatan Rujuk Internal apabila alasan/indikasi rujukan klinis tidak diisi. | Constraint |
| AC-11 | Sistem menolak pembuatan Rujuk Internal baru jika masih terdapat rujukan internal lain yang sedang berjalan dalam *Visit* yang sama. | Constraint |
| AC-12 | Rujukan internal lanjutan dapat dibuat secara sah setelah pelayanan pada dokter tujuan rujukan sebelumnya telah diselesaikan. | Correctness |
| AC-13 | Sistem menolak pembatalan atau perubahan Rujuk Internal melalui antarmuka operasional reguler rawat jalan. | Constraint |
| AC-14 | Sistem menolak pembuatan Rujuk Internal jika tanggal pelayanan yang dituju berbeda dengan tanggal kalender *Visit* (*bukan same-day*). | Exception |
| AC-15 | Ketika kuota dokter tujuan penuh, penanganan sistem mengikuti konfigurasi SOP rumah sakit (penolakan atau penerbitan antrean *over-quota*). | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Penutupan dan Lifecycle Kunjungan (Visit):** Penentuan kapan *Visit* selesai secara keseluruhan serta finalisasi administrasi kepulangan → **OC-02-04 Reg-Out** (`ADM-REG`, `TRK-BILLING`).
- **Penerbitan Nomor Antrean & Pengelolaan Antrean di Destination:** Pengaturan nomor urut, urutan pemanggilan, *skip*, *recall*, dan penyelesaian antrean pada poliklinik tujuan → **OC-05-01 Antrian Rawat Jalan** (`RJL-ANTRIAN`).
- **Rujukan Eksternal:** Pengalihan dan transfer pasien ke fasilitas pelayanan kesehatan di luar rumah sakit → Alur/Outcome Rujukan Eksternal.
- **Booking Kunjungan Antar-Hari:** Penjadwalan pelayanan ke dokter/poliklinik untuk hari kalender berikutnya atau tanggal mendatang → **OC-01-01 Booking** (`ADM-BOOKING`).
- **Pelayanan Klinis & Tindakan Medis:** Pemeriksaan fisik, konsultasi dokter, serta pencatatan tindakan/intervensi klinis di ruang periksa → **OC-05-02 Tindakan Rawat Jalan** (`RJL-TINDAKAN`, `RJL-KONSUL`).
- **Konfigurasi Jadwal & Kuota Layanan:** Penyusunan jadwal dokter, kapasitas kuota per sesi, dan manajemen dokter pengganti → **OC-01-06 Jadwal Praktek** (`ORG-JADWAL`).
- **Dokumentasi Klinis Elektronik (EMR):** Pembuatan surat rujukan medis detail, resume medis, transfer resume SOAP, dan CPPT → Domain Rekam Medis / EMR.
- **Tarif, Penagihan, dan Asuransi/BPJS:** Penghitungan biaya konsultasi rujukan, rincian billing, penjaminan multi-poli, dan update SEP BPJS → **OC-02-01 Rincian Tagihan Pasien** (`TRK-BILLING`, `TRK-JAMINAN`) dan BPJS Domain (`BPJ-VCLAIM`).
- **Koreksi Administratif Supervisor:** Prosedur koreksi kesalahan rujukan atau pembatalan darurat melalui jalur back-office.
