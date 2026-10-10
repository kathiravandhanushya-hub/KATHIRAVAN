# KathiravanMart - GitHub Push Helper Script (PowerShell)
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "  KathiravanMart - GitHub Initialization & Push" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""

$repoUrl = Read-Host "Enter your GitHub Repository URL (e.g., https://github.com/username/kathiravanmart.git)"

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "Error: Repository URL cannot be empty." -ForegroundColor Red
    exit 1
}

Write-Host "`n[1/5] Initializing Git repository..." -ForegroundColor Yellow
git init

Write-Host "`n[2/5] Staging files..." -ForegroundColor Yellow
git add .

Write-Host "`n[3/5] Creating initial commit..." -ForegroundColor Yellow
git commit -m "feat: complete KathiravanMart multi-seller marketplace with servlets, JDBC, and AI chatbot"

Write-Host "`n[4/5] Setting main branch and remote origin..." -ForegroundColor Yellow
git branch -M main
git remote remove origin 2>$null
git remote add origin $repoUrl

Write-Host "`n[5/5] Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin main

Write-Host "`n===================================================" -ForegroundColor Green
Write-Host "  Successfully pushed to GitHub!" -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Green
