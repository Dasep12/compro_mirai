import NewsHero from "@/components/views/news/NewsHero";
import NewsList from "@/components/views/news/NewsList";
import FadeInUp from "@/components/ui/FadeInUp";
import { getNews } from "@/lib/data/collections";
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "Berita & Artikel Terkini | PT Mirai Softnet",
  description: "Dapatkan informasi terbaru seputar inovasi teknologi, pencapaian perusahaan, serta wawasan industri terkini dari PT Mirai Softnet. Ikuti perjalanan kami dalam menghadirkan solusi IT terbaik.",
};

export default async function NewsPage() {
  const news = await getNews(100);

  return (
    <div className="overflow-hidden">
      <NewsHero />

      <FadeInUp delay={0.2}>
        <NewsList newsList={news} />
      </FadeInUp>
    </div>
  );
}
