import type { CollectionConfig } from "payload";

export const Portfolios: CollectionConfig = {
  slug: "portfolios",
  admin: {
    useAsTitle: "clientName",
    description: "Daftar rekam jejak / portofolio proyek klien.",
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: "clientName",
      type: "text",
      required: true,
      label: "Nama Klien / Judul Portofolio (Misal: Toyota Boshoku Indonesia)",
    },
    {
      name: "customer",
      type: "relationship",
      relationTo: "customers",
      label: "Relasi Data Customer (Opsional)",
      admin: {
        description: "Pilih data customer dari tabel Customers jika ada.",
      },
    },
    {
      name: "relatedServices",
      type: "relationship",
      relationTo: "services",
      hasMany: true,
      label: "Layanan Terkait (Opsional)",
    },
    {
      name: "description",
      type: "textarea",
      required: true,
      label: "Deskripsi Proyek",
    },
    {
      name: "achievements",
      type: "array",
      label: "Daftar Pencapaian / Implementasi (Bentuk Angka 1, 2, 3...)",
      fields: [
        {
          name: "text",
          type: "text",
          required: true,
          label: "Teks Implementasi",
        },
      ],
    },
    {
      name: "tags",
      type: "array",
      label: "Tag Kategori (Misal: Hardware, Software)",
      fields: [
        {
          name: "label",
          type: "text",
          required: true,
          label: "Label Tag (Misal: Software)",
        },
        {
          name: "theme",
          type: "select",
          defaultValue: "software",
          options: [
            { label: "Software (Biru)", value: "software" },
            { label: "Hardware (Orange)", value: "hardware" },
          ],
          label: "Tema Warna Tag",
        },
      ],
    },
    {
      name: "image",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Gambar Dokumentasi / Mockup",
    },
  ],
};
