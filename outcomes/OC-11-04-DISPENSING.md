# OUTCOME: Dispensing

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-04     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-07   |

---

## 1. Business Purpose

Dispensing adalah outcome bisnis yang mendefinisikan pelaksanaan pekerjaan penyiapan obat oleh instalasi farmasi / Apotek secara fisik, pengelolaan tanggung jawab penyimpanan dan pengawasan fisik sementara (*physical custody*), pemeriksaan internal mutu dan ketepatan obat (*internal pharmacy verification/double-check*), hingga terciptanya kesiapan fisik penyerahan (*Ready for Pickup*) atau terselesaikannya seluruh konsekuensi fisik akibat pembatalan maupun ketiadaan pengambilan obat (*No-Show Physical Resolution*).

Tujuan bisnis Dispensing adalah:
1. **Menjamin Akuntabilitas Penyiapan Fisik (*Physical Preparation Accountability*):** Merepresentasikan eksekusi penyiapan obat nyata (pengambilan barang dari rak, peracikan, pelabelan etiket, pengemasan) dalam bentuk pekerjaan penyiapan (*Dispensing Job*) yang terlacak secara transparan dari saat pekerjaan diterima hingga selesai dikerjakan.
2. **Memastikan Keselamatan Pasien Melalui Verifikasi Internal (*Internal Verification & Quality Safety*):** Memastikan setiap obat yang disiapkan telah melalui pemeriksaan kesesuaian internal oleh tenaga kefarmasian yang berwenang sebelum dinyatakan siap diserahkan kepada pihak penerima.
3. **Mengelola Tanggung Jawab Fisik Sementara (*Temporary Physical Custody Management*):** Menjamin bahwa setiap butir/satuan obat yang telah disiapkan berada di lokasi penyimpanan sementara yang jelas, teridentifikasi, dan dapat dipertanggungjawabkan selama masa tunggu pengambilan (*collection window*), serta mencegah hilangnya akuntabilitas fisik obat di lingkungan apotek.
4. **Menyelesaikan Disposisi Fisik pada Kondisi Pengecualian dan No-Show (*Accountable Physical Disposition*):** Memastikan bahwa apabila obat yang telah siap tidak diambil oleh pasien hingga masa tunggu berakhir (*Collection Expired*), farmasi bertanggung jawab penuh menyelesaikan fisik sediaan tersebut melalui tindakan disposisi yang sah (pengembalian ke stok aktif untuk item yang memenuhi syarat kelaikan, atau pemusnahan/pembuangan untuk item racikan/rusak) hingga tidak ada sisa sediaan fisik yang terlantar dalam *custody* apotek.
5. **Memelihara Batasan Operasional yang Tegas (*Operational Boundary Decoupling*):**
   - **Terhadap OC-11-03 (Penjualan):** Dispensing menerima instruksi pemenuhan yang sah (*commercial fulfillment instruction*) dan batas kuantitas komitmen (`AcceptedQty`), namun Dispensing tidak mengelola faktur, harga, diskon, pembayaran kasir, piutang, refund uang, maupun klaim jaminan/BPJS.
   - **Terhadap OC-11-05 (Serah Obat):** Dispensing berakhir secara normal ketika obat mencapai status siap diserahkan (*Ready for Pickup*). Dispensing tidak mengelola verifikasi identitas pasien akhir di konter loket, edukasi penggunaan obat (KIE), maupun serah-terima fisik akhir ke tangan pasien/keluarga.

Dispensing secara tegas **BUKAN**:
- **Penjualan / Billing / Komersial:** Pembentukan pesanan penjualan (*Sales Order*), pemisahan jalur penjamin (*payer split*), penerbitan faktur tagihan (*Invoice*), dan penguncian potret harga (*Pricing Snapshot*) adalah wewenang penuh **OC-11-03 (Penjualan)**.
- **Telaah Resep:** Pengkajian administratif, farmasetis, dan klinis atas instruksi resep dokter adalah wewenang penuh **OC-11-02 (Telaah Resep)**.
- **Serah Obat:** Pemanggilan antrian loket serah, verifikasi akhir identitas penerima obat, pemberian Komunikasi, Informasi, dan Edukasi (KIE) farmasi, serta serah-terima fisik ke pasien adalah wewenang penuh **OC-11-05 (Serah Obat)**.
- **Transaksi Pembayaran / Kasir / Refund:** Penerimaan uang tunai, kliring kartu, pengembalian dana (*refund*), maupun pembatalan bukti kas adalah wewenang penuh domain **Kasir** dan **Tata Rekening**.
- **Pencatatan Buku Inventori / Stock Ledger Implementation:** Mekanisme teknis mutasi saldo kartu stok, penyesuaian akuntansi persediaan, atau algoritma penentuan batch pergudangan adalah wewenang domain **Inventory**. Dispensing hanya berinteraksi menetapkan alokasi fisik barang dan mempublikasikan fakta disposisi fisik.
- **Detail Teknis & UI:** Outcome ini tidak mencakup rancangan antarmuka layar pengguna (UI), alur layar (*screen layout*), endpoint API, tabel database, status enum internal, maupun prosedur operasional standar (SOP) administratif rumah sakit.

---

## 2. Outcome Statement

