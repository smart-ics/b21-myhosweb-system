# OUTCOME: Charge

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-03          |
| Version     | 2.0               |
| Status      | Final Draft       |
| LastUpdated | 2026-10-05        |

---

## 1. Business Purpose

Pelayanan pemeriksaan laboratorium memerlukan kepastian aspek administratif dan pembiayaan sebelum tindakan klinis lanjutan (pengambilan spesimen dan pengujian laboratorium) dapat dilaksanakan.

OC-08-03 bertanggung jawab atas pemrosesan **Charge** pada Order Laboratorium — yaitu memastikan order laboratorium telah memiliki status **pembiayaan yang terpenuhi**, mengeksekusi command/action Charge terhadap order tersebut, dan menetapkan status Order Laboratorium menjadi **`Charged`** secara menyeluruh (*whole order*).

Dengan tercapainya status `Charged`, order laboratorium secara resmi memenuhi syarat dari sisi pembiayaan untuk dievaluasi kelayakannya saat akan dilanjutkan ke tahapan pelayanan berikutnya, yaitu **Sample Collection** (OC-08-04). OC-08-03 tidak mengambil alih pengelolaan finansial (yang merupakan domain Tata Rekening dan Kasir) serta tidak mengelola prosedur fisik pengambilan sampel (yang merupakan domain Sample Collection).

Apabila pembiayaan ditarik atau dibatalkan (misal: void di Kasir atau revokasi penjaminan di Tata Rekening) sebelum proses Sample Collection dilakukan, status order kembali menjadi **`Ordered`** sebagai konsekuensi langsung dari kondisi pembiayaan yang tidak lagi terpenuhi.

---

## 2. Outcome Statement

Order pemeriksaan laboratorium yang sebelumnya berstatus `Ordered` telah diverifikasi memiliki **pembiayaan yang terpenuhi** dan berhasil di-Charge, sehingga tercatat dengan status bisnis **`Charged`** untuk keseluruhan order, memenuhi syarat pembiayaan untuk dievaluasi pada saat proses **Sample Collection**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik utama outcome: menerima command Charge, memvalidasi prasyarat pembiayaan, memperbarui status Order Laboratorium menjadi `Charged`, dan memelihara lifecycle order laboratorium. |
| Tata Rekening | Menyediakan fakta bisnis kelayakan pembiayaan order (apakah penjaminan/tagihan telah sah dan disetujui untuk diproses). |
| Kasir | Menyediakan fakta bisnis penyelesaian pembayaran kasir apabila skema pembiayaan order mensyaratkan pembayaran langsung sebelum pemeriksaan. |
| Organisasi | Menyediakan identitas pengguna terautentikasi dengan hak akses modul Laboratorium atau Kasir yang mengeksekusi atau memicu command Charge. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `KSR-ORDER` Order Bayar | Kasir | Known |
| `ORG-USER` User & Petugas | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Order Laboratorium yang menjadi target Charge valid dan terdaftar dalam sistem.
- Status Order Laboratorium sebelum Charge adalah `Ordered` (atau sudah `Charged` pada skenario eksekusi ulang yang idempotent).
- Status **pembiayaan yang terpenuhi** atas order laboratorium tersebut telah terkonfirmasi dari domain Tata Rekening/Kasir.
- Status Order Laboratorium tercatat secara persisten sebagai **`Charged`** untuk keseluruhan order (berlaku pada level order, bukan individual item).
- Identitas eksekutor (pengguna terautentikasi dengan hak akses modul Laboratorium/Kasir, atau Sistem pada eksekusi otomatis) dan waktu eksekusi Charge tercatat.
- Order yang berstatus `Charged` memenuhi prasyarat pembiayaan untuk evaluasi kelayakan pada tahapan downstream (Sample Collection).
- Jika terjadi pembatalan pembiayaan (misal: void transaksi di Kasir atau revokasi penjaminan di Tata Rekening) saat order berstatus `Charged` dan Sample Collection belum dilakukan, status Order Laboratorium kembali menjadi **`Ordered`** karena pembiayaan tidak lagi terpenuhi.

### 5.2 Required Recorded Information

