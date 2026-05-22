"use client";

import { useState, useEffect } from "react";
import Image from "next/image";
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
    <section className="w-full relative flex flex-col items-center bg-[#7eb2fc]/5 px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 text-[#010101]">
      <div className="flex flex-col items-center gap-4 text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
          PORTOFOLIO
        </div>

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          Rekam Jejak Transformasi Digital Klien Kami
        </h2>

        <p className="text-[16px] leading-[180%] font-medium text-[#010101]/80 mt-1">
          Lihat bagaimana Mirai Softnet & Technology membantu berbagai
          perusahaan terkemuka memecahkan tantangan operasional dan mencapai
          efisiensi maksimal melalui solusi teknologi yang tepat sasaran.
        </p>
      </div>

      <div className="w-full flex flex-col items-center gap-[22px]">
        <div
          key={activeIndex}
          className="w-full flex flex-col-reverse lg:flex-row items-stretch bg-[#fdfdfd] shadow-[2px_4px_8px_1px_rgba(0,0,0,0.1)] rounded-mirai overflow-hidden animate-in fade-in zoom-in-[0.98] duration-500"
        >
          <div className="flex-1 flex flex-col items-start justify-center p-6 lg:p-10 xl:p-[60px] gap-5">
            <h3 className="text-[28px] md:text-[32px] font-bold leading-[125%]">
              {activePortfolio.clientName}
            </h3>

            <p className="text-[16px] md:text-[18px] leading-[180%] font-medium text-[#010101]/90">
              {activePortfolio.description}
            </p>

            {activePortfolio.achievements &&
              activePortfolio.achievements.length > 0 && (
                <ol className="list-decimal pl-5 flex flex-col gap-1.5 w-full text-[16px] md:text-[18px] leading-[180%] font-medium text-[#010101]/90">
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
                      className={`px-[14px] py-[5px] rounded-full text-[14px] font-semibold ${colorClass}`}
                    >
                      {tag.label}
                    </span>
                  );
                })}
              </div>
            )}
          </div>

          <div className="w-full lg:w-[45%] xl:w-[50%] h-[300px] lg:h-auto relative shrink-0">
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

        <div className="flex items-center gap-2.5 mt-2">
          {(portfolios ?? []).map((_, index) => (
            <button
              key={index}
              onClick={() => setActiveIndex(index)}
              aria-label={`Go to slide ${index + 1}`}
              className={`w-4 h-4 rounded-full transition-colors duration-300 ${
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
