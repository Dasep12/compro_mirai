#!/usr/bin/env bash
# ==============================================================================
# Script Restore Database Dump ke PostgreSQL Lokal di Container Docker
# Jalankan di VPS: bash scripts/restore_to_local_postgres.sh
# ==============================================================================
set -e

CONTAINER_NAME="miraisoftnet-db"

# Bersihkan carriage return (\r) dari .env agar aman di Linux
if [ -f .env ]; then
  eval $(grep -v '^[[:space:]]*#' .env | grep '=' | sed 's/\r$//' | sed 's/^/export /')
fi

DB_NAME=$(echo "${POSTGRES_DB:-miraisoftnet_compro}" | tr -d '\r')
DB_USER=$(echo "${POSTGRES_USER:-postgres}" | tr -d '\r')

echo "=== Memeriksa status container PostgreSQL ($CONTAINER_NAME) ==="
if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
  echo "Error: Container $CONTAINER_NAME tidak berjalan. Pastikan sudah docker compose up -d postgres."
  exit 1
fi

echo "=== Memastikan database '$DB_NAME' tersedia di container ==="
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d postgres -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
  docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d postgres -c "CREATE DATABASE \"$DB_NAME\";"

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

echo ""
echo "=== [2/2] Memeriksa total baris data yang berhasil di-restore ==="
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT count(*) AS total_media_items FROM \"media\";"
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT count(*) AS total_users FROM \"users\";"

echo ""
echo "=== Restore Database Selesai! ==="
