"use client";

import React, { useState } from "react";
import Image from "next/image";
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
    <section className="w-full relative flex flex-col items-center bg-[#fdfdfd] px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 text-[#010101]">
      <div className="flex flex-col items-center gap-4 max-w-[900px] text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
          PRODUK
        </div>

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          Solusi Software Terintegrasi untuk Bisnis Anda
        </h2>

        <p className="text-[16px] leading-[180%] font-medium text-[#010101]/80 mt-1">
          Tingkatkan efisiensi dan skalabilitas operasional perusahaan Anda
          melalui software in-house cerdas kami.{" "}
          <br className="hidden md:block" />
          Dirancang dengan teknologi mutakhir untuk menjawab tantangan spesifik
          di bidang manajemen SDM hingga produksi.
        </p>
      </div>

      <div className="w-full flex flex-col items-center gap-[23px]">
        <div className="flex items-center justify-center flex-wrap gap-3 bg-[#fdfdfd] border border-primary/30 p-1.5 rounded-2xl">
          {products.map((product, index) => {
            const isActive = activeIndex === index;
            return (
              <button
                key={product.id}
                onClick={() => setActiveIndex(index)}
                className={`px-6 py-2.5 rounded-xl font-semibold text-[15px] transition-all duration-300 ${
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

        <div className="w-full flex flex-col lg:flex-row items-stretch gap-5 lg:gap-10 text-left animate-in fade-in zoom-in-95 duration-500">
          <div className="flex-1 flex flex-col items-start gap-6 pt-2 lg:py-6">
            <div className="flex flex-col items-start gap-3">
              {activeProduct.badge && (
                <div className="bg-primary/10 text-primary font-semibold px-[14px] py-[5px] rounded-full text-[14px]">
                  {activeProduct.badge}
                </div>
              )}

              <h3 className="text-[28px] md:text-[34px] font-bold leading-[125%]">
                {activeProduct.headline}
              </h3>

              <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101]/80">
                {activeProduct.description}
              </p>
            </div>

            <div className="flex flex-col gap-5 w-full mt-2">
              {activeProduct.features?.map((feature, idx) => {
                const iconUrl =
                  feature.icon && typeof feature.icon === "object"
                    ? feature.icon.url
                    : null;

                return (
                  <div key={idx} className="flex items-start gap-4 w-full">
                    <div className="w-[48px] h-[48px] shrink-0 bg-primary/10 rounded-xl flex items-center justify-center">
                      {iconUrl ? (
                        <Image
                          src={iconUrl}
                          alt="Fitur Icon"
                          width={24}
                          height={24}
                          className="object-contain"
                          style={{ width: "24px", height: "auto" }}
                        />
                      ) : (
                        <div className="w-6 h-6 bg-gray-300 rounded-full" />
                      )}
                    </div>
                    <div className="flex flex-col gap-1.5 flex-1">
                      <h4 className="font-bold text-[16px] leading-[125%]">
                        {feature.title}
                      </h4>
                      <p className="text-[15px] leading-[160%] font-medium text-[#010101]/80">
                        {feature.description}
                      </p>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>

          <div className="w-full lg:w-[500px] xl:w-[576px] h-auto min-h-[300px] lg:min-h-[480px] bg-gray-50 rounded-2xl overflow-hidden relative shrink-0 flex items-center justify-center p-4">
            {mockupUrl ? (
              <Image
                src={mockupUrl}
                alt={mockupAlt || "Mockup Product"}
                fill
                quality={100}
                sizes="(max-width: 1024px) 100vw, 1200px"
                className="object-cover rounded-xl"
              />
            ) : (
              <div className="text-gray-400 font-medium">
                Gambar Mockup Belum Tersedia
              </div>
            )}
          </div>
        </div>
      </div>

      <div className="flex flex-col items-center gap-4 mt-4 w-full">
        <div className="flex flex-wrap items-center justify-center gap-3">
          <Link
            href={activeProduct?.productUrl || "#"}
            target="_blank"
            className="bg-primary text-[#fdfdfd] font-semibold px-6 py-3 rounded-[10px] hover:bg-brand-600 transition-colors"
          >
            Coba Sekarang
          </Link>

          <Link
            href={activeProduct?.productUrl || "#"}
            target="_blank"
            className="flex items-center gap-2 bg-[#fdfdfd] text-primary border-[1.5px] border-primary font-semibold px-6 py-3 rounded-[10px] hover:bg-brand-100 transition-colors"
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
    </section>
  );
}
