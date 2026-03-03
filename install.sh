#!/usr/bin/env bash
# AIExtenders Setup Assistant (Lite)
# Installs OpenClaw from official sources. Not affiliated with OpenClaw.
# https://aiextenders.com

set -euo pipefail

BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
CYAN="\033[36m"
RESET="\033[0m"

WORKSPACE="$HOME/.openclaw/workspace"
MIN_NODE=18
MIN_DISK_MB=500

echo ""
echo -e "${CYAN}${BOLD}⚡ AIExtenders Setup Assistant (Lite)${RESET}"
echo -e "${CYAN}   Compatible with OpenClaw. Not affiliated.${RESET}"
echo ""

# ── System Checks ──────────────────────────────────────────

echo -e "${BOLD}Checking system requirements...${RESET}"
echo ""

# OS
OS=$(uname -s)
case "$OS" in
  Darwin) echo -e "  ✅ macOS detected" ;;
  Linux)  echo -e "  ✅ Linux detected" ;;
  *)      echo -e "  ${RED}❌ Unsupported OS: $OS${RESET}"; exit 1 ;;
esac

# Disk space
if command -v df &>/dev/null; then
  AVAIL_MB=$(df -m "$HOME" | tail -1 | awk '{print $4}')
  if [ "$AVAIL_MB" -lt "$MIN_DISK_MB" ]; then
    echo -e "  ${RED}❌ Not enough disk space (${AVAIL_MB}MB < ${MIN_DISK_MB}MB)${RESET}"
    exit 1
  fi
  echo -e "  ✅ Disk space: ${AVAIL_MB}MB available"
fi

# Network
if curl -sfI https://registry.npmjs.org &>/dev/null; then
  echo -e "  ✅ Network: npm registry reachable"
else
  echo -e "  ${RED}❌ Cannot reach npm registry. Check your internet connection.${RESET}"
  exit 1
fi

# Node.js
if command -v node &>/dev/null; then
  NODE_VER=$(node -v | sed 's/v//' | cut -d. -f1)
  if [ "$NODE_VER" -ge "$MIN_NODE" ]; then
    echo -e "  ✅ Node.js: $(node -v)"
  else
    echo -e "  ${YELLOW}⚠️  Node.js $(node -v) found but v${MIN_NODE}+ required${RESET}"
    echo -e "  ${YELLOW}   Install latest: https://nodejs.org${RESET}"
    exit 1
  fi
else
  echo -e "  ${RED}❌ Node.js not found${RESET}"
  echo ""
  echo -e "  Install Node.js first: ${BOLD}https://nodejs.org${RESET}"
  echo -e "  Or via nvm: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
  exit 1
fi

echo ""

# ── Install OpenClaw ───────────────────────────────────────

if command -v openclaw &>/dev/null; then
  CURRENT=$(openclaw --version 2>/dev/null || echo "unknown")
  echo -e "${GREEN}✅ OpenClaw already installed (${CURRENT})${RESET}"
  echo -e "   Checking for updates..."
  npm update -g openclaw 2>/dev/null || true
else
  echo -e "${BOLD}Installing OpenClaw...${RESET}"
  npm install -g openclaw
  echo -e "${GREEN}✅ OpenClaw installed successfully${RESET}"
fi

echo ""

# ── Create Workspace ───────────────────────────────────────

if [ -d "$WORKSPACE" ]; then
  echo -e "${GREEN}✅ Workspace exists: ${WORKSPACE}${RESET}"
else
  echo -e "Creating workspace at ${WORKSPACE}..."
  mkdir -p "$WORKSPACE"
  echo -e "${GREEN}✅ Workspace created${RESET}"
fi

# Copy quickstart if it exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/QUICKSTART.md" ]; then
  cp "$SCRIPT_DIR/QUICKSTART.md" "$WORKSPACE/" 2>/dev/null || true
  echo -e "  📄 Quickstart guide copied to workspace"
fi

echo ""

# ── Verify ─────────────────────────────────────────────────

echo -e "${BOLD}Verifying installation...${RESET}"
if command -v openclaw &>/dev/null; then
  echo -e "${GREEN}${BOLD}✅ OpenClaw is ready!${RESET}"
  echo ""
  openclaw --version 2>/dev/null || true
else
  echo -e "${RED}❌ Something went wrong. OpenClaw not found in PATH.${RESET}"
  echo "  Try: source ~/.bashrc (or ~/.zshrc) and run this script again."
  exit 1
fi

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${BOLD}What's next:${RESET}"
echo -e "  1. Add your API key:  ${BOLD}openclaw config${RESET}"
echo -e "  2. Start the gateway: ${BOLD}openclaw gateway start${RESET}"
echo -e "  3. Open the chat:     ${BOLD}openclaw${RESET}"
echo ""
echo -e "  ${YELLOW}Want auto-configuration + automation packs?${RESET}"
echo -e "  → ${BOLD}https://aiextenders.com/pricing.html${RESET}"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
