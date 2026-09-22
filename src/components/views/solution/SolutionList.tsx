"use client";

import React, { useState, useMemo } from "react";
import Link from "next/link";
import { Search, X } from "lucide-react";
import type { Industry, Solution, SolutionCategory } from "../../../../payload-types";

interface SolutionListProps {
  solutions: Solution[];
  industries: Industry[];
}

export function getCategoryBadgeClass(color?: string | null): string {
  switch (color) {
    case "blue":
      return "bg-[#0451bf] text-white";
    case "orange":
      return "bg-secondary-500 text-white";
    case "purple":
      return "bg-purple-600 text-white";
    case "green":
      return "bg-emerald-600 text-white";
    case "teal":
    default:
      return "bg-[#009688] text-white";
  }
}

export default function SolutionList({ solutions, industries }: SolutionListProps) {
  const [selectedIndustry, setSelectedIndustry] = useState<string>("all");
  const [searchQuery, setSearchQuery] = useState<string>("");

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
        item.title?.toLowerCase().includes(q) ||
        item.excerpt?.toLowerCase().includes(q) ||
        industryName.toLowerCase().includes(q) ||
        item.solutionCategories?.some((cat) => {
          const catObj = cat as SolutionCategory;
          const catName = typeof catObj === "object" && catObj !== null ? catObj.name : "";
          return catName.toLowerCase().includes(q);
        });

      return matchIndustry && matchQuery;
    });
  }, [solutions, selectedIndustry, searchQuery]);

  return (
    <div className="w-full flex flex-col lg:flex-row items-start gap-8 lg:gap-10">
      {/* --- LEFT COLUMN: Dynamic Industry Filter --- */}
      <aside className="w-full lg:w-[280px] xl:w-[300px] shrink-0 bg-[#fdfdfd] border border-gray-100 rounded-2xl p-6 shadow-sm">
        <h3 className="text-[20px] font-bold text-[#010101] mb-5 tracking-tight">Filter</h3>

        <div className="flex flex-col gap-4">

          <div className="flex flex-col gap-3">
            {/* "All" option */}
            <label className="flex items-start gap-3 cursor-pointer group select-none text-[14px] leading-snug">
              <div className="relative flex items-center justify-center mt-0.5">
                <input
                  type="radio"
                  name="industry-filter"
                  value="all"
                  checked={selectedIndustry === "all"}
                  onChange={() => setSelectedIndustry("all")}
                  className="sr-only"
                />
                <div
                  className={`w-4 h-4 rounded-full border transition-all flex items-center justify-center ${
                    selectedIndustry === "all"
                      ? "border-[#0451bf] bg-white ring-2 ring-[#0451bf]/20"
                      : "border-gray-300 bg-white group-hover:border-gray-400"
                  }`}
                >
                  {selectedIndustry === "all" && (
                    <div className="w-2 h-2 rounded-full bg-[#0451bf]" />
                  )}
                </div>
              </div>
              <span
                className={`transition-colors ${
                  selectedIndustry === "all"
                    ? "text-[#010101] font-semibold"
                    : "text-[#010101]/80 group-hover:text-[#010101]"
                }`}
              >
                All
              </span>
            </label>

            {/* Dynamic industries from CMS */}
            {(industries || []).map((ind) => {
              const val = ind.slug || String(ind.id);
              const isChecked = selectedIndustry === val;

              return (
                <label
                  key={ind.id}
                  className="flex items-start gap-3 cursor-pointer group select-none text-[14px] leading-snug"
                >
                  <div className="relative flex items-center justify-center mt-0.5">
                    <input
                      type="radio"
                      name="industry-filter"
                      value={val}
                      checked={isChecked}
                      onChange={() => setSelectedIndustry(val)}
                      className="sr-only"
                    />
                    <div
                      className={`w-4 h-4 rounded-full border transition-all flex items-center justify-center ${
                        isChecked
                          ? "border-[#0451bf] bg-white ring-2 ring-[#0451bf]/20"
                          : "border-gray-300 bg-white group-hover:border-gray-400"
                      }`}
                    >
                      {isChecked && (
                        <div className="w-2 h-2 rounded-full bg-[#0451bf]" />
                      )}
                    </div>
                  </div>
                  <span
                    className={`transition-colors ${
                      isChecked
                        ? "text-[#010101] font-semibold"
                        : "text-[#010101]/80 group-hover:text-[#010101]"
                    }`}
                  >
                    {ind.name}
                  </span>
                </label>
              );
            })}

            {(!industries || industries.length === 0) && (
              <p className="text-[12px] text-gray-400 italic px-1 pt-1">
                (Belum ada data industri di CMS)
              </p>
            )}
          </div>
        </div>
      </aside>

      {/* --- RIGHT COLUMN: Search & Table / List --- */}
      <main className="flex-1 w-full flex flex-col gap-6">
        {/* Search Bar */}
        <div className="w-full relative">
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") {
                e.currentTarget.blur();
              }
            }}
            placeholder="Search use case and press Enter..."
            className="w-full h-[52px] pl-4 pr-20 rounded-xl bg-[#fdfdfd] border border-gray-200 text-[#010101] placeholder-gray-400 text-[14px] md:text-[15px] focus:outline-none focus:border-[#0451bf] focus:ring-2 focus:ring-[#0451bf]/15 transition-all shadow-sm"
          />
          <div className="absolute right-4 top-1/2 -translate-y-1/2 flex items-center gap-2">
            {searchQuery && (
              <button
                type="button"
                onClick={() => setSearchQuery("")}
                className="p-1 rounded-full text-gray-400 hover:text-gray-600 hover:bg-gray-100 transition-colors"
                title="Hapus pencarian"
              >
                <X className="w-4 h-4" />
              </button>
            )}
            <Search className="w-5 h-5 text-gray-400 pointer-events-none" />
          </div>
        </div>

        {/* Desktop Table View */}
        <div className="hidden md:block w-full overflow-x-auto rounded-2xl border border-gray-100 bg-[#fdfdfd] shadow-sm">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-gray-100 bg-gray-50/50">
                <th className="py-4 px-6 text-[14px] font-semibold text-[#010101] w-[26%]">Use Case</th>
                <th className="py-4 px-6 text-[14px] font-semibold text-[#010101] w-[34%]">Description</th>
                <th className="py-4 px-6 text-[14px] font-semibold text-[#010101] w-[18%]">Industry</th>
                <th className="py-4 px-6 text-[14px] font-semibold text-[#010101] w-[22%]">Solution Category</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {filteredSolutions.length === 0 ? (
                <tr>
                  <td colSpan={4} className="py-16 text-center text-gray-500 font-medium text-[15px]">
                    {solutions.length === 0 ? (
                      <div className="flex flex-col items-center gap-2">
                        <p>Belum ada data solution use case yang dipublikasikan di CMS.</p>
                        <span className="text-[13px] text-gray-400">
                          Tambahkan data solusi melalui dashboard admin Payload CMS (/admin).
                        </span>
                      </div>
                    ) : (
                      <div className="flex flex-col items-center gap-2">
                        <p>
                          Tidak ada solusi yang cocok dengan pencarian{" "}
                          {searchQuery ? `"${searchQuery}"` : "filter yang dipilih"}.
                        </p>
                        <button
                          type="button"
                          onClick={() => {
                            setSearchQuery("");
                            setSelectedIndustry("all");
                          }}
                          className="mt-1 text-[13px] font-semibold text-[#0451bf] hover:underline cursor-pointer"
                        >
                          Reset Pencarian & Filter
                        </button>
                      </div>
                    )}
                  </td>
                </tr>
              ) : (
                filteredSolutions.map((item) => {
                  const industryObj =
                    typeof item.industry === "object" && item.industry !== null
                      ? (item.industry as Industry)
                      : null;
                  const industryLabel = industryObj?.name || "General";

                  const formattedDate = item.publishedDate
                    ? new Date(item.publishedDate).toLocaleDateString("id-ID", {
                        day: "numeric",
                        month: "long",
                        year: "numeric",
                      })
                    : "";

                  return (
                    <tr key={item.id} className="hover:bg-gray-50/60 transition-colors group">
                      {/* Use Case */}
                      <td className="py-5 px-6 align-top">
                        <Link
                          href={`/solution/${item.slug || item.id}`}
                          className="font-bold text-[15px] lg:text-[16px] leading-[140%] text-[#010101] group-hover:text-[#0451bf] transition-colors block"
                        >
                          {item.title}
                        </Link>
                        {formattedDate && (
                          <span className="inline-block mt-2 text-[12px] font-semibold text-[#e02d3c]">
                            Posted on {formattedDate}
                          </span>
                        )}
                      </td>

                      {/* Description */}
                      <td className="py-5 px-6 align-top">
                        <p className="text-[13px] lg:text-[14px] leading-[160%] text-[#010101]/80 line-clamp-3">
                          {item.excerpt}
                        </p>
                        <Link
                          href={`/solution/${item.slug || item.id}`}
                          className="inline-block mt-2 font-semibold text-[13px] text-[#010101] underline underline-offset-2 hover:text-[#0451bf] transition-colors"
                        >
                          Details
                        </Link>
                      </td>

                      {/* Industry Badge */}
                      <td className="py-5 px-6 align-top">
                        <span className="inline-flex items-center px-3 py-1.5 rounded-full text-[12px] font-semibold bg-[#0451bf] text-white whitespace-normal shadow-sm">
                          {industryLabel}
                        </span>
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
                              const badgeClass = getCategoryBadgeClass(catObj?.badgeColor);

                              return (
                                <span
                                  key={catObj?.id || String(catItem)}
                                  className={`inline-flex items-center px-3 py-1 rounded-full text-[11px] font-semibold leading-tight shadow-sm ${badgeClass}`}
                                >
                                  {label}
                                </span>
                              );
                            })
                          ) : (
                            <span className="text-[12px] text-gray-400">-</span>
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

        {/* Mobile / Tablet Card View */}
        <div className="block md:hidden w-full flex flex-col gap-4">
          {filteredSolutions.length === 0 ? (
            <div className="py-12 text-center text-gray-500 font-medium text-[14px] bg-white rounded-xl border border-gray-100 p-6 flex flex-col items-center gap-2">
              {solutions.length === 0 ? (
                <>
                  <p>Belum ada data solution use case yang dipublikasikan di CMS.</p>
                  <span className="text-[12px] text-gray-400">
                    Tambahkan data solusi melalui dashboard admin Payload CMS (/admin).
                  </span>
                </>
              ) : (
                <>
                  <p>
                    Tidak ada solusi yang cocok dengan pencarian{" "}
                    {searchQuery ? `"${searchQuery}"` : "filter yang dipilih"}.
                  </p>
                  <button
                    type="button"
                    onClick={() => {
                      setSearchQuery("");
                      setSelectedIndustry("all");
                    }}
                    className="mt-1 text-[13px] font-semibold text-[#0451bf] hover:underline cursor-pointer"
                  >
                    Reset Pencarian & Filter
                  </button>
                </>
              )}
            </div>
          ) : (
            filteredSolutions.map((item) => {
              const industryObj =
                typeof item.industry === "object" && item.industry !== null
                  ? (item.industry as Industry)
                  : null;
              const industryLabel = industryObj?.name || "General";

              const formattedDate = item.publishedDate
                ? new Date(item.publishedDate).toLocaleDateString("id-ID", {
                    day: "numeric",
                    month: "long",
                    year: "numeric",
                  })
                : "";

              return (
                <div
                  key={item.id}
                  className="bg-[#fdfdfd] border border-gray-100 rounded-xl p-5 shadow-sm flex flex-col gap-3"
                >
                  <div className="flex flex-wrap gap-2 items-center justify-between">
                    <span className="inline-flex items-center px-2.5 py-1 rounded-full text-[11px] font-semibold bg-[#0451bf] text-white">
                      {industryLabel}
                    </span>
                    {formattedDate && (
                      <span className="text-[11px] font-semibold text-[#e02d3c]">
                        Posted on {formattedDate}
                      </span>
                    )}
                  </div>

                  <Link
                    href={`/solution/${item.slug || item.id}`}
                    className="font-bold text-[16px] leading-[140%] text-[#010101] hover:text-[#0451bf] transition-colors"
                  >
                    {item.title}
                  </Link>

                  <p className="text-[13px] leading-[160%] text-[#010101]/80 line-clamp-3">
                    {item.excerpt}
                  </p>

                  <div className="flex flex-wrap gap-1.5 pt-1">
                    {(item.solutionCategories || []).map((catItem) => {
                      const catObj =
                        typeof catItem === "object" && catItem !== null
                          ? (catItem as SolutionCategory)
                          : null;
                      const label = catObj?.name || String(catItem);
                      const badgeClass = getCategoryBadgeClass(catObj?.badgeColor);

                      return (
                        <span
                          key={catObj?.id || String(catItem)}
                          className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-semibold ${badgeClass}`}
                        >
                          {label}
                        </span>
                      );
                    })}
                  </div>

                  <div className="pt-2 border-t border-gray-100 flex items-center justify-end">
                    <Link
                      href={`/solution/${item.slug || item.id}`}
                      className="font-semibold text-[13px] text-[#0451bf] hover:underline"
                    >
                      Details &rarr;
                    </Link>
                  </div>
                </div>
              );
            })
          )}
        </div>
      </main>
    </div>
  );
}
