import { getPayload } from "payload";
import config from "../../../../payload.config";
import PricingHero from "@/components/views/pricing/PricingHero";
import PricingPerks from "@/components/views/pricing/PricingPerks";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";

export default async function PricingPage() {
  const payload = await getPayload({ config });

  const services = await payload.find({
    collection: "services",
    depth: 1,
    limit: 10,
  });

  const customers = await payload.find({
    collection: "customers",
    limit: 20,
  });

  const partnerships = await payload.find({
    collection: "partnerships",
    limit: 20,
  });

  return (
    <>
      <PricingHero />

      <PricingPerks services={services.docs} />

      <PartnershipCustomer
        customers={customers.docs}
        partnerships={partnerships.docs}
      />
    </>
  );
}
