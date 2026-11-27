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
      name: "showCTA",
      type: "checkbox",
      defaultValue: true,
      label: "Tampilkan CTA ke Website Produk",
      admin: {
        description:
          "Nonaktifkan jika halaman produk cukup berisi penjelasan dan tidak perlu tombol ke aplikasi/website eksternal.",
      },
    },
    {
      name: "productUrl",
      type: "text",
      label: "URL Website Produk",
      admin: {
        condition: (_, siblingData) => siblingData.showCTA !== false,
        description:
          "Wajib diisi jika CTA aktif. Tombol pada showcase dan halaman detail akan menuju URL ini.",
      },
      validate: (
        value: string | null | undefined,
        { data }: { data: { showCTA?: boolean | null } },
      ) => {
        if (data?.showCTA !== false && !value?.trim()) {
          return "URL Website Produk wajib diisi saat CTA aktif.";
        }
        return true;
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
      admin: {
        condition: (_, siblingData) => siblingData.showCTA !== false,
        description:
          "Teks tombol yang mengarahkan ke URL Website Produk di atas.",
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
      admin: {
        description: "Muncul di Hero section halaman muka dan halaman detail.",
      },
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
      admin: {
        description:
          "Ceritakan latar belakang, visi, dan solusi menyeluruh dari produk ini.",
      },
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
        {
          name: "description",
          type: "textarea",
          required: true,
          label: "Deskripsi Benefit",
        },
      ],
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
        { name: "title", type: "text", required: true, label: "Nama Fitur" },
        {
          name: "description",
          type: "textarea",
          required: true,
          label: "Deskripsi Fitur",
        },
        {
          name: "picture",
          type: "upload",
          relationTo: "media",
          label: "Gambar Detail Fitur",
        },
      ],
    },
    {
      name: "implementationTitle",
      type: "text",
      label: "Judul Bagian Tahapan Penerapan (Opsional)",
      admin: { description: "Kosongkan untuk memakai judul default." },
    },
    {
      name: "implementationDescription",
      type: "textarea",
      label: "Deskripsi Singkat Tahapan Penerapan (Opsional)",
    },
    {
      name: "implementationImage",
      type: "upload",
      relationTo: "media",
      label: "Gambar Utuh Tahapan Penerapan (Opsional)",
      admin: {
        description:
          "Jika diisi, gambar lebar penuh ditampilkan menggantikan daftar tahapan. Kosongkan untuk menampilkan daftar.",
      },
    },
    {
      name: "implementationSteps",
      type: "array",
      label: "Tahapan Penerapan Produk (Opsional)",
      labels: { singular: "Langkah", plural: "Langkah" },
      admin: {
        description:
          "Tahapan onboarding/penerapan produk dari awal hingga siap digunakan. Tidak untuk alur kerja di dalam produk.",
        initCollapsed: true,
      },
      fields: [
        {
          name: "title",
          type: "text",
          required: true,
          label: "Nama Tahap (Misal: Konsultasi Kebutuhan)",
        },
        { name: "description", type: "textarea", label: "Deskripsi Tahap" },
        {
          name: "duration",
          type: "text",
          label: "Estimasi Durasi (Opsional, Misal: 1-2 Minggu)",
        },
      ],
    },
    {
      name: "workflowTitle",
      type: "text",
      label: "Judul Bagian Cara Kerja Produk (Opsional)",
      admin: {
        description:
          "Judul untuk alur penggunaan/proses yang dijalankan produk.",
      },
    },
    {
      name: "workflowDescription",
      type: "textarea",
      label: "Deskripsi Bagian Cara Kerja Produk (Opsional)",
    },
    {
      name: "workflowImage",
      type: "upload",
      relationTo: "media",
      label: "Gambar Utuh Cara Kerja (Opsional)",
      admin: {
        description:
          "Jika diisi, gambar lebar penuh ditampilkan menggantikan tab dan daftar jalur. Kosongkan untuk menampilkan daftar jalur.",
      },
    },
    {
      name: "workflowTracks",
      type: "array",
      label: "Jalur Cara Kerja Produk",
      labels: { singular: "Jalur", plural: "Jalur" },
      admin: {
        description:
          "Gunakan beberapa jalur untuk proses yang bercabang, misalnya Staff dan Non-Staff. Bagian tidak tampil jika tidak ada langkah.",
        initCollapsed: true,
      },
      fields: [
        { name: "name", type: "text", required: true, label: "Nama Jalur" },
        {
          name: "description",
          type: "textarea",
          label: "Deskripsi Jalur (Opsional)",
        },
        {
          name: "steps",
          type: "array",
          label: "Langkah dalam Jalur",
          labels: { singular: "Langkah", plural: "Langkah" },
          minRows: 1,
          fields: [
            {
              name: "title",
              type: "text",
              required: true,
              label: "Nama Langkah",
            },
            {
              name: "description",
              type: "textarea",
              label: "Penjelasan Langkah (Opsional)",
            },
          ],
        },
      ],
    },
    {
      name: "useCases",
      type: "array",
      label: "Target Pengguna / Industri (Use Cases)",
      fields: [
        {
          name: "industry",
          type: "text",
          required: true,
          label: "Nama Industri / Target (Misal: Manufaktur)",
        },
      ],
    },
    {
      name: "gallery",
      type: "array",
      label: "Galeri / Screenshot Antarmuka (UI)",
      fields: [
        {
          name: "galleryImage",
          type: "upload",
          relationTo: "media",
          required: true,
          label: "Gambar Screenshot",
        },
        { name: "caption", type: "text", label: "Caption Gambar (Opsional)" },
      ],
    },
    {
      name: "integrations",
      type: "array",
      label: "Integrasi & Teknologi Pendukung",
      admin: {
        description:
          "Sistem yang bisa dihubungkan. Misal: SAP, Android, iOS, Hardware Khusus.",
      },
      fields: [
        {
          name: "logo",
          type: "upload",
          relationTo: "media",
          label: "Logo Integrasi/Teknologi",
        },
        {
          name: "name",
          type: "text",
          required: true,
          label: "Nama Sistem (Misal: SAP ERP)",
        },
      ],
    },
    {
      name: "clients",
      type: "array",
      label: "Klien yang Menggunakan Produk Ini",
      admin: { description: "Tampilkan logo perusahaan sebagai social proof." },
      fields: [
        {
          name: "clientLogo",
          type: "upload",
          relationTo: "media",
          required: true,
          label: "Logo Klien",
        },
        { name: "clientName", type: "text", label: "Nama Klien" },
      ],
    },
  ],
};
