# Troubleshooting Guide

Common issues and solutions for the MCP Figma server.

## Connection Issues

### "Not connected to Figma"

**Symptoms:**
- Error: "Not connected to Figma. Attempting to connect..."
- Functions return connection errors

**Solutions:**

1. **Verify WebSocket Server is Running**
   ```powershell
   # Check if port 3055 is in use
   netstat -ano | findstr :3055
   ```
   If not running, start it:
   ```powershell
   .\scripts\server\start-websocket.ps1
   ```

2. **Check Figma Plugin**
   - Ensure plugin is running: `Plugins > Cursor Talk To Figma MCP Plugin`
   - Verify "Use localhost" is enabled
   - Check port is set to 3055
   - Restart plugin if needed

3. **Verify Channel Connection**
   - Get channel name from Figma plugin panel
   - Join channel using `join_channel` function
   - Channel names are case-sensitive

### "Must join a channel before sending commands"

**Solution:**
1. Get the channel name from the Figma plugin panel
2. Use `join_channel` with the channel name:
   ```
   Join the Figma channel [channel-name]
   ```
3. Wait for confirmation before sending other commands

### WebSocket Connection Fails (Windows/WSL)

**Symptoms:**
- Connection timeout
- Cannot connect from WSL

**Solution:**
1. Edit `figma-mcp-server/src/socket.ts`
2. Uncomment the hostname line:
   ```typescript
   hostname: "0.0.0.0",
   ```
3. Restart the WebSocket server

## Installation Issues

### Bun Not Found

**Symptoms:**
- `bun: command not found`
- Setup script fails

**Solutions:**

1. **Restart Terminal**
   - Close and reopen PowerShell/terminal
   - PATH may not be refreshed

2. **Add to PATH Manually**
   ```powershell
   $env:Path += ";C:\Users\Admin\.bun\bin"
   ```

3. **Install Bun**
   ```powershell
   powershell -c "irm bun.sh/install.ps1|iex"
   ```

### Dependencies Not Installing

**Symptoms:**
- `bun install` fails
- Missing packages

**Solutions:**

1. **Check Internet Connection**
   - Verify you can access npm registry

2. **Clear Cache**
   ```bash
   bun install --force
   ```

3. **Verify Bun Installation**
   ```bash
   bun --version
   ```

## MCP Server Issues

### MCP Server Not Found in Cursor

**Symptoms:**
- Server doesn't appear in Cursor settings
- Functions not available

**Solutions:**

1. **Verify Configuration File**
   - Check `.cursor/mcp.json` exists
   - Verify JSON syntax is valid

2. **Restart Cursor**
   - Close and reopen Cursor completely
   - Configuration is loaded on startup

3. **Check Bun Installation**
   - Verify `bun` is accessible
   - Check PATH includes Bun

### Commands Timeout

**Symptoms:**
- Functions timeout
- No response from Figma

**Solutions:**

1. **Check Plugin Status**
   - Verify Figma plugin is still running
   - Restart plugin if needed

2. **Verify WebSocket Connection**
   - Check WebSocket server is running
   - Verify connection is active

3. **Check Figma File**
   - Ensure a Figma file is open
   - Some functions require an open file

## Plugin Issues

### Plugin Not Appearing in Figma

**Symptoms:**
- Plugin not in plugins menu
- Cannot find plugin

**Solutions:**

1. **For Local Installation**
   - Check `Plugins > Development`
   - Verify manifest.json path is correct

2. **For Community Installation**
   - Reinstall from [Figma Community](https://www.figma.com/community/plugin/1485687494525374295/cursor-talk-to-figma-mcp-plugin)
   - Check plugin is enabled

### Plugin Not Connecting

**Symptoms:**
- Plugin shows "Not connected"
- Cannot establish connection

**Solutions:**

1. **Verify WebSocket Server**
   - Check server is running on port 3055
   - Verify "Use localhost" is enabled

2. **Check Firewall**
   - Ensure port 3055 is not blocked
   - Allow localhost connections

3. **Restart Plugin**
   - Close and reopen plugin
   - Try reconnecting

## Function-Specific Issues

### Can't Create Connections

**Symptoms:**
- `create_connections` fails
- No connectors created

**Solution:**
1. Set default connector first:
   ```
   Use set_default_connector to set a default connector style
   ```
2. If no default connector exists:
   - Copy a connector from FigJam
   - Paste it onto your page
   - Select it
   - Call `set_default_connector` with the connector ID

### Text Operations Fail

**Symptoms:**
- Text updates don't work
- Batch operations fail

**Solutions:**

1. **Verify Node IDs**
   - Ensure text nodes exist
   - Check node IDs are correct

2. **Use Batch Operations**
   - Use `set_multiple_text_contents` for multiple updates
   - More efficient and reliable

### Export Issues

**Symptoms:**
- Export fails
- No image returned

**Solutions:**

1. **Check Node Exists**
   - Verify node ID is valid
   - Ensure node is visible

2. **Try Different Format**
   - PNG is most reliable
   - SVG/PDF may have limitations

## Performance Issues

### Slow Operations

**Symptoms:**
- Functions take too long
- Timeouts on large designs

**Solutions:**

1. **Use Batch Operations**
   - Group multiple operations
   - More efficient than individual calls

2. **Chunk Large Operations**
   - Break large tasks into smaller chunks
   - Monitor progress

3. **Optimize Design**
   - Reduce complexity if possible
   - Use components for repeated elements

## Diagnostic Tools

### Status Check Script

Run the status check to verify setup:

```powershell
.\scripts\utils\check-status.ps1
```

This checks:
- Bun installation
- Dependencies
- Build status
- MCP configuration
- WebSocket server

### Manual Verification

1. **Check WebSocket Server**
   ```powershell
   netstat -ano | findstr :3055
   ```

2. **Verify MCP Config**
   ```powershell
   Get-Content .cursor/mcp.json
   ```

3. **Test Bun**
   ```powershell
   bun --version
   ```

## Getting Help

If issues persist:

1. **Check Documentation**
   - Review [Activation Guide](../getting-started/activation.md)
   - Check [Setup Guide](setup.md)

2. **Review Logs**
   - WebSocket server logs
   - Figma plugin console
   - Cursor MCP logs

3. **Community Support**
   - [GitHub Issues](https://github.com/grab/cursor-talk-to-figma-mcp/issues)
   - Check existing issues for similar problems

## Additional Resources

- **Quick Start:** [Quick Start Guide](../getting-started/quick-start.md)
- **Activation:** [Activation Guide](../getting-started/activation.md)
- **Setup:** [Setup Guide](setup.md)
- **Functions:** [Functions Reference](../reference/functions.md)

---

**Still having issues?** Check the [GitHub Issues](https://github.com/grab/cursor-talk-to-figma-mcp/issues) or open a new issue with details about your problem.

