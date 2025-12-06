# AGENTS.md

Agent-focused instructions for working with the MCP Figma Server project.

## Project Overview

This project integrates the cursor-talk-to-figma-mcp server, enabling Cursor AI to communicate with Figma for reading designs and modifying them programmatically. The project uses Bun runtime, WebSocket communication, and the Model Context Protocol (MCP).

## How It Works (Agent Quick Reference)

1. Start WebSocket server on 3055: `scripts/server/start-websocket.*` (keep terminal open).
2. Run Figma plugin, copy channel name, call `join_channel` before any command.
3. MCP stdio server proxies tools → WebSocket → Figma plugin → Figma; responses return the same path.
4. Logging must go to stderr with `[Figma] [Category] [Action] …`; never use stdout for logs.
5. Do not override `ws.close`; rely on close events for clean teardown.

## Setup Commands

### Installation
- Install dependencies: `.\scripts\setup\setup.ps1` (Windows) or `./scripts/setup/setup.sh` (Linux/Mac)
- This installs Bun (if needed) and all project dependencies in `figma-mcp-server/`

### Development Server
- Start WebSocket server: `.\scripts\server\start-websocket.ps1` (Windows) or `./scripts/server/start-websocket.sh` (Linux/Mac)
- **Critical:** Keep this terminal open - WebSocket server must run on port 3055 for MCP to work
- Server location: `figma-mcp-server/src/socket.ts`

### Build
- Build project: `cd figma-mcp-server && bun run build`
- Output: `figma-mcp-server/dist/`

### Status Check
- Verify setup: `.\scripts\utils\check-status.ps1`
- Checks: Bun installation, dependencies, build, MCP config, WebSocket server

## Code Style

- **Runtime:** Bun (not Node.js)
- **Language:** TypeScript
- **MCP Protocol:** Model Context Protocol (stdio transport)
- **WebSocket:** Custom protocol on port 3055
- **Error Handling:** Log to stderr (not stdout) to avoid MCP protocol issues

## Best Use: Extracting and Creating in Figma

**Extract/Inspect**
- Join channel → `get_document_info` → `get_selection` → `read_my_design`.
- Use `scan_text_nodes`, `scan_nodes_by_types`, `get_annotations`, `get_reactions` (progress is 0–100%).
- Log retrievals with `[Figma] [Get] …`; keep batch scans before edits.

**Create/Modify**
- Create structure first (`create_frame`, `create_rectangle`), then text (`create_text`).
- Style (`set_fill_color`, `set_stroke_color`, `set_corner_radius`) and auto-layout (`set_layout_mode`, `set_padding`, `set_item_spacing`).
- Use batch ops (`set_multiple_text_contents`, `set_multiple_annotations`) to reduce round trips; verify with `get_node_info`/`get_nodes_info`.

**Prototype Connectors**
- Run `get_reactions`, apply `reaction_to_connector_strategy`, ensure default connector, then `create_connections`.

**Error/Timeout Hygiene**
- Pending requests must resolve/reject even with falsy results; log errors with node IDs and operation context.
- Keep WebSocket server on 3055 reachable; set `PORT`/`HOST` env when needed (e.g., WSL/VM).

## Figma Operations Focus

### Always Follow This Workflow

1. **Join Channel First**
   - Use `mcp_TalkToFigma_join_channel` with channel name from Figma plugin
   - Channel name is displayed in Figma plugin panel
   - **Never skip this step** - all operations require channel connection

2. **Get Information Before Modifying**
   - Use `get_document_info` to understand document structure
   - Use `get_selection` to check current selection
   - Use `get_node_info` or `read_my_design` to analyze elements
   - Scan with `scan_text_nodes` or `scan_nodes_by_types` for bulk operations

3. **Use Batch Operations**
   - Prefer `set_multiple_text_contents` over multiple `set_text_content` calls
   - Use `set_multiple_annotations` for multiple annotations
   - Use `delete_multiple_nodes` for bulk deletions
   - Batch operations process in chunks of 5 automatically

4. **Verify Changes**
   - Always use `get_node_info` after modifications
   - Check selection with `get_selection` after operations
   - Verify document state with `get_document_info` when needed

### Getting Information from Figma

**Primary Functions:**
- `get_document_info` - Document structure, pages, components, styles
- `get_selection` - Currently selected elements
- `read_my_design` - Detailed node tree of selection
- `get_node_info(nodeId)` - Specific node details
- `get_nodes_info(nodeIds[])` - Multiple nodes at once
- `get_styles` - All local styles (colors, text, effects)
- `get_local_components` - All local components
- `get_annotations(nodeId?)` - Annotations in document or node
- `scan_text_nodes(nodeId)` - All text nodes in a node (chunked for large designs)
- `scan_nodes_by_types(nodeId, types[])` - Find nodes by type

