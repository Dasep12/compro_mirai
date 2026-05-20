import Image from "next/image";
import { Service } from "../../../../payload-types";

interface ServiceProblemProps {
  showProblem: boolean | null | undefined;
  problemData: Service["problem"];
}

export default function ServiceProblem({
  showProblem,
  problemData,
}: ServiceProblemProps) {
  if (!showProblem || !problemData) return null;

  return (
    <section className="w-full relative overflow-hidden flex flex-col items-center px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-[22px] text-[#010101]">
      <div className="flex flex-col items-center gap-3 max-w-[850px] text-center">
        {problemData.badge && (
          <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
            {problemData.badge}
          </div>
        )}

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          {problemData.title}
        </h2>

        <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101]/90 mt-1">
          {problemData.subtitle}
        </p>
      </div>

      <div className="w-full grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5 mt-4">
        {problemData.cards?.map((card, index) => {
          const iconUrl =
            card.icon && typeof card.icon === "object" ? card.icon.url : null;
          const iconAlt =
            card.icon && typeof card.icon === "object"
              ? card.icon.alt
              : card.title;

          return (
            <div
              key={card.id || index}
              className="bg-[#fdfdfd] shadow-[3px_3px_8px_1px_rgba(0,0,0,0.1)] rounded-xl flex flex-col items-start p-6 lg:p-[24px_28px] gap-[14px] transition-transform hover:-translate-y-1 hover:shadow-lg duration-300"
            >
              <div className="bg-brand-100/10 rounded-xl p-[6px] shrink-0 flex items-center justify-center">
                {iconUrl ? (
                  <Image
                    src={iconUrl}
                    alt={iconAlt || "Problem Icon"}
                    width={48}
                    height={48}
                    className="object-contain"
                  />
                ) : (
                  <div className="w-[48px] h-[48px] bg-gray-200 rounded-lg flex items-center justify-center text-[10px] text-gray-500 text-center">
                    No Icon
                  </div>
                )}
              </div>

              <div className="flex flex-col gap-2 w-full">
                <h3 className="font-bold text-[18px] md:text-[20px] leading-[125%] text-[#010101]">
                  {card.title}
                </h3>
                <p className="text-[14px] md:text-[15px] font-medium leading-[180%] text-[#010101]/80">
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