Pekerjaan penyiapan fisik obat (*Dispensing Job*) yang bersumber dari instruksi pemenuhan yang sah **telah selesai disiapkan secara fisik dan diverifikasi internal oleh farmasi serta berada dalam physical custody yang akuntabel dan siap diserahkan (Ready for Pickup), atau setiap pengecualian fisik dan kondisi No-Show yang terjadi telah diselesaikan secara sah melalui disposisi fisik definitif (Resolved / Cancelled)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Apotek (`APT`)** | Pemilik utama outcome Dispensing: mengelola siklus hidup *Dispensing Job*, mencatat penerimaan ke dalam antrian kerja (*Queued*), memonitor penyiapan fisik (*Preparing*), mengeksekusi verifikasi internal farmasi, mengelola *temporary physical custody*, menetapkan status siap serah (*Ready for Pickup*), memisahkan item yang gagal dipenuhi (*Unfulfilled*), mengelola penanganan *No-Show Resolution*, serta mengeksekusi disposisi fisik akhir hingga tuntas (*Resolved*). |
| **Inventory (`INV`)** | Kolaborator persediaan: menyediakan master identitas obat dan bentuk sediaan (`INV-MASTER`), mengonfirmasi alokasi fisik barang yang disiapkan (`INV-STOK`), menerima pengembalian fisik barang yang layak ke stok aktif, serta mencatat pemusnahan sediaan yang tidak layak pakai ulang (`INV-MUSNAH`). |
| **Organisasi (`ORG`)** | Penyedia konteks unit dan tenaga pelaksana: menyediakan identitas unit layanan farmasi/depo/stasiun penyiapan (`ORG-LAYANAN`) serta data tenaga kefarmasian yang berwenang (Apoteker, Tenaga Vokasi Farmasi / Asisten Tenaga Kefarmasian) yang bertindak sebagai penyiap (*preparer*) dan pemeriksa (*verifier*) (`ORG-PPA`). |
| **Admission (`ADM`)** | Penyedia konteks alur pasien: menerima pembaruan kemajuan fisik penyiapan obat (*Queued*, *Preparing*, *Ready for Pickup*) guna visibilitas pelacakan perjalanan pelayanan pasien (*Patient Journey Tracking* via `ADM-TRACKER`). |
| **Pasien (`PAS`)** | Subjek pelayanan: menyediakan identitas tunggal pasien yang sah (`PAS-DATSOS`) yang terhubung dengan sediaan obat yang disiapkan. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `APT-ORDER` Sales Order | Apotek | Known |
| `APT-QUEUE` Antrian Apotek | Apotek | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `INV-MUSNAH` Musnah | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

#### A. Hakikat Dispensing Job sebagai Unit Pekerjaan Fisik (*Physical Preparation Batch*)
1. Satu *Dispensing Job* merepresentasikan **satu batch pekerjaan penyiapan fisik** obat di farmasi.
2. Relasi antara instruksi komersial (*Sales Order*) dan *Dispensing Job* bersifat fleksibel operasional:
   - Tidak berlaku batasan kaku bahwa 1 Sales Order = 1 Dispensing Job.
   - Tidak berlaku batasan kaku bahwa 1 Sales Order Item = 1 Dispensing Job.
   - Satu Sales Order dapat menghasilkan satu atau beberapa *Dispensing Job* berdasarkan kebutuhan operasional penyiapan fisik (misalnya: pemisahan batch penyiapan obat jadi non-racikan dengan obat racikan puyer/kapsul/sirup, pemisahan sediaan suhu dingin/termolabil dengan suhu ruang, atau pemisahan beban kerja antar stasiun kerja farmasi).
3. Aturan pengelompokan batch penyiapan (*batch grouping rules*) tidak boleh dikunci secara kaku dalam outcome definition; pengelompokan diserahkan pada kebijakan operasional instalasi farmasi.

#### B. Konsep Keberhasilan Normal: Ready for Pickup
1. Keberhasilan normal dari Dispensing dicapai ketika *Dispensing Job* berstatus **Ready for Pickup**.
2. *Dispensing Job* dinyatakan berhasil mencapai **Ready for Pickup** HANYA JIKA memenuhi empat syarat kumulatif:
   - **Selesai Fisik:** Seluruh obat yang tercakup dalam job tersebut telah selesai diambil, diracik, dikemas, dan diberi etiket sesuai instruksi.
   - **Lolos Verifikasi Internal:** Seluruh obat telah selesai diperiksa secara internal (*double-check*) oleh tenaga kefarmasian yang berwenang (memeriksa ketepatan identitas obat, dosis, jumlah, etiket/aturan pakai, bentuk sediaan, dan integritas kemasan).
   - **Physical Custody Jelas:** Sediaan obat telah diletakkan dalam lokasi penyimpanan sementara yang teridentifikasi secara akuntabel (misalnya *holding bin*, keranjang siap serah, atau rak penyimpanan obat jadi).
   - **Siap Masuk Serah Obat:** Sediaan obat benar-benar siap diserahkan saat pasien/keluarga hadir di loket penyerahan (**OC-11-05**).
3. **Ready for Pickup BUKAN Berarti Obat Telah Diserahkan:** *Ready for Pickup* adalah batas serah-terima kewenangan (*handoff boundary*) menuju proses **OC-11-05 (Serah Obat)**. Kehadiran fisik pasien dan penerimaan fisik obat oleh pasien belum terjadi pada titik ini.
4. **Invarian All-or-Nothing (Dilarang Partially Ready for Pickup):**
   - Tidak ada status atau kondisi bisnis `Partially Ready for Pickup`.
   - Satu *Dispensing Job* HANYA BOLEH mencapai status *Ready for Pickup* jika **100% item yang menjadi bagian dari job tersebut telah siap secara fisik dan lolos verifikasi internal**.

#### C. Siklus Hidup Utama Dispensing Job
Siklus hidup normal pekerjaan penyiapan fisik mengikuti tahapan:
```text
Eligible ──► Queued ──► Preparing ──► Ready for Pickup
```
1. **Eligible:** Kebutuhan atau instruksi pemenuhan dari Sales Order telah sah secara klinis dan komersial untuk dipenuhi secara fisik oleh instalasi farmasi.
2. **Queued (Dalam Antrian Penyiapan):**
   - Pekerjaan penyiapan secara resmi masuk ke dalam antrian tanggung jawab operasional farmasi dan menunggu alokasi/pelaksanaan oleh petugas.
   - *Queued* bukan berarti petugas sudah mulai meracik/mengambil obat.
   - **Penghitungan Waktu Tunggu / Service Level Agreement (SLA):** Waktu tunggu penyiapan farmasi secara bisnis resmi mulai dihitung sejak pekerjaan memasuki status *Queued*.
3. **Preparing (Sedang Disiapkan Secara Fisik):**
   - Pekerjaan fisik (pengambilan dari rak, peracikan, pelabelan etiket) benar-benar mulai dikerjakan oleh petugas farmasi di stasiun kerja terkait.
   - Mulai tahap ini, pekerjaan merepresentasikan *physical work-in-progress* yang sedang berjalan dan mengikat tanggung jawab fisik petugas pelaksana.
