# ==============================================================================
# PowerShell Deployment Script untuk Windows Server
# ==============================================================================

$ErrorActionPreference = "Stop"

Write-Host "[1/5] Mengambil pembaruan kode terbaru dari Git..." -ForegroundColor Cyan
git pull origin main

Write-Host "[2/5] Memeriksa file .env..." -ForegroundColor Cyan
if (-not (Test-Path .env)) {
    Write-Host "ERROR: File .env tidak ditemukan!" -ForegroundColor Red
    exit 1
}
Write-Host "File .env ditemukan." -ForegroundColor Green

Write-Host "[3/5] Memulai proses build Docker & menjalankan container..." -ForegroundColor Cyan
docker compose up -d --build --remove-orphans

Write-Host "[4/5] Menunggu container siap..." -ForegroundColor Cyan
Start-Sleep -Seconds 10

Write-Host "[5/5] Status container saat ini:" -ForegroundColor Cyan
docker compose ps

Write-Host "`n DEPLOYMENT BERHASIL!" -ForegroundColor Green
Write-Host "Untuk melihat log aplikasi, jalankan: docker compose logs -f" -ForegroundColor Yellow
