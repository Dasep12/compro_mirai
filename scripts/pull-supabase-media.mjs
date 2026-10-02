import { S3Client, ListObjectsV2Command, GetObjectCommand } from "@aws-sdk/client-s3";
import fs from "fs";
import path from "path";
import { pipeline } from "stream/promises";

// Simple .env parser
if (fs.existsSync(".env")) {
  const envContent = fs.readFileSync(".env", "utf-8");
  for (const line of envContent.split("\n")) {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith("#") && trimmed.includes("=")) {
      const idx = trimmed.indexOf("=");
      const key = trimmed.slice(0, idx).trim();
      const val = trimmed.slice(idx + 1).trim();
      if (!process.env[key]) {
        process.env[key] = val;
      }
    }
  }
}

const s3 = new S3Client({
  credentials: {
    accessKeyId: process.env.SUPABASE_S3_ACCESS_KEY_ID || "",
    secretAccessKey: process.env.SUPABASE_S3_SECRET_ACCESS_KEY || "",
  },
  region: process.env.SUPABASE_S3_REGION || "ap-southeast-1",
  endpoint: process.env.SUPABASE_S3_ENDPOINT,
  forcePathStyle: true,
});

const BUCKET = process.env.SUPABASE_STORAGE_BUCKET || "media";
const OUTPUT_DIR = path.resolve(process.cwd(), "media");

if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

async function getAllKeys() {
  let keys = [];
  let continuationToken = undefined;

  do {
    const command = new ListObjectsV2Command({
      Bucket: BUCKET,
      ContinuationToken: continuationToken,
    });
    const res = await s3.send(command);
    if (res.Contents) {
      for (const obj of res.Contents) {
        if (obj.Key) keys.push({ key: obj.Key, size: obj.Size || 0 });
      }
    }
    continuationToken = res.NextContinuationToken;
  } while (continuationToken);

  return keys;
}

async function downloadFile(key) {
  const targetPath = path.join(OUTPUT_DIR, key);
  const targetDir = path.dirname(targetPath);
  if (!fs.existsSync(targetDir)) {
    fs.mkdirSync(targetDir, { recursive: true });
  }

  // Skip if already exists and has same size
  if (fs.existsSync(targetPath)) {
    const stat = fs.statSync(targetPath);
    if (stat.size > 0) {
      return { key, status: "skipped" };
    }
  }

  const getCmd = new GetObjectCommand({
    Bucket: BUCKET,
    Key: key,
  });

  const res = await s3.send(getCmd);
  const writeStream = fs.createWriteStream(targetPath);
  await pipeline(res.Body, writeStream);
  return { key, status: "downloaded" };
}

async function run() {
  console.log(`[1/3] Menghubungi Supabase S3 (${process.env.SUPABASE_S3_ENDPOINT})...`);
  const items = await getAllKeys();
  console.log(`[2/3] Ditemukan ${items.length} file di bucket '${BUCKET}'. Memulai download ke '${OUTPUT_DIR}'...`);

  const CONCURRENCY = 10;
  let completed = 0;
  let downloadedCount = 0;
  let skippedCount = 0;

  for (let i = 0; i < items.length; i += CONCURRENCY) {
    const chunk = items.slice(i, i + CONCURRENCY);
    await Promise.all(
      chunk.map(async ({ key }) => {
        try {
          const res = await downloadFile(key);
          if (res.status === "downloaded") downloadedCount++;
          else skippedCount++;
        } catch (err) {
          console.error(`Gagal download ${key}:`, err.message);
        } finally {
          completed++;
          if (completed % 25 === 0 || completed === items.length) {
            const pct = ((completed / items.length) * 100).toFixed(1);
            console.log(`Progress: ${completed}/${items.length} (${pct}%) [Downloaded: ${downloadedCount}, Skipped: ${skippedCount}]`);
          }
        }
      })
    );
  }

  console.log(`[3/3] Selesai! Total ${items.length} file berhasil disimpan di folder '${OUTPUT_DIR}'.`);
}

run().catch(console.error);
