# OUTCOME: IGD Visit

| Field       | Value        |
|-------------|--------------|
| Code        | OC-07-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap orang yang datang ke Instalasi Gawat Darurat (IGD) membutuhkan penanganan medis segera tanpa boleh terhambat oleh kelengkapan administrasi awal maupun kepastian identitas resmi pasien. Rumah sakit harus mampu membuka dan mencatat episode kunjungan gawat darurat (**IGD Visit**) sebagai *persisted business fact* yang menjadi wadah dan konteks operasional bagi seluruh aktivitas pelayanan medis darurat.

IGD Visit merepresentasikan satu episode kunjungan seseorang ke Unit IGD untuk mendapatkan penanganan medis. Episode ini berfungsi sebagai konteks pelayanan induk yang menaungi berbagai aktivitas pelayanan pasien selama di IGD (seperti triage, tindakan medis darurat, pemakaian alkes/obat, konsultasi dokter spesialis, hingga pemeriksaan penunjang), tanpa menjadikan aktivitas-aktivitas tersebut sebagai pendefinisi dari episode kunjungan itu sendiri.

Episode IGD Visit dapat dicatat seketika bahkan saat identitas pasien belum diketahui (misalnya pasien tidak sadar, tanpa identitas, atau datang tanpa pendamping) menggunakan data dasar pengunjung yang tersedia (`VisitorName`), dan identitas resmi pasien dapat dilengkapi atau ditautkan kemudian selama episode berlangsung. Keberadaan IGD Visit menjamin akuntabilitas penerimaan pasien gawat darurat, keabsahan pemberian pertolongan medis segera, serta kepastian alur hingga ditetapkannya keputusan akhir kelanjutan pelayanan pasien.

---

## 2. Outcome Statement

Satu episode kunjungan seseorang ke Unit Gawat Darurat (IGD) **telah tercatat sebagai konteks pelayanan aktif untuk menampung seluruh aktivitas pelayanan medis darurat, dan diselesaikan secara tuntas melalui penetapan keputusan kelanjutan pelayanan (disposisi akhir: Pulang, Rawat Jalan, atau Rawat Inap)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| Gawat Darurat (IGD) | Pemilik utama (*Core Domain*): mencatat pembukaan episode kunjungan IGD, menyediakan konteks pelayanan gawat darurat, menaungi aktivitas pelayanan, serta mencatat penetapan keputusan akhir (disposisi) yang mengakhiri episode. |
| Pasien (PAS) | Menyediakan data sosial pasien yang sah jika identitas sudah terdaftar, atau memutakhirkan/menautkan identitas definitif pasien (*Data Sosial Pasien / No. RM*) jika pengunjung awalnya dicatat dengan identitas sementara. |
| Admission (ADM) | Menyelaraskan episode kunjungan IGD dengan registrasi rumah sakit formal ketika administrasi telah dapat diproses, tanpa menghambat dimulainya episode IGD. |
| Organisasi (ORG) | Menyediakan data unit layanan IGD aktif dan data Petugas Pemberi Asuhan (PPA / dokter jaga / perawat) yang bertanggung jawab atas penerimaan dan penanganan pasien. |
| Rawat Inap (RNA) | Domain penerima pelimpahan pelayanan ketika keputusan akhir IGD Visit adalah **Rawat Inap**, menjadi gerbang awal alur penerimaan rawat inap. |
| Rawat Jalan (RJL) | Domain penerima pengalihan pelayanan ketika keputusan akhir IGD Visit adalah **Rawat Jalan** (poliklinik). |
| Tata Rekening (TRK) | Menyediakan konteks penjaminan dan penagihan biaya atas pelayanan yang terjadi selama episode kunjungan IGD (meskipun pencatatan tagihan dan kasir adalah outcome terpisah). |

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

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Satu episode kunjungan IGD atas nama seseorang (teridentifikasi maupun belum teridentifikasi) telah dibuka dan tercatat sebagai unit pelayanan gawat darurat yang aktif.
- Episode IGD Visit memiliki identitas pengenal kedatangan minimal yang valid: Nomor Rekam Medis (jika sudah terdaftar) ATAU informasi dasar pengunjung sementara (misalnya `VisitorName` seperti "Mr. X", "Ny. Y", atau nama pengunjung yang dilaporkan).
- Episode IGD Visit memiliki penanda waktu kedatangan resmi di unit IGD.
- Episode IGD Visit berkedudukan sebagai konteks induk (*encounter context*) bagi seluruh aktivitas operasional klinis dan administratif selama berada di IGD.
- Jika episode diawali tanpa identitas pasien definitif, fakta keterkaitan antara episode kunjungan dengan identitas resmi pasien (No. RM definitif) dapat diperbarui kemudian tanpa mengubah riwayat episode pelayanan yang telah berjalan.
- Episode IGD Visit memiliki keputusan akhir kelanjutan pelayanan (disposisi akhir) yang ditetapkan oleh dokter/petugas berwenang: salah satu dari **Pulang**, **Rawat Jalan**, atau **Rawat Inap**.
- Penetapan keputusan akhir kelanjutan pelayanan menandai bahwa episode kunjungan IGD telah selesai (*closed/completed*).

