#!/usr/bin/env bash
# ==============================================================================
# Script Migrasi Otomatis dari Supabase (PostgreSQL + S3 Storage) ke Server Sendiri
# Jalankan di VPS: bash scripts/pull_from_supabase.sh
# ==============================================================================
set -e

echo "=== [1/3] Menarik Seluruh Data & Skema PostgreSQL dari Supabase ==="
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

mkdir -p scripts/dumps
DUMP_FILE="scripts/dumps/supabase_full_dump.sql"

echo "Menjalankan pg_dump via Docker postgres:16-alpine..."
docker run --rm \
  -v "$(pwd)/scripts/dumps:/dumps" \
  postgres:16-alpine \
  pg_dump "$DATABASE_URI" \
  --clean --if-exists --no-owner --no-acl \
  -F p -f "/dumps/supabase_full_dump.sql"

echo "Dump PostgreSQL berhasil disimpan di $DUMP_FILE"

echo ""
echo "=== [2/3] Menarik Seluruh Aset Media dari Supabase S3 ==="
node scripts/pull-supabase-media.mjs

echo ""
echo "=== [3/3] Selesai! ==="
echo "Data PostgreSQL ada di: $DUMP_FILE"
echo "Seluruh file media ada di: $(pwd)/media"
echo ""
echo "Langkah berikutnya: jalankan 'docker compose up -d' dengan postgres lokal."
