# Bonecom Career — Konten Collection Products

Dokumen ini memetakan bahan portofolio Bonecom Career ke field Payload `Products`. Naskah bersumber dari `Bahan-Portofolio-Bonecom-Career.md`; fakta yang tidak ada di bahan tidak ditambahkan. Uraian alur memakai data sumber dan perlu dikonfirmasi pemilik produk sebelum dipublikasikan.

## Arahan tampilan dan tautan

Collection yang sama mengisi showcase produk di homepage Mirai dan halaman detail `/products/bonecom-career`. Showcase tetap memiliki navigasi internal **Lebih Detail**. Sesuai percakapan, halaman produk berisi penjelasan dan flow; CTA ke website recruitment dimatikan untuk Bonecom Career.

## Field utama

| Field Payload | Nilai untuk Bonecom Career                                                                                                                                                                                                           |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `name`        | Bonecom Career                                                                                                                                                                                                                       |
| `showCTA`     | `false` — sembunyikan CTA eksternal di homepage dan halaman detail.                                                                                                                                                                  |
| `productUrl`  | Kosongkan. Field ini tidak diperlukan saat `showCTA` nonaktif.                                                                                                                                                                       |
| `slug`        | `bonecom-career`                                                                                                                                                                                                                     |
| `ctaText`     | Tidak dipakai saat CTA nonaktif. Biarkan default atau kosong.                                                                                                                                                                        |
| `subtitle`    | Portal karier dan sistem rekrutmen terpadu untuk tiga perusahaan Bonecom Tricom Group.                                                                                                                                               |
| `iconTitle`   | **Wajib sebelum menyimpan:** unggah ikon/logo Bonecom Career berbentuk persegi dalam SVG atau PNG. Bahan yang tersedia belum berisi ikon produk khusus.                                                                              |
| `badge`       | REKRUTMEN TERPADU · MANUFAKTUR                                                                                                                                                                                                       |
| `headline`    | Rekrutmen Tiga Perusahaan, Satu Portal Karier                                                                                                                                                                                        |
| `description` | Bonecom Career menyatukan portal lowongan, seleksi kandidat, dan administrasi karyawan baru untuk tiga perusahaan. Pelamar melamar serta memantau statusnya secara daring, sementara HRD mengelola tahapan rekrutmen hingga kontrak. |
| `image`       | Unggah `C:\Users\muham\Downloads\mockup\mockup-hero.webp`. Alt: `Portal karier Bonecom Career di laptop dan ponsel`.                                                                                                                 |

`name`, `badge`, `headline`, `description`, `image`, dan `features` tampil di showcase homepage. `subtitle` digunakan pada tooltip navigasi/kartu. Halaman detail menggunakan kembali headline, description, dan gambar yang sama.

## `fullDescription` — draf latar belakang, solusi, hasil

Field ini opsional dan **belum ditampilkan** oleh halaman detail saat ini. Simpan sebagai bahan editorial; jangan mengandalkannya untuk konten live sebelum komponen halaman merendernya.

### Tantangan

Bonecom Tricom Group merekrut untuk tiga perusahaan melalui jalur Staff dan Non-Staff. Lamaran dari berbagai kanal, jadwal seleksi, dokumen MCU dan offering, serta persetujuan kontrak sebelumnya dikelola terpisah. HRD sulit melihat posisi setiap kandidat, sedangkan pelamar tidak selalu mengetahui perkembangan lamarannya.

### Solusi

Bonecom Career menyatukan portal karier dan proses seleksi untuk tiga perusahaan. Pelamar membuat akun dengan verifikasi NIK dan OTP email, melengkapi profil, melamar lowongan, lalu memantau status dari akunnya.

HRD mengelola jalur Staff dan Non-Staff dengan enam tahap masing-masing. Proses dapat dilakukan satu per satu atau secara massal. Undangan, surat, dan pemberitahuan dikirim lewat email. Psikotes berjalan daring dengan pengawasan webcam; Offering Letter dan kontrak dibuat sebagai PDF resmi per perusahaan. Approval kontrak dapat dilakukan atasan melalui email, dan kandidat dapat menandatangani kontrak online atau di kantor.

### Hasil

Proses rekrutmen tiga perusahaan dikelola dari satu aplikasi yang dapat diakses melalui desktop dan ponsel. HRD dapat memantau tahapan kandidat, pelamar menerima informasi perkembangan lamaran, dan data karyawan baru dapat diekspor untuk proses HRIS. Bahan menyebut sistem sudah berjalan di production dan kuota pendaftaran harian dapat diatur.

## Nilai bisnis

| Field Payload        | Nilai                                                                                         |
| -------------------- | --------------------------------------------------------------------------------------------- |
| `benefitTitle`       | Rekrutmen lebih terarah, transparan, dan efisien                                              |
| `benefitDescription` | Satukan proses HRD dan pengalaman pelamar dari lowongan dibuka hingga kontrak ditandatangani. |

Isi array `benefits`:

