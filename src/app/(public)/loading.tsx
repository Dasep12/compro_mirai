export default function Loading() {
  return (
    <div className="w-full flex-1 flex flex-col items-center justify-center min-h-[60vh] gap-3">
      <style
        dangerouslySetInnerHTML={{
          __html: `
            @keyframes loading-slide {
              0% { transform: translateX(-100%); }
              100% { transform: translateX(200%); }
            }
            .animate-loading-slide {
              animation: loading-slide 1.5s infinite ease-in-out;
            }
          `,
        }}
      />

      <div className="w-[200px] md:w-[300px] h-[6px] bg-base-100/30 rounded-full overflow-hidden relative">
        <div className="absolute top-0 left-0 h-full w-1/2 bg-linear-to-r from-[#0451bf] to-secondary-300 rounded-full animate-loading-slide"></div>
      </div>

      <span className="text-[13px] font-medium text-primary animate-pulse tracking-wide">
        Memuat halaman...
      </span>
    </div>
  );
}
