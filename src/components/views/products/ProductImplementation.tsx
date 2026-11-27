import type { ReactNode } from "react";
import { ChevronDown, ChevronLeft, ChevronRight, Clock } from "lucide-react";
import { Product } from "../../../../payload-types";

interface ProductImplementationProps {
  product: Product;
}

const COLUMNS = 3;

const formatStep = (index: number) => String(index + 1).padStart(2, "0");

export default function ProductImplementation({ product }: ProductImplementationProps) {
  const steps = product.implementationSteps ?? [];
  if (steps.length === 0) return null;

  const lastIndex = steps.length - 1;

  return (
    <section className="w-full relative overflow-hidden bg-brand-100/10 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 xl:py-[80px] flex flex-col items-center gap-10 sm:gap-12 lg:gap-[60px] text-[#010101]">
      <div className="flex flex-col items-center gap-3 sm:gap-4 text-center max-w-[800px]">
        <div className="bg-primary text-[#fdfdfd] rounded-full px-[16px] py-[6px] 2xl:px-[20px] 2xl:py-[8px] text-[14px] 2xl:text-[16px] font-medium leading-[120%] tracking-wide uppercase">
          ALUR IMPLEMENTASI
        </div>
        <h2 className="text-[28px] sm:text-[34px] lg:text-[40px] xl:text-[46px] font-bold leading-[125%]">
          {product.implementationTitle || `Langkah mudah menuju implementasi ${product.name}`}
        </h2>
        {product.implementationDescription && (
          <p className="text-[15px] sm:text-[16px] text-[#010101]/70 leading-relaxed">
            {product.implementationDescription}
          </p>
        )}
      </div>

      <div className="w-full">
        {/* Mobile & tablet: timeline vertikal */}
        <ol className="flex flex-col gap-6 relative lg:hidden">
          {steps.length > 1 && (
            <div className="absolute top-6 bottom-6 left-[23px] w-[2px] bg-primary/25" />
          )}

          {steps.map((step, index) => {
            const isLast = index === lastIndex;

            return (
              <li key={step.id || index} className="flex items-start gap-5 relative">
                <div
                  className={`relative z-10 w-12 h-12 shrink-0 rounded-full flex items-center justify-center text-[15px] font-bold shadow-sm ${
                    isLast
                      ? "bg-primary text-[#fdfdfd]"
                      : "bg-[#fdfdfd] text-primary border-2 border-primary"
                  }`}
                >
                  {formatStep(index)}
                </div>

                <StepCard
                  title={step.title}
                  description={step.description}
                  duration={step.duration}
                  isLast={isLast}
                />
              </li>
            );
          })}
        </ol>

        {/* Desktop: pola ular kiri → kanan, turun, kanan → kiri */}
        <ol className="hidden lg:grid grid-cols-3 gap-y-[60px] gap-x-[48px] w-full relative">
          {steps.map((step, i) => {
            const row = Math.floor(i / COLUMNS);
            const isEvenRow = row % 2 === 0;
            const col = isEvenRow ? i % COLUMNS : COLUMNS - 1 - (i % COLUMNS);
            const isLast = i === lastIndex;

            const drawRight = isEvenRow && col < COLUMNS - 1 && !isLast;
            const drawLeft = !isEvenRow && col > 0 && !isLast;
            const drawDown =
              ((isEvenRow && col === COLUMNS - 1) || (!isEvenRow && col === 0)) && !isLast;

            return (
              <li
                key={step.id || i}
                className="relative flex flex-col items-start z-10 group"
                style={{ gridRow: row + 1, gridColumn: col + 1 }}
              >
                {drawRight && (
                  <>
                    <div className="absolute top-[23px] left-[24px] w-[calc(100%+48px)] h-[2px] bg-primary/25 -z-10" />
                    <Arrow className="top-[24px] left-[calc(100%+24px)]">
                      <ChevronRight className="w-4 h-4" />
                    </Arrow>
                  </>
                )}
                {drawLeft && (
                  <>
                    <div className="absolute top-[23px] right-[calc(100%-24px)] w-[calc(100%+48px)] h-[2px] bg-primary/25 -z-10" />
                    <Arrow className="top-[24px] left-[-24px]">
                      <ChevronLeft className="w-4 h-4" />
                    </Arrow>
                  </>
                )}
                {drawDown && (
                  <>
                    <div className="absolute top-[24px] left-[23px] h-[calc(100%+60px)] w-[2px] bg-primary/25 -z-10" />
                    <Arrow className="top-[calc(100%+30px)] left-[24px]">
                      <ChevronDown className="w-4 h-4" />
                    </Arrow>
                  </>
                )}

                <div
                  className={`relative w-12 h-12 shrink-0 rounded-full flex items-center justify-center text-[15px] font-bold shadow-sm transition-all duration-300 group-hover:scale-110 ${
                    isLast
                      ? "bg-primary text-[#fdfdfd]"
                      : "bg-[#fdfdfd] text-primary border-2 border-primary group-hover:bg-primary group-hover:text-[#fdfdfd]"
                  }`}
                >
                  {formatStep(i)}
                </div>

                <div className="mt-5 w-full flex-1 flex">
                  <StepCard
                    title={step.title}
                    description={step.description}
                    duration={step.duration}
                    isLast={isLast}
                  />
                </div>
              </li>
            );
          })}
        </ol>
      </div>
    </section>
  );
}

interface StepCardProps {
  title: string;
  description?: string | null;
  duration?: string | null;
  isLast: boolean;
}

function StepCard({ title, description, duration, isLast }: StepCardProps) {
  return (
    <div
      className={`flex-1 w-full bg-[#fdfdfd] rounded-[20px] p-5 sm:p-6 flex flex-col items-start gap-2 sm:gap-3 border shadow-[3px_3px_8px_1px_rgba(0,0,0,0.05)] transition-all duration-300 hover:-translate-y-1 hover:shadow-lg ${
        isLast ? "border-primary" : "border-black/5 hover:border-primary/60"
      }`}
    >
      {duration && (
        <span className="inline-flex items-center gap-1.5 text-[12px] sm:text-[13px] font-semibold text-primary bg-brand-100/25 px-3 py-1 rounded-full">
          <Clock className="w-3.5 h-3.5" />
          {duration}
        </span>
      )}
      <h3 className="text-[17px] sm:text-[19px] font-bold leading-[130%] text-[#010101]">
        {title}
      </h3>
      {description && (
        <p className="text-[14px] sm:text-[15px] font-medium leading-[165%] text-[#010101]/70">
          {description}
        </p>
      )}
    </div>
  );
}

function Arrow({ className, children }: { className: string; children: ReactNode }) {
  return (
    <div
      className={`absolute z-10 -translate-x-1/2 -translate-y-1/2 w-7 h-7 rounded-full bg-[#fdfdfd] border border-primary/30 text-primary flex items-center justify-center shadow-sm ${className}`}
    >
      {children}
    </div>
  );
}
