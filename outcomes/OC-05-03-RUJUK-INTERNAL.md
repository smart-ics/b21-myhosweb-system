# OUTCOME: Rujuk Internal Rawat Jalan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-05-03     |
| Version     | 1.2          |
| Status      | Review       |
| LastUpdated | 2026-10-05   |

---

## 1. Business Purpose

Dalam proses pelayanan rawat jalan, berdasarkan evaluasi dan keputusan klinis dokter pemeriksa asal, pasien dapat ditentukan memerlukan pemeriksaan lanjutan, konsultasi spesialistik, atau penanganan medis tambahan oleh dokter lain di dalam fasilitas rumah sakit yang sama pada hari pelayanan yang bersangkutan.

**Rujuk Internal** adalah proses pengalihan pelayanan pasien dari dokter asal ke dokter tujuan dalam satu fasilitas rumah sakit, pada hari yang sama (*same-day*), dan dalam satu Kunjungan (*same-Visit*) yang sama. Dokter tujuan dapat berada di poliklinik yang sama maupun poliklinik yang berbeda, namun dokter tujuan wajib berbeda dari dokter asal. Pencatatan rujukan internal ke dalam sistem dilakukan oleh dokter pemeriksa asal atau oleh petugas poliklinik yang memiliki otorisasi administratif berdasarkan keputusan klinis dokter tersebut.

Outcome ini menjamin kesinambungan pelayanan medis (*continuity of care*) secara mulus tanpa membebani pasien untuk melakukan registrasi ulang di loket pendaftaran/Admission atau membuat nomor kunjungan baru. Dengan dicatatnya Rujuk Internal, pelayanan pada *Origin Service Context* secara otomatis dinyatakan selesai dan permintaan pembentukan antrean (*Destination Queue*) pada destination langsung dipicu tanpa memerlukan tahapan persetujuan (*approval*) dari pihak tujuan.

Rujuk Internal secara tegas dibedakan dari **Rujuk Eksternal**. Rujuk Eksternal mengarahkan pasien ke fasilitas pelayanan kesehatan di luar rumah sakit, tidak membentuk antrean pelayanan internal, dan berada di luar lingkup kapabilitas ini.

---

## 2. Outcome Statement

Berdasarkan keputusan klinis dokter asal, pelayanan pasien pada *Origin Service Context* **telah diselesaikan dan Visit berpindah ke *Destination Service Context* dalam wadah satu *Visit* yang sama pada hari yang sama, dengan permintaan pembentukan *Destination Queue* lanjutan langsung dipicu dan dipersistensikan disertai alasan rujukan klinis, siap dikelola oleh capability Antrian Rawat Jalan pada destination**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Jalan | **Domain pemilik utama layanan rawat jalan**, yang menaungi dokter, poliklinik, service context, pelayanan, rujukan internal (`RJL-TRANSFER`), dan pengelolaan antrean rawat jalan (`RJL-ANTRIAN`). |
| Admission | Memelihara keutuhan dan lifecycle Visit pasien, termasuk memastikan Visit tidak dibuat ulang ketika terjadi Rujuk Internal. |
| Organisasi | Menyediakan referensi master poliklinik, data dokter, serta validasi jadwal praktik dokter tujuan. |
| Pasien | Menjadi subjek pelayanan dan rujukan internal. |

> Rawat Jalan merupakan domain besar yang menaungi capability pelayanan poli/dokter, Rujuk Internal, dan Antrian Rawat Jalan.
>
> Capability **Antrian Rawat Jalan** (`OC-05-01`) mengelola queue pada masing-masing destination. Queue dapat terbentuk melalui dua jalur:
>
> 1. Queue awal yang berasal dari proses registrasi kunjungan (Admission); dan
> 2. Queue lanjutan yang dipicu melalui Rujuk Internal.
>
> Dalam konteks OC-05-03, Rujuk Internal memicu permintaan pembentukan queue lanjutan pada destination. Penerbitan nomor antrean, pengelolaan siklus hidup, dan progres antrean selanjutnya dikelola secara penuh oleh capability Antrian Rawat Jalan pada destination sesuai batasan tata kelola `OC-05-01`.

---

## 4. Participating Capabilities

