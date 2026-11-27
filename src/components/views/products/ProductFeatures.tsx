"use client";

import React from "react";
import Image from "@/components/ui/Image";
import SectionLabel from "@/components/ui/SectionLabel";
import { Product } from "../../../../payload-types";

interface ProductFeaturesProps {
  product: Product;
}

type ProductFeature = NonNullable<Product["features"]>[number];

function FeatureImage({
  feature,
  className,
  sizes,
}: {
  feature: ProductFeature;
  className: string;
  sizes: string;
}) {
  const image =
    feature.picture && typeof feature.picture === "object"
      ? feature.picture
      : null;

  return (
    <div className={`relative overflow-hidden bg-brand-100/10 ${className}`}>
      {image?.url ? (
        <Image
          src={image.url}
          alt={image.alt || feature.title}
          fill
          sizes={sizes}
          className="object-cover transition-transform duration-700 group-hover:scale-[1.03]"
        />
      ) : (
        <div className="flex h-full min-h-[180px] items-center justify-center text-sm font-medium text-[#010101]/40 lg:min-h-0">
          Gambar fitur belum tersedia
        </div>
      )}
    </div>
  );
}

export default function ProductFeatures({ product }: ProductFeaturesProps) {
  const features = product.features ?? [];
  if (features.length === 0) return null;

  const [mainFeature, ...remainingFeatures] = features;
  const secondaryFeatures = remainingFeatures.slice(0, 2);
  const additionalFeatures = remainingFeatures.slice(2);

  return (
    <section className="w-full bg-[#fdfdfd] px-4 py-12 text-[#010101] sm:px-8 sm:py-16 lg:px-[120px] lg:py-20 2xl:px-[calc(50vw-600px)]">
      <div className="mx-auto flex max-w-[1200px] flex-col gap-8 lg:gap-10">
        <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
          <div className="flex max-w-[720px] flex-col items-start gap-4">
            <SectionLabel>Fitur Unggulan</SectionLabel>
            <h2 className="text-[30px] font-bold leading-[125%] sm:text-[38px] lg:text-[46px]">
              Kemampuan {product.name}
            </h2>
          </div>
          <p className="max-w-[360px] text-[14px] leading-[165%] text-[#010101]/65 sm:text-[15px] lg:pb-2">
            Jelajahi fitur utama yang tersedia dalam produk.
          </p>
        </div>

        <div
          className={`grid gap-4 ${
            secondaryFeatures.length > 0
              ? "lg:grid-cols-[1.05fr_0.95fr]"
              : ""
          }`}
        >
          <article className="group overflow-hidden rounded-[24px] border border-black/5 bg-brand-100/10">
            <FeatureImage
              feature={mainFeature}
              className="h-[210px] sm:h-[260px] lg:h-[280px]"
              sizes="(max-width: 1024px) 100vw, 600px"
            />
            <div className="p-5 sm:p-7">
              <h3 className="text-[24px] font-bold leading-[130%] sm:text-[30px]">
                {mainFeature.title}
              </h3>
              <p className="mt-2 text-[14px] leading-[170%] text-[#010101]/70 sm:text-[15px]">
                {mainFeature.description}
              </p>
            </div>
          </article>

          {secondaryFeatures.length > 0 && (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-1">
              {secondaryFeatures.map((feature, index) => (
                <article
                  key={feature.id || index}
                  className="group flex min-h-[190px] overflow-hidden rounded-[24px] border border-black/5 bg-[#f7f7f7]"
                >
                  <FeatureImage
                    feature={feature}
                    className="min-h-[190px] w-[34%] shrink-0 self-stretch"
                    sizes="(max-width: 1024px) 34vw, 220px"
                  />
                  <div className="flex min-w-0 flex-1 flex-col justify-center p-4 sm:p-5">
                    <h3 className="text-[17px] font-bold leading-[130%] sm:text-[19px]">
                      {feature.title}
                    </h3>
                    <p className="mt-2 text-[13px] leading-[160%] text-[#010101]/70 sm:text-[14px]">
                      {feature.description}
                    </p>
                  </div>
                </article>
              ))}
            </div>
          )}
        </div>

        {additionalFeatures.length > 0 && (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {additionalFeatures.map((feature, index) => (
              <article
                key={feature.id || index}
                className="group overflow-hidden rounded-[24px] border border-black/5 bg-[#f7f7f7]"
              >
                <FeatureImage
                  feature={feature}
                  className="aspect-[16/10]"
                  sizes="(max-width: 640px) 100vw, 33vw"
                />
                <div className="min-h-[190px] p-5 sm:p-7">
                  <h3 className="text-[19px] font-bold leading-[130%] sm:text-[21px]">
                    {feature.title}
                  </h3>
                  <p className="mt-2 text-[14px] leading-[170%] text-[#010101]/70 sm:text-[15px]">
                    {feature.description}
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
