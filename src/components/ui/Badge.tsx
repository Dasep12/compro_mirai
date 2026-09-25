import React from "react";

export type BadgeColor =
  | "blue"
  | "teal"
  | "orange"
  | "purple"
  | "green"
  | "gray"
  | string;

export type BadgeSize = "sm" | "md" | "lg";
export type BadgeVariant = "solid" | "soft";

export interface BadgeProps
  extends Omit<React.HTMLAttributes<HTMLSpanElement>, "color"> {
  color?: BadgeColor | null;
  size?: BadgeSize;
  variant?: BadgeVariant;
  icon?: React.ReactNode;
  children: React.ReactNode;
  className?: string;
}

/**
 * Returns Tailwind classNames for badge colors
 */
export function getBadgeColorClass(
  color?: BadgeColor | null,
  variant: BadgeVariant = "solid"
): string {
  const c = color?.toLowerCase() || "teal";

  if (variant === "soft") {
    switch (c) {
      case "blue":
        return "bg-blue-50 text-[#0451bf] border border-[#0451bf]/20";
      case "orange":
        return "bg-amber-50 text-[#f58220] border border-[#f58220]/25";
      case "purple":
        return "bg-purple-50 text-purple-700 border border-purple-200/80";
      case "green":
        return "bg-emerald-50 text-emerald-700 border border-emerald-200/80";
      case "red":
      case "coral":
        return "bg-rose-50 text-[#e02d3c] border border-[#e02d3c]/20";
      case "gray":
        return "bg-gray-100 text-gray-700 border border-gray-200";
      case "teal":
      default:
        return "bg-teal-50 text-[#009688] border border-[#009688]/25";
    }
  }

  // Default: Solid variant
  switch (c) {
    case "blue":
      return "bg-[#0451bf] text-white shadow-xs";
    case "orange":
      return "bg-[#f58220] text-white shadow-xs";
    case "purple":
      return "bg-[#7c3aed] text-white shadow-xs";
    case "green":
      return "bg-[#059669] text-white shadow-xs";
    case "red":
    case "coral":
      return "bg-[#ea5353] text-white shadow-xs";
    case "gray":
      return "bg-gray-600 text-white shadow-xs";
    case "teal":
    default:
      return "bg-[#009688] text-white shadow-xs";
  }
}

/**
 * Unified Badge / Chip Component
 * Digunakan untuk label sektor industri, kategori solusi, tag berita, dsb
 * Menjamin keseragaman ukuran, proporsi, font, dan bentuk pill di seluruh halaman.
 */
export default function Badge({
  color = "teal",
  size = "md",
  variant = "solid",
  icon,
  children,
  className = "",
  ...props
}: BadgeProps) {
  const colorClass = getBadgeColorClass(color, variant);

  const sizeClass =
    size === "sm"
      ? "text-[11px] px-2.5 py-0.5"
      : size === "lg"
      ? "text-[13px] sm:text-[14px] px-4 py-1.5"
      : "text-[12px] sm:text-[12.5px] px-3 py-1";

  return (
    <span
      className={`inline-flex items-center justify-center gap-1.5 rounded-full font-semibold leading-normal tracking-wide whitespace-nowrap transition-colors select-none ${sizeClass} ${colorClass} ${className}`}
      {...props}
    >
      {icon && <span className="shrink-0">{icon}</span>}
      <span>{children}</span>
    </span>
  );
}

// Alias agar bisa di-import sebagai Chip maupun Badge
export { Badge as Chip };
