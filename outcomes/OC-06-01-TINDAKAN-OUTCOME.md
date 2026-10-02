# OUTCOME: Tindakan Rawat Inap

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat dan memelihara fakta pelaksanaan aktivitas pelayanan medis, keperawatan, dan pelayanan klinis lainnya yang benar-benar telah diberikan oleh tenaga kesehatan kepada pasien selama masa perawatan rawat inap.

Tindakan rawat inap merepresentasikan **fakta pelaksanaan pelayanan klinis aktual (Clinical Service Event)**, bukan sekadar instruksi medis/order atau ketersediaan master jenis tindakan. Pencatatan ini membuktikan bahwa pasien telah nyata-nyata menerima asuhan klinis dalam rangka pemeriksaan, diagnosis, pengobatan, perawatan luka, pemantauan kondisi, maupun pemulihan.

Pencatatan kejadian pelayanan ini menerapkan prinsip **One Clinical Event, Multiple Perspectives**, di mana satu fakta pelaksanaan tindakan menjadi sumber tunggal bagi beberapa perspektif bisnis:
1. **Perspektif Asuhan Klinis:** Memastikan kesinambungan pelayanan, kejelasan akuntabilitas tenaga kesehatan pelaksana, dan dokumentasi riwayat intervensi yang diterima pasien.
2. **Perspektif Finansial / Billing:** Menjadi dasar pembentukan *charge* (komponen rincian tagihan) pasien apabila tindakan memiliki konsekuensi tarif sesuai penjamin dan kelas rawat pasien, tanpa menyamakan tindakan itu sendiri dengan transaksi keuangan.
3. **Perspektif Logistik / Pemakaian Barang:** Menjadi dasar keterkaitan apabila tindakan memerlukan bahan medis habis pakai (BMHP), di mana pencatatan pengurangan dan penggunaan barang dikelola pada domain terpisah (*Pakai Barang*).

Tanpa pencatatan pelaksanaan tindakan yang sah dan akuntabel, rumah sakit tidak dapat membuktikan pertanggungjawaban pelayanan yang telah diberikan kepada pasien, kehilangan dasar penerbitan komponen tagihan tindakan yang valid, serta mengaburkan transparansi kinerja klinis tenaga kesehatan.

---

## 2. Outcome Statement

