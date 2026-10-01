/* eslint-disable @typescript-eslint/no-unused-vars */
"use client";

import React, { useState, useMemo } from "react";
import Link from "next/link";
import Image from "@/components/ui/Image";
import {
  Search,
  SlidersHorizontal,
  RotateCcw,
  MessageSquare,
  ArrowRight,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import Badge, { getBadgeColorClass } from "@/components/ui/Badge";
import { getMediaUrl } from "@/lib/utils";
import type { Industry, PartnershipSolution, Solution, SolutionCategory } from "../../../../payload-types";

interface SolutionListProps {
  solutions: Solution[];
  industries: Industry[];
  initialPageSize?: number;
}

export const getCategoryBadgeClass = getBadgeColorClass;

const formatDate = (dateStr?: string | null) => {
  if (!dateStr) return "";

  try {
    const d = new Date(dateStr);
    if (isNaN(d.getTime())) return "";
    return d.toLocaleDateString("id-ID", {
      day: "numeric",
      month: "long",
      year: "numeric",
    });
  } catch {
    return "";
  }
};

export default function SolutionList({
  solutions,
  industries,
  initialPageSize = 10,
}: SolutionListProps) {
  const [selectedIndustry, setSelectedIndustry] = useState<string>("all");
  const [searchQuery, setSearchQuery] = useState<string>("");

  // Pagination States
  const [pageSize, setPageSize] = useState<number>(initialPageSize);
  const [currentPage, setCurrentPage] = useState<number>(1);

  // Helper shuffle array dengan Fisher-Yates
  const shuffleSolutions = (items: Solution[]) => {
    const array = [...items];

    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
    
    return array;
  };

  // Helper deterministik shuffle awal agar SSR dan hidrasi client 100% konsisten (bebas mismatch)
  const getDeterministicSolutions = (items: Solution[]) => {
    return [...(items || [])].sort((a, b) => {
      const hashA = ((a.id * 1664525 + 1013904223) >>> 0) % 100000;
      const hashB = ((b.id * 1664525 + 1013904223) >>> 0) % 100000;

      return hashA - hashB;
    });
  };

  // State data solusi yang diacak khusus untuk tab "Semua Industri"
  const [prevSolutions, setPrevSolutions] = useState<Solution[]>(solutions);
  const [shuffledAllSolutions, setShuffledAllSolutions] = useState<Solution[]>(() =>
    getDeterministicSolutions(solutions)
  );

  // Jika prop solutions berubah dari luar, sinkronkan langsung saat render (pola resmi React tanpa cascading renders)
  if (solutions !== prevSolutions) {
    setPrevSolutions(solutions);
    setShuffledAllSolutions(getDeterministicSolutions(solutions));
  }

  // Menghitung jumlah solusi per industri secara dinamis
  const industryCounts = useMemo(() => {
    const counts: Record<string, number> = { all: (solutions || []).length };
    (solutions || []).forEach((item) => {
      const ind =
        typeof item.industry === "object" && item.industry !== null
          ? item.industry
          : null;
      const key = ind?.slug || (item.industry ? String(item.industry) : null);
      if (key) {
        counts[key] = (counts[key] || 0) + 1;
      }
    });

    return counts;
  }, [solutions]);

  // Filter solutions berdasarkan industri dan pencarian kata kunci
  const filteredSolutions = useMemo(() => {
    // Jika "Semua Industri" dipilih, gunakan urutan yang telah diacak agar tidak monoton mengikuti urutan DB
    const baseSource =
      selectedIndustry === "all" ? shuffledAllSolutions : (solutions || []);

    return baseSource.filter((item) => {
      // 1. Industry filter matching
      const itemIndustrySlug =
        typeof item.industry === "object" && item.industry !== null
          ? item.industry.slug || String(item.industry.id)
          : String(item.industry);

      const matchIndustry =
        selectedIndustry === "all" || itemIndustrySlug === selectedIndustry;

      // 2. Search query matching
      const q = searchQuery.toLowerCase().trim();
      if (!q) return matchIndustry;

      const industryName =
        typeof item.industry === "object" && item.industry !== null
          ? item.industry.name
          : "";

      const matchQuery =
        // 1. Use Case: Judul & Ringkasan Solusi
        item.title?.toLowerCase().includes(q) ||
        item.excerpt?.toLowerCase().includes(q) ||
        // 2. Sektor Industri
        industryName.toLowerCase().includes(q) ||
        // 3. Teknologi: Kategori Solusi (Network, IoT, Cloud, Security, dll)
        item.solutionCategories?.some((cat) => {
          const catObj = cat as SolutionCategory;
          const catName =
            typeof catObj === "object" && catObj !== null ? catObj.name : "";

          return catName.toLowerCase().includes(q);
        }) ||
        // 4. Teknologi: Brand / Mitra Prinsipal (Cisco, Fortinet, Aruba, dll)
        item.partnership_solution?.some((partner) => {
          const partnerObj = partner as PartnershipSolution;
          const partnerName =
            typeof partnerObj === "object" && partnerObj !== null
              ? partnerObj.name
              : "";

          return partnerName.toLowerCase().includes(q);
        });

      return matchIndustry && matchQuery;
    });
  }, [solutions, shuffledAllSolutions, selectedIndustry, searchQuery]);

  // Total Halaman untuk Pagination
  const totalPages = Math.ceil(filteredSolutions.length / pageSize) || 1;
  const safeCurrentPage = Math.min(Math.max(1, currentPage), totalPages);

  // Data terpaginasi untuk Card List
  const paginatedSolutions = useMemo(() => {
    const start = (safeCurrentPage - 1) * pageSize;
    
    return filteredSolutions.slice(start, start + pageSize);
  }, [filteredSolutions, safeCurrentPage, pageSize]);

  // Helper untuk deretan angka halaman (smart pagination dengan ellipsis)
  const pageNumbers = useMemo(() => {
    if (totalPages <= 7) {
      return Array.from({ length: totalPages }, (_, i) => i + 1);
    }

    if (safeCurrentPage <= 3) {
      return [1, 2, 3, 4, "...", totalPages];
    }

    if (safeCurrentPage >= totalPages - 2) {
      return [1, "...", totalPages - 3, totalPages - 2, totalPages - 1, totalPages];
    }

    return [1, "...", safeCurrentPage - 1, safeCurrentPage, safeCurrentPage + 1, "...", totalPages];
  }, [safeCurrentPage, totalPages]);

  // Nama industri yang sedang aktif
  const activeIndustryName = useMemo(() => {
    if (selectedIndustry === "all") return null;
    const found = (industries || []).find(
      (ind) => (ind.slug || String(ind.id)) === selectedIndustry
    );
    
    return found?.name || selectedIndustry;
  }, [selectedIndustry, industries]);

  const handleResetFilters = () => {
    if (solutions && solutions.length > 0) {
      setShuffledAllSolutions(shuffleSolutions(solutions));
    }
    setSelectedIndustry("all");
    setSearchQuery("");
    setCurrentPage(1);
  };

  const handleSelectIndustry = (val: string) => {
    if (val === "all") {
      setShuffledAllSolutions(shuffleSolutions(solutions || []));
    }
    setSelectedIndustry(val);
    setCurrentPage(1);
  };

  const handleSearchChange = (val: string) => {
    setSearchQuery(val);
    setCurrentPage(1);
  };

  const handlePageSizeChange = (newSize: number) => {
    setPageSize(newSize);
    setCurrentPage(1);
  };

  return (
    <div className="w-full flex flex-col lg:flex-row items-start gap-4 lg:gap-8 xl:gap-10">
      {/* Filter Sidebar */}
      <aside className="hidden lg:block w-[280px] xl:w-[310px] shrink-0 sticky top-28 self-start bg-white border border-gray-200/80 rounded-2xl p-5 shadow-[0_4px_20px_rgba(0,0,0,0.03)]">
        <div className="flex items-center justify-between pb-3.5 mb-3 border-b border-gray-100">
          <div className="flex items-center gap-2.5">
            <div>
              <h3 className="text-[17px] sm:text-[18px] font-bold text-[#010101] tracking-tight">
                Sektor Industri
              </h3>
            </div>
          </div>
        </div>

        <div className="flex flex-col gap-1.5">
          {/* "Semua Industri" Option */}
          <button
            type="button"
            onClick={() => handleSelectIndustry("all")}
            className={`w-full flex items-center justify-between px-4 py-3 rounded-xl text-[15px] transition-all text-left group cursor-pointer ${
              selectedIndustry === "all"
                ? "bg-[#0451bf] text-white font-semibold shadow-sm shadow-[#0451bf]/25"
                : "text-gray-700 hover:bg-gray-50 hover:text-black font-medium"
            }`}
          >
            <div className="flex items-center gap-2.5 truncate">
              <span className="truncate">Semua Industri</span>
            </div>
          </button>

          {/* Dynamic Industries from CMS */}
          {(industries || []).map((ind) => {
            const val = ind.slug || String(ind.id);
            const isSelected = selectedIndustry === val;

            return (
              <button
                key={ind.id}
                type="button"
                onClick={() => handleSelectIndustry(val)}
                className={`w-full flex items-center justify-between px-4 py-3 rounded-xl text-[15px] transition-all text-left group cursor-pointer ${
                  isSelected
                    ? "bg-[#0451bf] text-white font-semibold shadow-sm shadow-[#0451bf]/25"
                    : "text-gray-700 hover:bg-gray-50 hover:text-black font-medium"
                }`}
              >
                <div className="flex items-center gap-2.5 truncate pr-2">
                  <span className="truncate">{ind.name}</span>
                </div>
              </button>
            );
          })}

          {(!industries || industries.length === 0) && (
            <p className="text-[13px] text-gray-400 italic px-2 py-3 text-center">
              (Belum ada data industri)
            </p>
          )}
        </div>
      </aside>

      {/* Content */}
      <main className="w-full lg:w-0 flex-1 min-w-0 flex flex-col gap-4">
        {/* Search Bar */}
        <div className="w-full relative">
          <div className="absolute left-4.5 top-1/2 -translate-y-1/2 pointer-events-none flex items-center text-gray-400">
            <Search className="w-5 h-5" />
          </div>
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => handleSearchChange(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") {
                e.currentTarget.blur();
              }
            }}
            placeholder="Cari use case, teknologi, atau sektor industri..."
            className="w-full h-[54px] pl-12 pr-12 rounded-2xl bg-white border border-gray-200/90 text-[#010101] placeholder-gray-400 text-[15px] md:text-[16px] focus:outline-none focus:border-[#0451bf] focus:ring-4 focus:ring-[#0451bf]/10 transition-all shadow-[0_2px_12px_rgba(0,0,0,0.02)]"
          />
          {searchQuery && (
            <button
              type="button"
              onClick={() => handleSearchChange("")}
              className="absolute right-4 top-1/2 -translate-y-1/2 p-2 rounded-full text-gray-400 hover:text-[#0451bf] hover:bg-gray-100 transition-colors cursor-pointer"
              title="Reset pencarian"
            >
              <RotateCcw className="w-4 h-4" />
            </button>
          )}
        </div>

        {/* --- MOBILE / TABLET HORIZONTAL FILTER CHIPS (lg:hidden) --- */}
        <div className="block lg:hidden w-full">
          <div className="flex items-center gap-1.5 mb-2.5 text-[14px] font-semibold text-gray-700 px-0.5">
            <SlidersHorizontal className="w-4 h-4 text-[#0451bf]" />
            <span>Filter:</span>
          </div>
          <div className="flex items-center gap-2 overflow-x-auto pb-2 scrollbar-none -mx-4 px-4 sm:-mx-8 sm:px-8">
            {/* "Semua" Chip */}
            <button
              type="button"
              onClick={() => handleSelectIndustry("all")}
              className={`shrink-0 flex items-center gap-2 px-4 py-2 rounded-full text-[14px] font-medium transition-all cursor-pointer ${
                selectedIndustry === "all"
                  ? "bg-[#0451bf] text-white font-semibold shadow-sm shadow-[#0451bf]/30"
                  : "bg-white border border-gray-200 text-gray-700 hover:border-[#0451bf]/50"
              }`}
            >
              <span>Semua</span>
              <span
                className={`text-[12px] px-2 py-0.5 rounded-full ${
                  selectedIndustry === "all"
                    ? "bg-white/20 text-white font-semibold"
                    : "bg-gray-100 text-gray-500"
                }`}
              >
                {industryCounts.all || 0}
              </span>
            </button>

            {/* Dynamic Industry Chips */}
            {(industries || []).map((ind) => {
              const val = ind.slug || String(ind.id);
              const isSelected = selectedIndustry === val;
              const count = industryCounts[val] || 0;

              return (
                <button
                  key={ind.id}
                  type="button"
                  onClick={() => handleSelectIndustry(val)}
                  className={`shrink-0 flex items-center gap-2 px-4 py-2 rounded-full text-[14px] font-medium transition-all cursor-pointer ${
                    isSelected
                      ? "bg-[#0451bf] text-white font-semibold shadow-sm shadow-[#0451bf]/30"
                      : "bg-white border border-gray-200 text-gray-700 hover:border-[#0451bf]/50"
                  }`}
                >
                  <span>{ind.name}</span>
                  <span
                    className={`text-[12px] px-2 py-0.5 rounded-full ${
                      isSelected
                        ? "bg-white/20 text-white font-semibold"
                        : "bg-gray-100 text-gray-500"
                    }`}
                  >
                    {count}
                  </span>
                </button>
              );
            })}
          </div>
        </div>

        {/* --- CARD VIEW (Responsive untuk Mobile, Tablet & Desktop) --- */}
        <div className="flex flex-col gap-4 sm:gap-5 lg:gap-3.5 w-full min-w-0">
          {filteredSolutions.length === 0 ? (
            <div className="py-16 px-6 text-center bg-white rounded-2xl border border-gray-200/80 shadow-[0_2px_16px_rgba(0,0,0,0.02)]">
              {solutions.length === 0 ? (
                /* CMS Data is currently empty */
                <div className="flex flex-col items-center max-w-xl mx-auto text-center gap-3">
                  <h4 className="text-[20px] lg:text-[22px] font-bold text-[#010101]">
                    Studi Kasus Solusi Sedang Diperbarui
                  </h4>
                  <p className="text-[15px] lg:text-[16px] text-gray-600 leading-[175%]">
                    Kami sedang menyiapkan dokumentasi implementasi solusi dan studi kasus terbaru untuk kategori ini. Ingin mengetahui solusi yang tepat untuk kebutuhan industri Anda? Diskusikan langsung bersama tim konsultan kami.
                  </p>
                  <a
                    href="https://wa.me/6281188862020?text=Halo%20Mirai,%20saya%20ingin%20berkonsultasi%20mengenai%20solusi%20teknologi%20untuk%20perusahaan%20kami"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="mt-3 inline-flex items-center gap-2.5 px-6 py-3 rounded-xl bg-[#0451bf] text-white font-semibold text-[15px] hover:bg-[#033b8c] transition-all shadow-sm hover:shadow-md cursor-pointer"
                  >
                    <MessageSquare className="w-5 h-5" />
                    <span>Konsultasi Gratis via WhatsApp</span>
                  </a>
                </div>
              ) : (
                /* Filter or Search returned 0 */
                <div className="flex flex-col items-center max-w-md mx-auto text-center gap-3">
                  <div className="w-12 h-12 rounded-2xl bg-gray-100 text-gray-400 flex items-center justify-center mb-1">
                    <Search className="w-6 h-6" />
                  </div>
                  <h4 className="text-[18px] lg:text-[20px] font-bold text-[#010101]">
                    Tidak Ada Solusi yang Cocok
                  </h4>
                  <p className="text-[14px] lg:text-[15px] text-gray-500 leading-relaxed">
                    Tidak ditemukan use case yang cocok dengan kriteria filter{" "}
                    {searchQuery && (
                      <span>
                        kata kunci <strong>&ldquo;{searchQuery}&rdquo;</strong>
                      </span>
                    )}
                    {searchQuery && selectedIndustry !== "all" && " dan "}
                    {selectedIndustry !== "all" && (
                      <span>
                        sektor <strong>&ldquo;{activeIndustryName}&rdquo;</strong>
                      </span>
                    )}
                    .
                  </p>
                </div>
              )}
            </div>
          ) : (
            paginatedSolutions.map((item) => {
              const industryObj =
                typeof item.industry === "object" && item.industry !== null
                  ? (item.industry as Industry)
                  : null;
              const industryLabel = industryObj?.name || "General";
              const imageUrl =
                getMediaUrl(item.coverImage, "hero") ||
                (typeof item.coverImage === "object" && item.coverImage !== null ? item.coverImage.url : null);
              const dateStr = formatDate(item.publishedDate || item.createdAt);

              return (
                <React.Fragment key={item.id}>
                  {/* --- 1. CARD KHUSUS MOBILE & TABLET (< lg) --- */}
                  <Link
                    href={`/solution/${item.slug || item.id}`}
                    className="group w-full shadow-[0px_4px_10px_1px_rgba(0,0,0,0.08)] hover:shadow-xl hover:-translate-y-1 transition-all duration-300 rounded-[20px] bg-[#fdfdfd] overflow-hidden flex flex-col items-stretch gap-0 border border-gray-100 cursor-pointer lg:hidden"
                  >
                    {/* Gambar di Bagian Atas (Aspect Ratio 16:9) */}
                    <div className="w-full aspect-[16/9] shrink-0 relative overflow-hidden bg-gray-100">
                      <Image
                        src={imageUrl}
                        alt={item.title}
                        fill
                        sizes="(max-width: 1024px) 100vw, 500px"
                        className="w-full h-full object-cover object-center"
                      />
                    </div>

                    {/* Informasi Konten Card Mobile & Tablet */}
                    <div className="flex flex-col items-start p-5 sm:p-6 gap-3 sm:gap-4 w-full flex-1">
                      {/* Bawah Gambar: Sektor Industri (Kiri) & Tanggal (Kanan) */}
                      <div className="flex items-center justify-between w-full gap-2">
                        <div className="bg-[#7eb2fc]/25 text-[#0451bf] rounded-[99px] px-[14px] py-[4px] font-semibold text-[13px] sm:text-[14px] leading-[170%] flex items-center justify-center">
                          {industryLabel}
                        </div>
                        {dateStr && (
                          <span className="text-[12px] sm:text-[13px] font-medium text-gray-500 shrink-0">
                            {dateStr}
                          </span>
                        )}
                      </div>

                      {/* Bawahnya: Judul Use Case */}
                      <h3 className="text-[18px] sm:text-[20px] font-bold leading-[140%] text-[#010101] line-clamp-2 group-hover:text-[#0451bf] transition-colors">
                        {item.title}
                      </h3>

                      {/* Bawahnya: Deskripsi Singkat */}
                      <p className="text-[13.5px] sm:text-[14px] font-normal leading-[170%] text-[#010101]/80 line-clamp-3">
                        {item.excerpt}
                      </p>

                      {/* Bawahnya lagi: Badge Kategori Solusi */}
                      <div className="flex flex-wrap items-center gap-1.5 pt-1 mt-auto">
                        {item.solutionCategories && item.solutionCategories.length > 0 ? (
                          item.solutionCategories.map((catItem) => {
                            const catObj =
                              typeof catItem === "object" && catItem !== null
                                ? (catItem as SolutionCategory)
                                : null;
                            const label = catObj?.name || String(catItem);

                            return (
                              <Badge
                                key={catObj?.id || String(catItem)}
                                color={catObj?.badgeColor}
                                size="sm"
                              >
                                {label}
                              </Badge>
                            );
                          })
                        ) : null}
                      </div>
                    </div>
                  </Link>

                  {/* --- 2. CARD KHUSUS LAPTOP KECIL & LAPTOP BIASA (>= lg) --- */}
                  <Link
                    href={`/solution/${item.slug || item.id}`}
                    className="group w-full bg-white border border-gray-200/80 rounded-2xl p-3.5 xl:p-4 shadow-[0_2px_12px_rgba(0,0,0,0.02)] hover:shadow-[0_4px_20px_rgba(4,81,191,0.08)] hover:border-[#0451bf]/40 transition-all duration-300 hidden lg:flex items-stretch justify-between gap-4 cursor-pointer"
                  >
                    {/* Bagian Kiri: Gambar dan Kolom Teks Use Case */}
                    <div className="flex items-start gap-4 flex-1 min-w-0">
                      {/* Gambar di Sebelah Kiri (Aspect Ratio 16:9) */}
                      <div className="relative w-44 xl:w-52 aspect-[16/9] shrink-0 self-start rounded-xl overflow-hidden bg-gray-100 border border-gray-100/80">
                        <Image
                          src={imageUrl}
                          alt={item.title}
                          fill
                          sizes="208px"
                          className="w-full h-full object-cover object-center"
                        />
                      </div>

                      {/* Kolom Tengah: Judul Use Case, Deskripsi, Badge Kategori Solusi */}
                      <div className="flex-1 min-w-0 flex flex-col justify-center gap-1.5 py-0.5">
                        {/* Judul Use Case (max line 1 overflow ellipsis) */}
                        <h4 className="font-bold text-[15.5px] xl:text-[17px] text-[#010101] group-hover:text-[#0451bf] transition-colors truncate leading-snug">
                          {item.title}
                        </h4>

                        {/* Deskripsi Singkat (max line 1 overflow ellipsis) */}
                        <p className="text-[13px] xl:text-[14px] line-clamp-2 text-gray-500 leading-relaxed">
                          {item.excerpt}
                        </p>

                        {/* Badge Kategori Solusi */}
                        <div className="flex items-center gap-1.5 flex-wrap pt-0.5">
                          {item.solutionCategories && item.solutionCategories.length > 0 ? (
                            item.solutionCategories.map((catItem) => {
                              const catObj =
                                typeof catItem === "object" && catItem !== null
                                  ? (catItem as SolutionCategory)
                                  : null;
                              const label = catObj?.name || String(catItem);

                              return (
                                <Badge
                                  key={catObj?.id || String(catItem)}
                                  color={catObj?.badgeColor}
                                  size="sm"
                                >
                                  {label}
                                </Badge>
                              );
                            })
                          ) : (
                            <span className="text-[11px] xl:text-[12px] text-gray-400">-</span>
                          )}
                        </div>
                      </div>
                    </div>

                    {/* Sisi Kanan: Pojok Kanan Atas (Badge Sektor) & Di Tengah Kanan Bawahnya (Panah Langsung Bersih) */}
                    <div className="shrink-0 flex flex-col items-end justify-between self-stretch pl-2 xl:pl-3 py-0.5">
                      {/* Pojok Kanan Atas: Badge Sektor */}
                      <Badge
                        color="blue"
                        size="sm"
                        className="text-[12px] px-3 py-1 max-w-[160px] xl:max-w-[200px] truncate"
                      >
                        {industryLabel}
                      </Badge>

                      {/* Di Tengah Kanan Tepat di Bawah Badge Sektor: Panah Langsung Bersih */}
                      <div className="flex-1 flex items-center justify-end w-full pt-1">
                        <ArrowRight className="w-5 h-5 text-gray-400 group-hover:text-[#0451bf] transition-all duration-300 group-hover:translate-x-1" />
                      </div>
                    </div>
                  </Link>
                </React.Fragment>
              );
            })
          )}
        </div>

        {/* --- PAGINATION CONTROLS (Responsive untuk Mobile, Tablet & Desktop) --- */}
        {filteredSolutions.length > 0 && (
          <div className="flex flex-col sm:flex-row items-center justify-between w-full pt-3 pb-2 px-1 gap-3">
            {/* Info Counter */}
            <div className="text-[12.5px] sm:text-[13px] text-gray-500 order-2 sm:order-1 text-center sm:text-left">
              Menampilkan{" "}
              <span className="font-semibold text-gray-800">
                {(safeCurrentPage - 1) * pageSize + 1}
              </span>{" "}
              -{" "}
              <span className="font-semibold text-gray-800">
                {Math.min(safeCurrentPage * pageSize, filteredSolutions.length)}
              </span>{" "}
              dari{" "}
              <span className="font-semibold text-gray-800">
                {filteredSolutions.length}
              </span>{" "}
              solusi
            </div>

            {/* Selector Limit & Tombol Halaman */}
            <div className="flex items-center gap-2.5 sm:gap-4 order-1 sm:order-2 flex-wrap justify-center">
              {/* Limit Selector */}
              <div className="flex items-center gap-1.5 sm:gap-2 text-[12px] sm:text-[13px] text-gray-500">
                <span>Tampilkan:</span>
                <select
                  value={pageSize}
                  onChange={(e) => handlePageSizeChange(Number(e.target.value))}
                  className="px-2 py-1 bg-white border border-gray-200 rounded-lg text-gray-700 text-[12px] sm:text-[13px] font-medium focus:outline-none focus:border-[#0451bf] focus:ring-2 focus:ring-[#0451bf]/10 cursor-pointer transition-all"
                >
                  <option value={5}>5</option>
                  <option value={10}>10</option>
                  <option value={20}>20</option>
                  <option value={50}>50</option>
                </select>
                <span className="hidden xs:inline">per halaman</span>
              </div>

              {/* Page Buttons */}
              {totalPages > 1 && (
                <div className="flex items-center gap-1">
                  {/* Prev */}
                  <button
                    type="button"
                    disabled={safeCurrentPage <= 1}
                    onClick={() => setCurrentPage((p) => Math.max(p - 1, 1))}
                    className="w-8 h-8 flex items-center justify-center rounded-lg border border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-[#0451bf] hover:border-[#0451bf]/40 disabled:opacity-30 disabled:pointer-events-none transition-all cursor-pointer"
                    title="Halaman Sebelumnya"
                  >
                    <ChevronLeft className="w-4 h-4" />
                  </button>

                  {/* Numbers */}
                  {pageNumbers.map((page, idx) => {
                    if (page === "...") {
                      return (
                        <span
                          key={`ellipsis-${idx}`}
                          className="w-7 h-7 sm:w-8 sm:h-8 flex items-center justify-center text-gray-400 text-[12px] sm:text-[13px]"
                        >
                          ...
                        </span>
                      );
                    }

                    const pageNum = Number(page);
                    const isActive = pageNum === safeCurrentPage;

                    return (
                      <button
                        key={pageNum}
                        type="button"
                        onClick={() => setCurrentPage(pageNum)}
                        className={`w-7 h-7 sm:w-8 sm:h-8 flex items-center justify-center rounded-lg text-[12px] sm:text-[13px] font-semibold transition-all cursor-pointer ${
                          isActive
                            ? "bg-[#0451bf] text-white shadow-sm shadow-[#0451bf]/30"
                            : "text-gray-700 hover:bg-gray-100 hover:text-[#0451bf]"
                        }`}
                      >
                        {pageNum}
                      </button>
                    );
                  })}

                  {/* Next */}
                  <button
                    type="button"
                    disabled={safeCurrentPage >= totalPages}
                    onClick={() => setCurrentPage((p) => Math.min(p + 1, totalPages))}
                    className="w-8 h-8 flex items-center justify-center rounded-lg border border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-[#0451bf] hover:border-[#0451bf]/40 disabled:opacity-30 disabled:pointer-events-none transition-all cursor-pointer"
                    title="Halaman Selanjutnya"
                  >
                    <ChevronRight className="w-4 h-4" />
                  </button>
                </div>
              )}
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
