import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const Solutions: CollectionConfig = {
  slug: "solutions",
  admin: {
    useAsTitle: "title",
    defaultColumns: ["title", "industry", "publishedDate"],
    description: "Daftar Solusi & Use Case Industri (Halaman /solution).",
  },
  hooks: {
    beforeValidate: [
      ({ data }) => {
        if (data?.title) {
          data.slug = generateSlug(data.title);
        }
        return data;
      },
    ],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: "title",
      type: "text",
      required: true,
      label: "Judul Use Case Solusi (Misal: Safety & Emergency Response System for Resorts)",
    },
    {
      name: "slug",
      type: "text",
      unique: true,
      label: "URL Slug",
      admin: {
        position: "sidebar",
        readOnly: true,
        description: "Otomatis di-generate dari nama use case saat disimpan.",
      },
    },
    {
      name: "publishedDate",
      type: "date",
      required: true,
      label: "Tanggal Publikasi",
      defaultValue: () => new Date().toISOString(),
      admin: {
        date: {
          pickerAppearance: "dayOnly",
          displayFormat: "d MMMM yyyy",
        },
        description: "Ditampilkan di daftar use case: 'Posted on DD MMMM YYYY'",
      },
    },
    {
      name: "industry",
      type: "relationship",
      relationTo: "industries",
      required: true,
      label: "Industri (Untuk Filter Menu)",
      admin: {
        description: "Pilih sektor industri dari koleksi Industries.",
      },
    },
    {
      name: "solutionCategories",
      type: "relationship",
      relationTo: "solution-categories",
      hasMany: true,
      required: true,
      label: "Kategori Solusi (Badge Kolom Kanan)",
      admin: {
        description: "Pilih satu atau lebih kategori solusi dari koleksi Solution Categories.",
      },
    },
    {
      name: "excerpt",
      type: "textarea",
      required: true,
      label: "Ringkasan Singkat (Description pada tabel list view)",
      admin: {
        description: "Teks ini muncul di kolom Description pada tabel use case sebelum link Details.",
      },
    },
    {
      name: "coverImage",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Gambar Cover / Banner Solusi",
    },

    // --- Content Tabs for Detail Page ---
    {
      type: "tabs",
      tabs: [
        {
          label: "Latar Belakang & Masalah",
          fields: [
            {
              name: "businessChallenge",
              type: "richText",
              label: "Tantangan Bisnis / Masalah Industri (Business Challenge)",
              admin: {
                description: "Uraikan tantangan atau risiko yang dihadapi industri sebelum solusi ini diimplementasikan.",
              },
            },
          ],
        },
        {
          label: "Arsitektur & Solusi",
          fields: [
            {
              name: "solutionOverview",
              type: "richText",
              label: "Penjelasan Lengkap Solusi (Solution Overview)",
              admin: {
                description: "Jelaskan bagaimana solusi ini bekerja menjawab tantangan di atas.",
              },
            },
            {
              name: "architectureDiagram",
              type: "upload",
              relationTo: "media",
              label: "Diagram Arsitektur / Topologi Sistem (Opsional)",
              admin: {
                description: "Visualisasi teknis alur perangkat, cloud, atau integrasi software.",
              },
            },
            {
              name: "keyFeatures",
              type: "array",
              label: "Fitur / Kapabilitas Utama",
              fields: [
                {
                  name: "title",
                  type: "text",
                  required: true,
                  label: "Nama Fitur",
                },
                {
                  name: "description",
                  type: "textarea",
                  required: true,
                  label: "Deskripsi Singkat Fitur",
                },
              ],
            },
          ],
        },
        {
          label: "Key Benefits & ROI",
          fields: [
            {
              name: "keyBenefits",
              type: "array",
              label: "Daftar Manfaat Terukur (Key Benefits)",
              fields: [
                {
                  name: "metric",
                  type: "text",
                  label: "Metrik / Angka (Misal: '99.9%', '50% Faster', '24/7')",
                },
                {
                  name: "title",
                  type: "text",
                  required: true,
                  label: "Judul Manfaat",
                },
                {
                  name: "description",
                  type: "textarea",
                  required: true,
                  label: "Uraian Manfaat",
                },
              ],
            },
          ],
        },
        {
          label: "Ekosistem Terkait",
          fields: [
            {
              name: "partners",
              type: "relationship",
              relationTo: "partnerships",
              hasMany: true,
              label: "Mitra Teknologi / Technology Partners (Ecosystem)",
              admin: {
                description: "Pilih partner vendor resmi yang teknologinya digunakan dalam solusi ini.",
              },
            },
            {
              name: "relatedServices",
              type: "relationship",
              relationTo: "services",
              hasMany: true,
              label: "Layanan Mirai Terkait",
              admin: {
                description: "Layanan jasa yang terlibat dalam implementasi solusi ini.",
              },
            },
            {
              name: "relatedProducts",
              type: "relationship",
              relationTo: "products",
              hasMany: true,
              label: "Produk Mirai Terkait",
              admin: {
                description: "Produk internal Mirai yang digunakan dalam solusi ini.",
              },
            },
            {
              name: "relatedPortfolios",
              type: "relationship",
              relationTo: "portfolios",
              hasMany: true,
              label: "Studi Kasus Klien Terkait (Opsional)",
              admin: {
                description: "Contoh implementasi nyata solusi ini pada portofolio klien terdahulu.",
              },
            },
          ],
        },
        {
          label: "CTA & Dokumen",
          fields: [
            {
              name: "ctaText",
              type: "text",
              label: "Teks Tombol Konsultasi (WhatsApp)",
              defaultValue: "Konsultasikan Solusi Ini",
            },
            {
              name: "solutionDocument",
              type: "upload",
              relationTo: "media",
              label: "Dokumen Solution Brief / Brosur PDF (Opsional)",
              admin: {
                description: "Brosur atau whitepaper yang bisa di-download pengunjung.",
              },
            },
          ],
        },
      ],
    },
  ],
};