### 5.2 Required Recorded Information

**Informasi Kedatangan dan Identitas Episode:**
- Nomor/identitas referensi unik episode kunjungan IGD.
- Waktu kedatangan / waktu pencatatan awal kunjungan IGD (tanggal dan jam).
- Unit layanan IGD penerima.
- Petugas penerima / pencatat awal kunjungan.
- Informasi subjek pengunjung:
  * *Jika teridentifikasi:* Nomor Rekam Medis (No. RM) dan data sosial pasien yang valid.
  * *Jika belum teridentifikasi:* Nama pengunjung sementara (`VisitorName`), jenis kelamin fisik yang teramati, perkiraan usia/kelompok usia, serta catatan pengenal awal.
- Keterangan cara kedatangan (datang sendiri, diantar keluarga/warga, rujukan faskes lain, diantar kepolisian, atau dibawa ambulans).
- Dokter/PPA penanggung jawab awal IGD (atau tim jaga IGD).

**Informasi Pemutakhiran Identitas (jika berlaku):**
- Referensi identitas pasien definitif (No. RM) yang ditautkan ke episode.
- Waktu dan identitas petugas yang melakukan penautan/pemutakhiran identitas pasien.

**Informasi Keputusan Kelanjutan Pelayanan (Disposisi Akhir):**
- Jenis keputusan akhir (tepat salah satu):
  1. **Pulang** (pasien diperbolehkan meninggalkan fasilitas pelayanan IGD).
  2. **Rawat Jalan** (pasien dialihkan untuk mendapatkan pelayanan lanjutan di unit rawat jalan / poliklinik).
  3. **Rawat Inap** (pasien dilimpahkan untuk mendapatkan pelayanan lanjutan di unit rawat inap / bangsal).
- Waktu penetapan keputusan akhir (tanggal dan jam penutupan episode).
- Dokter/petugas berwenang yang menetapkan keputusan akhir.
- Catatan/keterangan klinis atau administratif atas keputusan akhir (misal: kondisi membaik diizinkan pulang, poliklinik tujuan pengalihan, atau indikasi rawat inap).

### 5.3 Required Business Conditions

- Pembentukan episode IGD Visit tidak boleh dihambat atau dipersyaratkan oleh kelengkapan administrasi admission, status kepesertaan jaminan/asuransi, maupun ketersediaan Nomor Rekam Medis resmi.
- Minimal harus ada satu informasi pengenal pengunjung (`VisitorName` atau No. RM) agar episode IGD Visit dapat dicatat.
- Pembentukan episode IGD Visit tidak boleh dipersyaratkan oleh adanya hasil triage atau pencatatan tindakan medis tertentu terlebih dahulu.
- Episode IGD Visit harus berada dalam status aktif agar dapat menampung dan menjadi konteks referensi bagi aktivitas-aktivitas pelayanan di IGD (triage, tindakan klinis, penggunaan alkes/obat, dll.).
- Episode IGD Visit tidak dapat dinyatakan selesai tanpa adanya penetapan keputusan akhir kelanjutan pelayanan yang definitif.
- Keputusan kelanjutan pelayanan bersifat saling meniadakan (*mutually exclusive*): satu episode IGD Visit hanya boleh memiliki tepat satu disposisi akhir (Pulang, Rawat Jalan, atau Rawat Inap).
- Setelah keputusan akhir ditetapkan, episode IGD Visit ditutup dan tidak dapat menerima pencatatan aktivitas pelayanan medis baru.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Episode kunjungan IGD tercatat dengan nomor referensi unik dan dapat ditelusuri.
- Tercatat secara definitif tepat satu keputusan akhir kelanjutan pelayanan (disposisi):
  1. **Pulang**,
  2. **Rawat Jalan**, atau
  3. **Rawat Inap**.