4. **Ready for Pickup (Siap Diserahkan):**
   - Pekerjaan fisik selesai, verifikasi internal lolos, dan obat berada dalam *custody* siap serah.

#### D. Integritas Pekerjaan yang Sedang Berjalan (*Work-in-Progress Integrity*)
1. **Larangan Mutasi Diam-Diam (*No Silent Mutation*):** Setelah *Dispensing Job* memasuki status **Preparing**, isi pekerjaan penyiapan fisik (identitas obat, kuantitas fisik, bentuk sediaan, instruksi peracikan) dilarang diubah secara diam-diam (*silent mutation*) menjadi instruksi fisik yang berbeda.
2. **Penanganan Perubahan Instruksi Fisik / Klinis:**
   - Jika terjadi perubahan klinis dari dokter atau perubahan instruksi pemenuhan yang mengubah kebutuhan fisik obat saat pekerjaan sedang berstatus *Preparing*:
     ```text
     Dispensing Job Lama  ──►  Cancelled (secara akuntabel)
                                      ↓
     Instruksi Baru       ──►  Dispensing Job Baru
     ```
   - Pekerjaan lama harus dibatalkan secara akuntabel (**Cancelled**), mencatat alasan pembatalan klinis/operasional, dan mengembalikan/membersihkan sediaan fisik yang sempat disiapkan.
   - Kebutuhan fisik yang baru wajib menghasilkan *Dispensing Job* baru.
   - Dilarang memodifikasi isi *Dispensing Job* lama secara in-place sehingga histori pekerjaan fisik aslinya hilang atau kabur.
3. **Perubahan Administratif Non-Fisik:** Perubahan data administratif yang tidak memengaruhi instruksi fisik penyiapan (misalnya koreksi nomor telepon pasien atau catatan administratif pengantar) tidak otomatis membatalkan *Dispensing Job* yang sedang berjalan.

#### E. Pembedaan Konseptual: Cancelled vs Unfulfilled
Dispensing membedakan secara tegas dua kondisi ketidakterpenuhan:
1. **Cancelled (Dibatalkan):**
   - Digunakan ketika **kebutuhan atau instruksi yang menjadi dasar pekerjaan sudah ditarik atau tidak lagi berlaku**.
   - Contoh penyebab:
     - Terapi obat direvisi atau dihentikan oleh dokter pemeriksa;
     - Pasien membatalkan permintaan item sebelum pekerjaan selesai;
     - Kebutuhan lama ditarik karena digantikan oleh resep/instruksi baru.
   - Makna bisnis: **Tidak ada lagi kewajiban bagi farmasi untuk memenuhi kebutuhan lama tersebut**.
2. **Unfulfilled (Tidak Terpenuhi):**
   - Digunakan ketika **kebutuhan pasien masih sah dan berlaku, namun farmasi gagal menyediakan atau menyelesaikan obat tersebut**.
   - Contoh penyebab:
     - Ketiadaan stok fisik saat hendak diambil di rak farmasi (*physical stockout*);
     - Kerusakan atau kegagalan teknis saat peracikan obat yang tidak dapat digantikan segera;
     - Kendala operasional instalasi farmasi yang menghalangi penyelesaian penyiapan.
   - Makna bisnis: **Kebutuhan pasien tidak dibatalkan**. Kebutuhan tersebut tetap sah dan memerlukan resolusi/pemenuhan lanjutan di konteks yang sesuai (misalnya pemenuhan dari depo lain, pengadaan cito, konfirmasi penggantian terapi ke dokter, atau pencatatan penyesuaian komersial pada Sales Order).

> **Invarian:** *Cancelled* dilarang disamakan maknanya dengan *Unfulfilled*.

#### F. Penanganan Pemenuhan Parsial (*Partial Fulfillment Handling*)
1. **Larangan Status Partially Ready:** Satu *Dispensing Job* tidak boleh menjadi *Ready for Pickup* secara parsial.
2. **Mekanisme Pemisahan Akuntabel (*Accountable Split of Unfulfilled Items*):**
   - Jika dalam satu *Dispensing Job* terdapat sebagian item yang gagal dipenuhi (misal karena stok fisik tidak mencukupi atau rusak):
     - Item yang gagal dipenuhi harus dipisahkan secara akuntabel dari job tersebut dan dicatat status ketidakterpenuhannya sebagai **Unfulfilled**;
     - Bagian item yang berhasil disiapkan dan lolos verifikasi tetap dapat diselesaikan sebagai satu kesatuan pekerjaan yang utuh dan mencapai status **Ready for Pickup**;
     - Histori bahwa item yang *Unfulfilled* tersebut sebelumnya berasal dari batch/job yang sama wajib dapat ditelusuri secara utuh (*lineage traceability*).
3. **Kepastian Makna Ready for Pickup:** Seluruh item yang tersisa di dalam *Dispensing Job* yang berstatus *Ready for Pickup* dipastikan 100% siap fisik dan terverifikasi.

#### G. Masa Tunggu Pengambilan (*Collection Window*) dan Penanganan No-Show
1. **Hakikat Collection Window:**
   - *Collection Window* adalah masa tunggu pengambilan obat oleh pasien/keluarga yang **resmi dimulai sejak Dispensing Job mencapai status Ready for Pickup**.
   - **Prinsip Konfigurasi Kebijakan (*Policy-Driven*):** Durasi *collection window* (misalnya 24 jam, 3 hari, 7 hari, atau 14 hari) adalah **kebijakan operasional / konfigurasi sistem (*operational policy/configuration*)**, BUKAN fakta domain yang boleh di-*hardcode* ke dalam outcome definition.
   - *No-Show* didefinisikan secara bisnis sebagai kondisi ketika:
     > **Masa tunggu pengambilan (*collection window*) telah berakhir sesuai kebijakan yang berlaku, dan obat belum diserahkan kepada pasien.**
2. **Collection Expired BUKAN Terminal State:**
   - Status **Collection Expired** hanya menyatakan bahwa batas waktu pengambilan telah terlampaui (kondisi/trigger temporal).
   - Saat *Collection Expired* terjadi, obat fisik masih berada dalam penyimpanan sementara (*temporary physical custody*) farmasi. Tanggung jawab fisik Dispensing **belum selesai**.
   - Farmasi tetap memikul tanggung jawab fisik untuk menyelesaikan penanganan sediaan tersebut.
