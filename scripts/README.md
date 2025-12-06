# Scripts Directory

This directory contains all utility scripts for the MCP Figma server project.

## Directory Structure

```
scripts/
├── setup/          # Installation and setup scripts
├── server/         # WebSocket server scripts
└── utils/          # Utility and helper scripts
```

## Setup Scripts

### `setup/setup.ps1` (Windows)
Installs Bun (if needed) and all project dependencies.

**Usage:**
```powershell
.\scripts\setup\setup.ps1
```

**What it does:**
- Checks for Bun installation
- Installs Bun if missing
- Installs project dependencies
- Provides next steps

### `setup/setup.sh` (Linux/Mac)
Same functionality as PowerShell version for Unix systems.

**Usage:**
```bash
chmod +x scripts/setup/setup.sh
./scripts/setup/setup.sh
```

## Server Scripts

### `server/start-websocket.ps1` (Windows)
Starts the WebSocket server on port 3055.

**Usage:**
```powershell
.\scripts\server\start-websocket.ps1
```

**What it does:**
- Checks for Bun
- Verifies dependencies
- Starts WebSocket server
- Keeps terminal open (required)

**Important:** Keep this terminal window open while using Figma MCP!

### `server/start-websocket.sh` (Linux/Mac)
Same functionality as PowerShell version.

**Usage:**
```bash
chmod +x scripts/server/start-websocket.sh
./scripts/server/start-websocket.sh
```

## Utility Scripts

### `utils/check-status.ps1`
Checks the status of all components.

**Usage:**
```powershell
.\scripts\utils\check-status.ps1
```

**What it checks:**
- Bun runtime installation
- Dependencies installation
- Build status
- MCP configuration
- WebSocket server status

### `utils/create-mcp-config.ps1`
Creates the MCP configuration file.

**Usage:**
```powershell
.\scripts\utils\create-mcp-config.ps1
```

**What it does:**
- Creates `.cursor` directory if needed
- Generates `.cursor/mcp.json` with local configuration
- Provides next steps

## Script Requirements

All scripts require:
- **Bun runtime** (installed automatically by setup scripts)
- **PowerShell 5.1+** (for .ps1 scripts)
- **Bash** (for .sh scripts)

## Troubleshooting

### Scripts Not Executing

**Windows:**
- Ensure execution policy allows scripts:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

**Linux/Mac:**
- Make scripts executable:
  ```bash
  chmod +x scripts/**/*.sh
  ```

### Path Issues

Scripts use relative paths. Run from project root:
```powershell
# Correct
.\scripts\setup\setup.ps1

# Incorrect (from scripts directory)
.\setup\setup.ps1
```

## Additional Resources

- **Installation:** [Installation Guide](../docs/getting-started/installation.md)
- **Quick Start:** [Quick Start Guide](../docs/getting-started/quick-start.md)
- **Troubleshooting:** [Troubleshooting Guide](../docs/guides/troubleshooting.md)

---

**Need help?** Check the [Troubleshooting Guide](../docs/guides/troubleshooting.md).