- Identitas Order Laboratorium (Order ID).
- Status Order Laboratorium terbaru (**`Charged`**, atau kembali ke **`Ordered`** jika terjadi pembatalan pembiayaan sebelum Sample Collection).
- Waktu status `Charged` atau reversion ditetapkan (Timestamp).
- Identitas Petugas/Pengguna atau Sistem yang mengeksekusi command Charge (User ID / System Actor).
- Mekanisme Pemicu / Trigger Source (Manual atau Otomatis/Event-Driven).
- Referensi status pemenuhan pembiayaan dari domain Tata Rekening / Kasir.

### 5.3 Required Business Conditions

- Order Laboratorium harus berada dalam status aktif yang dapat diproses (status awal `Ordered`).
- Order yang berstatus `Cancelled` tidak dapat di-Charge.
- Status pembiayaan atas order harus telah terkonfirmasi sebagai **pembiayaan yang terpenuhi** oleh domain finansial (Tata Rekening / Kasir).
- Command Charge dapat dieksekusi oleh siapa pun pengguna terautentikasi yang memiliki hak akses ke modul Laboratorium atau modul Kasir (tidak dibatasi role jabatan spesifik), atau dipicu secara otomatis oleh sistem.
- Mekanisme trigger command Charge menerapkan kombinasi berbasis jenis penjaminan dan jenis kunjungan pasien:
  - **Otomatis (*event-driven*)**: Diterapkan pada skema penjaminan tanpa bayar langsung di muka (misal: BPJS, Asuransi, atau Pasien Rawat Inap dengan tagihan berjalan), dipicu saat penjaminan/kelayakan pembiayaan terkonfirmasi sah.
  - **Manual/Transaksional**: Diterapkan pada skema bayar langsung di muka (misal: Pasien Umum Rawat Jalan), dieksekusi oleh pengguna berwenang di Kasir/Laboratorium setelah pembayaran diselesaikan.
- Charge berlaku secara atomik untuk keseluruhan Order Laboratorium; tidak diperkenankan pemisahan status Charge per individual item pemeriksaan.
- Jika order sudah berstatus `Charged`, pemanggilan ulang command Charge harus tetap berhasil dan menghasilkan status `Charged` secara idempotent tanpa duplikasi transaksi finansial atau anomali data.
- **Sample Collection Eligibility** tidak disimpan sebagai flag atau state persisten pada Order Laboratorium, melainkan dievaluasi secara dinamis oleh proses Sample Collection.
- Setelah status beralih menjadi `Charged`, order terkunci dari edit item maupun pembatalan langsung melalui alur normal OC-08-02.
- **Status Reversion on Financial Cancellation**: Apabila pembiayaan tidak lagi terpenuhi akibat pembatalan finansial (void kasir / pencabutan penjaminan), Order Laboratorium yang berstatus `Charged` otomatis kembali menjadi `Ordered`, dengan syarat mutlak **proses Sample Collection belum dilakukan**.
- Order yang kembali ke status `Ordered` kehilangan kelayakan untuk Sample Collection, dan kembali terbuka untuk pemrosesan pembiayaan ulang atau pembatalan sesuai ketentuan OC-08-02.
- Apabila proses Sample Collection telah dilakukan (`Sample Collected` atau status tahapan berikutnya), pembatalan finansial tidak boleh meregresikan status klinis order secara otomatis.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Order Laboratorium tersimpan dengan status bisnis **`Charged`**.
- Catatan audit/riwayat mencatat waktu dan pelaku (pengguna atau sistem) perubahan status menjadi `Charged`.
- Permintaan evaluasi kelayakan oleh proses Sample Collection mengakui bahwa aspek pembiayaan order telah terpenuhi (`Charged`).

---

## 6. Outcome Boundary

### Start

Dimulai ketika command/action Charge dieksekusi terhadap Order Laboratorium yang berstatus `Ordered`, baik secara otomatis (*event-driven*) maupun secara manual oleh pengguna berwenang, berbasis kombinasi jenis penjaminan dan jenis kunjungan pasien.

### End

Berakhir ketika Order Laboratorium berhasil bertransisi status menjadi **`Charged`** (atau dikonfirmasi tetap `Charged` secara idempotent) dan tersimpan secara persisten, siap menjadi subjek evaluasi kelayakan pada saat proses Sample Collection (OC-08-04) diinisiasi.

### Batas Tanggung Jawab

