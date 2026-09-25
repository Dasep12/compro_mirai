"use client";

import { useState } from "react";
import Link from "next/link";
import Image from "@/components/ui/Image";
import { RichText } from "@payloadcms/richtext-lexical/react";
import { getMediaUrl } from "@/lib/utils";
import { generateWhatsAppUrl } from "@/lib/whatsapp";
import Badge from "@/components/ui/Badge";
import {
  Layers,
  Calendar,
  Share2,
  Check,
  ArrowRight,
} from "lucide-react";
import type { Industry, PartnershipSolution, Solution, SolutionCategory } from "../../../../payload-types";

interface SolutionDetailProps {
  solution: Solution;
}

export default function SolutionDetail({ solution }: SolutionDetailProps) {
  const [copied, setCopied] = useState(false);

  // Industry classification
  const industryObj =
    typeof solution.industry === "object" && solution.industry !== null
      ? (solution.industry as Industry)
      : null;
  const industryLabel = industryObj?.name || "General Industry";

  // Formatted publication date
  const formattedDate = solution.publishedDate
    ? new Date(solution.publishedDate).toLocaleDateString("id-ID", {
        day: "numeric",
        month: "long",
        year: "numeric",
      })
    : "";

  // Cover image URL
  const coverUrl =
    getMediaUrl(solution.coverImage, "hero") ||
    (typeof solution.coverImage === "object" ? solution.coverImage?.url : null);

  // Partnership brands
  const partnershipsList = (solution.partnership_solution || [])
    .map((p) => (typeof p === "object" && p !== null ? (p as PartnershipSolution) : null))
    .filter((p): p is PartnershipSolution => p !== null);

  // WhatsApp consultation link
  const waMessage = `Halo Tim Mirai Softnet Technology,\n\nSaya tertarik berkonsultasi mengenai solusi: *${solution.title}*.\n\nMohon informasi teknis, arsitektur, dan estimasi implementasinya untuk perusahaan kami.\nTerima kasih.`;
  const waUrl = generateWhatsAppUrl({ message: waMessage });

  // Copy URL to clipboard
  const handleCopyLink = () => {
    if (typeof window !== "undefined") {
      navigator.clipboard.writeText(window.location.href);
      setCopied(true);
      setTimeout(() => setCopied(false), 2500);
    }
  };

  return (
    <article className="w-full relative flex flex-col items-center px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-6 sm:py-10 lg:py-14 gap-8 sm:gap-10 lg:gap-12 text-[#010101] bg-[#fdfdfd] font-sans">
      {/* 1. TOP NAVIGATION & BREADCRUMBS */}
      <div className="w-full flex flex-col sm:flex-row sm:items-center justify-between gap-3 sm:gap-4">
        {/* Tombol Kembali (Dipertahankan sesuai permintaan) */}
        <Link
          href="/solution"
          className="group rounded-[10px] bg-[#fdfdfd] border-none flex items-center gap-[10px] p-1.5 sm:p-2 text-[#0451bf] font-semibold text-[14px] sm:text-[16px] leading-[175%] no-underline hover:opacity-80 transition-all duration-300 hover:-translate-x-1 w-fit"
        >
          <svg
            className="w-[20px] h-[20px] sm:w-[23px] sm:h-[23px]"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={2.5}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M10 19l-7-7m0 0l7-7m-7 7h18"
            />
          </svg>
          <span>Kembali ke Solusi</span>
        </Link>

        {/* Breadcrumb Navigation */}
        <nav className="text-[12px] sm:text-[13px] text-gray-500 flex flex-wrap items-center gap-1.5 self-start sm:self-auto">
          <Link href="/" className="hover:text-primary transition-colors">
            Home
          </Link>
          <span>/</span>
          <Link href="/solution" className="hover:text-primary transition-colors">
            Solusi
          </Link>
          <span>/</span>
          <span className="text-gray-800 font-medium truncate max-w-[200px] sm:max-w-xs">
            {solution.title}
          </span>
        </nav>
      </div>

      {/* 2. EXECUTIVE HERO HEADER */}
      <header className="w-full flex flex-col items-start gap-4 sm:gap-5">
        {/* Category & Metadata Pills Bar */}
        <div className="w-full flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          {/* Left: Badges */}
          <h1 className="text-[26px] sm:text-[36px] lg:text-[42px] font-bold leading-[125%] text-[#010101] tracking-tight text-left">
            {solution.title}
          </h1>

          {/* Right: Publication Date */}
          {formattedDate && (
            <span className="inline-flex items-center gap-1.5 text-[12px] sm:text-[13px] text-gray-500 font-medium shrink-0 self-start sm:self-auto">
              <Calendar className="w-3.5 h-3.5 text-gray-400" />
              <span>{formattedDate}</span>
            </span>
          )}
        </div>


        {/* Ringkasan Eksekutif (Excerpt / Lead Summary) */}
        {solution.excerpt && (
          <div className="w-full relative pl-4 sm:pl-5 pr-4 py-3.5 sm:py-4 border-l-4 border-primary bg-primary/5 rounded-r-xl">
            <p className="text-[15px] sm:text-[17px] font-normal leading-[180%] text-gray-700 text-left">
              {solution.excerpt}
            </p>
          </div>
        )}
      </header>

      {/* 3. CINEMATIC HERO COVER BANNER */}
      <section className="w-full">
        <div className="w-full aspect-[16/9] sm:aspect-[21/9] lg:aspect-[2.3/1] max-h-[480px] rounded-[18px] sm:rounded-[24px] overflow-hidden relative shadow-[0_8px_30px_rgba(0,0,0,0.06)] border border-gray-100 bg-gray-50 group">
          {coverUrl ? (
            <Image
              src={coverUrl}
              alt={solution.title}
              fill
              priority
              sizes="(max-width: 1280px) 100vw, 1200px"
              className="object-cover group-hover:scale-[1.015] transition-transform duration-700 ease-out"
            />
          ) : (
            <div className="w-full h-full flex flex-col items-center justify-center text-gray-400 gap-2">
              <Layers className="w-10 h-10 text-gray-300" />
              <span className="text-sm font-medium">Use Case Illustration</span>
            </div>
          )}

          {/* Floating Subtle Badge di Banner */}
          <div className="absolute bottom-3 left-3 sm:bottom-4 sm:left-4 bg-white/90 backdrop-blur-md px-3 py-1.5 rounded-full border border-white/60 shadow-xs flex items-center gap-2 text-[11px] sm:text-[12px] font-semibold text-gray-800">
            <span className="w-2 h-2 rounded-full bg-[#0451bf] animate-pulse" />
            <span>Mirai Enterprise Solution</span>
          </div>
        </div>
      </section>

      {/* 4. MAIN EDITORIAL CONTENT & ENTERPRISE SPECIFICATION SIDEBAR (70% - 30%) */}
      <div className="w-full grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 items-start">
        {/* LEFT COLUMN: ARTIKEL DEEP-DIVE & DETAIL (Col 8) */}
        <div className="w-full lg:col-span-8 flex flex-col gap-8 sm:gap-10">
          {/* RichText Content Body */}
          {solution.description ? (
            <div className="w-full flex flex-col gap-4 text-left">

              <div
                className="w-full text-[15px] sm:text-[16px] leading-[185%] font-normal text-[#010101]/90 text-left whitespace-pre-line break-words
        [&_h1]:text-[24px] [&_h1]:sm:text-[28px] [&_h1]:md:text-[32px] [&_h1]:font-bold [&_h1]:leading-[130%] [&_h1]:text-[#010101] [&_h1]:mb-3 [&_h1]:mt-6
        [&_h2]:text-[20px] [&_h2]:sm:text-[23px] [&_h2]:md:text-[26px] [&_h2]:font-bold [&_h2]:leading-[130%] [&_h2]:text-[#010101] [&_h2]:mb-3 [&_h2]:mt-5
        [&_h3]:text-[17px] [&_h3]:sm:text-[20px] [&_h3]:font-bold [&_h3]:leading-[130%] [&_h3]:text-[#010101] [&_h3]:mb-2 [&_h3]:mt-4
        [&_h4]:text-[16px] [&_h4]:sm:text-[18px] [&_h4]:font-bold [&_h4]:leading-[135%] [&_h4]:text-[#010101] [&_h4]:mb-2 [&_h4]:mt-4
        [&_h5]:text-[15px] [&_h5]:sm:text-[16px] [&_h5]:font-bold [&_h5]:leading-[140%] [&_h5]:text-[#010101] [&_h5]:mb-2 [&_h5]:mt-3
        [&_h6]:text-[14px] [&_h6]:font-bold [&_h6]:leading-[150%] [&_h6]:text-[#010101] [&_h6]:mb-2 [&_h6]:mt-3
        [&_p]:mb-4 [&_p]:last:mb-0
        [&_a]:text-[#0451bf] [&_a]:underline [&_a]:font-semibold hover:[&_a]:text-blue-800
        [&_strong]:font-bold [&_strong]:text-[#010101] [&_b]:font-bold
        [&_blockquote]:border-l-4 [&_blockquote]:border-[#0451bf] [&_blockquote]:bg-blue-50/30 [&_blockquote]:py-2 [&_blockquote]:px-4 [&_blockquote]:rounded-r-lg [&_blockquote]:italic [&_blockquote]:text-[#010101]/80 [&_blockquote]:mb-5 [&_blockquote]:my-4
        [&_ul]:list-disc [&_ul]:pl-[22px] [&_ul]:mb-5 [&_ul]:space-y-1.5
        [&_ol]:list-decimal [&_ol]:pl-[22px] [&_ol]:mb-5 [&_ol]:space-y-1.5
        [&_li]:leading-[180%] [&_li]:text-gray-700
        [&_img]:rounded-xl [&_img]:my-6 [&_img]:shadow-sm"
              >
                <RichText data={solution.description} />
              </div>
            </div>
          ) : (
            <div className="w-full p-8 rounded-2xl bg-gray-50 border border-gray-100 text-center text-gray-500">
              Uraian detail use case sedang dalam tahap pembaruan.
            </div>
          )}

          {/* Consultation CTA Banner Box (Cocok untuk Company Profile) */}
          <div className="w-full rounded-[20px] bg-primary text-[#fdfdfd] p-6 sm:p-9 lg:p-10 relative overflow-hidden shadow-sm">
            <div className="flex flex-col items-start gap-4 sm:gap-5">
              <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/15 text-[13px] sm:text-[14px] font-semibold tracking-wide">
                <span>Konsultasi Solusi & Kebutuhan Bisnis</span>
              </div>

              <h3 className="text-[24px] sm:text-[30px] lg:text-[34px] font-bold leading-[125%] text-[#fdfdfd]">
                Ingin Mengimplementasikan Solusi Ini di Perusahaan Anda?
              </h3>

              <p className="text-[15px] sm:text-[16px] lg:text-[17px] leading-[175%] text-white/90 max-w-2xl">
                Diskusikan arsitektur sistem, pemilihan perangkat keras/lunak, dan estimasi biaya implementasi bersama tim engineer berpengalaman dari PT Mirai Softnet Technology.
              </p>

              <div className="flex flex-wrap items-center gap-3 pt-2 w-full sm:w-auto">
                <a
                  href={waUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 px-6 py-3.5 rounded-mirai bg-[#fdfdfd] text-primary font-bold text-[15px] sm:text-[16px] shadow-xs hover:bg-gray-100 transition-all duration-300 hover:scale-[1.02] active:scale-[0.98]"
                >
                  <span>Konsultasi Solusi Ini</span>
                </a>

                <Link
                  href="/solution"
                  className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-mirai bg-white/10 hover:bg-white/20 text-[#fdfdfd] font-semibold text-[15px] sm:text-[16px] transition-all duration-300 border border-white/20"
                >
                  <span>Lihat Solusi Lainnya</span>
                  <ArrowRight className="w-4 h-4" />
                </Link>
              </div>
            </div>
          </div>
        </div>

        {/* RIGHT COLUMN: ENTERPRISE SPECIFICATION & VALUE PROPS SIDEBAR (Col 4 - Sticky) */}
        <aside className="w-full lg:col-span-4 flex flex-col gap-6 lg:sticky lg:top-24">
          {/* Card 1: Quick Specs & Meta */}
          <div className="w-full rounded-[20px] bg-white border border-gray-100 shadow-[0_4px_24px_rgba(0,0,0,0.04)] p-6 sm:p-7 flex flex-col gap-6">
            <div className="flex items-center justify-between pb-3.5 border-b border-gray-100">
              <h3 className="text-[18px] sm:text-[20px] font-bold text-[#010101]">
                Detail Use Case
              </h3>

              {/* Tombol Bagikan / Salin Link */}
              <button
                type="button"
                onClick={handleCopyLink}
                className="p-2 rounded-lg text-gray-400 hover:text-primary hover:bg-blue-50 transition-colors relative"
                title="Salin tautan solusi"
              >
                {copied ? (
                  <Check className="w-4 h-4 text-emerald-600" />
                ) : (
                  <Share2 className="w-4 h-4" />
                )}
                {copied && (
                  <span className="absolute -top-7 right-0 bg-gray-900 text-white text-[11px] font-medium px-2 py-0.5 rounded shadow-sm whitespace-nowrap animate-in fade-in zoom-in-95">
                    Tersalin!
                  </span>
                )}
              </button>
            </div>

            {/* Sektor Industri */}
            <div className="flex flex-col items-start gap-2">
              <span className="text-[12.5px] sm:text-[13px] font-bold uppercase tracking-wider text-gray-400">
                Sektor Industri:
              </span>
              <Badge
                color="blue"
                size="md"
                className="text-[13px] sm:text-[14px] px-3.5 py-1.5 font-semibold"
              >
                {industryLabel}
              </Badge>
            </div>

            {/* Kategori Solusi */}
            <div className="flex flex-col items-start gap-2">
              <span className="text-[12.5px] sm:text-[13px] font-bold uppercase tracking-wider text-gray-400">
                Kategori Solusi:
              </span>
              <div className="flex flex-wrap gap-2">
                {(solution.solutionCategories || []).length > 0 ? (
                  (solution.solutionCategories || []).map((catItem) => {
                    const catObj =
                      typeof catItem === "object" && catItem !== null
                        ? (catItem as SolutionCategory)
                        : null;
                    const label = catObj?.name || String(catItem);

                    return (
                      <Badge
                        key={catObj?.id || String(catItem)}
                        color={catObj?.badgeColor || "teal"}
                        size="md"
                        variant="soft"
                        className="text-[12.5px] sm:text-[13.5px] px-3 py-1 font-semibold"
                      >
                        {label}
                      </Badge>
                    );
                  })
                ) : (
                  <span className="text-[14px] text-gray-400">-</span>
                )}
              </div>
            </div>

            {/* Mitra & Brand Solusi (Partnerships) */}
            {partnershipsList.length > 0 && (
              <div className="flex flex-col items-start gap-2">
                <span className="text-[12.5px] sm:text-[13px] font-bold uppercase tracking-wider text-gray-400">
                  Brand:
                </span>
                <div className="flex flex-wrap gap-2">
                  {partnershipsList.map((partner) => (
                    <Badge
                      key={partner.id}
                      color="red"
                      size="md"
                      className="text-[12.5px] sm:text-[13.5px] px-3 py-1 font-semibold"
                    >
                      {partner.name}
                    </Badge>
                  ))}
                </div>
              </div>
            )}

            {/* Tanggal Publikasi */}
            {formattedDate && (
              <div className="pt-3.5 border-t border-gray-100 flex items-center justify-between text-[13px] sm:text-[14px] text-gray-500">
                <span className="font-medium">Dipublikasikan:</span>
                <span className="font-semibold text-gray-800">{formattedDate}</span>
              </div>
            )}
          </div>          
        </aside>
      </div>
    </article>
  );
}
