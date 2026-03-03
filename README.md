# ⚡ AIExtenders Setup Assistant (Lite)

A lightweight installer that gets [OpenClaw](https://github.com/openclaw/openclaw) up and running on your machine in under 2 minutes.

> **Compatible with OpenClaw. Not affiliated with or endorsed by OpenClaw.**

![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Windows%20%7C%20Linux-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Version](https://img.shields.io/badge/version-1.0.0-purple)

---

## What It Does

- ✅ Checks your system (Node.js, Python, disk space, network)
- ✅ Installs OpenClaw from the official npm registry
- ✅ Creates a ready-to-use workspace
- ✅ Verifies the installation works

That's it. No magic, no lock-in. Just a clean setup.

## Quick Start

### macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/aiextenders/AIExtenders-Setup-Assistant/main/install.sh | bash
```

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/aiextenders/AIExtenders-Setup-Assistant/main/install.ps1 | iex
```

### Manual
```bash
git clone https://github.com/aiextenders/AIExtenders-Setup-Assistant.git
cd AIExtenders-Setup-Assistant
chmod +x install.sh
./install.sh
```

## What Gets Installed

| Component | Source | Version |
|-----------|--------|---------|
| OpenClaw | npm (official) | Latest stable |
| Workspace | Local directory | `~/.openclaw/workspace` |

**Nothing is bundled.** OpenClaw is downloaded directly from its official source during installation.

## System Requirements

- **OS:** macOS 12+, Windows 10+, or Linux (Ubuntu 20.04+)
- **Node.js:** v18+ (installer checks this)
- **Disk:** 500MB free minimum
- **Network:** Required during installation
- **API Key:** You'll need an Anthropic or OpenAI API key to use OpenClaw

## Lite vs Pro

This is the **free Lite version**. It installs OpenClaw and gets you running.

| Feature | Lite (Free) | Pro ($29) |
|---------|:-----------:|:---------:|
| Install OpenClaw | ✅ | ✅ |
| System compatibility check | ✅ | ✅ |
| Workspace creation | ✅ | ✅ |
| GUI installer (no terminal) | ❌ | ✅ |
| Auto API key configuration | ❌ | ✅ |
| Automation pack installation | ❌ | ✅ |
| Environment optimization | ❌ | ✅ |
| One-click updates | ❌ | ✅ |
| Priority support | ❌ | ✅ |

→ **[Upgrade to Pro](https://aiextenders.com/pricing.html)**

## How It Works

The installer is a straightforward shell script (or PowerShell on Windows). You can read every line before running it.

1. Checks for Node.js (installs via nvm if missing)
2. Runs `npm install -g openclaw`
3. Creates workspace at `~/.openclaw/workspace`
4. Copies a quickstart guide into your workspace
5. Runs `openclaw doctor` to verify everything works

No telemetry. No tracking. No accounts required.

## FAQ

**Is this official?**
No. AIExtenders is an independent project. We build tools that work with OpenClaw but are not affiliated with the OpenClaw team.

**Is it safe?**
The installer only runs `npm install` commands and creates local directories. Read the source — it's ~150 lines of bash.

**Do I need an API key?**
Not for installation, but you'll need one (Anthropic or OpenAI) to actually use OpenClaw after setup.

**What if I already have OpenClaw?**
The installer detects existing installations and skips redundant steps.

## Changelog

### v1.0.0 (March 2026)
- Initial release
- macOS, Windows, and Linux support
- System requirement checks
- Automatic Node.js detection
- Workspace creation with quickstart guide

## License

MIT — do whatever you want with the wrapper code. OpenClaw itself has its own license.

## Links

- 🌐 [AIExtenders.com](https://aiextenders.com) — Full automation packs & Pro installer
- 📦 [OpenClaw](https://github.com/openclaw/openclaw) — The AI agent runtime
- 💬 [OpenClaw Discord](https://discord.com/invite/clawd) — Community

---

<p align="center">
  <a href="https://aiextenders.com">
    <img src="https://img.shields.io/badge/⚡_Upgrade_to_Pro-FF4500?style=for-the-badge" alt="Upgrade to Pro">
  </a>
</p>
