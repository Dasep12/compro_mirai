/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import NextImage, { ImageProps } from "next/image";
import { useState } from "react";

const loadedImageUrls = new Set<string>();

export default function Image({ className = "", onLoad, onError, alt, src, ...props }: ImageProps) {
  const srcString = typeof src === "string" ? src : (src as any)?.src || "";
  
  const [isLoading, setIsLoading] = useState(() => !loadedImageUrls.has(srcString));
  const [isError, setIsError] = useState(false);

  const baseWrapper = "overflow-hidden flex items-center justify-center rounded-lg";
  const layoutWrapper = props.fill ? "absolute inset-0 w-full h-full" : "relative w-fit h-fit";
  
  return (
    <div className={`${baseWrapper} ${layoutWrapper} ${className}`}>
      {isError && (
        <div className="absolute inset-0 z-20 flex flex-col items-center justify-center bg-gray-100 text-gray-400">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-8 w-8 mb-1"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={1.5}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z"
            />
          </svg>
          <span className="text-xs font-medium">Failed to load</span>
        </div>
      )}

      {isLoading && !isError && (
        <div className="absolute inset-0 z-10 bg-gray-200 before:absolute before:inset-0 before:-translate-x-full before:animate-[shimmer_1.5s_infinite] before:bg-gradient-to-r before:from-transparent before:via-white/60 before:to-transparent" />
      )}
      
      <NextImage
        {...props}
        src={src}
        alt={alt || "image"}
        unoptimized={true}
        className={`w-full h-full object-cover transition-opacity duration-500 ease-in-out ${
          isLoading || isError ? "opacity-0" : "opacity-100"
        }`}
        onLoad={(e) => {
          loadedImageUrls.add(srcString);
          setIsLoading(false);
          if (onLoad) {
            onLoad(e);
          }
        }}
        onError={(e) => {
          setIsLoading(false);
          setIsError(true);
          if (onError) {
            onError(e);
          }
        }}
      />
    </div>
  );
}