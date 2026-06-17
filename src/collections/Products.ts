import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const Products: CollectionConfig = {
  slug: "products",
  admin: {
    useAsTitle: "name",
    description:
      "Daftar produk internal yang akan tampil sebagai Tab di halaman muka dan halaman Detail Produk.",
  },
  hooks: {
    beforeValidate: [
      ({ data }) => {
        if (data?.name && !data?.slug) {
          data.slug = generateSlug(data.name);
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
        description: "Link ke landing page eksternal produk ini (Misal: https://bithrms.com)",
      },
    },
    {
      name: "slug",
      type: "text",
      required: true,
      unique: true,
      label: "URL Slug",
    },
    {
      name: "ctaText",
      type: "text",
      defaultValue: "Kunjungi Website",
      label: "Teks Tombol CTA (Call to Action)",
      admin: { description: "Teks tombol yang mengarahkan ke URL Website Produk di atas." },
    },
    {
      name: "subtitle",
      type: "textarea",
      required: true,
      label: "Sub-judul / Deskripsi Singkat",
      admin: {
        description: "Teks ini akan muncul di tooltip navigasi AppBar dan Card daftar layanan.",
      },
    },
    {
      name: "iconTitle",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Ikon Menu Navigasi",
      admin: { description: "Gunakan gambar berformat SVG atau PNG dengan rasio 1:1." },
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
      admin: { description: "Muncul di Hero section halaman muka dan halaman detail." },
    },
    {
      name: "image",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Gambar Mockup Produk Utama (Hero Image)",
    },
    {
      name: "fullDescription",
      type: "richText",
      label: "Deskripsi Lengkap Produk",
      admin: { description: "Ceritakan latar belakang, visi, dan solusi menyeluruh dari produk ini." },
    },
    {
      name: "benefitTitle",
      type: "text",
      required: true,
      label: "Judul Bagian Value Proposition / Benefit",
    },
    {
      name: "benefitDescription",
      type: "textarea",
      required: true,
      label: "Deskripsi Singkat Bagian Value Proposition / Benefit",
    },
    {
      name: "benefits",
      type: "array",
      label: "Nilai Jual / Keuntungan Bisnis (Benefits)",
      fields: [
        { name: "title", type: "text", required: true, label: "Judul Benefit" },
        { name: "description", type: "textarea", required: true, label: "Deskripsi Benefit" },
      ],
    },
    {
      name: "features",
      type: "array",
      label: "Daftar Fitur Utama",
      fields: [
        { name: "icon", type: "upload", relationTo: "media", label: "Ikon Fitur (SVG/PNG)" },
        { name: "title", type: "text", required: true, label: "Nama Fitur" },
        { name: "description", type: "textarea", required: true, label: "Deskripsi Fitur" },
        { name: "picture", type: "upload", relationTo: "media", label: "Gambar Detail Fitur" },
      ],
    },
    {
      name: "useCases",
      type: "array",
      label: "Target Pengguna / Industri (Use Cases)",
      fields: [
        { name: "industry", type: "text", required: true, label: "Nama Industri / Target (Misal: Manufaktur)" },
      ],
    },
    {
      name: "gallery",
      type: "array",
      label: "Galeri / Screenshot Antarmuka (UI)",
      fields: [
        { name: "galleryImage", type: "upload", relationTo: "media", required: true, label: "Gambar Screenshot" },
        { name: "caption", type: "text", label: "Caption Gambar (Opsional)" },
      ],
    },
    {
      name: "integrations",
      type: "array",
      label: "Integrasi & Teknologi Pendukung",
      admin: { description: "Sistem yang bisa dihubungkan. Misal: SAP, Android, iOS, Hardware Khusus." },
      fields: [
        { name: "logo", type: "upload", relationTo: "media", label: "Logo Integrasi/Teknologi" },
        { name: "name", type: "text", required: true, label: "Nama Sistem (Misal: SAP ERP)" },
      ],
    },
    {
      name: "clients",
      type: "array",
      label: "Klien yang Menggunakan Produk Ini",
      admin: { description: "Tampilkan logo perusahaan sebagai social proof." },
      fields: [
        { name: "clientLogo", type: "upload", relationTo: "media", required: true, label: "Logo Klien" },
        { name: "clientName", type: "text", label: "Nama Klien" },
      ],
    },
  ],
};