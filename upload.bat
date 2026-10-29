@echo off
cd /d "%~dp0"

echo Synchronizing with GitHub...

git add -A

git diff --cached --quiet
if %errorlevel%==0 (
    echo No changes detected.
    pause
    exit /b
)

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format \"yyyy-MM-dd HH:mm:ss\""') do set DTS=%%i

git commit -m "ATG sync %DTS%"
git push origin main

echo.
echo Sync completed.
pause