**Best Practices:**
- Start with `get_document_info` for overview
- Use `get_selection` to understand current context
- Use `read_my_design` for detailed analysis of selection
- Scan before bulk operations to identify targets

### Adding/Modifying Information in Figma

**Creation Functions:**
- `create_rectangle(x, y, width, height, name?, parentId?)` - Create rectangles
- `create_frame(...)` - Create frames with auto-layout support
- `create_text(x, y, text, fontSize?, fontWeight?, fontColor?, name?, parentId?)` - Create text

**Modification Functions:**
- `set_text_content(nodeId, text)` - Update single text node
- `set_multiple_text_contents(nodeId, text[])` - Batch update text (preferred)
- `move_node(nodeId, x, y)` - Move elements
- `resize_node(nodeId, width, height)` - Resize elements
- `clone_node(nodeId, x?, y?)` - Clone elements
- `delete_node(nodeId)` - Delete single node
- `delete_multiple_nodes(nodeIds[])` - Batch delete (preferred)

**Styling Functions:**
- `set_fill_color(nodeId, r, g, b, a?)` - Set fill color (RGBA 0-1)
- `set_stroke_color(nodeId, r, g, b, a?, weight?)` - Set stroke
- `set_corner_radius(nodeId, radius, corners?)` - Round corners

**Auto-Layout Functions:**
- `set_layout_mode(nodeId, layoutMode, layoutWrap?)` - Set layout (HORIZONTAL/VERTICAL)
- `set_padding(nodeId, paddingTop?, paddingRight?, paddingBottom?, paddingLeft?)` - Set padding
- `set_axis_align(nodeId, primaryAxisAlignItems?, counterAxisAlignItems?)` - Align items
- `set_layout_sizing(nodeId, layoutSizingHorizontal?, layoutSizingVertical?)` - Control sizing
- `set_item_spacing(nodeId, itemSpacing?, counterAxisSpacing?)` - Set spacing

**Component Functions:**
- `create_component_instance(componentKey, x, y)` - Create instance
- `get_instance_overrides(nodeId?)` - Extract overrides
- `set_instance_overrides(sourceInstanceId, targetNodeIds[])` - Apply overrides

**Annotation Functions:**
- `set_annotation(nodeId, labelMarkdown, annotationId?, categoryId?, properties?)` - Create/update annotation
- `set_multiple_annotations(nodeId, annotations[])` - Batch annotations (preferred)

## Logging and Monitoring

### Required Logging Practices

1. **Log All Figma Operations**
   - Log before: Operation type, target node IDs, parameters
   - Log after: Success status, results, node IDs created/modified
   - Format: `[Figma] [Operation] [Status] [Details]`

2. **Log Channel Connections**
   - Log channel join: `[Figma] [Channel] Joined: {channel}`
   - Log connection status: `[Figma] [Connection] Status: {connected/disconnected}`
   - Log errors: `[Figma] [Error] {error message}`

3. **Log Information Retrieval**
   - Log document info requests: `[Figma] [Get] Document info requested`
   - Log selection queries: `[Figma] [Get] Selection: {count} items`
   - Log node info requests: `[Figma] [Get] Node info: {nodeId}`

4. **Log Modifications**
   - Log creations: `[Figma] [Create] {type} at ({x}, {y}) - ID: {nodeId}`
   - Log updates: `[Figma] [Update] {type} {nodeId}: {changes}`
   - Log deletions: `[Figma] [Delete] {count} nodes: {nodeIds}`

5. **Error Logging**
   - Always log errors with context
   - Include node IDs, operation type, and error message
   - Format: `[Figma] [Error] {operation} failed: {error} (Node: {nodeId})`

### Logging Format

```
[Figma] [Category] [Action] [Details]
```

Categories: `Channel`, `Connection`, `Get`, `Create`, `Update`, `Delete`, `Error`
Actions: Operation-specific (e.g., `Joined`, `Document info`, `Text updated`)

### Example Logs

```
[Figma] [Channel] Joined: n7grm1gb
[Figma] [Get] Document info: "↪ ⬇️   Dropdowns" (1 page, 1 section)
[Figma] [Get] Selection: 0 items
[Figma] [Create] Rectangle at (100, 100) size 200x50 - ID: 123:456
[Figma] [Update] Text 123:456: "Old text" → "New text"
[Figma] [Error] Connection failed: Not connected to Figma
```

