#!/usr/bin/env bash
# ==============================================================================
# Script Restore Database Dump ke PostgreSQL Lokal di Container Docker
# Jalankan di VPS: bash scripts/restore_to_local_postgres.sh
# ==============================================================================
set -e

CONTAINER_NAME="miraisoftnet-db"
DB_NAME="miraisoftnet_compro"
DB_USER="postgres"

echo "=== Memeriksa status container PostgreSQL ($CONTAINER_NAME) ==="
if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
  echo "Error: Container $CONTAINER_NAME tidak berjalan. Pastikan sudah 'docker compose up -d postgres'."
  exit 1
fi

DUMP_FILE=""
if [ -f "scripts/dumps/supabase_full_dump.sql" ]; then
  DUMP_FILE="scripts/dumps/supabase_full_dump.sql"
elif [ -f "scripts/supabase_data_backup.sql" ]; then
  DUMP_FILE="scripts/supabase_data_backup.sql"
fi

if [ -z "$DUMP_FILE" ]; then
  echo "Error: File dump tidak ditemukan di scripts/dumps/supabase_full_dump.sql atau scripts/supabase_data_backup.sql"
  exit 1
fi

echo "=== [1/2] Me-restore $DUMP_FILE ke container $CONTAINER_NAME ($DB_NAME) ==="
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$DUMP_FILE"

echo "=== [2/2] Memperbarui URL Media dari Supabase ke Local Endpoint (/api/media/file) ==="
if [ -f "scripts/migrate-to-local.sql" ]; then
  docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "scripts/migrate-to-local.sql"
fi

echo "=== Restore & Migrasi Database Selesai! ==="
