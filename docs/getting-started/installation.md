# Installation Guide

Complete guide for installing all dependencies and tools for the MCP Figma server.

## Prerequisites

Before you begin, ensure you have:

1. **Bun Runtime** - Required for running the MCP server
2. **Figma Desktop App** or **Figma Web** - Access to Figma
3. **Cursor IDE** - With MCP support enabled

## Step 1: Install Bun Runtime

### Windows (PowerShell)

```powershell
powershell -c "irm bun.sh/install.ps1|iex"
```

After installation, verify:
```powershell
bun --version
```

**Note:** You may need to restart your terminal/PowerShell for Bun to be available globally. If Bun is not found, add it to your PATH:

```powershell
$env:Path += ";C:\Users\Admin\.bun\bin"
```

Or add permanently:
1. Open System Properties > Environment Variables
2. Add `C:\Users\Admin\.bun\bin` to User PATH variable

### macOS/Linux

```bash
curl -fsSL https://bun.sh/install | bash
```

Verify installation:
```bash
bun --version
```

## Step 2: Install Project Dependencies

### Option A: Using Setup Script (Recommended)

**Windows:**
```powershell
.\scripts\setup\setup.ps1
```

**Linux/Mac:**
```bash
chmod +x scripts/setup/setup.sh
./scripts/setup/setup.sh
```

### Option B: Manual Installation

```bash
cd figma-mcp-server
bun install
```

This will install:
- `@modelcontextprotocol/sdk@1.13.1`
- `uuid@11.1.0`
- `ws@8.18.1`
- `zod@3.22.4`
- Plus dev dependencies (TypeScript, tsup, etc.)

**Total:** ~166 packages

## Step 3: Build the Project (Optional)

To compile TypeScript to JavaScript:

```bash
cd figma-mcp-server
bun run build
```

This creates the `dist/` folder with:
- `server.js` (ESM)
- `server.cjs` (CJS)
- TypeScript definitions
- Source maps

## Step 4: Configure MCP Server

The MCP server should be automatically configured. If not, see [Setup Guide](../guides/setup.md) for manual configuration.

## Verification

Verify your installation:

```powershell
# Windows
.\scripts\utils\check-status.ps1

# Or manually check:
Test-Path "figma-mcp-server/node_modules"  # Should be True
Test-Path "figma-mcp-server/dist/server.js"  # Should be True (if built)
```

## What Was Installed

### Bun Runtime
- **Version:** Latest (check with `bun --version`)
- **Location:** System-wide installation
- **Status:** ✅ Installed and verified

### Project Dependencies
- **Location:** `figma-mcp-server/node_modules/`
- **Packages:** 166 packages installed
- **Status:** ✅ Installed

### Built Project (if built)
- **Location:** `figma-mcp-server/dist/`
- **Output:** Compiled JavaScript files
- **Status:** ✅ Built (optional)

## Next Steps

After installation:

1. **Start the WebSocket server** - See [Quick Start](quick-start.md)
2. **Install Figma plugin** - See [Activation Guide](activation.md)
3. **Connect to Figma** - See [Activation Guide](activation.md)

## Troubleshooting

### Bun Not Found

**Symptom:** `bun: command not found`

**Solution:**
- Restart your terminal/PowerShell
- Add Bun to PATH (see Step 1)
- Verify installation: `bun --version`

### Dependencies Not Installing

**Symptom:** `bun install` fails

**Solution:**
- Check internet connection
- Verify Bun is installed: `bun --version`
- Try clearing cache: `bun install --force`

### Build Fails

**Symptom:** `bun run build` errors

**Solution:**
- Ensure dependencies are installed: `bun install`
- Check TypeScript version compatibility
- Review error messages for specific issues

## Additional Resources

- **Quick Start:** [Quick Start Guide](quick-start.md)
- **Activation:** [Activation Guide](activation.md)
- **Troubleshooting:** [Troubleshooting Guide](../guides/troubleshooting.md)

---

**Installation complete?** Proceed to [Quick Start](quick-start.md) to get started!

