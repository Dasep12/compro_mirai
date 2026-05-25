import { AboutUs } from "../../../../payload-types";

interface AboutStrengthsProps {
  data: AboutUs;
}

export default function AboutStrengths({ data }: AboutStrengthsProps) {
  if (!data?.strengths || (data.strengths ?? []).length === 0) {
    return null;
  }

  return (
    <section className="w-full relative overflow-hidden bg-primary px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-14 sm:py-16 lg:py-20 xl:py-[80px] font-sans flex justify-center">
      <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-[#7eb2fc] rounded-full mix-blend-multiply filter blur-[120px] opacity-20 pointer-events-none translate-x-1/3 -translate-y-1/3" />
      <div className="absolute bottom-0 left-0 w-[400px] h-[400px] bg-[#fdfdfd] rounded-full mix-blend-overlay filter blur-[100px] opacity-10 pointer-events-none -translate-x-1/2 translate-y-1/2" />

      <div className="w-full flex flex-col lg:flex-row gap-10 sm:gap-12 lg:gap-[60px] xl:gap-[100px] relative z-10">
        <div className="w-full lg:w-[420px] xl:w-[500px] shrink-0">
          <div className="sticky flex flex-col items-start gap-5">
            <div className="bg-[#fdfdfd]/10 text-[#7eb2fc] border border-[#7eb2fc]/30 rounded-full px-[16px] py-[6px] text-[14px] font-bold leading-[120%] tracking-wider uppercase backdrop-blur-sm">
              MENGAPA KAMI?
            </div>

            <h2 className="text-[28px] sm:text-[34px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%] sm:leading-[120%] text-[#fdfdfd] tracking-tight">
              Keunggulan Kompetitif Kami
            </h2>

            <p className="text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-[#fdfdfd]/80">
              Lebih dari sekadar vendor IT, kami adalah mitra strategis yang
              memastikan teknologi Anda selaras dengan target bisnis jangka
              panjang.
            </p>

            <div className="w-[80px] h-[3px] bg-[#7eb2fc] rounded-full mt-4" />
          </div>
        </div>

        <div className="flex-1 flex flex-col">
          {data.strengths.map((item, index) => {
            const displayNumber = String(index + 1).padStart(2, "0");
            const isLast = index === data.strengths.length - 1;

            return (
              <div
                key={item.id || index}
                className={`flex flex-col sm:flex-row items-start gap-4 sm:gap-6 lg:gap-10 py-8 sm:py-10 lg:py-[40px] group transition-all duration-300 ${
                  !isLast ? "border-b border-[#fdfdfd]/15" : ""
                }`}
              >
                <div className="text-[48px] sm:text-[56px] lg:text-[72px] font-black leading-none text-[#fdfdfd]/20 group-hover:text-[#7eb2fc] transition-colors duration-500 shrink-0 font-mono tracking-tighter">
                  {displayNumber}
                </div>

                <div className="flex flex-col gap-2 sm:gap-3 mt-0 sm:mt-2">
                  <h3 className="text-[20px] sm:text-[22px] lg:text-[26px] font-bold leading-[130%] text-[#fdfdfd] group-hover:translate-x-2 transition-transform duration-300">
                    {item.title}
                  </h3>

                  {item.description && (
                    <p className="text-[14px] sm:text-[15px] lg:text-[16px] font-medium leading-[160%] sm:leading-[180%] text-[#fdfdfd]/70 group-hover:text-[#fdfdfd]/90 transition-colors duration-300">
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
