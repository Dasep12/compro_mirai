import Image from "@/components/ui/Image";
import { Problem as ProblemType } from "../../../../payload-types";

interface ProblemProps {
  data: ProblemType[];
}

export default function Problem({ data }: ProblemProps) {
  if (data?.length === 0) return null;

  return (
    <section className="w-full relative overflow-hidden flex flex-col items-center bg-[#7eb2fc]/5 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-8 lg:gap-12 text-[#010101]">
      <div className="flex flex-col items-center gap-4 text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
          KEUNGGULAN
        </div>
        <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%]">
          Mengapa Memilih Mirai Softnet?
        </h2>

        <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1 max-w-3xl">
          Dedikasi utama kami adalah mendukung pertumbuhan bisnis Anda melalui
          kombinasi keahlian teknis terpadu, inovasi tanpa henti, serta wawasan
          strategis yang dirancang untuk menjawab setiap tantangan.
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 w-full">
        {(data ?? []).map((card, index) => {
          const iconUrl =
            card.icon && typeof card.icon === "object"
              ? card.icon.url
              : undefined;

          return (
            <div
              key={index}
              className="bg-[#fdfdfd] shadow-[3px_3px_8px_1px_rgba(0,0,0,0.1)] rounded-xl flex flex-col items-start p-5 sm:p-6 lg:p-[24px_28px] gap-4 transition-transform hover:-translate-y-1 hover:shadow-lg duration-300"
            >
              <div className="bg-[#7eb2fc]/10 rounded-xl p-2 shrink-0 flex items-center justify-center">
                {iconUrl ? (
                  <Image
                    src={iconUrl}
                    alt={`${card.title} Icon`}
                    width={48}
                    height={48}
                    className="w-10 h-10 sm:w-12 sm:h-12 object-contain"
                  />
                ) : (
                  <div className="w-10 h-10 sm:w-12 sm:h-12 flex items-center justify-center text-gray-400">
                    #
                  </div>
                )}
              </div>

              <div className="flex flex-col gap-2 mt-1">
                <h3 className="text-[18px] lg:text-[20px] font-bold leading-[125%]">
                  {card.title}
                </h3>
                <p className="text-[14px] lg:text-[15px] font-medium leading-[160%] text-[#010101]/80">
                  {card.description}
                </p>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
}
