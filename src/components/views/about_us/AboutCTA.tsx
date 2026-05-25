import Link from "next/link";
import { AboutUs } from "../../../../payload-types";

interface AboutCtaProps {
  data: AboutUs;
}

export default function AboutCta({ data }: AboutCtaProps) {
  if (!data?.ctaHeadline || !data?.ctaButtonText) {
    return null;
  }

  return (
    <section className="w-full relative overflow-hidden bg-primary px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-14 sm:py-16 lg:py-20 xl:py-[100px] font-sans">
      <div className="w-full relative z-10 flex flex-col lg:flex-row items-center justify-between gap-8 lg:gap-16">
        <div className="flex flex-col items-center lg:items-start text-center lg:text-left gap-3 sm:gap-4">
          <h2 className="text-[28px] sm:text-[34px] lg:text-[42px] xl:text-[48px] font-bold leading-[125%] sm:leading-[120%] text-[#fdfdfd] tracking-tight max-w-2xl">
            {data.ctaHeadline}
          </h2>

          {data.ctaDescription && (
            <p className="text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[18px] leading-[160%] sm:leading-[180%] font-medium text-[#fdfdfd]/80 mt-1 max-w-xl">
              {data.ctaDescription}
            </p>
          )}

          <Link
            href={data.ctaButtonLink}
            className="mt-2 bg-[#fdfdfd] text-primary gap-2 border-[1.5px] border-primary font-semibold px-6 py-3 rounded-mirai hover:bg-brand-100 hover:border-brand-600 transition-colors no-underline flex items-center justify-center w-full sm:w-auto"
          >
            {data.ctaButtonText}
            <svg
              className="w-5 h-5 transition-transform duration-300 group-hover:translate-x-1"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M14 5l7 7m0 0l-7 7m7-7H3"
              />
            </svg>
          </Link>
        </div>
      </div>
    </section>
  );
}
