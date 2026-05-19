import type { CollectionConfig } from "payload";

export const Products: CollectionConfig = {
  slug: "products",
  admin: {
    useAsTitle: "name",
    description:
      "Daftar produk internal yang akan tampil sebagai Tab di halaman muka.",
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: "name",
      type: "text",
      required: true,
      label: "Nama Produk (Untuk nama Tab. Misal: Bit HRMS)",
    },
    {
      name: "productUrl",
      type: "text",
      required: true,
      label: "URL Website Produk",
      admin: {
        description:
          "Link ke landing page eksternal produk ini (Misal: https://bithrms.com)",
      },
    },
    {
      name: "subtitle",
      type: "textarea",
      required: true,
      label: "Sub-judul / Deskripsi Singkat",
      admin: {
        description:
          "Teks ini akan muncul di tooltip navigasi AppBar dan Card daftar layanan.",
      },
    },
    {
      name: "iconTitle",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Ikon Menu Navigasi",
      admin: {
        description: "Gunakan gambar berformat SVG atau PNG dengan rasio 1:1.",
      },
    },
    {
      name: "badge",
      type: "text",
      label: "Badge / Kicker (Misal: Smart HR & Talent Management)",
    },
    {
      name: "headline",
      type: "text",
      required: true,
      label: "Headline Utama (Misal: Business Intelligent for Talent)",
    },
    {
      name: "description",
      type: "textarea",
      required: true,
      label: "Deskripsi Singkat Produk",
    },
    {
      name: "features",
      type: "array",
      label: "Daftar Fitur Utama",
      fields: [
        {
          name: "icon",
          type: "upload",
          relationTo: "media",
          label: "Ikon Fitur (SVG/PNG)",
        },
        {
          name: "title",
          type: "text",
          required: true,
          label: "Nama Fitur (Misal: Absensi Cerdas & Validasi Presisi)",
        },
        {
          name: "description",
          type: "textarea",
          required: true,
          label: "Deskripsi Fitur",
        },
      ],
    },
    {
      name: "image",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Gambar Mockup Produk (Sebelah Kanan)",
    },
  ],
};
