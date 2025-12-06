# Setup Guide

Configuration options and best practices for setting up the MCP Figma server.

## Configuration Options

### MCP Server Configuration

The MCP server can be configured in two ways:

#### Option 1: Official NPM Package (Recommended)

Uses the published npm package with automatic updates:

```json
{
  "mcpServers": {
    "TalkToFigma": {
      "command": "bunx",
      "args": ["cursor-talk-to-figma-mcp@latest"]
    }
  }
}
```

**Benefits:**
- ✅ Automatic updates - Always gets the latest version
- ✅ Official maintained - From the official repository
- ✅ Simple setup - No local repository needed
- ✅ Reliable - Tested and published version

#### Option 2: Local Development

Uses the local repository for development and customization:

```json
{
  "mcpServers": {
    "TalkToFigma": {
      "command": "bun",
      "args": ["figma-mcp-server/src/talk_to_figma_mcp/server.ts"],
      "cwd": "${workspaceFolder}"
    }
  }
}
```

**Benefits:**
- ✅ Can modify and customize the code
- ✅ Works offline
- ✅ Good for development and debugging
- ✅ Full control over version

**Location:** `.cursor/mcp.json` (workspace-specific)

### WebSocket Server Configuration

**Default Settings:**
- **Port:** 3055
- **Hostname:** localhost

**Windows WSL Configuration:**

For Windows WSL compatibility, edit `figma-mcp-server/src/socket.ts` and uncomment:

```typescript
hostname: "0.0.0.0",
```

This allows connections from WSL to the WebSocket server.

## Which Setup Should You Use?

### Use Official Version if:
- You want the latest features automatically
- You don't need to modify the code
- You prefer simpler setup
- You want official support

### Use Local Version if:
- You're developing or customizing
- You need offline access
- You want to control the exact version
- You're contributing to the project

## Configuration Files

### MCP Configuration

**Location:** `.cursor/mcp.json`

Created automatically during setup, or manually using:
```powershell
.\scripts\utils\create-mcp-config.ps1
```

### WebSocket Server

**Location:** `figma-mcp-server/src/socket.ts`

Default configuration works for most setups. Only modify for WSL or special network configurations.

## Best Practices

1. **Use Official Version for Production** - More reliable and automatically updated
2. **Use Local Version for Development** - Full control and customization
3. **Keep WebSocket Server Running** - Required for all operations
4. **Version Control Configuration** - Commit `.cursor/mcp.json` to your repository
5. **Document Custom Configurations** - Note any special settings

## Switching Between Configurations

To switch from local to official:

1. Update `.cursor/mcp.json` with the official configuration
2. Restart Cursor
3. The server will now use the npm package

To switch from official to local:

1. Ensure `figma-mcp-server` is set up
2. Update `.cursor/mcp.json` with the local configuration
3. Restart Cursor
4. The server will now use the local code

## Troubleshooting Configuration

### MCP Server Not Found

- Verify `.cursor/mcp.json` exists
- Check JSON syntax is valid
- Restart Cursor after changes
- Verify Bun is in PATH

### WebSocket Connection Issues

- Check port 3055 is not in use
- Verify firewall settings
- For WSL, use `hostname: "0.0.0.0"`
- Check network configuration

## Additional Resources

- **Installation:** [Installation Guide](../getting-started/installation.md)
- **Local vs Official:** [Development Guide](../development/local-vs-official.md)
- **Troubleshooting:** [Troubleshooting Guide](troubleshooting.md)

---

**Need help?** Check the [Troubleshooting Guide](troubleshooting.md) or [Activation Guide](../getting-started/activation.md).

