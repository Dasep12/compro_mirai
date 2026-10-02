# MiraiSoftNet Company Profile

Platform website profil perusahaan resmi **Mirai Softnet & Technology** yang dibangun menggunakan arsitektur modern **Headless Fullstack** memadukan **Next.js 16 (App Router)**, **React 19**, **PayloadCMS 3**, **Tailwind CSS v4**, dan **PostgreSQL 16 (Self-Hosted Docker)** dengan penyimpanan media lokal mandiri tanpa ketergantungan pada layanan cloud pihak ketiga (Supabase-free).

Aplikasi ini menyajikan informasi portofolio, katalog produk, rincian layanan IT, peluang karir, dan artikel berita dengan performa tinggi, animasi dinamis, serta panel manajemen konten terintegrasi.

---

## Panduan Memulai (Getting Started - Local Development)

Ikuti langkah-langkah berikut untuk menjalankan proyek di lingkungan pengembangan lokal laptop/PC:

### 1. Konfigurasi Variabel Lingkungan (Environment Variables)

Salin `.env.example` menjadi `.env` di root direktori proyek dan sesuaikan konfigurasi:

```env
# ==============================================================================
# DATABASE CONFIGURATION (POSTGRESQL MANDIRI / SELF-HOSTED)
# ==============================================================================
# Untuk Local Development (Laptop ke port 5432):
DATABASE_URI=postgresql://postgres:your_password_here@127.0.0.1:5432/miraisoftnet_compro

# Kredensial Database Docker Container
POSTGRES_DB=miraisoftnet_compro
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_password_here

# ==============================================================================
# PAYLOAD CMS & SERVER CONFIGURATION
# ==============================================================================
PAYLOAD_SECRET=your_32_characters_random_secret_string_here
PORT=3000
NEXT_PUBLIC_SERVER_URL=http://localhost:3000

# ==============================================================================
# STORAGE CONFIGURATION (NATIVE LOCAL STORAGE)
# ==============================================================================
STORAGE_DRIVER=local

# URL server VPS untuk fallback gambar jika file media belum ada di laptop saat dev
NEXT_PUBLIC_REMOTE_MEDIA_URL=https://miraisoftnet.com
```

> [!TIP]
> **Hemat Penyimpanan Laptop (Zero-Media Footprint):**
> Anda tidak perlu menyalin ratusan file media (~290 MB) ke laptop. Berkat konfigurasi `NEXT_PUBLIC_REMOTE_MEDIA_URL=https://miraisoftnet.com`, Next.js dev server otomatis mengambil fallback gambar langsung dari server produksi via rewrite transparan. Folder `media/` juga telah diabaikan dari Git (`.gitignore`) dan disembunyikan di VS Code explorer agar workspace tetap bersih dan ringan.

---

### 2. Menjalankan Database PostgreSQL Lokal (via Docker)

Jika Anda tidak menginstall PostgreSQL secara langsung di OS laptop, Anda cukup menjalankan container database PostgreSQL menggunakan Docker Compose:

```bash
docker compose up -d postgres
```

> [!NOTE]
> **Prerender Resilience:** Jika database belum dijalankan, Next.js tetap dapat berjalan (`npm run dev`) dan melayani halaman dengan aman tanpa crash (`200 OK`) berkat sistem penanganan fallback data koleksi yang tangguh.

---

### 3. Unduh Dependensi & Sinkronisasi Tipe CMS

Pastikan Anda menggunakan **Node.js versi 20 atau lebih baru**:

```bash
# 1. Unduh package
npm install

# 2. Sinkronkan skema Payload CMS ke TypeScript
npm run generate:importmap
npm run generate:types
```

---

### 4. Menjalankan Server Pengembangan (Development Mode)

```bash
npm run dev
```

Buka peramban (browser) Anda:

