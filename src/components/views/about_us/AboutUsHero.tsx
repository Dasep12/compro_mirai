import Image from "@/components/ui/Image";
import { AboutUs } from "../../../../payload-types";

interface AboutHeroProps {
  data: AboutUs;
}

export default function AboutUsHero({ data }: AboutHeroProps) {
  const imageUrl =
    data?.heroImage && typeof data.heroImage === "object"
      ? data.heroImage.url
      : null;
  const imageAlt =
    data?.heroImage && typeof data.heroImage === "object"
      ? data.heroImage.alt
      : "Mirai Softnet Technology";

  return (
    <section className="w-full relative overflow-hidden flex flex-col items-start px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] pt-24 sm:pt-[120px] lg:pt-[140px] pb-10 sm:pb-14 lg:pb-[60px] gap-6 sm:gap-8 lg:gap-[32px] text-[#010101]">
      <style
        dangerouslySetInnerHTML={{
          __html: `
            @keyframes levitate {
              0%, 100% { transform: translateY(0); }
              50% { transform: translateY(-15px); }
            }
            .animate-levitate {
              animation: levitate 4s ease-in-out infinite;
            }
          `,
        }}
      />
      <div className="w-full flex flex-col lg:flex-row items-center lg:items-start gap-8 lg:gap-[40px] xl:gap-[60px]">
        <div className="flex-1 flex flex-col items-start gap-3 sm:gap-4 lg:gap-[16px] w-full animate-in fade-in slide-in-from-bottom-4 duration-700">
          <div className="bg-[#0451bf] text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
            TENTANG KAMI
          </div>

          <h1 className="text-[28px] sm:text-[36px] lg:text-[40px] xl:text-[46px] font-bold leading-[130%] sm:leading-[125%] text-[#010101] tracking-tight text-left max-w-2xl lg:max-w-full">
            {data?.heroHeadline || "Mendorong Transformasi Digital Indonesia"}
          </h1>

          <div className="w-[60px] h-[4px] bg-[#0451bf] rounded-full mt-2 mb-2"></div>

          <p className="w-full text-[14px] sm:text-[15px] lg:text-[16px] leading-[160%] sm:leading-[190%] font-medium text-[#010101]/80 text-left sm:text-justify whitespace-pre-line">
            {data?.heroDescription}
          </p>
        </div>

        <div className="w-full lg:w-1/2 xl:w-[540px] 2xl:w-[600px] h-[280px] sm:h-[400px] md:h-[480px] lg:h-[500px] xl:h-[540px] 2xl:h-[600px] shrink-0 rounded-[20px] overflow-hidden relative bg-[#fdfdfd] p-3 sm:p-4 shadow-sm group">
          {imageUrl ? (
            <Image
              src={imageUrl}
              alt={imageAlt || "Mirai Softnet Overview"}
              fill
              priority
              quality={100}
              sizes="(max-width: 1280px) 100vw, 600px"
              className="object-cover rounded-[20px]"
            />
          ) : (
            <div className="w-full h-full flex items-center justify-center bg-[#7eb2fc]/10 text-gray-400 font-medium rounded-[20px]">
              Ilustrasi Company Profile
            </div>
          )}

          <div className="absolute inset-0 border border-black/5 pointer-events-none rounded-[20px]" />
        </div>
      </div>
    </section>
  );
}