Aktivitas pelayanan medis, keperawatan, atau prosedur klinis yang dilakukan oleh tenaga kesehatan kepada pasien rawat inap **telah tercatat sebagai fakta pelaksanaan pelayanan (Clinical Service Event) yang sah, akuntabel, dan siap digunakan sebagai konteks asuhan berkelanjutan serta dasar pembentukan charge tagihan pasien apabila berlaku**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | Pemilik konteks operasional: memastikan pasien berada dalam masa rawat inap aktif dan menempati bed di bangsal saat tindakan dilakukan |
| Pasien (`PAS`) | Menyediakan data identitas pasien (Nomor Rekam Medis) sebagai subjek penerima tindakan pelayanan klinis |
| Organisasi (`ORG`) | Menyediakan data master unit layanan (bangsal/ruangan) tempat tindakan dilakukan serta data Petugas Pemberi Asuhan (PPA) pelaksana tindakan |
| Tata Rekening (`TRK`) | Menyediakan aturan tarif berdasarkan kelas rawat dan penjamin, serta menerima pembentukan *charge* tagihan atas tindakan yang berkonsekuensi finansial |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `RNA-BED` Pakai Bed | Rawat Inap | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `RNA-TINDAKAN` Tindakan Rawat Inap | Rawat Inap | Capability Candidate |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Validasi & Eskalasi Scope (Aturan Governance Skill):**
> Berdasarkan Domain Catalog (Versi 2.1 authoritative), Domain Rawat Inap (`RNA`) saat ini baru mencakup: `RNA-ANTRIAN`, `RNA-BED`, `RNA-TRANSFER`, `RNA-CHARGE`, `RNA-DISCHARGE`, dan `RNA-HK`. Berbeda dengan Rawat Jalan yang memiliki `RJL-TINDAKAN` dan Gawat Darurat yang memiliki `IGD-TINDAKAN`, capability pencatatan tindakan klinis di Rawat Inap belum terdaftar di Domain Catalog.
> Sesuai aturan tata kelola skill, tim analisis **tidak membuat capability baru secara sepihak**. Oleh sebab itu, capability `RNA-TINDAKAN` (Tindakan Rawat Inap) dicantumkan sebagai **Capability Candidate** dan **dieskalasikan kepada Product Owner** untuk formalisasi persetujuan penambahan scope capability pada Domain Rawat Inap.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Fakta pelaksanaan tindakan klinis/keperawatan telah nyata-nyata dilakukan kepada pasien rawat inap dan tersimpan secara persisten dalam sistem.
- Tindakan merujuk pada pasien rawat inap yang sah dan sedang berada dalam masa perawatan aktif (sedang menempati bed di bangsal rawat inap).
- Tindakan dilakukan oleh Petugas Pemberi Asuhan (PPA) yang sah, aktif, dan teridentifikasi.
- Tindakan dilaksanakan pada unit bangsal rawat inap yang sah.
- Tindakan merujuk pada jenis tindakan yang valid dan aktif dalam katalog layanan rumah sakit.
- Tindakan memiliki kuantitas/volume pelaksanaan yang terukur (positif).
- Catatan tindakan memiliki status bisnis yang jelas: **Dilaksanakan (Performed)**, atau jika dibatalkan karena koreksi administratif menjadi **Dibatalkan Pasca Pelaksanaan (Void)**.
- Jika tindakan dilakukan berdasarkan instruksi/order dokter (CPOE), tindakan mencatat referensi keterkaitan dengan order tersebut sebagai bukti pelaksanaan order. Namun, keberadaan order bukan merupakan prasyarat mutlak pencatatan tindakan (tindakan mandiri keperawatan dan tindakan kedaruratan bangsal tetap sah dicatat tanpa order).
- Jika tindakan memiliki konsekuensi biaya sesuai aturan tarif dan jaminan pasien, fakta pelayanan ini telah memicu pembentukan komponen *charge* pada rincian tagihan (billing) pasien di domain Tata Rekening.
- Catatan tindakan memisahkan fakta pelayanan dengan pemakaian barang medis; bahan habis pakai yang digunakan tidak menjadi satu entitas dengan tindakan melainkan dikelola pada outcome terpisah (*Pakai Barang*).

### 5.2 Required Recorded Information

- **Identitas Transaksi:** Nomor identitas/referensi unik pelayanan tindakan rawat inap.
- **Identitas Pasien:** Nomor Rekam Medis (Nomor Pasien) dan nama pasien.
- **Konteks Rawat Inap:** Nomor registrasi rawat inap aktif, unit bangsal, kamar/ruangan, dan bed tempat pasien dirawat.
- **Layanan Klinis:** Jenis/nama tindakan klinis yang dilaksanakan dan kode layanan terkait.
- **Kategori Pelaksana:** Klasifikasi profesi pelaksana (misalnya: tindakan dokter spesialis, dokter umum, keperawatan/kebidanan, atau tindakan tim/kolaborasi).
- **Pelaksana Tindakan:** Identitas Petugas Pemberi Asuhan (PPA) utama dan anggota tim pelaksana (jika dilakukan secara tim).
- **Waktu Pelaksanaan:** Tanggal dan waktu aktual saat tindakan selesai/dilakukan kepada pasien.
- **Waktu Pencatatan:** Waktu pencatatan fakta tindakan ke dalam sistem.
- **Pencatat:** Identitas petugas yang memasukkan catatan tindakan.
- **Kuantitas Pelayanan:** Jumlah frekuensi/kali atau volume tindakan yang dilaksanakan (minimal 1).
- **Catatan Pelayanan:** Keterangan klinis atau catatan khusus pelaksanaan tindakan (misalnya: sisi tubuh/lokasi anatomis, respons pasien, atau instruksi pemantauan pasca tindakan).
- **Referensi Order (Kondisional):** Nomor/ID instruksi order medis jika tindakan dilakukan untuk memenuhi order dokter sebelumnya.
- **Status Finansial:** Indikasi apakah tindakan berkonsekuensi tarif atau non-tarif.
- **Referensi Charge Billing (Kondisional):** Nomor referensi komponen tagihan (*charge ID*) di Tata Rekening apabila tindakan berkonsekuensi tarif.
- **Status Bisnis Tindakan:** Status pelaksanaan saat ini (**Dilaksanakan / Performed** atau **Dibatalkan Pasca Pelaksanaan / Void**).
- **Data Pembatalan (Kondisional - jika Void):** Tanggal dan waktu pembatalan, alasan pembatalan bisnis yang dapat dipertanggungjawabkan, serta identitas petugas yang melakukan pembatalan.

