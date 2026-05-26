import Hero from "@/components/views/home/Hero";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import { getPayload } from "payload";
import config from "../../../payload.config";
import Problem from "@/components/views/home/Problem";
import ServiceShowcase from "@/components/views/home/ServiceShowcase";
import ProductShowcase from "@/components/views/home/ProductShowcase";
import PortfolioShowcase from "@/components/views/home/PortfolioShowcase";
import Contact from "@/components/views/home/Contact";
import FaqShowcase from "@/components/views/home/FaqShowcase";
import FadeInUp from "@/components/ui/FadeInUp";

export default async function Home() {
  const payload = await getPayload({ config });

  const customers = await payload.find({
    collection: "customers",
    limit: 20,
    sort: "createdAt",
  });

  const partnerships = await payload.find({
    collection: "partnerships",
    limit: 20,
    sort: "createdAt",
  });

  const services = await payload.find({
    collection: "services",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

  const products = await payload.find({
    collection: "products",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

  const portfolios = await payload.find({
    collection: "portfolios",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

  const faqs = await payload.find({
    collection: "faqs",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

  const problems = await payload.find({
    collection: "problems",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

  return (
    <div className="overflow-hidden">
      <Hero />

      <FadeInUp delay={0.2}>
        <PartnershipCustomer
          customers={customers.docs}
          partnerships={partnerships.docs}
        />
      </FadeInUp>

      <FadeInUp>
        <Problem data={problems.docs} />
      </FadeInUp>

      <FadeInUp>
        <ServiceShowcase services={services.docs} />
      </FadeInUp>

      <FadeInUp>
        <ProductShowcase products={products.docs} />
      </FadeInUp>

      <FadeInUp>
        <PortfolioShowcase portfolios={portfolios.docs} />
      </FadeInUp>

      <FadeInUp>
        <Contact />
      </FadeInUp>

      <FadeInUp>
        <FaqShowcase faqs={faqs.docs} />
      </FadeInUp>
    </div>
  );
}
