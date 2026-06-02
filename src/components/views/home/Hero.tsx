import Link from "next/link";
import Image from "@/components/ui/Image";
import { generateWhatsAppUrl } from "@/lib/whatsapp";

export default function Hero() {
  const waUrl = generateWhatsAppUrl();

  return (
    <section className="w-full relative overflow-hidden flex flex-col lg:flex-row items-center justify-between px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-[50px] gap-10 lg:gap-8 text-[#010101]">
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
      <div className="flex flex-col items-start gap-4 sm:gap-5 w-full flex-1 lg:max-w-[500px] xl:max-w-[629px]">
        <h1 className="text-[28px] sm:text-[36px] lg:text-[40px] xl:text-[48px] leading-[130%] sm:leading-[140%] font-bold text-left">
          Transformasi Digital Bisnis Solusi Efisiensi Menyeluruh Untuk
          Perusahaan Anda
        </h1>

        <p className="text-[14px] sm:text-[15px] lg:text-[15px] xl:text-[16px] leading-[160%] sm:leading-[180%] font-medium text-left text-[#010101]/80">
          Wujudkan efisiensi operasional melalui ekosistem digital yang tepat
          sasaran. Kami menghadirkan solusi aplikasi kustom, integrasi ERP, dan
          keamanan siber untuk memastikan bisnis Anda aman, tangguh, dan siap
          bersaing.
        </p>

        <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 sm:gap-4 mt-2 w-full sm:w-auto">
          <Link
            href={waUrl}
            target="_blank"
            className="bg-primary text-[#fdfdfd] font-semibold px-6 py-3 rounded-mirai hover:bg-brand-600 transition-colors no-underline flex items-center justify-center w-full sm:w-auto text-center"
          >
            Konsultasi Sekarang
          </Link>

          <Link
            href="https://tokomirai.com/"
            className="bg-[#fdfdfd] text-primary border-[1.5px] border-primary font-semibold px-6 py-3 rounded-mirai hover:bg-brand-100 hover:border-brand-600 transition-colors no-underline flex items-center justify-center w-full sm:w-auto text-center"
          >
            Lihat Katalog
          </Link>
        </div>
      </div>
      <div className="w-full flex-1 flex justify-center lg:justify-end mt-2 lg:mt-0">
        <Image
          src="/api/media/file/main-hero.png"
          alt="Ilustrasi Transformasi Digital Mirai Softnet"
          width={720}
          height={600}
          priority
          className="object-contain w-full h-auto max-w-[450px] lg:max-w-[500px] xl:max-w-[720px] max-h-[320px] sm:max-h-[450px] lg:max-h-[450px] xl:max-h-[600px] animate-levitate"
        />
      </div>
    </section>
  );
}