- Tercatat waktu penetapan keputusan akhir dan identitas dokter/petugas yang menetapkannya.
- Episode IGD Visit berstatus selesai (*Completed / Closed / Transferred / Discharged*).
- Episode telah siap menjadi dasar bagi proses lanjutan: pemulangan pasien, penerimaan di rawat jalan, atau proses registrasi/penempatan bed di rawat inap.

---

## 6. Outcome Boundary

### Start

Dimulai ketika seseorang datang ke Instalasi Gawat Darurat (IGD) karena membutuhkan penanganan medis darurat dan episode kunjungannya mulai dicatat oleh petugas sebagai pelayanan IGD (baik menggunakan data pasien yang sudah terdaftar maupun data pengunjung sementara / `VisitorName`).

### End

Selesai ketika dokter/petugas yang berwenang telah menetapkan keputusan atas kelanjutan pelayanan pasien (disposisi akhir: **Pulang**, **Rawat Jalan**, atau **Rawat Inap**), mencatatnya ke dalam episode, dan menandai bahwa episode kunjungan IGD telah selesai.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Emergency Priority over Administrative Prerequisite**: Pembentukan IGD Visit tidak boleh mensyaratkan adanya registrasi admisi rumah sakit terlebih dahulu (*admission registration does not precede emergency care*). Pelayanan gawat darurat dapat segera dimulai.
- **Independence from Patient Identity**: Ketiadaan Nomor Rekam Medis (pasien belum terdaftar / tidak dikenal) tidak boleh menghalangi pembentukan episode IGD Visit. Penggunaan data dasar sementara (`VisitorName`) sah secara bisnis untuk membuka episode.
- **Separation of Episode and Clinical Services**: IGD Visit adalah wadah/konteks episode kunjungan, bukan satu tindakan klinis atau triage. Triage, tindakan medis, pemakaian barang, dan pemeriksaan penunjang adalah aktivitas/outcome terpisah yang merujuk pada episode IGD Visit yang aktif.
- **Mandatory Final Disposition for Completion**: Episode IGD Visit tidak dapat ditutup atau diselesaikan tanpa salah satu dari 3 keputusan akhir yang sah: Pulang, Rawat Jalan, atau Rawat Inap.
- **Mutual Exclusivity of Disposition**: Keputusan akhir kelanjutan pelayanan bersifat tunggal untuk satu episode kunjungan (tepat satu pilihan).
- **Closure Immutability**: Setelah episode ditutup dengan keputusan akhir kelanjutan pelayanan, episode tidak dapat menerima penambahan aktivitas pelayanan klinis IGD baru. Apabila pasien yang sama datang kembali di lain waktu, wajib dibuka episode IGD Visit yang baru.
- **Traceability of Identity Resolution**: Jika identitas pasien definitif baru diketahui di tengah atau di akhir episode, penautan ke master pasien tidak boleh menghapus atau merusak riwayat aktivitas yang telah dicatat selama pengunjung berstatus sementara.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or handled abnormally.

