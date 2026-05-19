import type { CollectionConfig } from "payload";

export const Visitors: CollectionConfig = {
  slug: "visitors",
  admin: {
    useAsTitle: "name",
    description: "Data leads/pengunjung yang mengisi form kontak web.",
    defaultColumns: ["name", "email", "phone", "createdAt"],
  },
  access: {
    read: () => true,
    create: () => true,
    update: () => false,
    delete: () => false,
  },
  fields: [
    {
      name: "name",
      type: "text",
      required: true,
      label: "Nama Lengkap",
    },
    {
      name: "email",
      type: "text",
      required: true,
      label: "Email Perusahaan",
    },
    {
      name: "phone",
      type: "text",
      required: true,
      label: "Nomor Telepon",
    },
    {
      name: "message",
      type: "textarea",
      required: true,
      label: "Pesan",
    },
  ],
};
