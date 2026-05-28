import type { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: "*",
      allow: ["/", "/api/media/"],
      disallow: ["/admin", "/admin/"],
    },
    sitemap: "https://miraisoftnet.com/sitemap.xml",
  };
}
