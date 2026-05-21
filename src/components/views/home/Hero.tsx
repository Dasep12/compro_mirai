import Link from "next/link";
import Image from "next/image";

export default function Hero() {
  return (
    <section className="w-full relative overflow-hidden flex flex-col xl:flex-row items-center justify-between px-4 lg:px-[120px] 2xl:px-[240px] py-10 xl:py-[50px] gap-10 xl:gap-8 text-[#010101]">
      <div className="flex flex-col items-start gap-5 w-full flex-1 xl:max-w-[629px]">
        <h1 className="text-[36px] md:text-[48px] leading-[140%] font-bold text-left">
          Transformasi Digital Bisnis Solusi Efisiensi Menyeluruh Untuk
          Perusahaan Anda
        </h1>

        <p className="text-[16px] leading-[180%] font-medium text-left text-[#010101]/80">
          Wujudkan efisiensi operasional melalui ekosistem digital yang tepat
          sasaran. Kami menghadirkan solusi aplikasi kustom, integrasi ERP, dan
          keamanan siber untuk memastikan bisnis Anda aman, tangguh, dan siap
          bersaing.
        </p>

        <div className="flex flex-wrap items-start gap-2.5 mt-2">
          <Link
            href="#"
            className="bg-primary text-[#fdfdfd] font-semibold px-5 py-3 rounded-mirai hover:bg-brand-600 transition-colors no-underline flex items-center justify-center"
          >
            Konsultasi Sekarang
          </Link>

          <Link
            href="#"
            className="bg-[#fdfdfd] text-primary border-[1.5px] border-primary font-semibold px-5 py-3 rounded-mirai hover:bg-brand-100 hover:border-brand-600 transition-colors no-underline flex items-center justify-center"
          >
            Lihat Katalog
          </Link>
        </div>
      </div>

      <div className="w-full flex-1 flex justify-center xl:justify-end">
        <Image
          src="/api/media/file/main-hero.png"
          alt="Ilustrasi Transformasi Digital Mirai Softnet"
          width={720}
          height={600}
          priority
          className="object-contain w-full max-w-[720px] h-auto max-h-[400px] xl:max-h-[600px]"
        />
      </div>
    </section>
  );
}