### 5.3 Required Business Conditions

- Pasien harus terdaftar sebagai pasien rawat inap yang aktif pada saat tindakan dilakukan (tidak boleh berstatus belum masuk bangsal atau sudah pulang/discharged).
- Tenaga kesehatan pelaksana (PPA) harus terdaftar aktif dalam organisasi dan memiliki kewenangan klinis sesuai tindakan yang dilakukan.
- Waktu pelaksanaan tindakan harus berada dalam rentang waktu masa rawat inap pasien (setelah waktu masuk bangsal dan sebelum waktu kepulangan).
- Jenis tindakan harus merupakan layanan yang aktif dan diizinkan untuk dilakukan pada unit bangsal yang bersangkutan.
- Kuantitas tindakan harus berupa angka bulat positif (> 0).
- Apabila tindakan berkonsekuensi tarif, tarif yang diterapkan harus mengacu pada kelas rawat inap pasien dan tipe penjamin yang aktif pada episode perawatan tersebut.
- Satu catatan tindakan merepresentasikan satu kejadian pelayanan nyata pada satu satuan waktu.

### 5.4 Completion Proof

- Catatan tindakan tersimpan secara persisten dengan nomor referensi transaksi pelayanan yang unik.
- Status tindakan berstatus **Dilaksanakan (Performed)**.
- Tindakan dapat ditelusuri dan diverifikasi melalui riwayat pelayanan pasien, nomor rekam medis, bangsal rawat, maupun tenaga kesehatan pelaksana.
- Apabila tindakan bertarif, komponen *charge* tagihan yang merujuk pada tindakan ini telah terbentuk dan dapat diverifikasi pada rincian tagihan (billing) pasien di domain Tata Rekening.
- Catatan tindakan siap digunakan oleh tenaga kesehatan lain sebagai referensi asuhan klinis lanjutan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika tenaga kesehatan (PPA) telah selesai atau sedang melaksanakan aktivitas pelayanan klinis/keperawatan kepada pasien rawat inap, dan memulai pencatatan fakta pelaksanaan pelayanan tersebut ke dalam sistem operasional bangsal, baik yang didasari oleh adanya instruksi/order medis sebelumnya maupun sebagai tindakan klinis/keperawatan mandiri.

### End

Berakhir ketika fakta bahwa tindakan telah selesai dilakukan berhasil tersimpan secara persisten dalam sistem dengan seluruh atribut bisnis yang disyaratkan berstatus **Dilaksanakan (Performed)**, serta berhasil meneruskan informasi konsekuensi tarif ke domain Tata Rekening untuk pembentukan *charge* tagihan pasien apabila tindakan tersebut berstatus bertarif.

