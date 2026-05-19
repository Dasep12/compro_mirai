import Link from "next/link";
import { Service, Product } from "../../../payload-types";
import Image from "next/image";

interface FooterProps {
  services: Service[];
  products: Product[];
}

export default function Footer({ services, products }: FooterProps) {
  return (
    <footer className="w-full bg-base-800 text-[15px] text-[#fdfdfd] px-4 lg:px-[120px] 2xl:px-[240px] pt-10 pb-5 flex flex-col gap-10">
      <div className="flex flex-col md:flex-row items-start gap-10 w-full">
        <div className="flex-[1.5] flex flex-col gap-4">
          <Link href="/">
            <Image
              src="/api/media/file/mirai-white.png"
              alt="Mirai Softnet Logo"
              width={201}
              height={70}
              className="object-contain w-auto h-[70px]"
            />
          </Link>

          <p className="leading-[140%] font-medium mt-2">
            Vasanta Innopark No T-51, Jl. Kalimantan, Gandamekar, Kec. Cikarang
            Barat, Kab. Bekasi, <br />
            Jawa Barat 17530
          </p>

          <div className="flex flex-col gap-1 mt-2">
            <span className="leading-[140%] font-medium">
              Email: info@miraisoftnet.com
            </span>

            <span className="leading-[140%] font-medium">
              Telp : +62 (021) 50 666 222
            </span>
          </div>

          <div className="flex items-center gap-3 mt-4">
            <Link href="#" className="hover:opacity-80 transition-opacity">
              <Image
                src="/api/media/file/playstore-button.svg"
                alt="Get it on Google Play"
                width={136}
                height={46}
                className="w-auto h-[46px]"
              />
            </Link>

            <Link href="#" className="hover:opacity-80 transition-opacity">
              <Image
                src="/api/media/file/appstore-button.svg"
                alt="Download on the App Store"
                width={129}
                height={46}
                className="w-auto h-[46px]"
              />
            </Link>
          </div>
        </div>

        <div className="flex-1 flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase mb-2">
            Produk
          </h3>
          {products?.map((product) => (
            <Link
              href={`${product.productUrl}`}
              key={product.id}
              target="_blank"
              className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
            >
              {product.name}
            </Link>
          ))}
        </div>

        <div className="flex-1 flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase mb-2">
            Layanan & Jasa
          </h3>
          {services?.map((service) => (
            <Link
              href={`/services/${service.slug}`}
              key={service.id}
              className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
            >
              {service.title}
            </Link>
          ))}
        </div>

        <div className="flex-1 flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase mb-2">
            Sumber Daya
          </h3>
          <Link
            href="/help"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
          >
            Pusat Bantuan
          </Link>

          {/* <Link
            href="/career"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
          >
            Karir
          </Link> */}

          <Link
            href="#"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
          >
            Katalog
          </Link>
        </div>

        <div className="flex-1 flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase mb-2">
            Perusahaan
          </h3>

          <Link
            href="/about"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
          >
            Tentang Kami
          </Link>

          <Link
            href="/terms"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
          >
            Terms of Use
          </Link>

          <Link
            href="/privacy"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
          >
            Privacy Policy
          </Link>

          <Link
            href="#"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline"
          >
            Hubungi Kami
          </Link>
        </div>
      </div>

      <div className="w-full border-t border-[#fdfdfd]/30 flex items-center justify-end pt-5 px-2.5">
        <span className="leading-[140%] font-medium text-right text-sm md:text-[15px]">
          © Copyright 2026 PT Mirai Softnet Technology. All rights reserved.
        </span>
      </div>
    </footer>
  );
}
