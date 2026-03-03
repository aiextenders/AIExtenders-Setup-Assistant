# AIExtenders Setup Assistant (Lite) — Windows
# Installs OpenClaw from official sources. Not affiliated with OpenClaw.
# https://aiextenders.com

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "⚡ AIExtenders Setup Assistant (Lite)" -ForegroundColor Cyan
Write-Host "   Compatible with OpenClaw. Not affiliated." -ForegroundColor DarkCyan
Write-Host ""

# ── System Checks ──────────────────────────────────────────

Write-Host "Checking system requirements..." -ForegroundColor White
Write-Host ""

# OS
$osInfo = [System.Environment]::OSVersion
if ($osInfo.Platform -ne "Win32NT") {
    Write-Host "  ❌ This script is for Windows. Use install.sh for macOS/Linux." -ForegroundColor Red
    exit 1
}
$winVer = [System.Environment]::OSVersion.Version.Major
if ($winVer -ge 10) {
    Write-Host "  ✅ Windows $winVer detected" -ForegroundColor Green
} else {
    Write-Host "  ❌ Windows 10+ required (found Windows $winVer)" -ForegroundColor Red
    exit 1
}

# Disk space
$drive = (Get-PSDrive C)
$freeGB = [math]::Round($drive.Free / 1GB, 1)
if ($freeGB -lt 0.5) {
    Write-Host "  ❌ Not enough disk space (${freeGB}GB free, need 0.5GB)" -ForegroundColor Red
    exit 1
}
Write-Host "  ✅ Disk space: ${freeGB}GB available" -ForegroundColor Green

# Network
try {
    $null = Invoke-WebRequest -Uri "https://registry.npmjs.org" -Method Head -TimeoutSec 5 -UseBasicParsing
    Write-Host "  ✅ Network: npm registry reachable" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Cannot reach npm registry. Check your internet connection." -ForegroundColor Red
    exit 1
}

# Node.js
$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if ($nodeCmd) {
    $nodeVer = (node -v) -replace 'v', ''
    $nodeMajor = [int]($nodeVer.Split('.')[0])
    if ($nodeMajor -ge 18) {
        Write-Host "  ✅ Node.js: v$nodeVer" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  Node.js v$nodeVer found but v18+ required" -ForegroundColor Yellow
        Write-Host "     Download: https://nodejs.org" -ForegroundColor Yellow
        exit 1
    }
} else {
    Write-Host "  ❌ Node.js not found" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Install Node.js first: https://nodejs.org" -ForegroundColor White
    exit 1
}

Write-Host ""

# ── Install OpenClaw ───────────────────────────────────────

$openclawCmd = Get-Command openclaw -ErrorAction SilentlyContinue
if ($openclawCmd) {
    Write-Host "✅ OpenClaw already installed" -ForegroundColor Green
    Write-Host "   Checking for updates..." -ForegroundColor Gray
    npm update -g openclaw 2>$null
} else {
    Write-Host "Installing OpenClaw..." -ForegroundColor White
    npm install -g openclaw
    Write-Host "✅ OpenClaw installed successfully" -ForegroundColor Green
}

Write-Host ""

# ── Create Workspace ───────────────────────────────────────

$workspace = "$env:USERPROFILE\.openclaw\workspace"
if (Test-Path $workspace) {
    Write-Host "✅ Workspace exists: $workspace" -ForegroundColor Green
} else {
    Write-Host "Creating workspace..." -ForegroundColor White
    New-Item -ItemType Directory -Path $workspace -Force | Out-Null
    Write-Host "✅ Workspace created: $workspace" -ForegroundColor Green
}

# Copy quickstart
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$qs = Join-Path $scriptDir "QUICKSTART.md"
if (Test-Path $qs) {
    Copy-Item $qs $workspace -Force
    Write-Host "  📄 Quickstart guide copied to workspace" -ForegroundColor Gray
}

Write-Host ""

# ── Verify ─────────────────────────────────────────────────

Write-Host "Verifying installation..." -ForegroundColor White
$verify = Get-Command openclaw -ErrorAction SilentlyContinue
if ($verify) {
    Write-Host "✅ OpenClaw is ready!" -ForegroundColor Green
    Write-Host ""
    openclaw --version 2>$null
} else {
    Write-Host "❌ Something went wrong. Restart your terminal and try again." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host ""
Write-Host "  What's next:" -ForegroundColor White
Write-Host "  1. Add your API key:  openclaw config" -ForegroundColor Gray
Write-Host "  2. Start the gateway: openclaw gateway start" -ForegroundColor Gray
Write-Host "  3. Open the chat:     openclaw" -ForegroundColor Gray
Write-Host ""
Write-Host "  Want auto-configuration + automation packs?" -ForegroundColor Yellow
Write-Host "  → https://aiextenders.com/pricing.html" -ForegroundColor White
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host ""
