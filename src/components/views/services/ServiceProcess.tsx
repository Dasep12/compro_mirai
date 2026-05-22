import Image from "next/image";
import { Service } from "../../../../payload-types"; // Sesuaikan path

interface ServiceProcessProps {
  showProcess: boolean | null | undefined;
  processData: Service["process"];
  showFramework: boolean | null | undefined;
  frameworkData: Service["framework"];
}

export default function ServiceProcess({
  showProcess,
  processData,
  showFramework,
  frameworkData,
}: ServiceProcessProps) {
  if (!showProcess && !showFramework) return null;

  return (
    <section className="w-full relative flex flex-col items-center bg-brand-100/10 px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 md:gap-20 text-[#010101]">
      {showProcess && processData && processData.steps && (
        <div className="w-full flex flex-col items-center gap-[40px]">
          <div className="flex flex-col items-center gap-3 max-w-[850px] text-center mb-4">
            {processData.badge && (
              <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
                {processData.badge}
              </div>
            )}
            <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
              {processData.title}
            </h2>
            <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101]/90 mt-1">
              {processData.subtitle}
            </p>
          </div>

          <div className="relative w-full flex flex-col gap-8 md:gap-16 pb-10">
            <div className="hidden md:block absolute left-1/2 top-0 bottom-0 w-[1.5px] bg-primary -translate-x-1/2 z-0" />

            {(processData.steps ?? []).map((step, index) => {
              const isEven = index % 2 !== 0;
              const stepNumber = index + 1;

              const iconUrl =
                step.icon && typeof step.icon === "object"
                  ? step.icon.url
                  : null;
              const iconAlt =
                step.icon && typeof step.icon === "object"
                  ? step.icon.alt
                  : step.title;

              return (
                <div
                  key={step.id || index}
                  className={`w-full flex flex-col md:flex-row items-center relative z-10 ${
                    isEven ? "md:flex-row-reverse" : "md:flex-row"
                  }`}
                >
                  <div className="hidden md:block md:w-1/2" />

                  <div className="absolute left-0 md:left-1/2 transform md:-translate-x-1/2 -top-4 md:top-1/2 md:-translate-y-1/2 w-[60px] h-[60px] md:w-[80px] md:h-[80px] rounded-full bg-primary flex items-center justify-center shadow-[2px_4px_10px_1px_rgba(0,0,0,0.1)] z-20 shrink-0">
                    <span className="text-[#fdfdfd] text-[20px] md:text-[28px] font-bold leading-none">
                      {stepNumber}
                    </span>
                  </div>

                  <div className="w-full md:w-1/2 flex pt-[50px] md:pt-0">
                    <div
                      className={`w-full bg-[#fdfdfd] shadow-[3px_5px_10px_1px_rgba(0,0,0,0.1)] rounded-xl p-6 lg:p-[24px_28px] flex flex-col items-start gap-3 transition-transform hover:-translate-y-1 duration-300 ${
                        isEven ? "md:mr-12 lg:mr-16" : "md:ml-12 lg:ml-16"
                      }`}
                    >
                      <div className="bg-brand-100/10 rounded-xl p-[6px] shrink-0">
                        {iconUrl ? (
                          <Image
                            src={iconUrl}
                            alt={iconAlt || "Step Icon"}
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

                      <h3 className="font-bold text-[20px] md:text-[24px] leading-[130%] text-[#010101]">
                        {step.title}
                      </h3>
                      <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101]/80">
                        {step.description}
                      </p>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {showFramework && frameworkData && frameworkData.logos && (
        <div className="w-full flex flex-col items-center gap-10 pt-10 border-t border-primary/10">
          <div className="flex flex-col items-center gap-3 max-w-[850px] text-center">
            <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
              {frameworkData.title}
            </h2>
            <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#010101]/90 mt-1">
              {frameworkData.subtitle}
            </p>
          </div>

          <div className="w-full max-w-[1200px] flex flex-wrap items-center justify-center gap-8 md:gap-12 lg:gap-16">
            {frameworkData.logos.map((logoItem, index) => {
              const logoUrl =
                logoItem.logo && typeof logoItem.logo === "object"
                  ? logoItem.logo.url
                  : null;
              const logoAlt =
                logoItem.logo && typeof logoItem.logo === "object"
                  ? logoItem.logo.alt
                  : "Framework Logo";

              if (!logoUrl) return null;

              return (
                <div
                  key={logoItem.id || index}
                  className="relative h-[40px] md:h-[50px] lg:h-[60px] w-auto max-w-[180px] transition-all duration-300 flex items-center justify-center"
                >
                  <Image
                    src={logoUrl}
                    alt={logoAlt}
                    width={200}
                    height={60}
                    className="object-contain h-full w-auto"
                  />
                </div>
              );
            })}
          </div>
        </div>
      )}
    </section>
  );
}
