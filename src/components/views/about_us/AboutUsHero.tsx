import Image from "next/image";
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
    <section className="w-full relative overflow-hidden flex flex-col items-start px-4 md:px-[120px] xl:px-[240px] pt-[140px] pb-[60px] gap-[32px] text-[#010101]">
      <div className="w-full flex flex-col xl:flex-row items-center xl:items-start gap-[40px] xl:gap-[60px]">
        <div className="flex-1 flex flex-col items-start gap-[16px] w-full">
          <div className="bg-[#0451bf] text-[#fdfdfd] rounded-full px-[14px] py-[5px] text-[14px] font-medium leading-[180%] tracking-wide uppercase">
            TENTANG KAMI
          </div>

          <h1 className="text-[32px] md:text-[46px] font-bold leading-[125%] text-[#010101] tracking-tight text-left">
            {data?.heroHeadline || "Mendorong Transformasi Digital Indonesia"}
          </h1>

          <div className="w-[60px] h-[4px] bg-[#0451bf] rounded-full mt-2 mb-2"></div>

          <p className="w-full text-[16px] leading-[190%] font-medium text-[#010101]/80 text-justify whitespace-pre-line">
            {data?.heroDescription}
          </p>
        </div>

        <div className="w-full xl:w-[540px] 2xl:w-[600px] h-[350px] md:h-[480px] xl:h-[540px] 2xl:h-[600px] shrink-0 rounded-[20px] overflow-hidden relative bg-[#fdfdfd] p-4 shadow-[0px_4px_10px_1px_rgba(0,0,0,0.1)] group">
          {imageUrl ? (
            <Image
              src={imageUrl}
              alt={imageAlt || "Mirai Softnet Overview"}
              fill
              priority
              quality={100}
              sizes="(max-width: 1280px) 100vw, 600px"
              className="object-cover rounded-[20px] transition-transform duration-700 group-hover:scale-105"
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
