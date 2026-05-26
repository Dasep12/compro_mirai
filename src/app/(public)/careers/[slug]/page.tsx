import { getPayload } from "payload";
import configPromise from "@payload-config";
import { notFound } from "next/navigation";
import CareerDetail from "@/components/views/careers/CareerDetail";
import FadeInUp from "@/components/ui/FadeInUp";

interface PageProps {
  params: Promise<{ slug: string }>;
}

export default async function CareerPage({ params }: PageProps) {
  const { slug } = await params;
  const payload = await getPayload({ config: configPromise });

  const { docs } = await payload.find({
    collection: "careers",
    where: { slug: { equals: slug } },
    limit: 1,
  });

  const job = docs[0];

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