1. **Satu sistem untuk tiga perusahaan** — Lowongan, kop surat, penandatangan, dan alur approval dapat dibedakan per perusahaan, tetapi tetap dikelola dari satu tempat.
2. **Mengikuti cara kerja HRD** — Jalur Staff dan Non-Staff memiliki tahapan seleksi masing-masing sesuai proses perusahaan.
3. **Pekerjaan berulang lebih ringkas** — Pemrosesan kandidat secara massal, email otomatis, dan pilihan alasan penolakan sekali klik membantu mengurangi tugas berulang.
4. **Status lamaran lebih jelas** — Status, jadwal, dan hasil tahap seleksi dapat dilihat pelamar dari akun dan pemberitahuan email.
5. **Approval dan kontrak digital** — Atasan dapat menyetujui kontrak dan MCU lewat email; kontrak dapat ditandatangani online atau di kantor.
6. **Data siap untuk HRIS** — Biodata, kontrak final, dan data karyawan baru dapat diunduh untuk proses impor HRIS.
7. **Kontrol akses dan perlindungan data** — Hak akses per peran, 2FA untuk Admin dan HRD, enkripsi data rekening/NPWP, serta backup harian.

## Cara kerja produk

Workflow menggunakan satu urutan langkah, maksimal empat kartu per baris. Baris berikutnya membalik arah dan berlanjut dari sisi tempat baris sebelumnya berakhir. `workflowImage` bersifat opsional dan ditampilkan selebar konten di bawah seluruh langkah, bukan menggantikannya.

| Field Payload         | Nilai                                                                                                              |
| --------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `workflowTitle`       | Tentukan setelah pemilik produk menyetujui framing satu alur.                                                      |
| `workflowDescription` | Jelaskan alur yang sudah dikonfirmasi; jangan menyiratkan Staff dan Non-Staff memiliki tahap identik.              |
| `workflowSteps`       | Isi setelah HRD memvalidasi urutan workflow tunggal yang mewakili produk tanpa menggabungkan tahapan yang berbeda. |
| `workflowImage`       | Opsional; diagram breakdown ditampilkan di bawah daftar `workflowSteps`.                                           |

Data lama `workflowTracks` (Staff dan Non-Staff) dipertahankan di collection tetapi disembunyikan dari editor agar perubahan model tidak menghapus data. Jangan menyalin atau menggabungkan kedua jalur secara otomatis menjadi `workflowSteps`; konfirmasi urutan tunggal kepada HRD terlebih dahulu. Nama tahap yang tercantum pada bahan lama belum cukup untuk menyatakan satu alur lintas jalur yang akurat.

## Fitur utama

Array `features` tampil di showcase homepage dan bagian fitur pada halaman detail. `title` dan `description` wajib; `icon` dan `picture` opsional. Ikon belum dipilih karena bahan tidak menentukan ikon produk yang tepat.

1. **Portal karier dan profil pelamar** — Lowongan dwibahasa dengan pencarian/filter. Pelamar mendaftar dengan validasi NIK dan OTP email, melengkapi profil, serta memantau status lamaran.
   `picture`: `C:\Users\muham\Downloads\screenshot\desktop\02-lowongan.webp`
2. **Seleksi Staff dan Non-Staff** — HRD mengelola dua jalur seleksi, memproses kandidat satu per satu atau massal, dan mencari/filter kandidat di setiap tahap.
   `picture`: `C:\Users\muham\Downloads\screenshot\desktop\11-hrd-nonstaff-screening.webp`
3. **Psikotes dan assessment** — Psikotes CBT daring mendukung bank soal dan paket tes, pengawasan webcam, serta pencatatan aktivitas mencurigakan. Assessment dapat dilakukan melalui platform luar atau konsultan.
   `picture`: `C:\Users\muham\Downloads\screenshot\desktop\15-hrd-monitor-psikotes.webp`
4. **MCU, offering, dan kontrak** — Kelola surat MCU, Offering Letter PDF, approval berjenjang, konfirmasi kandidat, dan tanda tangan kontrak online atau di kantor.
   `picture`: `C:\Users\muham\Downloads\screenshot\desktop\17-hrd-offering.webp`
5. **Laporan dan data karyawan** — Tinjau laporan rekrutmen, Candidate Progress, biodata kandidat ber-QR, pelanggaran psikotes, dan ekspor Excel untuk proses HRIS.
   `picture`: `C:\Users\muham\Downloads\screenshot\desktop\18-hrd-laporan.webp`
6. **Administrasi dan keamanan** — Kelola empat peran pengguna, master data, template, CMS portal, 2FA Admin/HRD, tautan publik bertoken, serta backup harian.
   `picture`: `C:\Users\muham\Downloads\screenshot\desktop\20-admin-dashboard.webp`

## Tahapan penerapan produk

Field `implementationTitle`, `implementationDescription`, dan `implementationSteps` menjelaskan onboarding/deployment produk kepada pelanggan. Bahan sumber hanya mencatat ruang lingkup pekerjaan proyek Bonecom (analisis kebutuhan, desain, pengembangan, deployment, QC, dokumentasi), bukan prosedur penerapan produk yang dapat dijanjikan ke pelanggan lain. Karena itu, **biarkan field ini kosong** sampai tim memiliki tahapan onboarding yang benar dan dapat digunakan ulang. Jika nanti tersedia diagram penerapan utuh, isi `implementationImage`; gambar akan menggantikan daftar tahap. Jika gambar dikosongkan, daftar langkah akan digunakan.