| Exception | Expected Behavior |
|---|---|
| Pengunjung datang dalam kondisi tidak sadar / tanpa identitas sama sekali dan tanpa pendamping | Episode IGD Visit tetap wajib dicatat menggunakan penamaan sementara (misalnya `VisitorName`: "Mr. X / Label Kedatangan Darurat") agar konteks pelayanan segera terbentuk dan penanganan medis darurat dapat langsung dicatat. |
| Identitas pasien resmi (No. RM) berhasil ditemukan setelah episode berjalan menggunakan nama sementara | Petugas memperbarui episode IGD Visit dengan menautkan data sosial pasien resmi (No. RM definitif) melalui kemampuan `PAS-DATSOS`. Seluruh aktivitas dan layanan yang telah tercatat sebelumnya otomatis tetap melekat pada episode tersebut. |
| Pasien meninggalkan IGD atas permintaan sendiri (APS / Pulang Paksa) atau melarikan diri sebelum penanganan selesai | Episode diselesaikan dengan keputusan akhir **Pulang** disertai dokumentasi catatan/alasan khusus (misal: atas permintaan sendiri / menolak tindakan), sehingga episode tetap memiliki penutupan administratif yang sah. |
| Pasien meninggal dunia di IGD (*Death on Arrival* / Meninggal saat Penanganan) | Episode diselesaikan dengan keputusan akhir **Pulang** disertai dokumentasi keterangan kematian / pemulangan jenazah, sehingga episode kunjungan IGD resmi ditutup. |
| Terjadi pembatalan kunjungan akibat kekeliruan pencatatan (*False Visit / Duplicate Entry*) | Episode dapat dibatalkan hanya oleh petugas berwenang dengan mencatat alasan pembatalan yang sah, dan episode ditandai batal tanpa penetapan disposisi kelanjutan pelayanan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Episode IGD Visit berhasil dicatat seketika saat seseorang datang ke IGD membutuhkan penanganan medis, menggunakan identitas pasien terdaftar (No. RM) maupun hanya dengan informasi dasar pengunjung (`VisitorName`). | Completeness |
| AC-02 | Episode IGD Visit yang aktif dapat dijadikan sebagai konteks acuan (*encounter context*) bagi pencatatan aktivitas pelayanan lain di IGD (triage, tindakan medis, dan pemakaian barang). | Completeness |
| AC-03 | Episode IGD Visit dapat diselesaikan secara definitif ketika dokter/petugas menetapkan salah satu dari 3 keputusan kelanjutan pelayanan: **Pulang**, **Rawat Jalan**, atau **Rawat Inap**. | Completeness |
| AC-04 | Setiap penetapan keputusan akhir mencatat secara akurat jenis keputusan (tepat salah satu dari 3 opsi), waktu penetapan, dan identitas petugas/dokter yang menetapkan. | Correctness |
| AC-05 | Sistem menerima pencatatan episode IGD Visit tanpa mensyaratkan ketersediaan Nomor Rekam Medis resmi pada saat kedatangan. | Constraint |
| AC-06 | Sistem mengizinkan pembentukan episode IGD Visit tanpa mensyaratkan selesainya triage atau tindakan medis terlebih dahulu. | Constraint |
| AC-07 | Episode IGD Visit tidak dapat ditutup tanpa adanya salah satu dari 3 keputusan kelanjutan pelayanan yang valid. | Constraint |
| AC-08 | Episode IGD Visit yang telah ditutup dengan keputusan akhir tidak dapat menerima penambahan aktivitas pelayanan klinis baru. | Constraint |
| AC-09 | Jika episode dimulai dengan pengunjung belum teridentifikasi, identitas resmi pasien (No. RM) dapat ditautkan ke episode tersebut tanpa membatalkan atau merusak riwayat pelayanan yang sudah dicatat. | Exception |
| AC-10 | Kasus pasien pulang atas permintaan sendiri atau meninggal dunia dapat diselesaikan dalam koridor keputusan akhir yang sah dengan pencatatan keterangan yang sesuai. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penilaian, pengkategorian skala kegawatan, dan pencatatan klinis triage → Diatur dalam **OC-07-02 Triage** (`IGD-TRIAGE`).
- Pelaksanaan dan pencatatan tindakan medis darurat, prosedur penanganan klinis, dan jasa medis → Diatur dalam **OC-07-04 Tindakan** (`IGD-TINDAKAN`).
- Pencatatan pemakaian obat, alkes habis pakai, dan darah selama penanganan IGD → Diatur dalam **OC-07-05 Pakai Barang** (`INV-PAKAI`).
- Permintaan dan pengelolaan operasional serta penagihan mobil ambulans → Diatur dalam **OC-07-03 Ambulance** (`IGD-AMBULANCE`).
- Proses pendaftaran rawat inap, alokasi bed, dan administrasi penerimaan pasien di bangsal setelah diputuskan rawat inap → Diatur dalam **OC-01-03 Registrasi Rawat Inap** dan **OC-06-02 Pakai Bed**.
- Penjadwalan, pemanggilan, dan antrian di poliklinik rawat jalan setelah diputuskan dialihkan ke rawat jalan → Diatur dalam **OC-01-02 Registrasi Rawat Jalan** dan **OC-05-01 Antrian Poli**.
- Dokumentasi rekam medis klinis mendalam (CPPT, anamnesis dokter, resume medis IGD) → Dikelola oleh **Domain EMR / Rekam Medis Elektronik**.
- Penghitungan tarif pelayanan, pembentukan billing kasir, deposit, dan pelunasan tagihan pembayaran → Diatur dalam **Domain Tata Rekening** (`SC-02`, `SC-03`).
- Pengelolaan master pasien, pembuatan No. RM baru, dan penggabungan rekam medis ganda (*patient merge*) → Diatur dalam **Domain Pasien** (`PAS-DATSOS`, `PAS-MERGE`).
- Penerbitan Surat Eligibilitas Peserta (SEP) BPJS Kesehatan untuk IGD → Diatur dalam **OC-01-04 VCLAIM BPJS**.
