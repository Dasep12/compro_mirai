"use client";

import React, { useEffect, useRef, useState } from "react";
import Image from "next/image";
import { Customer, Partnership } from "../../../../payload-types";

interface MarqueeRowProps {
  items: (Customer | Partnership)[];
  isPartner?: boolean;
}

const MarqueeRow = ({ items, isPartner = false }: MarqueeRowProps) => {
  const [isOverflowing, setIsOverflowing] = useState(false);
  const containerRef = useRef<HTMLDivElement>(null);
  const trackRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const container = containerRef.current;
    const track = trackRef.current;
    if (!container || !track) return;

    const checkOverflow = () => {
      if (track.scrollWidth > container.clientWidth + 10) {
        setIsOverflowing(true);
      } else {
        setIsOverflowing(false);
      }
    };

    const observer = new ResizeObserver(checkOverflow);
    observer.observe(container);
    observer.observe(track);

    return () => observer.disconnect();
  }, [items]);

  const renderItems = () => (
    <>
      {(items ?? []).map((item, index) => {
        const logoUrl =
          item.logo && typeof item.logo === "object" ? item.logo.url : null;
        const logoAlt =
          item.logo && typeof item.logo === "object"
            ? item.logo.alt
            : item.name || "Logo";

        return (
          <div
            key={`${item.id}-${index}`}
            className={`${
              isPartner
                ? "h-[50px] md:h-[72px]"
                : "h-[60px] w-[120px] md:w-[200px]"
            } flex items-center justify-center shrink-0`}
          >
            {logoUrl ? (
              <Image
                src={logoUrl}
                alt={logoAlt}
                width={isPartner ? 346 : 200}
                height={isPartner ? 72 : 60}
                className="object-contain w-auto h-full"
              />
            ) : (
              <div className="w-[100px] h-full bg-gray-100 animate-pulse rounded-mirai" />
            )}
          </div>
        );
      })}
    </>
  );

  return (
    <div
      ref={containerRef}
      className={`w-full overflow-hidden flex marquee-container ${
        isOverflowing ? "justify-start mask-image-gradient" : "justify-center"
      }`}
    >
      <div
        ref={trackRef}
        className={`flex items-center shrink-0 gap-8 md:gap-[50px] ${
          isOverflowing ? "animate-marquee pr-8 md:pr-[50px]" : ""
        }`}
      >
        {renderItems()}
      </div>

      {isOverflowing && (
        <div
          className="flex items-center shrink-0 gap-8 md:gap-[50px] animate-marquee pr-8 md:pr-[50px]"
          aria-hidden="true"
        >
          {renderItems()}
        </div>
      )}
    </div>
  );
};

interface PartnershipCustomerProps {
  customers: Customer[];
  partnerships: Partnership[];
}

export default function PartnershipCustomer({
  customers,
  partnerships,
}: PartnershipCustomerProps) {
  const hasCustomers = customers && customers.length > 0;
  const hasPartnerships = partnerships && partnerships.length > 0;

  if (!hasCustomers && !hasPartnerships) {
    return null;
  }

  return (
    <section className="w-full relative flex flex-col items-center px-4 lg:px-[120px] 2xl:px-[240px] py-10 gap-10 text-[#010101]">
      <style
        dangerouslySetInnerHTML={{
          __html: `
            @keyframes marquee {
              0% { transform: translateX(0%); }
              100% { transform: translateX(-100%); }
            }
            .animate-marquee {
              animation: marquee 25s linear infinite;
            }
            .mask-image-gradient {
              mask-image: linear-gradient(to right, transparent, black 5%, black 95%, transparent);
              -webkit-mask-image: linear-gradient(to right, transparent, black 5%, black 95%, transparent);
            }
          `,
        }}
      />

      {hasCustomers && (
        <div className="w-full flex flex-col items-center gap-2.5">
          <h2 className="text-[15px] md:text-[18px] font-bold leading-[180%] text-center">
            Our Existing Customers
          </h2>
          <div className="w-full mt-2">
            <MarqueeRow items={customers} isPartner={false} />
          </div>
        </div>
      )}

      {hasPartnerships && (
        <div className="w-full flex flex-col items-center gap-2.5 mt-4 md:mt-8">
          <h2 className="text-[15px] md:text-[18px] font-bold leading-[180%] text-center">
            Our Trusted Partnership
          </h2>
          <div className="w-full mt-2">
            <MarqueeRow items={partnerships} isPartner={true} />
          </div>
        </div>
      )}
    </section>
  );
}
