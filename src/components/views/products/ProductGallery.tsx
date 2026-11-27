"use client";

import React, { useEffect, useState } from "react";
import Image from "@/components/ui/Image";
import SectionLabel from "@/components/ui/SectionLabel";
import { Product } from "../../../../payload-types";
import { Maximize2, X } from "lucide-react";

interface ProductGalleryProps {
  product: Product;
}

export default function ProductGallery({ product }: ProductGalleryProps) {
  const [activeIndex, setActiveIndex] = useState(0);
  const [selectedImage, setSelectedImage] = useState<string | null>(null);
  const galleryItems = (product.gallery ?? [])
    .map((item, index) => {
      const image =
        item.galleryImage && typeof item.galleryImage === "object"
          ? item.galleryImage
          : null;

      return image?.url
        ? {
            id: item.id || index,
            url: image.url,
            alt: image.alt || item.caption || `${product.name} interface`,
            caption: item.caption,
          }
        : null;
    })
    .filter((item) => item !== null);
  const activeItem = galleryItems[activeIndex];

  useEffect(() => {
    if (!selectedImage) return;

    const previousOverflow = document.body.style.overflow;
    const closeOnEscape = (event: KeyboardEvent) => {
      if (event.key === "Escape") setSelectedImage(null);
    };

    document.body.style.overflow = "hidden";
    window.addEventListener("keydown", closeOnEscape);

    return () => {
      document.body.style.overflow = previousOverflow;
      window.removeEventListener("keydown", closeOnEscape);
    };
  }, [selectedImage]);

  if (galleryItems.length === 0 || !activeItem) return null;

  return (
    <>
      <section className="w-full bg-[#f7f7f7] px-4 py-12 text-[#010101] sm:px-8 sm:py-16 lg:px-[120px] lg:py-20 2xl:px-[calc(50vw-600px)]">
        <div className="mx-auto max-w-[1200px]">
          <div className="mb-8 flex flex-col gap-4 sm:mb-10 lg:flex-row lg:items-end lg:justify-between">
            <div className="flex max-w-[720px] flex-col items-start gap-4">
              <SectionLabel>Tampilan Produk</SectionLabel>
              <h2 className="text-[30px] font-bold leading-[125%] sm:text-[38px] lg:text-[46px]">
                Antarmuka {product.name}
              </h2>
            </div>
            <p className="max-w-[360px] text-[14px] leading-[165%] text-[#010101]/65 sm:text-[15px] lg:pb-2">
              Lihat tampilan produk lebih dekat.
            </p>
          </div>

          <div className="grid gap-4 lg:grid-cols-[1.7fr_0.8fr]">
            <button
              type="button"
              onClick={() => setSelectedImage(activeItem.url)}
              aria-label={`Perbesar gambar ${activeItem.alt}`}
              className="group relative aspect-[16/10] w-full overflow-hidden rounded-[24px] border border-black/5 bg-white text-left focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-primary sm:rounded-[32px]"
            >
              <Image
                src={activeItem.url}
                alt={activeItem.alt}
                fill
                sizes="(max-width: 1024px) 100vw, 70vw"
                className="object-contain p-2 transition-transform duration-500 group-hover:scale-[1.02] sm:p-4"
              />
              <span className="absolute bottom-4 right-4 inline-flex h-10 w-10 items-center justify-center rounded-full bg-primary text-white shadow-lg transition-transform group-hover:scale-105 sm:bottom-5 sm:right-5">
                <Maximize2 aria-hidden="true" className="h-4 w-4" />
              </span>
              {activeItem.caption && (
                <span className="absolute bottom-4 left-4 max-w-[calc(100%-5rem)] rounded-full bg-[#010101]/75 px-4 py-2 text-left text-[12px] font-medium text-white sm:bottom-5 sm:left-5 sm:text-[13px]">
                  {activeItem.caption}
                </span>
              )}
            </button>

            {galleryItems.length > 1 && (
              <div
                aria-label="Pilih tampilan produk"
                className="flex gap-3 overflow-x-auto pb-2 lg:max-h-[520px] lg:flex-col lg:overflow-y-auto lg:overflow-x-hidden lg:pb-0"
              >
                {galleryItems.map((item, index) => (
                  <button
                    key={item.id}
                    type="button"
                    onClick={() => setActiveIndex(index)}
                    aria-pressed={activeIndex === index}
                    className={`flex w-[240px] shrink-0 items-center gap-3 rounded-2xl border p-2 text-left transition-colors focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary sm:w-[280px] lg:w-full ${
                      activeIndex === index
                        ? "border-primary bg-white"
                        : "border-black/5 bg-white/60 hover:border-primary/40"
                    }`}
                  >
                    <span className="relative h-[70px] w-[100px] shrink-0 overflow-hidden rounded-xl bg-brand-100/10 sm:h-[76px] sm:w-[112px]">
                      <Image
                        src={item.url}
                        alt=""
                        fill
                        sizes="112px"
                        className="object-cover"
                      />
                    </span>
                    <span className="min-w-0">
                      <span className="block text-[11px] font-semibold uppercase tracking-[0.12em] text-primary">
                        Tampilan {String(index + 1).padStart(2, "0")}
                      </span>
                      <span className="mt-1 line-clamp-2 block text-[13px] font-semibold leading-[140%] text-[#010101] sm:text-[14px]">
                        {item.caption || item.alt}
                      </span>
                    </span>
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>
      </section>

      {selectedImage && (
        <div
          className="fixed inset-0 z-[100] flex items-center justify-center bg-black/95 p-4 sm:p-8"
          role="dialog"
          aria-modal="true"
          aria-label={`Tampilan ${product.name}`}
        >
          <button
            type="button"
            onClick={() => setSelectedImage(null)}
            aria-label="Tutup gambar"
            className="absolute right-4 top-4 z-[101] rounded-full bg-white/10 p-3 text-white transition-colors hover:bg-white/25 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white sm:right-8 sm:top-8"
          >
            <X aria-hidden="true" className="h-6 w-6" />
          </button>
          <div className="relative h-full max-h-[85vh] w-full max-w-[1200px] overflow-hidden rounded-lg">
            <Image
              src={selectedImage}
              alt={activeItem.alt}
              fill
              className="object-contain"
            />
          </div>
        </div>
      )}
    </>
  );
}
