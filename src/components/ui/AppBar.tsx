"use client";

import Link from "next/link";
import Image from "next/image";
import { Product, Service } from "../../../payload-types";

interface AppBarProps {
  services: Service[];
  products: Product[];
}

export default function AppBar({ services, products }: AppBarProps) {
  return (
    <nav className="fixed top-0 w-full h-[70px] bg-[#fdfdfd] shadow-[4px_4px_6px_1px_rgba(0,0,0,0.1)] flex items-center justify-between px-4 lg:px-[120px] 2xl:px-[240px] z-50 text-[#010101] text-[15px]">
      <Link
        href="/"
        className="relative h-[70px] w-[164px] shrink-0 flex items-center"
      >
        <Image
          src="/api/media/file/mirai-black.png"
          alt="Mirai Softnet Logo"
          width={164}
          height={50}
          className="object-contain w-auto h-auto"
          priority
        />
      </Link>

      <div className="hidden md:flex items-center justify-end flex-1 px-10 gap-8 h-full">
        <div className="group flex items-center gap-1 h-full cursor-pointer relative">
          <span className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 group-hover:after:w-full">
            Produk
          </span>
          <svg
            className="w-4 h-4 group-hover:rotate-180 transition-transform"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M19 9l-7 7-7-7"
            />
          </svg>

          <div className="absolute top-[70px] left-1/2 -translate-x-1/2 hidden group-hover:grid grid-cols-1 w-max gap-y-1 p-2 bg-[#fdfdfd] rounded-xl shadow-[4px_4px_10px_1px_rgba(0,0,0,0.1)]">
            {products?.map((product) => {
              const iconUrl =
                product.iconTitle && typeof product.iconTitle === "object"
                  ? product.iconTitle.url
                  : null;

              return (
                <Link
                  href={`${product.productUrl}`}
                  key={product.id}
                  target="_blank"
                  className="w-[275px] flex items-start gap-3 p-[10px_16px] hover:bg-[#010101]/5 transition-colors rounded-lg"
                >
                  <div className="w-[34px] h-[34px] flex items-center justify-center shrink-0">
                    {iconUrl ? (
                      <Image
                        src={iconUrl}
                        alt={`${product.name} Icon`}
                        width={34}
                        height={34}
                        className="object-contain"
                      />
                    ) : (
                      <svg
                        className="w-5 h-5 text-primary"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"
                        />
                      </svg>
                    )}
                  </div>

                  <div className="flex flex-col gap-1">
                    <span className="font-semibold text-[15px] text-[#010101] leading-tight">
                      {product.name}
                    </span>
                    <span className="text-[12px] text-base-100 leading-snug">
                      {product.subtitle}
                    </span>
                  </div>
                </Link>
              );
            })}
          </div>
        </div>

        <div className="group flex items-center gap-1 h-full cursor-pointer relative">
          <span className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 group-hover:after:w-full">
            Layanan & Jasa
          </span>
          <svg
            className="w-4 h-4 group-hover:rotate-180 transition-transform"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M19 9l-7 7-7-7"
            />
          </svg>

          <div className="absolute top-[70px] left-1/2 -translate-x-1/2 hidden group-hover:grid grid-cols-2 w-max gap-x-2.5 gap-y-1 p-2 bg-[#fdfdfd] rounded-xl shadow-[4px_4px_10px_1px_rgba(0,0,0,0.1)]">
            {services.map((service) => {
              const iconUrl =
                service.iconTitle && typeof service.iconTitle === "object"
                  ? service.iconTitle.url
                  : null;

              return (
                <Link
                  href={`/services/${service.slug}`}
                  key={service.id}
                  className="w-[275px] flex items-start gap-3 p-[10px_16px] hover:bg-[#010101]/5 transition-colors rounded-lg no-underline hover:no-underline"
                >
                  <div className="w-[34px] h-[34px] flex items-center justify-center shrink-0 relative overflow-hidden">
                    {iconUrl ? (
                      <Image
                        src={iconUrl}
                        alt={`${service.title} Icon`}
                        width={34}
                        height={34}
                        className="object-contain"
                      />
                    ) : (
                      <svg
                        className="w-5 h-5 text-primary"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"
                        />
                      </svg>
                    )}
                  </div>

                  <div className="flex flex-col gap-1">
                    <span className="font-semibold text-[15px] text-[#010101] leading-tight">
                      {service.title}
                    </span>
                    <span className="text-[12px] text-[#010101] leading-snug">
                      {service.subtitle}
                    </span>
                  </div>
                </Link>
              );
            })}
          </div>
        </div>

        <Link
          href="/pricing"
          className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 hover:after:w-full"
        >
          Harga
        </Link>

        {/* <Link
          href="/career"
          className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 hover:after:w-full"
        >
          Karir
        </Link> */}

        <Link
          href="#"
          className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 hover:after:w-full"
        >
          Katalog
        </Link>
      </div>

      <Link
        href="#"
        className="hidden md:flex items-center justify-center bg-primary text-white font-semibold px-5 py-2 rounded-mirai hover:bg-brand-600 transition-colors"
      >
        Hubungi Kami
      </Link>
    </nav>
  );
}
