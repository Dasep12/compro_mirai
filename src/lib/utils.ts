import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";
import type { Media } from "../../payload-types";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

/**
 * Ambil URL varian gambar yang sudah di-resize/dikompres Payload (thumbnail/card/hero)
 * alih-alih file master, supaya listing/grid tidak menarik gambar resolusi penuh.
 * Fallback ke `url` (master) kalau media belum ter-populate atau varian belum ada
 * (misal upload lama sebelum varian ini ditambahkan).
 */
export function getMediaUrl(
  media: number | Media | null | undefined,
  size?: "thumbnail" | "card" | "hero",
): string | null {
  if (!media || typeof media !== "object") return null;
  const sized = size ? media.sizes?.[size]?.url : null;
  return sized || media.url || null;
}

export function generateSlug(text: string): string {
  return text
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9\s-]/g, "")
    .replace(/\s+/g, "-");
}

export function formatRupiah(amount: number): string {
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
    minimumFractionDigits: 0,
  }).format(amount);
}

export function truncate(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text;
  return text.slice(0, maxLength).trimEnd() + "...";
}
