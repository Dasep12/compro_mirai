import pg from "pg";
import fs from "fs";

const SUPABASE_URI = "postgresql://postgres.rrovzatthpkjuwwwqxat:miraisoftnet12345!@aws-1-ap-southeast-1.pooler.supabase.com:6543/postgres?pgbouncer=true";

async function main() {
  const client = new pg.Client({
    connectionString: SUPABASE_URI,
    ssl: { rejectUnauthorized: false },
  });

  await client.connect();
  console.log("Connected to Supabase!");

  let ddl = [];
  ddl.push("-- ============================================================================");
  ddl.push("-- 1. EXTENSIONS & ENUM TYPES");
  ddl.push("-- ============================================================================");
  ddl.push('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";');
  ddl.push('CREATE EXTENSION IF NOT EXISTS "pgcrypto";\n');

  // Fetch ENUM types
  const enumRes = await client.query(`
    SELECT t.typname AS enum_name, array_agg(e.enumlabel ORDER BY e.enumsortorder) AS enum_values
    FROM pg_type t
    JOIN pg_enum e ON t.oid = e.enumtypid
    JOIN pg_namespace n ON n.oid = t.typnamespace
    WHERE n.nspname = 'public'
    GROUP BY t.typname;
  `);

  for (const row of enumRes.rows) {
    const raw = Array.isArray(row.enum_values) 
      ? row.enum_values 
      : String(row.enum_values).replace(/^\{|\}$/g, "").split(",");
    const vals = raw.map(v => `'${v.trim().replace(/^"|"$/g, "").replace(/'/g, "''")}'`).join(", ");
    ddl.push(`DO $$ BEGIN\n  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = '${row.enum_name}') THEN\n    CREATE TYPE "${row.enum_name}" AS ENUM (${vals});\n  END IF;\nEND $$;\n`);
  }

  // Fetch Sequences
  const seqRes = await client.query(`
    SELECT sequence_name 
    FROM information_schema.sequences 
    WHERE sequence_schema = 'public' 
    ORDER BY sequence_name;
  `);
  ddl.push("\n-- ============================================================================");
  ddl.push("-- 2. SEQUENCES");
  ddl.push("-- ============================================================================");
  for (const row of seqRes.rows) {
    ddl.push(`CREATE SEQUENCE IF NOT EXISTS "${row.sequence_name}";`);
  }

  // Fetch all tables
  const tablesRes = await client.query(`
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
    ORDER BY table_name;
  `);
  const tables = tablesRes.rows.map(r => r.table_name);
  console.log(`Found ${tables.length} tables to generate DDL for.`);

  ddl.push("\n-- ============================================================================");
  ddl.push("-- 3. TABLE DEFINITIONS (DDL)");
  ddl.push("-- ============================================================================");

  for (const table of tables) {
    const colRes = await client.query(`
      SELECT 
        c.column_name,
        c.data_type,
        c.udt_name,
        c.is_nullable,
        c.column_default,
        c.character_maximum_length,
        c.numeric_precision,
        c.numeric_scale
      FROM information_schema.columns c
      WHERE c.table_schema = 'public' AND c.table_name = $1
      ORDER BY c.ordinal_position;
    `, [table]);

    const pkRes = await client.query(`
      SELECT kcu.column_name
      FROM information_schema.table_constraints tc
      JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name
        AND tc.table_schema = kcu.table_schema
      WHERE tc.table_schema = 'public' 
        AND tc.table_name = $1 
        AND tc.constraint_type = 'PRIMARY KEY'
      ORDER BY kcu.ordinal_position;
    `, [table]);

    const pks = pkRes.rows.map(r => `"${r.column_name}"`);

    let colDefs = [];
    for (const col of colRes.rows) {
      let typeStr = "";
      if (col.data_type === "USER-DEFINED") {
        typeStr = `"${col.udt_name}"`;
      } else if (col.data_type === "ARRAY") {
        typeStr = `${col.udt_name.replace(/^_/, "")}[]`;
      } else if (col.data_type === "character varying") {
        typeStr = col.character_maximum_length ? `varchar(${col.character_maximum_length})` : "varchar";
      } else if (col.data_type === "timestamp with time zone") {
        typeStr = "timestamp with time zone";
      } else if (col.data_type === "timestamp without time zone") {
        typeStr = "timestamp";
      } else {
        typeStr = col.data_type;
      }

      let defStr = `  "${col.column_name}" ${typeStr}`;
      if (col.column_default !== null) {
        defStr += ` DEFAULT ${col.column_default}`;
      }
      if (col.is_nullable === "NO") {
        defStr += " NOT NULL";
      }
      colDefs.push(defStr);
    }

    if (pks.length > 0) {
      colDefs.push(`  CONSTRAINT "${table}_pkey" PRIMARY KEY (${pks.join(", ")})`);
    }

    ddl.push(`CREATE TABLE IF NOT EXISTS "${table}" (\n${colDefs.join(",\n")}\n);`);
  }

  // Fetch indexes
  let indexDefs = [];
  indexDefs.push("\n-- ============================================================================");
  indexDefs.push("-- 5. INDEXES");
  indexDefs.push("-- ============================================================================");
  const idxRes = await client.query(`
    SELECT indexdef 
    FROM pg_indexes 
    WHERE schemaname = 'public' 
      AND indexname NOT LIKE '%_pkey'
    ORDER BY tablename, indexname;
  `);

  for (const idx of idxRes.rows) {
    let stmt = idx.indexdef;
    if (!stmt.includes("IF NOT EXISTS")) {
      stmt = stmt.replace("CREATE INDEX ", "CREATE INDEX IF NOT EXISTS ")
                 .replace("CREATE UNIQUE INDEX ", "CREATE UNIQUE INDEX IF NOT EXISTS ");
    }
    indexDefs.push(`${stmt};`);
  }

  await client.end();

  // Now, merge with existing data in scripts/supabase_data_backup.sql
  console.log("Reading existing supabase_data_backup.sql...");
  let existingContent = fs.readFileSync("scripts/supabase_data_backup.sql", "utf-8");

  // Fix session_replication_role error if present
  existingContent = existingContent.replace("SET session_replication_role = 'DEFAULT';", "SET session_replication_role = 'origin';");

  // Split existingContent at `SET session_replication_role = 'replica';`
  const marker = "SET session_replication_role = 'replica';";
  const markerIdx = existingContent.indexOf(marker);

  if (markerIdx === -1) {
    throw new Error("Could not find session_replication_role marker in existing backup file!");
  }

  const header = existingContent.slice(0, markerIdx + marker.length);
  const dataBody = existingContent.slice(markerIdx + marker.length);

  const fullDump = [
    header,
    "\n\n",
    ddl.join("\n\n"),
    "\n\n-- ============================================================================",
    "-- 4. DATA (INSERT INTO)",
    "-- ============================================================================\n",
    dataBody.trim(),
    "\n\n",
    indexDefs.join("\n\n"),
    "\n\nSET session_replication_role = 'origin';\n"
  ].join("");

  fs.writeFileSync("scripts/supabase_data_backup.sql", fullDump, "utf-8");
  console.log("scripts/supabase_data_backup.sql successfully updated with complete Schema (DDL) + Data + Indexes!");
}

main().catch(err => {
  console.error(err);
  process.exit(1);
});