- **Website Publik**: [http://localhost:3000](http://localhost:3000)
- **Panel Admin CMS**: [http://localhost:3000/admin](http://localhost:3000/admin)

---

### 5. Kompilasi & Menjalankan Build Produksi (Manual)

```bash
# Build aplikasi Next.js (Standalone mode)
npm run build

# Menjalankan server build
npm run start
```

---

## Panduan Deployment Server VPS (Production Docker)

Proyek ini telah dikonfigurasi penuh dengan **Dockerfile multi-stage** (Next.js 16 Standalone mode) dan **Docker Compose** yang memadukan service aplikasi Next.js/Payload dan database PostgreSQL lokal mandiri.

### Ringkasan Perintah Cepat (TL;DR)

Setiap kali ada pembaruan kode di server VPS, Anda hanya perlu menjalankan satu perintah:

```bash
# Untuk Linux VPS (otomatis git pull, fix izin media, build & restart):
bash deploy.sh

# atau:
chmod +x deploy.sh && ./deploy.sh
```

```powershell
# Untuk Windows Server:
.\deploy.ps1
```

Atau jika ingin menjalankan proses deployment secara manual:

```bash
git pull origin main
chmod -R 777 media
docker compose up -d --build --remove-orphans
docker compose ps
```

---

### 1. Prasyarat di Server

1. **Git** terpasang (`sudo apt update && sudo apt install -y git`).
2. **Docker & Docker Compose** terpasang.
3. File `.env` sudah dibuat di root proyek dengan koneksi database antar-container:

   ```env
   # Di Server VPS, aplikasi terhubung ke service postgres lewat network Docker:
   DATABASE_URI=postgresql://postgres:YOUR_STRONG_PASSWORD@postgres:5432/miraisoftnet_compro
   POSTGRES_DB=miraisoftnet_compro
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=YOUR_STRONG_PASSWORD
   PAYLOAD_SECRET=YOUR_32_CHAR_SECRET
   NEXT_PUBLIC_SERVER_URL=https://miraisoftnet.com
   STORAGE_DRIVER=local
   ```

> [!IMPORTANT]
> **Instalasi Docker di Linux VPS (Ubuntu / Debian):**
>
> ```bash
> curl -fsSL https://get.docker.com -o get-docker.sh
> sudo sh get-docker.sh
> ```

---

### 2. Cara Kerja Script Otomatis `deploy.sh`

Script `deploy.sh` melakukan urutan berikut secara otomatis dan aman:

1. **Git Sync**: Menjalankan `git pull origin main`.
2. **Environment Check**: Memvalidasi keberadaan file `.env` dan variabel krusial.
3. **Izin Folder Media**: Menyiapkan direktori `media/` dengan izin `chmod -R 777` atau kepemilikan UID non-root `1001:1001` agar container aplikasi Next.js dapat mengunggah file tanpa kendala permission (`EACCES`).
4. **Build & Up**: Menjalankan `docker compose up -d --build --remove-orphans` untuk mem-build image baru dan merestart kontainer tanpa downtime lama.
5. **Healthcheck & Status**: Menampilkan status kesehatan seluruh container (`docker compose ps`).

---

## Pemeliharaan & Operasional Database (Database Maintenance)

Semua data kini tersimpan secara mandiri di container PostgreSQL `miraisoftnet-db`. Berikut panduan operasional penting:

### 1. Sinkronisasi Sequence PostgreSQL (Setelah Restore Dump)

Jika Anda baru saja merestore database dari file dump `.sql`, nomor sequence auto-increment ID PostgreSQL biasanya belum tersinkronkan dengan nilai ID tertinggi. Hal ini dapat menyebabkan error saat mengunggah media atau menambah data baru di panel admin CMS:
`"The following field is invalid: id"` (karena bentrok duplikasi kunci primer `id = 1`).

Jalankan perintah one-liner berikut di terminal server untuk menyinkronkan seluruh sequence tabel secara otomatis:

```bash
docker exec -i miraisoftnet-db psql -U postgres -d miraisoftnet_compro -c "
DO \$\$
DECLARE seq RECORD;
BEGIN
    FOR seq IN (
        SELECT t.table_name, s.sequence_name
        FROM information_schema.tables t
        JOIN information_schema.sequences s ON s.sequence_name = t.table_name || '_id_seq'
        WHERE t.table_schema = 'public'
    ) LOOP
        EXECUTE format('SELECT setval(%L, COALESCE((SELECT MAX(id) FROM %I), 1));', seq.sequence_name, seq.table_name);
    END LOOP;
END \$\$;"
```

### 2. Backup Database Mandiri

Untuk mencadangkan seluruh skema dan data database ke file SQL:

```bash
docker exec -t miraisoftnet-db pg_dump -U postgres miraisoftnet_compro > backup_$(date +%Y%m%d_%H%M%S).sql
```

### 3. Restore Database dari File SQL

Untuk merestore file cadangan database:

```bash
cat backup_file.sql | docker exec -i miraisoftnet-db psql -U postgres -d miraisoftnet_compro
```

*Catatan: Setelah restore selesai, jalankan script sinkronisasi sequence di poin 1.*

### 4. Backup & Restore File Media

Folder `media/` berada di host direktori `./media` yang di-mount langsung ke dalam container `/app/media`:

```bash
# Backup file media ke arsip kompresi:
tar -czvf media_backup_$(date +%Y%m%d).tar.gz media/

# Ekstrak arsip media:
tar -xzvf media_backup_YYYYMMDD.tar.gz
chmod -R 777 media
```

---

## Panduan Penyelesaian Masalah (Troubleshooting)

| Gejala / Error | Penyebab | Solusi |
| :--- | :--- | :--- |
| `connect ECONNREFUSED 127.0.0.1:5432` | Container PostgreSQL belum berjalan di laptop saat menjalankan `npm run dev`. | Jalankan `docker compose up -d postgres` di terminal laptop. |
| `{"errors":[{"message":"There was a problem while uploading the file."}]}` | User container non-root (`nextjs`, UID 1001) tidak memiliki izin tulis ke folder `./media` di host VPS. | Jalankan `chmod -R 777 media` di VPS, atau jalankan `bash deploy.sh`. |
| `{"errors":[{"message":"The following field is invalid: id"}]}` | Sequence PostgreSQL out-of-sync setelah restore data dump SQL. | Jalankan script sinkronisasi sequence di bagian **Pemeliharaan Database**. |
| `database "miraisoftnet_c" does not exist` atau terminal loncat saat eksekusi script bash | File `.sh` atau `.env` memiliki format newline Windows (CRLF `\r`). | Simpan file dengan format Unix (LF). Proyek telah dilengkapi `.gitattributes` untuk memastikan LF otomatis. |
| Gambar di laptop tidak muncul saat development | File media belum ada di laptop dan `NEXT_PUBLIC_REMOTE_MEDIA_URL` belum diatur. | Pastikan `NEXT_PUBLIC_REMOTE_MEDIA_URL=https://miraisoftnet.com` ada di `.env` lokal Anda. |

---

## Perintah Operasional Docker yang Berguna

| Kebutuhan | Perintah Terminal |
| :--- | :--- |
| **Melihat Log Aplikasi (Live/Streaming)** | `docker compose logs -f` |
| **Melihat Log Khusus App** | `docker compose logs -f app` |
| **Melihat Log Khusus Database** | `docker compose logs -f postgres` |
| **Melihat Status & Port Kontainer** | `docker compose ps` |
| **Restart Kontainer Aplikasi** | `docker compose restart app` |
| **Restart Kontainer Database** | `docker compose restart postgres` |
| **Masuk ke Shell Interaktif PostgreSQL (psql)** | `docker exec -it miraisoftnet-db psql -U postgres -d miraisoftnet_compro` |
| **Hentikan Seluruh Kontainer** | `docker compose down` |
| **Build Ulang Tanpa Cache (Fresh Build)** | `docker compose build --no-cache && docker compose up -d` |
| **Mengecek Penggunaan Resource (CPU/RAM)** | `docker stats miraisoftnet-compro miraisoftnet-db` |

---

## Pusat Dokumentasi Teknis (Technical Documentation)

Seluruh dokumentasi teknis, arsitektur sistem, dan panduan standarisasi kode telah disusun secara rapi di dalam folder [docs/](docs/):

| Dokumen | Topik Pembahasan |
| :--- | :--- |
| **[Pola Arsitektur](docs/ARCHITECTURE.md)** | Penjelasan arsitektur *Headless Fullstack* (Next.js 16 + PayloadCMS 3), pemisahan layer (Presentation, Data, CMS, Database), diagram alur Mermaid, dan keunggulan Payload Local API. |
| **[Peta Struktur Folder](docs/PROJECT_STRUCTURE.md)** | Penjelasan mendalam mengenai tata letak direktori root dan folder `src/` (`app/(public)`, `app/(payload)`, `collections`, `components/views`, `components/ui`, `lib`). |
| **[Data Layer & API](docs/DATA_LAYER_AND_API.md)** | Pola akses data Payload Local API (`getPayloadClient()`), strategi caching Next.js (`unstable_cache` dengan tag-based revalidation), ketersediaan endpoint REST (`/api/[...slug]`), dan GraphQL. |
| **[Model & Code Generation](docs/MODELS_AND_CODEGEN.md)** | Panduan pembuatan skema koleksi Payload CMS (`CollectionConfig`), konfigurasi fields, lifecycle hooks (auto slug), dan panduan generate tipe TypeScript ke `payload-types.ts`. |
| **[Manajemen State & Animasi](docs/STATE_MANAGEMENT.md)** | Pendekatan *Server-First Architecture* pada React Server Components (RSC), isolasi Client Components, implementasi React 19 hooks, dan animasi terstandarisasi dengan Framer Motion 12 (`FadeInUp`). |
| **[Standarisasi Kode](docs/CODING_STANDARDS.md)** | Konvensi penamaan berkas & simbol, panduan styling Tailwind CSS v4 via helper `cn()`, aturan penanganan breaking changes Next.js 16, standar SEO (metadata & JSON-LD), serta checklist pra-commit. |

---

## Navigasi Codebase Cepat dengan Graphify

Proyek ini telah dilengkapi dengan **Graphify Knowledge Graph** di direktori [graphify-out/](graphify-out/). Pengembang maupun AI agent tidak perlu memindai file satu per satu saat menganalisis relasi arsitektur:

- **Visualisasi Interaktif Browser**: Buka [graphify-out/graph.html](graphify-out/graph.html) langsung di browser Anda untuk menjelajahi peta arsitektur dan klaster modul secara visual.
- **Laporan Komunitas & Hubungan Modul**: Baca [graphify-out/GRAPH_REPORT.md](graphify-out/GRAPH_REPORT.md) untuk melihat daftar *God Nodes*, koneksi lintas modul, dan ringkasan struktur.
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
- **Database & Storage**: [PostgreSQL 16](https://www.postgresql.org/) (Self-Hosted Container) & Native Local Storage (`./media`)
- **Styling Engine**: [Tailwind CSS v4](https://tailwindcss.com/) & [PostCSS](https://postcss.org/)
- **Animasi & Interaktivitas**: [Framer Motion 12](https://motion.dev/)
- **Iconography**: [Lucide React](https://lucide.dev/)
- **Optimasi Gambar**: [Sharp](https://sharp.pixelplumbing.com/) (AVIF / WebP Native Pipeline)
- **Code Intelligence**: [Graphify](https://github.com/safishamsi/graphify)
