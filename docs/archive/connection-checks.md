# 🔍 Connection Status Check

## Current Status

✅ **MCP Server:** Loaded and active (40 tools, 6 prompts enabled)
❌ **Figma Connection:** Not connected

## Error Messages
- "Not connected to Figma. Attempting to connect..."
- "Error joining channel: Not connected to Figma"

## What This Means

The MCP server is loaded in Cursor, but it cannot communicate with Figma. This usually means:

1. **WebSocket server not running** - The bridge between Cursor and Figma
2. **Figma plugin not connected** - The plugin needs to be running and connected
3. **Connection issue** - Communication between components is broken

## 🔧 Quick Fix Steps

### Step 1: Verify WebSocket Server
The WebSocket server must be running on port 3055.

**Check:**
```powershell
netstat -ano | findstr :3055
```

**If not running, start it:**
```powershell
.\start-websocket.ps1
```

Or manually:
```powershell
cd figma-mcp-server
$env:Path += ";C:\Users\Admin\.bun\bin"
bun socket
```

### Step 2: Check Figma Plugin
1. **Open Figma**
2. **Run the plugin:** `Plugins > Cursor Talk To Figma MCP Plugin`
3. **Verify in plugin panel:**
   - "Use localhost" is enabled ✅
   - Port shows: 3055 ✅
   - Status shows: "Connected to server in channel: eljhs03w" ✅
   - If not connected, click "Connect" or restart the plugin

### Step 3: Verify Connection Flow
```
Cursor MCP Server → WebSocket (port 3055) → Figma Plugin → Figma
```

All components must be running:
- ✅ Cursor MCP Server (loaded - we see it)
- ❓ WebSocket Server (need to verify)
- ❓ Figma Plugin (need to verify)
- ❓ Figma File (should be open)

### Step 4: Test Connection
Once everything is verified:
1. Make sure WebSocket server window is open and running
2. Make sure Figma plugin is running and shows "Connected"
3. Have a Figma file open
4. Try again in Cursor

## 🎯 Most Common Issue

**WebSocket server not running** - This is the #1 cause of "Not connected to Figma" errors.

The WebSocket server is the bridge that connects:
- Cursor MCP Server ↔ WebSocket (port 3055) ↔ Figma Plugin

If the WebSocket server stops, the connection breaks.

## ✅ Success Indicators

When everything works, you should see:
- WebSocket server: "WebSocket server running on port 3055"
- Figma plugin: "Connected to server in channel: [channel-name]"
- Cursor: Functions work without "Not connected" errors

