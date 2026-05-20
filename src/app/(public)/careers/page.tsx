import { getPayload } from "payload";
import configPromise from "@payload-config";
import CareerHero from "@/components/views/careers/CareerHero";
import CareerList from "@/components/views/careers/CareerList";

export default async function CareersPage() {
  const payload = await getPayload({
    config: configPromise,
  });
  const { docs: careers } = await payload.find({ collection: "careers" });

  return (
    <>
      <CareerHero />

      <CareerList careers={careers} />
    </>
  );
}
