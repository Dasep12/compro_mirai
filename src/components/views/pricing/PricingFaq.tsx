"use client";

import { useState } from "react";
import { PricingFaq } from "../../../../payload-types";

interface PricingFaqProps {
  faqs: PricingFaq[];
}

export default function PricingFaq({ faqs }: PricingFaqProps) {
  const [expandedQnaIndex, setExpandedQnaIndex] = useState<number | null>(0);

  const toggleAccordion = (index: number) => {
    setExpandedQnaIndex((prev) => (prev === index ? null : index));
  };

  if (!faqs || faqs.length === 0) return null;

  return (
    <section className="w-full relative flex flex-col items-center bg-[#fdfdfd] px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 text-[#010101] font-sans">
      <div className="flex flex-col items-center gap-4 max-w-[900px] text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
          FAQ
        </div>

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          <span className="text-primary">Frequently</span>{" "}
          <span className="text-[#010101]">Asked Questions</span>
        </h2>

        <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101] mt-1 max-w-[800px]">
          Temukan jawaban atas pertanyaan umum seputar layanan IT, solusi
          software kustom, dan produk unggulan Mirai Softnet.
        </p>
      </div>

      <div className="w-[80%] bg-[#fdfdfd] shadow-[2px_4px_10px_1px_rgba(0,0,0,0.05)] rounded-[20px] p-6 lg:p-8 xl:p-[32px_40px] flex flex-col gap-4 animate-in fade-in slide-in-from-right-4 duration-500">
        {faqs.map((faq, idx) => {
          const isExpanded = expandedQnaIndex === idx;
          const displayNumber = String(idx + 1).padStart(2, "0");

          return (
            <div
              key={faq.id || idx}
              className="flex flex-col border-b border-gray-100 last:border-b-0 pb-4 last:pb-0"
            >
              <div
                onClick={() => toggleAccordion(idx)}
                className="flex items-center gap-4 cursor-pointer group"
              >
                <div className="w-8 h-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center font-bold text-[13px] shrink-0">
                  {displayNumber}
                </div>

                <h3 className="flex-1 font-bold text-[16px] md:text-[18px] leading-[140%] text-primary group-hover:text-blue-800 transition-colors">
                  {faq.question}
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
                    {faq.answer}
                  </div>
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
}