| Capability | Domain | Role in this Outcome |
|------------|--------|----------------------|
| `RJL-TRANSFER` Rujuk Internal | Rawat Jalan | Mencatat rujukan, menyelesaikan origin service context, memindahkan Visit ke destination service context, dan memicu pembentukan queue lanjutan. |
| `RJL-ANTRIAN` Antrian Rawat Jalan | Rawat Jalan | Menerbitkan nomor antrean dan mengelola lifecycle queue pada masing-masing destination sesuai tata kelola `OC-05-01`. |
| `ADM-REG` Registration | Admission | Membentuk Visit dan mengaitkan registrasi awal sesuai alur pendaftaran. |
| `ADM-TRACKER` Visit Lifecycle | Admission | Memelihara lifecycle Visit sampai Visit dinyatakan selesai oleh domain yang berwenang. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Menyediakan referensi poli/unit layanan asal dan tujuan. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Menyediakan referensi dokter asal dan dokter tujuan. |
| `ORG-JADWAL` Jadwal Praktik Dokter | Organisasi | Memvalidasi jadwal aktif dan aturan ketersediaan dokter tujuan. |

> **Status:** Seluruh capability di atas berstatus **Known**.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Rantai Relasi Semantik Domain:**

Rujuk Internal menghubungkan entitas domain melalui alur relasi berikut:

```text
Visit
  ├── Origin Service Context (Selesai)
  └── Destination Service Context (Aktif)
        └── Internal Referral (Fakta Transaksi)
              └── Destination Queue (Dikelola RJL-ANTRIAN)
```

---

**Keutuhan Visit, Service Context, dan Same-Day:**

- Pasien tetap berada dalam satu Visit yang sama.
- Rujuk Internal tidak membuat Visit baru dan tidak mengganti identitas Visit.
- Rujuk Internal hanya berlaku pada hari kalender pelayanan yang sama (*same-day*).
- Pembuatan Rujuk Internal menyelesaikan Origin Service Context dan Queue origin.
- Visit kemudian memiliki Destination Service Context dan Destination Queue.
- Penyelesaian Origin Service Context tidak berarti Visit selesai.
- Lifecycle Visit tetap aktif sampai Visit dinyatakan selesai oleh domain yang berwenang.
- OC-05-03 tidak mengelola keputusan akhir mengenai penyelesaian Visit.

> OC-05-03 hanya mengelola perpindahan Service Context dan pemicuan pembentukan Queue destination. Keputusan mengenai kapan Visit secara keseluruhan selesai berada di luar scope capability ini dan mengikuti lifecycle Visit yang dikelola oleh domain lain.

---

**Pembentukan dan Ownership Destination Queue:**

- Rujuk Internal memicu pembentukan Destination Queue secara langsung setelah validasi tujuan berhasil.
- Destination Queue merupakan queue lanjutan dalam domain Rawat Jalan.
- Penerbitan nomor antrean dan tata kelola antrean dilakukan oleh capability Antrian Rawat Jalan pada destination sesuai ketentuan `OC-05-01`.
- Destination dapat berupa poli/dokter yang memiliki queue awal dari Admission atau queue lanjutan dari Rujuk Internal.
- Queue tujuan menggunakan aturan queue reguler destination.
- Rujuk Internal tidak membuat capability queue baru dan tidak mengambil alih lifecycle queue destination.
- Origin hanya memperoleh informasi bahwa Visit telah dirujuk ke destination.
- Origin tidak melihat atau mengelola progres queue destination.

> Destination Queue yang terbentuk melalui Rujuk Internal tetap merupakan bagian dari Antrian Rawat Jalan. Perbedaannya hanya pada sumber pembentukannya: queue awal berasal dari Admission, sedangkan queue lanjutan berasal dari Rujuk Internal.

---

**Karakteristik Destination Queue (Reguler Tanpa Prioritas):**

- Pasien rujukan internal tidak memperoleh hak istimewa loncatan nomor antrean atau prioritas panggilan khusus semata-mata karena berasal dari Rujuk Internal.

**Identifikasi Rujukan pada Destination Queue:**

- Antrean pada destination menampilkan penanda sumber **Rujuk Internal**.
- Antrean menyertakan konteks asal rujukan: poliklinik asal, dokter asal, dan alasan/indikasi klinis rujukan.

**Pemisahan Visibilitas dan Tanggung Jawab (*Decoupled Visibility*):**

