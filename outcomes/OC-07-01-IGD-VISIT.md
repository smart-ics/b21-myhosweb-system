# OUTCOME: IGD Visit

| Field       | Value        |
|-------------|--------------|
| Code        | OC-07-01     |
| Version     | 1.3          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat episode kunjungan seseorang ke Unit Instalasi Gawat Darurat (IGD) sebagai *persisted business fact* yang menjadi konteks pelayanan resmi bagi seluruh aktivitas medis darurat yang berlangsung selama kunjungan tersebut.

IGD Visit merepresentasikan satu episode kunjungan seseorang ke Unit IGD. Episode ini menjadi konteks pelayanan induk yang menaungi berbagai aktivitas selama di IGD — seperti triage, tindakan medis, dan pemakaian bahan/alkes — tanpa menjadikan aktivitas-aktivitas tersebut sebagai syarat terbentuknya episode kunjungan.

Karena sifat kegawatdaruratan, episode IGD Visit dapat dibuka seketika bahkan ketika identitas resmi pasien belum diketahui. Informasi identitas pasien dapat dilengkapi atau ditautkan kemudian selama episode masih berlangsung. Keberadaan IGD Visit menjamin akuntabilitas penerimaan pasien gawat darurat dan kepastian alur pelayanan hingga ditetapkannya keputusan akhir kelanjutan pelayanan.

---

## 2. Outcome Statement

Satu episode kunjungan seseorang ke Unit Gawat Darurat (IGD) **telah tercatat sebagai konteks pelayanan aktif yang diakui sistem, siap menjadi acuan bagi seluruh aktivitas pelayanan selama episode berlangsung**.

---

## 3. Participating Domains

