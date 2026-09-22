import { Metadata } from "next";
import { getSolutions, getIndustries } from "@/lib/data/collections";
import SolutionList from "@/components/views/solution/SolutionList";

export const metadata: Metadata = {
  title: "Solution Use Case | PT Mirai Softnet Technology",
  description:
    "Browse available solution use cases. Temukan solusi teknologi terintegrasi dari PT Mirai Softnet Technology untuk berbagai kebutuhan industri, dari sektor publik hingga manufaktur dan perhotelan.",
};

export default async function SolutionPage() {
  const [solutions, industries] = await Promise.all([
    getSolutions(100),
    getIndustries(100),
  ]);

  return (
    <div className="w-full min-h-screen bg-[#fdfdfd] pb-16 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)]">
      {/* Page Title & Subtitle */}
       <section className="w-full relative flex flex-col items-center bg-[#fdfdfd] px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 xl:py-[80px] text-[#010101]">
        <div className="flex flex-col items-center gap-4 text-center max-w-[900px] lg:max-w-[1000px] animate-in fade-in slide-in-from-bottom-4 duration-700">
          <h1 className="text-[28px] sm:text-[36px] lg:text-[40px] xl:text-[48px] font-bold leading-[130%] sm:leading-[125%]">
            Solution Use Case
          </h1>

          <p className="text-[14px] sm:text-[15px] lg:text-[16px] xl:text-[18px] leading-[160%] sm:leading-[180%] font-medium text-[#010101]/80 mt-1 max-w-3xl">
            Browse available solution use cases
          </p>
        </div>
      </section>

      {/* Main Filter & Table Content */}
      <SolutionList solutions={solutions} industries={industries} />
    </div>
  );
}