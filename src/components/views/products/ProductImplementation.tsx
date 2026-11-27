import { Clock } from "lucide-react";
import Image from "@/components/ui/Image";
import SectionLabel from "@/components/ui/SectionLabel";
import { Product } from "../../../../payload-types";

interface ProductImplementationProps {
  product: Product;
}

const formatStep = (index: number) => String(index + 1).padStart(2, "0");

export default function ProductImplementation({
  product,
}: ProductImplementationProps) {
  const steps = product.implementationSteps ?? [];
  const implementationImage =
    product.implementationImage &&
    typeof product.implementationImage === "object"
      ? product.implementationImage
      : null;
  const implementationImageUrl = implementationImage?.url;
  if (steps.length === 0 && !implementationImageUrl) return null;

  return (
    <section className="w-full bg-brand-100/10 px-4 py-12 text-[#010101] sm:px-8 sm:py-16 lg:px-[120px] lg:py-20 2xl:px-[calc(50vw-600px)]">
      <div className="mx-auto grid max-w-[1200px] gap-10 lg:grid-cols-[0.8fr_1.2fr] lg:gap-16">
        <header className="flex flex-col items-start gap-5 lg:sticky lg:top-28 lg:h-fit">
          <SectionLabel>Penerapan Produk</SectionLabel>
          <h2 className="text-[30px] font-bold leading-[125%] sm:text-[38px] lg:text-[46px]">
            {product.implementationTitle ||
              `Tahapan penerapan ${product.name}`}
          </h2>
          {product.implementationDescription && (
            <p className="max-w-[440px] text-[15px] leading-[170%] text-[#010101]/70 sm:text-[16px]">
              {product.implementationDescription}
            </p>
          )}
        </header>

        {implementationImageUrl ? (
          <div className="relative mx-auto aspect-[1.7/1] w-full overflow-hidden rounded-3xl bg-[#fdfdfd] shadow-[3px_5px_12px_1px_rgba(0,0,0,0.06)] sm:aspect-[2/1] lg:aspect-[2.3/1]">
            <Image
              src={implementationImageUrl}
              alt={
                implementationImage.alt ||
                `${product.name} - Tahapan Penerapan`
              }
              fill
              sizes="(max-width: 1280px) 100vw, 1200px"
              className="object-cover"
            />
          </div>
        ) : (
          <ol className="flex flex-col">
            {steps.map((step, index) => (
              <li
                key={step.id || index}
                className="grid grid-cols-[48px_1fr] gap-4 sm:grid-cols-[56px_1fr] sm:gap-6"
              >
                <div className="relative flex justify-center">
                  <span
                    className={`relative z-10 flex h-10 w-10 items-center justify-center rounded-full text-[13px] font-bold sm:h-12 sm:w-12 sm:text-[14px] ${
                      index === 0
                        ? "bg-primary text-[#fdfdfd]"
                        : "border border-primary/30 bg-[#fdfdfd] text-primary"
                    }`}
                  >
                    {formatStep(index)}
                  </span>
                  {index < steps.length - 1 && (
                    <span
                      aria-hidden="true"
                      className="absolute bottom-0 top-10 w-px bg-primary/25 sm:top-12"
                    />
                  )}
                </div>

                <div
                  className={`pb-8 sm:pb-10 ${
                    index < steps.length - 1 ? "border-b border-black/10" : ""
                  }`}
                >
                  <div className="flex flex-wrap items-center justify-between gap-3">
                    <h3 className="text-[18px] font-bold leading-[135%] sm:text-[21px]">
                      {step.title}
                    </h3>
                    {step.duration && (
                      <span className="inline-flex items-center gap-1.5 rounded-full bg-[#fdfdfd] px-3 py-1 text-[12px] font-semibold text-primary sm:text-[13px]">
                        <Clock aria-hidden="true" className="h-3.5 w-3.5" />
                        {step.duration}
                      </span>
                    )}
                  </div>
                  {step.description && (
                    <p className="mt-2 max-w-[620px] text-[14px] leading-[165%] text-[#010101]/70 sm:text-[15px]">
                      {step.description}
                    </p>
                  )}
                </div>
              </li>
            ))}
          </ol>
        )}
      </div>
    </section>
  );
}
