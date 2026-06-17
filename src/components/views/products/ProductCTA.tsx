import Link from "next/link";
import { generateWhatsAppUrl } from "@/lib/whatsapp";
import { Product } from "../../../../payload-types";

interface ProductCTAProps {
  product: Product;
}

export default function ProductCTA({ product }: ProductCTAProps) {
  const waUrl = generateWhatsAppUrl();

  return (
    <section className="w-full relative flex flex-col items-center justify-center bg-primary px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-14 sm:py-16 lg:py-20 text-center text-[#fdfdfd]">
      <div className="flex flex-col items-center gap-4 max-w-[900px] lg:max-w-[1000px]">
        <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] max-w-4xl">
          Jadikan {product.name} Bagian dari Teknologi Anda
        </h2>
      </div>

      <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-center gap-3 sm:gap-4 mt-8 w-full sm:w-auto">
        <Link
          href={product.productUrl || waUrl || "#"}
          target="_blank"
          className="bg-[#fdfdfd] text-primary font-semibold px-6 py-3 rounded-mirai hover:bg-gray-100 transition-colors no-underline flex items-center justify-center w-full sm:w-auto text-center shadow-sm"
        >
          {product.ctaText || "Kunjungi Website"}
        </Link>
      </div>
    </section>
  );
}