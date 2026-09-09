# Data Models & TypeScript Code Generation (`payload-types.ts`)

Dokumen ini menjelaskan standarisasi pembuatan model data di PayloadCMS, konfigurasi skema koleksi, dan mekanisme *Code Generation* otomatis ke dalam definisi tipe TypeScript (`payload-types.ts`).

---

## Konsep Schema-Driven Modeling

Pada proyek ini, seluruh struktur data didefinisikan secara deklaratif di folder `src/collections/` menggunakan objek `CollectionConfig` atau `GlobalConfig` dari paket `payload`:

- **Single Source of Truth**: Skema field CMS menjadi acuan utama untuk database tables, antarmuka admin UI, validasi form, dan tipe TypeScript.
- **Type-Safe Development**: Setiap properti yang dibuat pada CMS akan secara otomatis terpetakan ke interface TypeScript yang ketat.
- **Lifecycle Hooks**: Skema dapat menyematkan logika bisnis otomatis (seperti penentuan slug otomatis dari judul).

---

## Mekanisme Code Generation (`npm run generate:types`)

PayloadCMS menyediakan CLI bawaan untuk membaca `payload.config.ts` dan menghasilkan satu file definisi tipe TypeScript lengkap bernama `payload-types.ts`:

### Perintah Generate

```bash
# Menghasilkan ulang file payload-types.ts
npm run generate:types
```

*Script di balik layar pada `package.json`:*

```bash
cross-env PAYLOAD_CONFIG_PATH=payload.config.ts payload generate:types
```

### Konfigurasi Target Output (`payload.config.ts`)

Lokasi file hasil generate diatur secara eksplisit pada file konfigurasi utama:

```typescript
// payload.config.ts
export default buildConfig({
  // ...
  typescript: {
    outputFile: path.resolve(dirname, "payload-types.ts"),
  },
});
```

---

## Struktur File: Definisi Skema vs Tipe Hasil Generate

| File | Dibuat Oleh | Fungsi & Tanggung Jawab |
| :--- | :--- | :--- |
| **`src/collections/<Nama>.ts`** | Developer | Mendefinisikan nama tabel (slug), field form, validasi, hak akses, dan hooks. |
| **`payload.config.ts`** | Developer | Mendaftarkan seluruh koleksi dan konfigurasi database/editor. |
| **`payload-types.ts`** | Payload CLI | Menghasilkan interface TypeScript lengkap (`Service`, `Product`, `Customer`, `Career`, dll.). |

---

## Panduan Membuat Skema Koleksi Baru

Ikuti langkah-langkah terstandarisasi berikut saat menambahkan entitas data baru:

### 1. Buat File Skema Koleksi (`src/collections/NamaKoleksi.ts`)

Contoh pembuatan koleksi dengan fitur auto-slug dan relasi media:

```typescript
// src/collections/Example.ts
import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const Example: CollectionConfig = {
  slug: "examples",
  admin: {
    useAsTitle: "title",
  },
  hooks: {
    beforeValidate: [
      ({ data }) => {
        // Otomatis buat slug jika belum diisi
        if (data?.title && !data?.slug) {
          data.slug = generateSlug(data.title);
        }
        return data;
      },
    ],
  },
  access: {
    read: () => true, // Akses baca publik
  },
  fields: [
    {
      name: "title",
      type: "text",
      required: true,
      label: "Judul",
    },
    {
      name: "slug",
      type: "text",
      required: true,
      unique: true,
      label: "URL Slug",
    },
    {
      name: "image",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Foto / Gambar Sampul",
    },
    {
      name: "description",
      type: "richText",
      label: "Konten Lengkap",
    },
  ],
};
```

### 2. Daftarkan di `payload.config.ts`

Impor dan masukkan koleksi baru ke dalam array `collections`:

```typescript
// payload.config.ts
import { Example } from "./src/collections/Example";

export default buildConfig({
  collections: [
    Users,
    Services,
    // ...
    Example,
  ],
  // ...
});
```

### 3. Eksekusi Code Generation

Jalankan perintah berikut di terminal:

```bash
npm run generate:types
```

Setelah perintah selesai, antarmuka `Example` akan otomatis tersedia di `payload-types.ts`.

### 4. Konsumsi Tipe pada Data Layer & Komponen Frontend

Gunakan tipe yang dihasilkan untuk memastikan type-safety:

```tsx
// src/components/views/example/ExampleCard.tsx
import type { Example } from "@/../payload-types";

interface ExampleCardProps {
  item: Example;
}

export default function ExampleCard({ item }: ExampleCardProps) {
  return (
    <div className="p-4 border rounded-xl">
      <h3 className="text-lg font-bold">{item.title}</h3>
      <p className="text-sm text-gray-500">{item.slug}</p>
    </div>
  );
}
```

---

## Daftar Tipe Utama pada Proyek Ini

Semua tipe berikut dapat diimpor langsung dari `@/../payload-types`:

| Nama Interface | Koleksi Sumber | Digunakan Pada |
| :--- | :--- | :--- |
| **`Service`** | `src/collections/Services.ts` | Navigasi AppBar, Showcase Home, Halaman Detail Layanan |
| **`Product`** | `src/collections/Products.ts` | Navigasi AppBar, Showcase Home, Katalog Produk |
| **`Customer`** | `src/collections/Customers.ts` | Testimonial & Logo Slider Customer |
| **`Partnership`** | `src/collections/Partnership.ts` | Logo Slider Partner Strategis |
| **`Portfolio`** | `src/collections/Portfolios.ts` | Showcase Portofolio & Studi Kasus |
| **`Career`** | `src/collections/Career.ts` | Listing Lowongan & Detail Pekerjaan |
| **`News`** | `src/collections/News.ts` | Grid Berita & Pembaca Artikel |
| **`Faq`** | `src/collections/Faqs.ts` | Accordion Tanya-Jawab Umum |
| **`PricingFaq`** | `src/collections/PricingFaq.ts` | Accordion Tanya-Jawab Harga |
| **`Problem`** | `src/collections/Problem.ts` | Bagian "Tantangan Bisnis" di Homepage |
| **`AboutU`** | `src/collections/AboutUs.ts` | Profil Perusahaan, Visi, Misi |
| **`Media`** | `src/collections/Media.ts` | Komponen [Image.tsx](file:///c:/repository/compro_mirai/src/components/ui/Image.tsx) & render aset |
