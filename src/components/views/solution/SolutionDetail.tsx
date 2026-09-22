/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import React from "react";
import Link from "next/link";
import Image from "@/components/ui/Image";
import { RichText } from "@payloadcms/richtext-lexical/react";
import { ArrowLeft, CheckCircle2, Download, MessageSquare, ExternalLink } from "lucide-react";
import { generateWhatsAppUrl } from "@/lib/whatsapp";
import { getMediaUrl } from "@/lib/utils";
import { getCategoryBadgeClass } from "./SolutionList";
import type { Industry, Solution, SolutionCategory } from "../../../../payload-types";

interface SolutionDetailProps {
  solution: Solution;
}

export default function SolutionDetail({ solution }: SolutionDetailProps) {
  const waUrl = generateWhatsAppUrl({
    message: `Halo tim Mirai Softnet, saya tertarik dan ingin berkonsultasi mengenai solusi: "${solution.title}".`,
  });

  const industryObj =
    typeof solution.industry === "object" && solution.industry !== null
      ? (solution.industry as Industry)
      : null;
  const industryLabel = industryObj?.name || "General";

  const formattedDate = solution.publishedDate
    ? new Date(solution.publishedDate).toLocaleDateString("id-ID", {
        day: "numeric",
        month: "long",
        year: "numeric",
      })
    : "";

  const coverUrl =
    getMediaUrl(solution.coverImage, "hero") ||
    (typeof solution.coverImage === "object" ? solution.coverImage?.url : null);
  const diagramUrl =
    getMediaUrl(solution.architectureDiagram, "hero") ||
    (typeof solution.architectureDiagram === "object" ? solution.architectureDiagram?.url : null);
  const documentUrl =
    typeof solution.solutionDocument === "object" ? solution.solutionDocument?.url : null;

  return (
    <div className="w-full flex flex-col items-center text-[#010101] bg-[#fdfdfd] py-8 sm:py-12 lg:py-16 px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)]">
      <div className="w-full max-w-5xl flex flex-col items-start gap-8">
        
        {/* Navigation & Breadcrumb */}
        <div className="w-full flex flex-wrap items-center justify-between gap-4">
          <Link
            href="/solution"
            className="inline-flex items-center gap-2 text-[#0451bf] font-semibold text-[14px] sm:text-[15px] hover:-translate-x-1 transition-transform duration-200"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Kembali ke Daftar Solusi</span>
          </Link>

          <nav className="text-[13px] text-gray-500 flex items-center gap-1.5">
            <Link href="/" className="hover:text-primary transition-colors">Home</Link>
            <span>/</span>
            <Link href="/solution" className="hover:text-primary transition-colors">Solusi</Link>
            <span>/</span>
            <span className="text-gray-800 font-medium truncate max-w-[200px] sm:max-w-xs">{solution.title}</span>
          </nav>
        </div>

        {/* Header Metadata & Badges */}
        <header className="w-full flex flex-col gap-4">
          <div className="flex flex-wrap items-center gap-2.5">
            <span className="inline-flex items-center px-3.5 py-1.5 rounded-full text-[12px] font-semibold bg-[#0451bf] text-white shadow-sm">
              {industryLabel}
            </span>

            {(solution.solutionCategories || []).map((catItem) => {
              const catObj =
                typeof catItem === "object" && catItem !== null
                  ? (catItem as SolutionCategory)
                  : null;
              const label = catObj?.name || String(catItem);
              const badgeClass = getCategoryBadgeClass(catObj?.badgeColor);

              return (
                <span
                  key={catObj?.id || String(catItem)}
                  className={`inline-flex items-center px-3 py-1 rounded-full text-[11px] font-semibold leading-tight shadow-sm ${badgeClass}`}
                >
                  {label}
                </span>
              );
            })}

            {formattedDate && (
              <span className="text-[13px] font-semibold text-[#e02d3c] ml-auto">
                Posted on {formattedDate}
              </span>
            )}
          </div>

          <h1 className="text-[28px] sm:text-[36px] lg:text-[42px] font-bold leading-[125%] text-[#010101] tracking-tight">
            {solution.title}
          </h1>

          {solution.excerpt && (
            <p className="text-[16px] sm:text-[18px] leading-[170%] text-[#010101]/80 font-medium">
              {solution.excerpt}
            </p>
          )}
        </header>

        {/* Hero Cover Image */}
        {coverUrl && (
          <div className="w-full aspect-video sm:h-[420px] md:h-[480px] rounded-2xl overflow-hidden relative shadow-md border border-gray-100 bg-gray-50">
            <Image
              src={coverUrl}
              alt={solution.title}
              fill
              priority
              sizes="(max-width: 1200px) 100vw, 1100px"
              className="object-cover"
            />
          </div>
        )}

        {/* Section: Business Challenge / Masalah Industri */}
        {solution.businessChallenge && (
          <section className="w-full bg-red-50/40 border border-red-100 rounded-2xl p-6 sm:p-8 flex flex-col gap-4">
            <div className="inline-flex items-center gap-2 text-[#e02d3c] font-bold text-[14px] uppercase tracking-wider">
              <span>Tantangan & Masalah Industri</span>
            </div>
            <div className="text-[15px] sm:text-[16px] leading-[180%] text-[#010101]/90 font-medium [&_p]:mb-3 [&_ul]:list-disc [&_ul]:pl-5">
              <RichText data={solution.businessChallenge} />
            </div>
          </section>
        )}

        {/* Section: Solusi & Cara Kerja */}
        {solution.solutionOverview && (
          <section className="w-full flex flex-col gap-4 mt-2">
            <h2 className="text-[22px] sm:text-[26px] font-bold text-[#010101] tracking-tight">
              Arsitektur & Pendekatan Solusi
            </h2>
            <div className="text-[15px] sm:text-[16px] leading-[185%] text-[#010101]/90 font-medium [&_p]:mb-4 [&_ul]:list-disc [&_ul]:pl-5 [&_ol]:list-decimal [&_ol]:pl-5">
              <RichText data={solution.solutionOverview} />
            </div>
          </section>
        )}

        {/* Architecture / System Topology Diagram */}
        {diagramUrl && (
          <div className="w-full flex flex-col gap-3 p-6 bg-gray-50 border border-gray-200/80 rounded-2xl">
            <span className="text-[14px] font-bold text-gray-700 uppercase tracking-wide">
              Diagram Topologi / Arsitektur Solusi
            </span>
            <div className="w-full relative h-[300px] sm:h-[420px] md:h-[500px] rounded-xl overflow-hidden bg-white border border-gray-200">
              <Image
                src={diagramUrl}
                alt={`Diagram Arsitektur ${solution.title}`}
                fill
                sizes="(max-width: 1200px) 100vw, 1000px"
                className="object-contain p-2"
              />
            </div>
          </div>
        )}

        {/* Section: Key Features */}
        {solution.keyFeatures && solution.keyFeatures.length > 0 && (
          <section className="w-full flex flex-col gap-4 mt-4">
            <h2 className="text-[22px] sm:text-[26px] font-bold text-[#010101] tracking-tight">
              Fitur & Kapabilitas Utama
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {solution.keyFeatures.map((feat: any, idx: number) => (
                <div
                  key={idx}
                  className="p-5 rounded-xl border border-gray-100 bg-[#fdfdfd] shadow-sm flex items-start gap-3.5 hover:border-brand-200 transition-colors"
                >
                  <CheckCircle2 className="w-5 h-5 text-primary shrink-0 mt-0.5" />
                  <div className="flex flex-col gap-1">
                    <h3 className="font-bold text-[15px] sm:text-[16px] text-[#010101]">
                      {feat.title}
                    </h3>
                    <p className="text-[13px] sm:text-[14px] leading-[160%] text-[#010101]/80 font-medium">
                      {feat.description}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* Section: Key Benefits & ROI */}
        {solution.keyBenefits && solution.keyBenefits.length > 0 && (
          <section className="w-full flex flex-col gap-4 mt-4">
            <h2 className="text-[22px] sm:text-[26px] font-bold text-[#010101] tracking-tight">
              Manfaat Nyata & Dampak Bisnis
            </h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {solution.keyBenefits.map((benefit: any, idx: number) => (
                <div
                  key={idx}
                  className="p-6 rounded-2xl bg-gradient-to-br from-blue-50/50 to-white border border-blue-100/70 shadow-sm flex flex-col gap-2"
                >
                  {benefit.metric && (
                    <span className="text-[28px] font-extrabold text-[#0451bf] leading-tight">
                      {benefit.metric}
                    </span>
                  )}
                  <h3 className="font-bold text-[16px] text-[#010101]">
                    {benefit.title}
                  </h3>
                  <p className="text-[13px] sm:text-[14px] leading-[160%] text-[#010101]/80 font-medium">
                    {benefit.description}
                  </p>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* Section: Technology Partners */}
        {solution.partners && solution.partners.length > 0 && (
          <section className="w-full flex flex-col gap-4 mt-4 p-6 sm:p-8 rounded-2xl bg-gray-50/60 border border-gray-100">
            <h2 className="text-[20px] sm:text-[22px] font-bold text-[#010101]">
              Didukung oleh Mitra Teknologi Resmi
            </h2>
            <p className="text-[14px] text-[#010101]/75 -mt-2">
              Solusi ini dirancang menggunakan perangkat keras dan teknologi teruji dari ekosistem partner kami:
            </p>
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4 mt-2">
              {solution.partners.map((partner: any) => {
                if (typeof partner !== "object") return null;
                const logoUrl =
                  getMediaUrl(partner.logo, "thumbnail") ||
                  (typeof partner.logo === "object" ? partner.logo?.url : null);
                return (
                  <div
                    key={partner.id}
                    className="p-4 bg-white rounded-xl border border-gray-200/80 shadow-xs flex flex-col items-center justify-center gap-2 text-center"
                  >
                    {logoUrl ? (
                      <div className="w-full h-12 relative flex items-center justify-center">
                        <Image
                          src={logoUrl}
                          alt={partner.name || "Partner Logo"}
                          width={100}
                          height={40}
                          className="object-contain max-h-10"
                        />
                      </div>
                    ) : (
                      <div className="w-10 h-10 rounded-full bg-gray-100 flex items-center justify-center font-bold text-gray-500">
                        {partner.name?.charAt(0) || "P"}
                      </div>
                    )}
                    <span className="text-[12px] font-semibold text-gray-800 line-clamp-1">
                      {partner.name}
                    </span>
                  </div>
                );
              })}
            </div>
          </section>
        )}

        {/* Section: Related Services & Products */}
        {((solution.relatedServices && solution.relatedServices.length > 0) ||
          (solution.relatedProducts && solution.relatedProducts.length > 0)) && (
          <section className="w-full flex flex-col gap-4 mt-4">
            <h2 className="text-[22px] sm:text-[26px] font-bold text-[#010101] tracking-tight">
              Layanan & Produk Implementasi
            </h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {/* Services */}
              {(solution.relatedServices || []).map((srv: any) => {
                if (typeof srv !== "object") return null;
                return (
                  <Link
                    key={srv.id}
                    href={`/services/${srv.slug}`}
                    className="p-5 rounded-2xl border border-gray-200/80 bg-white hover:border-[#0451bf] hover:shadow-md transition-all group flex flex-col gap-2"
                  >
                    <div className="flex items-center justify-between">
                      <span className="text-[11px] font-bold uppercase tracking-wider text-primary">
                        Layanan IT
                      </span>
                      <ExternalLink className="w-4 h-4 text-gray-400 group-hover:text-primary transition-colors" />
                    </div>
                    <h3 className="text-[17px] font-bold text-[#010101] group-hover:text-[#0451bf] transition-colors">
                      {srv.title}
                    </h3>
                    {srv.subtitle && (
                      <p className="text-[13px] text-[#010101]/75 line-clamp-2">
                        {srv.subtitle}
                      </p>
                    )}
                  </Link>
                );
              })}

              {/* Products */}
              {(solution.relatedProducts || []).map((prod: any) => {
                if (typeof prod !== "object") return null;
                return (
                  <Link
                    key={prod.id}
                    href={`/products/${prod.slug}`}
                    className="p-5 rounded-2xl border border-gray-200/80 bg-white hover:border-[#0451bf] hover:shadow-md transition-all group flex flex-col gap-2"
                  >
                    <div className="flex items-center justify-between">
                      <span className="text-[11px] font-bold uppercase tracking-wider text-secondary-500">
                        Produk Mirai
                      </span>
                      <ExternalLink className="w-4 h-4 text-gray-400 group-hover:text-primary transition-colors" />
                    </div>
                    <h3 className="text-[17px] font-bold text-[#010101] group-hover:text-[#0451bf] transition-colors">
                      {prod.name}
                    </h3>
                    {prod.subtitle && (
                      <p className="text-[13px] text-[#010101]/75 line-clamp-2">
                        {prod.subtitle}
                      </p>
                    )}
                  </Link>
                );
              })}
            </div>
          </section>
        )}

        {/* Section: Call To Action & Download */}
        <section className="w-full mt-6 p-8 sm:p-10 rounded-3xl bg-gradient-to-r from-[#03418e] to-[#0451bf] text-white shadow-xl flex flex-col md:flex-row items-center justify-between gap-6">
          <div className="flex flex-col gap-2 text-center md:text-left">
            <h2 className="text-[24px] sm:text-[28px] font-extrabold leading-tight">
              Ingin Menerapkan Solusi Ini di Perusahaan Anda?
            </h2>
            <p className="text-[14px] sm:text-[15px] text-white/90 max-w-xl font-medium">
              Diskusikan kebutuhan spesifik infrastruktur IT, keamanan, dan digitalisasi organisasi Anda bersama tim ahli kami.
            </p>
          </div>

          <div className="flex flex-wrap items-center gap-3 shrink-0">
            {documentUrl && (
              <a
                href={documentUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 px-5 py-3 rounded-xl bg-white/10 hover:bg-white/20 border border-white/30 text-white font-semibold text-[14px] transition-all backdrop-blur-sm"
              >
                <Download className="w-4 h-4" />
                <span>Download Brief</span>
              </a>
            )}

            <Link
              href={waUrl}
              target="_blank"
              className="inline-flex items-center gap-2 px-6 py-3 rounded-xl bg-[#25D366] hover:bg-[#20ba59] text-white font-bold text-[14px] shadow-lg transition-transform hover:scale-105 active:scale-95"
            >
              <MessageSquare className="w-4 h-4" />
              <span>{solution.ctaText || "Konsultasikan Solusi Ini"}</span>
            </Link>
          </div>
        </section>

      </div>
    </div>
  );
}
