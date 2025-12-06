# Quick Start Guide

Get the MCP Figma server up and running in 3 simple steps.

## 🎯 Activate in 3 Steps

### Step 1: Install Dependencies

**Windows (PowerShell):**
```powershell
.\scripts\setup\setup.ps1
```

**Linux/Mac (Bash):**
```bash
chmod +x scripts/setup/setup.sh
./scripts/setup/setup.sh
```

This installs Bun (if needed) and all project dependencies.

### Step 2: Start WebSocket Server

**Windows (PowerShell):**
```powershell
.\scripts\server\start-websocket.ps1
```

**Linux/Mac (Bash):**
```bash
./scripts/server/start-websocket.sh
```

**⚠️ Important:** Keep this terminal window open while using Figma MCP!

The server runs on port **3055** by default.

### Step 3: Restart Cursor

Close and reopen Cursor to load the MCP server configuration from `.cursor/mcp.json`.

## 🔌 Connect to Figma

1. **Open Figma** → Run plugin: `Plugins > Cursor Talk To Figma MCP Plugin`
2. **Note the channel name** from the plugin panel (e.g., "959ykpvn")
3. **In Cursor**, join the channel:
   - Use the `join_channel` function with the channel name
   - Or ask: "Join the Figma channel [channel-name]"

## ✅ Verify It's Working

In Cursor, try:
```
Get information about the current Figma document
```

Or use the function:
```
mcp_TalkToFigma_get_document_info
```

## 📁 Configuration Location

- **MCP Config:** `.cursor/mcp.json` (workspace-specific)
- **WebSocket Server:** Port 3055
- **Server Path:** Uses official npm package (`cursor-talk-to-figma-mcp@latest`)

## 🆘 Quick Troubleshooting

| Issue | Solution |
|-------|----------|
| MCP server not found | Restart Cursor |
| Not connected to Figma | Check WebSocket server is running |
| Must join a channel | Get channel name from Figma plugin |

## 📚 More Information

- **Full Installation:** [Installation Guide](installation.md)
- **Detailed Activation:** [Activation Guide](activation.md)
- **Complete Tutorial:** [Tutorial](../guides/tutorial.md)
- **All Functions:** [Functions Reference](../reference/functions.md)

---

**Ready for more?** Check out the [Complete Tutorial](../guides/tutorial.md) for detailed examples and best practices!

