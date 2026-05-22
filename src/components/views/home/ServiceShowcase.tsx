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
    <section className="w-full relative overflow-hidden flex flex-col items-center bg-[#fdfdfd] px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 text-[#010101]">
      <div className="flex flex-col items-center gap-4 max-w-[900px] text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
          LAYANAN & JASA
        </div>

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          Solusi IT Terintegrasi untuk Pertumbuhan Bisnis
        </h2>

        <p className="text-[16px] leading-[180%] font-medium text-[#010101]/80 mt-1">
          Dari pengembangan perangkat lunak kustom hingga manajemen
          infrastruktur dan keamanan siber, kami menghadirkan{" "}
          <br className="hidden md:block" />
          ekosistem teknologi end-to-end yang dirancang khusus untuk
          mengoptimalkan efisiensi operasional perusahaan Anda.
        </p>
      </div>

      <div className="w-full flex flex-col lg:flex-row items-start gap-6 lg:gap-[22px] mt-2">
        <div className="w-full lg:w-[273px] flex flex-row lg:flex-col overflow-x-auto lg:overflow-visible gap-3 shrink-0 pb-4 lg:pb-0 scrollbar-hide">
          {(services ?? []).map((service, index) => {
            const isActive = activeIndex === index;
            const iconUrl =
              service.iconTitle && typeof service.iconTitle === "object"
                ? service.iconTitle.url
                : null;

            return (
              <div
                key={service.id}
                onClick={() => setActiveIndex(index)}
                className={`flex items-center p-[14px_18px] gap-[14px] rounded-2xl cursor-pointer transition-all duration-300 min-w-[220px] lg:min-w-0 ${
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
                      alt={`${service.title} Icon`}
                      width={28}
                      height={28}
                      className="object-contain"
                      style={{ width: "28px", height: "auto" }}
                    />
                  ) : (
                    <div className="w-5 h-5 bg-gray-300 rounded-full" />
                  )}
                </div>

                <div className="flex flex-col flex-1 overflow-hidden">
                  <span className="font-bold text-[15px] leading-[125%] truncate">
                    {service.title}
                  </span>
                  <span
                    className={`text-[12px] leading-tight truncate mt-1 ${
                      isActive ? "text-[#fdfdfd]/80" : "text-[#53938b]"
                    }`}
                  >
                    {service.dashboardBadge || "Detail Layanan"}
                  </span>
                </div>
              </div>
            );
          })}
        </div>

        <div className="flex-1 w-full bg-[#fdfdfd] lg:min-h-[480px] rounded-[20px] border border-gray-100 shadow-[3px_3px_15px_rgba(0,0,0,0.05)] overflow-hidden flex flex-col xl:flex-row items-start transition-all duration-500">
          <div className="w-full xl:w-[576px] h-[250px] md:h-[350px] xl:h-[480px] relative shrink-0 bg-gray-50/50 flex items-center justify-center">
            {heroImageUrl ? (
              <Image
                src={heroImageUrl}
                alt={heroImageAlt || "Hero Service"}
                fill
                sizes="(max-width: 1280px) 100vw, 576px"
                className="object-cover md:object-contain p-4"
              />
            ) : (
              <div className="text-gray-400 font-medium">
                Belum ada gambar hero
              </div>
            )}
          </div>

          <div className="flex flex-col items-start p-4 xl:p-[20px_40px] gap-5 flex-1">
            <h3 className="text-[23px] md:text-[28px] font-bold leading-[125%] transition-opacity duration-300">
              {activeService?.dashboardTitle || activeService?.title}
            </h3>

            <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101]/80 line-clamp-6 transition-opacity duration-300">
              {activeService?.dashboardSubtitle || activeService?.subtitle}
            </p>

            <div className="mt-auto pt-4 w-full flex justify-end">
              <Link
                href={`/services/${activeService?.slug}`}
                className="flex items-center gap-2 px-5 py-3 rounded-[10px] border-[1.5px] border-primary text-primary font-semibold hover:bg-brand-100 transition-colors"
              >
                <span>Lebih Detail</span>
                <svg
                  className="w-5 h-5"
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