## Testing Instructions

### Before Committing

1. **Verify WebSocket Server Running**
   - Check: `netstat -ano | findstr :3055` (Windows)
   - Or run: `.\scripts\utils\check-status.ps1`

2. **Test Connection**
   - Join channel in Cursor
   - Test: `get_document_info` should return document data
   - Test: `get_selection` should return selection (even if empty)

3. **Test Operations**
   - Create a test element
   - Verify with `get_node_info`
   - Delete test element
   - Verify deletion

4. **Check Logs**
   - Verify all operations are logged
   - Check for error logs
   - Ensure log format is consistent

### Test Checklist

- [ ] WebSocket server running on port 3055
- [ ] Channel connection established
- [ ] Can get document info
- [ ] Can get selection
- [ ] Can create elements
- [ ] Can modify elements
- [ ] Can delete elements
- [ ] All operations logged
- [ ] Errors handled and logged

## File Structure

### Folder Organization Principles
- **Separated folders** for different file types and purposes
- **Subfolders** for different categories and pages
- **Clear hierarchy** - maximum 3-4 levels deep
- **Scalable structure** - easy to add new content

### Key Directories

- **MCP Server:** `figma-mcp-server/src/talk_to_figma_mcp/server.ts`
- **WebSocket Server:** `figma-mcp-server/src/socket.ts`
- **Figma Plugin:** `figma-mcp-server/src/cursor_mcp_plugin/`
- **Scripts:** `scripts/` (setup/, server/, utils/)
- **Documentation:** `docs/` (getting-started/, guides/, reference/, development/, archive/)
- **MCP Config:** `.cursor/mcp.json`
- **Rules:** `.cursor/rules/mcp-figma-rules.mdc`

### Adding New Files

**Documentation:**
- Getting started → `docs/getting-started/`
- Guides → `docs/guides/`
- Reference → `docs/reference/`
- Development → `docs/development/`
- Archive/Test → `docs/archive/`

**Scripts:**
- Setup → `scripts/setup/`
- Server → `scripts/server/`
- Utilities → `scripts/utils/`

**Always use kebab-case for filenames** (e.g., `my-new-file.md`)

## Configuration

### MCP Server Config

Location: `.cursor/mcp.json`

**Official (Recommended):**
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

**Local Development:**
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

## Common Patterns

### Pattern: Read and Analyze Design

```typescript
1. join_channel(channel)
2. get_document_info() // Overview
3. get_selection() // Current context
4. read_my_design() // Detailed analysis
5. Log all information retrieved
```

### Pattern: Create and Style Element

```typescript
1. join_channel(channel)
2. create_frame(...) or create_rectangle(...)
3. Log creation with node ID
4. set_fill_color(nodeId, ...)
5. set_corner_radius(nodeId, ...)
6. get_node_info(nodeId) // Verify
7. Log final state
```

### Pattern: Bulk Text Update

```typescript
1. join_channel(channel)
2. scan_text_nodes(parentNodeId) // Find all text
3. Log found text nodes
4. set_multiple_text_contents(parentNodeId, updates[])
5. Log updates applied
6. Verify with get_node_info
```

## Error Handling

### Connection Errors
- "Not connected to Figma" → Check WebSocket server, plugin connection, channel
- "Must join a channel" → Call `join_channel` first
- "Request timed out" → Check plugin status, WebSocket connection

### Operation Errors
- Always log errors with full context
- Include node IDs, operation type, parameters
- Provide actionable error messages
- Retry logic for transient errors

## Security Considerations

- WebSocket server runs on localhost only (port 3055)
- No external network access required
- Channel-based isolation
- No authentication needed (local only)

## Documentation

- **Main Docs:** `docs/index.md` - Navigation hub
- **Quick Start:** `docs/getting-started/quick-start.md`
- **Functions:** `docs/reference/functions.md` - All 40+ functions
- **API:** `docs/reference/api.md` - Technical reference
- **Troubleshooting:** `docs/guides/troubleshooting.md`

## Important Notes

- **Always join channel first** - Required before any operation
- **WebSocket must be running** - Check with status script
- **Use batch operations** - More efficient for multiple items
- **Log everything** - Critical for debugging and monitoring
- **Verify changes** - Always check with get_node_info after modifications
- **Handle errors gracefully** - All functions can throw exceptions

---

**Last Updated:** Based on cursor-talk-to-figma-mcp v0.3.5

