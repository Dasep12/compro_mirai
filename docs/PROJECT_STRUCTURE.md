# Struktur Direktori & Folder (Project Structure)

Dokumen ini menjelaskan struktur direktori, organisasi file, dan tanggung jawab setiap modul pada proyek **MiraiSoftNet Company Profile (Next.js 16 + PayloadCMS 3)**.

---

## Struktur Root Proyek

```text
compro_mirai/
├── .agents/                    # Konfigurasi agen AI, rules, & workflows (Antigravity)
├── .git/                       # Konfigurasi version control Git & git hooks
├── docs/                       # Dokumentasi teknis komprehensif proyek
│   ├── ARCHITECTURE.md         # Pola arsitektur Fullstack & alur data
│   ├── PROJECT_STRUCTURE.md    # Peta struktur folder (dokumen ini)
│   ├── DATA_LAYER_AND_API.md   # Payload Local API & Caching Next.js
│   ├── MODELS_AND_CODEGEN.md   # Collections schema & generate:types
│   ├── STATE_MANAGEMENT.md     # Server Components vs Client State & Animasi
│   └── CODING_STANDARDS.md     # Standarisasi kode, SEO, & Tailwind v4
├── graphify-out/               # Knowledge Graph arsitektur proyek (Graphify)
│   ├── graph.json              # Data relasi kode & modul
│   ├── graph.html              # Visualisasi interaktif arsitektur di browser
│   └── GRAPH_REPORT.md         # Laporan analisis komunitas & God Nodes
├── media/                      # Direktori penyimpanan upload file media CMS lokal
├── public/                     # Aset statis publik (favicon, logo, icons)
├── src/                        # Seluruh source code utama aplikasi
├── eslint.config.mjs           # Konfigurasi linter ESLint 9
├── next.config.ts              # Konfigurasi Next.js 16
├── package.json                # Dependensi proyek & script npm
├── payload-types.ts            # Tipe TypeScript hasil generate Payload CMS
├── payload.config.ts           # Konfigurasi sentral PayloadCMS 3 (DB, Collections)
├── postcss.config.mjs          # Konfigurasi PostCSS & Tailwind CSS v4
├── tsconfig.json               # Konfigurasi TypeScript 5
└── README.md                   # Gerbang utama dan petunjuk menjalankan proyek
```

---

## Bedah Direktori `src/`

Folder `src/` menjadi pusat seluruh logika aplikasi dan terbagi ke dalam 4 pilar utama: `app/`, `collections/`, `components/`, dan `lib/`.

```text
src/
├── app/                        # Next.js App Router (Rute publik & CMS)
│   ├── (payload)/              # Route Group untuk Payload CMS backend & Admin
│   ├── (public)/               # Route Group untuk website company profile publik
│   ├── robots.ts               # Generator file robots.txt dinamis
│   └── sitemap.ts              # Generator XML Sitemap dinamis
├── collections/                # Definisi skema koleksi & globals Payload CMS
├── components/                 # Komponen antarmuka React
│   ├── payloads/               # Kustomisasi komponen admin CMS
│   ├── ui/                     # Komponen UI umum & reusable (AppBar, Footer, dll.)
│   └── views/                  # Komponen sectional spesifik tiap halaman
└── lib/                        # Layanan inti, data fetching, dan utility helpers
```

---

### 1. `src/app/(public)/` (Rute Publik Pengunjung)

Menggunakan konvensi Route Group `(public)` agar seluruh halaman pengunjung memiliki layout yang sama tanpa mempengaruhi rute admin CMS:

