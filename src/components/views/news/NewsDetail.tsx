"use client";

import Image from "@/components/ui/Image";
import Link from "next/link";
import { RichText } from "@payloadcms/richtext-lexical/react";
import { News } from "../../../../payload-types";

interface NewsDetailProps {
  newsItem: News;
}

export default function NewsDetail({ newsItem }: NewsDetailProps) {
  const imageUrl =
    newsItem.image && typeof newsItem.image === "object" ? newsItem.image.url : null;
  const imageAlt =
    newsItem.image && typeof newsItem.image === "object" ? newsItem.image.alt : newsItem.title;

  const dateStr = newsItem.date ? new Date(newsItem.date).toLocaleDateString('id-ID', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  }) : "";

  return (
    <article className="w-full relative overflow-hidden flex flex-col items-center px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-8 sm:py-10 lg:py-14 gap-6 sm:gap-8 lg:gap-[22px] text-[#010101] bg-[#fdfdfd] font-sans">
      <div className="w-full max-w-4xl flex flex-col items-start gap-4 sm:gap-5 xl:gap-[20px]">
        <Link
          href="/news"
          className="group rounded-[10px] bg-[#fdfdfd] border border-gray-200 lg:border-none flex items-center gap-[10px] p-2 text-[#0451bf] font-semibold text-[15px] sm:text-[16px] leading-[175%] no-underline hover:opacity-80 transition-all duration-300 hover:-translate-x-1"
        >
          <svg
            className="w-[23px] h-[23px]"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={2.5}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M10 19l-7-7m0 0l7-7m-7 7h18"
            />
          </svg>
          <span>Kembali ke Berita</span>
        </Link>

        <div className="flex items-center gap-3 w-full mt-4">
          <div className="bg-[#7eb2fc]/25 text-[#0451bf] rounded-[99px] flex items-center justify-center px-[14px] py-[5px] text-[13px] sm:text-[14px] font-semibold leading-[180%] capitalize">
            {newsItem.category}
          </div>
          {dateStr && (
            <span className="text-[14px] font-medium text-gray-500">{dateStr}</span>
          )}
        </div>

        <h1 className="text-[28px] sm:text-[34px] lg:text-[40px] font-bold leading-[130%] sm:leading-[125%] text-[#010101]">
          {newsItem.title}
        </h1>

        <div className="w-full aspect-video sm:h-[400px] md:h-[500px] xl:h-[550px] shrink-0 rounded-[20px] overflow-hidden relative bg-gray-50 p-4 shadow-sm animate-in fade-in zoom-in-95 duration-700 mt-4 mb-4">
          {imageUrl ? (
            <Image
              src={imageUrl}
              alt={imageAlt || "News Cover"}
              fill
              priority
              quality={100}
              sizes="(max-width: 1280px) 100vw, 1000px"
              className="object-cover rounded-[20px]"
            />
          ) : (
            <div className="w-full h-full flex items-center justify-center text-gray-400 font-medium">
              Belum ada Cover Berita
            </div>
          )}
        </div>

        <div className="w-full flex flex-col gap-6 mt-2 text-left">
          <div
            className="w-full text-[16px] leading-[180%] font-medium text-[#010101] text-left sm:text-justify
    [&_h1]:text-[28px] [&_h1]:md:text-[32px] [&_h1]:font-bold [&_h1]:leading-[125%] [&_h1]:text-[#010101] [&_h1]:mb-4 [&_h1]:mt-6
    [&_h2]:text-[23px] [&_h2]:md:text-[26px] [&_h2]:font-bold [&_h2]:leading-[125%] [&_h2]:text-[#010101] [&_h2]:mb-3 [&_h2]:mt-5
    [&_h3]:text-[20px] [&_h3]:font-bold [&_h3]:leading-[125%] [&_h3]:text-[#010101] [&_h3]:mb-2 [&_h3]:mt-4
    [&_h4]:text-[18px] [&_h4]:font-bold [&_h4]:leading-[130%] [&_h4]:text-[#010101] [&_h4]:mb-2 [&_h4]:mt-3
    [&_h5]:text-[16px] [&_h5]:font-bold [&_h5]:leading-[140%] [&_h5]:text-[#010101] [&_h5]:mb-2 [&_h5]:mt-3
    [&_h6]:text-[14px] [&_h6]:font-bold [&_h6]:leading-[150%] [&_h6]:text-[#010101] [&_h6]:mb-2 [&_h6]:mt-3
    [&_p]:mb-4 [&_p]:last:mb-0
    [&_a]:text-[#0451bf] [&_a]:underline [&_a]:font-semibold hover:[&_a]:text-blue-800
    [&_strong]:font-bold [&_b]:font-bold
    [&_blockquote]:border-l-4 [&_blockquote]:border-[#0451bf] [&_blockquote]:pl-4 [&_blockquote]:italic [&_blockquote]:text-[#010101]/70 [&_blockquote]:mb-4 [&_blockquote]:my-4
    [&_ul]:list-disc [&_ul]:pl-[21px] [&_ul]:mb-4
    [&_ol]:list-decimal [&_ol]:pl-[21px] [&_ol]:mb-4
    [&_li]:mb-1 [&_li]:leading-[180%]"
          >
            {newsItem.content && <RichText data={newsItem.content} />}
          </div>
        </div>
      </div>
    </article>
  );
}
