import { getPayload } from "payload";
import config from "../../../../payload.config";
import AboutUsHero from "@/components/views/about_us/AboutUsHero";
import AboutVisionMission from "@/components/views/about_us/AboutVisionMission";
import AboutCoreValues from "@/components/views/about_us/AboutCoreValue";
import AboutMilestones from "@/components/views/about_us/AboutMilestone";
import AboutStrengths from "@/components/views/about_us/AboutStrengths";
import AboutIndustries from "@/components/views/about_us/AboutIndustries";
import PartnershipCustomer from "@/components/views/home/PartnershipCustomer";
import AboutTeam from "@/components/views/about_us/AboutTeam";
import AboutCta from "@/components/views/about_us/AboutCTA";
import FadeInUp from "@/components/ui/FadeInUp";

export default async function AboutUsPage() {
  const payload = await getPayload({ config });

  const aboutUs = await payload.findGlobal({
    slug: "about-us",
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

  return (
    <div className="overflow-hidden">
      <AboutUsHero data={aboutUs} />

      <FadeInUp delay={0.2}>
        <AboutVisionMission data={aboutUs} />
      </FadeInUp>

      <FadeInUp>
        <AboutCoreValues data={aboutUs} />
      </FadeInUp>

      <FadeInUp>
        <AboutMilestones data={aboutUs} />
      </FadeInUp>

      <FadeInUp>
        <AboutStrengths data={aboutUs} />
      </FadeInUp>

      <FadeInUp>
        <AboutIndustries data={aboutUs} />
      </FadeInUp>

      <FadeInUp>
        <PartnershipCustomer
          customers={customers.docs}
          partnerships={partnerships.docs}
        />
      </FadeInUp>

      <FadeInUp>
        <AboutTeam data={aboutUs} />
      </FadeInUp>

      <FadeInUp>
        <AboutCta data={aboutUs} />
      </FadeInUp>
    </div>
  );
}
