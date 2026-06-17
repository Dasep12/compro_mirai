"use client";

import React, { useState, useEffect } from "react";
import Image from "@/components/ui/Image";
import { Product } from "../../../../payload-types";
import { Maximize2, X } from "lucide-react";

interface ProductGalleryProps {
  product: Product;
}

export default function ProductGallery({ product }: ProductGalleryProps) {
  const [selectedImage, setSelectedImage] = useState<string | null>(null);

  // Lock scroll when modal is open
  useEffect(() => {
    if (selectedImage) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "auto";
    }
    return () => {
      document.body.style.overflow = "auto";
    };
  }, [selectedImage]);

  if (!product.gallery || product.gallery.length === 0) return null;

  return (
    <>
      <section className="w-full bg-[#111111] py-20 lg:py-28 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] overflow-hidden">
        <div className="flex flex-col items-center text-center gap-4 mb-16">
          <h2 className="text-[32px] sm:text-[40px] font-bold leading-[125%] text-white">
            Antarmuka Pengguna
          </h2>
          <p className="text-[16px] sm:text-[18px] text-white/70 max-w-2xl">
            Intip kemudahan penggunaan dan desain modern yang kami hadirkan di dalam {product.name}.
          </p>
        </div>

        <div className="flex overflow-x-auto gap-6 pb-8 snap-x snap-mandatory hide-scrollbar">
          {product.gallery.map((item, idx) => {
            const imageUrl =
              item.galleryImage && typeof item.galleryImage === "object"
                ? item.galleryImage.url
                : null;
            if (!imageUrl) return null;

            return (
              <div
                key={item.id || idx}
                className="group relative shrink-0 w-[280px] sm:w-[400px] lg:w-[600px] aspect-[16/10] rounded-[16px] overflow-hidden bg-white/5 border border-white/10 snap-center cursor-pointer"
                onClick={() => setSelectedImage(imageUrl)}
              >
                <Image
                  src={imageUrl}
                  alt={item.caption || `Screenshot ${idx + 1}`}
                  fill
                  className="object-cover transition-transform duration-700 group-hover:scale-105"
                />
                <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                  <Maximize2 className="w-8 h-8 text-white" />
                </div>
                {item.caption && (
                  <div className="absolute bottom-0 left-0 right-0 p-4 bg-gradient-to-t from-black/80 to-transparent">
                    <p className="text-white text-sm font-medium">{item.caption}</p>
                  </div>
                )}
              </div>
            );
          })}
        </div>
        <style dangerouslySetInnerHTML={{ __html: `
          .hide-scrollbar::-webkit-scrollbar { display: none; }
          .hide-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        `}} />
      </section>

      {/* Lightbox Modal */}
      {selectedImage && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/95 p-4 sm:p-8">
          <button
            onClick={() => setSelectedImage(null)}
            className="absolute top-4 right-4 sm:top-8 sm:right-8 p-3 rounded-full bg-white/10 text-white hover:bg-white/25 transition-colors z-[101]"
          >
            <X className="w-6 h-6" />
          </button>
          <div className="relative w-full max-w-[1200px] h-full max-h-[85vh] rounded-lg overflow-hidden flex items-center justify-center">
            <Image
              src={selectedImage}
              alt="Fullscreen screenshot"
              fill
              className="object-contain"
            />
          </div>
        </div>
      )}
    </>
  );
}
