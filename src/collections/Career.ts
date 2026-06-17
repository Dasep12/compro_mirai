import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const Career: CollectionConfig = {
  slug: "careers",
  admin: {
    useAsTitle: "title",
    defaultColumns: ["title", "category", "type", "location"],
  },
  hooks: {
    beforeValidate: [
      ({ data }) => {
        if (data?.title && !data?.slug) {
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
      label: "Posisi Pekerjaan (Contoh: Fullstack Developer)",
    },
    {
      name: "slug",
      type: "text",
      required: true,
      unique: true,
      label: "URL Slug (Contoh: fullstack-developer)",
    },
    {
      name: "isUrgent",
      type: "checkbox",
      label: "Tandai sebagai URGENT? (Akan memunculkan badge merah)",
      defaultValue: false,
    },
    {
      name: "category",
      type: "select",
      required: true,
      label: "Kategori / Departemen (Untuk filter tab di atas)",
      options: [
        { label: "Developer", value: "developer" },
        { label: "Administrasi", value: "administrasi" },
        { label: "Marketing", value: "marketing" },
        { label: "Internship", value: "internship" },
        { label: "Freelance", value: "freelance" },
      ],
    },
    {
      name: "image",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Ilustrasi Pekerjaan",
    },
    {
      name: "shortDescription",
      type: "textarea",
      required: true,
      label: "Deskripsi Singkat",
      admin: {
        description:
          "Tampil di kartu list dan paragraf pembuka di halaman detail.",
      },
    },
    {
      name: "skill",
      type: "text",
      label: "Skill Utama (Misal: ASP.NET)",
      required: true,
    },
    {
      name: "experience",
      type: "text",
      label: "Pengalaman (Misal: 2-4 Tahun)",
      required: true,
    },
    {
      name: "location",
      type: "select",
      label: "Lokasi Kerja",
      options: ["On-Site", "Hybrid", "Remote"],
      required: true,
    },
    {
      name: "type",
      type: "select",
      label: "Tipe Pekerjaan",
      options: ["Full-Time", "Part-Time", "Contract", "Internship"],
      required: true,
    },
    {
      name: "content",
      type: "richText",
      required: true,
      label: "Detail Pekerjaan (Jobdesk & Requirements)",
      admin: {
        description:
          "Gunakan fitur Bullet List di sini untuk menuliskan poin-poin Jobdesk dan Requirement sesuai desain.",
      },
    },
  ],
};
