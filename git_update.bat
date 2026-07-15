@echo off
SETLOCAL EnableDelayedExpansion
title Git Repository Updater - SW Gobinda Veg Hotel & Restaurant
color 0B

echo ===================================================
echo   Git Repository Updater
echo ===================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in PATH.
    echo Please install Git and try again.
    pause
    exit /b 1
)

echo Checking repository status...
git status
echo.
echo ===================================================
echo.

set /p PROCEED="Do you want to stage and commit these changes? (Y/N): "
if /I "%PROCEED%" neq "Y" (
    echo Update cancelled.
    pause
    exit /b 0
)

echo.
set /p COMMIT_MSG="Enter commit message (Leave empty for default: 'Update website'): "
if "%COMMIT_MSG%"=="" (
    set COMMIT_MSG=Update website
)

echo.
echo Staging files...
git add .
if %errorlevel% neq 0 (
    echo [ERROR] Failed to stage files.
    pause
    exit /b 1
)

echo.
echo Committing changes...
git commit -m "%COMMIT_MSG%"
if %errorlevel% neq 0 (
    echo [ERROR] Commit failed (maybe no changes to commit?).
    pause
    exit /b 1
)

echo.
echo Pushing to GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo [ERROR] Failed to push to GitHub.
    pause
    exit /b 1
)

echo.
echo ===================================================
echo   SUCCESS: Repository updated successfully!
echo ===================================================
echo.
pause
