import type { CollectionConfig } from "payload";

export const PricingFaq: CollectionConfig = {
  slug: "pricing-faqs",
  admin: {
    useAsTitle: "question",
  },
  access: {
    read: () => true,
  },
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
};
