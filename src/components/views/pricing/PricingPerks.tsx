"use client";

import { useState } from "react";
import Link from "next/link";
import { Service } from "../../../../payload-types";

interface PricingPerksProps {
  services: Service[];
}

export default function PricingPerks({ services }: PricingPerksProps) {
  const pricingServices = services.filter((s) => s.showPricing);

  const [activeIndex, setActiveIndex] = useState(0);

  if (!pricingServices || pricingServices.length === 0) {
    return null;
  }

  const activeService = pricingServices[activeIndex];
  const pricingData = activeService.pricing;

  if (!pricingData?.tiers || pricingData.tiers.length === 0) {
    return null;
  }

  return (
    <section className="w-full flex flex-col items-center px-4 lg:px-[120px] xl:px-[240px] py-[40px] gap-[22px] text-[#010101] text-center font-sans">
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

      <div className="flex flex-col items-center gap-[12px] mt-4">
        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%] text-[#010101] max-w-[1014px]">
          {pricingData.pricingHeadline ||
            `Paket Layanan ${activeService.title}`}
        </h2>
        <p className="text-[15px] md:text-[16px] font-medium leading-[180%] text-[#010101] max-w-[800px]">
          {pricingData.pricingDescription}
        </p>
      </div>

      <div className="w-full grid grid-cols-1 xl:grid-cols-3 gap-[20px] mt-[20px] text-left">
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
              className={`flex flex-col items-center p-[40px_20px] gap-[32px] rounded-[16px] transition-transform hover:-translate-y-2 duration-300 ${
                isPopular
                  ? "bg-brand-100/10 border-2 border-primary shadow-[2px_4px_10px_1px_rgba(0,0,0,0.1)]"
                  : "bg-[#fdfdfd] border-transparent shadow-[2px_4px_10px_1px_rgba(0,0,0,0.1)]"
              }`}
            >
              <h3
                className={`font-bold leading-[125%] text-center ${isPopular ? "text-[28px]" : "text-[24px]"}`}
              >
                {tierName}
              </h3>

              <div className="flex items-end justify-center px-[10px] text-primary gap-2">
                <span
                  className={`font-bold leading-none ${isPopular ? "text-[52px]" : "text-[48px]"}`}
                >
                  {price}
                </span>
                {priceSuffix && (
                  <span className="text-[19px] font-medium leading-[180%] text-[#010101] mb-1">
                    {priceSuffix}
                  </span>
                )}
              </div>

              <div className="w-full flex flex-col items-start gap-[22px] flex-1">
                <p className="text-[15px] md:text-[19px] font-medium leading-[180%] text-[#010101] text-left w-full">
                  {description}
                </p>

                <div className="w-full flex flex-col items-start gap-[10px]">
                  {(features ?? []).map((feat, i) => (
                    <div
                      key={feat.id || i}
                      className="w-full flex items-center gap-[12px]"
                    >
                      <svg
                        className={`w-[24px] h-[24px] shrink-0 ${isPopular ? "text-primarbg-primary" : "text-[#010101]"}`}
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
                      <span className="text-[15px] md:text-[19px] font-medium leading-[125%] text-[#010101]">
                        {feat.featureItem}
                      </span>
                    </div>
                  ))}
                </div>
              </div>

              <Link
                href={buttonLink || "#contact"}
                className={`w-full rounded-[10px] flex items-center justify-center px-[20px] py-[12px] font-semibold text-[16px] leading-[175%] mt-auto transition-colors ${
                  isPopular
                    ? "bg-primary text-[#fdfdfd] hover:bg-blue-800"
                    : "bg-[#fdfdfd] border-[1.5px] border-primary text-primary hover:bg-primary/5"
                }`}
              >
                {buttonText || "Konsultasi Sekarang"}
              </Link>
            </div>
          );
        })}
      </div>
    </section>
  );
}
