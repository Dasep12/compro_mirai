import withPayload from "@payloadcms/next/withPayload";
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",
  images: {
    formats: ['image/avif', 'image/webp'],
    // 82 = default quality di Image.tsx, 85 = dipakai di hero/detail besar.
    // 100 tetap diizinkan untuk kasus khusus, tapi tidak dipakai secara default lagi.
    qualities: [45, 65, 82, 85, 100],
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
