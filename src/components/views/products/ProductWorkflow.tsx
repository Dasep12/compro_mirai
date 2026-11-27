import Image from "@/components/ui/Image";
import SectionLabel from "@/components/ui/SectionLabel";
import { Product } from "../../../../payload-types";

interface ProductWorkflowProps {
  product: Product;
}

const STEPS_PER_ROW = 4;

export default function ProductWorkflow({ product }: ProductWorkflowProps) {
  const steps = product.workflowSteps ?? [];
  const workflowImage =
    product.workflowImage && typeof product.workflowImage === "object"
      ? product.workflowImage
      : null;
  const workflowImageUrl = workflowImage?.url;

  if (steps.length === 0 && !workflowImageUrl) return null;

  return (
    <section className="w-full px-4 py-10 text-[#010101] sm:px-8 sm:py-14 lg:px-[120px] lg:py-16 xl:py-[80px] 2xl:px-[calc(50vw-600px)]">
      <div className="mx-auto flex max-w-[1200px] flex-col gap-10">
        <header className="flex flex-col items-center gap-5 text-center">
          <SectionLabel align="center">Cara Kerja</SectionLabel>
          <h2 className="max-w-[760px] text-[30px] font-bold leading-[125%] sm:text-[38px] lg:text-[46px]">
            {product.workflowTitle || `Cara kerja ${product.name}`}
          </h2>
          {product.workflowDescription && (
            <p className="max-w-[760px] text-[15px] leading-[170%] text-[#010101]/70 sm:text-[16px]">
              {product.workflowDescription}
            </p>
          )}
        </header>

        {steps.length > 0 && (
          <ol
            aria-label="Urutan cara kerja produk"
            className="relative mt-4 flex flex-col gap-8 lg:grid lg:grid-cols-4 lg:gap-x-10 lg:gap-y-[60px]"
          >
            <span
              aria-hidden="true"
              className="absolute bottom-4 left-[19px] top-4 border-l-2 border-dashed border-primary/40 lg:hidden"
            />
            {steps.map((step, index) => {
              const row = Math.floor(index / STEPS_PER_ROW);
              const isEvenRow = row % 2 === 0;
              const column = isEvenRow
                ? index % STEPS_PER_ROW
                : STEPS_PER_ROW - 1 - (index % STEPS_PER_ROW);
              const isLastItem = index === steps.length - 1;
              const drawRight =
                isEvenRow && column < STEPS_PER_ROW - 1 && !isLastItem;
              const drawLeft = !isEvenRow && column > 0 && !isLastItem;
              const drawDown =
                ((isEvenRow && column === STEPS_PER_ROW - 1) ||
                  (!isEvenRow && column === 0)) &&
                !isLastItem;

              return (
                <li
                  key={step.id || index}
                  className="group relative z-10 flex items-start gap-6 lg:flex-col lg:items-center lg:gap-0 lg:text-center"
                  style={{
                    gridRow: row + 1,
                    gridColumn: column + 1,
                  }}
                >
                  {drawRight && (
                    <div className="absolute left-[50%] top-[19px] -z-10 hidden w-[calc(100%+40px)] border-t-2 border-dashed border-primary/40 lg:block" />
                  )}
                  {drawLeft && (
                    <div className="absolute right-[50%] top-[19px] -z-10 hidden w-[calc(100%+40px)] border-t-2 border-dashed border-primary/40 lg:block" />
                  )}
                  {drawDown && (
                    <div className="absolute left-[calc(50%-1px)] top-[19px] -z-10 hidden h-[calc(100%+60px)] border-l-2 border-dashed border-primary/40 lg:block" />
                  )}

                  <div className="relative z-10 flex h-10 w-10 shrink-0 items-center justify-center lg:cursor-pointer">
                    <span
                      aria-hidden="true"
                      className="absolute inset-0 rounded-full bg-[#7eb2fc]/40 opacity-30 transition-opacity duration-300 group-hover:opacity-60"
                    />
                    <span
                      aria-hidden="true"
                      className="relative flex h-7 w-7 items-center justify-center rounded-full border-[3px] border-primary bg-white text-[11px] font-bold text-primary shadow-sm transition-all duration-300 group-hover:scale-125 group-hover:bg-primary group-hover:text-white"
                    >
                      {index + 1}
                    </span>
                  </div>

                  <article className="mt-[-6px] flex flex-1 flex-col items-start gap-2 rounded-xl border border-gray-100 bg-white p-5 shadow-[3px_3px_8px_1px_rgba(0,0,0,0.06)] transition-transform group-hover:-translate-y-1 group-hover:shadow-lg lg:mt-4 lg:h-full lg:w-full lg:items-center lg:p-6">
                    <h3 className="text-[16px] font-bold leading-[130%] text-[#010101] sm:text-[18px]">
                      {step.title}
                    </h3>
                    {step.description && (
                      <p className="text-[13px] font-medium leading-[160%] text-[#010101]/70 sm:text-[14px] sm:leading-[170%]">
                        {step.description}
                      </p>
                    )}
                  </article>
                </li>
              );
            })}
          </ol>
        )}

        {workflowImageUrl && (
          <div className="w-full">
            <Image
              src={workflowImageUrl}
              alt={workflowImage.alt || `${product.name} - Diagram Cara Kerja`}
              width={workflowImage.width || 1200}
              height={workflowImage.height || 600}
              sizes="100vw"
              className="!h-auto !w-full !overflow-visible !rounded-none object-contain"
            />
          </div>
        )}
      </div>
    </section>
  );
}
