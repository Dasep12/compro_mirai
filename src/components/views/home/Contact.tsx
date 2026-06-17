"use client";

import React, { useState } from "react";

const WA_NUMBER = "6281188862020";
const WA_CONTACT_NAME = "Tim Mirai Softnet";

type SubmitStatus = "idle" | "success" | "error";

export default function Contact() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    phone: "",
    message: "",
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState<SubmitStatus>("idle");

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });

    if (submitStatus !== "idle") setSubmitStatus("idle");
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setSubmitStatus("idle");

    try {
      const response = await fetch("/api/visitors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        throw new Error(`Server error: ${response.status}`);
      }

      const textMessage = `Halo ${WA_CONTACT_NAME},\n\nSaya tertarik untuk berdiskusi mengenai Layanan atau Produk Anda di Mirai Softnet & Technology.\n\n*Detail Kontak:*\n- Nama: ${formData.name}\n- Email: ${formData.email}\n- Telp: ${formData.phone}\n\n*Pesan:*\n${formData.message}`;

      const encodedMessage = encodeURIComponent(textMessage);
      const waUrl = `https://wa.me/${WA_NUMBER}?text=${encodedMessage}`;
      window.open(waUrl, "_blank");

      setSubmitStatus("success");
      setFormData({ name: "", email: "", phone: "", message: "" });
    } catch (error) {
      console.error("Error submitting form:", error);

      setSubmitStatus("error");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <section className="w-full relative flex flex-col xl:flex-row items-center xl:items-start justify-between bg-primary px-4 sm:px-8 lg:px-[120px] 2xl:px-[calc(50vw-600px)] py-10 sm:py-14 lg:py-16 gap-10 xl:gap-20 text-[#fdfdfd]">
      <div className="flex-1 flex flex-col items-start gap-8 sm:gap-10 w-full">
        <div className="flex flex-col gap-4">
          <h2 className="text-[30px] sm:text-[36px] md:text-[46px] font-bold leading-[125%]">
            Mari Mulai Transformasi Digital Anda
          </h2>

          <p className="text-[14px] sm:text-[15px] md:text-[16px] leading-[180%] font-medium text-[#fdfdfd]/90">
            Diskusikan kebutuhan teknologi perusahaan Anda dengan tim ahli kami.
            Kami siap memberikan solusi yang presisi dan berdampak nyata bagi
            efisiensi bisnis Anda.
          </p>
        </div>

        <div className="flex flex-col gap-4 text-[14px] sm:text-[15px] md:text-[16px] font-medium leading-[180%]">
          <div className="flex items-center gap-4">
            <svg
              className="w-5 h-5 shrink-0"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
              />
            </svg>
            <span>marketing@miraisoftnet.com</span>
          </div>
          <div className="flex items-center gap-4">
            <svg
              className="w-5 h-5 shrink-0"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
              />
            </svg>
            <span>+62 (021) 50 666 222</span>
          </div>
          <div className="flex items-center gap-4">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
              <path d="M0 0h24v24H0z" fill="none" />
              <path fill="#fff" d="M19.05 4.91A9.82 9.82 0 0 0 12.04 2c-5.46 0-9.91 4.45-9.91 9.91c0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38c1.45.79 3.08 1.21 4.74 1.21c5.46 0 9.91-4.45 9.91-9.91c0-2.65-1.03-5.14-2.9-7.01m-7.01 15.24c-1.48 0-2.93-.4-4.2-1.15l-.3-.18l-3.12.82l.83-3.04l-.2-.31a8.26 8.26 0 0 1-1.26-4.38c0-4.54 3.7-8.24 8.24-8.24c2.2 0 4.27.86 5.82 2.42a8.18 8.18 0 0 1 2.41 5.83c.02 4.54-3.68 8.23-8.22 8.23m4.52-6.16c-.25-.12-1.47-.72-1.69-.81c-.23-.08-.39-.12-.56.12c-.17.25-.64.81-.78.97c-.14.17-.29.19-.54.06c-.25-.12-1.05-.39-1.99-1.23c-.74-.66-1.23-1.47-1.38-1.72c-.14-.25-.02-.38.11-.51c.11-.11.25-.29.37-.43s.17-.25.25-.41c.08-.17.04-.31-.02-.43s-.56-1.34-.76-1.84c-.2-.48-.41-.42-.56-.43h-.48c-.17 0-.43.06-.66.31c-.22.25-.86.85-.86 2.07s.89 2.4 1.01 2.56c.12.17 1.75 2.67 4.23 3.74c.59.26 1.05.41 1.41.52c.59.19 1.13.16 1.56.1c.48-.07 1.47-.6 1.67-1.18c.21-.58.21-1.07.14-1.18s-.22-.16-.47-.28" />
            </svg>

            <span>+62 811-8886-2020</span>
          </div>
          <div className="flex items-start gap-4">
            <svg
              className="w-5 h-5 shrink-0 mt-1"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0zM15 11a3 3 0 11-6 0 3 3 0 016 0z"
              />
            </svg>
            <span>
              Vasanta Innopark No T-51, Jl. Kalimantan, Gandamekar, Kec.
              Cikarang Barat, Bekasi.
            </span>
          </div>
        </div>
      </div>

      <form
        onSubmit={handleSubmit}
        className="w-full lg:w-[80%] xl:w-[536px] shrink-0 flex flex-col gap-3 font-medium"
      >
        <input
          type="text"
          name="name"
          value={formData.name}
          onChange={handleChange}
          required
          placeholder="Nama Anda"
          className="w-full bg-[#fdfdfd] text-[#010101] rounded-[4px] px-[22px] py-[14px] outline-none placeholder-[#53938b]/70 focus:ring-2 focus:ring-[#fa9f29] transition-all"
        />

        <div className="w-full flex flex-col md:flex-row gap-3">
          <input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
            placeholder="Email Perusahaan"
            className="flex-1 w-full bg-[#fdfdfd] text-[#010101] rounded-[4px] px-[22px] py-[14px] outline-none placeholder-[#53938b]/70 focus:ring-2 focus:ring-[#fa9f29] transition-all"
          />

          <input
            type="tel"
            name="phone"
            value={formData.phone}
            onChange={handleChange}
            required
            placeholder="Nomor Telepon"
            className="flex-1 w-full bg-[#fdfdfd] text-[#010101] rounded-[4px] px-[22px] py-[14px] outline-none placeholder-[#53938b]/70 focus:ring-2 focus:ring-[#fa9f29] transition-all"
          />
        </div>

        <textarea
          name="message"
          value={formData.message}
          onChange={handleChange}
          required
          placeholder="Pesan"
          className="w-full h-[120px] bg-[#fdfdfd] text-[#010101] rounded-[4px] px-[22px] py-[14px] outline-none placeholder-[#53938b]/70 resize-none focus:ring-2 focus:ring-[#fa9f29] transition-all"
        />

        {submitStatus === "success" && (
          <div className="flex items-center gap-2 bg-[#fdfdfd]/15 border border-[#fdfdfd]/30 rounded-[6px] px-4 py-3 text-[14px] font-medium">
            <svg
              className="w-4 h-4 shrink-0 text-green-300"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M5 13l4 4L19 7"
              />
            </svg>
            <span>Pesan terkirim! WhatsApp akan terbuka otomatis.</span>
          </div>
        )}

        {submitStatus === "error" && (
          <div className="flex items-center gap-2 bg-red-500/20 border border-red-400/40 rounded-[6px] px-4 py-3 text-[14px] font-medium">
            <svg
              className="w-4 h-4 shrink-0 text-red-300"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
            <span>
              Terjadi kesalahan. Coba lagi atau hubungi kami langsung.
            </span>
          </div>
        )}

        <button
          type="submit"
          disabled={isSubmitting}
          className="w-full bg-[#fa9f29] text-[#fdfdfd] font-semibold text-[16px] rounded-[10px] py-[14px] mt-1 hover:bg-[#e08b20] transition-colors disabled:opacity-70 disabled:cursor-not-allowed flex items-center justify-center gap-2"
        >
          {isSubmitting ? (
            <>
              <svg
                className="animate-spin w-4 h-4"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  className="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  strokeWidth="4"
                />
                <path
                  className="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"
                />
              </svg>
              Mengirim...
            </>
          ) : (
            "Coba Sekarang"
          )}
        </button>
      </form>
    </section>
  );
}
