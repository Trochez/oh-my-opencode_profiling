# Installation Guide

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Repository Setup](#repository-setup)
3. [Environment Configuration](#environment-configuration)
4. [Dependency Installation](#dependency-installation)
5. [Build Process](#build-process)
6. [First Run Verification](#first-run-verification)
7. [Environment Variables](#environment-variables)
8. [Troubleshooting](#troubleshooting)
9. [Uninstallation](#uninstallation)

## Prerequisites

### Operating System Requirements

- **Linux**: Any modern distribution (Ubuntu 20.04+, Fedora 35+, etc.)
- **macOS**: 10.15+ (Catalina or newer)
- **Windows**: Windows 10 (with WSL2) or Windows Server

### Development Tools

| Tool | Minimum Version | Installation Command |
| --- | --- | --- |
| **Node.js** | 18.x | `curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs` |
| **pnpm** | 8.x | `npm install -g pnpm` |
| **Docker** | 20.10+ | Follow Docker Desktop installation guide for your OS |
| **Git** | 2.30+ | `sudo apt-get install -y git` |

## Repository Setup

### 1. Clone the Repository

```bash
# Create a dedicated directory
mkdir -p ~/opencode-profile-tool && cd ~/opencode-profile-tool

# Clone the target repository
git clone git@github.com:Trochez/oh-my-opencode_profiling.git .
```

### 2. Verify Repository Structure

```bash
ls -la
# Should show:
# .sisyphus/
#   .sisyphus/plans/opencode-profile-tool.md
#   tasks/
#   workers/
# .omx/
#   state/
# README.md
# .env.example
```

## Environment Configuration

### 1. Create Configuration Files

```bash
# Copy example environment file
cp .env.example .env

# Generate a secure secret key (Linux/macOS)
openssl rand -hex 32 > .secret-key

# On Windows PowerShell
# $key = [System.Text.Encoding]::UTF8.GetString([System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes(32))
# $key | Out-File -FilePath .secret-key -Encoding ascii
```

### 2. Configure Environment Variables

Set the values in `.env` to match your local environment.

## Dependency Installation

```bash
pnpm install
```

## Build Process

```bash
pnpm run build
```

## First Run Verification

```bash
pnpm run dev
```

Then confirm the app starts without errors and the main pages render correctly.

## Environment Variables

Required variables typically include:

- `DATABASE_URL`
- `API_PORT`
- `AUTH_TOKEN_SECRET`
- `MAX_RETENTION_DAYS`

## Troubleshooting

- Reinstall dependencies if module resolution fails.
- Confirm Docker is running before starting local services.
- Verify `.env` values match your environment.
- Check logs for missing permissions or port conflicts.

## Uninstallation

Remove the local checkout and any generated environment files if you no longer need the tool.