- Unit asal (*origin*) hanya memiliki visibilitas bahwa Visit pasien telah dialihkan ke poliklinik dan dokter tujuan tertentu.
- Unit asal tidak menampilkan, memantau, atau mengelola status progres queue di destination (seperti status menunggu, dipanggil, atau dalam pelayanan).
- Pengelolaan progres queue sepenuhnya merupakan tanggung jawab dan wewenang capability Antrian Rawat Jalan pada *Destination Service Context*.

**Singularitas Rujukan Berjalan:**

- Dalam satu Visit, hanya diperbolehkan terdapat maksimal **satu** Rujuk Internal yang sedang berjalan pada satu waktu.
- Rujukan internal lanjutan hanya dapat dibuat setelah pelayanan di *Destination Service Context* sebelumnya telah diselesaikan secara sah.

---

### 5.2 Required Recorded Information

**Identitas dan Lifecycle Visit:**

- Visit ID atau nomor registrasi tetap sama dan tidak berubah.
- Origin Service Context dicatat sebagai context asal.
- Destination Service Context dicatat sebagai context tujuan.
- Status lifecycle Visit tidak diselesaikan oleh OC-05-03.
- Perubahan status Visit mengikuti domain pemilik lifecycle Visit.

**Konteks Layanan Asal (Origin Service Context):**

- Poliklinik asal (kode dan nama unit layanan rawat jalan asal).
- Dokter pemeriksa asal (kode dan nama dokter asal / DPJP yang menetapkan rujukan).
- Waktu pencatatan rujukan internal (tanggal dan jam pencatatan).
- Identitas pembuat entri (dokter asal atau petugas poliklinik berwenang yang mencatat atas instruksi dokter).

**Konteks Layanan Tujuan (Destination Service Context):**

- Poliklinik tujuan (kode dan nama unit layanan rawat jalan tujuan).
- Dokter tujuan (kode dan nama dokter tujuan yang wajib dipilih).
- Sesi praktik / jadwal layanan dokter tujuan pada hari yang sama.

**Konteks Klinis Rujukan:**

- Alasan / indikasi rujukan internal (catatan indikasi medis wajib dari dokter pemeriksa asal).
- *Catatan:* Ringkasan pelayanan asal (*service summary*) tidak ditransfer secara otomatis oleh capability ini; akses rekam medis historis mengikuti otorisasi domain rekam medis/EMR.

**Destination Queue:**

- Queue tujuan terbentuk sebagai queue reguler pada destination dengan nomor antrean diterbitkan oleh `RJL-ANTRIAN`.
- Queue memiliki penanda sumber **Rujuk Internal**.
- Queue menyimpan referensi terhadap Visit dan transaksi Rujuk Internal.
- Queue dikelola penuh oleh capability Antrian Rawat Jalan pada destination.
- Status progres queue tidak menjadi status yang dikelola oleh origin.

**Record Transaksi Rujukan Internal:**

- Nomor referensi transaksi unik Rujuk Internal.
- Berfungsi sebagai fakta bisnis pemindahan konteks layanan yang menghubungkan Origin Service Context dan Destination Service Context (tidak memelihara siklus status independen; progres pelayanan direfleksikan langsung oleh Destination Queue dan Visit).

---

### 5.3 Required Business Conditions

- **Kewenangan Penetapan dan Pencatatan:** Keputusan rujukan internal wajib ditetapkan oleh dokter pemeriksa yang sedang menangani pasien di unit asal. Pencatatan ke dalam sistem dapat dilakukan oleh dokter pemeriksa bersangkutan atau petugas poliklinik yang memiliki hak otorisasi aktif berdasarkan instruksi dokter.
- **Keabsahan Visit Berjalan:** Visit pasien berstatus aktif (**Terdaftar**) dan berada dalam hari kalender pelayanan yang sama dengan hari pembuatan rujukan (*same-day*).
- **Kewajiban Pemilihan Tujuan:** Poliklinik tujuan dan dokter tujuan wajib dipilih secara eksplisit. Sistem tidak mengizinkan penerbitan rujukan internal tanpa dokter tujuan yang definitif.
- **Diferensiasi Dokter:** Dokter tujuan wajib berbeda dari dokter pemeriksa asal. Rujukan internal ke dokter yang sama ditolak, meskipun dipilih pada poliklinik yang berbeda atau sesi yang berbeda.

**Validasi Jadwal dan Kuota Destination:**

