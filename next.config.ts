import withPayload from "@payloadcms/next/withPayload";
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  serverExternalPackages: ["@payloadcms/db-postgres", "drizzle-kit", "esbuild"],
};

export default withPayload(nextConfig);
