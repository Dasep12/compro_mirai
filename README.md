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
npm run generate:importmap
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

## Panduan Deployment dengan Docker (Production)

Proyek ini telah dikonfigurasi penuh dengan **Dockerfile multi-stage** (Next.js 16 Standalone mode) dan **Docker Compose** untuk kemudahan proses rilis dan deployment di server (VPS / Cloud).

### Ringkasan Perintah Cepat (TL;DR)

Setiap kali ada pembaruan kode di server, cukup jalankan:

```bash
# Untuk Linux / macOS:
./deploy.sh

# Untuk Windows Server:
.\deploy.ps1
```

Atau jika ingin menjalankan secara manual:

```bash
git pull origin main
docker compose up -d --build --remove-orphans
docker compose ps
```

---

### 1. Prasyarat di Server

- **Git** terpasang (`sudo apt update && sudo apt install -y git`)
- File `.env` sudah dikonfigurasi di root direktori proyek (lihat `.env.example`).
- **Docker & Docker Compose** terpasang.

> [!IMPORTANT]
> **Jika Docker belum diinstall di server:**
>
> **A. Di Server Linux (Ubuntu / Debian VPS):**
> Jalankan perintah resmi berikut di terminal:
>
> ```bash
> curl -fsSL https://get.docker.com -o get-docker.sh
> sudo sh get-docker.sh
> ```
>
> **B. Di Server Windows (Windows Server / Windows 10/11 VPS):**
> Jalankan perintah berikut di PowerShell (Run as Administrator):
>
> ```powershell
> winget install Docker.DockerDesktop --accept-package-agreements --accept-source-agreements
> ```
>
> *(Atau download langsung installer resminya di [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/))*.

---

### 2. Penjelasan Alur Script Otomatis (`deploy.sh` / `deploy.ps1`)

Script otomatis `deploy.sh` dan `deploy.ps1` telah mengurus semua tahapan penting berikut secara aman:

1. **Menarik kode terbaru**: Menjalankan `git pull origin main`.
2. **Pemeriksaan `.env`**: Memastikan variabel lingkungan krusial sudah ada.
3. **Build & Restart Container**: Menjalankan `docker compose up -d --build --remove-orphans` (otomatis meregenerasi import map Payload dan mengompilasi Next.js mode standalone).
4. **Verifikasi Status**: Menampilkan daftar container yang sedang aktif dan sehat (`docker compose ps`).

> [!TIP]
> Di Linux/macOS, pastikan script sudah memiliki izin eksekusi sebelum pertama kali dijalankan:
>
> ```bash
> chmod +x deploy.sh
> ```

---

### 3. Alur Deployment Manual (Langkah demi Langkah)

Jika ingin menjalankan setiap proses secara mandiri atau memverifikasi sebelum build kontainer:

```bash
# 1. Ambil update terbaru dari repository
git pull origin main

# 2. Pastikan file .env sudah ada di root proyek (lihat .env.example)
cp .env.example .env   # (jika belum ada)
nano .env              # sesuaikan kredensial Supabase & Database

# 3. (Opsional) Verifikasi build secara lokal sebelum memasukkannya ke Docker
npm install
npm run generate:importmap
npm run build

# 4. Build Docker image dan jalankan container di latar belakang
docker compose up -d --build --remove-orphans

# 5. Verifikasi kontainer sudah berjalan sehat (healthy)
docker compose ps
```

---

### 4. Perintah Operasional Docker yang Berguna

| Kebutuhan | Perintah Terminal |
| :--- | :--- |
| **Melihat Log Aplikasi (Live/Streaming)** | `docker compose logs -f` |
| **Melihat Status & Port Kontainer** | `docker compose ps` |
| **Restart Kontainer Aplikasi** | `docker compose restart` |
| **Hentikan Kontainer** | `docker compose down` |
| **Build Ulang Tanpa Cache (Fresh Build)** | `docker compose build --no-cache && docker compose up -d` |
| **Mengecek Penggunaan Resource (CPU/RAM)** | `docker stats miraisoftnet-compro` |

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
- **Database & Object Storage**: [PostgreSQL & Supabase Storage](https://supabase.com/)
- **Styling Engine**: [Tailwind CSS v4](https://tailwindcss.com/) & [PostCSS](https://postcss.org/)
- **Animasi & Interaktivitas**: [Framer Motion 12](https://motion.dev/)
- **Iconography**: [Lucide React](https://lucide.dev/)
- **Optimasi Gambar**: [Sharp](https://sharp.pixelplumbing.com/)
- **Code Intelligence**: [Graphify](https://github.com/safishamsi/graphify)
