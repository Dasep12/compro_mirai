import withPayload from "@payloadcms/next/withPayload";
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",
  images: {
    formats: ['image/avif', 'image/webp'],
    qualities: [45, 65, 82, 85, 100],
    minimumCacheTTL: 31536000, // Simpan cache gambar selama 1 tahun di server
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**.supabase.co',
      },
    ],
  },
  serverExternalPackages: ["@payloadcms/db-postgres", "drizzle-kit", "esbuild"],
};

export default withPayload(nextConfig);
