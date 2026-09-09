# Data Layer, Payload Local API, Caching, & Routing

Dokumen ini menjelaskan mekanisme akses data, integrasi **Payload Local API**, strategi caching Next.js (`unstable_cache`), serta ketersediaan endpoint REST dan GraphQL pada proyek **MiraiSoftNet Company Profile**.

---

## Pola Akses Data: Payload Local API

Berbeda dengan arsitektur headless CMS terpisah yang mewajibkan request HTTP lintas server, proyek ini mengadopsi pola **Payload Local API**.

Server Components Next.js mengeksekusi query database secara langsung melalui Node.js runtime tanpa melalui jaringan HTTP:

```text
[Server Component (RSC)] 
       │
       ▼ (Direct Node.js Function Call)
[getPayloadClient() Singleton]
       │
       ▼ (Direct SQL Execution via postgresAdapter)
[PostgreSQL Database / Supabase]
```

### Keuntungan Pola Local API

1. **Performa Instan**: Nol latensi jaringan HTTP dan tidak ada overhead serialisasi/deserialisasi HTTP berulang.
2. **Keamanan Maksimal**: Kredensial database tidak pernah terpapar ke sisi client/browser.
3. **Penyaringan Lanjutan**: Mendukung kueri kompleks, relasi nested (`depth: 1` atau `depth: 2`), dan pagination langsung dari TypeScript.

---

## Singleton Client: `src/lib/payload.ts`

Untuk mencegah pembuatan koneksi database baru pada setiap *hot-reload* di lingkungan pengembangan, Payload client dibungkus dalam objek global:

```typescript
// src/lib/payload.ts
import { getPayload } from "payload";
import config from "../../payload.config";

const globalForPayload = globalThis as unknown as { _payloadClient: any };

export async function getPayloadClient() {
  if (!globalForPayload._payloadClient) {
    globalForPayload._payloadClient = await getPayload({ config });
  }
  return globalForPayload._payloadClient;
}
```

---

## Strategi Caching: `src/lib/data/collections.ts`

Setiap pemanggilan data dibungkus dengan fungsi `unstable_cache` dari Next.js. Hal ini memastikan data statis tetap cepat disajikan dari memory cache, sembari memberikan interval revalidasi berkala.

### 1. Pola Pengambilan Data List (dengan Tag-Based Cache)

```typescript
// src/lib/data/collections.ts
import { unstable_cache } from "next/cache";
import { getPayloadClient } from "../payload";

export const getServices = unstable_cache(
  async (limit = 10) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "services",
      depth: 1,
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["services"], // Kunci identifikasi cache
  { revalidate: 60, tags: ["services"] }, // TTL 60 detik + tag untuk on-demand revalidation
);
```

### 2. Pola Pengambilan Data Tunggal Berdasarkan Slug

Untuk halaman detail dinamis (seperti `/services/[slug]` atau `/products/[slug]`), fungsi menerima parameter `slug` dan mengambil relasi data lebih dalam (`depth: 2`):

```typescript
// src/lib/data/collections.ts
export async function getServiceBySlug(slug: string) {
  if (!slug) return null;

  try {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "services",
      depth: 2,
      where: { slug: { equals: slug } },
      limit: 1,
    });

    return result?.docs?.[0] ?? null;
  } catch (error) {
    console.error(`[Error] Failed to fetch service by slug (${slug}):`, error);
    return null;
  }
}
```

### 3. Pola Pengambilan Data Global (Single Document)

Untuk entitas global seperti data profil perusahaan `AboutUs`:

```typescript
// src/lib/data/collections.ts
export const getAboutUs = unstable_cache(
  async () => {
    const payload = await getPayloadClient();
    return payload.findGlobal({ slug: "about-us" });
  },
  ["about-us"],
  { revalidate: 60, tags: ["about-us"] },
);
```

---

## Konsumsi Data pada Server Components

Halaman publik memanfaatkan eksekusi paralel `Promise.all` di server untuk memuat seluruh kebutuhan data secara simultan tanpa *waterfall*:

```tsx
// src/app/(public)/page.tsx
export default async function Home() {
  const [
    customers,
    partnerships,
    services,
    products,
    portfolios,
    faqs,
    problems,
  ] = await Promise.all([
    getCustomers(20),
    getPartnerships(20),
    getServices(10),
    getProducts(10),
    getPortfolios(10),
    getFaqs(10),
    getProblems(10),
  ]);

  return (
    <div className="overflow-hidden">
      <Hero />
      <PartnershipCustomer customers={customers} partnerships={partnerships} />
      <Problem data={problems} />
      <ServiceShowcase services={services} />
      <ProductShowcase products={products} />
      <PortfolioShowcase portfolios={portfolios} />
      <Contact />
      <FaqShowcase faqs={faqs} />
    </div>
  );
}
```

---

## Endpoint API Otomatis (REST & GraphQL)

Meskipun halaman publik menggunakan Local API, PayloadCMS secara otomatis mengekspos endpoint jaringan yang dapat diakses oleh aplikasi eksternal (misal: mobile app, webhook, atau integrasi pihak ketiga) melalui route handler di `src/app/(payload)/api/[...slug]/route.ts`:

### REST API Endpoints

| Endpoint | Method | Keterangan |
| :--- | :--- | :--- |
| **`/api/services`** | `GET`, `POST` | Mengambil atau menambah data layanan |
| **`/api/services/:id`** | `GET`, `PATCH`, `DELETE` | Operasi data layanan spesifik |
| **`/api/products`** | `GET`, `POST` | Mengambil katalog produk |
| **`/api/portfolios`** | `GET` | Mengambil daftar portofolio |
| **`/api/careers`** | `GET` | Mengambil data lowongan kerja |
| **`/api/news`** | `GET` | Mengambil daftar artikel berita |
| **`/api/globals/about-us`** | `GET`, `POST` | Mengambil dokumen profil perusahaan |
| **`/api/media/file/:filename`** | `GET` | Streaming file gambar atau dokumen yang diunggah |

### GraphQL API

PayloadCMS juga menyediakan endpoint GraphQL terpadu:

- **URL**: `/api/graphql`
- **GraphQL Playground**: Tersedia secara visual di lingkungan pengembangan untuk menguji query dan schema.

---

## Koneksi Database & Konfigurasi Lingkungan

Konfigurasi database diatur pada `payload.config.ts` menggunakan adapter `@payloadcms/db-postgres`:

```typescript
// payload.config.ts
db: postgresAdapter({
  pool: {
    connectionString: process.env.DATABASE_URI,
  },
}),
```

### Variabel Lingkungan Wajib (`.env`)

```env
# Payload CMS Secret Key
PAYLOAD_SECRET=your-secure-payload-secret

# PostgreSQL Database Connection String (Supabase / Neon / Local Postgres)
DATABASE_URI=postgresql://postgres.xxx:password@aws-0-region.pooler.supabase.com:6543/postgres

# Supabase Client Public Keys (Opsional untuk integrasi storage/client)
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```
