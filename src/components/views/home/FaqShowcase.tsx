"use client";

import React, { useState } from "react";
import Image from "@/components/ui/Image";
import { Faq } from "../../../../payload-types";

interface FaqShowcaseProps {
  faqs: Faq[];
}

export default function FaqShowcase({ faqs }: FaqShowcaseProps) {
  const [activeCategoryIndex, setActiveCategoryIndex] = useState(0);
  const [expandedQnaIndex, setExpandedQnaIndex] = useState<number | null>(0);

  if (!faqs || faqs.length === 0) return null;

  const activeCategory = faqs[activeCategoryIndex];

  const handleCategoryChange = (index: number) => {
    setActiveCategoryIndex(index);
    setExpandedQnaIndex(0);
  };

  const toggleAccordion = (index: number) => {
    setExpandedQnaIndex((prev) => (prev === index ? null : index));
  };

  return (
    <section className="w-full relative flex flex-col items-center bg-[#fdfdfd] px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-8 lg:gap-10 text-[#010101]">
      <style
        dangerouslySetInnerHTML={{
          __html: `
            .hide-scrollbar::-webkit-scrollbar {
              display: none;
            }
            .hide-scrollbar {
              -ms-overflow-style: none;
              scrollbar-width: none;
            }
          `,
        }}
      />

      <div className="flex flex-col items-center gap-4 max-w-[900px] text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
          FAQ
        </div>

        <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] max-w-4xl">
          <span className="text-primary">Frequently</span>{" "}
          <span className="text-[#010101]">Asked Questions</span>
        </h2>

        <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1 max-w-3xl">
          Temukan jawaban atas pertanyaan umum seputar layanan IT, solusi
          software kustom, dan produk unggulan Mirai Softnet.
        </p>
      </div>

      <div className="w-full flex flex-col lg:flex-row items-start gap-6 lg:gap-8 mt-2">
        <div className="w-full lg:w-[280px] xl:w-[320px] flex flex-row lg:flex-col overflow-x-auto lg:overflow-visible gap-3 shrink-0 pb-2 lg:pb-0 hide-scrollbar snap-x snap-mandatory">
          {(faqs ?? []).map((faq, index) => {
            const isActive = activeCategoryIndex === index;
            const iconUrl =
              faq.icon && typeof faq.icon === "object" ? faq.icon.url : null;

            return (
              <div
                key={faq.id}
                onClick={() => handleCategoryChange(index)}
                className={`flex items-center p-[14px_18px] sm:p-[16px_20px] gap-[12px] sm:gap-[14px] rounded-2xl cursor-pointer transition-all duration-300 min-w-[200px] sm:min-w-[240px] lg:min-w-0 snap-start shrink-0 ${
                  isActive
                    ? "bg-primary text-[#fdfdfd] shadow-[0_4px_12px_rgba(4,81,177,0.25)]"
                    : "bg-[#fdfdfd] border-[0.5px] border-primary/25 text-[#010101] hover:bg-gray-50"
                }`}
              >
                <div
                  className={`w-8 h-8 sm:w-10 sm:h-10 rounded-lg flex items-center justify-center shrink-0 ${
                    isActive ? "bg-[#fdfdfd]" : "bg-[#7eb2fc]/15"
                  }`}
                >
                  {iconUrl ? (
                    <Image
                      src={iconUrl}
                      alt={`${faq.categoryName} Icon`}
                      width={24}
                      height={24}
                      className="object-contain w-5 h-5 sm:w-6 sm:h-6"
                    />
                  ) : (
                    <div className="w-5 h-5 sm:w-6 sm:h-6 bg-gray-300 rounded-full" />
                  )}
                </div>

                <span className="font-bold text-[14px] sm:text-[15px] lg:text-[16px] leading-[125%] truncate">
                  {faq.categoryName}
                </span>
              </div>
            );
          })}
        </div>

        <div className="flex-1 w-full bg-[#fdfdfd] shadow-[2px_4px_10px_1px_rgba(0,0,0,0.05)] rounded-[20px] p-5 sm:p-6 lg:p-8 xl:p-[40px] flex flex-col gap-4 sm:gap-5 animate-in fade-in slide-in-from-right-4 duration-500">
          {(activeCategory?.qnaList ?? []).map((qna, idx) => {
            const isExpanded = expandedQnaIndex === idx;
            const displayNumber = String(idx + 1).padStart(2, "0");

            return (
              <div
                key={idx}
                className="flex flex-col border-b border-gray-100 last:border-b-0 pb-4 last:pb-0"
              >
                <div
                  onClick={() => toggleAccordion(idx)}
                  className="flex items-center gap-3 sm:gap-4 cursor-pointer group"
                >
                  <div className="w-7 h-7 sm:w-8 sm:h-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center font-bold text-[12px] sm:text-[13px] shrink-0">
                    {displayNumber}
                  </div>

                  <h3 className="flex-1 font-bold text-[15px] sm:text-[16px] lg:text-[18px] leading-[140%] text-primary group-hover:text-brand-600 transition-colors">
                    {qna.question}
                  </h3>

                  <div className="w-7 h-7 sm:w-8 sm:h-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center shrink-0 transition-transform duration-300">
                    <svg
                      className={`w-3.5 h-3.5 sm:w-4 sm:h-4 transform transition-transform duration-300 ${
                        isExpanded ? "rotate-180" : "rotate-0"
                      }`}
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2.5}
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M19 9l-7 7-7-7"
                      />
                    </svg>
                  </div>
                </div>

                <div
                  className={`grid transition-all duration-300 ease-in-out ${
                    isExpanded
                      ? "grid-rows-[1fr] opacity-100 mt-2 sm:mt-3"
                      : "grid-rows-[0fr] opacity-0 mt-0"
                  }`}
                >
                  <div className="overflow-hidden">
                    <div className="pl-[40px] sm:pl-[48px] text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80">
                      {qna.answer}
                    </div>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
