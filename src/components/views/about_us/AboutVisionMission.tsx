import React from "react";
import { AboutUs } from "../../../../payload-types";

interface AboutVisionMissionProps {
  data: AboutUs;
}

export default function AboutVisionMission({ data }: AboutVisionMissionProps) {
  return (
    <section className="w-full relative flex flex-col items-center px-4 md:px-[120px] xl:px-[240px] py-[80px] gap-[80px] bg-[#fdfdfd] font-sans">
      <div className="w-full flex flex-col items-center justify-center text-center gap-[24px] max-w-[900px]">
        <div className="bg-brand-100/15 text-primary rounded-full px-[14px] py-[5px] text-[14px] font-bold leading-[180%] tracking-wide uppercase">
          Visi Perusahaan
        </div>

        <div className="relative inline-flex flex-col items-center mt-4">
          <svg
            className="w-10 h-10 md:w-14 md:h-14 text-primary/20 absolute -top-6 -left-6 md:-top-8 md:-left-12"
            fill="currentColor"
            viewBox="0 0 24 24"
          >
            <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h4v10h-10z" />
          </svg>

          <h2 className="text-[28px] md:text-[36px] xl:text-[42px] font-bold leading-[140%] text-primary tracking-tight relative z-10 px-4 md:px-0">
            {data?.visionText}
          </h2>
          <svg
            className="w-10 h-10 md:w-14 md:h-14 text-primary/20 absolute -bottom-6 -right-6 md:-bottom-8 md:-right-12 rotate-180"
            fill="currentColor"
            viewBox="0 0 24 24"
          >
            <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h4v10h-10z" />
          </svg>
        </div>
      </div>

      <div className="w-full flex flex-col items-center gap-[32px]">
        <h3 className="text-[24px] md:text-[32px] font-bold leading-[125%] text-[#010101] text-center">
          Misi Kami
        </h3>

        <div className="w-full grid grid-cols-1 md:grid-cols-2 gap-[20px] md:gap-[24px]">
          {data?.missionList?.map(
            (item: { missionText: string }, index: number) => {
              const displayNumber = String(index + 1).padStart(2, "0");

              return (
                <div
                  key={index}
                  className="relative bg-[#fdfdfd] border border-gray-100 rounded-[24px] p-[32px] flex flex-col gap-[20px] shadow-[2px_4px_16px_4px_rgba(0,0,0,0.03)] hover:shadow-[2px_8px_24px_4px_rgba(4,81,191,0.08)] transition-all duration-300 group overflow-hidden"
                >
                  <span className="absolute -bottom-6 -right-2 text-[120px] font-extrabold text-brand-100/5 group-hover:text-brand-100/10 transition-colors duration-500 z-0 select-none pointer-events-none leading-none">
                    {displayNumber}
                  </span>

                  <div className="relative z-10 flex flex-col gap-[16px]">
                    <div className="w-12 h-12 rounded-[12px] bg-primary/10 text-primary flex items-center justify-center font-bold text-[16px] group-hover:bg-primary group-hover:text-[#fdfdfd] transition-colors duration-300">
                      {displayNumber}
                    </div>

                    <p className="text-[15px] md:text-[17px] leading-[180%] font-medium text-[#010101]/90">
                      {item.missionText}
                    </p>
                  </div>
                </div>
              );
            },
          )}
        </div>
      </div>
    </section>
  );
}
