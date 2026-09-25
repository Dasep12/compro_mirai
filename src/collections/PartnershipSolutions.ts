import type { CollectionConfig } from "payload";

export const PartnershipSolutions: CollectionConfig = {
  slug: "partnership-solutions",
  admin: {
    useAsTitle: "name",
    defaultColumns: ["name", "createdAt"],
    description: "Daftar Mitra / Brand Teknologi Khusus Use Case Solusi Industri.",
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: "name",
      type: "text",
      required: true,
      label: "Nama Mitra / Brand Solusi (Misal: Cisco, Dell, Huawei, Hikvision, AWS)",
    },
  ],
};
