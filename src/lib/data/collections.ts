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
  { revalidate: 3600, tags: ["customers"] },
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
  { revalidate: 3600, tags: ["partnerships"] },
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
  { revalidate: 3600, tags: ["portfolios"] },
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
  { revalidate: 3600, tags: ["faqs"] },
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
  { revalidate: 3600, tags: ["problems"] },
);

export const getAboutUs = unstable_cache(
  async () => {
    const payload = await getPayloadClient();
    return payload.findGlobal({ slug: "about-us" });
  },
  ["about-us"],
  { revalidate: 3600, tags: ["about-us"] },
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
  { revalidate: 3600, tags: ["pricing-faqs"] },
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
  { revalidate: 3600, tags: ["products"] },
);

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
  { revalidate: 3600, tags: ["services"] },
);

export async function getServiceBySlug(slug: string) {
  const payload = await getPayloadClient();

  const result = await payload.find({
    collection: "services",
    depth: 2,
    where: { slug: { equals: slug } },
    limit: 1,
  });
  return result.docs[0] ?? null;
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
  { revalidate: 3600, tags: ["careers"] },
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
