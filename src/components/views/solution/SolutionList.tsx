"use client";

import React, { useState, useMemo, useEffect, useRef } from "react";
import Link from "next/link";
import {
  Search,
  SlidersHorizontal,
  RotateCcw,
  MessageSquare,
  ArrowRight,
  ChevronLeft,
  ChevronRight,
  Loader2,
} from "lucide-react";
import Badge, { getBadgeColorClass } from "@/components/ui/Badge";
import type { Industry, PartnershipSolution, Solution, SolutionCategory } from "../../../../payload-types";

interface SolutionListProps {
  solutions: Solution[];
  industries: Industry[];
  initialPageSize?: number;
}

export const getCategoryBadgeClass = getBadgeColorClass;

export default function SolutionList({
  solutions,
  industries,
  initialPageSize = 10,
}: SolutionListProps) {
  const [selectedIndustry, setSelectedIndustry] = useState<string>("all");
  const [searchQuery, setSearchQuery] = useState<string>("");

  // Pagination & Infinite Scroll States
  const [pageSize, setPageSize] = useState<number>(initialPageSize);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [mobileVisibleCount, setMobileVisibleCount] = useState<number>(initialPageSize);
  const [isLoadingMore, setIsLoadingMore] = useState<boolean>(false);
  const sentinelRef = useRef<HTMLDivElement | null>(null);

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
    return (solutions || []).filter((item) => {
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
  }, [solutions, selectedIndustry, searchQuery]);

  // Total Halaman untuk Desktop Pagination
  const totalPages = Math.ceil(filteredSolutions.length / pageSize) || 1;
  const safeCurrentPage = Math.min(Math.max(1, currentPage), totalPages);

  // Data terpaginasi untuk Desktop Table
  const paginatedDesktopSolutions = useMemo(() => {
    const start = (safeCurrentPage - 1) * pageSize;
    return filteredSolutions.slice(start, start + pageSize);
  }, [filteredSolutions, safeCurrentPage, pageSize]);

  // Data terpaginasi untuk Mobile Infinite Scroll
  const paginatedMobileSolutions = useMemo(() => {
    return filteredSolutions.slice(0, mobileVisibleCount);
  }, [filteredSolutions, mobileVisibleCount]);

  // Intersection Observer untuk Infinite Scroll di Mobile
  useEffect(() => {
    const sentinel = sentinelRef.current;
    if (!sentinel) return;

    const observer = new IntersectionObserver(
      (entries) => {
        const entry = entries[0];
        if (
          entry.isIntersecting &&
          !isLoadingMore &&
          mobileVisibleCount < filteredSolutions.length
        ) {
          setIsLoadingMore(true);
          setTimeout(() => {
            setMobileVisibleCount((prev) =>
              Math.min(prev + pageSize, filteredSolutions.length)
            );
            setIsLoadingMore(false);
          }, 250);
        }
      },
      { rootMargin: "150px" }
    );

    observer.observe(sentinel);
    return () => {
      observer.disconnect();
    };
  }, [filteredSolutions.length, mobileVisibleCount, pageSize, isLoadingMore]);

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
    setSelectedIndustry("all");
    setSearchQuery("");
    setCurrentPage(1);
    setMobileVisibleCount(pageSize);
  };

  const handleSelectIndustry = (val: string) => {
    setSelectedIndustry(val);
    setCurrentPage(1);
    setMobileVisibleCount(pageSize);
  };

  const handleSearchChange = (val: string) => {
    setSearchQuery(val);
    setCurrentPage(1);
    setMobileVisibleCount(pageSize);
  };

  const handlePageSizeChange = (newSize: number) => {
    setPageSize(newSize);
    setCurrentPage(1);
    setMobileVisibleCount(newSize);
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
      <main className="flex-1 w-full flex flex-col gap-4">
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

        {/* --- DESKTOP TABLE VIEW (hidden on md/mobile) --- */}
        <div className="hidden md:block w-full overflow-x-auto rounded-2xl border border-gray-200/80 bg-white shadow-[0_2px_16px_rgba(0,0,0,0.02)]">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-gray-100 bg-gray-50/75">
                <th className="py-4.5 px-6 text-[15px] font-bold text-[#010101] w-[27%]">
                  Use Case
                </th>
                <th className="py-4.5 px-6 text-[15px] font-bold text-[#010101] w-[35%]">
                  Deskripsi Singkat
                </th>
                <th className="py-4.5 px-6 text-[15px] font-bold text-[#010101] w-[18%]">
                  Sektor
                </th>
                <th className="py-4.5 px-6 text-[15px] font-bold text-[#010101] w-[20%]">
                  Kategori Solusi
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {filteredSolutions.length === 0 ? (
                <tr>
                  <td colSpan={4} className="py-16 px-6 text-center">
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
                  </td>
                </tr>
              ) : (
                paginatedDesktopSolutions.map((item) => {
                  const industryObj =
                    typeof item.industry === "object" && item.industry !== null
                      ? (item.industry as Industry)
                      : null;
                  const industryLabel = industryObj?.name || "General";

                  return (
                    <tr key={item.id} className="hover:bg-blue-50/30 transition-colors group">
                      {/* Use Case */}
                      <td className="py-5 px-6 align-top">
                        <Link
                          href={`/solution/${item.slug || item.id}`}
                          className="font-bold text-[17px] lg:text-[18px] leading-[145%] text-[#010101] group-hover:text-[#0451bf] transition-colors block"
                        >
                          {item.title}
                        </Link>
                      </td>

                      {/* Description */}
                      <td className="py-5 px-6 align-top">
                        <p className="text-[14px] lg:text-[15px] leading-[175%] text-[#010101]/85 line-clamp-3">
                          {item.excerpt}
                        </p>
                        <Link
                          href={`/solution/${item.slug || item.id}`}
                          className="inline-flex items-center gap-1.5 mt-2.5 font-semibold text-[14px] lg:text-[15px] text-[#0451bf] group-hover:underline underline-offset-2 transition-colors"
                        >
                          <span>Detail</span>
                          <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-0.5" />
                        </Link>
                      </td>

                      {/* Industry Badge */}
                      <td className="py-5 px-6 align-top">
                        <Badge color="blue">{industryLabel}</Badge>
                      </td>

                      {/* Solution Category Badges */}
                      <td className="py-5 px-6 align-top">
                        <div className="flex flex-wrap gap-1.5">
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
                                >
                                  {label}
                                </Badge>
                              );
                            })
                          ) : (
                            <span className="text-[13px] text-gray-400">-</span>
                          )}
                        </div>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>

        {/* --- DESKTOP PAGINATION CONTROLS (Pojok Kanan Bawah) --- */}
        {filteredSolutions.length > 0 && (
          <div className="hidden md:flex items-center justify-between w-full pt-2 pb-2 px-1">
            {/* Info Counter Kiri */}
            <div className="text-[13px] text-gray-500">
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

            {/* Pojok Kanan: Selector Limit & Tombol Halaman */}
            <div className="flex items-center gap-4">
              {/* Limit Selector */}
              <div className="flex items-center gap-2 text-[13px] text-gray-500">
                <span>Tampilkan:</span>
                <select
                  value={pageSize}
                  onChange={(e) => handlePageSizeChange(Number(e.target.value))}
                  className="px-2.5 py-1 bg-white border border-gray-200 rounded-lg text-gray-700 text-[13px] font-medium focus:outline-none focus:border-[#0451bf] focus:ring-2 focus:ring-[#0451bf]/10 cursor-pointer transition-all"
                >
                  <option value={5}>5</option>
                  <option value={10}>10</option>
                  <option value={20}>20</option>
                  <option value={50}>50</option>
                </select>
                <span>per halaman</span>
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
                          className="w-8 h-8 flex items-center justify-center text-gray-400 text-[13px]"
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
                        className={`w-8 h-8 flex items-center justify-center rounded-lg text-[13px] font-semibold transition-all cursor-pointer ${
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

        {/* --- MOBILE VIEW: CARDS & INFINITE SCROLL (block on md/mobile) --- */}
        <div className="block md:hidden w-full flex flex-col gap-4">
          {/* Mobile Header / Limit Selector */}
          {filteredSolutions.length > 0 && (
            <div className="flex items-center justify-between text-[12px] sm:text-[13px] text-gray-500 px-1">
              <span>
                Menampilkan{" "}
                <strong className="text-gray-800">
                  {Math.min(mobileVisibleCount, filteredSolutions.length)}
                </strong>{" "}
                dari{" "}
                <strong className="text-gray-800">{filteredSolutions.length}</strong> use case
              </span>
              <div className="flex items-center gap-1.5">
                <span>Batch:</span>
                <select
                  value={pageSize}
                  onChange={(e) => handlePageSizeChange(Number(e.target.value))}
                  className="px-2 py-1 bg-white border border-gray-200 rounded-lg text-gray-700 text-[12px] font-medium focus:outline-none focus:border-[#0451bf]"
                >
                  <option value={5}>5</option>
                  <option value={10}>10</option>
                  <option value={20}>20</option>
                  <option value={50}>50</option>
                </select>
              </div>
            </div>
          )}

          {filteredSolutions.length === 0 ? (
            <div className="py-10 px-5 text-center bg-white rounded-2xl border border-gray-200/80 shadow-sm flex flex-col items-center gap-3">
              {solutions.length === 0 ? (
                /* CMS Data is currently empty */
                <>
                  <h4 className="text-[19px] font-bold text-[#010101]">
                    Studi Kasus Solusi Sedang Diperbarui
                  </h4>
                  <p className="text-[14px] text-gray-600 leading-[170%]">
                    Kami sedang menyiapkan dokumentasi implementasi solusi dan studi kasus terbaru untuk kategori ini. Ingin mengetahui solusi yang tepat untuk kebutuhan industri Anda? Diskusikan langsung bersama tim konsultan kami.
                  </p>
                  <a
                    href="https://wa.me/6281188862020?text=Halo%20Mirai,%20saya%20ingin%20berkonsultasi%20mengenai%20solusi%20teknologi%20untuk%20perusahaan%20kami"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="mt-2 inline-flex items-center justify-center gap-2 w-full py-3 rounded-xl bg-[#0451bf] text-white font-semibold text-[14px] shadow-sm active:scale-98 transition-transform cursor-pointer"
                  >
                    <MessageSquare className="w-4 h-4" />
                    <span>Konsultasi via WhatsApp</span>
                  </a>
                </>
              ) : (
                /* Filter or Search returned 0 */
                <>
                  <div className="w-12 h-12 rounded-2xl bg-gray-100 text-gray-400 flex items-center justify-center">
                    <Search className="w-6 h-6" />
                  </div>
                  <h4 className="text-[17px] font-bold text-[#010101]">
                    Tidak Ada Solusi yang Cocok
                  </h4>
                  <p className="text-[14px] text-gray-500">
                    Tidak ditemukan use case yang cocok dengan filter atau kata kunci pencarian Anda.
                  </p>
                  <button
                    type="button"
                    onClick={handleResetFilters}
                    className="mt-1 inline-flex items-center justify-center gap-2 px-5 py-2.5 rounded-xl border border-[#0451bf] text-[#0451bf] font-semibold text-[14px] cursor-pointer"
                  >
                    <RotateCcw className="w-4 h-4" />
                    Reset Filter & Pencarian
                  </button>
                </>
              )}
            </div>
          ) : (
            paginatedMobileSolutions.map((item) => {
              const industryObj =
                typeof item.industry === "object" && item.industry !== null
                  ? (item.industry as Industry)
                  : null;
              const industryLabel = industryObj?.name || "General";

              return (
                <div
                  key={item.id}
                  className="bg-white border border-gray-200/80 rounded-2xl p-5 shadow-[0_2px_12px_rgba(0,0,0,0.03)] flex flex-col gap-3.5"
                >
                  <div className="flex flex-wrap gap-2 items-center justify-between">
                    <Badge color="blue">{industryLabel}</Badge>
                  </div>

                  <Link
                    href={`/solution/${item.slug || item.id}`}
                    className="font-bold text-[18px] leading-[140%] text-[#010101] hover:text-[#0451bf] transition-colors"
                  >
                    {item.title}
                  </Link>

                  <p className="text-[14px] leading-[170%] text-[#010101]/80 line-clamp-3">
                    {item.excerpt}
                  </p>

                  <div className="flex flex-wrap gap-1.5 pt-1">
                    {(item.solutionCategories || []).map((catItem) => {
                      const catObj =
                        typeof catItem === "object" && catItem !== null
                          ? (catItem as SolutionCategory)
                          : null;
                      const label = catObj?.name || String(catItem);

                      return (
                        <Badge
                          key={catObj?.id || String(catItem)}
                          color={catObj?.badgeColor}
                        >
                          {label}
                        </Badge>
                      );
                    })}
                  </div>

                  <div className="pt-2 border-t border-gray-100 flex items-center justify-end">
                    <Link
                      href={`/solution/${item.slug || item.id}`}
                      className="inline-flex items-center gap-1.5 font-semibold text-[14px] text-[#0451bf] hover:underline"
                    >
                      <span>Pelajari Selengkapnya</span>
                      <ArrowRight className="w-4 h-4" />
                    </Link>
                  </div>
                </div>
              );
            })
          )}

          {/* Infinite Scroll Sentinel / Loading Indicator */}
          {filteredSolutions.length > 0 && mobileVisibleCount < filteredSolutions.length && (
            <div
              ref={sentinelRef}
              className="w-full py-4 flex flex-col items-center justify-center gap-2"
            >
              {isLoadingMore ? (
                <div className="flex items-center gap-2 text-[13px] text-gray-500">
                  <Loader2 className="w-4 h-4 animate-spin text-[#0451bf]" />
                  <span>Memuat use case berikutnya...</span>
                </div>
              ) : (
                <button
                  type="button"
                  onClick={() => {
                    setMobileVisibleCount((prev) =>
                      Math.min(prev + pageSize, filteredSolutions.length)
                    );
                  }}
                  className="px-4 py-2 text-[13px] font-medium text-[#0451bf] bg-blue-50/60 rounded-xl hover:bg-blue-50 transition-colors cursor-pointer"
                >
                  Muat Lebih Banyak...
                </button>
              )}
            </div>
          )}

          {filteredSolutions.length > 0 &&
            mobileVisibleCount >= filteredSolutions.length &&
            filteredSolutions.length > pageSize && (
              <div className="w-full py-3 text-center">
                <p className="text-[12px] sm:text-[13px] text-gray-400">
                  Semua {filteredSolutions.length} use case telah ditampilkan
                </p>
              </div>
            )}
        </div>
      </main>
    </div>
  );
}
