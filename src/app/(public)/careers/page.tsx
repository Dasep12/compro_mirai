import { getPayload } from "payload";
import configPromise from "@payload-config";
import CareerHero from "@/components/views/careers/CareerHero";
import CareerList from "@/components/views/careers/CareerList";
import FadeInUp from "@/components/ui/FadeInUp";

export default async function CareersPage() {
  const payload = await getPayload({
    config: configPromise,
  });

  const { docs: careers } = await payload.find({
    collection: "careers",
    sort: "createdAt",
  });

  return (
    <div className="overflow-hidden">
      <CareerHero />

      <FadeInUp delay={0.2}>
        <CareerList careers={careers} />
      </FadeInUp>
    </div>
  );
}
