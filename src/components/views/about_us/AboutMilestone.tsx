import { AboutUs } from "../../../../payload-types";

interface AboutMilestonesProps {
  data: AboutUs;
}

export default function AboutMilestones({ data }: AboutMilestonesProps) {
  if (!data?.milestones || (data.milestones ?? []).length === 0) {
    return null;
  }

  return (
    <section className="w-full relative overflow-hidden bg-[#fdfdfd] px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 xl:py-[80px] flex flex-col items-center gap-10 sm:gap-12 lg:gap-[60px] font-sans">
      <div className="flex flex-col items-center gap-3 sm:gap-4 text-center max-w-[800px]">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] text-[14px] font-medium leading-[120%] tracking-wide uppercase">
          REKAM JEJAK
        </div>
        <h2 className="text-[28px] sm:text-[34px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] text-[#010101]">
          {data.milestoneHeadline || "Jejak Langkah Perjalanan Kami"}
        </h2>
      </div>

      <div className="w-full flex flex-col relative mt-4">
        <div className="flex flex-col gap-8 relative lg:hidden">
          <div className="absolute top-4 bottom-4 left-[19px] w-[2px] border-l-2 border-dashed border-primary/40 z-0" />

          {(data.milestones ?? []).map((item, index) => (
            <div
              key={item.id || index}
              className="flex items-start gap-6 relative z-10 group"
            >
              <div className="relative w-10 h-10 flex items-center justify-center shrink-0 z-10">
                <div className="absolute inset-0 rounded-full bg-[#7eb2fc]/40 animate-ping opacity-50" />
                <div className="relative w-7 h-7 bg-[#fdfdfd] border-[3px] border-primary rounded-full flex items-center justify-center shadow-sm">
                  <div className="w-2 h-2 rounded-full bg-primary" />
                </div>
              </div>

              <div className="bg-[#fdfdfd] border border-gray-100 shadow-[3px_3px_8px_1px_rgba(0,0,0,0.05)] rounded-xl p-5 flex flex-col items-start gap-2 flex-1 mt-[-6px]">
                <span className="text-[13px] font-bold text-primary bg-[#7eb2fc]/15 px-3 py-1 rounded-md">
                  {item.year}
                </span>
                <h3 className="text-[18px] font-bold text-[#010101]">
                  {item.title}
                </h3>
                {item.description && (
                  <p className="text-[14px] font-medium leading-[170%] text-[#010101]/70">
                    {item.description}
                  </p>
                )}
              </div>
            </div>
          ))}
        </div>

        <div className="hidden lg:grid grid-cols-3 gap-y-[60px] gap-x-[40px] w-full relative">
          {(data.milestones ?? []).map((item, i) => {
            const row = Math.floor(i / 3);
            const isEvenRow = row % 2 === 0;
            const col = isEvenRow ? i % 3 : 2 - (i % 3);
            const isLastItem = i === (data.milestones ?? []).length - 1;

            const drawRight = isEvenRow && col < 2 && !isLastItem;
            const drawLeft = !isEvenRow && col > 0 && !isLastItem;
            const drawDown =
              ((isEvenRow && col === 2) || (!isEvenRow && col === 0)) &&
              !isLastItem;

            return (
              <div
                key={item.id || i}
                className={`relative flex flex-col items-center text-center z-10 group`}
                style={{
                  gridRow: row + 1,
                  gridColumn: col + 1,
                }}
              >
                {drawRight && (
                  <div className="absolute top-[19px] left-[50%] w-[calc(100%+40px)] border-t-2 border-dashed border-primary/40 -z-10" />
                )}
                {drawLeft && (
                  <div className="absolute top-[19px] right-[50%] w-[calc(100%+40px)] border-t-2 border-dashed border-primary/40 -z-10" />
                )}
                {drawDown && (
                  <div className="absolute top-[19px] left-[calc(50%-1px)] h-[calc(100%+60px)] border-l-2 border-dashed border-primary/40 -z-10" />
                )}

                <div className="relative w-10 h-10 flex items-center justify-center shrink-0 z-10 cursor-pointer">
                  <div className="absolute inset-0 rounded-full bg-[#7eb2fc]/40 animate-ping opacity-30 group-hover:opacity-60 transition-opacity duration-300" />
                  <div className="relative w-7 h-7 bg-[#fdfdfd] border-[3px] border-primary rounded-full flex items-center justify-center shadow-sm transition-all duration-300 group-hover:scale-125 group-hover:bg-primary">
                    <div className="w-2 h-2 rounded-full bg-primary transition-colors group-hover:bg-[#fdfdfd]" />
                  </div>
                </div>

                <span className="text-[13px] font-bold text-primary bg-[#7eb2fc]/15 px-3 py-1 rounded-md mt-4 transition-colors group-hover:bg-primary group-hover:text-[#fdfdfd]">
                  {item.year}
                </span>

                <div className="bg-[#fdfdfd] shadow-[3px_3px_8px_1px_rgba(0,0,0,0.06)] border border-gray-100/80 rounded-xl flex flex-col items-center p-5 sm:p-6 gap-2 sm:gap-3 mt-4 w-full h-full transition-transform hover:-translate-y-1 hover:shadow-lg">
                  <h3 className="text-[16px] sm:text-[18px] font-bold leading-[130%] text-[#010101]">
                    {item.title}
                  </h3>
                  {item.description && (
                    <p className="text-[13px] sm:text-[14px] font-medium leading-[160%] sm:leading-[170%] text-[#010101]/70">
                      {item.description}
                    </p>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
