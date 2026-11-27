"use client";

import React from "react";
import { Product } from "../../../../payload-types";
import SectionLabel from "@/components/ui/SectionLabel";

interface ProductBenefitsProps {
  product: Product;
}

export default function ProductBenefits({ product }: ProductBenefitsProps) {
  if (!product.benefits || product.benefits.length === 0) return null;

  const [featuredBenefit, ...supportingBenefits] = product.benefits;

  return (
    <section className="relative w-full overflow-hidden bg-[#f7f7f7] px-4 py-12 text-[#010101] sm:px-8 sm:py-16 lg:px-[120px] lg:py-20 2xl:px-[calc(50vw-600px)]">
      <div className="mx-auto flex max-w-[1200px] flex-col gap-8 lg:gap-10">
        <div className="grid gap-8 lg:grid-cols-[0.85fr_1.15fr] lg:items-stretch lg:gap-12">
          <header className="flex flex-col items-start justify-center gap-5 py-2 lg:py-8">
            <SectionLabel>Nilai Bisnis</SectionLabel>
            <h2 className="max-w-[540px] text-[32px] font-bold leading-[120%] sm:text-[40px] lg:text-[48px]">
              {product.benefitTitle ?? ""}
            </h2>
            {product.benefitDescription && (
              <p className="max-w-[520px] text-[15px] leading-[170%] text-[#010101]/70 sm:text-[16px]">
                {product.benefitDescription}
              </p>
            )}
          </header>

          <article className="relative flex min-h-[320px] overflow-hidden rounded-[28px] bg-primary p-6 text-[#fdfdfd] sm:min-h-[360px] sm:p-9 lg:p-10">
            <div
              aria-hidden="true"
              className="pointer-events-none absolute -right-16 -top-28 h-[340px] w-[340px] rounded-full border border-white/20 sm:-right-8 sm:-top-32 sm:h-[420px] sm:w-[420px]"
            >
              <div className="absolute inset-8 rounded-full border border-white/20">
                <div className="absolute inset-8 rounded-full border border-white/20" />
              </div>
              <span className="absolute bottom-14 left-14 h-3 w-3 rounded-full bg-white/80" />
              <span className="absolute right-16 top-20 h-2 w-2 rounded-full bg-white/60" />
            </div>

            <div className="relative z-10 flex w-full flex-col justify-end gap-10">
              <div className="max-w-[560px]">
                <h3 className="text-[25px] font-bold leading-[125%] sm:text-[32px] lg:text-[36px]">
                  {featuredBenefit.title}
                </h3>
                <p className="mt-3 text-[14px] leading-[170%] text-white/85 sm:text-[16px]">
                  {featuredBenefit.description}
                </p>
              </div>
            </div>
          </article>
        </div>

        {supportingBenefits.length > 0 && (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {supportingBenefits.map((benefit, index) => (
              <article
                key={benefit.id || index}
                className="group relative flex min-h-[210px] flex-col justify-between overflow-hidden rounded-[24px] border border-black/5 bg-[#fdfdfd] p-6 transition-colors duration-300 hover:border-primary/40 sm:p-7"
              >
                <div>
                  <h3 className="text-[18px] font-bold leading-[135%] sm:text-[20px]">
                    {benefit.title}
                  </h3>
                  <p className="mt-2 text-[14px] leading-[165%] text-[#010101]/70 sm:text-[15px]">
                    {benefit.description}
                  </p>
                </div>
              </article>
            ))}
          </div>
        )}
      </div>
    </section>
  );
}
