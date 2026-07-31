import type { MetadataRoute } from "next";
import { getServices, getProducts, getNews, getCareers } from "@/lib/data/collections";
import { Product, Service, News, Career } from "../../payload-types";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://miraisoftnet.com";

  const [services, products, news, careers] = await Promise.all([
    getServices(100).catch(() => []),
    getProducts(100).catch(() => []),
    getNews(100).catch(() => []),
    getCareers(100).catch(() => []),
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

  const newsUrls = news.map((newsItem: News) => ({
    url: `${baseUrl}/news/${newsItem.slug}`,
    lastModified: new Date(newsItem.updatedAt || newsItem.date || new Date()),
    changeFrequency: "weekly" as const,
    priority: 0.7,
  }));

  const careerUrls = careers.map((career: Career) => ({
    url: `${baseUrl}/careers/${career.slug}`,
    lastModified: new Date(career.updatedAt || new Date()),
    changeFrequency: "weekly" as const,
    priority: 0.6,
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
      url: `${baseUrl}/services`,
      lastModified: new Date(),
      changeFrequency: "daily",
      priority: 0.9,
    },
    {
      url: `${baseUrl}/news`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.8,
    },
    ...serviceUrls,
    ...productUrls,
    ...newsUrls,
    ...careerUrls,
  ];
}
