import { notFound } from "next/navigation";
import { Metadata } from "next";
import { getSolutionBySlug } from "@/lib/data/collections";
import SolutionDetail from "@/components/views/solution/SolutionDetail";
import FadeInUp from "@/components/ui/FadeInUp";

interface PageProps {
  params: Promise<{ slug: string }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const solution = await getSolutionBySlug(slug);

  if (!solution) {
    return {
      title: "Solusi Tidak Ditemukan | PT Mirai Softnet Technology",
      description: "Halaman solusi use case yang Anda cari tidak ditemukan.",
    };
  }

  return {
    title: `${solution.title} | PT Mirai Softnet Technology`,
    description: solution.excerpt || "Solusi teknologi terintegrasi dari PT Mirai Softnet Technology.",
  };
}

export default async function SolutionDetailPage({ params }: PageProps) {
  const { slug } = await params;
  const solution = await getSolutionBySlug(slug);

  if (!solution) {
    return notFound();
  }

  return (
    <div className="w-full min-h-screen pt-20 sm:pt-24 overflow-hidden bg-[#fdfdfd]">
      <FadeInUp>
        <SolutionDetail solution={solution} />
      </FadeInUp>
    </div>
  );
}
