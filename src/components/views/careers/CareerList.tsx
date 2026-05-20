"use client";

import React, { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import { Career } from "../../../../payload-types"; // Sesuaikan path

interface CareerListProps {
  careers: Career[];
}

export default function CareerList({ careers }: CareerListProps) {
  const [activeCategory, setActiveCategory] = useState("Semua");
  const categories = [
    "Semua",
    "Developer",
    "Administrasi",
    "Marketing",
    "Internship",
    "Freelance",
  ];

  const filteredCareers = careers.filter(
    (job) =>
      activeCategory === "Semua" ||
      job.category === activeCategory.toLowerCase(),
  );

  const urgentJobs = filteredCareers.filter((job) => job.isUrgent);
  const regularJobs = filteredCareers.filter((job) => !job.isUrgent);

  return (
    <section className="w-full flex flex-col items-center px-4 lg:px-[120px] 2xl:px-[240px] py-[40px] gap-[22px] text-[#010101] bg-[#fdfdfd]">
      <div className="w-full flex flex-wrap items-center justify-start gap-[12px] mb-4">
        {categories.map((cat) => {
          const isActive = activeCategory === cat;
          return (
            <button
              key={cat}
              onClick={() => setActiveCategory(cat)}
              className={`rounded-[99px] flex items-center justify-center px-[20px] py-[5px] font-semibold text-[14px] leading-[180%] transition-colors ${
                isActive
                  ? "bg-[#0451bf] text-[#fdfdfd]"
                  : "bg-[#fdfdfd] border border-[#0451bf] text-[#0451bf] hover:bg-[#0451bf]/5"
              }`}
            >
              {cat}
            </button>
          );
        })}
      </div>

      {filteredCareers.length === 0 && (
        <div className="w-full text-center py-20 font-medium text-[16px] text-gray-500">
          Belum ada lowongan untuk kategori ini. Silakan tunggu informasi
          berikutnya!
        </div>
      )}

      {urgentJobs.length > 0 && (
        <div className="w-full flex flex-col gap-[20px]">
          {urgentJobs.map((job) => {
            const imageUrl =
              job.image && typeof job.image === "object" ? job.image.url : null;
            return (
              <div
                key={job.id}
                className="w-full shadow-[0px_4px_10px_1px_rgba(0,0,0,0.1)] rounded-[20px] bg-[#fdfdfd] overflow-hidden flex flex-col xl:flex-row items-start gap-0 xl:gap-[20px]"
              >
                <div className="w-full xl:w-[500px] h-[300px] xl:h-[500px] shrink-0 relative">
                  {imageUrl && (
                    <Image
                      src={imageUrl}
                      alt={job.title}
                      fill
                      className="object-cover"
                    />
                  )}
                </div>

                <div className="flex-1 flex flex-col items-start p-[20px] gap-[16px] w-full">
                  <div className="flex items-center gap-[16px]">
                    <div className="bg-[#f31b4a] text-[#fdfdfd] rounded-[99px] px-[14px] py-[5px] font-semibold text-[14px] leading-[180%] flex items-center justify-center">
                      URGENT!
                    </div>

                    <div className="bg-[#7eb2fc]/25 text-[#0451bf] rounded-[99px] px-[14px] py-[5px] font-semibold text-[14px] leading-[180%] flex items-center justify-center capitalize">
                      {job.category}
                    </div>
                  </div>

                  <h2 className="text-[24px] xl:text-[28px] font-bold leading-[180%] text-[#010101]">
                    {job.title}
                  </h2>

                  <p className="text-[14px] xl:text-[15px] font-medium leading-[180%] text-[#010101]">
                    {job.shortDescription}
                  </p>

                  <div className="w-full rounded-[20px] bg-[#7eb2fc]/10 flex flex-wrap xl:flex-nowrap items-center justify-between px-[20px] xl:px-[40px] gap-[10px] xl:gap-[20px] mt-2">
                    {[
                      { label: "Skill", val: job.skill },
                      { label: "Tipe", val: job.type },
                      { label: "Lokasi", val: job.location },
                      { label: "Pengalaman", val: job.experience },
                    ].map((item, idx) => (
                      <React.Fragment key={idx}>
                        <div className="flex flex-col items-center justify-center p-[15px_10px] xl:p-[22px_36px] gap-[4px]">
                          <span className="font-medium text-[12px] leading-[120%] text-[#010101]">
                            {item.label}
                          </span>

                          <span className="font-bold text-[16px] xl:text-[20px] leading-[120%] text-[#04459f] text-center">
                            {item.val}
                          </span>
                        </div>
                        {idx !== 3 && (
                          <div className="hidden xl:block w-[2px] h-[30px] bg-gray-300"></div>
                        )}
                      </React.Fragment>
                    ))}
                  </div>

                  <Link
                    href={`/careers/${job.slug}`}
                    className="bg-[#0451bf] text-[#fdfdfd] rounded-[10px] flex items-center justify-center px-[20px] py-[12px] gap-[10px] mt-2 font-semibold text-[16px] leading-[175%] hover:bg-blue-800 transition-colors w-full md:w-auto"
                  >
                    Lihat Detail
                    <svg
                      className="w-[20px] h-[20px]"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M14 5l7 7m0 0l-7 7m7-7H3"
                      />
                    </svg>
                  </Link>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {regularJobs.length > 0 && (
        <div className="w-full grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-[20px]">
          {regularJobs.map((job) => {
            const imageUrl =
              job.image && typeof job.image === "object" ? job.image.url : null;
            return (
              <div
                key={job.id}
                className="w-full shadow-[0px_4px_10px_1px_rgba(0,0,0,0.1)] rounded-[20px] bg-[#fdfdfd] overflow-hidden flex flex-col items-start gap-[20px]"
              >
                <div className="w-full h-[240px] xl:h-[360px] shrink-0 relative">
                  {imageUrl && (
                    <Image
                      src={imageUrl}
                      alt={job.title}
                      fill
                      className="object-cover"
                    />
                  )}
                </div>

                <div className="flex flex-col items-start p-[20px] gap-[16px] w-full">
                  <div className="bg-[#7eb2fc]/25 text-[#0451bf] rounded-[99px] px-[14px] py-[5px] font-semibold text-[14px] leading-[180%] flex items-center justify-center capitalize">
                    {job.category}
                  </div>

                  <h2 className="text-[22px] xl:text-[24px] font-bold leading-[140%] text-[#010101]">
                    {job.title}
                  </h2>

                  <p className="text-[14px] xl:text-[15px] font-medium leading-[180%] text-[#010101] line-clamp-3">
                    {job.shortDescription}
                  </p>

                  <div className="w-full flex flex-col gap-[10px] mt-2">
                    <div className="w-full rounded-[20px] bg-[#7eb2fc]/10 flex items-center justify-between px-[20px] xl:px-[40px] py-[15px]">
                      <div className="flex flex-col items-center gap-[4px] w-1/2">
                        <span className="font-medium text-[12px] leading-[120%] text-[#010101]">
                          Skill
                        </span>

                        <span className="font-bold text-[16px] leading-[120%] text-[#04459f] text-center">
                          {job.skill}
                        </span>
                      </div>

                      <div className="w-[2px] h-[30px] bg-gray-300"></div>

                      <div className="flex flex-col items-center gap-[4px] w-1/2">
                        <span className="font-medium text-[12px] leading-[120%] text-[#010101]">
                          Pengalaman
                        </span>

                        <span className="font-bold text-[16px] leading-[120%] text-[#04459f] text-center">
                          {job.experience}
                        </span>
                      </div>
                    </div>

                    <div className="w-full rounded-[20px] bg-[#7eb2fc]/10 flex items-center justify-between px-[20px] xl:px-[40px] py-[15px]">
                      <div className="flex flex-col items-center gap-[4px] w-1/2">
                        <span className="font-medium text-[12px] leading-[120%] text-[#010101]">
                          Lokasi
                        </span>

                        <span className="font-bold text-[16px] leading-[120%] text-[#04459f] text-center">
                          {job.location}
                        </span>
                      </div>

                      <div className="w-[2px] h-[30px] bg-gray-300"></div>

                      <div className="flex flex-col items-center gap-[4px] w-1/2">
                        <span className="font-medium text-[12px] leading-[120%] text-[#010101]">
                          Tipe
                        </span>

                        <span className="font-bold text-[16px] leading-[120%] text-[#04459f] text-center">
                          {job.type}
                        </span>
                      </div>
                    </div>
                  </div>

                  <Link
                    href={`/careers/${job.slug}`}
                    className="w-full bg-[#0451bf] text-[#fdfdfd] rounded-[10px] flex items-center justify-center px-[20px] py-[12px] gap-[10px] font-semibold text-[16px] leading-[175%] hover:bg-blue-800 transition-colors mt-2"
                  >
                    Lihat
                    <svg
                      className="w-[20px] h-[20px]"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M14 5l7 7m0 0l-7 7m7-7H3"
                      />
                    </svg>
                  </Link>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </section>
  );
}