- Dokter tujuan wajib memiliki jadwal praktik yang aktif dan valid pada hari pelayanan yang sama (`ORG-JADWAL`).
- Ketersediaan kuota/slot pelayanan dokter tujuan mengikuti konfigurasi dan SOP rumah sakit:
  - Jika SOP rumah sakit mensyaratkan ketersediaan kuota sebelum rujukan dibuat, rujukan ditolak saat kuota dokter tujuan penuh;
  - Jika SOP rumah sakit mengizinkan penambahan antrean di atas kuota (*over-quota / antrean rujukan khusus*), rujukan dapat dilanjutkan dan antrean diterbitkan mengikuti tata kelola `RJL-ANTRIAN`.
- Dokumen formal merujuk pada aturan resmi `ORG-JADWAL` dan `RJL-ANTRIAN` sebagai sumber penetapan ketersediaan jadwal dan kuota.

> Jadwal dokter merupakan prasyarat wajib. Penanganan terhadap keterpenuhan kuota destination mengikuti konfigurasi SOP rumah sakit yang berlaku.

- **Ketiadaan Rujukan Aktif Lain:** Tidak ada rujukan internal lain yang sedang berjalan dalam Visit tersebut pada saat pembuatan.
- **Ketiadaan Langkah Persetujuan (Zero Approval):** Begitu validasi jadwal berhasil dan rujukan disimpan, sistem langsung memicu penerbitan queue di destination tanpa memerlukan konfirmasi, verifikasi, atau *approval* dari dokter/petugas di destination.

---

### 5.4 Completion Proof

Outcome ini dinyatakan terwujud secara tuntas (*established*) apabila seluruh bukti bisnis berikut terverifikasi:

1. Record transaksi Rujuk Internal tersimpan dan terhubung ke Visit yang sama.
2. Origin Service Context tercatat selesai.
3. Queue origin tercatat selesai sesuai aturan Antrian Rawat Jalan (`OC-05-01`).
4. Visit berpindah context ke Destination Service Context tanpa membuat Visit baru.
5. Destination Queue terbentuk sebagai queue lanjutan pada destination dengan nomor antrean diterbitkan sesuai aturan `RJL-ANTRIAN`.
6. Destination Queue memiliki status awal sesuai aturan Antrian Rawat Jalan.
7. Destination dapat mengenali sumber queue sebagai Rujuk Internal beserta nama dokter asal, poli asal, dan alasan rujukan.
8. Origin hanya mengetahui tujuan rujukan tanpa melihat progres queue destination.
9. Visit tetap aktif dan tidak dinyatakan selesai oleh OC-05-03.

> Completion of this outcome means that the service context transfer and destination queue creation have been completed. It does not mean that the overall Visit lifecycle has been completed.

---

## 6. Outcome Boundary

### Start

Outcome dimulai ketika dokter pemeriksa asal memutuskan perlunya rujukan internal dan dokter atau petugas poli yang berwenang menginisiasi pencatatan Rujuk Internal dengan memilih:

- poli tujuan;
- dokter tujuan;
- jadwal layanan yang valid;
- alasan/indikasi rujukan.

### End

Outcome berakhir ketika:

- Origin Service Context selesai;
- Queue origin selesai sesuai aturan queue;
- Visit berpindah ke Destination Service Context;
- Destination Queue terbentuk sebagai queue lanjutan (nomor antrean diterbitkan oleh `RJL-ANTRIAN`);
- Informasi sumber Rujuk Internal tersedia di destination;
- Origin mengetahui tujuan rujukan tanpa melihat progres queue destination.

> Penyelesaian outcome ini tidak menutup Visit. Visit tetap aktif sampai dinyatakan selesai oleh domain yang memiliki kewenangan terhadap lifecycle Visit.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

**Service Context Constraint:**

> Rujuk Internal hanya memindahkan pelayanan dari Origin Service Context ke Destination Service Context. Capability ini tidak mengambil alih lifecycle Visit secara keseluruhan.

**Queue Ownership Constraint:**

> Rujuk Internal memicu permintaan pembentukan queue lanjutan, sedangkan penerbitan nomor antrean dan tata kelola antrean di seluruh Rawat Jalan (baik queue awal maupun lanjutan) dikelola secara penuh oleh capability Antrian Rawat Jalan (`RJL-ANTRIAN` / `OC-05-01`).

**Visit Lifecycle Constraint:**

