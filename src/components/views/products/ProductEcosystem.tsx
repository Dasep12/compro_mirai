"use client";

import React from "react";
import Image from "@/components/ui/Image";
import { Product } from "../../../../payload-types";

interface ProductEcosystemProps {
  product: Product;
}

export default function ProductEcosystem({ product }: ProductEcosystemProps) {
  const hasIntegrations = product.integrations && product.integrations.length > 0;
  const hasClients = product.clients && product.clients.length > 0;

  if (!hasIntegrations && !hasClients) return null;

  return (
    <section className="w-full bg-[#fdfdfd] py-20 lg:py-28 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] border-t border-black/5 flex flex-col gap-24">
      
      {hasIntegrations && (
        <div className="flex flex-col items-center justify-center text-center gap-10">
          <div className="flex flex-col items-center justify-center gap-3">
            <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
              PLATFORM
            </div>

            <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] max-w-6xl">
              Hadir di berbagai platform pilihan Anda.
            </h2>
          </div>
          
          <div className="flex flex-wrap justify-center gap-8 sm:gap-12 items-center max-w-4xl">
            {product.integrations?.map((integration, idx) => {
              const logoUrl =
                integration.logo && typeof integration.logo === "object"
                  ? integration.logo.url
                  : null;
              
              return (
                <div key={integration.id || idx} className="flex flex-col items-center gap-3 group">
                  <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-[16px] bg-white border border-black/5 shadow-sm flex items-center justify-center p-4 transition-transform duration-300 group-hover:-translate-y-2 group-hover:shadow-md">
                    {logoUrl ? (
                      <Image
                        src={logoUrl}
                        alt={integration.name}
                        width={60}
                        height={60}
                        className="w-full h-full object-contain grayscale opacity-60 group-hover:grayscale-0 group-hover:opacity-100 transition-all duration-300"
                      />
                    ) : (
                      <div className="w-full h-full bg-gray-100 rounded-lg" />
                    )}
                  </div>
                  <span className="text-[13px] font-medium text-[#010101]/70">{integration.name}</span>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {hasClients && (
        <div className="flex flex-col items-center text-center gap-10">
          <div className="flex flex-col gap-3">
            <p className="text-[#010101]/60 text-[15px] sm:text-[16px] max-w-xl">
              Dipercaya Oleh
            </p>
          </div>

          <div className="w-full max-w-[1200px] flex flex-wrap items-center justify-center gap-8 md:gap-12 lg:gap-16">
            {(product.clients ?? []).map((client, index) => {
              const logoUrl =
                client.clientLogo && typeof client.clientLogo === "object"
                  ? client.clientLogo.url
                  : null;
              const logoAlt =
                client.clientLogo && typeof client.clientLogo === "object"
                  ? client.clientLogo.alt
                  : "Framework Logo";

              if (!logoUrl) return null;

              return (
                <div
                  key={client.id || index}
                  className="relative h-[40px] md:h-[50px] lg:h-[60px] w-auto max-w-[180px] transition-all duration-300 flex items-center justify-center"
                >
                  <Image
                    src={logoUrl}
                    alt={logoAlt}
                    width={200}
                    height={60}
                    className="object-contain h-full w-auto"
                  />
                </div>
              );
            })}
          </div>
        </div>
      )}

    </section>
  );
}
