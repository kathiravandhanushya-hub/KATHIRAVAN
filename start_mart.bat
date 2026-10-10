@echo off
title KathiravanMart Local Server Launcher
echo ========================================================
echo   🛒 KathiravanMart - Multi-Seller Marketplace
echo   Anna University R2025 Semester 3 Capstone Project
echo ========================================================
echo.
echo Starting local web server on port 8080...
start "" powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0server.ps1"
timeout /t 2 /nobreak >nul
echo Opening KathiravanMart in default browser...
start http://localhost:8080/
echo.
echo ========================================================
echo   Live at: http://localhost:8080/
echo   Catalog: 525+ Products (Flipkart Bestsellers, Mobiles, Medicines, Industrial Tools)
echo ========================================================
pause
