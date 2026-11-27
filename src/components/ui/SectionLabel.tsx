import type { ReactNode } from "react";

interface SectionLabelProps {
  children: ReactNode;
  tone?: "brand" | "inverse";
  align?: "start" | "center";
}

export default function SectionLabel({
  children,
  tone = "brand",
  align = "start",
}: SectionLabelProps) {
  const isInverse = tone === "inverse";
  const isCentered = align === "center";

  return (
    <div
      className={`flex items-center gap-3 ${
        isCentered ? "w-full justify-center text-center" : ""
      }`}
    >
      <span
        aria-hidden="true"
        className={`h-[2px] ${isCentered ? "w-6 sm:w-8" : "w-8"} ${
          isInverse ? "bg-white/70" : "bg-primary"
        }`}
      />
      <span
        className={`shrink-0 text-[13px] font-semibold uppercase tracking-[0.16em] sm:text-[14px] ${
          isInverse ? "text-white/75" : "text-primary"
        }`}
      >
        {children}
      </span>
      {isCentered && (
        <span
          aria-hidden="true"
          className={`h-[2px] w-6 sm:w-8 ${
            isInverse ? "bg-white/70" : "bg-primary"
          }`}
        />
      )}
    </div>
  );
}
