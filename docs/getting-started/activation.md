# Activation Guide

Complete guide for activating and connecting the MCP Figma server to Figma.

## Prerequisites

Before activating, ensure you have:

- ✅ Bun runtime installed
- ✅ Dependencies installed (see [Installation Guide](installation.md))
- ✅ WebSocket server ready to start
- ✅ Cursor IDE with MCP support

## Step 1: Start the WebSocket Server

The WebSocket server is the bridge between Cursor and Figma. It must be running.

### Windows (PowerShell)

```powershell
.\scripts\server\start-websocket.ps1
```

### Linux/Mac (Bash)

```bash
./scripts/server/start-websocket.sh
```

### Manual Start

```bash
cd figma-mcp-server
bun socket
```

**⚠️ Important:** Keep this terminal window open while using Figma MCP!

You should see:
```
WebSocket server running on port 3055
```

## Step 2: Install Figma Plugin

You have two options:

### Option A: Install from Figma Community (Recommended)

1. Open Figma
2. Go to [Figma Community Plugin Page](https://www.figma.com/community/plugin/1485687494525374295/cursor-talk-to-figma-mcp-plugin)
3. Click "Install"
4. The plugin will appear in your Figma plugins menu

**Benefits:**
- ✅ Official plugin
- ✅ Auto-updates through Figma
- ✅ One-click installation

### Option B: Install Locally (Development)

1. In Figma, go to `Plugins > Development > New Plugin`
2. Choose "Link existing plugin"
3. Navigate to: `figma-mcp-server/src/cursor_mcp_plugin/manifest.json`
4. Click "Open"
5. The plugin will appear in your development plugins

**Benefits:**
- ✅ Can modify plugin code
- ✅ Good for development
- ✅ Full control

## Step 3: Connect to Figma

1. **Open Figma** and open any design file
2. **Run the plugin:**
   - Go to `Plugins > Cursor Talk To Figma MCP Plugin`
   - Or use `Plugins > Development > Cursor Talk To Figma MCP Plugin` (if installed locally)

3. **In the plugin panel:**
   - Ensure "Use localhost" is enabled
   - Port should show: **3055**
   - Note the **channel name** displayed (e.g., "959ykpvn" or similar)

4. **In Cursor**, join the channel:
   - You can ask: "Join the Figma channel [channel-name]"
   - Or use the function directly: `mcp_TalkToFigma_join_channel` with the channel name

## Step 4: Verify Connection

Test the connection with these commands in Cursor:

### Test 1: Get Document Info
```
Get information about the current Figma document
```

### Test 2: Get Selection
```
What is currently selected in Figma?
```

### Test 3: Read Design
```
Read the current design selection in Figma
```

## Configuration Details

### MCP Server Configuration

Location: `.cursor/mcp.json`

**Official Setup (Recommended):**
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

**Local Development Setup:**
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

### WebSocket Server

- **Port:** 3055 (default)
- **Hostname:** localhost (or 0.0.0.0 for WSL)

For Windows WSL, edit `figma-mcp-server/src/socket.ts` and uncomment:
```typescript
hostname: "0.0.0.0",
```

## Troubleshooting

### "MCP server not found"
- Ensure `.cursor/mcp.json` exists in the workspace root
- Restart Cursor after creating/editing the config
- Check that `bun` is in your PATH

### "Not connected to Figma"
- Ensure WebSocket server is running (`bun socket`)
- Check that Figma plugin is running
- Verify you've joined a channel using `join_channel`

### "Must join a channel"
- Get the channel name from the Figma plugin panel
- Use `join_channel` with the channel name
- Channel names are case-sensitive

### Windows/WSL Issues
- Uncomment `hostname: "0.0.0.0"` in `figma-mcp-server/src/socket.ts`
- Ensure firewall allows connections on port 3055

### Plugin Not Connecting
- Verify "Use localhost" is enabled in plugin
- Check port is set to 3055
- Restart the plugin if needed

## Connection Flow

Understanding the connection flow helps with troubleshooting:

```
Cursor MCP Server → WebSocket (port 3055) → Figma Plugin → Figma
```

All components must be running:
- ✅ Cursor MCP Server (loaded in Cursor)
- ✅ WebSocket Server (running on port 3055)
- ✅ Figma Plugin (running and connected)
- ✅ Figma File (should be open)

## Success Indicators

When everything works, you should see:

- **WebSocket server:** "WebSocket server running on port 3055"
- **Figma plugin:** "Connected to server in channel: [channel-name]"
- **Cursor:** Functions work without "Not connected" errors

## Next Steps

Once connected:

1. **Explore functions** - See [Functions Reference](../reference/functions.md)
2. **Read the tutorial** - See [Complete Tutorial](../guides/tutorial.md)
3. **Try examples** - See [Examples](../reference/examples.md)

## Additional Resources

- **Quick Start:** [Quick Start Guide](quick-start.md)
- **Setup Options:** [Setup Guide](../guides/setup.md)
- **Troubleshooting:** [Troubleshooting Guide](../guides/troubleshooting.md)
- **Functions:** [Functions Reference](../reference/functions.md)

---

**Connected successfully?** Check out the [Complete Tutorial](../guides/tutorial.md) to learn how to use all the features!

