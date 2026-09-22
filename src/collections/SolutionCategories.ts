import { generateSlug } from "@/lib/utils";
import type { CollectionConfig } from "payload";

export const SolutionCategories: CollectionConfig = {
  slug: "solution-categories",
  admin: {
    useAsTitle: "name",
    defaultColumns: ["name", "slug", "badgeColor"],
    description: "Daftar Kategori / Bidang Solusi (Badge pada Use Case).",
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
      label: "Nama Kategori (Misal: Surveillance & Security System, Data & Analytics)",
    },
    {
      name: "slug",
      type: "text",
      unique: true,
      label: "URL Slug",
      admin: {
        position: "sidebar",
        readOnly: true,
        description: "Dibuat otomatis dari nama kategori.",
      },
    },
    {
      name: "badgeColor",
      type: "select",
      label: "Warna Badge",
      defaultValue: "teal",
      options: [
        { label: "Teal (Default)", value: "teal" },
        { label: "Blue", value: "blue" },
        { label: "Orange", value: "orange" },
        { label: "Purple", value: "purple" },
        { label: "Green", value: "green" },
      ],
    },
    {
      name: "description",
      type: "textarea",
      label: "Deskripsi Kategori (Opsional)",
    },
  ],
};
