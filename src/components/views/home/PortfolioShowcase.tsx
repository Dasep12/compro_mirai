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
  const [activePage, setActivePage] = useState(0);
  // Tablet ke atas (md, 768px) tampilkan 2 kartu sekaligus; di bawah itu (mobile) 1 kartu.
  const [itemsPerPage, setItemsPerPage] = useState(1);

  useEffect(() => {
    const mql = window.matchMedia("(min-width: 768px)");
    const applyItemsPerPage = () => setItemsPerPage(mql.matches ? 2 : 1);

    applyItemsPerPage();
    mql.addEventListener("change", applyItemsPerPage);
    return () => mql.removeEventListener("change", applyItemsPerPage);
  }, []);

  const totalPages = portfolios
    ? Math.max(1, Math.ceil(portfolios.length / itemsPerPage))
    : 0;

  // Jaga index halaman tetap valid secara langsung saat render tanpa butuh useEffect
  // (menghindari cascading re-renders dan flash data kosong).
  const safeActivePage = totalPages > 0 ? Math.min(activePage, totalPages - 1) : 0;

  useEffect(() => {
    if (totalPages <= 1) return;

    const timer = setInterval(() => {
      setActivePage((current) => {
        const safeCurrent = Math.min(current, totalPages - 1);
        return safeCurrent >= totalPages - 1 ? 0 : safeCurrent + 1;
      });
    }, 10000);

    return () => clearInterval(timer);
  }, [totalPages, safeActivePage]);

  if (!portfolios || portfolios.length === 0) return null;

  const pageItems = portfolios.slice(
    safeActivePage * itemsPerPage,
    safeActivePage * itemsPerPage + itemsPerPage,
  );

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
        <div className="w-full grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8">
          {pageItems.map((portfolio) => {
            const imageUrl =
              portfolio.image && typeof portfolio.image === "object"
                ? portfolio.image.url
                : null;
            const imageAlt =
              portfolio.image && typeof portfolio.image === "object"
                ? portfolio.image.alt
                : portfolio.clientName;

            return (
              <div
                key={portfolio.id}
                className="w-full flex flex-col bg-[#fdfdfd] shadow-[2px_4px_8px_1px_rgba(0,0,0,0.1)] rounded-mirai overflow-hidden animate-in fade-in zoom-in-[0.98] duration-500"
              >
                <div className="w-full aspect-[4/3] sm:aspect-video relative shrink-0">
                  {imageUrl ? (
                    <Image
                      src={imageUrl}
                      alt={imageAlt || "Portfolio Image"}
                      fill
                      quality={85}
                      sizes="(max-width: 768px) 100vw, 50vw"
                      className="object-cover"
                    />
                  ) : (
                    <div className="w-full h-full bg-gray-200 flex items-center justify-center text-gray-500">
                      Tidak ada gambar
                    </div>
                  )}
                </div>

                <div className="flex flex-col items-start p-5 sm:p-6 lg:p-8 gap-4 lg:gap-5">
                  <h3 className="text-[20px] sm:text-[24px] lg:text-[26px] font-bold leading-[125%] shrink-0 line-clamp-2 text-ellipsis">
                    {portfolio.clientName}
                  </h3>

                  <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/90 line-clamp-3 sm:line-clamp-4 text-ellipsis">
                    {portfolio.description}
                  </p>

                  {portfolio.achievements && portfolio.achievements.length > 0 && (
                    <ol className="list-decimal pl-5 flex flex-col gap-1.5 w-full text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/90">
                      {(portfolio.achievements ?? []).map((item, idx) => (
                        <li key={idx} className="pl-1.5 line-clamp-2 text-ellipsis">
                          {item.text}
                        </li>
                      ))}
                    </ol>
                  )}

                  {portfolio.tags && portfolio.tags.length > 0 && (
                    <div className="flex flex-wrap items-center gap-2 mt-2 shrink-0">
                      {(portfolio.tags ?? []).map((tag, idx) => {
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
              </div>
            );
          })}
        </div>

        {totalPages > 1 && (
          <div className="flex items-center gap-2.5 mt-2 lg:mt-4">
            {Array.from({ length: totalPages }).map((_, index) => (
              <button
                key={index}
                onClick={() => setActivePage(index)}
                aria-label={`Go to slide ${index + 1}`}
                className={`w-3 h-3 sm:w-4 sm:h-4 rounded-full transition-colors duration-300 ${
                  safeActivePage === index
                    ? "bg-primary"
                    : "bg-[#7eb2fc]/25 hover:bg-primary/50"
                }`}
              />
            ))}
          </div>
        )}
      </div>
    </section>
  );
}