Outcome ini juga dianggap selesai pada kondisi terminal alternatif apabila pencatatan tindakan yang salah berhasil diubah status bisnisnya menjadi **Dibatalkan Pasca Pelaksanaan (Void)** disertai alasan koreksi bisnis yang sah dan penyesuaian tagihan terkait di domain Tata Rekening.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Fakta Pelaksanaan Aktual:** Tindakan hanya boleh dicatat jika aktivitas pelayanan klinis benar-benar telah dilaksanakan kepada pasien. Rencana tindakan atau instruksi dokter (order) tidak boleh dicatat sebagai Outcome Tindakan.
- **Konteks Rawat Inap Aktif:** Pasien harus memiliki status rawat inap aktif dan sedang menempati bed di bangsal. Tindakan tidak boleh dicatat untuk pasien yang belum teregistrasi di bangsal atau yang telah berstatus pulang (*discharged*).
- **Keabsahan Pelaksana:** Petugas Pemberi Asuhan (PPA) pelaksana harus merupakan tenaga kesehatan yang sah, aktif, dan terdaftar dalam sistem.
- **Batasan Waktu Klinis:** Waktu pelaksanaan tindakan tidak boleh berada di masa depan (*future timestamp*) dan tidak boleh terjadi sebelum waktu pasien resmi masuk rawat inap.
- **Pemisahan dari Bahan/Barang Medis:** Barang atau bahan medis yang digunakan dalam tindakan (seperti IV catheter, spuit, cairan infus, verban) tidak dicatat sebagai bagian dari entitas tindakan, melainkan harus dicatat melalui Outcome terpisah (*OC-06-05 Pakai Barang*).
- **Pemisahan dari Domain Billing & Pembayaran:** Tindakan bukan merupakan transaksi kasir atau bukti pembayaran. Tindakan hanya menjadi pemicu pembentukan charge tagihan (*charge generator*).
- **Integritas Pembatalan (Void):** Tindakan yang sudah menghasilkan charge tagihan tidak dapat dibatalkan (di-void) tanpa membatalkan atau merekonsiliasi komponen charge terkait di domain Tata Rekening.
- **Finalitas Tindakan yang Telah Dilunasi:** Tindakan yang komponen tagihannya telah dilunasi/diselesaikan di kasir tidak dapat dibatalkan (di-void) secara sepihak sebelum transaksi pembayaran di Tata Rekening diselesaikan melalui prosedur koreksi keuangan/restitusi yang sah.
- **Sifat Terminal Status Void:** Catatan tindakan yang telah berstatus *Void* tidak dapat diaktifkan kembali (*un-void*). Jika tindakan serupa memang dilakukan, harus dilakukan pencatatan tindakan baru.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak berstatus rawat inap aktif (belum masuk bangsal atau sudah berstatus pulang/discharge) | Pencatatan tindakan ditolak. Sistem menginformasikan bahwa tindakan bangsal hanya dapat dicatat untuk pasien rawat inap yang aktif menempati bed. |
| Tenaga kesehatan pelaksana (PPA) tidak valid atau non-aktif | Pencatatan tindakan ditolak. Sistem mewajibkan pemilihan tenaga kesehatan yang terdaftar aktif. |
| Waktu pelaksanaan berada di masa depan (*future date/time*) | Pencatatan tindakan ditolak. Waktu pelaksanaan harus merupakan waktu nyata yang telah berlalu. |
| Waktu pelaksanaan mendahului waktu masuk rawat inap pasien | Pencatatan tindakan ditolak. Waktu tindakan tidak boleh berada di luar masa perawatan rawat inap pasien. |
| Jenis tindakan tidak valid atau non-aktif pada katalog layanan | Pencatatan tindakan ditolak. Layanan tindakan yang dipilih harus aktif dan tersedia untuk unit bangsal bersangkutan. |
| Kuantitas pelayanan kurang dari 1 atau tidak valid | Pencatatan tindakan ditolak. Kuantitas pelaksanaan tindakan harus bernilai bulat positif (minimal 1). |
| Tarif tindakan tidak ditemukan dalam konfigurasi jaminan/kelas rawat (untuk tindakan bertarif) | Fakta pelayanan klinis tetap tercatat dengan status *Dilaksanakan*, namun status integrasi finansial ditandai membutuhkan penyesuaian tarif, serta diterbitkan notifikasi administratif ke Tata Rekening tanpa membatalkan fakta klinis. |
| Permintaan pembatalan (*Void*) tanpa disertai alasan pembatalan | Pembatalan tindakan ditolak. Alasan pembatalan dan identitas petugas pembatal wajib diisi demi akuntabilitas audit klinis. |
| Permintaan pembatalan (*Void*) atas tindakan yang tagihannya sudah lunas/dikunci oleh kasir | Pembatalan tindakan ditolak. Proses pembatalan harus melalui verifikasi dan prosedur koreksi keuangan di Tata Rekening terlebih dahulu. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Tindakan rawat inap tercatat dengan nomor transaksi unik, merujuk pada nomor rekam medis pasien, registrasi rawat inap aktif, jenis tindakan, unit bangsal, tanggal/waktu pelaksanaan aktual, dan PPA pelaksana yang sah. | Completeness |
| AC-02 | Status awal tindakan yang berhasil dicatat adalah **Dilaksanakan (Performed)**. | Completeness |
| AC-03 | Catatan tindakan dapat dicari, ditemukan, dan diverifikasi kembali berdasarkan nomor rekam medis, nomor registrasi rawat inap, tanggal pelaksanaan, atau nama PPA pelaksana. | Correctness |
| AC-04 | Untuk tindakan yang berstatus bertarif, pencatatan tindakan secara otomatis memicu terbentuknya komponen *charge* pada rincian tagihan (billing) pasien di Tata Rekening sesuai kelas rawat dan penjamin pasien. | Correctness |
| AC-05 | Jika tindakan dilakukan berdasarkan order dokter (CPOE), referensi nomor order tercatat pada data tindakan dan order tersebut terverifikasi telah terpenuhi/dilaksanakan. | Correctness |
| AC-06 | Tindakan keperawatan mandiri atau prosedur darurat dapat dicatat secara sah tanpa harus didahului oleh order dokter. | Correctness |
| AC-07 | Pencatatan tindakan tidak mencakup atau mengurangi stok fisik bahan/barang medis secara langsung; pemakaian barang terpisah ke Outcome Pakai Barang. | Correctness |
| AC-08 | Tindakan ditolak jika dicatat untuk pasien yang belum menempati bed atau yang sudah keluar (*discharged*) dari rawat inap. | Constraint |
| AC-09 | Tindakan ditolak jika waktu pelaksanaan yang dicatat berada di masa depan atau mendahului waktu masuk rawat inap pasien. | Constraint |
| AC-10 | Tindakan ditolak jika PPA pelaksana yang dipilih tidak terdaftar aktif dalam organisasi rumah sakit. | Constraint |
| AC-11 | Tindakan yang dibatalkan karena koreksi administratif berubah status menjadi **Dibatalkan Pasca Pelaksanaan (Void)** dengan mencatat waktu pembatalan, alasan pembatalan, dan identitas petugas pembatal. | Exception |
| AC-12 | Pembatalan (*Void*) atas tindakan yang telah menghasilkan charge tagihan secara otomatis memicu pembatalan/void komponen charge terkait pada billing pasien di Tata Rekening. | Exception |
| AC-13 | Tindakan yang tagihannya telah berstatus lunas/selesai di kasir ditolak untuk di-void secara langsung sebelum prosedur keuangan di Tata Rekening diselesaikan. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penerbitan instruksi medis atau order pemeriksaan/tindakan klinis oleh dokter (CPOE) → **SC-05 / SC-06 CPOE / Medical Order**.
- Pendokumentasian resume klinis lengkap, catatan perkembangan pasien terintegrasi (CPPT), asesmen medis, dan rekam medis elektronik → **Domain EMR / Rekam Medis Klinis**.
- Pencatatan pemakaian dan pengurangan stok bahan medis habis pakai (BMHP) atau obat yang digunakan saat tindakan → **OC-06-05 Pakai Barang** (`INV-PAKAI`).
- Penentuan dan pengelolaan master tarif rumah sakit → **Tata Rekening Domain** (`TRK-TARIF`).
- Pengelolaan rincian tagihan, diskon, dan kalkulasi tagihan kumulatif pasien → **OC-02-01 Rincian Tagihan Pasien** (`TRK-BILLING`).
- Penerimaan pembayaran, pelunasan kasir, dan penutupan shift kasir → **SC-03 Kasir** (`TRK-PAYMENT`, `TRK-KASIR`).
- Pengelolaan penempatan bed dan perpindahan pasien antar ruangan/bangsal → **OC-06-02 Pakai Bed** (`RNA-BED`) & **OC-06-03 Transfer Unit** (`RNA-TRANSFER`).
- Proses pemulangan operasional pasien dari rawat inap → **OC-06-04 Discharge** (`RNA-DISCHARGE`).
- Desain antarmuka pengguna (UI), tata letak layar (*layout*), form input, maupun spesifikasi teknis database/API.
