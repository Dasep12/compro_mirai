import type { CollectionConfig } from "payload";

const generateSlug = (text: string) =>
  text
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9\s-]/g, "")
    .replace(/\s+/g, "-");

export const Services: CollectionConfig = {
  slug: "services",
  admin: {
    useAsTitle: "title",
  },
  hooks: {
    beforeValidate: [
      ({ data }) => {
        if (data?.title && !data?.slug) {
          data.slug = generateSlug(data.title);
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
      name: "title",
      type: "text",
      required: true,
      label: "Nama Layanan / Produk (H1)",
    },
    {
      name: "slug",
      type: "text",
      required: true,
      unique: true,
      label: "URL Slug",
    },
    {
      name: "subtitle",
      type: "textarea",
      required: true,
      label: "Sub-judul / Deskripsi Singkat",
      admin: {
        description:
          "Teks ini akan muncul di tooltip navigasi AppBar dan Card daftar layanan.",
      },
    },
    {
      name: "iconTitle",
      type: "upload",
      relationTo: "media",
      required: true,
      label: "Ikon Menu Navigasi",
      admin: {
        description: "Gunakan gambar berformat SVG atau PNG dengan rasio 1:1.",
      },
    },
    {
      name: "dashboardBadge",
      type: "text",
      label: "Badge Dashboard",
    },
    {
      name: "dashboardTitle",
      type: "text",
      label: "Judul Dashboard",
    },
    {
      name: "dashboardSubtitle",
      type: "textarea",
      label: "Sub-judul / Deskripsi Dashboard",
    },
    {
      type: "tabs",
      tabs: [
        {
          label: "Hero",
          fields: [
            {
              name: "heroBadge",
              type: "text",
              label: "Badge / Kicker Atas",
            },
            {
              name: "heroDescription",
              type: "textarea",
              label: "Deskripsi Hero",
            },
            {
              name: "heroImage",
              type: "upload",
              relationTo: "media",
              label: "Gambar Hero Utama",
            },
            {
              type: "row",
              fields: [
                {
                  name: "heroBtn1Text",
                  type: "text",
                  label: "Teks Tombol 1 (Primary)",
                },
                { name: "heroBtn1Link", type: "text", label: "Link Tombol 1" },
              ],
            },
            {
              type: "row",
              fields: [
                {
                  name: "heroBtn2Text",
                  type: "text",
                  label: "Teks Tombol 2 (Secondary)",
                },
                { name: "heroBtn2Link", type: "text", label: "Link Tombol 2" },
              ],
            },
          ],
        },

        {
          label: "Problem",
          fields: [
            {
              name: "showProblem",
              type: "checkbox",
              label: "Aktifkan Section Problem?",
              defaultValue: true,
            },
            {
              name: "problem",
              type: "group",
              admin: { condition: (_, siblingData) => siblingData.showProblem },
              fields: [
                { name: "badge", type: "text", label: "Badge Section" },
                { name: "title", type: "text", label: "Judul Section" },
                { name: "subtitle", type: "textarea", label: "Sub-judul" },
                {
                  name: "cards",
                  type: "array",
                  label: "Daftar Masalah",
                  fields: [
                    {
                      name: "icon",
                      type: "upload",
                      relationTo: "media",
                      label: "Ikon Masalah",
                    },
                    { name: "title", type: "text", label: "Judul" },
                    {
                      name: "description",
                      type: "textarea",
                      label: "Deskripsi",
                    },
                  ],
                },
              ],
            },
          ],
        },

        {
          label: "Solution",
          fields: [
            {
              name: "showSolution",
              type: "checkbox",
              label: "Aktifkan Section Solution?",
              defaultValue: true,
            },
            {
              name: "solution",
              type: "group",
              admin: {
                condition: (_, siblingData) => siblingData.showSolution,
              },
              fields: [
                { name: "badge", type: "text", label: "Badge Section" },
                { name: "title", type: "text", label: "Judul Section" },
                {
                  name: "list",
                  type: "array",
                  label: "Daftar Solusi (Layout Zig-zag)",
                  fields: [
                    { name: "badge", type: "text", label: "Kicker Solusi" },
                    { name: "title", type: "text", label: "Judul" },
                    {
                      name: "description",
                      type: "textarea",
                      label: "Deskripsi",
                    },
                    {
                      name: "image",
                      type: "upload",
                      relationTo: "media",
                      label: "Gambar Pendukung",
                    },
                  ],
                },
              ],
            },
          ],
        },

        {
          label: "Process",
          fields: [
            {
              name: "showProcess",
              type: "checkbox",
              label: "Aktifkan Section Process?",
              defaultValue: true,
            },
            {
              name: "process",
              type: "group",
              admin: { condition: (_, siblingData) => siblingData.showProcess },
              fields: [
                { name: "badge", type: "text", label: "Badge Section" },
                { name: "title", type: "text", label: "Judul Section" },
                { name: "subtitle", type: "textarea", label: "Sub-judul" },
                {
                  name: "steps",
                  type: "array",
                  label: "Langkah-langkah",
                  fields: [
                    {
                      name: "icon",
                      type: "upload",
                      relationTo: "media",
                      label: "Ikon Langkah",
                    },
                    { name: "title", type: "text", label: "Judul Langkah" },
                    {
                      name: "description",
                      type: "textarea",
                      label: "Deskripsi",
                    },
                  ],
                },
              ],
            },
          ],
        },

        {
          label: "Framework",
          fields: [
            {
              name: "showFramework",
              type: "checkbox",
              label: "Aktifkan Section Framework?",
              defaultValue: true,
            },
            {
              name: "framework",
              type: "group",
              admin: {
                condition: (_, siblingData) => siblingData.showFramework,
              },
              fields: [
                { name: "title", type: "text", label: "Judul Section" },
                { name: "subtitle", type: "textarea", label: "Sub-judul" },
                {
                  name: "logos",
                  type: "array",
                  label: "Logo Teknologi",
                  fields: [
                    {
                      name: "logo",
                      type: "upload",
                      relationTo: "media",
                      label: "Upload Logo",
                    },
                  ],
                },
              ],
            },
          ],
        },

        {
          label: "Benefit",
          fields: [
            {
              name: "showBenefit",
              type: "checkbox",
              label: "Aktifkan Section Benefit?",
              defaultValue: true,
            },
            {
              name: "benefit",
              type: "group",
              admin: { condition: (_, siblingData) => siblingData.showBenefit },
              fields: [
                { name: "badge", type: "text", label: "Badge Section" },
                { name: "title", type: "text", label: "Judul Section" },
                { name: "subtitle", type: "textarea", label: "Sub-judul" },
                {
                  name: "cards",
                  type: "array",
                  label: "Daftar Benefit",
                  fields: [
                    {
                      name: "icon",
                      type: "upload",
                      relationTo: "media",
                      label: "Ikon Benefit",
                    },
                    { name: "title", type: "text", label: "Judul Benefit" },
                    {
                      name: "description",
                      type: "textarea",
                      label: "Deskripsi Benefit",
                    },
                  ],
                },
              ],
            },
          ],
        },

        {
          label: "Pricing",
          fields: [
            {
              name: "showPricing",
              type: "checkbox",
              label: "Aktifkan Paket Harga untuk Layanan ini?",
              defaultValue: true,
            },
            {
              name: "pricing",
              type: "group",
              admin: { condition: (_, siblingData) => siblingData.showPricing },
              fields: [
                {
                  name: "pricingHeadline",
                  type: "text",
                  label: "Headline Pricing (Misal: Kenapa Managed Services?)",
                },
                {
                  name: "pricingDescription",
                  type: "textarea",
                  label: "Deskripsi Pendek di bawah Headline",
                },
                {
                  name: "tiers",
                  type: "array",
                  label: "Daftar Paket / Tiering",
                  minRows: 1,
                  maxRows: 3,
                  fields: [
                    {
                      name: "isPopular",
                      type: "checkbox",
                      label:
                        "Tandai sebagai Paket Utama? (Akan memberikan border biru di UI)",
                      defaultValue: false,
                    },
                    {
                      name: "tierName",
                      type: "text",
                      label: "Nama Paket (Misal: Essential, Professional)",
                    },
                    {
                      name: "price",
                      type: "text",
                      label: "Harga (Misal: Rp 15 jt atau Hubungi Kami)",
                    },
                    {
                      name: "priceSuffix",
                      type: "text",
                      label:
                        "Akhiran (Misal: /bulan) - Kosongkan jika tidak ada",
                    },
                    {
                      name: "description",
                      type: "textarea",
                      label: "Deskripsi Paket",
                    },
                    {
                      name: "features",
                      type: "array",
                      label: "Daftar Fitur (Checklist)",
                      fields: [
                        {
                          name: "featureItem",
                          type: "text",
                          label: "Nama Fitur",
                        },
                      ],
                    },
                    {
                      name: "buttonText",
                      type: "text",
                      label: "Teks Tombol (Misal: Konsultasi Sekarang)",
                    },
                    { name: "buttonLink", type: "text", label: "Link Tombol" },
                  ],
                },
              ],
            },
          ],
        },
      ],
    },
  ],
};
