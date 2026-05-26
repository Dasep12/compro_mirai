import type { Metadata } from "next";
import { Plus_Jakarta_Sans } from "next/font/google";
import "./globals.css";
import { getPayload } from "payload";
import config from "../../../payload.config";
import AppBar from "@/components/ui/AppBar";
import Footer from "@/components/ui/Footer";

const jakarta = Plus_Jakarta_Sans({
  variable: "--font-jakarta",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  metadataBase: new URL("https://miraisoftnet.com"),

  title: {
    default: "Mirai Softnet & Technology",
    template: "%s | Mirai Softnet",
  },
  description:
    "Memberikan solusi teknologi terbaik untuk akselerasi bisnis Anda melalui layanan IT, pengembangan produk unggulan, dan peluang karir profesional.",

  openGraph: {
    type: "website",
    locale: "id_ID",
    url: "https://miraisoftnet.com",
    title: "Mirai Softnet & Technology",
    siteName: "Mirai Softnet",
    images: [
      {
        url: "/api/media/file/mirai-black.png",
        width: 1200,
        height: 630,
        alt: "Mirai Softnet Logo",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Mirai Softnet & Technology",
    images: ["/api/media/file/mirai-black.png"],
  },
  icons: {
    icon: [{ url: "/favicon.ico", sizes: "any", type: "image/x-icon" }],
  },
};

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const payload = await getPayload({ config });

  const services = await payload.find({
    collection: "services",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

  const products = await payload.find({
    collection: "products",
    depth: 1,
    limit: 10,
    sort: "createdAt",
  });

  return (
    <html lang="id" className={`${jakarta.variable} h-full antialiased`}>
      <body className="min-h-full flex flex-col font-sans">
        <AppBar services={services.docs} products={products.docs} />

        <main className="grow w-full mt-[70px]">{children}</main>

        <Footer services={services.docs} products={products.docs} />
      </body>
    </html>
  );
}
