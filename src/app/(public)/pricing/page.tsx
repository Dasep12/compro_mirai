import { getPayload } from "payload";
import config from "../../../../payload.config";
import PricingHero from "@/components/views/pricing/PricingHero";
import PricingPerks from "@/components/views/pricing/PricingPerks";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import PricingFaq from "@/components/views/pricing/PricingFaq";
import FadeInUp from "@/components/ui/FadeInUp";

export default async function PricingPage() {
  const payload = await getPayload({ config });

  const services = await payload.find({
    collection: "services",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

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

  const faqs = await payload.find({
    collection: "pricing-faqs",
    limit: 20,
    sort: "createdAt",
  });

  return (
    <div className="overflow-hidden">
      <PricingHero />

      <FadeInUp delay={0.2}>
        <PricingPerks services={services.docs} />
      </FadeInUp>

      <FadeInUp>
        <PartnershipCustomer
          customers={customers.docs}
          partnerships={partnerships.docs}
        />
      </FadeInUp>

      <FadeInUp>
        <PricingFaq faqs={faqs.docs} />
      </FadeInUp>
    </div>
  );
}
