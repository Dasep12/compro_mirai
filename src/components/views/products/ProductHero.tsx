"use client";

import Image from "@/components/ui/Image";
import Link from "next/link";
import { Product } from "../../../../payload-types";

interface ProductHeroProps {
  product: Product;
}

export default function ProductHero({ product }: ProductHeroProps) {
  const imageUrl =
    product.image && typeof product.image === "object"
      ? product.image.url
      : null;
  const imageAlt =
    product.image && typeof product.image === "object"
      ? product.image.alt
      : product.name;

  return (
    <section className="w-full relative flex flex-col lg:flex-row items-center justify-between px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-[50px] gap-10 lg:gap-8 bg-[#fdfdfd] text-[#010101]">
      <style
        dangerouslySetInnerHTML={{
          __html: `
            @keyframes levitate {
              0%, 100% { transform: translateY(0); }
              50% { transform: translateY(-15px); }
            }
            .animate-levitate {
              animation: levitate 4s ease-in-out infinite;
            }
          `,
        }}
      />
      <div className="flex flex-col items-start gap-4 sm:gap-5 w-full flex-1 lg:max-w-[500px] xl:max-w-[629px] shrink-0 z-10">
        {product.badge && (
          <div className="bg-brand-100/25 text-primary rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-semibold leading-[120%] tracking-wide uppercase">
            {product.badge}
          </div>
        )}
        
        <h1 className="text-[28px] sm:text-[36px] lg:text-[40px] xl:text-[48px] font-bold leading-[130%] sm:leading-[140%] text-left">
          {product.headline}
        </h1>
        
        <p className="text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[18px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/90">
          {product.description}
        </p>

        <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 sm:gap-4 mt-2 w-full sm:w-auto">
          <Link
            href={product.productUrl || "#"}
            target="_blank"
            className="bg-primary text-[#fdfdfd] font-semibold px-6 py-3 rounded-mirai hover:bg-brand-600 transition-colors no-underline flex items-center justify-center w-full sm:w-auto text-center"
          >
            <span>{product.ctaText || "Kunjungi Website"}</span>
          </Link>
        </div>
      </div>

      <div className="w-full flex-1 relative flex items-center justify-center lg:justify-end mt-4 lg:mt-0 h-[300px] sm:h-[400px] lg:h-[450px] xl:h-[600px] shrink-0">
        {imageUrl ? (
          <Image
            src={imageUrl}
            alt={imageAlt || "Hero Illustration"}
            fill
            priority
            quality={100}
            sizes="(max-width: 1024px) 100vw, 50vw"
            className="object-cover"
          />
        ) : (
          <div className="w-full h-full bg-gray-100 rounded-2xl flex items-center justify-center text-gray-400 font-medium">
            Belum ada gambar Hero
          </div>
        )}
      </div>
    </section>
  );
}
