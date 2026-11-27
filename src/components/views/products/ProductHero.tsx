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
    <section className="relative isolate w-full overflow-hidden bg-[#f7f7f7] px-4 py-12 text-[#010101] sm:px-8 sm:py-16 lg:px-[120px] lg:py-20 2xl:px-[calc(50vw-600px)]">
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -right-36 -top-40 h-[420px] w-[420px] rounded-full border border-primary/10 sm:h-[560px] sm:w-[560px]"
      />
      <div className="relative mx-auto grid max-w-[1200px] items-center gap-10 lg:grid-cols-[0.9fr_1.1fr] lg:gap-14">
        <div className="flex flex-col items-start gap-5">
          {product.badge && (
            <div className="flex items-center gap-3">
              <span className="h-[2px] w-8 bg-primary" />
              <span className="text-[13px] font-semibold uppercase tracking-[0.14em] text-primary sm:text-[14px]">
                {product.badge}
              </span>
            </div>
          )}

          <h1 className="max-w-[620px] text-[32px] font-bold leading-[120%] sm:text-[40px] lg:text-[50px] xl:text-[56px]">
            {product.headline}
          </h1>

          <p className="max-w-[560px] text-[15px] leading-[170%] text-[#010101]/75 sm:text-[16px] lg:text-[18px]">
            {product.description}
          </p>

          {product.showCTA !== false && product.productUrl && (
            <Link
              href={product.productUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="mt-2 inline-flex items-center gap-3 rounded-mirai bg-primary px-6 py-3 font-semibold text-[#fdfdfd] transition-colors hover:bg-brand-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary"
            >
              <span>{product.ctaText || "Kunjungi Website"}</span>
              <svg
                aria-hidden="true"
                className="h-4 w-4"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M7 17 17 7M7 7h10v10"
                />
              </svg>
            </Link>
          )}
        </div>

        <div className="relative mt-4 flex h-[300px] w-full flex-1 shrink-0 items-center justify-center sm:h-[400px] lg:mt-0 lg:h-[450px] lg:justify-end xl:h-[600px]">
          {imageUrl ? (
            <Image
              src={imageUrl}
              alt={imageAlt || "Hero Illustration"}
              fill
              priority
              quality={85}
              sizes="(max-width: 1024px) 100vw, 50vw"
              className="object-cover"
            />
          ) : (
            <div className="flex h-full w-full items-center justify-center rounded-2xl bg-gray-100 font-medium text-gray-400">
              Belum ada gambar Hero
            </div>
          )}
        </div>
      </div>
    </section>
  );
}
