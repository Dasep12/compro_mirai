import Image from "next/image";
import Link from "next/link";
import { Service } from "../../../../payload-types"; // Sesuaikan path jika berbeda

interface ServiceHeroProps {
  service: Service;
}

export default function ServiceHero({ service }: ServiceHeroProps) {
  const heroImageUrl =
    service.heroImage && typeof service.heroImage === "object"
      ? service.heroImage.url
      : null;
  const heroImageAlt =
    service.heroImage && typeof service.heroImage === "object"
      ? service.heroImage.alt
      : service.title;

  return (
    <section className="w-full relative overflow-hidden flex flex-col xl:flex-row items-center justify-between px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] md:py-[80px] gap-10 xl:gap-[20px] bg-[#fdfdfd] text-[#010101]">
      <div className="w-full xl:w-[629px] flex flex-col items-start gap-5 shrink-0 z-10">
        <div className="bg-brand-100/25 text-primary rounded-full px-[14px] py-[5px] text-[14px] font-semibold leading-[180%] tracking-wide uppercase">
          {service.title}
        </div>

        <h1 className="text-[36px] md:text-[48px] font-bold leading-[130%] md:leading-[140%] text-left">
          {service.heroBadge || "Solusi Teknologi Terintegrasi"}
        </h1>

        <p className="text-[16px] leading-[180%] font-medium text-[#010101]/90">
          {service.heroDescription}
        </p>

        <div className="flex flex-wrap items-center gap-3 mt-2">
          {service.heroBtn1Text && (
            <Link
              href={service.heroBtn1Link || "#contact"}
              className="px-5 py-3 bg-primary text-[#fdfdfd] font-semibold text-[16px] rounded-mirai hover:bg-brand-600 transition-colors"
            >
              {service.heroBtn1Text}
            </Link>
          )}

          {service.heroBtn2Text && (
            <Link
              href={service.heroBtn2Link || "#catalog"}
              className="px-5 py-3 bg-[#fdfdfd] text-primary border-[1.5px] border-primary font-semibold text-[16px] rounded-mirai hover:bg-brand-100 transition-colors"
            >
              {service.heroBtn2Text}
            </Link>
          )}
        </div>
      </div>

      <div className="w-full xl:w-[720px] h-[300px] md:h-[450px] xl:h-[600px] relative shrink-0 flex items-center justify-center">
        {heroImageUrl ? (
          <Image
            src={heroImageUrl}
            alt={heroImageAlt || "Hero Illustration"}
            fill
            priority
            quality={100}
            sizes="(max-width: 1280px) 100vw, 720px"
            className="object-contain"
          />
        ) : (
          <div className="w-full h-full bg-gray-100 rounded-2xl flex items-center justify-center text-gray-400 font-medium">
            Belum ada gambar Hero
          </div>
        )}
      </div>
    </section>
  );
}
