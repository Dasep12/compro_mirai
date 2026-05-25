"use client";

import React, { useState } from "react";

export default function Contact() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    phone: "",
    message: "",
  });
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    try {
      const response = await fetch("/api/visitors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        console.error("Gagal menyimpan data pengunjung");
      }

      const waNumber = "6285218026895";
      const textMessage = `Halo Pak Saputro,\n\nSaya tertarik untuk berdiskusi mengenai Layanan atau Produk Anda di Mirai Softnet & Technology.\n\n*Detail Kontak:*\n- Nama: ${formData.name}\n- Email: ${formData.email}\n- Telp: ${formData.phone}\n\n*Pesan:*\n${formData.message}`;

      const encodedMessage = encodeURIComponent(textMessage);
      const waUrl = `https://wa.me/${waNumber}?text=${encodedMessage}`;

      window.open(waUrl, "_blank");

      setFormData({ name: "", email: "", phone: "", message: "" });
    } catch (error) {
      console.error("Error submitting form:", error);
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
            <span>info@miraisoftnet.com</span>
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
                d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
              />
            </svg>
            <span>Saputro Dwi Novianto (+62 852 1802 6895)</span>
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
            type="text"
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

        <button
          type="submit"
          disabled={isSubmitting}
          className="w-full bg-[#fa9f29] text-[#fdfdfd] font-semibold text-[16px] rounded-[10px] py-[14px] mt-1 hover:bg-[#e08b20] transition-colors disabled:opacity-70 disabled:cursor-not-allowed"
        >
          {isSubmitting ? "Mengirim..." : "Coba Sekarang"}
        </button>
      </form>
    </section>
  );
}
