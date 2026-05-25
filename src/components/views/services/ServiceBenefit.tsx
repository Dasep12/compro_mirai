import Image from "next/image";
import { Service } from "../../../../payload-types"; // Sesuaikan path

interface ServiceBenefitProps {
  showBenefit: boolean | null | undefined;
  benefitData: Service["benefit"];
}

export default function ServiceBenefit({
  showBenefit,
  benefitData,
}: ServiceBenefitProps) {
  if (!showBenefit || !benefitData || !benefitData.cards) return null;

  return (
    <section className="w-full relative overflow-hidden flex flex-col items-center bg-[#fdfdfd] px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-8 lg:gap-10 text-[#010101]">
      <div className="flex flex-col items-center gap-4 max-w-[900px] text-center mb-2 lg:mb-4">
        {benefitData.badge && (
          <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
            {benefitData.badge}
          </div>
        )}

        <h2 className="text-[28px] sm:text-[32px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] max-w-4xl text-[#010101]">
          {benefitData.title}
        </h2>

        <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1 max-w-3xl">
          {benefitData.subtitle}
        </p>
      </div>

      <div className="w-full grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6 mt-2 lg:mt-4">
        {(benefitData.cards ?? []).map((card, index) => {
          const iconUrl =
            card.icon && typeof card.icon === "object" ? card.icon.url : null;
          const iconAlt =
            card.icon && typeof card.icon === "object"
              ? card.icon.alt
              : card.title;

          return (
            <div
              key={card.id || index}
              className="bg-[#fdfdfd] shadow-[3px_3px_8px_1px_rgba(0,0,0,0.1)] rounded-xl flex flex-col items-start p-5 sm:p-6 lg:p-[24px_28px] gap-4 sm:gap-5 transition-transform hover:-translate-y-1 hover:shadow-lg duration-300"
            >
              <div className="bg-brand-100/10 rounded-xl p-2 shrink-0 flex items-center justify-center">
                {iconUrl ? (
                  <Image
                    src={iconUrl}
                    alt={iconAlt || "Benefit Icon"}
                    width={48}
                    height={48}
                    className="w-10 h-10 sm:w-12 sm:h-12 object-contain"
                  />
                ) : (
                  <div className="w-10 h-10 sm:w-12 sm:h-12 bg-gray-200 rounded-lg flex items-center justify-center text-[10px] text-gray-500 text-center">
                    No Icon
                  </div>
                )}
              </div>

              <div className="flex flex-col gap-2 w-full text-left mt-1">
                <h3 className="font-bold text-[18px] lg:text-[20px] leading-[125%] text-[#04459f]">
                  {card.title}
                </h3>
                <p className="text-[14px] lg:text-[15px] font-medium leading-[160%] sm:leading-[180%] text-[#010101]/80">
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
