import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const News: CollectionConfig = {
  slug: "news",
  admin: {
    useAsTitle: "title",
    defaultColumns: ["title", "category", "date"],
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
      label: "Judul Berita",
    },
    {
      name: "slug",
      type: "text",
      required: true,
      unique: true,
      label: "URL Slug (Contoh: judul-berita)",
    },
    {
      name: "category",
      type: "select",
      required: true,
      label: "Kategori (Untuk filter tab)",
      options: [
        { label: "Berita", value: "berita" },
        { label: "Pengumuman", value: "pengumuman" },
        { label: "Acara", value: "acara" },
        { label: "Penghargaan", value: "penghargaan" },
        { label: "Teknologi", value: "teknologi" },
      ],
    },
    {
      name: "date",
      type: "date",
      required: true,
      label: "Tanggal Publikasi",
      admin: {
        date: {
          pickerAppearance: "dayOnly",
          displayFormat: "d MMM yyyy",
        },
      },
    },
    {
      name: "image",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Gambar / Cover Berita",
    },
    {
      name: "shortDescription",
      type: "textarea",
      required: true,
      label: "Deskripsi Singkat (Muncul di daftar berita)",
    },
    {
      name: "content",
      type: "richText",
      required: true,
      label: "Isi Berita",
    },
  ],
};