> Penyelesaian Origin Service Context dan Queue origin tidak boleh ditafsirkan sebagai penyelesaian Visit. Visit tetap aktif sampai domain pemilik lifecycle Visit menyatakan Visit selesai.

**Schedule and Quota Constraint:**

> Jadwal dokter tujuan wajib valid pada hari yang sama. Validasi kuota mengikuti SOP dan konfigurasi rumah sakit yang berlaku pada `ORG-JADWAL` dan `RJL-ANTRIAN`.

**Post-Referral Provider Absence Constraint:**

> Apabila dokter tujuan berhalangan hadir mendadak setelah antrean terbentuk di destination, rujukan internal yang telah tercatat tetap sah; tata kelola penyesuaian antrean (pengalihan atau pembatalan antrean) didelegasikan sepenuhnya ke capability Antrian Rawat Jalan (`OC-05-01`).

- **Batasan Same-Day dan Same-Visit:** Rujuk Internal hanya berlaku di dalam satu hari kalender pelayanan yang sama dan di dalam satu Visit yang sama. Rujukan untuk hari berikutnya bukan Rujuk Internal melainkan pembuatan janji temu/booking baru (`OC-01-01`).
- **Larangan Pembuatan Ulang Visit:** Dilarang membuat nomor registrasi/kunjungan baru untuk menampung rujukan internal. Kunjungan induk tetap tunggal untuk menjaga akuntabilitas episode rawat jalan.
- **Pembedaan Tegas Rujuk Internal vs Rujuk Eksternal:** Rujuk Internal hanya memindahkan pelayanan antar dokter di dalam fasilitas rumah sakit yang sama dan menghasilkan queue internal. Rujukan ke fasilitas kesehatan lain adalah Rujuk Eksternal dan dilarang diproses melalui alur ini.
- **Perilaku Queue Reguler (Tanpa Prioritas Otomatis):** Queue pada destination wajib mengikuti tata aturan queue reguler tujuan. Rujukan internal dilarang memberikan hak prioritas loncatan nomor queue otomatis di destination.
- **Tanpa Mekanisme Persetujuan (*Approval-Free*):** Destination tidak memiliki antarmuka *approval* untuk menolak rujukan. Selama jadwal dokter tujuan valid pada hari tersebut, rujukan langsung menginisiasi queue lanjutan.
- **Diferensiasi Wajib Dokter:** Dokter tujuan tidak boleh sama dengan dokter asal. Pengalihan pelayanan ke dokter yang sama pada jam berbeda dalam hari yang sama bukan merupakan rujukan internal.
- **Pemisahan Pengawasan Queue (*Decoupled Monitoring*):** Pengguna di unit asal dilarang memantau atau mengintervensi alur queue di destination. Unit asal hanya berhak mengetahui bahwa rujukan telah ditujukan ke unit dan dokter yang dipilih.
- **Imutabilitas Alur Operasional Reguler:** Rujuk Internal yang telah berhasil dipersistensikan tidak dapat dibatalkan, diubah, atau dihapus melalui alur kerja operasional reguler rawat jalan. Koreksi ditangani melalui wewenang supervisor/back-office di luar alur reguler.
- **Singularitas Rujukan Berjalan:** Satu Visit dilarang memiliki lebih dari satu rujukan internal yang aktif berjalan bersamaan.
- **Pemisahan Domain Klinis dan Finansial:** Capability ini tidak mentransfer dokumen rekam medis secara otomatis dan tidak memicu pembentukan transaksi billing/finansial tersendiri pada saat rujukan diterbitkan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or encounters an exception.

