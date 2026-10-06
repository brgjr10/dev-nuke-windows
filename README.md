# dev-nuke-windows

A nuclear option for clearing developer bloat on Windows. Kills hung dev processes, cleans temp folders, and clears package caches in one shot.

## What It Kills (Safe List)

| Category | Processes |
|----------|-----------|
| Python | `python.exe`, `pythonw.exe`, `python3.exe` |
| Node.js | `node.exe`, `npm.exe`, `npx.exe`, `yarn.exe`, `pnpm.exe`, `bun.exe`, `uv.exe` |
| Electron Apps | `electron.exe` |
| Git | `git.exe`, `git-remote-http.exe`, `git-remote-https.exe`, `git-lfs.exe` |
| Editors | `Code.exe` (VS Code), `VSCodium.exe`, `vscodium.exe` |
| Language Servers | `tsserver.exe`, `eslint.exe`, `prettier.exe`, `rust-analyzer.exe`, `gopls.exe`, `pylsp.exe`, `jedi-language-server.exe` |
| Build Tools | `webpack.exe`, `vite.exe`, `esbuild.exe` |

> **Note:** These are safe to kill anytime — they're ephemeral dev tools that restart automatically.

## What It Cleans

- `%TEMP%`, `%TMP%`, `%LOCALAPPDATA%\Temp` — Windows temp folders
- `npm cache`, `yarn cache`, `pnpm store` — Package manager caches

## Usage

### Quick Clean (Recommended)
```cmd
KillProcesses.cmd
```
Run as Administrator (auto-elevates). Takes ~3 seconds.

### Deep Clean (Manual)
For Docker, WSL, and databases, use graceful shutdown instead:
```powershell
# Docker
docker stop (docker ps -q)
docker desktop stop

# WSL
wsl --shutdown

# Databases (if running as services)
net stop postgresql-*
net stop mysql
redis-cli shutdown
mongod --shutdown
```

## Safety

- **No system processes** — Only targets known dev tools
- **Idempotent** — Safe to run repeatedly; skips missing processes silently
- **Admin required** — Auto-elevates via UAC prompt
- **No telemetry** — Runs locally, no network calls

## Customization

Edit `KillProcesses.cmd` to add/remove processes for your stack:
```cmd
:: Add your own
taskkill /f /t /im your-tool.exe >nul 2>&1
```

## Why Not Kill Everything?

Aggressively killing Docker, WSL, or databases causes:
- Container filesystem corruption
- WSL2 disk image corruption  
- Database WAL corruption / data loss

Use the graceful commands above instead.

---

**One-liner for the brave:**
```powershell
irm https://raw.githubusercontent.com/brgjr10/dev-nuke-windows/main/KillProcesses.cmd | iex
```
(Review the script first — never pipe untrusted code to `iex`.)