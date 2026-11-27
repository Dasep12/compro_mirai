import Link from "next/link";
import SectionLabel from "@/components/ui/SectionLabel";
import { Product } from "../../../../payload-types";

interface ProductCTAProps {
  product: Product;
}

export default function ProductCTA({ product }: ProductCTAProps) {
  if (product.showCTA === false || !product.productUrl) return null;

  return (
    <section className="w-full bg-[#f7f7f7] px-4 py-10 sm:px-8 sm:py-14 lg:px-[120px] lg:py-16 2xl:px-[calc(50vw-600px)]">
      <div className="relative mx-auto flex max-w-[1200px] flex-col items-start gap-8 overflow-hidden rounded-[28px] bg-primary p-6 text-[#fdfdfd] sm:rounded-[36px] sm:p-10 lg:flex-row lg:items-center lg:justify-between lg:gap-12 lg:p-14">
        <div
          aria-hidden="true"
          className="pointer-events-none absolute -right-24 -top-32 h-[360px] w-[360px] rounded-full border border-white/20 sm:-right-12 sm:-top-44 sm:h-[500px] sm:w-[500px]"
        >
          <div className="absolute inset-10 rounded-full border border-white/15" />
        </div>

        <div className="relative z-10 max-w-[720px]">
          <div className="mb-4">
            <SectionLabel tone="inverse">Pelajari lebih lanjut</SectionLabel>
          </div>
          <h2 className="text-[28px] font-bold leading-[125%] sm:text-[34px] lg:text-[42px]">
            Jadikan {product.name} bagian dari teknologi Anda
          </h2>
        </div>

        <Link
          href={product.productUrl}
          target="_blank"
          rel="noopener noreferrer"
          className="relative z-10 inline-flex w-full shrink-0 items-center justify-center gap-3 rounded-mirai bg-[#fdfdfd] px-6 py-3.5 text-center font-semibold text-primary shadow-sm transition-colors hover:bg-white/90 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white sm:w-auto"
        >
          <span>{product.ctaText || "Kunjungi Website"}</span>
          <svg
            aria-hidden="true"
            className="h-4 w-4"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={2}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M7 17 17 7M7 7h10v10"
            />
          </svg>
        </Link>
      </div>
    </section>
  );
}
