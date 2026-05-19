import Hero from "@/components/views/home/Hero";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import { getPayload } from "payload";
import config from "../../../payload.config";
import Problem from "@/components/views/home/Problem";

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

  return (
    <>
      <Hero />

      <PartnershipCustomer
        customers={customers.docs}
        partnerships={partnerships.docs}
      />

      <Problem />
    </>
  );
}