3. **Siklus Hidup Lengkap Jalur No-Show:**
   ```text
   Ready for Pickup ──► Collection Expired ──► No-Show Resolution ──► Resolved
   ```
4. **No-Show Resolution (Penyelesaian Fisik No-Show):**
   - Farmasi melakukan tindakan nyata penyelesaian *physical custody* dan menetapkan disposisi fisik yang sah (*valid physical disposition*) untuk setiap item yang tidak diambil.
   - **Kategori Disposisi Fisik yang Sah:**
     - **Pengembalian ke Stok Aktif (*Return to Available Inventory*):** Berlaku bagi sediaan obat jadi (blister/strip/botol bersegel utuh) yang memenuhi syarat kelaikan penyimpanan dan tanggal kadaluarsa memadai.
     - **Pemusnahan / Pembuangan (*Discard / Destruction*):** Berlaku bagi sediaan racikan (puyer, kapsul racikan, salep campuran, sirup kering yang telah direkonstitusi), obat yang segelnya telah terbuka, atau sediaan dengan masa simpan terbatas (*Beyond Use Date / BUD*) yang telah kadaluarsa.
     - **Disposisi Khusus Lain:** Karantina atau retur khusus sesuai regulasi farmasi setempat.
   - **Larangan Asumsi Restock Otomatis:** Dilarang mengasumsikan bahwa semua obat No-Show dapat otomatis dikembalikan ke stok persediaan aktif. Sediaan racikan yang sudah dibuat untuk pasien spesifik tidak boleh dikembalikan ke stok komersial.
5. **Resolved sebagai Terminal State Jalur No-Show:**
   - Status **Resolved** adalah status akhir definitif (*terminal state*) untuk jalur *No-Show*.
   - *Dispensing Job* baru dinyatakan **Resolved** HANYA JIKA memenuhi dua syarat:
     - **Zero Remaining Custody:** Tidak ada lagi obat fisik yang tertinggal dalam *temporary custody* pekerjaan tersebut (rak/keranjang penyimpanan kosong kembali);
     - **Accountable Physical Disposition:** Setiap item obat memiliki pencatatan disposisi fisik yang sah dan dapat dipertanggungjawabkan (berapa yang kembali ke stok, berapa yang dimusnahkan).

#### H. Pengawasan Fisik Sementara (*Physical Custody*)
1. Prinsip Pengawasan Fisik:
   > **Selama obat belum diserahkan melalui OC-11-05 atau belum diselesaikan melalui disposisi No-Show / exception yang sah, tanggung jawab physical custody Dispensing belum selesai.**
2. Dispensing memelihara akuntabilitas fisik atas keberadaan, lokasi rak/holding bin sementara, kondisi penyimpanan, dan integritas obat dari sejak barang diambil dari persediaan hingga diserahkan atau diselesaikan disposisinya.

#### I. Boundary dengan OC-11-05 (Serah Obat)
1. Keberhasilan normal Dispensing (*Ready for Pickup*) merupakan titik serah tugas operasional (*handoff boundary*) menuju OC-11-05.
2. Aktivitas berikut secara mutlak **BUKAN wewenang OC-11-04**, melainkan wewenang penuh **OC-11-05 (Serah Obat)**:
   - Pemanggilan antrian pasien di loket penyerahan obat;
   - Verifikasi identitas penerima obat di loket (mencocokkan nomor antrian, nama pasien, tanggal lahir);
   - Pemberian informasi, instruksi penggunaan, dan edukasi obat kepada pasien/keluarga (KIE);
   - Penyerahan fisik obat secara langsung ke tangan pasien/keluarga.
3. Dispensing selesai secara normal saat obat **telah siap secara fisik, terverifikasi internal, tersimpan dalam custody yang jelas, dan siap diserahkan**. Jika pasien hadir, alur berikutnya dikerjakan oleh OC-11-05.

#### J. Notifikasi Lintas Konteks (*Cross-Context Notification*)
1. Setelah disposisi fisik No-Show selesai dan status **Resolved** tercapai, Dispensing menerbitkan fakta resmi bahwa penyelesaian fisik telah selesai (*physical resolution completed*).
2. Fakta tersebut diteruskan ke konteks lain yang berkepentingan:
   - Konteks Penjualan / Tata Rekening (**OC-11-03** & **TRK**): untuk evaluasi penyesuaian komersial, pembatalan tagihan, atau nota kredit;
   - Konteks Rekam Medis / Tracking (**ADM-TRACKER**): untuk pencatatan riwayat akhir perjalanan resep.
3. **Prinsip Decoupling Downstream:** Status **Resolved** pada Dispensing **TIDAK BOLEH bergantung pada keberhasilan proses bisnis downstream**. Dispensing bertanggung jawab atas resolusi fisik barang; urusan refund uang kasir, klaim BPJS, atau penyesuaian rekening pasien adalah tanggung jawab independen dari masing-masing konteks tersebut.

#### K. Pembedaan Makna Status Akhir (*Terminal States*)
Dispensing menolak penggunaan status universal `Completed` yang menggabungkan seluruh arti. Setiap status akhir memiliki makna bisnis yang distinktif:
- **`Ready for Pickup`:** Pekerjaan fisik berhasil diselesaikan dan lolos verifikasi internal, berada dalam *custody* siap serah, namun belum diserahkan ke pasien (handoff boundary ke OC-11-05).
- **`Cancelled`:** Kebutuhan/instruksi fisik ditarik atau tidak lagi berlaku (tidak ada kewajiban pemenuhan lanjutan).
- **`Unfulfilled`:** Kebutuhan pasien masih sah, namun farmasi gagal menyediakan/menyelesaikan penyiapan fisik (memerlukan resolusi lanjutan).
- **`Collection Expired`:** Masa tunggu pengambilan berakhir, tetapi *physical custody* belum selesai (status transisi/temporal, BUKAN terminal).
- **`Resolved`:** Tanggung jawab *physical custody* akibat No-Show atau exception telah selesai secara definitif melalui disposisi fisik yang sah.

---

### 5.2 Required Recorded Information

