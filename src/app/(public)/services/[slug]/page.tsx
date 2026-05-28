import { notFound } from "next/navigation";
import ServiceHero from "@/components/views/services/ServiceHero";
import ServiceProblem from "@/components/views/services/ServiceProblem";
import ServiceSolution from "@/components/views/services/ServiceSolution";
import ServiceProcess from "@/components/views/services/ServiceProcess";
import ServiceCTA from "@/components/views/services/ServiceCTS";
import ServiceBenefit from "@/components/views/services/ServiceBenefit";
import FadeInUp from "@/components/ui/FadeInUp";
import { getServiceBySlug } from "@/lib/data/collections";

interface PageProps {
  params: Promise<{
    slug: string;
  }>;
}

export default async function ServicePage({ params }: PageProps) {
  const { slug } = await params;
  const service = await getServiceBySlug(slug);

  if (!service) {
    return notFound();
  }

  return (
    <div className="overflow-hidden">
      <ServiceHero service={service} />

      <FadeInUp delay={0.2}>
        <ServiceProblem
          showProblem={service.showProblem}
          problemData={service.problem}
        />
      </FadeInUp>

      <FadeInUp>
        <ServiceSolution
          showSolution={service.showSolution}
          solutionData={service.solution}
        />
      </FadeInUp>

      <FadeInUp>
        <ServiceProcess
          showProcess={service.showProcess}
          processData={service.process}
          showFramework={service.showFramework}
          frameworkData={service.framework}
        />
      </FadeInUp>

      <FadeInUp>
        <ServiceCTA service={service} />
      </FadeInUp>

      <FadeInUp>
        <ServiceBenefit
          showBenefit={service.showBenefit}
          benefitData={service.benefit}
        />
      </FadeInUp>
    </div>
  );
}