| Exception | Expected Behavior |
|-----------|-------------------|
| Dokter tujuan yang dipilih identik dengan dokter pemeriksa asal | Rujuk Internal ditolak. Pengguna diwajibkan memilih dokter tujuan yang berbeda. |
| Dokter tujuan tidak memiliki jadwal aktif pada hari yang sama | Rujuk Internal ditolak dan user diminta memilih dokter tujuan lain. |
| Kuota destination penuh | Perilaku mengikuti konfigurasi SOP rumah sakit: rujukan ditolak atau queue dibentuk sesuai aturan `ORG-JADWAL` / `RJL-ANTRIAN`. |
| Alasan atau indikasi rujukan internal tidak diisi | Rujuk Internal ditolak. Alasan rujukan bersifat wajib sebagai konteks klinis minimum bagi dokter tujuan. |
| Masih terdapat rujukan internal lain yang sedang berjalan pada Visit tersebut | Rujuk Internal ditolak. Pasien harus menyelesaikan pelayanan pada rujukan sebelumnya terlebih dahulu. |
| Visit pasien telah ditutup (Reg-Out) atau tidak berstatus aktif | Rujuk Internal ditolak. Rujuk Internal hanya sah dilakukan pada kunjungan yang sedang aktif berjalan. |
| Tanggal rujukan berbeda dengan tanggal kalender Visit (*bukan same-day*) | Rujuk Internal ditolak. Pengalihan layanan ke hari yang berbeda harus diarahkan ke alur Booking Kunjungan (`OC-01-01`). |
| Origin Service Context selesai | Visit tetap aktif dan berpindah ke Destination Service Context. |
| Visit belum selesai | OC-05-03 tidak boleh menutup Visit; lifecycle dilanjutkan oleh domain pemilik Visit. |
| Upaya pembatalan atau perubahan rujukan melalui alur operasional reguler rawat jalan | Sistem menolak aksi tersebut. Pengguna diarahkan untuk menghubungi supervisor/administrasi back-office jika memerlukan koreksi. |
| Dokter tujuan berhalangan hadir mendadak setelah queue terbentuk di destination | Rujuk Internal yang sudah terbentuk tetap sah; tata kelola penyesuaian antrean di destination diselesaikan melalui prosedur capability Antrian Rawat Jalan pada destination (`OC-05-01`), bukan membatalkan rujukan dari origin. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Rujuk Internal berhasil dibuat dengan mereferensikan Visit aktif, poliklinik asal, dokter asal, poliklinik tujuan, dokter tujuan yang memiliki jadwal aktif pada hari yang sama, serta alasan rujukan. | Completeness |
| AC-02 | Visit ID (Nomor Registrasi Kunjungan) pasien tetap sama dan tidak dibuat ulang selama maupun setelah proses Rujuk Internal berlangsung. | Constraint |
| AC-03 | Pelayanan dan status queue pasien pada Origin Service Context otomatis berubah menjadi **Selesai** seketika saat Rujuk Internal berhasil dicatat. | Correctness |
| AC-04 | Permintaan pembentukan Destination Queue pada Destination Service Context langsung dipicu secara otomatis sebagai queue lanjutan tanpa melalui tahapan *approval* dari destination. | Completeness |
| AC-05 | Queue pada destination memperoleh nomor urut queue reguler yang diterbitkan oleh capability Antrian Rawat Jalan destination dan tidak memiliki prioritas pemanggilan khusus. | Constraint |
| AC-06 | Queue pasien pada daftar antrian destination menampilkan penanda sumber **Rujuk Internal**, nama poliklinik asal, nama dokter asal, serta alasan rujukan. | Completeness |
| AC-07 | Pengguna pada unit asal hanya dapat melihat status bahwa pasien telah dirujuk ke poliklinik dan dokter tujuan, serta tidak dapat melihat atau mengelola status progres queue destination (*Menunggu*, *Dipanggil*, *Dalam Pelayanan*). | Constraint |
| AC-08 | Sistem menolak pembuatan Rujuk Internal apabila dokter tujuan yang dipilih sama dengan dokter asal. | Constraint |
| AC-09 | Sistem menolak pembuatan Rujuk Internal apabila dokter tujuan tidak memiliki jadwal praktik aktif pada hari yang sama. | Exception |
| AC-10 | Sistem menolak pembuatan Rujuk Internal apabila alasan/indikasi rujukan tidak dicantumkan. | Constraint |
| AC-11 | Sistem menolak pembuatan Rujuk Internal baru jika masih terdapat Rujuk Internal lain yang sedang berjalan dalam Visit yang sama. | Constraint |
| AC-12 | Rujukan internal lanjutan (*second internal referral*) berhasil dibuat setelah pelayanan pada dokter tujuan pertama telah diselesaikan secara sah. | Correctness |
| AC-13 | Upaya pembatalan atau pengubahan Rujuk Internal melalui antarmuka operasional reguler rawat jalan ditolak oleh sistem. | Constraint |
| AC-14 | Sistem menolak pembuatan Rujuk Internal jika tanggal pelayanan yang dituju bukan hari yang sama dengan tanggal Visit (*same-day violation*). | Exception |
| AC-15 | Queue yang terbentuk melalui Rujuk Internal tercatat sebagai queue lanjutan dan nomor antreannya diterbitkan oleh capability Antrian Rawat Jalan pada destination. | Queue Ownership |
| AC-16 | Queue awal yang berasal dari Admission dan queue lanjutan yang berasal dari Rujuk Internal tetap dikelola secara konsisten oleh capability Antrian Rawat Jalan pada masing-masing destination sesuai `OC-05-01`. | Domain Consistency |
| AC-17 | Setelah Origin Service Context selesai, Visit tetap aktif dan berpindah ke Destination Service Context. | Visit Lifecycle |
| AC-18 | OC-05-03 tidak mengubah status Visit menjadi selesai setelah Rujuk Internal dibuat. | Scope Boundary |
| AC-19 | Jika kuota destination penuh, perilaku sistem mengikuti konfigurasi SOP rumah sakit yang berlaku pada `ORG-JADWAL` / `RJL-ANTRIAN`. | Configurable Rule |
| AC-20 | Pengguna pada origin tidak dapat melihat atau mengelola status progres Destination Queue. | Visibility Boundary |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Penentuan kapan Visit secara keseluruhan dinyatakan selesai** — Keputusan penutupan Visit berada di luar scope OC-05-03 dan mengikuti lifecycle Visit yang dikelola oleh domain yang berwenang.
- **Pengelolaan lifecycle Visit setelah perpindahan Service Context** — Visit tetap aktif dan dikelola oleh pemilik lifecycle Visit.
- **Penerbitan nomor antrean dan pengelolaan progres Destination Queue** — Pemanggilan queue, penomoran antrean, pemanggilan ulang (*recall*), pasien dilewati (*skip*), serta pencatatan waktu pelayanan di destination → **OC-05-01 Antrian Rawat Jalan** (`RJL-ANTRIAN`).
- **Penetapan SOP dan konfigurasi kuota** — Pengaturan kuota layanan dan penetapan aturan over-quota dikelola pada domain/capability terkait (`ORG-JADWAL`, `RJL-ANTRIAN`).
- **Pengelolaan detail progres Destination Queue di sisi origin** — Origin tidak memantau atau mengintervensi queue destination.
- **Perubahan queue menjadi queue prioritas** — Tanpa business rule resmi yang ditetapkan, queue dari Rujuk Internal tetap reguler.
- **Rujukan Eksternal** — Pengalihan pasien ke fasilitas pelayanan kesehatan di luar rumah sakit berada di luar lingkup outcome ini dan ditangani melalui proses/outcome terpisah.
- **Pencatatan Tindakan Medis dan Konsultasi Klinis** — Pendokumentasian intervensi klinis dan pembentukan *service/billing record* → **OC-05-02 Tindakan Rawat Jalan** (`RJL-TINDAKAN`, `RJL-KONSUL`).
- **Pengelolaan Master Jadwal Praktik Dokter** — Pembuatan jadwal praktik, pengaturan kuota layanan, dan penetapan dokter pengganti → **OC-01-06 Jadwal Praktek** (`ORG-JADWAL`).
- **Prosedur Koreksi Administratif Back-Office** — Alur kerja koreksi kesalahan rujukan atau pembatalan darurat oleh supervisor → *Back-Office Administration Process* (di luar alur operasional reguler rawat jalan).
- **Penagihan, Tarif, dan Tata Rekening** — Perhitungan tarif konsultasi multi-dokter dan pembentukan tagihan → Tata Rekening Domain (`TRK-TARIF`, `TRK-BILLING`).
- **Verifikasi Asuransi, Penjaminan, dan VClaim BPJS** — Validasi kecukupan jaminan multi-poli atau penerbitan SEP tambahan → Tata Rekening Domain (`TRK-JAMINAN`) dan BPJS Domain (`BPJ-VCLAIM`).
- **Dokumentasi Rekam Medis Klinis Elektronik (EMR)** — Lembar transfer internal, asesmen medis SOAP rujukan, resume medis klinis, dan CPPT → Domain Rekam Medis / EMR.

