import { buildConfig } from "payload";
import { lexicalEditor } from "@payloadcms/richtext-lexical";
import { postgresAdapter } from "@payloadcms/db-postgres";
import path from "path";
import { fileURLToPath } from "url";
import { Users } from "./src/collections/User.ts";
import { Media } from "./src/collections/Media.ts";
import { Services } from "./src/collections/Services.ts";
import { Customers } from "./src/collections/Customers.ts";
import { Partnership } from "./src/collections/Partnership.ts";
import { Career } from "./src/collections/Career.ts";
import { Products } from "./src/collections/Products.ts";
import { Faqs } from "./src/collections/Faqs.ts";
import { Portfolios } from "./src/collections/Portfolios.ts";
import { Visitors } from "./src/collections/Visitors.ts";
import { PricingFaq } from "./src/collections/PricingFaq.ts";
import { AboutUs } from "./src/collections/AboutUs.ts";
import { Problems } from "./src/collections/Problem.ts";
import sharp from "sharp";
import { News } from "@/collections/News.ts";
import { Solutions } from "./src/collections/Solutions.ts";
import { Industries } from "./src/collections/Industries.ts";
import { SolutionCategories } from "./src/collections/SolutionCategories.ts";
import { PartnershipSolutions } from "./src/collections/PartnershipSolutions.ts";
import { s3Storage } from "@payloadcms/storage-s3";
// import { CustomLogo } from "@/components/payloads/CustomLogo.tsx";

const filename = fileURLToPath(import.meta.url);
const dirname = path.dirname(filename);

if (!process.env.PAYLOAD_SECRET) {
  throw new Error(
    "[Payload] PAYLOAD_SECRET is not set! Set it in your .env file.",
  );
}
if (!process.env.DATABASE_URI) {
  throw new Error(
    "[Payload] DATABASE_URI is not set! Set it in your .env file.",
  );
}

export default buildConfig({
  admin: {
    user: Users.slug,
    components: {
      graphics: {
        // Logo: CustomLogo,
      },
    },
    meta: {
      titleSuffix: "- Mirai Softnet",
      icons: {
        icon: [{ url: "/favicon.ico?v=2", sizes: "any", type: "image/x-icon" }],
      },
    },
  },
  collections: [
    Users,
    Problems,
    Media,
    Services,
    Customers,
    Partnership,
    Career,
    Products,
    Faqs,
    Portfolios,
    Visitors,
    PricingFaq,
    News,
    Industries,
    SolutionCategories,
    PartnershipSolutions,
    Solutions,
  ],
  globals: [AboutUs],
  plugins: [
    s3Storage({
      collections: {
        media: {
          generateFileURL: ({ filename, prefix }) => {
            const base = `https://${process.env.SUPABASE_PROJECT_ID || "rrovzatthpkjuwwwqxat"}.supabase.co/storage/v1/object/public/${process.env.SUPABASE_STORAGE_BUCKET || "media"}`;
            return prefix ? `${base}/${prefix}/${filename}` : `${base}/${filename}`;
          },
        },
      },
      bucket: process.env.SUPABASE_STORAGE_BUCKET || "media",
      config: {
        credentials: {
          accessKeyId: process.env.SUPABASE_S3_ACCESS_KEY_ID || "",
          secretAccessKey: process.env.SUPABASE_S3_SECRET_ACCESS_KEY || "",
        },
        region: process.env.SUPABASE_S3_REGION || "ap-southeast-1",
        endpoint:
          process.env.SUPABASE_S3_ENDPOINT ||
          `https://${process.env.SUPABASE_PROJECT_ID || "rrovzatthpkjuwwwqxat"}.storage.supabase.co/storage/v1/s3`,
        forcePathStyle: true,
      },
    }),
  ],
  editor: lexicalEditor(),
  secret: process.env.PAYLOAD_SECRET,
  db: postgresAdapter({
    pool: {
      connectionString: process.env.DATABASE_URI,
    },
    push: true,
  }),
  typescript: {
    outputFile: path.resolve(dirname, "payload-types.ts"),
  },
  sharp,
});
