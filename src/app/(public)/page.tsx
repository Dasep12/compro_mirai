import Hero from "@/components/views/home/Hero";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import Problem from "@/components/views/home/Problem";
import ServiceShowcase from "@/components/views/home/ServiceShowcase";
import ProductShowcase from "@/components/views/home/ProductShowcase";
import PortfolioShowcase from "@/components/views/home/PortfolioShowcase";
import Contact from "@/components/views/home/Contact";
import FaqShowcase from "@/components/views/home/FaqShowcase";
import FadeInUp from "@/components/ui/FadeInUp";
import {
  getCustomers,
  getPartnerships,
  getPortfolios,
  getFaqs,
  getProblems,
  getServices,
  getProducts,
} from "@/lib/data/collections";

export default async function Home() {
  const [
    customers,
    partnerships,
    services,
    products,
    portfolios,
    faqs,
    problems,
  ] = await Promise.all([
    getCustomers(20),
    getPartnerships(20),
    getServices(10),
    getProducts(10),
    getPortfolios(10),
    getFaqs(10),
    getProblems(10),
  ]);

  return (
    <div className="overflow-hidden">
      <Hero />

      <FadeInUp delay={0.2}>
        <PartnershipCustomer
          customers={customers}
          partnerships={partnerships}
        />
      </FadeInUp>

      <FadeInUp>
        <Problem data={problems} />
      </FadeInUp>

      <FadeInUp>
        <ServiceShowcase services={services} />
      </FadeInUp>

      <FadeInUp>
        <ProductShowcase products={products} />
      </FadeInUp>

      <FadeInUp>
        <PortfolioShowcase portfolios={portfolios} />
      </FadeInUp>

      <FadeInUp>
        <Contact />
      </FadeInUp>

      <FadeInUp>
        <FaqShowcase faqs={faqs} />
      </FadeInUp>
    </div>
  );
}
