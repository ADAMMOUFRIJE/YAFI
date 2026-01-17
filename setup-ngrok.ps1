# Script PowerShell pour configurer Ngrok automatiquement
# Usage: .\setup-ngrok.ps1

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "   YAFI - Configuration Ngrok    " -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier que les services tournent
Write-Host "🔍 Vérification des services..." -ForegroundColor Yellow
Write-Host ""

$backendRunning = Get-Process python -ErrorAction SilentlyContinue | Where-Object {$_.CommandLine -like "*server.py*"}
$frontendRunning = Get-NetTCPConnection -LocalPort 5173 -ErrorAction SilentlyContinue

if (-not $backendRunning) {
    Write-Host "❌ Backend Python non détecté sur port 5000" -ForegroundColor Red
    Write-Host "   Lancez d'abord: python backend/server.py" -ForegroundColor Yellow
    Write-Host ""
}

if (-not $frontendRunning) {
    Write-Host "❌ Frontend Vite non détecté sur port 5173" -ForegroundColor Red
    Write-Host "   Lancez d'abord: npm run dev" -ForegroundColor Yellow
    Write-Host ""
}

if (-not $backendRunning -or -not $frontendRunning) {
    Write-Host "⚠️  Lancez d'abord les services puis relancez ce script." -ForegroundColor Yellow
    exit
}

Write-Host "✅ Backend Python: OK" -ForegroundColor Green
Write-Host "✅ Frontend Vite: OK" -ForegroundColor Green
Write-Host ""

# Instructions pour ngrok backend
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  ÉTAPE 1: Exposer le BACKEND" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ouvrez un NOUVEAU terminal et lancez:" -ForegroundColor Yellow
Write-Host "  ngrok http 5000" -ForegroundColor White
Write-Host ""
Write-Host "📋 Copiez l'URL générée (ex: https://abc-xyz.ngrok-free.app)" -ForegroundColor Green
Write-Host ""

$backendURL = Read-Host "Collez l'URL du BACKEND Ngrok ici"

if ($backendURL -notmatch "^https?://") {
    Write-Host "❌ URL invalide. Elle doit commencer par https://" -ForegroundColor Red
    exit
}

# Nettoyer l'URL (enlever trailing slash)
$backendURL = $backendURL.TrimEnd('/')

Write-Host ""
Write-Host "✅ URL Backend: $backendURL" -ForegroundColor Green
Write-Host ""

# Mettre à jour le .env
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  MISE À JOUR de .env" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

$envPath = ".\.env"
$envContent = Get-Content $envPath -Raw

# Remplacer l'URL du backend
$envContent = $envContent -replace "VITE_PYTHON_API_URL=.*", "VITE_PYTHON_API_URL=$backendURL"

Set-Content -Path $envPath -Value $envContent -NoNewline

Write-Host "✅ Fichier .env mis à jour !" -ForegroundColor Green
Write-Host ""

# Instructions pour redémarrer le frontend
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  ÉTAPE 2: REDÉMARRER le FRONTEND" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Dans le terminal où tourne 'npm run dev':" -ForegroundColor Yellow
Write-Host "  1. Appuyez sur Ctrl+C" -ForegroundColor White
Write-Host "  2. Relancez: npm run dev" -ForegroundColor White
Write-Host ""

Read-Host "Appuyez sur ENTRÉE quand c'est fait"

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  ÉTAPE 3: Exposer le FRONTEND" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ouvrez un AUTRE nouveau terminal et lancez:" -ForegroundColor Yellow
Write-Host "  ngrok http 5173" -ForegroundColor White
Write-Host ""
Write-Host "📋 Copiez l'URL générée (ex: https://def-uvw.ngrok-free.app)" -ForegroundColor Green
Write-Host ""

$frontendURL = Read-Host "Collez l'URL du FRONTEND Ngrok ici"

if ($frontendURL -notmatch "^https?://") {
    Write-Host "❌ URL invalide." -ForegroundColor Red
    exit
}

$frontendURL = $frontendURL.TrimEnd('/')

Write-Host ""
Write-Host "=====================================" -ForegroundColor Green
Write-Host "       ✅ CONFIGURATION TERMINÉE !" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green
Write-Host ""
Write-Host "🎉 PARTAGEZ CETTE URL avec vos amis:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  $frontendURL" -ForegroundColor White -BackgroundColor DarkGreen
Write-Host ""
Write-Host "=====================================" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Résumé:" -ForegroundColor Yellow
Write-Host "  • Backend: $backendURL" -ForegroundColor White
Write-Host "  • Frontend: $frontendURL (À PARTAGER)" -ForegroundColor White
Write-Host ""
Write-Host "✅ Tout est prêt ! Le site fonctionne pour tout le monde !" -ForegroundColor Green
Write-Host ""