1. **Informasi Header Dispensing Job:**
   - Nomor identitas unik *Dispensing Job*.
   - Referensi unik ke *Sales Order* dan baris instruksi asal.
   - Referensi ke episode kunjungan pasien (*Registration / Visit ID*).
   - Identitas pasien (Nomor Rekam Medis dan Nama Pasien).
   - Unit layanan farmasi / depo / ruang peracikan tempat pekerjaan dilakukan (`ORG-LAYANAN`).
   - Kategori pekerjaan fisik penyiapan (misal: Obat Jadi Non-Racikan, Racikan Puyer/Kapsul, Sediaan Steril/Injeksi, Sediaan Suhu Dingin).
   - Status siklus hidup saat ini (**Queued**, **Preparing**, **Ready for Pickup**, **Collection Expired**, **Resolved**, **Cancelled**).
   - Catatan alasan perubahan status siklus hidup.
2. **Informasi Waktu dan Akuntabilitas SLA:**
   - Waktu pekerjaan resmi masuk antrian (*Queued Timestamp* - titik awal hitung SLA penyiapan).
   - Waktu dimulainya pekerjaan fisik (*Preparing Timestamp*).
   - Waktu penyelesaian verifikasi dan siap serah (*Ready for Pickup Timestamp*).
   - Waktu berakhirnya masa tunggu pengambilan (*Collection Expired Timestamp*, jika terjadi).
   - Waktu penuntasan disposisi fisik No-Show (*Resolved Timestamp*, jika terjadi).
3. **Informasi Personel Pelaksana Kefarmasian (`ORG-PPA`):**
   - Identitas petugas penyiap fisik (*Preparer / Compounder*).
   - Identitas tenaga kefarmasian yang melakukan pemeriksaan internal (*Internal Verifier / Double-Checker*).
   - Identitas petugas yang mengeksekusi disposisi fisik No-Show (jika terjadi).
4. **Informasi Rincian Item Penyiapan Fisik (`DispensingItem`):**
   - Referensi ke baris item Sales Order asal (`SalesOrderItem`).
   - Identitas obat yang disiapkan (nama obat, bentuk sediaan, kekuatan/dosis).
   - Kuantitas yang diinstruksikan untuk disiapkan (*OrderedQty*).
   - Kuantitas yang berhasil disiapkan fisik (*PreparedQty*).
   - Kuantitas yang gagal disiapkan (*UnfulfilledQty*, jika ada) beserta alasan operasionalnya.
   - Informasi fisik sediaan: nomor batch dan tanggal kedaluwarsa (*Expiration Date / ED*) dari obat fisik yang diambil dari rak, serta *Beyond Use Date* (BUD) untuk obat racikan.
   - Aturan pakai / instruksi etiket yang dicetak dan ditempelkan pada kemasan obat.
5. **Informasi Verifikasi Mutu Internal (*Internal Quality Checklist*):**
   - Catatan konfirmasi pemeriksaan ganda internal (kesesuaian 5 Benar: Benar Obat, Benar Pasien, Benar Dosis, Benar Rute/Bentuk Sediaan, Benar Waktu/Frekuensi).
   - Konfirmasi integritas fisik kemasan dan kejelasan label/etiket obat.
6. **Informasi Lokasi Pengawasan Fisik (*Physical Custody Record*):**
   - Identitas lokasi penyimpanan sementara obat siap serah (misalnya: *Holding Bin ID*, Nomor Rak Keranjang Farmasi, atau Lemari Penyimpanan Suhu Dingin).
7. **Informasi Rekam Jejak Pemisahan Pemenuhan Parsial (*Partial Fulfillment Lineage*):**
   - Catatan pemisahan item *Unfulfilled* dari *Dispensing Job* utama (waktu pemisahan, alasan kegagalan stok/teknis, dan nomor referensi keterkaitan silsilah).
8. **Informasi Disposisi Fisik No-Show (*No-Show Physical Disposition Record*):**
   - Rincian disposisi per baris item:
     - Kuantitas yang dikembalikan ke stok aktif persediaan (*RestockedQty*) beserta lokasi rak tujuan persediaan;
     - Kuantitas yang dimusnahkan/dibuang (*DiscardedQty*) beserta alasan pemusnahan (misal sediaan racikan rusak/kadaluarsa);
     - Nomor referensi berita acara / pencatatan pemusnahan jika dipersyaratkan.
   - Konfirmasi nol sisa sediaan fisik di lokasi penyimpanan sementara (*Zero Balance Custody Confirmation*).

---

### 5.3 Required Business Conditions

1. **Syarat Masuk Antrian Penyiapan (*Queued*):**
   - Instruksi pemenuhan berasal dari *Sales Order* yang sah dan telah disetujui.
   - Memiliki minimal satu item penyiapan dengan kuantitas > 0.
   - Terhubung dengan identitas pasien dan unit farmasi penyiap yang valid.
2. **Syarat Memulai Penyiapan Fisik (*Preparing*):**
   - *Dispensing Job* sebelumnya berstatus *Queued*.
   - Petugas penyiap fisik teridentifikasi secara sah sebagai staf farmasi berwenang.
3. **Syarat Integritas Penyiapan Fisik:**
   - Dilarang mengubah isi instruksi penyiapan fisik secara in-place selama berstatus *Preparing*.
   - Perubahan kebutuhan terapi atau instruksi penyiapan mewajibkan pembatalan akuntabel (*Cancelled*) atas pekerjaan lama dan penerbitan pekerjaan baru.
4. **Syarat Pencapaian Siap Serah (*Ready for Pickup*):**
   - 100% item dalam *Dispensing Job* telah selesai disiapkan secara fisik sesuai kuantitas.
   - Pemeriksaan internal (*double-check*) telah dilakukan oleh tenaga kefarmasian yang berwenang dengan hasil lolos/terkonfirmasi.
   - Lokasi penyimpanan sementara (*holding custody location*) telah ditentukan dan dicatat.
   - Tidak ada item yang tertinggal dalam status belum selesai atau gagal di dalam job tersebut.
5. **Syarat Pemisahan Item yang Gagal Dipenuhi:**
   - Item yang gagal dipenuhi wajib dikeluarkan dari job sebagai *Unfulfilled* sebelum job utama dapat mencapai *Ready for Pickup*.
   - Histori keterikatan item yang dipisahkan tetap terpelihara dan dapat dilacak ke Sales Order asal.
