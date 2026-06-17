"use client";

import React from "react";
import { Product } from "../../../../payload-types";
import { CheckCircle2 } from "lucide-react";

interface ProductBenefitsProps {
  product: Product;
}

export default function ProductBenefits({ product }: ProductBenefitsProps) {
  if (!product.benefits || product.benefits.length === 0) return null;

  return (
    <section className="w-full relative overflow-hidden flex flex-col items-center px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-8 lg:gap-10 text-[#010101]">
      <div className="flex flex-col lg:flex-row gap-16 lg:gap-24 items-center lg:items-start">
        
        <div className="w-full lg:w-1/3 flex flex-col gap-6 items-center lg:items-start">
          <div className="bg-primary w-fit text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
            Nilai Bisnis
          </div>
          <h2 className="text-[32px] sm:text-[40px] font-bold leading-[120%] text-[#010101]">
            {product.benefitTitle ?? ""}
          </h2>
          <p className="text-[16px] text-[#010101]/70 leading-relaxed text-center lg:text-left">
            {product.benefitDescription ?? ""}
          </p>
        </div>

        <div className="w-full lg:w-2/3 flex flex-col gap-6 lg:gap-8">
          {product.benefits.map((benefit, idx) => (
            <div
              key={benefit.id || idx}
              className="flex gap-4 sm:gap-6 p-6 sm:p-8 rounded-[24px] bg-brand-100/10 border border-black/5 hover:border-primary hover:bg-brand-100/20 transition-colors"
            >
              <div className="shrink-0 mt-1">
                <CheckCircle2 className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />
              </div>
              <div className="flex flex-col gap-2">
                <h3 className="text-[18px] sm:text-[22px] font-bold text-[#010101]">
                  {benefit.title}
                </h3>
                <p className="text-[15px] sm:text-[16px] text-[#010101]/70 leading-[160%]">
                  {benefit.description}
                </p>
              </div>
            </div>
          ))}
        </div>
        
      </div>
    </section>
  );
}
