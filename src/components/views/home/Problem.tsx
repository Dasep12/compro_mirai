import Image from "next/image";

const data = [
  {
    title: "Keamanan & Keandalan",
    description:
      "Menghadirkan solusi dan layanan IT yang terjamin aman, andal, dan mematuhi standar enterprise untuk melindungi aset digital Anda.",
    icon: "/api/media/file/globe-shield-20-regular.svg",
  },
  {
    title: "Solusi Kustom & Terintegrasi",
    description:
      "Kami merancang dan mengintegrasikan sistem (termasuk ERP, WMS, dan modul SAP) yang disesuaikan secara presisi dengan alur kerja spesifik perusahaan.",
    icon: "/api/media/file/app-generic-20-regular.svg",
  },
  {
    title: "Skalabilitas Fleksibel",
    description:
      "Mengembangkan infrastruktur dan aplikasi yang dirancang untuk dapat diskalakan (scalable) dengan mudah seiring dengan percepatan pertumbuhan bisnis Anda.",
    icon: "/api/media/file/chart-dashboard.svg",
  },
  {
    title: "Keahlian Teknis Terpadu",
    description:
      "Menggabungkan keahlian teknis yang mendalam, desain kreatif (UI/UX), dan wawasan strategis untuk memecahkan berbagai kompleksitas operasional.",
    icon: "/api/media/file/person-24-regular.svg",
  },
  {
    title: "Inovasi yang Berkelanjutan",
    description:
      "Selalu selangkah di depan dalam mengadopsi teknologi mutakhir guna memastikan bisnis Anda tetap adaptif di era lanskap digital yang dinamis.",
    icon: "/api/media/file/chart-person-24-regular.svg",
  },
  {
    title: "Kemitraan Jangka Panjang",
    description:
      "Kami bukan sekadar vendor, melainkan mitra strategis yang membangun kolaborasi jangka panjang berdasarkan kepercayaan, kualitas, dan kesuksesan bersama.",
    icon: "/api/media/file/calendar-arrow-counterclockwise-24-regular.svg",
  },
];

export default function Problem() {
  return (
    <section className="w-full relative overflow-hidden flex flex-col items-center bg-[#7eb2fc]/5 px-4 lg:px-[120px] 2xl:px-[240px] py-[50px] gap-10 text-[#010101]">
      <div className="flex flex-col items-center gap-4 text-center">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] text-[14px] font-medium leading-[120%] tracking-wide uppercase">
          PROBLEM
        </div>

        <h2 className="text-[32px] md:text-[46px] font-bold leading-[125%]">
          Mengapa Memilih Mirai Softnet?
        </h2>

        <p className="text-[16px] leading-[180%] font-medium text-[#010101]/80 mt-1">
          Dedikasi utama kami adalah mendukung pertumbuhan bisnis Anda melalui
          kombinasi keahlian teknis terpadu, inovasi tanpa henti,{" "}
          <br className="hidden md:block" />
          serta wawasan strategis yang dirancang khusus untuk kebutuhan industri
          Anda.
        </p>
      </div>

      <div className="w-full grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 items-stretch">
        {data.map((card, index) => (
          <div
            key={index}
            className="bg-[#fdfdfd] shadow-[3px_3px_8px_1px_rgba(0,0,0,0.1)] rounded-xl flex flex-col items-start p-6 lg:p-[24px_28px] gap-4 transition-transform hover:-translate-y-1 hover:shadow-lg duration-300"
          >
            <div className="bg-[#7eb2fc]/10 rounded-xl p-2 shrink-0 flex items-center justify-center">
              <Image
                src={card.icon}
                alt={`${card.title} Icon`}
                width={48}
                height={48}
                className="w-12 h-12 object-contain"
              />
            </div>

            <div className="flex flex-col gap-2 mt-1">
              <h3 className="text-[20px] font-bold leading-[125%]">
                {card.title}
              </h3>
              <p className="text-[15px] font-medium leading-[180%] text-[#010101]/80">
                {card.description}
              </p>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
