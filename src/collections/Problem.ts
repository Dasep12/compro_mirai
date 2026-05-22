import type { CollectionConfig } from "payload";

export const Problems: CollectionConfig = {
  slug: "problems",
  labels: {
    singular: "Problem / Keunggulan",
    plural: "Problems",
  },
  admin: {
    useAsTitle: "title",
    group: "Global Settings",
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: "title",
      type: "text",
      required: true,
      label: "Judul",
    },
    {
      name: "description",
      type: "textarea",
      required: true,
      label: "Deskripsi",
    },
    {
      name: "icon",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Ikon (Direkomendasikan format SVG)",
    },
  ],
};
