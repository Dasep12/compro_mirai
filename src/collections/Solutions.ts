import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const Solutions: CollectionConfig = {
  slug: "solutions",
  admin: {
    useAsTitle: "title",
    defaultColumns: ["title", "industry", "partnership_solution", "publishedDate"],
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
      label: "Vertical Industry (Sektor Industri)",
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
      label: "Solution Category (Kategori Solusi)",
      admin: {
        description: "Pilih satu atau lebih kategori solusi dari koleksi Solution Categories.",
      },
    },
    {
      name: "partnership_solution",
      type: "relationship",
      relationTo: "partnership-solutions",
      hasMany: true,
      label: "Partnership Solution (Brand / Mitra Solusi)",
      admin: {
        description: "Pilih satu atau lebih mitra/brand teknologi dari koleksi Partnership Solutions.",
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
      name: "description",
      type: "richText",
      label: "Deskripsi",
      admin: {
        description: "Deskripsi lengkap mengenai solusi (dapat menggunakan heading H1-H6, list, bold, dll).",
      },
    },
    {
      name: "coverImage",
      type: "upload",
      relationTo: "media",
      label: "Gambar Cover / Banner Solusi",
    },
  ],
};
