import {
  S3Client,
  PutObjectCommand,
  ListObjectsV2Command,
} from "@aws-sdk/client-s3";
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

async function getAllBucketKeys() {
  const keys = new Set();
  let continuationToken = undefined;

  do {
    const res = await s3.send(
      new ListObjectsV2Command({
        Bucket: bucket,
        ContinuationToken: continuationToken,
      })
    );

    if (res.Contents) {
      for (const item of res.Contents) {
        if (item.Key) keys.add(item.Key);
      }
    }
    continuationToken = res.NextContinuationToken;
  } while (continuationToken);

  return keys;
}

async function main() {
  console.log("=== SINKRONISASI MEDIA KE SUPABASE STORAGE ===");
  console.log(`Target Bucket: ${bucket}`);
  console.log(`Endpoint: ${endpoint}\n`);

  // 2. Ambil daftar file yang sudah ada di bucket
  console.log("Memeriksa file yang sudah ada di bucket Supabase...");
  const existingKeys = await getAllBucketKeys();
  console.log(`Ditemukan ${existingKeys.size} file yang sudah ada di bucket.`);

  // 3. Baca folder media lokal
  const mediaDir = path.resolve("media");
  const localFiles = fs
    .readdirSync(mediaDir)
    .filter((f) => f !== ".gitkeep" && fs.statSync(path.join(mediaDir, f)).isFile());

  console.log(`Ditemukan ${localFiles.length} file di folder 'media/'.`);

  // Cadangkan file ke backup scratch jika belum ada
  const backupDir =
    "C:\\Users\\muham\\.gemini\\antigravity-ide\\brain\\cd1a3e64-2fd1-4494-9bc8-f7884440522b\\scratch\\media_backup";
  if (!fs.existsSync(backupDir)) {
    fs.mkdirSync(backupDir, { recursive: true });
  }

  let uploadCount = 0;
  let skippedCount = 0;
  let failedCount = 0;

  for (let i = 0; i < localFiles.length; i++) {
    const filename = localFiles[i];
    const filePath = path.join(mediaDir, filename);

    // Salin ke backup scratch
    const backupPath = path.join(backupDir, filename);
    if (!fs.existsSync(backupPath)) {
      fs.copyFileSync(filePath, backupPath);
    }

    // Jika sudah ada di bucket -> SKIP
    if (existingKeys.has(filename)) {
      skippedCount++;
      continue;
    }

    // Upload file baru
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
      uploadCount++;
      existingKeys.add(filename);
      console.log(`[UPLOAD ${uploadCount}] Berhasil: ${filename}`);
    } catch (err) {
      failedCount++;
      console.error(`[ERROR] Gagal mengunggah ${filename}:`, err.message);
    }
  }

  console.log("\n--- RINGKASAN UPLOAD ---");
  console.log(`Total file lokal : ${localFiles.length}`);
  console.log(`Dilewati (sudah ada): ${skippedCount}`);
  console.log(`Berhasil diunggah : ${uploadCount}`);
  console.log(`Gagal diunggah   : ${failedCount}`);

  // 4. Update Database PostgreSQL
  console.log("\nMenghubungkan ke database PostgreSQL untuk menyelaraskan URL...");
  const client = new pg.Client({
    connectionString: databaseUri,
    ssl: { rejectUnauthorized: false },
  });
  await client.connect();

  const baseUrl = `https://${projectId}.supabase.co/storage/v1/object/public/${bucket}`;
  const res = await client.query("SELECT * FROM media;");

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

  console.log(`Berhasil menyelaraskan ${updatedCount} baris di tabel 'media'.`);
  await client.end();

  // 5. Bersihkan folder media lokal agar repo tetap bersih (sisakan .gitkeep)
  console.log("\nMembersihkan file lokal di folder 'media/' (file aman di Supabase & backup)...");
  for (const file of localFiles) {
    try {
      fs.unlinkSync(path.join(mediaDir, file));
    } catch {
      // ignore
    }
  }
  console.log("Folder 'media/' telah dibersihkan kembali.");

  console.log("\n=== SINKRONISASI SELESAI DENGAN SUKSES ===");
}

main().catch((err) => {
  console.error("Sync fatal error:", err);
  process.exit(1);
});