---

## 11. Domain Semantics & Relational Model

> **Catatan Penyelarasan:** Section ini menyajikan representasi konseptual atas relasi antar entitas domain dan pembedaan batasan bisnis dalam tata kelola Rujuk Internal.

### 11.1 Alur Relasi Semantik Domain

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                         VISIT (ADM-REG)                                          │
│                    (Konteks Induk Kunjungan Pasien — Lifecycle Tetap Aktif)                      │
│                                                                                                  │
│  ┌─────────────────────────────────┐                       ┌─────────────────────────────────┐  │
│  │      ORIGIN SERVICE CONTEXT     │   Rujuk Internal      │   DESTINATION SERVICE CONTEXT   │  │
│  │  • Poli Asal                    │   (RJL-TRANSFER)      │  • Poli Tujuan                  │  │
│  │  • Dokter Asal                  │ ────────────────────► │  • Dokter Tujuan                │  │
│  │  • Status: Selesai Otomatis     │  Fakta Perpindahan    │  • Tanggal Sama (Same-Day)      │  │
│  └─────────────────────────────────┘  Konteks Pelayanan    └─────────────────────────────────┘  │
│                                                                             │                    │
│                                                                             │ Memicu Pembentukan │
│                                                                             ▼                    │
│                                                            ┌──────────────────────────────────┐  │
│                                                            │        DESTINATION QUEUE         │  │
│                                                            │     (Dikelola RJL-ANTRIAN)       │  │
│                                                            │  • Queue Reguler Lanjutan        │  │
│                                                            │  • Nomor diterbitkan RJL-ANTRIAN │  │
│                                                            │  • Penanda: Rujuk Internal       │  │
│                                                            │  • Asal Poli, Dokter, Alasan     │  │
│                                                            │  • Lifecycle: OC-05-01           │  │
│                                                            └──────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

