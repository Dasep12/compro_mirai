# Spec: Alur Implementasi Produk

## User Flow
- Admin mengisi (opsional) judul, deskripsi, dan daftar langkah implementasi di collection **Products** (Payload).
- Halaman `/products/[slug]` menampilkan section "Alur Implementasi" di antara **Nilai Bisnis** dan **Galeri**.
- Desktop (lg+): grid 3 kolom berpola ular (kiri → kanan, turun, kanan → kiri, turun, ...), terinspirasi `AboutMilestone`,
  dengan modifikasi: node bernomor (01, 02, ...), konektor solid + panah arah, kartu rata kiri, estimasi durasi opsional,
  langkah terakhir diberi aksen.
- Mobile/tablet: timeline vertikal dengan node bernomor di kiri.

## Data (Payload, semua opsional)
- `implementationTitle` (text) – fallback: "Langkah mudah menuju implementasi {nama produk}".
- `implementationDescription` (textarea).
- `implementationSteps` (array): `title` (text, wajib per baris), `description` (textarea), `duration` (text, misal "1–2 Minggu").

## Dependencies
- Tidak ada paket baru. Memakai `lucide-react` (sudah ada) untuk ikon panah & jam.
- DB: adapter Postgres memakai `push: true` sehingga skema tersinkron otomatis saat dev. Production perlu sinkronisasi skema seperti field lain.

## Edge Case & Failure Handling
- `implementationSteps` kosong/null → section tidak dirender (`return null`).
- 1 langkah → tanpa konektor; jumlah langkah bukan kelipatan 3 → baris terakhir tetap mengikuti arah ular.
- `description`/`duration` kosong → elemen terkait tidak dirender.
- Kegagalan fetch produk sudah ditangani `getProductBySlug` (→ `notFound()`).
