import type { CollectionConfig } from "payload";

export const Partnership: CollectionConfig = {
  slug: "partnerships",
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
      label: "Nama Partner",
    },
    {
      name: "logo",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Logo Partner (Direkomendasikan format PNG/SVG)",
    },
  ],
};