- **Batas terhadap Tata Rekening & Kasir:** OC-08-03 tidak mengelola kalkulasi tarif, pencatatan piutang/invoice, penerimaan kas, alokasi penjaminan, maupun penerbitan kwitansi. Domain Tata Rekening dan Kasir bertanggung jawab penuh atas seluruh mekanisme finansial tersebut. OC-08-03 hanya mengonsumsi fakta bisnis apakah pembiayaan order telah terpenuhi. Jika pembiayaan dibatalkan (void) sebelum Sample Collection, OC-08-03 mengembalikan order ke `Ordered`.
- **Batas terhadap Sample Collection (OC-08-04):** OC-08-03 tidak melakukan pengambilan spesimen darah/cairan, tidak mengelola tabung atau barcode sampel, dan tidak menyimpan state `Sample Collection Eligibility`. Evaluasi kelayakan dilakukan sepenuhnya di sisi OC-08-04 saat alur pengambilan sampel dimulai. Jika Sample Collection telah berlangsung, pembatalan finansial tidak dapat meregresikan status order klinis.
- **Batas terhadap Order Laboratorium (OC-08-02):** Perubahan item pemeriksaan dan pembatalan order di bawah wewenang OC-08-02 berakhir begitu order memasuki status `Charged`. Namun jika order berstatus `Charged` kembali ke `Ordered` karena void pembiayaan sebelum Sample Collection, order kembali berada dalam wewenang pengelolaan OC-08-02.

---

## 7. Business Constraints

