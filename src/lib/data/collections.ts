import { unstable_cache } from "next/cache";
import { getPayloadClient } from "../payload";

export const getCustomers = unstable_cache(
  async (limit = 20) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "customers",
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["customers"],
  { revalidate: 60, tags: ["customers"] },
);

export const getPartnerships = unstable_cache(
  async (limit = 20) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "partnerships",
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["partnerships"],
  { revalidate: 60, tags: ["partnerships"] },
);

export const getPortfolios = unstable_cache(
  async (limit = 10) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "portfolios",
      depth: 1,
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["portfolios"],
  { revalidate: 60, tags: ["portfolios"] },
);

export const getFaqs = unstable_cache(
  async (limit = 10) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "faqs",
      depth: 1,
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["faqs"],
  { revalidate: 60, tags: ["faqs"] },
);

export const getProblems = unstable_cache(
  async (limit = 10) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "problems",
      depth: 1,
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["problems"],
  { revalidate: 60, tags: ["problems"] },
);

export const getAboutUs = unstable_cache(
  async () => {
    const payload = await getPayloadClient();
    return payload.findGlobal({ slug: "about-us" });
  },
  ["about-us"],
  { revalidate: 60, tags: ["about-us"] },
);

export const getPricingFaqs = unstable_cache(
  async (limit = 20) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "pricing-faqs",
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["pricing-faqs"],
  { revalidate: 60, tags: ["pricing-faqs"] },
);

export const getProducts = unstable_cache(
  async (limit = 10) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "products",
      depth: 1,
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["products"],
  { revalidate: 60, tags: ["products"] },
);

export async function getProductBySlug(slug: string) {
  if (!slug) return null;

  try {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "products",
      depth: 2,
      where: { slug: { equals: slug } },
      limit: 1,
    });

    return result?.docs?.[0] ?? null;
  } catch (error) {
    console.error(`[Error] Failed to fetch product by slug (${slug}):`, error);
    return null;
  }
}

export const getServices = unstable_cache(
  async (limit = 10) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "services",
      depth: 1,
      limit,
      sort: "createdAt",
    });
    return result.docs;
  },
  ["services"],
  { revalidate: 60, tags: ["services"] },
);

export async function getServiceBySlug(slug: string) {
  if (!slug) return null;

  try {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "services",
      depth: 2,
      where: { slug: { equals: slug } },
      limit: 1,
    });

    return result?.docs?.[0] ?? null;
  } catch (error) {
    console.error(`[Error] Failed to fetch service by slug (${slug}):`, error);
    return null;
  }
}

export const getCareers = unstable_cache(
  async (limit = 20) => {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "careers",
      depth: 1,
      limit,
      sort: "-createdAt",
    });
    return result.docs;
  },
  ["careers"],
  { revalidate: 60, tags: ["careers"] },
);

export async function getCareerBySlug(slug: string) {
  const payload = await getPayloadClient();

  const result = await payload.find({
    collection: "careers",
    depth: 1,
    where: { slug: { equals: slug } },
    limit: 1,
  });
  return result.docs[0] ?? null;
}
