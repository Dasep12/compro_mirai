#!/usr/bin/env bash
# ==============================================================================
# Script Otomatis Deployment Mirai Softnet Company Profile
# Jalankan script ini di server setelah clone repo atau saat ada update terbaru
# ==============================================================================

set -e

echo "[1/5] Mengambil pembaruan kode terbaru dari Git..."
git pull origin main

echo "[2/5] Memeriksa keberadaan file .env..."
if [ ! -f .env ]; then
  echo "ERROR: File .env tidak ditemukan di direktori proyek!"
  echo "Silakan salin .env.example atau buat file .env dengan variabel yang diperlukan."
  exit 1
fi
echo "File .env ditemukan."

echo "[3/5] Memulai proses build Docker image & menjalankan container..."
docker compose up -d --build --remove-orphans

echo "[4/5] Menunggu container siap melayani request (10 detik)..."
sleep 10

echo "[5/5] Status container saat ini:"
docker compose ps

echo ""
echo "DEPLOYMENT BERHASIL!"
echo "Aplikasi berjalan di port 3000 (atau sesuai konfigurasi PORT di .env)."
echo "Untuk melihat log aplikasi, jalankan: docker compose logs -f"
