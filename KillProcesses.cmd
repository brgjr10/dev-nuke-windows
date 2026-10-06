@echo off
setlocal

net session >nul 2>&1
if %errorlevel% neq 0 (
  echo Requesting administrator rights...
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)

echo Killing processes...


:: ===== SAFE: Dev tools only (run anytime) =====
taskkill /f /t /im python.exe        >nul 2>&1
taskkill /f /t /im pythonw.exe       >nul 2>&1
taskkill /f /t /im electron.exe       >nul 2>&1
taskkill /f /t /im python3.exe       >nul 2>&1
taskkill /f /t /im node.exe          >nul 2>&1
taskkill /f /t /im uv.exe            >nul 2>&1
taskkill /f /t /im bun.exe           >nul 2>&1
taskkill /f /t /im git.exe           >nul 2>&1
taskkill /f /t /im git-remote-http.exe  >nul 2>&1
taskkill /f /t /im git-remote-https.exe >nul 2>&1
taskkill /f /t /im git-lfs.exe       >nul 2>&1
taskkill /f /t /im vscodium.exe      >nul 2>&1
taskkill /f /t /im VSCodium.exe      >nul 2>&1
taskkill /f /t /im Code.exe          >nul 2>&1
taskkill /f /t /im tsserver.exe      >nul 2>&1
taskkill /f /t /im eslint.exe        >nul 2>&1
taskkill /f /t /im prettier.exe      >nul 2>&1
taskkill /f /t /im webpack.exe       >nul 2>&1
taskkill /f /t /im vite.exe          >nul 2>&1
taskkill /f /t /im esbuild.exe       >nul 2>&1
taskkill /f /t /im rust-analyzer.exe >nul 2>&1
taskkill /f /t /im gopls.exe         >nul 2>&1
taskkill /f /t /im pylsp.exe         >nul 2>&1
taskkill /f /t /im jedi-language-server.exe >nul 2>&1
taskkill /f /t /im npm.exe           >nul 2>&1
taskkill /f /t /im yarn.exe          >nul 2>&1
taskkill /f /t /im pnpm.exe          >nul 2>&1

:: ===== DEEP CLEAN: Run manually when needed =====
:: Docker (graceful)
docker stop (docker ps -q) >nul 2>&1
docker desktop stop >nul 2>&1
:: WSL
wsl --shutdown >nul 2>&1
:: Databases (graceful)
net stop postgresql-* >nul 2>&1
net stop mysql >nul 2>&1
redis-cli shutdown >nul 2>&1
mongod --shutdown >nul 2>&1

:: ===== TEMP/CACHE CLEANUP =====
del /q /f /s %TEMP%\* >nul 2>&1
del /q /f /s %TMP%\* >nul 2>&1
del /q /f /s %LOCALAPPDATA%\Temp\* >nul 2>&1
npm cache clean --force >nul 2>&1
yarn cache clean --force >nul 2>&1
pnpm store prune >nul 2>&1



echo Done.
timeout /t 3 >nul
exit /b 0
