"use client";

import Link from "next/link";
import Image from "@/components/ui/Image";
import { Product, Service } from "../../../payload-types";
import { useState } from "react";
import { generateWhatsAppUrl } from "@/lib/whatsapp";

interface AppBarProps {
  services: Service[];
  products: Product[];
}

export default function AppBar({ services, products }: AppBarProps) {
  const waUrl = generateWhatsAppUrl();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [openMobileDropdown, setOpenMobileDropdown] = useState<string | null>(
    null,
  );

  const [openDesktopDropdown, setOpenDesktopDropdown] = useState<string | null>(
    null,
  );

  const toggleMobileDropdown = (menu: string) => {
    setOpenMobileDropdown(openMobileDropdown === menu ? null : menu);
  };

  const closeMobileMenu = () => {
    setIsMobileMenuOpen(false);
    setOpenMobileDropdown(null);
  };

  return (
    <>
      {openDesktopDropdown && (
        <div
          className="fixed inset-0 z-40 bg-transparent hidden lg:block"
          onClick={() => setOpenDesktopDropdown(null)}
        />
      )}

      <nav className="fixed top-0 w-full h-[70px] bg-[#fdfdfd] shadow-[4px_4px_6px_1px_rgba(0,0,0,0.1)] flex items-center justify-between px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] z-50 text-[#010101] text-[15px]">
        <Link
          href="/"
          className="relative h-[70px] w-[164px] shrink-0 flex items-center"
          onClick={closeMobileMenu}
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
        <div className="hidden lg:flex items-center justify-end flex-1 px-10 gap-8 h-full">
          <div
            className="group flex items-center gap-1 h-full cursor-pointer relative"
            onClick={(e) => {
              e.stopPropagation();
              setOpenDesktopDropdown(
                openDesktopDropdown === "produk" ? null : "produk",
              );
            }}
          >
            <span className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 group-hover:after:w-full">
              Produk
            </span>
            <svg
              className={`w-4 h-4 transition-transform duration-300 ${
                openDesktopDropdown === "produk" || isMobileMenuOpen
                  ? "group-hover:rotate-180"
                  : "group-hover:rotate-180"
              } ${openDesktopDropdown === "produk" ? "rotate-180 text-primary" : ""}`}
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

            <div
              className={`absolute top-[70px] left-1/2 -translate-x-1/2 w-max gap-y-1 p-2 bg-[#fdfdfd] rounded-xl shadow-[4px_4px_10px_1px_rgba(0,0,0,0.1)] ${
                openDesktopDropdown === "produk"
                  ? "grid"
                  : "hidden lg:group-hover:grid"
              }`}
              onClick={(e) => e.stopPropagation()}
            >
              {(products ?? []).length == 0 ? (
                    <Link
                      href="#"
                      onClick={closeMobileMenu}
                      className="w-full flex items-start gap-3 p-[10px_12px] hover:bg-[#010101]/5 active:bg-[#010101]/10 transition-colors rounded-mirai"
                    >
                      <span>Produk Tidak Tersedia</span>
                    </Link>
                  ) : (products ?? []).map((product) => {
                const iconUrl =
                  product.iconTitle && typeof product.iconTitle === "object"
                    ? product.iconTitle.url
                    : null;

                return (
                  <Link
                    href={`/products/${product.slug}`}
                    key={product.id}
                    className="w-[275px] flex items-start gap-3 p-[10px_16px] hover:bg-[#010101]/5 transition-colors rounded-lg"
                    onClick={() => setOpenDesktopDropdown(null)}
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

          <div
            className="group flex items-center gap-1 h-full cursor-pointer relative"
            onClick={(e) => {
              e.stopPropagation();
              setOpenDesktopDropdown(
                openDesktopDropdown === "layanan" ? null : "layanan",
              );
            }}
          >
            <span className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 group-hover:after:w-full">
              Layanan & Jasa
            </span>
            <svg
              className={`w-4 h-4 transition-transform duration-300 ${
                openDesktopDropdown === "layanan"
                  ? "rotate-180 text-primary"
                  : "group-hover:rotate-180"
              }`}
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

            <div
              className={`absolute top-[70px] left-1/2 -translate-x-1/2 w-max gap-x-2.5 gap-y-1 p-2 bg-[#fdfdfd] rounded-xl shadow-[4px_4px_10px_1px_rgba(0,0,0,0.1)] ${
                services && services.length === 1
                  ? "grid-cols-1"
                  : "grid-cols-2"
              } ${
                openDesktopDropdown === "layanan"
                  ? "grid"
                  : "hidden lg:group-hover:grid"
              }`}
              onClick={(e) => e.stopPropagation()}
            >
              {(services ?? []).length == 0 ? (
                    <Link
                      href="#"
                      onClick={closeMobileMenu}
                      className="w-full flex items-start gap-3 p-[10px_12px] hover:bg-[#010101]/5 active:bg-[#010101]/10 transition-colors rounded-mirai"
                    >
                      <span>Layanan Tidak Tersedia</span>
                    </Link>
                  ) : (services ?? []).map((service) => {
                const iconUrl =
                  service.iconTitle && typeof service.iconTitle === "object"
                    ? service.iconTitle.url
                    : null;

                return (
                  <Link
                    href={`/services/${service.slug}`}
                    key={service.id}
                    className="w-[275px] flex items-start gap-3 p-[10px_16px] hover:bg-[#010101]/5 transition-colors rounded-lg no-underline hover:no-underline"
                    onClick={() => setOpenDesktopDropdown(null)}
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
                      <span className="text-[12px] text-[#010101]/70 leading-snug line-clamp-2">
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

          {/* Open if there is a new product in the future */}
          {/* <Link
            href="/careers"
            className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 hover:after:w-full"
          >
            Karir
          </Link> */}

          <Link
            href="https://tokomirai.com/"
            target="_blank"
            className="font-medium relative after:absolute after:-bottom-1 after:left-0 after:h-[2px] after:w-0 after:bg-[#010101] after:transition-all after:duration-300 hover:after:w-full"
          >
            Katalog
          </Link>
        </div>
        <Link
          href={waUrl}
          target="_blank"
          className="hidden lg:flex items-center justify-center bg-primary text-white font-semibold px-5 py-2 rounded-mirai hover:bg-brand-600 transition-colors"
        >
          Hubungi Kami
        </Link>
        <button
          className="flex lg:hidden p-2 text-[#010101] hover:bg-[#010101]/5 rounded-mirai transition-colors"
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          aria-label="Toggle Menu"
        >
          {isMobileMenuOpen ? (
            <svg
              className="w-6 h-6"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          ) : (
            <svg
              className="w-6 h-6"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M4 6h16M4 12h16M4 18h16"
              />
            </svg>
          )}
        </button>
        <div
          className={`absolute top-[70px] left-0 w-full bg-[#fdfdfd] shadow-[0_4px_6px_1px_rgba(0,0,0,0.1)] flex flex-col lg:hidden transition-all duration-300 origin-top overflow-y-auto ${
            isMobileMenuOpen
              ? "scale-y-100 opacity-100 max-h-[calc(100vh-70px)]"
              : "scale-y-0 opacity-0 h-0"
          }`}
        >
          <div className="flex flex-col px-4 py-4 gap-2">
            <div className="flex flex-col">
              <button
                onClick={() => toggleMobileDropdown("produk")}
                className="flex items-center justify-between py-3 font-medium text-left w-full hover:text-primary transition-colors"
              >
                <span>Produk</span>
                <svg
                  className={`w-4 h-4 transition-transform duration-300 ${
                    openMobileDropdown === "produk"
                      ? "rotate-180 text-primary"
                      : ""
                  }`}
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
              </button>
              <div
                className={`grid transition-[grid-template-rows] duration-300 ease-in-out ${
                  openMobileDropdown === "produk"
                    ? "grid-rows-[1fr]"
                    : "grid-rows-[0fr]"
                }`}
              >
                <div className="overflow-hidden flex flex-col gap-1 pl-2">
                  {(products ?? []).length == 0 ? (
                    <Link
                      href="#"
                      onClick={closeMobileMenu}
                      className="w-full flex items-start gap-3 p-[10px_12px] hover:bg-[#010101]/5 active:bg-[#010101]/10 transition-colors rounded-mirai"
                    >
                      <span>Produk Tidak Tersedia</span>
                    </Link>
                  ) : (products ?? []).map((product) => {
                    const iconUrl =
                      product.iconTitle && typeof product.iconTitle === "object"
                        ? product.iconTitle.url
                        : null;
                    return (
                      <Link
                        href={`/products/${product.slug}`}
                        key={product.id}
                        onClick={closeMobileMenu}
                        className="w-full flex items-start gap-3 p-[10px_12px] hover:bg-[#010101]/5 active:bg-[#010101]/10 transition-colors rounded-mirai"
                      >
                        <div className="w-[30px] h-[30px] flex items-center justify-center shrink-0">
                          {iconUrl ? (
                            <Image
                              src={iconUrl}
                              alt="Icon"
                              width={30}
                              height={30}
                              className="object-contain"
                            />
                          ) : (
                            <div className="w-5 h-5 bg-primary/20 rounded-full" />
                          )}
                        </div>
                        <div className="flex flex-col gap-0.5">
                          <span className="font-semibold text-[14px] text-[#010101]">
                            {product.name}
                          </span>
                          <span className="text-[11px] text-base-100 line-clamp-1">
                            {product.subtitle}
                          </span>
                        </div>
                      </Link>
                    );
                  })}
                  
                </div>
              </div>
            </div>

            <div className="flex flex-col border-t border-black/5">
              <button
                onClick={() => toggleMobileDropdown("layanan")}
                className="flex items-center justify-between py-3 font-medium text-left w-full hover:text-primary transition-colors"
              >
                <span>Layanan & Jasa</span>
                <svg
                  className={`w-4 h-4 transition-transform duration-300 ${
                    openMobileDropdown === "layanan"
                      ? "rotate-180 text-primary"
                      : ""
                  }`}
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
              </button>
              <div
                className={`grid transition-[grid-template-rows] duration-300 ease-in-out ${
                  openMobileDropdown === "layanan"
                    ? "grid-rows-[1fr]"
                    : "grid-rows-[0fr]"
                }`}
              >
                <div className="overflow-hidden flex flex-col gap-1 pl-2">
                  {(services ?? []).length == 0 ? (
                    <Link
                      href="#"
                      onClick={closeMobileMenu}
                      className="w-full flex items-start gap-3 p-[10px_12px] hover:bg-[#010101]/5 active:bg-[#010101]/10 transition-colors rounded-mirai"
                    >
                      <span>Layanan Tidak Tersedia</span>
                    </Link>
                  ) : (services ?? []).map((service) => {
                    const iconUrl =
                      service.iconTitle && typeof service.iconTitle === "object"
                        ? service.iconTitle.url
                        : null;
                    return (
                      <Link
                        href={`/services/${service.slug}`}
                        key={service.id}
                        onClick={closeMobileMenu}
                        className="w-full flex items-start gap-3 p-[10px_12px] hover:bg-[#010101]/5 active:bg-[#010101]/10 transition-colors rounded-mirai"
                      >
                        <div className="w-[30px] h-[30px] flex items-center justify-center shrink-0">
                          {iconUrl ? (
                            <Image
                              src={iconUrl}
                              alt="Icon"
                              width={30}
                              height={30}
                              className="object-contain"
                            />
                          ) : (
                            <div className="w-5 h-5 bg-primary/20 rounded-full" />
                          )}
                        </div>
                        <div className="flex flex-col gap-0.5">
                          <span className="font-semibold text-[14px] text-[#010101]">
                            {service.title}
                          </span>
                          <span className="text-[11px] text-[#010101]/70 line-clamp-1">
                            {service.subtitle}
                          </span>
                        </div>
                      </Link>
                    );
                  })}
                </div>
              </div>
            </div>

            <Link
              href="/pricing"
              onClick={closeMobileMenu}
              className="py-3 font-medium border-t border-black/5 w-full hover:text-primary transition-colors"
            >
              Harga
            </Link>

            {/* Open if there is a new product in the future */}
            {/* <Link
              href="/careers"
              onClick={closeMobileMenu}
              className="py-3 font-medium border-t border-black/5 w-full hover:text-primary transition-colors"
            >
              Karir
            </Link> */}

            <Link
              href="https://tokomirai.com/"
              target="_blank"
              onClick={closeMobileMenu}
              className="py-3 font-medium border-t border-black/5 w-full hover:text-primary transition-colors"
            >
              Katalog
            </Link>

            <div className="w-full pt-4 mt-2 border-t border-black/5">
              <Link
                href={waUrl}
                target="_blank"
                onClick={closeMobileMenu}
                className="flex items-center justify-center bg-primary text-white font-semibold px-5 py-3 rounded-mirai hover:bg-brand-600 transition-colors w-full"
              >
                Hubungi Kami
              </Link>
            </div>
          </div>
        </div>
      </nav>
    </>
  );
}
