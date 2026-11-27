"use client";

import { useId, useRef, useState, type KeyboardEvent } from "react";
import Image from "@/components/ui/Image";
import SectionLabel from "@/components/ui/SectionLabel";
import { Product } from "../../../../payload-types";

interface ProductWorkflowProps {
  product: Product;
}

type FlowDirection = "right" | "left" | "down";

const STEPS_PER_ROW = 2;

function FlowArrow({ direction }: { direction: FlowDirection }) {
  const paths: Record<FlowDirection, string> = {
    right: "M2 12h24m-7-7 7 7-7 7",
    left: "M30 12H6m7-7-7 7 7 7",
    down: "M12 2v16m-7-7 7 7 7-7",
  };

  return (
    <svg
      aria-hidden="true"
      className="text-primary"
      width={direction === "down" ? 24 : 32}
      height={24}
      viewBox={direction === "down" ? "0 0 24 24" : "0 0 32 24"}
      fill="none"
      focusable="false"
    >
      <path
        d={paths[direction]}
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

export default function ProductWorkflow({ product }: ProductWorkflowProps) {
  const tracks = (product.workflowTracks ?? []).filter(
    (track) => track.steps && track.steps.length > 0,
  );
  const workflowImage =
    product.workflowImage && typeof product.workflowImage === "object"
      ? product.workflowImage
      : null;
  const workflowImageUrl = workflowImage?.url;
  const [activeTrackIndex, setActiveTrackIndex] = useState(0);
  const tabRefs = useRef<Array<HTMLButtonElement | null>>([]);
  const tabsId = useId();

  if (tracks.length === 0 && !workflowImageUrl) return null;

  const selectTrackWithKeyboard = (
    event: KeyboardEvent<HTMLButtonElement>,
    currentIndex: number,
  ) => {
    let nextIndex: number;

    switch (event.key) {
      case "ArrowRight":
        nextIndex = (currentIndex + 1) % tracks.length;
        break;
      case "ArrowLeft":
        nextIndex = (currentIndex - 1 + tracks.length) % tracks.length;
        break;
      case "Home":
        nextIndex = 0;
        break;
      case "End":
        nextIndex = tracks.length - 1;
        break;
      default:
        return;
    }

    event.preventDefault();
    setActiveTrackIndex(nextIndex);
    tabRefs.current[nextIndex]?.focus();
  };

  return (
    <section className="w-full bg-brand-100/10 px-4 py-10 sm:px-8 sm:py-14 lg:px-30 lg:py-16 2xl:px-[calc(50vw-600px)]">
      <div className="mx-auto flex max-w-300 flex-col items-center gap-8 lg:gap-10">
        <div className="flex max-w-225 flex-col items-center gap-3 text-center">
          <SectionLabel align="center">Cara Kerja</SectionLabel>
          <h2 className="text-[28px] font-bold leading-[125%] text-[#010101] sm:text-[34px] lg:text-[40px]">
            {product.workflowTitle || `Bagaimana ${product.name} bekerja?`}
          </h2>
          {product.workflowDescription && (
            <p className="max-w-3xl text-[14px] leading-[165%] text-[#010101]/70 sm:text-[16px]">
              {product.workflowDescription}
            </p>
          )}
        </div>

        <div className="w-full">
          {workflowImageUrl ? (
            <div className="relative mx-auto aspect-[1.7/1] w-full max-w-[1200px] overflow-hidden rounded-3xl bg-[#fdfdfd] shadow-[3px_5px_12px_1px_rgba(0,0,0,0.06)] sm:aspect-[2/1] lg:aspect-[2.3/1]">
              <Image
                src={workflowImageUrl}
                alt={workflowImage.alt || `${product.name} - Cara Kerja`}
                fill
                sizes="(max-width: 1280px) 100vw, 1200px"
                className="object-cover"
              />
            </div>
          ) : (
            <>
              {tracks.length > 1 && (
                <div className="mx-auto mb-8 flex w-max max-w-full gap-2 overflow-x-auto rounded-2xl border border-gray-200 bg-[#fdfdfd] p-1">
                  <div
                    className="flex flex-nowrap items-center gap-2"
                    role="tablist"
                    aria-label="Pilih jalur rekrutmen"
                    aria-orientation="horizontal"
                  >
                    {tracks.map((track, index) => (
                      <button
                        key={track.id || index}
                        ref={(element) => {
                          tabRefs.current[index] = element;
                        }}
                        id={`${tabsId}-tab-${index}`}
                        type="button"
                        role="tab"
                        aria-selected={activeTrackIndex === index}
                        aria-controls={`${tabsId}-panel-${index}`}
                        tabIndex={activeTrackIndex === index ? 0 : -1}
                        onClick={() => setActiveTrackIndex(index)}
                        onKeyDown={(event) =>
                          selectTrackWithKeyboard(event, index)
                        }
                        className={`whitespace-nowrap rounded-xl px-5 py-2 text-[15px] font-semibold transition-colors focus-visible:outline focus-visible:outline-offset-2 focus-visible:outline-primary sm:px-6 sm:text-[16px] ${
                          activeTrackIndex === index
                            ? "bg-primary text-[#fdfdfd]"
                            : "bg-[#fdfdfd] text-[#010101] hover:bg-gray-100"
                        }`}
                      >
                        {track.name}
                      </button>
                    ))}
                  </div>
                </div>
              )}

              {tracks.map((track, trackIndex) => {
                const steps = track.steps ?? [];
                const rows = Array.from(
                  { length: Math.ceil(steps.length / STEPS_PER_ROW) },
                  (_, rowIndex) =>
                    steps.slice(
                      rowIndex * STEPS_PER_ROW,
                      (rowIndex + 1) * STEPS_PER_ROW,
                    ),
                );

                return (
                  <article
                    key={track.id || trackIndex}
                    id={`${tabsId}-panel-${trackIndex}`}
                    role={tracks.length > 1 ? "tabpanel" : undefined}
                    aria-labelledby={
                      tracks.length > 1
                        ? `${tabsId}-tab-${trackIndex}`
                        : undefined
                    }
                    tabIndex={tracks.length > 1 ? 0 : undefined}
                    hidden={tracks.length > 1 && activeTrackIndex !== trackIndex}
                    className="mx-auto w-full max-w-250 rounded-3xl border border-black/5 bg-[#fdfdfd] p-5 shadow-[3px_5px_12px_1px_rgba(0,0,0,0.06)] focus-visible:outline focus-visible:outline-offset-4 focus-visible:outline-primary sm:p-7"
                  >
                    <div className="mb-7 border-b border-black/5 pb-4">
                      <h3 className="mt-1 text-[20px] font-bold leading-[130%] text-[#010101] sm:text-[24px]">
                        {track.name}
                      </h3>
                      {track.description && (
                        <p className="mt-2 text-[14px] leading-[160%] text-[#010101]/70">
                          {track.description}
                        </p>
                      )}
                    </div>

                    <div
                      className="space-y-6 lg:space-y-10"
                      role="group"
                      aria-label={`Alur ${track.name}`}
                    >
                      {rows.map((row, rowIndex) => {
                        const isReverse = rowIndex % 2 === 1;
                        const rowStartIndex = rowIndex * STEPS_PER_ROW;

                        return (
                          <div
                            key={`${track.id || trackIndex}-row-${rowIndex}`}
                            className={`flex flex-col gap-6 lg:flex-row lg:gap-6 ${
                              isReverse ? "lg:flex-row-reverse" : ""
                            }`}
                            role="list"
                            aria-label={`Langkah ${rowStartIndex + 1} sampai ${rowStartIndex + row.length}`}
                          >
                            {row.map((step, visualIndex) => {
                              const stepIndex = rowStartIndex + visualIndex;
                              const isLastInRow =
                                visualIndex === row.length - 1;
                              const hasNextStep = stepIndex < steps.length - 1;
                              const direction = isReverse ? "left" : "right";

                              return (
                                <div
                                  key={step.id || stepIndex}
                                  className="relative min-w-0 flex-1 lg:max-w-[calc(50%-12px)]"
                                  role="listitem"
                                >
                                  <div className="flex h-full min-h-[112px] items-start gap-3 rounded-2xl border border-black/5 bg-brand-100/10 p-4 sm:min-h-32">
                                    <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-primary text-[13px] font-bold text-white">
                                      {String(stepIndex + 1).padStart(2, "0")}
                                    </span>
                                    <div className="flex min-w-0 flex-col gap-1">
                                      <h4 className="text-[15px] font-bold leading-[130%] text-[#010101] sm:text-[16px]">
                                        {step.title}
                                      </h4>
                                      {step.description && (
                                        <p className="text-[13px] leading-[160%] text-[#010101]/70 sm:text-[14px]">
                                          {step.description}
                                        </p>
                                      )}
                                    </div>
                                  </div>

                                  {hasNextStep && (
                                    <>
                                      <span className="absolute -bottom-6 left-1/2 z-10 -translate-x-1/2 text-primary lg:hidden">
                                        <FlowArrow direction="down" />
                                      </span>
                                      <span
                                        className={`absolute top-1/2 z-10 hidden -translate-y-1/2 lg:block ${
                                          isLastInRow
                                            ? "left-1/2 -bottom-10 top-auto -translate-x-1/2 translate-y-0"
                                            : isReverse
                                              ? "-left-7"
                                              : "-right-7"
                                        }`}
                                      >
                                        <FlowArrow
                                          direction={
                                            isLastInRow ? "down" : direction
                                          }
                                        />
                                      </span>
                                    </>
                                  )}
                                </div>
                              );
                            })}
                          </div>
                        );
                      })}
                    </div>
                  </article>
                );
              })}
            </>
          )}
        </div>
      </div>
    </section>
  );
}
