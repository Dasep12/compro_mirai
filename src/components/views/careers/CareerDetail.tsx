"use client";

import Image from "next/image";
import Link from "next/link";
import { RichText } from "@payloadcms/richtext-lexical/react";
import { Career } from "../../../../payload-types";

interface CareerDetailProps {
  job: Career;
}

export default function CareerDetail({ job }: CareerDetailProps) {
  const imageUrl =
    job.image && typeof job.image === "object" ? job.image.url : null;
  const imageAlt =
    job.image && typeof job.image === "object" ? job.image.alt : job.title;

  const handleApplyClick = () => {
    const subject = encodeURIComponent(
      `Lamaran Pekerjaan: ${job.title} - Mirai Softnet`,
    );
    window.location.href = `mailto:info@miraisoftnet.com?subject=${subject}`;
  };

  return (
    <article className="w-full relative overflow-hidden flex flex-col items-start px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-8 sm:py-10 lg:py-14 gap-6 sm:gap-8 lg:gap-[22px] text-[#010101] bg-[#fdfdfd] font-sans">
      <Link
        href="/careers"
        className="rounded-[10px] bg-[#fdfdfd] border border-gray-200 lg:border-none flex items-center gap-[10px] p-2 text-[#0451bf] font-semibold text-[15px] sm:text-[16px] leading-[175%] no-underline hover:opacity-80 transition-opacity"
      >
        <svg
          className="w-[23px] h-[23px]"
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
        <span>Kembali</span>
      </Link>

      <div className="w-full flex flex-col lg:flex-row items-start gap-6 sm:gap-8 lg:gap-12 xl:gap-[20px]">
        <div className="w-full lg:w-5/12 xl:w-[630px] h-[240px] sm:h-[350px] md:h-[500px] xl:h-[630px] shrink-0 rounded-[20px] overflow-hidden relative bg-gray-50 p-4 shadow-sm">
          {imageUrl ? (
            <Image
              src={imageUrl}
              alt={imageAlt || "Career Illustration"}
              fill
              priority
              quality={100}
              sizes="(max-width: 1280px) 100vw, 630px"
              className="object-cover rounded-[20px]"
            />
          ) : (
            <div className="w-full h-full flex items-center justify-center text-gray-400 font-medium">
              Belum ada Ilustrasi Lowongan
            </div>
          )}
        </div>

        <div className="flex-1 w-full flex flex-col items-start gap-4 sm:gap-5 xl:gap-[20px]">
          <div className="bg-[#7eb2fc]/25 text-[#0451bf] rounded-[99px] flex items-center justify-center px-[14px] py-[5px] text-[13px] sm:text-[14px] font-semibold leading-[180%] capitalize">
            {job.category === "developer" ? "Software Developer" : job.category}
          </div>

          <h1 className="text-[28px] sm:text-[34px] lg:text-[40px] font-bold leading-[130%] sm:leading-[125%] text-[#010101]">
            {job.title}
          </h1>

          <p className="w-full text-[14px] sm:text-[15px] lg:text-[16px] leading-[180%] sm:leading-[200%] font-medium text-[#010101] text-left sm:text-justify">
            {job.shortDescription}
          </p>

          <div className="w-full rounded-[20px] bg-[#7eb2fc]/10 grid grid-cols-2 lg:grid-cols-4 gap-4 p-4 text-center border border-primary/5">
            {[
              { label: "Skill", val: job.skill },
              { label: "Tipe", val: job.type },
              { label: "Lokasi", val: job.location },
              { label: "Pengalaman", val: job.experience },
            ].map((item, i) => (
              <div
                key={i}
                className="flex flex-col items-center justify-center py-2"
              >
                <span className="text-[12px] font-medium leading-[120%] text-gray-500 uppercase tracking-wider mb-1">
                  {item.label}
                </span>
                <span className="text-[16px] xl:text-[18px] font-bold leading-[120%] text-[#04459f]">
                  {item.val}
                </span>
              </div>
            ))}
          </div>

          <div className="w-full flex flex-col gap-6 mt-2 text-left">
            <div
              className="w-full text-[16px] leading-[180%] font-medium text-[#010101] text-left xl:text-justify
      [&_h1]:text-[28px] [&_h1]:md:text-[32px] [&_h1]:font-bold [&_h1]:leading-[125%] [&_h1]:text-[#010101] [&_h1]:mb-4 [&_h1]:mt-6
      [&_h2]:text-[23px] [&_h2]:md:text-[26px] [&_h2]:font-bold [&_h2]:leading-[125%] [&_h2]:text-[#010101] [&_h2]:mb-3 [&_h2]:mt-5
      [&_h3]:text-[20px] [&_h3]:font-bold [&_h3]:leading-[125%] [&_h3]:text-[#010101] [&_h3]:mb-2 [&_h3]:mt-4
      [&_h4]:text-[18px] [&_h4]:font-bold [&_h4]:leading-[130%] [&_h4]:text-[#010101] [&_h4]:mb-2 [&_h4]:mt-3
      [&_h5]:text-[16px] [&_h5]:font-bold [&_h5]:leading-[140%] [&_h5]:text-[#010101] [&_h5]:mb-2 [&_h5]:mt-3
      [&_h6]:text-[14px] [&_h6]:font-bold [&_h6]:leading-[150%] [&_h6]:text-[#010101] [&_h6]:mb-2 [&_h6]:mt-3
      [&_p]:mb-4 [&_p]:last:mb-0
      [&_a]:text-[#0451bf] [&_a]:underline [&_a]:font-semibold hover:[&_a]:text-blue-800
      [&_strong]:font-bold [&_b]:font-bold
      [&_blockquote]:border-l-4 [&_blockquote]:border-[#0451bf] [&_blockquote]:pl-4 [&_blockquote]:italic [&_blockquote]:text-[#010101]/70 [&_blockquote]:mb-4 [&_blockquote]:my-4
      [&_ul]:list-disc [&_ul]:pl-[21px] [&_ul]:mb-4
      [&_ol]:list-decimal [&_ol]:pl-[21px] [&_ol]:mb-4
      [&_li]:mb-1 [&_li]:leading-[180%]"
            >
              {job.content && <RichText data={job.content} />}
            </div>
          </div>

          <button
            onClick={handleApplyClick}
            className="w-full xl:w-auto bg-[#0451bf] text-[#fdfdfd] rounded-[10px] flex items-center justify-center px-[40px] py-[12px] font-semibold text-[16px] leading-[175%] hover:bg-blue-800 transition-colors mt-4 shadow-sm"
          >
            Lamar Sekarang
          </button>
        </div>
      </div>
    </article>
  );
}
