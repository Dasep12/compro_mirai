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
        hostname: 'miraisoftnet.com',
      },
      {
        protocol: 'http',
        hostname: 'localhost',
      },
      {
        protocol: 'http',
        hostname: '127.0.0.1',
      },
    ],
  },
  async rewrites() {
    const remoteUrl = process.env.NEXT_PUBLIC_REMOTE_MEDIA_URL || "https://miraisoftnet.com";
    return {
      beforeFiles: [],
      afterFiles: [],
      fallback: [
        {
          source: "/api/media/file/:path*",
          destination: `${remoteUrl}/api/media/file/:path*`,
        },
      ],
    };
  },
  serverExternalPackages: ["@payloadcms/db-postgres", "drizzle-kit", "esbuild"],
};

export default withPayload(nextConfig);
