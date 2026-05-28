import type { Metadata, Viewport } from "next";
import { Plus_Jakarta_Sans } from "next/font/google";
import "./globals.css";
import AppBar from "@/components/ui/AppBar";
import Footer from "@/components/ui/Footer";
import { getProducts, getServices } from "@/lib/data/collections";

const jakarta = Plus_Jakarta_Sans({
  variable: "--font-jakarta",
  subsets: ["latin"],
});

export const viewport: Viewport = {
  themeColor: "#0451b1",
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
};

export const metadata: Metadata = {
  metadataBase: new URL("https://miraisoftnet.com"),
  applicationName: "Mirai Softnet",
  category: "technology",
  title: {
    default: "Mirai Softnet & Technology",
    template: "%s | Mirai Softnet",
  },
  description:
    "Memberikan solusi teknologi terbaik untuk akselerasi bisnis Anda melalui layanan IT, pengembangan produk unggulan, dan peluang karir profesional.",
  keywords: [
    "Software House Bekasi",
    "IT Consultant",
    "Pengembangan Aplikasi",
    "Solusi Teknologi",
    "Mirai Softnet",
  ],
  authors: [
    { name: "Mirai Softnet & Technology", url: "https://miraisoftnet.com" },
  ],
  creator: "Mirai Softnet & Technology",
  publisher: "Mirai Softnet & Technology",

  robots: {
    index: true,
    follow: true,
    nocache: false,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },

  alternates: {
    canonical: "/",
  },

  verification: {
    // google: "#",
    // yandex: "#",
    // yahoo: "#",
  },

  formatDetection: {
    telephone: false,
    date: false,
    email: false,
    address: false,
  },

  appleWebApp: {
    capable: true,
    title: "Mirai Softnet",
    statusBarStyle: "black-translucent",
  },

  openGraph: {
    type: "website",
    locale: "id_ID",
    url: "https://miraisoftnet.com",
    title: "Mirai Softnet & Technology",
    siteName: "Mirai Softnet",
    description:
      "Memberikan solusi teknologi terbaik untuk akselerasi bisnis Anda melalui layanan IT dan pengembangan produk unggulan.",
    images: [
      {
        url: "/api/media/file/mirai-black.png",
        width: 1200,
        height: 630,
        alt: "Mirai Softnet & Technology Logo",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Mirai Softnet & Technology",
    description: "Solusi teknologi terbaik untuk akselerasi bisnis Anda.",
    images: ["/api/media/file/mirai-black.png"],
  },

  icons: {
    icon: [{ url: "/favicon.ico?v=2", sizes: "any", type: "image/x-icon" }],
  },
};

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const [services, products] = await Promise.all([
    getServices(10),
    getProducts(10),
  ]);

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Organization",
    name: "Mirai Softnet & Technology",
    url: "https://miraisoftnet.com",
    logo: "https://miraisoftnet.com/api/media/file/mirai-black.png",
    description:
      "Memberikan solusi teknologi terbaik untuk akselerasi bisnis Anda melalui layanan IT dan pengembangan produk unggulan.",
    contactPoint: {
      "@type": "ContactPoint",
      telephone: "+62-852-1802-6895",
      contactType: "customer service",
    },
  };

  return (
    <html lang="id" className={`${jakarta.variable} h-full antialiased`}>
      <body className="min-h-full flex flex-col font-sans">
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />

        <AppBar services={services} products={products} />

        <main className="grow w-full mt-[70px]">{children}</main>

        <Footer services={services} products={products} />
      </body>
    </html>
  );
}
