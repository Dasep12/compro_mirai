# Standarisasi Kode & Panduan Implementasi (Coding Standards)

Dokumen ini berisi aturan, konvensi penulisan kode, dan *best practices* pengembangan antarmuka serta data yang wajib diikuti oleh setiap developer pada proyek **MiraiSoftNet Company Profile (Next.js 16, React 19, TypeScript, & Tailwind CSS v4)**.

---

## Konvensi Penamaan (Naming Conventions)

| Elemen | Format Standar | Contoh Sesuai | Tidak Sesuai |
| :--- | :--- | :--- | :--- |
| **Folder Rute Next.js** | `kebab-case` | `about-us/`, `careers/` | `aboutUs/`, `About_Us/` |
| **Berkas Komponen React** | `PascalCase.tsx` | `AppBar.tsx`, `Hero.tsx`, `FadeInUp.tsx` | `appBar.tsx`, `hero_section.tsx` |
| **Berkas Koleksi CMS** | `PascalCase.ts` | `Services.ts`, `AboutUs.ts`, `Career.ts` | `services.ts`, `about_us.ts` |
| **Berkas Utility / Lib** | `camelCase.ts` | `utils.ts`, `whatsapp.ts`, `collections.ts` | `Utils.ts`, `WhatsApp.ts` |
| **Interface / Type** | `PascalCase` | `ServiceProps`, `CustomerFeedback` | `service_props`, `ICustomer` |
| **Fungsi / Method** | `camelCase` (kata kerja) | `getServices()`, `generateSlug()` | `GetServices()`, `get_services()` |
| **Variabel / Properti** | `camelCase` | `customerList`, `isOpen`, `activeTab` | `CustomerList`, `is_open` |
| **Environment Variable** | `UPPER_SNAKE_CASE` | `PAYLOAD_SECRET`, `DATABASE_URI` | `payloadSecret`, `database_uri` |

---

## Standarisasi Styling (Tailwind CSS v4)

### 1. Penggabungan Class Dinamis dengan Helper `cn()`

Hindari concatenasi string biasa yang rawan konflik class CSS. Selalu gunakan helper `cn()` yang memadukan `clsx` dan `tailwind-merge`:

```tsx
// src/lib/utils.ts
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
```

*Contoh Penggunaan:*

```tsx
<button
  className={cn(
    "px-4 py-2 rounded-lg font-medium transition-colors",
    isActive ? "bg-primary text-white" : "bg-gray-100 text-gray-700 hover:bg-gray-200",
    className
  )}
>
  {children}
</button>
```

### 2. Pendekatan Mobile-First

Selalu bangun tampilan dimulai dari layar mobile terkecil, lalu tambahkan breakpoint bertingkat:

```tsx
// Benar (Mobile-first)
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  {/* Items */}
</div>
```

---

## Standarisasi Aturan Next.js 16 & React 19

### 1. Directive `'use client'`

Letakkan directive `'use client'` di baris paling pertama file **hanya** jika komponen tersebut:

- Menggunakan React hooks (`useState`, `useEffect`, `useRef`, `useCallback`).
- Menggunakan browser API (`window`, `localStorage`, event listener `scroll`).
- Menggunakan Framer Motion (`motion.div`, `AnimatePresence`).

> [!TIP]
> Pertahankan Server Components di level rute atau container sebanyak mungkin, dan isolasi Client Components hanya ke bagian interaktif daun (*leaf components*).

### 2. Penanganan Asynchronous Rute (`params` & `searchParams`)

Pada Next.js versi modern (15+ & 16), parameter rute `params` dan `searchParams` harus ditangani sebagai `Promise`:

```tsx
// src/app/(public)/services/[slug]/page.tsx
interface ServiceDetailPageProps {
  params: Promise<{ slug: string }>;
}

export default async function ServiceDetailPage({ params }: ServiceDetailPageProps) {
  const { slug } = await params;
  const service = await getServiceBySlug(slug);

  if (!service) {
    notFound();
  }

  return <ServiceDetailView service={service} />;
}
```

---

## Standarisasi SEO & Metadata

Setiap halaman wajib memiliki metadata deskriptif untuk memastikan optimasi mesin pencari dan visibilitas social share:

```tsx
// Contoh deklarasi metadata dinamis
export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const service = await getServiceBySlug(slug);

  if (!service) return { title: "Layanan Tidak Ditemukan" };

  return {
    title: `${service.title} | Mirai Softnet`,
    description: service.subtitle,
    openGraph: {
      title: service.title,
      description: service.subtitle,
      images: [
        {
          url: typeof service.iconTitle === "object" ? service.iconTitle?.url ?? "" : "",
          width: 800,
          height: 600,
          alt: service.title,
        },
      ],
    },
  };
}
```

---

## Standarisasi Komponen & Media

### Penggunaan Wrapper Gambar (`src/components/ui/Image.tsx`)

Untuk menangani aset gambar yang diunggah via Payload Media secara aman:

- Selalu sertakan `alt` text yang relevan.
- Atur dimensi `width` dan `height` atau gunakan properti `fill` bersama container `relative`.
- Tangani kasus jika URL media bernilai `null` atau `undefined` dengan fallback placeholder.

---

## Checklist Pra-Commit & Code Review

Sebelum melakukan push atau membuat Pull Request, pastikan seluruh checklist berikut terpenuhi:

- [ ] **Linter Bersih**: Jalankan `npm run lint` tanpa menghasilkan peringatan (*warning*) atau error.
- [ ] **Generate Types Terupdate**: Jika ada modifikasi pada file koleksi di `src/collections/`, pastikan telah mengeksekusi `npm run generate:types`.
- [ ] **Type Check**: Pastikan tidak ada type error TypeScript (`npx tsc --noEmit`).
- [ ] **Build Valid**: Pastikan aplikasi berhasil dibuild via `npm run build`.
- [ ] **Graphify Terupdate**: Jalankan `graphify update .` atau pastikan git hook post-commit terpasang agar knowledge graph tetap mutakhir.
