import type { GlobalConfig } from "payload";

export const AboutUs: GlobalConfig = {
  slug: "about-us",
  label: "About Us (Tentang Kami)",
  admin: {
    group: "Website Content",
    description: "Pengaturan konten halaman Tentang Kami (Company Profile).",
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      type: "tabs",
      tabs: [
        {
          label: "Pengenalan (Hero)",
          fields: [
            {
              name: "heroHeadline",
              type: "text",
              required: true,
              label: "Headline Utama",
              defaultValue: "Mendorong Transformasi Digital Indonesia",
            },
            {
              name: "heroDescription",
              type: "textarea",
              required: true,
              label: "Deskripsi Perusahaan (Overview)",
            },
            {
              name: "heroImage",
              type: "upload",
              relationTo: "media",
              label: "Gambar / Ilustrasi Hero",
            },
          ],
        },

        {
          label: "Visi & Misi",
          fields: [
            {
              name: "visionText",
              type: "textarea",
              required: true,
              label: "Visi Perusahaan",
            },
            {
              name: "missionList",
              type: "array",
              required: true,
              label: "Daftar Misi",
              fields: [
                {
                  name: "missionText",
                  type: "textarea",
                  required: true,
                  label: "Teks Misi",
                },
              ],
            },
          ],
        },
        {
          label: "Nilai Inti (Core Values)",
          fields: [
            {
              name: "coreValues",
              type: "array",
              required: true,
              label: "Daftar Nilai Inti",
              fields: [
                {
                  name: "icon",
                  type: "upload",
                  relationTo: "media",
                  label: "Ikon (SVG/PNG)",
                },
                {
                  name: "title",
                  type: "text",
                  required: true,
                  label: "Judul Nilai (Contoh: Inovasi)",
                },
                {
                  name: "description",
                  type: "textarea",
                  required: true,
                  label: "Deskripsi Nilai",
                },
              ],
            },
          ],
        },

        {
          label: "Sejarah (Milestones)",
          fields: [
            {
              name: "milestoneHeadline",
              type: "text",
              label: "Headline Sejarah/Perjalanan",
              defaultValue: "Jejak Langkah Kami",
            },
            {
              name: "milestones",
              type: "array",
              label: "Daftar Pencapaian",
              fields: [
                {
                  name: "year",
                  type: "text",
                  required: true,
                  label: "Tahun / Tanggal (Contoh: 2021)",
                },
                {
                  name: "title",
                  type: "text",
                  required: true,
                  label: "Judul Pencapaian",
                },
                {
                  name: "description",
                  type: "textarea",
                  label: "Deskripsi Singkat",
                },
              ],
            },
          ],
        },

        {
          label: "Keunggulan (Strength)",
          fields: [
            {
              name: "strengths",
              type: "array",
              required: true,
              label: "Daftar Keunggulan Perusahaan",
              fields: [
                {
                  name: "title",
                  type: "text",
                  required: true,
                  label: "Keunggulan",
                },
                {
                  name: "description",
                  type: "textarea",
                  label: "Deskripsi Penjelasan",
                },
              ],
            },
          ],
        },

        {
          label: "Industri (Industries)",
          fields: [
            {
              name: "industries",
              type: "array",
              required: true,
              label: "Daftar Industri Klien",
              fields: [
                {
                  name: "icon",
                  type: "upload",
                  relationTo: "media",
                  label: "Ikon Industri",
                },
                {
                  name: "name",
                  type: "text",
                  required: true,
                  label: "Nama Industri",
                },
              ],
            },
          ],
        },

        {
          label: "Tim Kami",
          fields: [
            {
              name: "teamHeadline",
              type: "text",
              required: true,
              label: "Headline Tim",
              defaultValue: "Kenali Orang-orang di Balik Mirai Softnet",
            },
            {
              name: "teamDescription",
              type: "textarea",
              label: "Deskripsi Singkat Tentang Tim",
            },
            {
              name: "teamMembers",
              type: "array",
              label: "Daftar Anggota Tim",
              fields: [
                {
                  name: "photo",
                  type: "upload",
                  relationTo: "media",
                  label: "Foto Profil",
                },
                {
                  name: "name",
                  type: "text",
                  required: true,
                  label: "Nama Lengkap",
                },
                {
                  name: "position",
                  type: "text",
                  required: true,
                  label: "Posisi / Jabatan",
                },
                {
                  name: "linkedin",
                  type: "text",
                  label: "Link URL LinkedIn (Opsional)",
                },
              ],
            },
          ],
        },

        {
          label: "Call To Action (CTA)",
          fields: [
            {
              name: "ctaHeadline",
              type: "text",
              required: true,
              label: "Headline CTA",
              defaultValue: "Siap Memulai Transformasi Digital Anda?",
            },
            {
              name: "ctaDescription",
              type: "textarea",
              label: "Deskripsi Singkat CTA",
            },
            {
              name: "ctaButtonText",
              type: "text",
              required: true,
              label: "Teks Tombol CTA",
              defaultValue: "Hubungi Kami",
            },
            {
              name: "ctaButtonLink",
              type: "text",
              required: true,
              label: "Link / URL Tujuan Tombol",
              defaultValue: "/contact",
            },
          ],
        },
      ],
    },
  ],
};
