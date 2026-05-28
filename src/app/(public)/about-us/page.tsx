import type { Metadata } from "next";
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
import {
  getAboutUs,
  getCustomers,
  getPartnerships,
} from "@/lib/data/collections";

export const metadata: Metadata = {
  title: "Tentang Kami",
  description:
    "Kenali Mirai Softnet & Technology — misi, visi, nilai inti, dan tim profesional yang mendorong transformasi digital Indonesia.",
};

export default async function AboutUsPage() {
  const [aboutUs, customers, partnerships] = await Promise.all([
    getAboutUs(),
    getCustomers(20),
    getPartnerships(20),
  ]);

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
          customers={customers}
          partnerships={partnerships}
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
