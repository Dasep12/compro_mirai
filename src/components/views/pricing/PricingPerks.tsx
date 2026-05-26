"use client";

import { useState, useRef } from "react";
import Link from "next/link";
import { Service } from "../../../../payload-types";

interface PricingPerksProps {
  services: Service[];
}

export default function PricingPerks({ services }: PricingPerksProps) {
  const pricingServices = services.filter((s) => s.showPricing);

  const [activeIndex, setActiveIndex] = useState(0);
  const sliderRef = useRef<HTMLDivElement>(null);

  const scrollLeft = () => {
    if (sliderRef.current) {
      sliderRef.current.scrollBy({ left: -340, behavior: "smooth" });
    }
  };

  const scrollRight = () => {
    if (sliderRef.current) {
      sliderRef.current.scrollBy({ left: 340, behavior: "smooth" });
    }
  };

  if (!pricingServices || pricingServices.length === 0) {
    return null;
  }

  const activeService = pricingServices[activeIndex];
  const pricingData = activeService.pricing;

  if (!pricingData?.tiers || pricingData.tiers.length === 0) {
    return null;
  }

  return (
    <section className="w-full flex flex-col items-center px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-8 sm:py-10 lg:py-14 gap-6 sm:gap-8 lg:gap-[22px] text-[#010101] text-center font-sans">
      <div className="w-full overflow-x-auto pb-4 flex justify-center">
        <div className="flex items-start p-1 gap-[12px] rounded-[16px] bg-[#fdfdfd] border border-brandbg-brand-100/50 w-max">
          {(pricingServices ?? []).map((service, index) => {
            const isActive = activeIndex === index;
            return (
              <button
                key={service.id}
                onClick={() => setActiveIndex(index)}
                className={`flex items-start px-[24px] py-[8px] rounded-[12px] font-semibold text-[18px] leading-[180%] transition-colors whitespace-nowrap ${
                  isActive
                    ? "bg-primary text-[#fdfdfd]"
                    : "bg-[#fdfdfd] text-[#010101] hover:bg-brand-100/10"
                }`}
              >
                {service.title}
              </button>
            );
          })}
        </div>
      </div>

      <div className="flex flex-col items-center gap-3 sm:gap-[12px] mt-2 lg:mt-4">
        <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] text-[#010101] max-w-[1014px]">
          {pricingData.pricingHeadline ||
            `Paket Layanan ${activeService.title}`}
        </h2>
        <p className="text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[18px] font-medium leading-[160%] sm:leading-[180%] text-[#010101] max-w-3xl">
          {pricingData.pricingDescription}
        </p>
        <div className="hidden md:flex xl:hidden items-center gap-2 mt-2 text-primary bg-brand-100/10 px-4 py-2 rounded-full animate-pulse">
          <svg
            className="w-4 h-4"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={2}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"
            />
          </svg>
          <span className="text-[13px] font-semibold">
            Geser untuk melihat paket lainnya
          </span>
        </div>
      </div>

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
      <div className="w-full relative group mt-4 lg:mt-[20px]">
        <button
          onClick={scrollLeft}
          className="hidden md:flex xl:hidden absolute left-[-10px] sm:left-[-20px] lg:left-[-40px] top-1/2 -translate-y-1/2 w-10 h-10 sm:w-12 sm:h-12 bg-white border border-gray-200 rounded-full items-center justify-center shadow-lg z-10 text-primary hover:bg-gray-50 focus:outline-none transition-all duration-300 opacity-0 group-hover:opacity-100"
          aria-label="Scroll left"
        >
          <svg
            className="w-5 h-5 sm:w-6 sm:h-6"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={2.5}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M15 19l-7-7 7-7"
            />
          </svg>
        </button>

        <button
          onClick={scrollRight}
          className="hidden md:flex xl:hidden absolute right-[-10px] sm:right-[-20px] lg:right-[-40px] top-1/2 -translate-y-1/2 w-10 h-10 sm:w-12 sm:h-12 bg-white border border-gray-200 rounded-full items-center justify-center shadow-lg z-10 text-primary hover:bg-gray-50 focus:outline-none transition-all duration-300 opacity-0 group-hover:opacity-100"
          aria-label="Scroll right"
        >
          <svg
            className="w-5 h-5 sm:w-6 sm:h-6"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={2.5}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M9 5l7 7-7 7"
            />
          </svg>
        </button>

        <div
          ref={sliderRef}
          className={`w-full flex flex-col md:flex-row ${
            (pricingData.tiers?.length || 0) < 3
              ? "xl:flex xl:justify-center md:justify-center"
              : "xl:grid xl:grid-cols-3"
          } gap-5 md:gap-6 lg:gap-[20px] text-left md:overflow-x-auto md:snap-x hide-scrollbar p-2 py-4 md:p-4 md:py-8 xl:overflow-visible`}
        >
          {(pricingData.tiers ?? []).map((tier, index) => {
            const {
              isPopular,
              tierName,
              price,
              priceSuffix,
              description,
              features,
              buttonText,
              buttonLink,
              id,
            } = tier;

            return (
              <div
                key={id || index}
                className={`group flex flex-col items-center p-6 sm:p-8 lg:p-[40px_20px] gap-6 sm:gap-[32px] rounded-[16px] transition-all hover:-translate-y-2 hover:shadow-xl duration-300 md:shrink-0 md:snap-center ${
                  (pricingData.tiers?.length || 0) < 3
                    ? "w-full md:w-[380px] xl:w-[400px]"
                    : "w-full md:w-[360px] lg:w-[380px] xl:w-full"
                } ${
                  isPopular
                    ? "bg-brand-100/10 border-2 border-primary shadow-[2px_4px_10px_1px_rgba(0,0,0,0.1)]"
                    : "bg-[#fdfdfd] border-transparent shadow-[2px_4px_10px_1px_rgba(0,0,0,0.1)]"
                }`}
              >
                <h3
                  className={`font-bold leading-[125%] text-center ${isPopular ? "text-[24px] sm:text-[28px]" : "text-[20px] sm:text-[24px]"}`}
                >
                  {tierName}
                </h3>

                <div className="flex items-end justify-center px-[10px] text-primary gap-2">
                  <span
                    className={`font-bold leading-none ${isPopular ? "text-[40px] sm:text-[50px]" : "text-[36px] sm:text-[46px]"}`}
                  >
                    {price}
                  </span>
                  {priceSuffix && (
                    <span className="text-[16px] sm:text-[19px] font-medium leading-[180%] text-[#010101] mb-1">
                      {priceSuffix}
                    </span>
                  )}
                </div>

                <div className="w-full flex flex-col items-start gap-[16px] sm:gap-[22px] flex-1">
                  <p className="text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[19px] font-medium leading-[160%] sm:leading-[180%] text-[#010101] text-left w-full">
                    {description}
                  </p>

                  <div className="w-full flex flex-col items-start gap-2 sm:gap-[10px]">
                    {(features ?? []).map((feat, i) => (
                      <div
                        key={feat.id || i}
                        className="w-full flex items-center gap-[12px]"
                      >
                        <svg
                          className={`w-[20px] h-[20px] sm:w-[24px] sm:h-[24px] shrink-0 ${isPopular ? "text-primary" : "text-[#010101]"}`}
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke="currentColor"
                          strokeWidth={2.5}
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M5 13l4 4L19 7"
                          />
                        </svg>
                        <span className="text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[19px] font-medium leading-[140%] sm:leading-[125%] text-[#010101]">
                          {feat.featureItem}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>

                <Link
                  href={buttonLink || "#contact"}
                  className={`w-full rounded-[10px] flex items-center justify-center px-[20px] py-[12px] font-semibold text-[16px] leading-[175%] mt-auto transition-all duration-300 ${
                    isPopular
                      ? "bg-primary text-[#fdfdfd] hover:bg-blue-800 hover:scale-[1.02] shadow-md"
                      : "bg-[#fdfdfd] border-[1.5px] border-primary text-primary hover:bg-primary hover:text-white"
                  }`}
                >
                  {buttonText || "Konsultasi Sekarang"}
                </Link>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