- **Prasyarat Pembiayaan yang Terpenuhi**: Order Laboratorium hanya dapat di-Charge apabila memiliki status pembiayaan yang terpenuhi sesuai kebijakan penjaminan pasien (misal: pembayaran kasir terkonfirmasi untuk pasien umum, verifikasi penjaminan sah untuk BPJS/asuransi, atau tagihan disetujui dibebankan pada deposit/rawat inap).
- **Makna Bisnis "Pembiayaan yang Terpenuhi"**: Istilah "Charged" tidak boleh diartikan semata-mata sebagai "pembayaran lunas". Status ini menandakan bahwa pembiayaan order telah memenuhi syarat operasional rumah sakit untuk melanjutkan pemeriksaan klinis.
- **Whole-Order Granularity**: Status `Charged` berlaku untuk keseluruhan Order Laboratorium secara utuh. Tidak ada status Charge parsial pada level individual order item.
- **Command Idempotency**: Pemanggilan command Charge terhadap order yang sudah berstatus `Charged` harus menghasilkan respons sukses dan mempertahankan status `Charged` secara idempotent tanpa efek samping finansial atau duplikasi pencatatan.
- **Dynamic Sample Collection Eligibility**: Kelayakan Sample Collection bukan merupakan kolom atau status tersimpan pada entitas Order Laboratorium, melainkan hasil evaluasi logika pada saat tahapan Sample Collection dijalankan.
- **No Speculative States**: Tidak diperkenankan menambahkan status atau flag perantara baru (seperti `Partially Charged`, `Pending Payment`, atau `Eligible For Collection`) yang belum didefinisikan secara resmi.
- **Order Immutability Post-Charge**: Setelah order berstatus `Charged`, komposisi item pemeriksaan tidak dapat diubah atau dibatalkan melalui alur normal OC-08-02.
- **Broad Charge Executor Authorization**: Otorisasi eksekusi command Charge tidak dibatasi pada role profesi/jabatan tertentu; siapa pun pengguna terautentikasi yang memiliki hak akses ke modul Laboratorium atau modul Kasir berwenang mengeksekusi command Charge terhadap Order Laboratorium.
- **Flexible Trigger Mechanism based on Guarantee/Visit Scheme**: Command Charge mendukung eksekusi baik secara otomatis (*event-driven*) maupun manual/transaksional, ditentukan oleh kombinasi jenis penjaminan dan jenis kunjungan pasien (otomatis untuk skema penjaminan tanpa bayar di muka seperti BPJS, Asuransi, atau Rawat Inap; dan manual/kasir untuk skema pembayaran langsung seperti Pasien Umum Rawat Jalan).
- **Status Reversion upon Financial Revocation Prior to Sample Collection**: Order Laboratorium berstatus `Charged` otomatis kembali ke status `Ordered` sebagai konsekuensi pembiayaan tidak lagi terpenuhi apabila terjadi pembatalan transaksi di Kasir (void) atau pencabutan penjaminan di Tata Rekening, dengan syarat mutlak **selama Sample Collection belum dilakukan**. Apabila Sample Collection telah dilakukan, pembatalan finansial tidak boleh meregresikan status order klinis secara sepihak.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| Order Laboratorium tidak ditemukan / ID tidak valid | Command Charge ditolak. Order harus valid dan terdaftar. |
| Pengguna tidak memiliki hak akses ke modul Laboratorium maupun Kasir | Command Charge ditolak. Pengguna harus terautentikasi dan memiliki hak akses minimal ke modul Laboratorium atau Kasir. |
| Status pembiayaan belum terpenuhi (belum ada konfirmasi pembayaran/penjaminan dari Tata Rekening/Kasir) | Command Charge ditolak. Order tetap pada status sebelumnya (`Ordered`) dan tidak dapat dilanjutkan ke Sample Collection. |
| Order Laboratorium berstatus `Cancelled` | Command Charge ditolak. Order yang telah dibatalkan tidak dapat di-Charge. |
| Order Laboratorium sudah berada pada status downstream (`Sample Collected`, `Processing`, `Resulted`, `Released`) | Command Charge tidak mengubah status downstream dan tidak menyebabkan regresi status. |
| Pembatalan pembiayaan (void kasir / revokasi penjamin) saat order sudah memasuki tahapan downstream (`Sample Collected`, dst.) | Penurunan status order secara otomatis ditolak. Status klinis order tidak diregresikan secara sepihak; penyelesaian finansial dilakukan melalui tata kelola retur/dispute operasional antar unit. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Order Laboratorium berstatus `Ordered` yang telah memiliki pembiayaan yang terpenuhi berhasil beralih status menjadi **`Charged`** saat command Charge dieksekusi. | Completeness |
| AC-02 | Perubahan status menjadi `Charged` berlaku untuk keseluruhan Order Laboratorium, mencakup seluruh item pemeriksaan di dalamnya. | Correctness |
| AC-03 | Command Charge ditolak apabila status pembiayaan order belum terpenuhi berdasarkan verifikasi dari domain Tata Rekening / Kasir. | Constraint |
| AC-04 | Command Charge terhadap order yang sudah berstatus `Charged` tetap berhasil secara idempotent dengan status order tetap `Charged` tanpa menimbulkan efek samping ganda. | Correctness |
| AC-05 | Command Charge ditolak apabila dieksekusi terhadap order yang berstatus `Cancelled`. | Constraint |
| AC-06 | Status kelayakan untuk Sample Collection (*Sample Collection Eligibility*) tidak disimpan sebagai state atau flag pada entitas Order Laboratorium. | Constraint |
| AC-07 | Proses Charge tidak melakukan perhitungan tarif, penerimaan uang kas, atau pencatatan jurnal piutang/finansial (seluruh proses finansial tetap berada pada domain Tata Rekening/Kasir). | Boundary |
| AC-08 | Setelah order berstatus `Charged`, pengeditan item pemeriksaan dan pembatalan langsung melalui OC-08-02 tidak dapat dilakukan lagi. | Boundary |
| AC-09 | Command Charge dapat dieksekusi oleh siapa pun pengguna terautentikasi yang memiliki hak akses ke modul Laboratorium atau modul Kasir, dan eksekusi ditolak jika pengguna tidak memiliki hak akses tersebut. | Correctness |
| AC-10 | Command Charge dapat dieksekusi secara otomatis (*event-driven*) untuk skema penjaminan tanpa bayar di muka atau secara manual/transaksional untuk skema pembayaran langsung, sesuai kombinasi jenis penjaminan dan jenis kunjungan pasien. | Correctness |
| AC-11 | Order Laboratorium berstatus `Charged` otomatis kembali ke status `Ordered` saat terjadi pembatalan pembiayaan (void kasir / revokasi penjaminan), dengan syarat mutlak proses Sample Collection belum dilakukan. | Correctness |
| AC-12 | Pembatalan pembiayaan tidak meregresikan status Order Laboratorium apabila order telah memasuki atau melewati tahapan Sample Collection (`Sample Collected` atau status lanjutan). | Constraint |
| AC-13 | Order Laboratorium yang kembali ke status `Ordered` kehilangan kelayakan untuk Sample Collection hingga pembiayaannya kembali terpenuhi. | Constraint |

