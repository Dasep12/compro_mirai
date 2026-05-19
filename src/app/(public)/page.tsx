import Hero from "@/components/views/home/Hero";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import { getPayload } from "payload";
import config from "../../../payload.config";
import Problem from "@/components/views/home/Problem";
import ServiceShowcase from "@/components/views/home/ServiceShowcase";
import ProductShowcase from "@/components/views/home/ProductShowcase";
import PortfolioShowcase from "@/components/views/home/PortfolioShowcase";
import Contact from "@/components/views/home/Contact";

export default async function Home() {
  const payload = await getPayload({ config });

  const customers = await payload.find({
    collection: "customers",
    limit: 20,
  });

  const partnerships = await payload.find({
    collection: "partnerships",
    limit: 20,
  });

  const services = await payload.find({
    collection: "services",
    depth: 1,
    limit: 10,
  });

  const products = await payload.find({
    collection: "products",
    depth: 1,
    limit: 10,
  });

  const portfolios = await payload.find({
    collection: "portfolios",
    depth: 1,
    limit: 10,
  });

  return (
    <>
      <Hero />

      <PartnershipCustomer
        customers={customers.docs}
        partnerships={partnerships.docs}
      />

      <Problem />

      <ServiceShowcase services={services.docs} />

      <ProductShowcase products={products.docs} />

      <PortfolioShowcase portfolios={portfolios.docs} />

      <Contact />
    </>
  );
}
