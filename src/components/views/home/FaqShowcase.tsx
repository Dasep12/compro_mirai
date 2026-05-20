"use client";

import React, { useState } from "react";
import Image from "next/image";
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
    <section className="w-full relative flex flex-col items-center bg-[#fdfdfd] px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 text-[#010101]">
      <div className="flex flex-col items-center gap-4 max-w-[900px] text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
          FAQ
        </div>

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          <span className="text-primary">Frequently</span>{" "}
          <span className="text-[#010101]">Asked Questions</span>
        </h2>

        <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101] mt-1">
          Temukan jawaban atas pertanyaan umum seputar layanan IT, solusi
          software kustom, dan produk unggulan Mirai Softnet.
        </p>
      </div>

      <div className="w-full flex flex-col lg:flex-row items-start gap-6 lg:gap-8 mt-2">
        <div className="w-full lg:w-[280px] flex flex-row lg:flex-col overflow-x-auto lg:overflow-visible gap-3 shrink-0 pb-4 lg:pb-0 scrollbar-hide">
          {faqs.map((faq, index) => {
            const isActive = activeCategoryIndex === index;
            const iconUrl =
              faq.icon && typeof faq.icon === "object" ? faq.icon.url : null;

            return (
              <div
                key={faq.id}
                onClick={() => handleCategoryChange(index)}
                className={`flex items-center p-[14px_18px] gap-[14px] rounded-2xl cursor-pointer transition-all duration-300 min-w-[180px] lg:min-w-0 ${
                  isActive
                    ? "bg-primary text-[#fdfdfd] shadow-md"
                    : "bg-[#fdfdfd] border-[0.5px] border-primary/25 text-[#010101] hover:bg-gray-50"
                }`}
              >
                <div
                  className={`w-9 h-9 rounded-lg flex items-center justify-center shrink-0 ${
                    isActive ? "bg-[#fdfdfd]" : "bg-[#7eb2fc]/15"
                  }`}
                >
                  {iconUrl ? (
                    <Image
                      src={iconUrl}
                      alt={`${faq.categoryName} Icon`}
                      width={24}
                      height={24}
                      className="object-contain"
                      style={{ width: "24px", height: "auto" }}
                    />
                  ) : (
                    <div className="w-5 h-5 bg-gray-300 rounded-full" />
                  )}
                </div>

                <span className="font-bold text-[16px] leading-[125%] truncate">
                  {faq.categoryName}
                </span>
              </div>
            );
          })}
        </div>

        <div className="flex-1 w-full bg-[#fdfdfd] shadow-[2px_4px_10px_1px_rgba(0,0,0,0.05)] rounded-[20px] p-6 lg:p-8 xl:p-[32px_40px] flex flex-col gap-4 animate-in fade-in slide-in-from-right-4 duration-500">
          {activeCategory?.qnaList?.map((qna, idx) => {
            const isExpanded = expandedQnaIndex === idx;
            const displayNumber = String(idx + 1).padStart(2, "0");

            return (
              <div
                key={idx}
                className="flex flex-col border-b border-gray-100 last:border-b-0 pb-4 last:pb-0"
              >
                <div
                  onClick={() => toggleAccordion(idx)}
                  className="flex items-center gap-4 cursor-pointer group"
                >
                  <div className="w-8 h-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center font-bold text-[13px] shrink-0">
                    {displayNumber}
                  </div>

                  <h3 className="flex-1 font-bold text-[16px] md:text-[18px] leading-[140%] text-primary group-hover:text-brand-600 transition-colors">
                    {qna.question}
                  </h3>

                  <div className="w-8 h-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center shrink-0 transition-transform duration-300">
                    <svg
                      className={`w-4 h-4 transform transition-transform duration-300 ${
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
                      ? "grid-rows-[1fr] opacity-100 mt-3"
                      : "grid-rows-[0fr] opacity-0 mt-0"
                  }`}
                >
                  <div className="overflow-hidden">
                    <div className="pl-[48px] text-[15px] leading-[180%] font-medium text-[#010101]/90">
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
