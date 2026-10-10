@echo off
echo ===================================================
echo   KathiravanMart - Git Initialization & Push Helper
echo ===================================================
echo.

set /p GITHUB_REPO_URL="Enter your GitHub Repository URL (e.g., https://github.com/username/kathiravanmart.git): "

if "%GITHUB_REPO_URL%"=="" (
    echo Error: Repository URL cannot be empty.
    pause
    exit /b 1
)

echo.
echo [1/5] Initializing Git repository...
git init

echo.
echo [2/5] Staging files...
git add .

echo.
echo [3/5] Creating initial commit...
git commit -m "feat: complete KathiravanMart multi-seller e-commerce marketplace"

echo.
echo [4/5] Setting main branch and remote origin...
git branch -M main
git remote remove origin 2>nul
git remote add origin %GITHUB_REPO_URL%

echo.
echo [5/5] Pushing to GitHub...
git push -u origin main

echo.
echo ===================================================
echo   Push completed! Check your repository on GitHub.
echo ===================================================
pause
