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

const filename = fileURLToPath(import.meta.url);
const dirname = path.dirname(filename);

export default buildConfig({
  admin: {
    user: Users.slug,
  },
  collections: [
    Users,
    Media,
    Services,
    Customers,
    Partnership,
    Career,
    Products,
    Faqs,
  ],
  editor: lexicalEditor(),
  secret: process.env.PAYLOAD_SECRET || "",
  db: postgresAdapter({
    pool: {
      connectionString: process.env.DATABASE_URI || "",
    },
  }),
  typescript: {
    outputFile: path.resolve(dirname, "payload-types.ts"),
  },
});