| Domain | Kategori | Role in this Outcome |
|---|---|---|
| Gawat Darurat (IGD) | **Core Domain — Owner** | Pemilik dan pengelola penuh episode IGD Visit: membuka episode, menyediakan konteks pelayanan gawat darurat, menaungi aktivitas pelayanan, serta menetapkan dan mencatat keputusan akhir kelanjutan pelayanan yang mengakhiri episode. |
| Pasien (PAS) | Domain Pendukung | Menyediakan data sosial dan identitas resmi pasien (No. RM) bila identitas sudah terdaftar, atau memfasilitasi penautan identitas definitif pasien bila episode dimulai dengan identitas pengunjung sementara. |
| Admission (ADM) | Domain Pendukung | Menyelaraskan episode kunjungan IGD dengan registrasi rumah sakit formal bila diperlukan, tanpa menjadi prasyarat dimulainya episode IGD. |
| Organisasi (ORG) | Domain Pendukung | Menyediakan data unit layanan IGD yang aktif dan data Petugas Pemberi Asuhan (PPA) yang bertanggung jawab atas penerimaan dan penanganan pasien. |
| Rawat Inap (RNA) | Domain Penerima Transfer | Menjadi domain penerima pelimpahan pelayanan apabila keputusan akhir IGD Visit adalah Rawat Inap. |
| Rawat Jalan (RJL) | Domain Penerima Transfer | Menjadi domain penerima pengalihan pelayanan apabila keputusan akhir IGD Visit adalah Rawat Jalan. |
| Tata Rekening (TRK) | Domain Pendukung | Menyediakan konteks penjaminan yang berlaku atas episode kunjungan IGD. Pencatatan tagihan dan pembayaran merupakan outcome terpisah. |
| Berkas Rekam Medis (BRM) | Domain Konsumen / Penerima Data | Mengonsumsi fakta pelayanan dan penyelesaian episode IGD Visit — termasuk keputusan akhir dan keterangan kematian — sebagai salah satu sumber data untuk kebutuhan Pelaporan RL dan pelaporan mortalitas. Tidak menjadi bagian dari lifecycle IGD Visit dan bukan prasyarat penyelesaian episode. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ADM-REG` Registration | Admission | Known |
| `IGD-RANAP` Transfer Ranap | Gawat Darurat | Known |
| `RNA-TRANSFER` Transfer Ke Unit Lain | Rawat Inap | Known |
| `RJL-TRANSFER` Rujukan Internal | Rawat Jalan | Known |
| `BRM-RL` Laporan RL | Berkas Rekam Medis | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Satu episode kunjungan IGD atas nama seseorang — teridentifikasi maupun belum teridentifikasi — telah dibuka dan tercatat sebagai pelayanan gawat darurat yang aktif.
- Episode IGD Visit memiliki identitas pengenal minimal yang valid: Nomor Rekam Medis bila pasien sudah terdaftar, atau nama pengunjung sementara bila identitas resmi belum diketahui.
- Episode IGD Visit memiliki penanda waktu kedatangan di unit IGD.
- Episode IGD Visit berkedudukan sebagai konteks induk bagi seluruh aktivitas pelayanan klinis dan administratif selama kunjungan di IGD.
- Jika episode dimulai tanpa identitas pasien definitif, identitas resmi dapat ditautkan kemudian tanpa mengubah riwayat episode yang telah berjalan.

### 5.2 Required Recorded Information

**Pembukaan Episode:**
- Nomor referensi unik episode kunjungan IGD.
- Waktu pembukaan episode (tanggal dan jam kedatangan).
- Unit layanan IGD tempat episode dibuka.
- Identitas subjek kunjungan: Nomor Rekam Medis bila pasien sudah terdaftar, atau nama/pengenal pengunjung sementara bila identitas resmi belum diketahui.

**Pemutakhiran Identitas (jika berlaku):**
- Identitas pasien resmi (No. RM) yang ditautkan ke episode setelah berhasil diidentifikasi.

**Keputusan Kelanjutan Pelayanan (Disposisi Akhir):**
- Jenis keputusan akhir, tepat salah satu dari:
  1. **Pulang** — pasien diperbolehkan meninggalkan fasilitas pelayanan IGD.
  2. **Rawat Jalan** — pasien dialihkan untuk mendapatkan pelayanan lanjutan di unit rawat jalan.
  3. **Rawat Inap** — pasien dilimpahkan untuk mendapatkan pelayanan lanjutan di unit rawat inap.
- Waktu penetapan keputusan akhir.
- Dokter atau petugas berwenang yang menetapkan keputusan akhir.
- Keterangan atas keputusan akhir yang diperlukan untuk menjelaskan konteks penyelesaian episode (misalnya: kondisi membaik, poliklinik tujuan pengalihan, indikasi rawat inap, atau kepulangan atas permintaan sendiri). Apabila pasien meninggal dunia di IGD, keterangan wajib menyatakan fakta kematian secara eksplisit sehingga dapat dibedakan dari pasien yang pulang dalam kondisi hidup, dan fakta tersebut tersedia sebagai sumber data bagi domain konsumen seperti Pelaporan RL.

### 5.3 Required Business Conditions

- Episode IGD Visit dapat dibuka tanpa mensyaratkan adanya registrasi admisi rumah sakit, kelengkapan status jaminan, maupun ketersediaan Nomor Rekam Medis resmi.
- Minimal harus ada satu informasi pengenal pengunjung agar episode IGD Visit dapat dicatat.
- Episode IGD Visit dapat dibuka tanpa mensyaratkan selesainya triage atau pencatatan tindakan medis terlebih dahulu.
- Episode IGD Visit harus berada dalam status aktif agar dapat menjadi konteks referensi bagi aktivitas-aktivitas pelayanan di IGD.
- Episode IGD Visit tidak dapat dinyatakan selesai tanpa adanya penetapan keputusan akhir kelanjutan pelayanan yang definitif.
- Keputusan kelanjutan pelayanan bersifat saling meniadakan: satu episode IGD Visit hanya boleh memiliki tepat satu disposisi akhir.
- Setelah keputusan akhir ditetapkan, episode IGD Visit ditutup dan tidak dapat menerima penambahan aktivitas pelayanan baru.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Episode kunjungan IGD tercatat dengan nomor referensi unik dan dapat ditelusuri.
- Terdapat tepat satu keputusan akhir kelanjutan pelayanan yang ditetapkan: **Pulang**, **Rawat Jalan**, atau **Rawat Inap**.
- Tercatat waktu penetapan keputusan akhir dan identitas dokter atau petugas yang menetapkannya.
- Episode IGD Visit berstatus selesai.
- Episode telah siap menjadi dasar bagi proses lanjutan sesuai disposisi yang ditetapkan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika seseorang datang ke Instalasi Gawat Darurat (IGD) membutuhkan penanganan medis dan episode kunjungannya mulai dicatat oleh petugas — baik menggunakan data pasien yang sudah terdaftar maupun menggunakan nama atau pengenal pengunjung sementara ketika identitas resmi belum diketahui.

### End

Selesai ketika dokter atau petugas yang berwenang telah menetapkan keputusan akhir kelanjutan pelayanan pasien (**Pulang**, **Rawat Jalan**, atau **Rawat Inap**), keputusan tersebut tercatat ke dalam episode, dan episode kunjungan IGD dinyatakan selesai.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Prioritas Pelayanan di Atas Kelengkapan Administrasi**: Pembentukan episode IGD Visit tidak boleh mensyaratkan selesainya registrasi admisi rumah sakit. Pelayanan gawat darurat dapat segera dimulai dan episode dapat langsung dicatat.
- **Kebebasan dari Prasyarat Identitas**: Ketiadaan identitas resmi pasien tidak boleh menghalangi pembentukan episode IGD Visit. Nama atau pengenal pengunjung sementara sah secara bisnis untuk membuka episode.
- **Pemisahan Episode dan Aktivitas Klinis**: IGD Visit adalah konteks episode kunjungan, bukan tindakan klinis atau triage. Triage, tindakan medis, dan pemakaian barang adalah aktivitas atau outcome terpisah yang merujuk pada episode IGD Visit yang aktif sebagai konteksnya.
- **Disposisi Akhir sebagai Syarat Penutupan Episode**: Episode IGD Visit tidak dapat ditutup atau diselesaikan tanpa salah satu keputusan akhir yang sah: Pulang, Rawat Jalan, atau Rawat Inap.
- **Keunikan Disposisi**: Satu episode kunjungan hanya boleh memiliki tepat satu keputusan akhir kelanjutan pelayanan.
- **Episode Tertutup Tidak Menerima Aktivitas Baru**: Setelah episode ditutup dengan keputusan akhir, episode tidak dapat menerima penambahan aktivitas pelayanan klinis IGD baru. Kunjungan berikutnya oleh pasien yang sama wajib membuka episode IGD Visit baru.
- **Keterlacakan Resolusi Identitas**: Penautan identitas resmi pasien ke episode yang dimulai dengan identitas sementara tidak boleh menghapus atau merusak riwayat aktivitas yang telah dicatat sebelumnya.
- **Pencatatan Eksplisit Fakta Kematian**: Apabila pasien meninggal dunia di IGD, fakta kematian harus tercatat secara eksplisit pada keterangan penyelesaian episode tanpa mengubah disposition yang tetap Pulang. Fakta kematian yang tercatat pada episode IGD Visit dapat digunakan sebagai sumber informasi oleh domain Pelaporan RL untuk kebutuhan pelaporan mortalitas.

---

## 8. Business Exceptions

> Conditions under which the Outcome is established or handled under abnormal circumstances.

| Exception | Expected Behavior |
|---|---|
| Pengunjung datang dalam kondisi tidak sadar, tanpa identitas, dan tanpa pendamping | Episode IGD Visit tetap dicatat segera menggunakan nama atau pengenal sementara agar konteks pelayanan terbentuk dan penanganan medis darurat dapat langsung dicatat. |
| Identitas resmi pasien (No. RM) ditemukan setelah episode berjalan dengan identitas sementara | Petugas memperbarui episode dengan menautkan data sosial pasien resmi. Seluruh aktivitas dan layanan yang telah tercatat sebelumnya tetap melekat pada episode tersebut. |
| Pasien meninggalkan IGD atas permintaan sendiri (APS / Pulang Paksa) sebelum penanganan selesai | Episode diselesaikan dengan keputusan akhir **Pulang** disertai keterangan bahwa kepulangan adalah atas permintaan sendiri atau penolakan tindakan. |
| Pasien meninggal dunia di IGD (*Death on Arrival* atau meninggal saat penanganan berlangsung) | IGD Visit diselesaikan dengan disposition **Pulang**. Keterangan penyelesaian wajib menyatakan secara eksplisit bahwa pasien meninggal dunia. Meninggal bukan disposition tersendiri, melainkan fakta yang melekat pada penyelesaian episode. Fakta kematian tersebut menjadi bagian dari riwayat penyelesaian episode dan dapat dikonsumsi oleh domain Pelaporan RL untuk kebutuhan pelaporan mortalitas. |
| Terjadi kekeliruan pencatatan (entri ganda atau kunjungan palsu) | Episode dapat dibatalkan oleh petugas berwenang dengan mencatat alasan pembatalan yang sah. Pembatalan adalah kondisi di luar lifecycle normal (bukan penutupan melalui disposisi), dan hanya digunakan untuk koreksi administratif. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Episode IGD Visit berhasil dicatat ketika seseorang datang ke IGD, baik menggunakan identitas pasien terdaftar maupun hanya dengan nama atau pengenal pengunjung sementara. | Completeness |
| AC-02 | Episode IGD Visit yang aktif dapat dijadikan sebagai konteks acuan bagi pencatatan aktivitas pelayanan lain di IGD, termasuk triage, tindakan medis, dan pemakaian barang. | Completeness |
| AC-03 | Episode IGD Visit dapat diselesaikan secara definitif ketika dokter atau petugas menetapkan salah satu dari tiga keputusan kelanjutan pelayanan: Pulang, Rawat Jalan, atau Rawat Inap. | Completeness |
| AC-04 | Setiap penetapan keputusan akhir mencatat jenis keputusan, waktu penetapan, dan identitas dokter atau petugas yang menetapkannya. | Correctness |
| AC-05 | Episode IGD Visit dapat dibuka tanpa mensyaratkan Nomor Rekam Medis resmi pada saat kedatangan. | Constraint |
| AC-06 | Episode IGD Visit dapat dibuka tanpa mensyaratkan selesainya triage atau tindakan medis terlebih dahulu. | Constraint |
| AC-07 | Episode IGD Visit tidak dapat ditutup tanpa adanya salah satu keputusan kelanjutan pelayanan yang valid. | Constraint |
| AC-08 | Episode IGD Visit yang telah ditutup dengan keputusan akhir tidak dapat menerima penambahan aktivitas pelayanan klinis baru. | Constraint |
| AC-09 | Identitas resmi pasien dapat ditautkan ke episode yang dimulai dengan identitas sementara, tanpa membatalkan atau merusak riwayat pelayanan yang sudah dicatat. | Exception |
| AC-10 | Apabila pasien meninggal dunia di IGD, episode IGD Visit dapat diselesaikan dengan disposition Pulang disertai keterangan eksplisit bahwa pasien meninggal dunia, dan fakta tersebut tersedia sebagai sumber data bagi kebutuhan Pelaporan RL. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penilaian, pengkategorian skala kegawatan, dan pencatatan hasil triage → Diatur dalam **OC-07-02 Triage** (`IGD-TRIAGE`).
- Pelaksanaan dan pencatatan tindakan medis darurat, prosedur penanganan klinis, dan jasa medis → Diatur dalam **OC-07-04 Tindakan** (`IGD-TINDAKAN`).
- Pencatatan pemakaian obat, alkes habis pakai, dan bahan selama penanganan IGD → Diatur dalam **OC-07-05 Pakai Barang** (`INV-PAKAI`).
- Permintaan, pengelolaan operasional, dan penagihan ambulans → Diatur dalam **OC-07-03 Ambulance** (`IGD-AMBULANCE`).
- Proses pendaftaran rawat inap, alokasi bed, dan administrasi penerimaan di bangsal setelah diputuskan rawat inap → Diatur dalam **OC-01-03 Registrasi Rawat Inap** dan **OC-06-02 Pakai Bed**.
- Penjadwalan, antrian, dan penerimaan di poliklinik rawat jalan setelah diputuskan dialihkan ke rawat jalan → Diatur dalam **OC-01-02 Registrasi Rawat Jalan** dan **OC-05-01 Antrian Poli**.
- Dokumentasi rekam medis klinis (CPPT, anamnesis dokter, resume medis IGD) → Dikelola oleh **Domain EMR / Rekam Medis Elektronik**.
- Penghitungan tarif, pembentukan billing, deposit, dan pelunasan tagihan → Diatur dalam **Domain Tata Rekening** (`SC-02`, `SC-03`).
- Pengelolaan master pasien, pembuatan No. RM baru, dan penggabungan rekam medis ganda → Diatur dalam **Domain Pasien** (`PAS-DATSOS`, `PAS-MERGE`).
- Penerbitan Surat Eligibilitas Peserta (SEP) BPJS Kesehatan untuk kunjungan IGD → Diatur dalam **OC-01-04 VCLAIM BPJS**.
