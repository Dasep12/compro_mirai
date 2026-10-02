import { unstable_cache } from "next/cache";
import { getPayloadClient } from "../payload";

export const getCustomers = unstable_cache(
  async (limit = 20) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "customers",
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch customers:", error);
      return [];
    }
  },
  ["customers"],
  { revalidate: 60, tags: ["customers"] },
);

export const getPartnerships = unstable_cache(
  async (limit = 20) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "partnerships",
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch partnerships:", error);
      return [];
    }
  },
  ["partnerships"],
  { revalidate: 60, tags: ["partnerships"] },
);

export const getPortfolios = unstable_cache(
  async (limit = 10) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "portfolios",
        depth: 1,
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch portfolios:", error);
      return [];
    }
  },
  ["portfolios"],
  { revalidate: 60, tags: ["portfolios"] },
);

export const getFaqs = unstable_cache(
  async (limit = 10) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "faqs",
        depth: 1,
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch faqs:", error);
      return [];
    }
  },
  ["faqs"],
  { revalidate: 60, tags: ["faqs"] },
);

export const getProblems = unstable_cache(
  async (limit = 10) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "problems",
        depth: 1,
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch problems:", error);
      return [];
    }
  },
  ["problems"],
  { revalidate: 60, tags: ["problems"] },
);

export const getAboutUs = unstable_cache(
  async () => {
    try {
      const payload = await getPayloadClient();
      return await payload.findGlobal({ slug: "about-us" });
    } catch (error) {
      console.warn("[Warning] Failed to fetch about-us global:", error);
      return null;
    }
  },
  ["about-us"],
  { revalidate: 60, tags: ["about-us"] },
);

export const getPricingFaqs = unstable_cache(
  async (limit = 20) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "pricing-faqs",
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch pricing-faqs:", error);
      return [];
    }
  },
  ["pricing-faqs"],
  { revalidate: 60, tags: ["pricing-faqs"] },
);

export const getProducts = unstable_cache(
  async (limit = 10) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "products",
        depth: 1,
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch products:", error);
      return [];
    }
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
    console.warn(`[Warning] Failed to fetch product by slug (${slug}):`, error);
    return null;
  }
}

export const getServices = unstable_cache(
  async (limit = 10) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "services",
        depth: 1,
        limit,
        sort: "createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch services:", error);
      return [];
    }
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
    console.warn(`[Warning] Failed to fetch service by slug (${slug}):`, error);
    return null;
  }
}

export const getCareers = unstable_cache(
  async (limit = 20) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "careers",
        depth: 1,
        limit,
        sort: "-createdAt",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch careers:", error);
      return [];
    }
  },
  ["careers"],
  { revalidate: 60, tags: ["careers"] },
);

export async function getCareerBySlug(slug: string) {
  if (!slug) return null;

  try {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "careers",
      depth: 1,
      where: { slug: { equals: slug } },
      limit: 1,
    });
    return result.docs[0] ?? null;
  } catch (error) {
    console.warn(`[Warning] Failed to fetch career by slug (${slug}):`, error);
    return null;
  }
}

export const getNews = unstable_cache(
  async (limit = 20) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "news",
        depth: 1,
        limit,
        sort: "-date",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch news:", error);
      return [];
    }
  },
  ["news"],
  { revalidate: 60, tags: ["news"] },
);

export async function getNewsBySlug(slug: string) {
  if (!slug) return null;

  try {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "news",
      depth: 1,
      where: { slug: { equals: slug } },
      limit: 1,
    });
    return result.docs[0] ?? null;
  } catch (error) {
    console.warn(`[Warning] Failed to fetch news by slug (${slug}):`, error);
    return null;
  }
}

export const getSolutions = unstable_cache(
  async (limit = 100) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "solutions",
        depth: 2,
        limit,
        sort: "-publishedDate",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch solutions (table might not exist yet):", error);
      return [];
    }
  },
  ["solutions"],
  { revalidate: 60, tags: ["solutions"] },
);

export async function getSolutionBySlug(slug: string) {
  if (!slug) return null;

  try {
    const payload = await getPayloadClient();
    const result = await payload.find({
      collection: "solutions",
      depth: 2,
      where: { slug: { equals: slug } },
      limit: 1,
    });
    return result?.docs?.[0] ?? null;
  } catch (error) {
    console.warn(`[Warning] Failed to fetch solution by slug (${slug}):`, error);
    return null;
  }
}

export const getIndustries = unstable_cache(
  async (limit = 100) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "industries",
        depth: 1,
        limit,
        sort: "order",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch industries (table might not exist yet):", error);
      return [];
    }
  },
  ["industries"],
  { revalidate: 60, tags: ["industries"] },
);

export const getSolutionCategories = unstable_cache(
  async (limit = 100) => {
    try {
      const payload = await getPayloadClient();
      const result = await payload.find({
        collection: "solution-categories",
        depth: 1,
        limit,
        sort: "name",
      });
      return result.docs;
    } catch (error) {
      console.warn("[Warning] Failed to fetch solution-categories (table might not exist yet):", error);
      return [];
    }
  },
  ["solution-categories"],
  { revalidate: 60, tags: ["solution-categories"] },
);
