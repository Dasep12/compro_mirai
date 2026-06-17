"use client";

import React, { useState } from "react";
import Image from "@/components/ui/Image";
import Link from "next/link";
import { Product } from "../../../../payload-types";

interface ProductShowcaseProps {
  products: Product[];
}

export default function ProductShowcase({ products }: ProductShowcaseProps) {
  const [activeIndex, setActiveIndex] = useState(0);

  if (!products || products.length === 0) return null;

  const activeProduct = products[activeIndex];

  const mockupUrl =
    activeProduct?.image && typeof activeProduct.image === "object"
      ? activeProduct.image.url
      : null;
  const mockupAlt =
    activeProduct?.image && typeof activeProduct.image === "object"
      ? activeProduct.image.alt
      : activeProduct?.name;

  return (
    <section className="w-full relative flex flex-col items-center bg-[#fdfdfd] px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 md:py-[50px] gap-8 md:gap-10 text-[#010101]">
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
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[180%] 2xl:leading-[140%] tracking-wide uppercase">
          PRODUK
        </div>

        <h2 className="text-[28px] sm:text-[32px] md:text-[46px] font-bold leading-[125%]">
          Solusi Software Terintegrasi untuk Bisnis Anda
        </h2>

        <p className="text-[14px] sm:text-[15px] md:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1">
          Tingkatkan efisiensi dan skalabilitas operasional perusahaan Anda
          melalui software in-house cerdas kami.{" "}
          <br className="hidden md:block" />
          Dirancang dengan teknologi mutakhir untuk menjawab tantangan spesifik
          di bidang manajemen SDM hingga produksi.
        </p>
      </div>

      <div className="w-full flex flex-col items-center gap-[23px]">
        <div className="w-full flex items-center justify-start md:justify-center overflow-x-auto hide-scrollbar snap-x snap-mandatory">
          <div className="flex items-center justify-start flex-nowrap md:flex-wrap gap-2 sm:gap-3 bg-[#fdfdfd] border border-primary/30 p-1.5 rounded-2xl shrink-0 min-w-min">
            {(products ?? []).map((product, index) => {
              const isActive = activeIndex === index;
              return (
                <button
                  key={product.id}
                  onClick={() => setActiveIndex(index)}
                  className={`px-5 sm:px-6 py-2 sm:py-2.5 rounded-xl font-semibold text-[14px] sm:text-[15px] transition-all duration-300 shrink-0 snap-start whitespace-nowrap cursor-pointer ${
                    isActive
                      ? "bg-primary text-[#fdfdfd] shadow-sm"
                      : "bg-transparent text-[#010101] hover:bg-gray-100"
                  }`}
                >
                  {product.name}
                </button>
              );
            })}
          </div>
        </div>

        <div className="w-full flex flex-col xl:flex-row items-stretch gap-8 xl:gap-10 text-left animate-in fade-in zoom-in-95 duration-500 mt-2 xl:mt-0">
          <div className="w-full xl:w-[480px] 2xl:w-[576px] h-[250px] sm:h-[350px] md:h-[400px] xl:h-auto min-h-[250px] lg:min-h-[380px] xl:min-h-[480px] bg-gray-50 rounded-2xl overflow-hidden relative shrink-0 flex items-center justify-center p-4">
            {mockupUrl ? (
              <Image
                key={`mockup-${activeProduct.id}`}
                src={mockupUrl}
                alt={mockupAlt || "Mockup Product"}
                fill
                priority 
                quality={100} 
                sizes="(max-width: 768px) 100vw, 50vw"
                className="object-cover rounded-xl"
              />
            ) : (
              <div className="text-gray-400 font-medium">
                Gambar Mockup Belum Tersedia
              </div>
            )}
          </div>

          <div className="flex-1 flex flex-col items-start gap-6 pt-2 xl:py-6">
            <div className="flex flex-col items-start gap-3">
              {activeProduct.badge && (
                <div className="bg-primary/10 text-primary font-semibold px-[14px] py-[5px] rounded-full text-[13px] md:text-[14px]">
                  {activeProduct.badge}
                </div>
              )}

              <h3 className="text-[24px] sm:text-[28px] md:text-[34px] font-bold leading-[125%]">
                {activeProduct.headline}
              </h3>

              <p className="text-[14px] md:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80">
                {activeProduct.description}
              </p>
            </div>

            <div className="flex flex-col gap-5 w-full mt-2">
              {(activeProduct.features ?? []).map((feature, idx) => {
                const iconUrl =
                  feature.icon && typeof feature.icon === "object"
                    ? feature.icon.url
                    : null;

                return (
                  <div key={idx} className="flex items-start gap-4 w-full">
                    <div className="w-[40px] h-[40px] md:w-[48px] md:h-[48px] shrink-0 bg-primary/10 rounded-xl flex items-center justify-center">
                      {iconUrl ? (
                        <Image
                          src={iconUrl}
                          alt="Fitur Icon"
                          width={32}
                          height={32}
                          className="object-contain w-6 h-6 md:w-8 md:h-8"
                        />
                      ) : (
                        <div className="w-5 h-5 md:w-6 md:h-6 bg-gray-300 rounded-full" />
                      )}
                    </div>
                    <div className="flex flex-col gap-1 md:gap-1.5 flex-1">
                      <h4 className="font-bold text-[15px] md:text-[16px] leading-[125%]">
                        {feature.title}
                      </h4>
                      <p className="text-[14px] md:text-[15px] leading-[160%] font-medium text-[#010101]/80">
                        {feature.description}
                      </p>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>

      <div className="flex flex-col items-center gap-4 mt-2 md:mt-4 w-full">
        <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-center gap-3 w-full sm:w-auto">
          <Link
            href={activeProduct?.productUrl || "#"}
            target="_blank"
            className="bg-primary text-[#fdfdfd] font-semibold px-6 py-3 rounded-[10px] hover:bg-brand-600 transition-colors text-center text-[14px] sm:text-[15px]"
          >
            Coba Sekarang
          </Link>

          <Link
            href={`/products/${activeProduct.slug}`}
            className="flex items-center justify-center gap-2 bg-[#fdfdfd] text-primary border-[1.5px] border-primary font-semibold px-6 py-3 rounded-[10px] hover:bg-brand-100 transition-colors text-center text-[14px] sm:text-[15px]"
          >
            <span>Lebih Detail</span>
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
    </section>
  );
}