## Target penggunaan

Isi array `useCases`:

- `industry`: Manufaktur
- `industry`: Grup perusahaan dengan kebutuhan rekrutmen multi-entitas

## Galeri

Unggah gambar ke collection Media dahulu, lalu tambahkan ke array `gallery` dengan caption. Gunakan WebP jika tersedia; PNG adalah alternatif kualitas penuh. Pilihan kurasi berikut menjaga galeri tetap fokus.

### Mockup

- `C:\Users\muham\Downloads\mockup\mockup-cover.webp` — Tampilan portal karier Bonecom Career.
- `C:\Users\muham\Downloads\mockup\mockup-hrd.webp` — Dashboard HRD dan pilihan alasan Tidak Lulus.
- `C:\Users\muham\Downloads\mockup\mockup-alur.webp` — Tahap Screening Non-Staff dan Offering Letter Staff.
- `C:\Users\muham\Downloads\mockup\mockup-pelamar.webp` — Pengalaman pelamar di ponsel.

### Screenshot desktop

- `C:\Users\muham\Downloads\screenshot\desktop\01-beranda.webp` — Beranda portal karier.
- `C:\Users\muham\Downloads\screenshot\desktop\03-detail-lowongan.webp` — Detail lowongan.
- `C:\Users\muham\Downloads\screenshot\desktop\05-pelamar-beranda.webp` — Dashboard pelamar.
- `C:\Users\muham\Downloads\screenshot\desktop\07-pelamar-status-lamaran.webp` — Status lamaran.
- `C:\Users\muham\Downloads\screenshot\desktop\09-hrd-dashboard.webp` — Dashboard HRD dan monitoring interview.
- `C:\Users\muham\Downloads\screenshot\desktop\12-hrd-staff-interview.webp` — Interview HR & User untuk jalur Staff.
- `C:\Users\muham\Downloads\screenshot\desktop\14-hrd-master-psikotes.webp` — Paket psikotes CBT.
- `C:\Users\muham\Downloads\screenshot\desktop\17-hrd-offering.webp` — Offering Letter.
- `C:\Users\muham\Downloads\screenshot\desktop\18-hrd-laporan.webp` — Laporan dan analitik rekrutmen.
- `C:\Users\muham\Downloads\screenshot\desktop\21-admin-approval-flow.webp` — Pengaturan approval berjenjang.

### Screenshot ponsel

- `C:\Users\muham\Downloads\screenshot\mobile\m01-beranda.webp` — Beranda portal karier di ponsel.
- `C:\Users\muham\Downloads\screenshot\mobile\m02-lowongan.webp` — Daftar lowongan di ponsel.
- `C:\Users\muham\Downloads\screenshot\mobile\m03-detail-lowongan.webp` — Detail lowongan di ponsel.
- `C:\Users\muham\Downloads\screenshot\mobile\m04-daftar-akun.webp` — Pendaftaran akun di ponsel.
- `C:\Users\muham\Downloads\screenshot\mobile\m05-pelamar-beranda.webp` — Dashboard pelamar di ponsel.

## Integrasi dan teknologi pendukung

Biarkan array `integrations` kosong untuk halaman ini. Bahan memang menyebut Gmail API/Google Workspace, Resend sebagai cadangan email, WhatsApp Blast, dan ekspor Excel HRIS. Namun komponen halaman saat ini menampilkan isi `integrations` di section **Platform**, sedangkan sebagian item tersebut adalah kanal komunikasi atau ekspor data—bukan platform yang dipilih pengguna. HRIS disebut sebagai ekspor file, bukan integrasi langsung. Tambahkan hanya setelah tujuan section dan label tampilannya disepakati.

Teknologi proyek yang dicatat di bahan (Laravel 12, PHP 8.3, MySQL, Blade, Bootstrap 5, dan lainnya) adalah catatan implementasi, bukan otomatis daftar integrasi produk.

## Klien

Isi array `clients` sebagai social proof setelah logo diunggah ke Payload Media:

- `clientName`: PT Bonecom Tricom — logo `C:\repository\compro_mirai\media\bonecom.png`
- `clientName`: PT Bonecom Tricom Paint Tech — logo `C:\repository\compro_mirai\media\bonecom-paintech.png`
- `clientName`: PT Ravalia Inti Mandiri — logo `C:\repository\compro_mirai\media\ravalia.png`

Pastikan penggunaan nama/logo perusahaan disetujui klien sebelum halaman dipublikasikan.

## Informasi sumber yang tidak punya field Products

Tahun proyek (2026), status live, platform dan stack teknis, ruang lingkup pengembangan, CTA konsultasi Mirai, serta SEO tidak memiliki field khusus di collection `Products`. Jangan masukkan ke field lain hanya agar tersimpan. Data yang terlihat pada screenshot adalah data contoh, bukan data pelamar sungguhan.
