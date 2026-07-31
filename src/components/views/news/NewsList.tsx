"use client";

import React, { useState } from "react";
import Image from "@/components/ui/Image";
import Link from "next/link";
import { News } from "../../../../payload-types";

interface NewsListProps {
  newsList: News[];
}

export default function NewsList({ newsList }: NewsListProps) {
  const [activeCategory, setActiveCategory] = useState("Semua");
  const categories = [
    "Semua",
    "Berita",
    "Pengumuman",
    "Acara",
    "Penghargaan",
    "Teknologi",
  ];

  const filteredNews = newsList.filter(
    (item) =>
      activeCategory === "Semua" ||
      item.category === activeCategory.toLowerCase(),
  );

  return (
    <section className="w-full flex flex-col items-center px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-8 sm:py-10 lg:py-14 gap-6 sm:gap-8 lg:gap-[22px] text-[#010101] bg-[#fdfdfd]">
      <div className="w-full flex flex-wrap items-center justify-start gap-[12px] mb-4">
        {(categories ?? []).map((cat) => {
          const isActive = activeCategory === cat;
          return (
            <button
              key={cat}
              onClick={() => setActiveCategory(cat)}
              className={`rounded-[99px] flex items-center justify-center px-[20px] py-[5px] font-semibold text-[14px] leading-[180%] transition-colors duration-300 cursor-pointer ${
                isActive
                  ? "bg-[#0451bf] text-[#fdfdfd] shadow-md"
                  : "bg-[#fdfdfd] border border-[#0451bf] text-[#0451bf] hover:bg-[#0451bf]/10"
              }`}
            >
              {cat}
            </button>
          );
        })}
      </div>

      {filteredNews.length === 0 && (
        <div className="w-full text-center py-20 font-medium text-[16px] text-gray-500">
          Belum ada berita untuk kategori ini.
        </div>
      )}

      {filteredNews.length > 0 && (
        <div className="w-full flex flex-col gap-8 lg:gap-10">
          {(filteredNews ?? []).map((item) => {
            const imageUrl =
              item.image && typeof item.image === "object" ? item.image.url : null;
              
            const dateStr = item.date ? new Date(item.date).toLocaleDateString('id-ID', {
              day: 'numeric',
              month: 'long',
              year: 'numeric'
            }) : "";

            return (
              <div
                key={item.id}
                className="group w-full shadow-[0px_4px_10px_1px_rgba(0,0,0,0.1)] hover:shadow-xl hover:-translate-y-1 transition-all duration-300 rounded-[20px] bg-[#fdfdfd] overflow-hidden flex flex-col md:flex-row items-stretch gap-0 border border-gray-100"
              >
                <div className="w-full md:w-[40%] lg:w-[35%] h-[240px] sm:h-[300px] md:h-auto md:min-h-[300px] shrink-0 relative">
                  {imageUrl && (
                    <Image
                      src={imageUrl}
                      alt={item.title}
                      fill
                      className="object-cover group-hover:scale-101 transition-transform duration-500"
                    />
                  )}
                </div>

                <div className="flex flex-col items-start p-5 sm:p-6 md:p-8 lg:p-10 gap-4 w-full flex-1">
                  <div className="flex items-center justify-between w-full">
                    <div className="bg-[#7eb2fc]/25 text-[#0451bf] rounded-[99px] px-[14px] py-[5px] font-semibold text-[14px] leading-[180%] flex items-center justify-center capitalize">
                      {item.category}
                    </div>
                    {dateStr && (
                      <span className="text-[13px] md:text-[14px] font-medium text-gray-500">{dateStr}</span>
                    )}
                  </div>

                  <h2 className="text-[22px] md:text-[26px] lg:text-[28px] font-bold leading-[140%] text-[#010101] line-clamp-2 group-hover:text-[#0451bf] transition-colors">
                    {item.title}
                  </h2>

                  <p className="text-[14px] lg:text-[16px] font-medium leading-[180%] text-[#010101]/80 line-clamp-3 md:line-clamp-4">
                    {item.shortDescription}
                  </p>
                  
                  <div className="mt-auto pt-4 w-full flex justify-end">
                    <Link
                      href={`/news/${item.slug}`}
                      className="w-full md:w-auto bg-[#fdfdfd] text-[#0451bf] border border-[#0451bf] rounded-[10px] flex items-center justify-center px-[24px] py-[10px] gap-[10px] font-semibold text-[15px] leading-[175%] hover:bg-[#0451bf] hover:text-[#fdfdfd] transition-all duration-300"
                    >
                      Baca Selengkapnya
                      <svg
                        className="w-[20px] h-[20px]"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M14 5l7 7m0 0l-7 7m7-7H3"
                        />
                      </svg>
                    </Link>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </section>
  );
}
