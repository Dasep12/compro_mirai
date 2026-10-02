import pg from "pg";
import fs from "fs";
import path from "path";

if (fs.existsSync(".env")) {
  const env = fs.readFileSync(".env", "utf-8");
  for (const line of env.split("\n")) {
    const t = line.trim();
    if (t && !t.startsWith("#") && t.includes("=")) {
      const i = t.indexOf("=");
      if (!process.env[t.slice(0, i).trim()]) {
        process.env[t.slice(0, i).trim()] = t.slice(i + 1).trim();
      }
    }
  }
}

function escapeLiteral(val) {
  if (val === null || val === undefined) return "NULL";
  if (typeof val === "boolean") return val ? "TRUE" : "FALSE";
  if (typeof val === "number") return val.toString();
  if (val instanceof Date) return `'${val.toISOString()}'`;
  if (typeof val === "object") {
    return `'${JSON.stringify(val).replace(/'/g, "''")}'::jsonb`;
  }
  return `'${String(val).replace(/'/g, "''")}'`;
}

async function exportDatabase() {
  console.log("[1/4] Menghubungi Supabase PostgreSQL...");
  const client = new pg.Client({
    connectionString: process.env.DATABASE_URI,
    ssl: { rejectUnauthorized: false },
  });
  await client.connect();
  console.log("[2/4] Terhubung! Mengambil daftar tabel...");

  const tablesRes = await client.query(`
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
    ORDER BY table_name;
  `);

  const tables = tablesRes.rows.map((r) => r.table_name);
  console.log(`Ditemukan ${tables.length} tabel.`);

  let sqlStatements = [];
  sqlStatements.push("-- ============================================================================");
  sqlStatements.push(`-- DUMP SUPABASE DATABASE COMPRO MIRAI - ${new Date().toISOString()}`);
  sqlStatements.push("-- ============================================================================\n");
  sqlStatements.push("SET statement_timeout = 0;");
  sqlStatements.push("SET lock_timeout = 0;");
  sqlStatements.push("SET client_encoding = 'UTF8';");
  sqlStatements.push("SET standard_conforming_strings = on;");
  sqlStatements.push("SET check_function_bodies = false;");
  sqlStatements.push("SET xmloption = content;");
  sqlStatements.push("SET client_min_messages = warning;");
  sqlStatements.push("SET row_security = off;\n");

  console.log("[3/4] Mengambil data tiap tabel...");
  let totalRows = 0;

  // Urutan khusus: tabel master/relasi
  // Untuk menghindari foreign key violation, disable triggers/FK saat restore
  sqlStatements.push("SET session_replication_role = 'replica';\n");

  for (const table of tables) {
    const rowsRes = await client.query(`SELECT * FROM "${table}";`);
    const rows = rowsRes.rows;
    if (rows.length === 0) continue;

    totalRows += rows.length;
    console.log(`Export tabel '${table}': ${rows.length} baris`);

    const columns = Object.keys(rows[0]);
    const colsSql = columns.map((c) => `"${c}"`).join(", ");

    sqlStatements.push(`-- Data untuk tabel: "${table}" (${rows.length} rows)`);
    sqlStatements.push(`TRUNCATE TABLE "${table}" CASCADE;`);

    // Batch insert per 100 baris
    for (let i = 0; i < rows.length; i += 100) {
      const batch = rows.slice(i, i + 100);
      const valuesList = batch
        .map((row) => {
          const vals = columns.map((col) => escapeLiteral(row[col]));
          return `(${vals.join(", ")})`;
        })
        .join(",\n  ");

      sqlStatements.push(`INSERT INTO "${table}" (${colsSql}) VALUES\n  ${valuesList};`);
    }
    sqlStatements.push("");
  }

  // Update sequences
  sqlStatements.push("-- Sinkronisasi Sequence ID");
  for (const table of tables) {
    sqlStatements.push(`
      DO $$
      DECLARE
        max_id bigint;
        seq_name text;
      BEGIN
        IF EXISTS (
          SELECT 1 FROM information_schema.columns 
          WHERE table_name = '${table}' AND column_name = 'id' AND data_type IN ('integer', 'bigint')
        ) THEN
          SELECT pg_get_serial_sequence('"${table}"', 'id') INTO seq_name;
          IF seq_name IS NOT NULL THEN
            EXECUTE 'SELECT COALESCE(MAX(id), 0) + 1 FROM "${table}"' INTO max_id;
            EXECUTE 'ALTER SEQUENCE ' || seq_name || ' RESTART WITH ' || max_id;
          END IF;
        END IF;
      END $$;
    `);
  }

  sqlStatements.push("\nSET session_replication_role = 'DEFAULT';\n");

  const outFile = path.resolve(process.cwd(), "scripts", "supabase_data_backup.sql");
  fs.writeFileSync(outFile, sqlStatements.join("\n"), "utf-8");

  console.log(`[4/4] Selesai! Berhasil mengekspor ${totalRows} baris data ke '${outFile}'.`);
  await client.end();
}

exportDatabase().catch(console.error);