6. **Syarat Transisi No-Show & Disposisi Fisik:**
   - Transisi ke *Collection Expired* hanya terjadi apabila waktu saat ini telah melampaui batas *collection window* yang ditetapkan kebijakan operasional dan obat belum diserahkan.
   - Transisi ke *Resolved* mensyaratkan seluruh sediaan fisik telah memiliki disposisi sah (dikembalikan ke stok atau dimusnahkan) dan tidak ada obat tersisa dalam *holding custody*.

---

### 5.4 Completion Proof

Outcome Dispensing dinyatakan selesai secara akuntabel apabila dapat diverifikasi bahwa:
1. **Penyelesaian Normal (Handoff Boundary):**
   - *Dispensing Job* berstatus **Ready for Pickup**;
   - 100% item pada job tersebut terverifikasi selesai disiapkan dan lolos verifikasi internal;
   - Lokasi *temporary physical custody* tercatat jelas dan siap untuk proses **OC-11-05 (Serah Obat)**.
2. **Penyelesaian Pembatalan (Authorized Abort):**
   - *Dispensing Job* berstatus **Cancelled**;
   - Alasan pembatalan (misal revisi resep klinisi) tercatat akuntabel;
   - Sediaan fisik yang sempat diambil/diproses telah dibersihkan atau dikembalikan secara tertib.
3. **Penyelesaian No-Show (Physical Resolution Completed):**
   - *Dispensing Job* berstatus **Resolved**;
   - Masa *collection window* terbukti telah kedaluwarsa (*Collection Expired*);
   - Setiap butir item obat memiliki catatan disposisi fisik definitif (*Restocked* atau *Discarded*);
   - Tidak ada obat yang tertinggal dalam *temporary custody* farmasi (*Zero Remaining Custody*);
   - Fakta penyelesaian fisik telah diterbitkan ke sistem untuk kebutuhan konsumsi konteks terkait.

---

## 6. Outcome Boundary

### Start
Outcome dimulai ketika instruksi pemenuhan yang sah dari *Sales Order* diterima oleh farmasi dan didaftarkan sebagai *Dispensing Job* ke dalam antrian operasional penyiapan farmasi (**Queued**), yang secara bersamaan menandai dimulainya penghitungan waktu tunggu / SLA penyiapan obat secara bisnis.

### End
Outcome berakhir pada salah satu kondisi batas berikut:
1. **Jalur Normal:** Berakhir ketika seluruh sediaan obat dalam *Dispensing Job* telah selesai disiapkan secara fisik, lolos verifikasi internal farmasi, diletakkan dalam *physical custody* yang jelas, dan mencapai status **Ready for Pickup** sebagai titik serah tanggung jawab (*handoff boundary*) menuju **OC-11-05 (Serah Obat)**.
2. **Jalur Pembatalan (*Cancellation*):** Berakhir ketika instruksi penyiapan ditarik atau digantikan, pekerjaan dihentikan, dan job berstatus **Cancelled** secara akuntabel.
3. **Jalur No-Show (*Physical Custody Resolution*):** Berakhir ketika masa pengambilan kedaluwarsa (*Collection Expired*), seluruh sediaan fisik obat yang tidak diambil telah diselesaikan disposisinya secara sah (kembali ke stok atau dimusnahkan), tidak ada obat tertinggal dalam *custody* apotek, dan job mencapai status terminal **Resolved**.

*Catatan Batasan:* Outcome End **tidak mencakup**:
- Pemanggilan pasien dan penyerahan fisik obat kepada pasien di konter (wewenang **OC-11-05**);
- Pemberian konseling dan edukasi pemakaian obat kepada pasien (wewenang **OC-11-05**);
- Penyelesaian transaksi finansial, kasir, atau pengembalian dana uang pasien (wewenang **Kasir** / **Tata Rekening**);
- Pembatalan atau penyesuaian berkas klaim BPJS (wewenang penjaminan / **BPJ**).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Dispensing Job Represents a Physical Batch Invariant:** Satu *Dispensing Job* merepresentasikan satu batch pekerjaan fisik penyiapan. Hubungan dengan Sales Order tidak dibatasi secara kaku (1 Sales Order dapat menghasilkan beberapa Dispensing Job sesuai kebutuhan operasional farmasi).
2. **All-or-Nothing Ready for Pickup Invariant:** Tidak ada status `Partially Ready for Pickup`. Sebuah *Dispensing Job* HANYA BOLEH mencapai *Ready for Pickup* apabila 100% item yang berada di dalamnya telah selesai disiapkan dan lolos verifikasi internal.
3. **No Silent Mutation Invariant:** Setelah *Dispensing Job* memasuki status *Preparing*, isi instruksi fisik penyiapan dilarang dimutasi secara diam-diam. Perubahan instruksi fisik mewajibkan pembatalan (*Cancelled*) atas pekerjaan lama dan penerbitan pekerjaan baru.
4. **Administrative vs Physical Change Decoupling Invariant:** Perubahan data administratif yang tidak mengubah kebutuhan atau instruksi fisik penyiapan tidak membatalkan *Dispensing Job* yang sedang berjalan.
5. **Distinct Meaning of Cancelled vs Unfulfilled Invariant:**
   - *Cancelled* digunakan ketika kebutuhan/instruksi ditarik dan tidak lagi berlaku (tidak ada kewajiban pemenuhan lanjutan).
   - *Unfulfilled* digunakan ketika kebutuhan pasien tetap sah tetapi farmasi gagal menyediakannya (kebutuhan tetap memerlukan resolusi lanjutan). Keduanya tidak boleh disamakan.
