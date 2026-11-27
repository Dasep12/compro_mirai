"use client";

import React from "react";
import Image from "@/components/ui/Image";
import SectionLabel from "@/components/ui/SectionLabel";
import { Product } from "../../../../payload-types";

interface ProductEcosystemProps {
  product: Product;
}

export default function ProductEcosystem({ product }: ProductEcosystemProps) {
  const integrations = product.integrations ?? [];
  const clients = (product.clients ?? []).filter(
    (client) => client.clientLogo && typeof client.clientLogo === "object",
  );
  const hasIntegrations = integrations.length > 0;
  const hasClients = clients.length > 0;

  if (!hasIntegrations && !hasClients) return null;

  return (
    <section className="w-full bg-[#fdfdfd] px-4 py-12 text-[#010101] sm:px-8 sm:py-16 lg:px-30 lg:py-20 2xl:px-[calc(50vw-600px)]">
      <div className="mx-auto flex max-w-300 flex-col gap-10 lg:gap-14">
        {hasIntegrations && (
          <div className="grid gap-8 lg:grid-cols-[0.8fr_1.2fr] lg:items-center lg:gap-12">
            <div className="flex flex-col items-start gap-4">
              <SectionLabel>Platform & Integrasi</SectionLabel>
              <h2 className="text-[28px] font-bold leading-[130%] sm:text-[34px] lg:text-[40px]">
                Ekosistem pendukung {product.name}
              </h2>
            </div>

            <ul className="grid grid-cols-2 gap-3 sm:grid-cols-3">
              {integrations.map((integration, index) => {
                const logoUrl =
                  integration.logo && typeof integration.logo === "object"
                    ? integration.logo.url
                    : null;

                return (
                  <li
                    key={integration.id || index}
                    className="flex min-h-28 flex-col items-center justify-center gap-3 rounded-2xl border border-black/5 bg-[#f7f7f7] p-4 text-center transition-colors hover:border-primary/30 sm:min-h-33"
                  >
                    {logoUrl ? (
                      <Image
                        src={logoUrl}
                        alt=""
                        width={64}
                        height={64}
                        className="h-10 w-10 object-contain sm:h-12 sm:w-12"
                      />
                    ) : (
                      <span className="flex h-10 w-10 items-center justify-center rounded-full bg-primary/10 text-[16px] font-bold uppercase text-primary sm:h-12 sm:w-12">
                        {integration.name.slice(0, 1)}
                      </span>
                    )}
                    <span className="text-[12px] font-semibold leading-[140%] sm:text-[13px]">
                      {integration.name}
                    </span>
                  </li>
                );
              })}
            </ul>
          </div>
        )}

        {hasClients && (
          <div className="rounded-3xl border border-black/5 px-5 py-7 sm:px-8 sm:py-9">
            <div className="flex flex-col items-center gap-6">
              <SectionLabel align="center">Dipercaya oleh</SectionLabel>
              <div
                className="w-full overflow-x-auto pb-2"
                role="region"
                aria-label="Logo klien"
              >
                <ul className="flex w-max min-w-full snap-x snap-mandatory items-center justify-center gap-8">
                  {clients.map((client, index) => {
                    const logo =
                      client.clientLogo && typeof client.clientLogo === "object"
                        ? client.clientLogo
                        : null;

                    if (!logo?.url) return null;

                    return (
                      <li
                        key={client.id || index}
                        className="flex h-10 max-w-37.5 shrink-0 snap-center items-center sm:h-12 sm:max-w-45"
                      >
                        <Image
                          src={logo.url}
                          alt={logo.alt || client.clientName || "Logo klien"}
                          width={180}
                          height={60}
                          className="h-full w-auto object-contain"
                        />
                      </li>
                    );
                  })}
                </ul>
              </div>
            </div>
          </div>
        )}
      </div>
    </section>
  );
}
