import Link from "next/link";
import { Service, Product } from "../../../payload-types";
import Image from "next/image";

interface FooterProps {
  services: Service[];
  products: Product[];
}

export default function Footer({ services, products }: FooterProps) {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="w-full bg-base-800 text-[15px] text-[#fdfdfd] px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] pt-12 pb-6 flex flex-col gap-10">
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-6 gap-10 w-full">
        <div className="flex flex-col gap-4 sm:col-span-2 lg:col-span-2">
          <Link href="/" className="inline-block w-max">
            <Image
              src="/api/media/file/mirai-white.png"
              alt="Mirai Softnet Logo"
              width={201}
              height={70}
              className="object-contain w-auto h-[60px] lg:h-[70px]"
              priority
            />
          </Link>

          <p className="leading-[150%] font-medium mt-2 text-[#fdfdfd]/90 max-w-md text-[14px] lg:text-[15px]">
            Vasanta Innopark No T-51, Jl. Kalimantan, Gandamekar, Kec. Cikarang
            Barat, Kab. Bekasi, Jawa Barat 17530
          </p>

          <div className="flex flex-col gap-1.5 mt-2 text-[14px] text-[#fdfdfd]/80">
            <span className="flex items-center gap-2">
              <span className="font-semibold text-[#74e0d3]">Email:</span>{" "}
              info@miraisoftnet.com
            </span>
            <span className="flex items-center gap-2">
              <span className="font-semibold text-[#74e0d3]">Jam Kerja:</span>{" "}
              Senin - Jumat (09:00 - 18:00)
            </span>
          </div>
        </div>

        <div className="flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase tracking-wider text-[14px] mb-1">
            Produk
          </h3>
          {(products ?? []).slice(0, 5).map((product) => (
            <Link
              key={product.id}
              href={`${product.productUrl}`}
              target="_blank"
              className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
            >
              {product.name}
            </Link>
          ))}
        </div>

        <div className="flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase tracking-wider text-[14px] mb-1">
            Layanan
          </h3>
          {(services ?? []).slice(0, 5).map((service) => (
            <Link
              key={service.id}
              href={`/services/${service.slug}`}
              className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
            >
              {service.title}
            </Link>
          ))}
        </div>

        <div className="flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase tracking-wider text-[14px] mb-1">
            Akses Cepat
          </h3>
          <Link
            href="/pricing"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
          >
            Harga
          </Link>
          <Link
            href="#"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
          >
            Katalog
          </Link>
        </div>

        <div className="flex flex-col gap-3">
          <h3 className="font-bold text-[#74e0d3] leading-[140%] uppercase tracking-wider text-[14px] mb-1">
            Perusahaan
          </h3>
          <Link
            href="/about-us"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
          >
            Tentang Kami
          </Link>
          <Link
            href="#"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
          >
            Terms of Use
          </Link>
          <Link
            href="#"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
          >
            Privacy Policy
          </Link>
          <Link
            href="#"
            className="leading-[140%] font-semibold hover:text-[#74e0d3] transition-colors no-underline hover:no-underline opacity-90 hover:opacity-100 text-[14px] lg:text-[15px]"
          >
            Hubungi Kami
          </Link>
        </div>
      </div>

      <div className="w-full border-t border-[#fdfdfd]/20 flex flex-col sm:flex-row items-center justify-between pt-5 gap-4 text-[13px] text-[#fdfdfd]/70">
        <p className="text-center sm:text-left order-2 sm:order-1">
          &copy; {currentYear} PT Mirai Softnet Teknologi. Hak Cipta Dilindungi
          Undang-Undang.
        </p>
        <div className="flex items-center gap-6 order-1 sm:order-2">
          <span className="text-[#74e0d3]/90 font-medium">
            Build for Acceleration
          </span>
        </div>
      </div>
    </footer>
  );
}