6. **Accountable Partial Fulfillment Splitting Invariant:** Apabila sebagian item dalam batch gagal dipenuhi, item yang gagal dipisahkan sebagai *Unfulfilled*, sedangkan bagian yang berhasil dapat diselesaikan hingga mencapai *Ready for Pickup*. Histori keterikatan batch asal wajib dapat ditelusuri.
7. **Policy-Driven Collection Window Invariant:** Durasi *collection window* merupakan parameter kebijakan/konfigurasi operasional, dan dilarang di-*hardcode* sebagai angka tertentu (misal 7 hari) dalam batasan domain outcome.
8. **Collection Expired Non-Terminal Invariant:** Status *Collection Expired* adalah kondisi temporal non-terminal. Berakhirnya waktu tunggu pengambilan tidak mengakhiri tanggung jawab fisik farmasi.
9. **No-Show Resolution Prerequisite for Resolved Invariant:** *Dispensing Job* yang mengalami No-Show dilarang mencapai status *Resolved* sebelum seluruh sediaan fisik obat yang tidak diambil memiliki disposisi sah dan tercatat secara akuntabel.
10. **Zero Remaining Custody Invariant:** Status *Resolved* pada jalur No-Show mensyaratkan tidak ada lagi sediaan obat yang tertinggal dalam *temporary physical custody* farmasi.
11. **No Automatic Restocking Assumption Invariant:** Dilarang mengasumsikan bahwa semua obat No-Show dapat otomatis dikembalikan ke stok aktif. Sediaan racikan khusus (*compounded drugs*) atau sediaan rusak/terbuka wajib diarahkan ke disposisi pemusnahan/pembuangan (*discard*).
12. **Ready for Pickup Handoff Boundary Invariant:** *Ready for Pickup* adalah akhir dari tanggung jawab penyiapan Dispensing dan batas serah menuju OC-11-05. Penyerahan fisik kepada pasien dan edukasi KIE dilarang dimasukkan sebagai kriteria penyelesaian Dispensing.
13. **Downstream Decoupling on Physical Resolution Invariant:** Keberhasilan tercapainya status *Resolved* pada Dispensing tidak boleh digantungkan pada keberhasilan proses refund kasir, adjustment billing, atau pembatalan klaim BPJS di sistem downstream.
14. **Distinct Terminal States Invariant:** Dilarang menggunakan status umum tunggal seperti `Completed` untuk mencampuradukkan status *Ready for Pickup*, *Cancelled*, dan *Resolved*.
15. **SLA Clock Starts at Queued Invariant:** Penghitungan waktu tunggu penyiapan obat secara bisnis dimulai tepat saat pekerjaan memasuki status *Queued*, bukan saat petugas mulai meracik (*Preparing*).
16. **Mandatory Internal Verification Invariant:** Setiap obat yang disiapkan wajib melalui verifikasi ganda internal oleh tenaga kefarmasian sebelum diizinkan mencapai status *Ready for Pickup*.
17. **Physical Custody Accountability Invariant:** Selama obat berada dalam status *Ready for Pickup* hingga diserahkan via OC-11-05 atau diselesaikan via No-Show, lokasi fisik penyimpanan sementara (*holding location*) wajib tercatat dan dapat dipertanggungjawabkan.

---

## 8. Business Exceptions

