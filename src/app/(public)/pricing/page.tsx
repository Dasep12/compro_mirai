import { getPayload } from "payload";
import config from "../../../../payload.config";
import PricingHero from "@/components/views/pricing/PricingHero";
import PricingPerks from "@/components/views/pricing/PricingPerks";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import PricingFaq from "@/components/views/pricing/PricingFaq";

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
    <>
      <PricingHero />

      <PricingPerks services={services.docs} />

      <PartnershipCustomer
        customers={customers.docs}
        partnerships={partnerships.docs}
      />

      <PricingFaq faqs={faqs.docs} />
    </>
  );
}
