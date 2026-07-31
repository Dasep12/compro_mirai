import { notFound } from "next/navigation";
import NewsDetail from "@/components/views/news/NewsDetail";
import FadeInUp from "@/components/ui/FadeInUp";
import { getNewsBySlug } from "@/lib/data/collections";
import { Metadata } from "next";

interface PageProps {
  params: Promise<{ slug: string }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const newsItem = await getNewsBySlug(slug);

  if (!newsItem) {
    return {
      title: "Not Found",
      description: "Berita yang Anda cari tidak ditemukan.",
    };
  }

  return {
    title: `${newsItem.title} | Mirai Softnet`,
    description: newsItem.shortDescription,
  };
}

export default async function NewsDetailPage({ params }: PageProps) {
  const { slug } = await params;

  const newsItem = await getNewsBySlug(slug);

  if (!newsItem) {
    return notFound();
  }

  return (
    <div className="overflow-hidden">
      <FadeInUp>
        <NewsDetail newsItem={newsItem} />
      </FadeInUp>
    </div>
  );
}