---

## 10. Out of Scope

- Mekanisme pembayaran kasir, penerimaan uang tunai/non-tunai, dan penutupan shift kasir → **Kasir Domain** (`OC-03-01`, `OC-03-02`).
- Pengelolaan rincian tagihan, kalkulasi tarif, alokasi penjaminan, dan deposit pasien → **Tata Rekening Domain** (`OC-02-01`, `OC-02-02`, `OC-02-03`).
- Pembuatan dan pemeliharaan awal Order Laboratorium pada status `Ordered` → **OC-08-02 Order Laboratorium**.
- Pengambilan spesimen fisik, pencatatan wadah/tabung sampel, pelabelan barcode spesimen, dan evaluasi kelayakan koleksi sampel → **OC-08-04 Sample Collection**.
- Pengelolaan hasil pemeriksaan laboratorium → **OC-08-05 Result Management**.
- Prosedur pembatalan/void transaksi finansial kasir → **Kasir Domain** (`OC-03-01`).

---

## 11. Business Decisions & Open Questions

### Confirmed Decisions

1. **Definisi Charge**: Charge adalah proses memastikan order laboratorium telah memiliki status pembiayaan yang memenuhi syarat untuk dilanjutkan ke pemeriksaan.
2. **Outcome State**: Menghasilkan Order Laboratorium berstatus **`Charged`** untuk keseluruhan order.
3. **Makna Bisnis "Pembiayaan yang Terpenuhi"**: Charged tidak berarti pembayaran tunai lunas, melainkan pembiayaan telah terpenuhi sesuai skema penjaminan pasien (Umum, BPJS, Asuransi, Rawat Inap).
4. **Whole Order Level**: Status `Charged` melekat pada level order laboratorium, bukan individual item pemeriksaan.
5. **Command Semantics & Idempotency**: Charge merupakan command/action pada Order Laboratorium yang wajib idempotent jika dipanggil berulang kali pada order yang sudah `Charged`.
6. **Separation of Concerns Finansial**: Mekanisme finansial tetap menjadi tanggung jawab domain Tata Rekening dan Kasir; OC-08-03 tidak mengambil alih fungsi kasir atau billing.
7. **Dynamic Sample Collection Eligibility**: Sample Collection Eligibility bukan state atau flag yang disimpan pada Order Laboratorium, melainkan hasil evaluasi pada saat proses Sample Collection diinisiasi.
8. **Lean State Model**: Tidak menambahkan status perantara baru (seperti Partially Charged atau Pending Payment).
9. **Otorisasi Eksekutor Command Charge (OQ#3)**: Siapa pun pengguna terautentikasi yang memiliki hak akses ke modul Laboratorium atau modul Kasir berwenang mengeksekusi command Charge pada Order Laboratorium (tidak dibatasi role jabatan spesifik).
10. **Mekanisme Pemicu Command Charge (OQ#1)**: Eksekusi command Charge menerapkan kombinasi berbasis jenis penjaminan dan jenis kunjungan pasien — mendukung pemicu otomatis (*event-driven*) untuk skema penjaminan tanpa bayar langsung di muka (misal: BPJS, Asuransi Perusahaan, Rawat Inap dengan tagihan berjalan) dan pemicu manual/transaksional oleh pengguna berwenang untuk skema bayar langsung (misal: Pasien Umum Rawat Jalan).
11. **Dampak Pembatalan Pembiayaan / Void Kasir (OQ#2)**: Order Laboratorium berstatus `Charged` otomatis kembali menjadi `Ordered` sebagai konsekuensi pembiayaan tidak lagi terpenuhi, dengan catatan syarat mutlak: **selama Sample Collection belum dilakukan**. Order yang kembali ke status `Ordered` kehilangan kelayakan untuk Sample Collection dan dapat diproses pembiayaan ulang atau dibatalkan sesuai alur OC-08-02. Jika Sample Collection sudah dilakukan, pembatalan finansial tidak boleh meregresikan status order klinis secara sepihak.

### Open Questions

*Tidak ada Open Question yang belum terselesaikan. Seluruh pertanyaan bisnis (OQ#1 s/d OQ#3) telah diputuskan secara definitif oleh Product Owner dan diintegrasikan ke dalam spesifikasi Outcome ini.*
