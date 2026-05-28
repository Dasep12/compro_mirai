import type { Metadata } from "next";
import PricingHero from "@/components/views/pricing/PricingHero";
import PricingPerks from "@/components/views/pricing/PricingPerks";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import PricingFaq from "@/components/views/pricing/PricingFaq";
import FadeInUp from "@/components/ui/FadeInUp";
import {
  getCustomers,
  getPartnerships,
  getPricingFaqs,
  getServices,
} from "@/lib/data/collections";

export const metadata: Metadata = {
  title: "Harga",
  description:
    "Temukan paket harga layanan IT Mirai Softnet yang fleksibel dan transparan, sesuai kebutuhan bisnis Anda.",
};

export default async function PricingPage() {
  const [services, customers, partnerships, faqs] = await Promise.all([
    getServices(10),
    getCustomers(20),
    getPartnerships(20),
    getPricingFaqs(20),
  ]);

  return (
    <div className="overflow-hidden">
      <PricingHero />

      <FadeInUp delay={0.2}>
        <PricingPerks services={services} />
      </FadeInUp>

      <FadeInUp>
        <PartnershipCustomer
          customers={customers}
          partnerships={partnerships}
        />
      </FadeInUp>

      <FadeInUp>
        <PricingFaq faqs={faqs} />
      </FadeInUp>
    </div>
  );
}
