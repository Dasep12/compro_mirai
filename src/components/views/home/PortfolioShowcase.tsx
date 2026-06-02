"use client";

import { useState, useEffect } from "react";
import Image from "@/components/ui/Image";
import { Portfolio } from "../../../../payload-types";

interface PortfolioShowcaseProps {
  portfolios: Portfolio[];
}

export default function PortfolioShowcase({
  portfolios,
}: PortfolioShowcaseProps) {
  const [activeIndex, setActiveIndex] = useState(0);

  useEffect(() => {
    if (!portfolios || portfolios.length <= 1) return;

    const timer = setInterval(() => {
      setActiveIndex((current) =>
        current === portfolios.length - 1 ? 0 : current + 1,
      );
    }, 5000);

    return () => clearInterval(timer);
  }, [portfolios, activeIndex]);

  if (!portfolios || portfolios.length === 0) return null;

  const activePortfolio = portfolios[activeIndex];

  const imageUrl =
    activePortfolio?.image && typeof activePortfolio.image === "object"
      ? activePortfolio.image.url
      : null;
  const imageAlt =
    activePortfolio?.image && typeof activePortfolio.image === "object"
      ? activePortfolio.image.alt
      : activePortfolio?.clientName;

  return (
    <section className="w-full relative flex flex-col items-center bg-[#7eb2fc]/5 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-8 lg:gap-10 text-[#010101]">
      <div className="flex flex-col items-center gap-4 text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
          PORTOFOLIO
        </div>

        <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] max-w-4xl">
          Rekam Jejak Transformasi Digital Klien Kami
        </h2>

        <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1 max-w-3xl">
          Lihat bagaimana Mirai Softnet & Technology membantu berbagai
          perusahaan terkemuka memecahkan tantangan operasional dan mencapai
          efisiensi maksimal melalui solusi teknologi yang tepat sasaran.
        </p>
      </div>

      <div className="w-full flex flex-col items-center gap-6 lg:gap-8">
        <div
          key={activeIndex}
          className="w-full flex flex-col-reverse lg:flex-row items-stretch bg-[#fdfdfd] shadow-[2px_4px_8px_1px_rgba(0,0,0,0.1)] rounded-mirai overflow-hidden animate-in fade-in zoom-in-[0.98] duration-500"
        >
          <div className="flex-1 flex flex-col items-start justify-center p-5 sm:p-6 lg:p-10 xl:p-[60px] gap-4 lg:gap-5">
            <h3 className="text-[20px] sm:text-[24px] lg:text-[28px] xl:text-[32px] font-bold leading-[125%]">
              {activePortfolio.clientName}
            </h3>

            <p className="text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[18px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/90">
              {activePortfolio.description}
            </p>

            {activePortfolio.achievements &&
              activePortfolio.achievements.length > 0 && (
                <ol className="list-decimal pl-5 flex flex-col gap-1.5 w-full text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[18px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/90">
                  {(activePortfolio.achievements ?? []).map((item, idx) => (
                    <li key={idx} className="pl-1.5">
                      {item.text}
                    </li>
                  ))}
                </ol>
              )}

            {activePortfolio.tags && activePortfolio.tags.length > 0 && (
              <div className="flex flex-wrap items-center gap-2 mt-2">
                {(activePortfolio.tags ?? []).map((tag, idx) => {
                  const isHardware = tag.theme === "hardware";
                  const colorClass = isHardware
                    ? "bg-[#fde4c3]/50 text-[#fa9f29]"
                    : "bg-[#7eb2fc]/25 text-primary";

                  return (
                    <span
                      key={idx}
                      className={`px-[12px] py-[4px] sm:px-[14px] sm:py-[5px] rounded-full text-[12px] sm:text-[14px] font-semibold ${colorClass}`}
                    >
                      {tag.label}
                    </span>
                  );
                })}
              </div>
            )}
          </div>

          <div className="w-full lg:w-[45%] xl:w-[50%] h-[240px] sm:h-[320px] lg:h-auto relative shrink-0">
            {imageUrl ? (
              <Image
                src={imageUrl}
                alt={imageAlt || "Portfolio Image"}
                fill
                quality={100}
                sizes="(max-width: 1024px) 100vw, 50vw"
                className="object-cover"
              />
            ) : (
              <div className="w-full h-full bg-gray-200 flex items-center justify-center text-gray-500">
                Tidak ada gambar
              </div>
            )}
          </div>
        </div>

        <div className="flex items-center gap-2.5 mt-2 lg:mt-4">
          {(portfolios ?? []).map((_, index) => (
            <button
              key={index}
              onClick={() => setActiveIndex(index)}
              aria-label={`Go to slide ${index + 1}`}
              className={`w-3 h-3 sm:w-4 sm:h-4 rounded-full transition-colors duration-300 ${
                activeIndex === index
                  ? "bg-primary"
                  : "bg-[#7eb2fc]/25 hover:bg-primary/50"
              }`}
            />
          ))}
        </div>
      </div>
    </section>
  );
}
