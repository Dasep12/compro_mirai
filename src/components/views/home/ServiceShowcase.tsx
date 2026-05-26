"use client";

import React, { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import { Service } from "../../../../payload-types";

interface ServiceShowcaseProps {
  services: Service[];
}

export default function ServiceShowcase({ services }: ServiceShowcaseProps) {
  const [activeIndex, setActiveIndex] = useState(0);

  useEffect(() => {
    if (!services || services.length <= 1) return;

    const timer = setInterval(() => {
      setActiveIndex((current) => {
        return current === services.length - 1 ? 0 : current + 1;
      });
    }, 5000);

    return () => clearInterval(timer);
  }, [services, activeIndex]);

  if (!services || services.length === 0) return null;

  const activeService = services[activeIndex];
  const heroImageUrl =
    activeService?.heroImage && typeof activeService.heroImage === "object"
      ? activeService.heroImage.url
      : null;
  const heroImageAlt =
    activeService?.heroImage && typeof activeService.heroImage === "object"
      ? activeService.heroImage.alt
      : activeService?.title;

  return (
    <section className="w-full relative overflow-hidden flex flex-col items-center bg-[#fdfdfd] px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-8 lg:gap-10 text-[#010101]">
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
            @keyframes fadeInService {
              from { opacity: 0; transform: translateY(10px); }
              to { opacity: 1; transform: translateY(0); }
            }
            .animate-fade-in-service {
              animation: fadeInService 0.5s ease-out forwards;
            }
          `,
        }}
      />

      <div className="flex flex-col items-center gap-4 text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
          LAYANAN KAMI
        </div>

        <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%]">
          Solusi Teknologi Terintegrasi
        </h2>

        <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1 max-w-3xl">
          Dari perancangan arsitektur sistem hingga implementasi aplikasi, kami
          menawarkan layanan menyeluruh yang dirancang khusus untuk memacu
          efisiensi dan memperkuat keunggulan kompetitif bisnis Anda di era
          digital.
        </p>
      </div>

      <div className="flex flex-col lg:flex-row items-stretch w-full gap-4 lg:gap-8 mt-2">
        <div className="w-full lg:w-[350px] flex flex-row lg:flex-col gap-2 shrink-0 overflow-x-auto lg:overflow-visible hide-scrollbar pb-2 lg:pb-0 snap-x snap-mandatory">
          {services.map((service, index) => {
            const isActive = index === activeIndex;
            const iconUrl =
              service.iconTitle && typeof service.iconTitle === "object"
                ? service.iconTitle.url
                : null;

            return (
              <button
                key={service.id}
                onClick={() => setActiveIndex(index)}
                className={`flex items-center gap-3 p-[12px_16px] sm:p-[14px_20px] text-left rounded-mirai transition-all duration-300 border shrink-0 snap-start min-w-[240px] sm:min-w-[280px] lg:min-w-0 lg:w-full ${
                  isActive
                    ? "bg-primary border-primary shadow-[0_4px_12px_rgba(4,81,177,0.25)]"
                    : "bg-transparent border-transparent hover:bg-[#010101]/5"
                }`}
              >
                <div
                  className={`w-[40px] h-[40px] lg:w-[46px] lg:h-[46px] rounded-full flex items-center justify-center shrink-0 transition-colors duration-300 ${
                    isActive ? "bg-[#fdfdfd]/20" : "bg-base-100/10"
                  }`}
                >
                  {iconUrl ? (
                    <Image
                      src={iconUrl}
                      alt={`${service.title} Icon`}
                      width={24}
                      height={24}
                      className={`object-contain w-5 h-5 lg:w-6 lg:h-6 transition-all duration-300 ${
                        isActive ? "brightness-0 invert" : ""
                      }`}
                    />
                  ) : (
                    <svg
                      className={`w-5 h-5 lg:w-6 lg:h-6 transition-colors duration-300 ${
                        isActive ? "text-[#fdfdfd]" : "text-base-100"
                      }`}
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M13 10V3L4 14h7v7l9-11h-7z"
                      />
                    </svg>
                  )}
                </div>
                <div className="flex flex-col gap-0.5 lg:gap-1">
                  <span
                    className={`font-bold text-[14px] lg:text-[16px] leading-[120%] transition-colors duration-300 ${
                      isActive ? "text-[#fdfdfd]" : "text-[#010101]"
                    }`}
                  >
                    {service.title}
                  </span>
                  <span
                    className={`text-[11px] lg:text-[13px] font-medium line-clamp-1 transition-colors duration-300 ${
                      isActive ? "text-[#fdfdfd]/80" : "text-[#010101]/60"
                    }`}
                  >
                    {service.subtitle}
                  </span>
                </div>
              </button>
            );
          })}
        </div>

        <div className="flex-1 w-full lg:w-auto flex flex-col xl:flex-row bg-[#fdfdfd] shadow-[3px_3px_8px_1px_rgba(0,0,0,0.1)] rounded-mirai border border-black/5 overflow-hidden h-[480px] sm:h-[560px] lg:h-[600px] xl:h-[420px]">
          <div className="w-full xl:w-[45%] h-[200px] sm:h-[300px] lg:h-[320px] xl:h-full relative shrink-0 bg-gray-50">
            {heroImageUrl ? (
              <Image
                key={heroImageUrl}
                src={heroImageUrl}
                alt={heroImageAlt || "Service Image"}
                fill
                className="object-cover animate-fade-in"
              />
            ) : (
              <div className="w-full h-full flex items-center justify-center bg-base-100/10">
                <span className="text-base-100/50 font-medium">No Image</span>
              </div>
            )}
          </div>

          <div 
            key={activeService?.id || activeIndex}
            className="flex flex-col items-start p-5 sm:p-6 lg:p-8 xl:p-[40px] gap-3 sm:gap-4 xl:gap-5 flex-1 h-full animate-fade-in-service"
          >
            <h3 className="text-[20px] sm:text-[24px] xl:text-[28px] font-bold leading-[125%] transition-opacity duration-300 line-clamp-2 w-full text-left shrink-0">
              {activeService?.dashboardTitle || activeService?.title}
            </h3>

            <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 line-clamp-4 sm:line-clamp-5 xl:line-clamp-6 transition-opacity duration-300 w-full text-left">
              {activeService?.dashboardSubtitle || activeService?.subtitle}
            </p>

            <div className="mt-auto pt-4 w-full flex justify-end shrink-0">
              <Link
                href={`/services/${activeService?.slug}`}
                className="flex items-center gap-2 px-5 py-3 rounded-mirai border-[1.5px] border-primary text-primary font-semibold hover:bg-brand-100 hover:border-brand-600 transition-colors"
              >
                <span className="text-[14px] sm:text-[15px]">Lebih Detail</span>
                <svg
                  className="w-4 h-4 sm:w-5 sm:h-5"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  strokeWidth={2}
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M9 5l7 7-7 7"
                  />
                </svg>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