> Rawat Jalan adalah domain besar yang memiliki beberapa capability terkait pelayanan. `RJL-TRANSFER` bertanggung jawab mencatat Rujuk Internal dan memicu pembentukan queue lanjutan, sedangkan `RJL-ANTRIAN` bertanggung jawab atas penerbitan nomor antrean dan pengelolaan queue pada masing-masing destination.
>
> Queue pertama dapat terbentuk melalui Admission. Queue lanjutan terbentuk melalui pemicuan dari Rujuk Internal. Keduanya tetap berada dalam domain Antrian Rawat Jalan (`OC-05-01`) dan dikelola sesuai aturan destination masing-masing.
>
> OC-05-03 tidak menyelesaikan Visit. Outcome ini hanya menyelesaikan Origin Service Context, membentuk Destination Service Context, dan memicu Destination Queue.

### 11.2 Perbandingan Batasan Bisnis Alur Layanan

| Dimensi Evaluasi | Queue Awal Poli (OC-05-01 / OC-01-02) | Rujuk Internal Rawat Jalan (OC-05-03) | Rujuk Eksternal (Out of Scope) |
|---|---|---|---|
| **Konteks Kunjungan (Visit)** | Registrasi baru atau *walk-in* / booking | Menggunakan Visit yang sama (*same-Visit*); Visit tidak ditutup | Mengakhiri episode atau merujuk ke luar fasyankes |
| **Hari Pelayanan** | Hari registrasi awal | Hari pelayanan yang sama (*same-day*) | Bisa hari yang sama atau terjadwal ke depan |
| **Lokasi Tujuan** | Poliklinik awal yang didaftarkan | Dokter lain di RS yang sama (poli sama/beda) | Fasilitas kesehatan lain di luar RS |
| **Pembentukan Queue** | Diterbitkan saat registrasi Admission | Dipicu oleh Rujuk Internal (`RJL-TRANSFER`), nomor diterbitkan `RJL-ANTRIAN` | Tidak membentuk queue internal RS |
| **Pengelola Queue** | `RJL-ANTRIAN` Antrian Rawat Jalan | `RJL-ANTRIAN` Antrian Rawat Jalan | N/A |
| **Mekanisme Approval** | Tidak ada | Tidak ada (*zero approval*) | Memerlukan koordinasi/surat rujukan eksternal |
| **Prioritas Queue** | Mengikuti aturan reguler | Mengikuti aturan reguler (tanpa prioritas) | N/A |
| **Penyelesaian Visit** | Tidak diselesaikan oleh proses ini | Tidak diselesaikan oleh OC-05-03 | Dapat mengakhiri episode Visit |
| **Visibilitas Status** | Terlihat pada poli terdaftar | Origin hanya melihat tujuan rujukan; tidak memantau progres queue | Terlihat sebagai status rujukan keluar |
