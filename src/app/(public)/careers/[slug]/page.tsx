import { notFound } from "next/navigation";
import CareerDetail from "@/components/views/careers/CareerDetail";
import FadeInUp from "@/components/ui/FadeInUp";
import { getCareerBySlug } from "@/lib/data/collections";

interface PageProps {
  params: Promise<{ slug: string }>;
}

export default async function CareerPage({ params }: PageProps) {
  const { slug } = await params;

  const job = await getCareerBySlug(slug);

  if (!job) {
    return notFound();
  }

  return (
    <div className="overflow-hidden">
      <FadeInUp>
        <CareerDetail job={job} />
      </FadeInUp>
    </div>
  );
}
