# MiraiSoftNet Company Profile

Platform website profil perusahaan resmi **Mirai Softnet & Technology** yang dibangun menggunakan arsitektur modern **Headless Fullstack** memadukan **Next.js 16 (App Router)**, **React 19**, **PayloadCMS 3**, **Tailwind CSS v4**, dan **PostgreSQL (Supabase)**.

Aplikasi ini menyajikan informasi portofolio, katalog produk, rincian layanan IT, peluang karir, dan artikel berita dengan performa tinggi, animasi dinamis, serta panel manajemen konten terintegrasi.

---

## Panduan Memulai (Getting Started)

Ikuti langkah-langkah berikut untuk menjalankan proyek di lingkungan pengembangan lokal:

### 1. Konfigurasi Variabel Lingkungan (Environment Variables)

Buat file `.env` di root direktori proyek dan sesuaikan konfigurasi kredensial database serta secret key:

```env
# PayloadCMS Secret Key (Wajib diisi string acak aman)
PAYLOAD_SECRET=your-secure-payload-secret-key

# PostgreSQL Connection String (Supabase / Local Postgres)
DATABASE_URI=postgresql://postgres.xxx:password@aws-0-region.pooler.supabase.com:6543/postgres

# Supabase Client Keys (Opsional untuk integrasi storage/client)
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 2. Unduh Dependensi Proyek

Pastikan Anda menggunakan **Node.js versi 20 atau lebih baru**:

```bash
npm install
```

### 3. Generate Definisi Tipe TypeScript CMS

Jalankan perintah ini untuk menyinkronkan seluruh skema koleksi Payload CMS ke file `payload-types.ts`:

```bash
npm run generate:types
```

### 4. Menjalankan Server Pengembangan (Development Mode)

```bash
npm run dev
```

Buka peramban (browser) Anda:

- **Website Publik**: [http://localhost:3000](http://localhost:3000)
- **Panel Admin CMS**: [http://localhost:3000/admin](http://localhost:3000/admin)

### 5. Kompilasi & Menjalankan Build Produksi

```bash
# Build aplikasi untuk production
npm run build

# Menjalankan server production
npm run start
```

---

## Pusat Dokumentasi Teknis (Technical Documentation)

Seluruh dokumentasi teknis, arsitektur sistem, dan panduan standarisasi kode telah disusun secara rapi di dalam folder [docs/](file:///c:/repository/compro_mirai/docs/):

| Dokumen | Topik Pembahasan |
| :--- | :--- |
| **[Pola Arsitektur](file:///c:/repository/compro_mirai/docs/ARCHITECTURE.md)** | Penjelasan arsitektur *Headless Fullstack* (Next.js 16 + PayloadCMS 3), pemisahan layer (Presentation, Data, CMS, Database), diagram alur Mermaid, dan keunggulan Payload Local API. |
| **[Peta Struktur Folder](file:///c:/repository/compro_mirai/docs/PROJECT_STRUCTURE.md)** | Penjelasan mendalam mengenai tata letak direktori root dan folder `src/` (`app/(public)`, `app/(payload)`, `collections`, `components/views`, `components/ui`, `lib`). |
| **[Data Layer & API](file:///c:/repository/compro_mirai/docs/DATA_LAYER_AND_API.md)** | Pola akses data Payload Local API (`getPayloadClient()`), strategi caching Next.js (`unstable_cache` dengan tag-based revalidation), ketersediaan endpoint REST (`/api/[...slug]`), dan GraphQL. |
| **[Model & Code Generation](file:///c:/repository/compro_mirai/docs/MODELS_AND_CODEGEN.md)** | Panduan pembuatan skema koleksi Payload CMS (`CollectionConfig`), konfigurasi fields, lifecycle hooks (auto slug), dan panduan generate tipe TypeScript ke `payload-types.ts`. |
| **[Manajemen State & Animasi](file:///c:/repository/compro_mirai/docs/STATE_MANAGEMENT.md)** | Pendekatan *Server-First Architecture* pada React Server Components (RSC), isolasi Client Components, implementasi React 19 hooks, dan animasi terstandarisasi dengan Framer Motion 12 (`FadeInUp`). |
| **[Standarisasi Kode](file:///c:/repository/compro_mirai/docs/CODING_STANDARDS.md)** | Konvensi penamaan berkas & simbol, panduan styling Tailwind CSS v4 via helper `cn()`, aturan penanganan breaking changes Next.js 16, standar SEO (metadata & JSON-LD), serta checklist pra-commit. |

---

## Navigasi Codebase Cepat dengan Graphify

Proyek ini telah dilengkapi dengan **Graphify Knowledge Graph** di direktori [graphify-out/](file:///c:/repository/compro_mirai/graphify-out/). Pengembang maupun AI agent tidak perlu memindai file satu per satu saat menganalisis relasi arsitektur:

- **Visualisasi Interaktif Browser**: Buka [graphify-out/graph.html](file:///c:/repository/compro_mirai/graphify-out/graph.html) langsung di browser Anda untuk menjelajahi peta arsitektur dan klaster modul secara visual.
- **Laporan Komunitas & Hubungan Modul**: Baca [graphify-out/GRAPH_REPORT.md](file:///c:/repository/compro_mirai/graphify-out/GRAPH_REPORT.md) untuk melihat daftar *God Nodes*, koneksi lintas modul, dan ringkasan struktur.
- **Query Cepat Lewat Terminal**:

  ```bash
  # Menanyakan relasi atau alur modul tertentu
  graphify query "bagaimana services diambil dan dirender?"

  # Mengetahui jalur keterhubungan antara dua modul/simbol
  graphify path "Services" "AppBar"
  ```

- **Pembaruan Otomatis**: Git hook post-commit telah terpasang untuk memperbarui graph secara otomatis setiap kali Anda melakukan commit kode baru. Anda juga dapat memperbaruinya secara manual kapan saja dengan:

  ```bash
  graphify update .
  ```

---

## Tech Stack & Ekosistem Utama

- **Framework Web**: [Next.js 16](https://nextjs.org/) (App Router, Server Components)
- **UI Library**: [React 19](https://react.dev/)
- **Bahasa Pemrograman**: [TypeScript 5](https://www.typescriptlang.org/)
- **Headless CMS Engine**: [PayloadCMS 3](https://payloadcms.com/) (Lexical Rich Text Editor, Postgres Adapter)
- **Database**: [PostgreSQL](https://www.postgresql.org/) (terhubung via [Supabase](https://supabase.com/))
- **Styling Engine**: [Tailwind CSS v4](https://tailwindcss.com/) & [PostCSS](https://postcss.org/)
- **Animasi & Interaktivitas**: [Framer Motion 12](https://motion.dev/)
- **Iconography**: [Lucide React](https://lucide.dev/)
- **Optimasi Gambar**: [Sharp](https://sharp.pixelplumbing.com/)
- **Code Intelligence**: [Graphify](https://github.com/safishamsi/graphify)
