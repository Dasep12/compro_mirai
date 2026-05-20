import Link from "next/link";

export default function ServiceCTA() {
  return (
    <section className="w-full relative flex flex-col items-center justify-center bg-primary px-4 lg:px-[120px] 2xl:px-[240px] py-[60px] lg:py-[80px] text-center text-[#fdfdfd]">
      <div className="flex flex-col items-center gap-4 max-w-[1000px]">
        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          Jadikan Teknologi Sebagai Keunggulan Kompetitif Anda
        </h2>

        <p className="text-[15px] md:text-[16px] leading-[180%] font-medium text-[#fdfdfd]/90">
          Dari perancangan infrastruktur fisik hingga pengembangan software
          kustom, kami siap membangun fondasi digital yang tangguh untuk masa
          depan bisnis Anda. Jadwalkan sesi konsultasi gratis hari ini.
        </p>
      </div>

      <div className="flex flex-row items-center justify-center gap-3 md:gap-4 mt-8 w-full">
        <Link
          href="#contact"
          className="px-6 py-[12px] bg-[#fdfdfd] text-primary font-semibold text-[16px] leading-[175%] rounded-mirai hover:bg-gray-100 transition-colors text-center shadow-sm"
        >
          Jadwalkan Konsultasi Gratis
        </Link>

        <Link
          href="#catalog"
          className="px-6 py-[12px] bg-[#fa9f29] text-[#fdfdfd] font-semibold text-[16px] leading-[175%] rounded-mirai hover:bg-[#e08b20] transition-colors text-center shadow-sm"
        >
          Lihat Katalog
        </Link>
      </div>
    </section>
  );
}
