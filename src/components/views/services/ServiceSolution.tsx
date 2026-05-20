import Image from "next/image";
import { Service } from "../../../../payload-types"; // Sesuaikan path

interface ServiceSolutionProps {
  showSolution: boolean | null | undefined;
  solutionData: Service["solution"];
}

export default function ServiceSolution({
  showSolution,
  solutionData,
}: ServiceSolutionProps) {
  if (!showSolution || !solutionData || !solutionData.list) return null;

  return (
    <section className="w-full relative flex flex-col items-center px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 lg:gap-[40px] text-[#010101] bg-[#fdfdfd]">
      <div className="flex flex-col items-center gap-3 max-w-[850px] text-center mb-4 lg:mb-8">
        {solutionData.badge && (
          <div className="bg-primary text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
            {solutionData.badge}
          </div>
        )}

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          {solutionData.title}
        </h2>
      </div>

      <div className="w-full flex flex-col gap-16 lg:gap-[80px]">
        {solutionData.list.map((item, index) => {
          const isReversed = index % 2 !== 0;

          const imageUrl =
            item.image && typeof item.image === "object"
              ? item.image.url
              : null;
          const imageAlt =
            item.image && typeof item.image === "object"
              ? item.image.alt
              : item.title;

          return (
            <div
              key={item.id || index}
              className={`w-full flex flex-col gap-8 lg:gap-[80px] items-center ${
                isReversed ? "lg:flex-row-reverse" : "lg:flex-row"
              }`}
            >
              <div className="w-full lg:w-1/2 h-[250px] md:h-[350px] lg:h-[400px] relative shrink-0 shadow-[2px_4px_10px_1px_rgba(0,0,0,0.15)] rounded-2xl overflow-hidden bg-gray-50">
                {imageUrl ? (
                  <Image
                    src={imageUrl}
                    alt={imageAlt || "Solution Image"}
                    fill
                    sizes="(max-width: 1024px) 100vw, 50vw"
                    className="object-cover"
                  />
                ) : (
                  <div className="w-full h-full flex items-center justify-center text-gray-400 font-medium">
                    Belum ada gambar
                  </div>
                )}
              </div>

              <div className="flex-1 w-full flex flex-col items-start justify-center gap-4">
                {item.badge && (
                  <div className="bg-brand-100/25 text-primary rounded-full px-[14px] py-[5px] text-[14px] font-semibold leading-[180%] tracking-wide">
                    {item.badge}
                  </div>
                )}

                <h3 className="text-[28px] lg:text-[43px] font-bold leading-[130%] lg:leading-[150%] text-[#010101]">
                  {item.title}
                </h3>

                <p className="text-[15px] lg:text-[16px] leading-[180%] font-medium text-[#010101]/90">
                  {item.description}
                </p>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
}
