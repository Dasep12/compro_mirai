import type { CollectionConfig } from "payload";

export const Faqs: CollectionConfig = {
  slug: "faqs",
  admin: {
    useAsTitle: "categoryName",
    group: "Global Settings",
    description: "Kelola daftar FAQ berdasarkan kategori Tab.",
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: "categoryName",
      type: "text",
      required: true,
      label: "Nama Kategori (Misal: General, Produk, Layanan & Jasa)",
    },
    {
      name: "icon",
      type: "upload",
      relationTo: "media",
      label: "Ikon Kategori (SVG/PNG untuk Tab kiri)",
    },
    {
      name: "qnaList",
      type: "array",
      label: "Daftar Pertanyaan & Jawaban",
      minRows: 1,
      fields: [
        {
          name: "question",
          type: "text",
          required: true,
          label: "Pertanyaan",
        },
        {
          name: "answer",
          type: "textarea",
          required: true,
          label: "Jawaban",
        },
      ],
    },
  ],
};