> Conditions under which the Outcome deviates from normal flow or cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Perubahan klinis terapi oleh dokter saat penyiapan sedang berjalan (*Preparing*)** | *Dispensing Job* lama dibatalkan secara akuntabel (**Cancelled**) dengan mencatat alasan pembatalan klinis. Sediaan fisik yang sempat disiapkan dibersihkan/dikelola. Instruksi baru dari Sales Order menghasilkan *Dispensing Job* baru. Dilarang melakukan mutasi diam-diam atas job lama. |
| **Keterbatasan stok fisik atau kerusakan obat saat penyiapan (*Dispensing Shortage / Physical Defect*)** | Item yang gagal dipenuhi dipisahkan secara akuntabel dari job dan dicatat sebagai **Unfulfilled** dengan alasan operasional yang jelas. Bagian item yang berhasil disiapkan diselesaikan hingga mencapai **Ready for Pickup**. Informasi kegagalan diteruskan ke pengelola Sales Order untuk tindak lanjut pemenuhan. |
| **Obat gagal dalam verifikasi internal farmasi (*Internal Double-Check Failure*)** | Status *Ready for Pickup* ditolak. Petugas wajib melakukan koreksi penyiapan fisik (misal penggantian etiket yang salah atau peracikan ulang sediaan) hingga seluruh item lolos verifikasi internal. Jika tidak dapat diperbaiki karena kendala stok/sediaan, item ditangani melalui pemisahan *Unfulfilled*. |
| **Pasien tidak hadir mengambil obat hingga masa tunggu berakhir (*Collection Window Expired / No-Show*)** | Pekerjaan bertransisi ke status **Collection Expired**. Tanggung jawab fisik belum selesai. Farmasi menginisiasi *No-Show Resolution*: memeriksa sediaan fisik dan menentukan disposisi yang sah (kembali ke stok atau musnah). Pekerjaan baru mencapai **Resolved** setelah tidak ada obat tersisa di lokasi penyimpanan sementara. |
| **Sediaan No-Show tidak memenuhi syarat pengembalian ke stok persediaan (*Non-Restockable No-Show Items*)** | Obat racikan puyer/kapsul/sirup atau obat yang segelnya telah rusak diproses melalui disposisi pemusnahan/pembuangan (**Discard / Musnah** via `INV-MUSNAH`), bukan dikembalikan ke persediaan komersial. Pencatatan pemusnahan diselesaikan sebelum job mencapai status **Resolved**. |
| **Pembatalan instruksi sebelum pekerjaan fisik dimulai (saat berstatus *Queued*)** | *Dispensing Job* langsung bertransisi ke status **Cancelled** tanpa memerlukan pembersihan fisik barang. Alokasi antrian dibebaskan secara tertib. |
| **Perubahan administratif non-fisik pada saat pekerjaan sedang disiapkan** | Data administratif diperbarui tanpa membatalkan *Dispensing Job*. Penyiapan fisik obat tetap berjalan normal menuju *Ready for Pickup*. |
| **Kegagalan proses refund atau pembatalan klaim downstream saat No-Show fisik telah selesai** | Status **Resolved** pada *Dispensing Job* tetap sah dan tidak dibatalkan. Kegagalan proses finansial/klaim downstream ditangani secara mandiri oleh domain Tata Rekening / Kasir / BPJS tanpa menahan status penutupan fisik Dispensing. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | *Dispensing Job* hanya dapat dibentuk dari instruksi pemenuhan yang sah dan memiliki minimal satu item penyiapan fisik dengan kuantitas > 0. | Completeness |
| **AC-02** | Waktu tunggu / SLA penyiapan obat secara bisnis mulai dihitung sejak pekerjaan memasuki status **Queued**. | Correctness |
| **AC-03** | Status **Ready for Pickup** hanya dapat dicapai jika 100% item dalam *Dispensing Job* telah selesai disiapkan secara fisik dan lolos verifikasi ganda internal farmasi. | Constraint |
| **AC-04** | Sistem menolak penetapan status `Partially Ready for Pickup`; jika terdapat item yang belum siap, job tidak dapat berstatus *Ready for Pickup*. | Constraint |
| **AC-05** | Perubahan instruksi penyiapan fisik pada saat berstatus *Preparing* membatalkan pekerjaan lama menjadi **Cancelled** dan membentuk *Dispensing Job* baru, tanpa melakukan mutasi diam-diam pada pekerjaan lama. | Correctness |
| **AC-06** | Perubahan administratif yang tidak mengubah instruksi fisik penyiapan tidak membatalkan *Dispensing Job* yang sedang berjalan. | Constraint |
| **AC-07** | Kegagalan pemenuhan karena kendala stok/operasional dicatat sebagai **Unfulfilled** (bukan *Cancelled*), dan kebutuhan pasien tetap tercatat untuk resolusi lanjutan. | Correctness |
| **AC-08** | Item yang gagal dipenuhi (*Unfulfilled*) dapat dipisahkan secara akuntabel dari *Dispensing Job*, sehingga sisa item yang berhasil dapat mencapai **Ready for Pickup** dengan riwayat silsilah batch yang tetap terlacak. | Completeness |
| **AC-09** | Masa tunggu pengambilan (*collection window*) dimulai tepat saat *Dispensing Job* mencapai status **Ready for Pickup**, dengan durasi yang mengacu pada konfigurasi kebijakan operasional (bukan nilai hard-coded). | Correctness |
| **AC-10** | Berakhirnya masa tunggu pengambilan mengubah status job menjadi **Collection Expired** sebagai kondisi temporal non-terminal, dan tanggung jawab *physical custody* tetap berada pada farmasi. | Constraint |
| **AC-11** | *Dispensing Job* pada jalur No-Show hanya dapat bertransisi ke status **Resolved** apabila seluruh sediaan fisik telah memiliki disposisi sah (*Restocked* atau *Discarded*) dan lokasi *holding custody* bernilai nol (tidak ada obat tertinggal). | Completeness |
| **AC-12** | Sediaan racikan khusus atau obat rusak akibat No-Show diproses melalui disposisi pemusnahan (*Discard*), dan tidak dikembalikan ke stok aktif persediaan komersial. | Correctness |
| **AC-13** | Status **Ready for Pickup** berfungsi sebagai handoff boundary menuju OC-11-05 dan tidak mencakup penyerahan obat kepada pasien atau edukasi KIE. | Constraint |
| **AC-14** | Keberhasilan penetapan status **Resolved** pada Dispensing tidak bergantung pada status keberhasilan penyelesaian refund, billing, atau klaim BPJS di sistem downstream. | Constraint |
| **AC-15** | Status akhir *Dispensing Job* dibedakan secara tegas antara **Ready for Pickup**, **Cancelled**, dan **Resolved**, tanpa menggunakan status universal `Completed`. | Correctness |
| **AC-16** | Setiap obat yang berstatus *Ready for Pickup* memiliki pencatatan lokasi penyimpanan fisik sementara (*holding bin / rak siap serah*) yang teridentifikasi secara akuntabel. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pemesanan Komersial & Plafon Kuantitas Komitmen:** Pembentukan Sales Order, pemisahan jalur penjamin (*payer split*), dan penguncian plafon komitmen `AcceptedQty` → **OC-11-03 Penjualan** (`APT-ORDER`).
- **Penetapan Harga, Faktur, & Potret Finansial:** Penerbitan Invoice, penentuan harga satuan, tuslah, diskon, dan penetapan *Pricing Snapshot* → **OC-11-03 Penjualan** (`APT-BILL`) dan **Tata Rekening** (`TRK-TARIF`).
- **Penyerahan Obat ke Pasien & Edukasi Pasien:** Pemanggilan antrian serah obat di loket, verifikasi identitas penerima akhir, dan edukasi/konseling pemakaian obat (KIE) → **OC-11-05 Serah Obat** (`APT-SERAH`).
- **Pengkajian Klinis Resep:** Telaah administratif, farmasetis, dan klinis atas resep dokter → **OC-11-02 Telaah Resep** (`APT-TELAAH`).
- **Penerimaan Pembayaran Kasir & Penutupan Kas:** Eksekusi pembayaran tunai/kartu/QRIS di kasir, penutupan shift kasir, dan pengembalian uang (*refund*) fisik kepada pasien → **OC-03-01 Kasir** (`TRK-PAYMENT`, `TRK-KASIR`) dan **OC-03-02 Closing Shift**.
- **Pencatatan Buku Kas & Penyesuaian Akuntansi Piutang:** Penyesuaian nota kredit, posting jurnal piutang, dan rekonsiliasi keuangan rumah sakit → Domain **Tata Rekening** (`TRK-BILLING`).
- **Pengurusan Klaim Jaminan & BPJS:** Verifikasi keabsahan kartu, penerbitan SEP, kaidah Fornas, dan verifikasi berkas klaim BPJS → **OC-01-04 VCLAIM BPJS** (`BPJ-VCLAIM`) dan domain jaminan eksternal.
- **Implementasi Kartu Stok & Buku Besar Pergudangan:** Mekanisme internal penulisan tabel mutasi stok, kartu stok inventori, dan algoritma alokasi gudang → Domain **Inventory** (`INV-STOK`, `INV-MUTASI`).
- **Penghitungan Stok Fisik Apotek:** Pelaksanaan stok opname berkala instalasi farmasi → **OC-11-06 Opname** (`INV-OPNAME`).
- **Rancangan Teknis dan Antarmuka Pengguna:** Skema tabel basis data, trigger SQL, model data internal, antarmuka grafis (UI wireframe / mockup), tata letak layar, endpoint API, dan format serialisasi event/message.
