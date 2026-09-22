import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
import pg from "pg";
import fs from "fs";
import path from "path";

// 1. Baca konfigurasi dari .env
const envText = fs.readFileSync(".env", "utf-8");
const env = {};
for (const line of envText.split("\n")) {
  const m = line.match(/^\s*([\w]+)\s*=\s*(.*)?\s*$/);
  if (m) env[m[1]] = m[2].trim();
}

const bucket = env.SUPABASE_STORAGE_BUCKET || "media";
const projectId = env.SUPABASE_PROJECT_ID || "rrovzatthpkjuwwwqxat";
const endpoint =
  env.SUPABASE_S3_ENDPOINT ||
  `https://${projectId}.storage.supabase.co/storage/v1/s3`;
const region = env.SUPABASE_S3_REGION || "ap-southeast-1";
const accessKeyId = env.SUPABASE_S3_ACCESS_KEY_ID;
const secretAccessKey = env.SUPABASE_S3_SECRET_ACCESS_KEY;
const databaseUri = env.DATABASE_URI;

if (!accessKeyId || !secretAccessKey) {
  console.error("Missing S3 credentials in .env");
  process.exit(1);
}

const s3 = new S3Client({
  endpoint,
  region,
  credentials: {
    accessKeyId,
    secretAccessKey,
  },
  forcePathStyle: true,
});

const getMimeType = (filename) => {
  const ext = path.extname(filename).toLowerCase();
  switch (ext) {
    case ".png":
      return "image/png";
    case ".jpg":
    case ".jpeg":
      return "image/jpeg";
    case ".webp":
      return "image/webp";
    case ".svg":
      return "image/svg+xml";
    case ".gif":
      return "image/gif";
    case ".ico":
      return "image/x-icon";
    case ".pdf":
      return "application/pdf";
    default:
      return "application/octet-stream";
  }
};

async function main() {
  console.log("=== MEMULAI MIGRASI MEDIA KE SUPABASE STORAGE ===");
  console.log(`Target Bucket: ${bucket}`);
  console.log(`Endpoint: ${endpoint}`);

  // 2. Upload file lokal ke Supabase Storage
  const mediaDir = path.resolve("media");
  const files = fs.readdirSync(mediaDir);
  console.log(`\nDitemukan ${files.length} file di folder 'media/'. Mengunggah ke bucket...`);

  let uploadSuccess = 0;
  let uploadFailed = 0;

  for (let i = 0; i < files.length; i++) {
    const filename = files[i];
    const filePath = path.join(mediaDir, filename);
    const stat = fs.statSync(filePath);
    if (!stat.isFile()) continue;

    const fileBuffer = fs.readFileSync(filePath);
    const contentType = getMimeType(filename);

    try {
      await s3.send(
        new PutObjectCommand({
          Bucket: bucket,
          Key: filename,
          Body: fileBuffer,
          ContentType: contentType,
          CacheControl: "public, max-age=31536000, immutable",
        })
      );
      uploadSuccess++;
      process.stdout.write(`\r[${uploadSuccess + uploadFailed}/${files.length}] Berhasil mengunggah: ${filename}`);
    } catch (err) {
      uploadFailed++;
      console.error(`\nGagal mengunggah ${filename}:`, err.message);
    }
  }

  console.log(`\nSelesai Upload: ${uploadSuccess} berhasil, ${uploadFailed} gagal.`);

  // 3. Update Record URL di Database PostgreSQL
  console.log("\nMenghubungkan ke database PostgreSQL untuk update URL media...");
  const client = new pg.Client({
    connectionString: databaseUri,
    ssl: { rejectUnauthorized: false },
  });
  await client.connect();

  const baseUrl = `https://${projectId}.supabase.co/storage/v1/object/public/${bucket}`;
  console.log(`Base URL Supabase Storage: ${baseUrl}`);

  const res = await client.query("SELECT * FROM media;");
  console.log(`Ditemukan ${res.rows.length} record di tabel 'media'.`);

  let updatedCount = 0;

  for (const row of res.rows) {
    let newUrl = row.url;
    if (row.filename) {
      newUrl = `${baseUrl}/${row.filename}`;
    }

    let newThumbnailUrl = row.thumbnail_u_r_l;
    let newSizesThumbnailUrl = row.sizes_thumbnail_url;
    let newSizesCardUrl = row.sizes_card_url;
    let newSizesHeroUrl = row.sizes_hero_url;

    if (row.sizes_thumbnail_filename) {
      newSizesThumbnailUrl = `${baseUrl}/${row.sizes_thumbnail_filename}`;
      newThumbnailUrl = newSizesThumbnailUrl;
    } else if (newUrl) {
      newThumbnailUrl = newUrl;
    }

    if (row.sizes_card_filename) {
      newSizesCardUrl = `${baseUrl}/${row.sizes_card_filename}`;
    }

    if (row.sizes_hero_filename) {
      newSizesHeroUrl = `${baseUrl}/${row.sizes_hero_filename}`;
    }

    await client.query(
      `UPDATE media 
       SET url = $1, 
           thumbnail_u_r_l = $2, 
           sizes_thumbnail_url = $3, 
           sizes_card_url = $4, 
           sizes_hero_url = $5
       WHERE id = $6`,
      [
        newUrl,
        newThumbnailUrl,
        newSizesThumbnailUrl,
        newSizesCardUrl,
        newSizesHeroUrl,
        row.id,
      ]
    );
    updatedCount++;
  }

  console.log(`Berhasil mengupdate ${updatedCount} baris di tabel 'media'.`);
  await client.end();

  // 4. Verifikasi Akses Publik URL
  console.log("\nMemverifikasi akses publik URL Supabase Storage...");
  const testFiles = files.slice(0, 3);
  for (const testFile of testFiles) {
    const testUrl = `${baseUrl}/${testFile}`;
    try {
      const response = await fetch(testUrl, { method: "HEAD" });
      console.log(`- ${testFile}: HTTP ${response.status} ${response.statusText} (${testUrl})`);
    } catch (e) {
      console.error(`- ${testFile}: Error fetching:`, e.message);
    }
  }

  console.log("\n=== MIGRASI SELESAI DENGAN SUKSES ===");
}

main().catch((err) => {
  console.error("Migration fatal error:", err);
  process.exit(1);
});
