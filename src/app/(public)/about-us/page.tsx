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
    <>
      <AboutUsHero data={aboutUs} />

      <AboutVisionMission data={aboutUs} />

      <AboutCoreValues data={aboutUs} />

      <AboutMilestones data={aboutUs} />

      <AboutStrengths data={aboutUs} />

      <AboutIndustries data={aboutUs} />

      <PartnershipCustomer
        customers={customers.docs}
        partnerships={partnerships.docs}
      />

      <AboutTeam data={aboutUs} />

      <AboutCta data={aboutUs} />
    </>
  );
}
