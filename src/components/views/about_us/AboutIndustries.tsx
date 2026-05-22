import Image from "next/image";
import { AboutUs } from "../../../../payload-types";

interface AboutIndustriesProps {
  data: AboutUs;
}

export default function AboutIndustries({ data }: AboutIndustriesProps) {
  if (!data?.industries || (data.industries ?? []).length === 0) {
    return null;
  }

  return (
    <section className="w-full relative flex flex-col items-center bg-[#fdfdfd] px-4 2xl:px-[240px] py-[80px] gap-[40px] text-[#010101] font-sans">
      <div className="flex flex-col items-center gap-4 text-center">
        <div className="bg-[#7eb2fc]/15 text-[#0451bf] rounded-full px-[16px] py-[6px] text-[14px] font-bold leading-[120%] tracking-wide uppercase">
          SEKTOR INDUSTRI
        </div>

        <h2 className="text-[32px] md:text-[42px] font-bold leading-[125%] text-[#010101]">
          Industri <span className="text-[#0451bf]">yang Kami Layani</span>
        </h2>

        <p className="text-[16px] leading-[180%] font-medium text-[#010101]/80 mt-1">
          Solusi IT kami dirancang dengan fleksibilitas tinggi untuk beradaptasi
          dan memecahkan tantangan spesifik di berbagai sektor industri.
        </p>
      </div>

      <div className="w-full flex flex-wrap justify-center gap-4 md:gap-6">
        {(data.industries ?? []).map((item, index) => {
          const iconUrl =
            item.icon && typeof item.icon === "object" && "url" in item.icon
              ? (item.icon.url as string)
              : null;

          return (
            <div
              key={item.id || index}
              className="group w-[150px] md:w-[180px] lg:w-[200px] aspect-square bg-[#fdfdfd] border border-gray-100 shadow-[2px_4px_12px_rgba(0,0,0,0.03)] rounded-[24px] flex flex-col items-center justify-center gap-4 p-4 text-center transition-all duration-300 hover:-translate-y-2 hover:border-[#7eb2fc]/50 hover:shadow-[0px_10px_24px_-8px_rgba(4,81,191,0.2)] cursor-pointer"
            >
              <div className="w-[64px] h-[64px] rounded-full bg-[#7eb2fc]/10 flex items-center justify-center text-[#0451bf] transition-colors duration-500">
                {iconUrl ? (
                  <Image
                    src={iconUrl}
                    alt={`${item.name} Icon`}
                    width={32}
                    height={32}
                    className="object-contain brightness-0 group-hover:brightness-0 group-hover:invert transition-all duration-500"
                    style={{
                      filter:
                        "invert(20%) sepia(97%) saturate(2222%) hue-rotate(205deg) brightness(93%) contrast(105%)",
                    }}
                  />
                ) : (
                  <svg
                    className="w-8 h-8 transition-transform duration-500 group-hover:scale-110"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    strokeWidth={1.5}
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
                    />
                  </svg>
                )}
              </div>

              <h3 className="text-[15px] md:text-[16px] font-bold leading-[130%] text-[#010101] group-hover:text-[#0451bf] transition-colors duration-300 px-2">
                {item.name}
              </h3>
            </div>
          );
        })}
      </div>
    </section>
  );
}
