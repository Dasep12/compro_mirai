import Image from "next/image";
import { AboutUs } from "../../../../payload-types";

interface AboutCoreValuesProps {
  data: AboutUs;
}

export default function AboutCoreValues({ data }: AboutCoreValuesProps) {
  if (!data?.coreValues || (data.coreValues ?? []).length === 0) {
    return null;
  }

  return (
    <section className="w-full relative overflow-hidden flex flex-col items-center bg-[#7eb2fc]/5 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-8 lg:gap-10 text-[#010101] font-sans">
      <div className="flex flex-col items-center gap-4 text-center max-w-[800px]">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] text-[14px] font-medium leading-[120%] tracking-wide uppercase">
          NILAI INTI
        </div>

        <h2 className="text-[28px] sm:text-[36px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] max-w-4xl">
          Prinsip Kerja Kami
        </h2>

        <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1 max-w-3xl">
          Fondasi utama yang membimbing setiap keputusan, baris kode, dan
          kemitraan yang kami bangun di <br className="hidden md:block" />
          Mirai Softnet.
        </p>
      </div>

      <div className="w-full grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5 lg:gap-6 items-stretch mt-2 lg:mt-0">
        {(data.coreValues ?? []).map((value, index) => {
          const iconUrl =
            value.icon && typeof value.icon === "object" && "url" in value.icon
              ? (value.icon.url as string)
              : null;

          return (
            <div
              key={value.id || index}
              className="bg-[#fdfdfd] shadow-[3px_3px_8px_1px_rgba(0,0,0,0.1)] rounded-xl flex flex-col items-start p-6 lg:p-[24px_28px] gap-4 transition-transform hover:-translate-y-1 hover:shadow-lg duration-300"
            >
              <div className="bg-[#7eb2fc]/10 rounded-xl p-2 shrink-0 flex items-center justify-center">
                {iconUrl ? (
                  <Image
                    src={iconUrl}
                    alt={`${value.title} Icon`}
                    width={48}
                    height={48}
                    className="w-12 h-12 object-contain"
                  />
                ) : (
                  <svg
                    className="w-12 h-12 p-1 text-primary"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    strokeWidth={1.5}
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      d="M13 10V3L4 14h7v7l9-11h-7z"
                    />
                  </svg>
                )}
              </div>

              <div className="flex flex-col gap-2 mt-1">
                <h3 className="text-[20px] font-bold leading-[125%]">
                  {value.title}
                </h3>
                <p className="text-[15px] font-medium leading-[180%] text-[#010101]/80">
                  {value.description}
                </p>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
}
