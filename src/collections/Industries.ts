import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const Industries: CollectionConfig = {
  slug: "industries",
  admin: {
    useAsTitle: "name",
    defaultColumns: ["name", "slug", "updatedAt"],
    description: "Daftar Sektor Industri untuk Filter Use Case Solusi.",
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
      label: "Nama Industri (Misal: Hospitality & Tourism, Healthcare)",
    },
    {
      name: "slug",
      type: "text",
      unique: true,
      label: "URL Slug",
      admin: {
        position: "sidebar",
        readOnly: true,
        description: "Dibuat otomatis dari nama industri.",
      },
    },
    {
      name: "description",
      type: "textarea",
      label: "Deskripsi Industri (Opsional)",
    },
    {
      name: "order",
      type: "number",
      label: "Urutan Tampilan",
      defaultValue: 0,
      admin: {
        description: "Urutan prioritas saat ditampilkan di filter (angka kecil muncul lebih awal).",
      },
    },
  ],
};
