import type { MetadataRoute } from "next";
import { getServices, getProducts } from "@/lib/data/collections";
import { Product, Service } from "../../payload-types";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://miraisoftnet.com";

  const [services, products] = await Promise.all([
    getServices(100).catch(() => []),
    getProducts(100).catch(() => []),
  ]);

  const serviceUrls = services.map((service: Service) => ({
    url: `${baseUrl}/services/${service.slug}`,
    lastModified: new Date(service.updatedAt || new Date()),
    changeFrequency: "weekly" as const,
    priority: 0.8,
  }));

  const productUrls = products.map((product: Product) => ({
    url: `${baseUrl}/products/${product.productUrl}`,
    lastModified: new Date(product.updatedAt || new Date()),
    changeFrequency: "weekly" as const,
    priority: 0.8,
  }));

  return [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: "daily",
      priority: 1.0,
    },
    {
      url: `${baseUrl}/about-us`,
      lastModified: new Date(),
      changeFrequency: "monthly",
      priority: 0.5,
    },
    {
      url: `${baseUrl}/careers`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.7,
    },
    {
      url: `${baseUrl}/pricing`,
      lastModified: new Date(),
      changeFrequency: "monthly",
      priority: 0.6,
    },
    {
      url: `${baseUrl}/services`,
      lastModified: new Date(),
      changeFrequency: "daily",
      priority: 0.9,
    },
    ...serviceUrls,
    ...productUrls,
  ];
}
