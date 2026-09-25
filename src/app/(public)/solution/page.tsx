import { Metadata } from "next";
import { getSolutions, getIndustries } from "@/lib/data/collections";
import SolutionList from "@/components/views/solution/SolutionList";
import SolutionHero from "@/components/views/solution/SolutionHero";

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
      <SolutionHero />

      {/* Main Filter & Table Content */}
      <SolutionList solutions={solutions} industries={industries} />
    </div>
  );
}