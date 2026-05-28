import CareerHero from "@/components/views/careers/CareerHero";
import CareerList from "@/components/views/careers/CareerList";
import FadeInUp from "@/components/ui/FadeInUp";
import { getCareers } from "@/lib/data/collections";

export default async function CareersPage() {
  const careers = await getCareers(10);

  return (
    <div className="overflow-hidden">
      <CareerHero />

      <FadeInUp delay={0.2}>
        <CareerList careers={careers} />
      </FadeInUp>
    </div>
  );
}
