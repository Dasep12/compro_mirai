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
  ],
  globals: [AboutUs],
  editor: lexicalEditor(),
  secret: process.env.PAYLOAD_SECRET,
  db: postgresAdapter({
    pool: {
      connectionString: process.env.DATABASE_URI,
    },
  }),
  typescript: {
    outputFile: path.resolve(dirname, "payload-types.ts"),
  },
  sharp,
});
