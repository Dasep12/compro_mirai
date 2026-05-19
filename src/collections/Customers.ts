import type { CollectionConfig } from "payload";

export const Customers: CollectionConfig = {
  slug: "customers",
  admin: {
    useAsTitle: "name",
    group: "Global Settings",
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: "name",
      type: "text",
      required: true,
      label: "Nama Perusahaan / Klien",
    },
    {
      name: "logo",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Logo Klien (Direkomendasikan format PNG transparan)",
    },
  ],
};
