@echo off
cd /d "%~dp0"

echo Synchronizing with GitHub...

rem Generate URLs.csv for GitHub Pages
echo Filename;URL > URLs.csv

for %%F in (*.pdf) do (
    echo "%%F";"https://koolbear-oss.github.io/ATG/%%F">>URLs.csv
)

git add -A

git diff --cached --quiet
if %errorlevel%==0 (
    echo No changes detected.
    pause
    exit /b
)

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format ''yyyy-MM-dd HH:mm:ss''"') do set DTS=%%i

git commit -m "ATG sync %DTS%"
git push origin main

echo.
echo Sync completed.
pause