| Path / Folder | Deskripsi Halaman |
| :--- | :--- |
| **`layout.tsx`** | Root layout publik: Menginisialisasi font Plus Jakarta Sans, viewport, metadata global, structured data JSON-LD, [AppBar.tsx](file:///c:/repository/compro_mirai/src/components/ui/AppBar.tsx), dan [Footer.tsx](file:///c:/repository/compro_mirai/src/components/ui/Footer.tsx). |
| **`loading.tsx`** | UI skeleton loading otomatis saat halaman sedang streaming data. |
| **`globals.css`** | Konfigurasi styling global Tailwind CSS v4 dan variabel tema. |
| **`page.tsx`** | Homepage: Mengambil data hero, customer, partner, services, products, portfolio, contact, dan FAQ secara paralel. |
| **`about-us/`** | Halaman profil perusahaan, visi, misi, dan nilai-nilai MiraiSoftNet. |
| **`services/`** | Daftar seluruh layanan IT yang ditawarkan. |
| **`services/[slug]/`** | Halaman detail layanan dinamis berdasarkan slug (misal: `/services/enterprise-software`). |
| **`products/`** | Katalog produk software dan solusi siap pakai. |
| **`products/[slug]/`** | Halaman detail produk dinamis berdasarkan slug. |
| **`careers/`** | Lowongan pekerjaan aktif dan benefit berkarir di MiraiSoftNet. |
| **`careers/[slug]/`** | Detail lowongan pekerjaan dan form/tautan lamaran. |
| **`news/`** | Berita, artikel, dan update teknologi terkini. |
| **`news/[slug]/`** | Halaman baca artikel lengkap dengan format rich text. |
| **`pricing/`** | Paket estimasi harga, skema layanan, dan FAQ terkait harga. |

---

### 2. `src/app/(payload)/` (CMS Backend & Admin Panel)

Mengintegrasikan engine PayloadCMS 3 secara native ke dalam App Router Next.js:

| Subfolder | Deskripsi |
| :--- | :--- |
| **`admin/[[...segments]]/`** | Halaman dashboard antarmuka admin Payload CMS (`/admin`) untuk mengelola seluruh konten dan media. |
| **`api/[...slug]/`** | Route handler otomatis yang mengekspos endpoint REST API dan GraphQL untuk seluruh collections. |

---

### 3. `src/collections/` (Skema Data & Content Modeling)

Setiap file di folder ini merepresentasikan entitas model data CMS yang terdaftar pada `payload.config.ts`:

| File Koleksi | Slug Koleksi | Fungsi & Kegunaan |
| :--- | :--- | :--- |
| **`AboutUs.ts`** | `about-us` (Global) | Data tunggal profil perusahaan, visi, misi, dan kontak legal. |
| **`Services.ts`** | `services` | Layanan IT (judul, slug, ikon, kategori, fitur, benefit, proses pengerjaan, rich text). |
| **`Products.ts`** | `products` | Produk digital (deskripsi, spesifikasi, screenshot media, tech stack, slug). |
| **`Portfolios.ts`** | `portfolios` | Studi kasus proyek yang telah diselesaikan bersama klien. |
| **`Customers.ts`** | `customers` | Testimonial klien dan logo brand customer. |
| **`Partnership.ts`** | `partnerships` | Logo dan informasi mitra kerja sama strategis. |
| **`Career.ts`** | `careers` | Lowongan kerja (posisi, departemen, tipe kerja, persyaratan, deskripsi). |
| **`News.ts`** | `news` | Artikel blog, siaran pers, dan wawasan industri. |
| **`Faqs.ts`** | `faqs` | Daftar pertanyaan umum dan jawaban seputar perusahaan. |
| **`PricingFaq.ts`** | `pricing-faqs` | FAQ spesifik mengenai skema pembayaran dan paket harga. |
| **`Problem.ts`** | `problems` | Poin masalah bisnis klien yang dijawab oleh solusi MiraiSoftNet. |
| **`Media.ts`** | `media` | Manajemen upload berkas gambar dan dokumen dengan optimasi Sharp. |
| **`User.ts`** | `users` | Akun administrator CMS dengan autentikasi aman. |
| **`Visitors.ts`** | `visitors` | Pencatatan statistik kunjungan pengunjung web. |

---

### 4. `src/components/` (Komponen Antarmuka)

#### a. `src/components/ui/` (Komponen Dasar)

- **`AppBar.tsx`**: Navigasi atas dengan dropdown menu dinamis produk & layanan, state drawer mobile, dan tombol CTA.
- **`Footer.tsx`**: Bagian footer bawah yang memuat tautan navigasi, sosial media, dan informasi kontak.
- **`FadeInUp.tsx`**: Wrapper animasi Framer Motion untuk transisi *fade-in slide-up* saat elemen masuk ke viewport.
- **`Image.tsx`**: Komponen pembungkus Next.js `<Image>` dengan fallback penanganan media Payload.

#### b. `src/components/views/` (Bagian Halaman Spesifik)

Dikelompokkan rapi per halaman tujuan:

- **`home/`**: `Hero`, `PartnershipCustomer`, `Problem`, `ServiceShowcase`, `ProductShowcase`, `PortfolioShowcase`, `Contact`, `FaqShowcase`.
- **`services/`**: List tampilan layanan, hero layanan, dan detail section.
- **`products/`**: Grid katalog produk dan tampilan fitur detail produk.
- **`careers/`**: Tampilan lowongan, badge departemen, dan modal/form lamaran.
- **`news/`**: Grid artikel berita, highlight berita utama, dan pembaca artikel.
- **`pricing/`**: Tabel perbandingan paket harga dan accordion FAQ harga.
- **`about_us/`**: Milestone perusahaan, tim inti, dan komitmen layanan.

---

### 5. `src/lib/` (Utility & Layanan Inti)

- **`payload.ts`**: Menginisialisasi instance tunggal (*Singleton*) Payload Client via `getPayload({ config })`.
- **`data/collections.ts`**: Kumpulan fungsi data fetching ter-cache (`getServices()`, `getProducts()`, `getCustomers()`, dll.) yang dibungkus dengan Next.js `unstable_cache`.
- **`utils.ts`**: Helper fungsi seperti `cn()` (penggabungan class Tailwind `clsx` + `tailwind-merge`) dan `generateSlug()`.
- **`whatsapp.ts`**: Helper untuk membuat URL tautan obrolan WhatsApp resmi dengan pesan pra-format interaktif.
