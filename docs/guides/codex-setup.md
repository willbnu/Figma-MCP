# Codex Plugin Setup for Figma MCP

This guide explains how to configure the Codex Plugin to work with the Figma MCP server.

## Configuration

### Location
`C:\Users\Admin\.codex\config.toml` (or `~/.codex/config.toml` on Linux/Mac)

### Current Configuration

The configuration file should include:

```toml
model = "gpt-5.1-codex-max"
model_reasoning_effort = "xhigh"
windows_wsl_setup_acknowledged = true

# Default working directory for this repository
default_cwd = "d:/Figma MCP"

# MCP Server Configuration for Figma
# This configures the cursor-talk-to-figma-mcp server to work with Codex
[mcp_servers.TalkToFigma]
command = "bun"
args = ["figma-mcp-server/src/talk_to_figma_mcp/server.ts"]
cwd = "d:/Figma MCP"

# Alternative: Use official NPM package (uncomment to use instead of local)
# [mcp_servers.TalkToFigma]
# command = "bunx"
# args = ["cursor-talk-to-figma-mcp@latest"]

# Environment variables for Bun and Figma scripts
[env]
BUN_ENV = "development"
NODE_ENV = "development"
```

## Available MCP Tools

The Figma MCP server exposes the following tools (all 40+ functions):

### Document & Selection
- `get_document_info` - Get information about the current Figma document
- `get_selection` - Get information about the current selection
- `read_my_design` - Get detailed node information about the current selection
- `get_node_info` - Get detailed information about a specific node
- `get_nodes_info` - Get detailed information about multiple nodes
- `set_focus` - Set focus on a specific node
- `set_selections` - Set selection to multiple nodes

### Creation
- `create_rectangle` - Create a new rectangle
- `create_frame` - Create a new frame with auto-layout support
- `create_text` - Create a new text element
- `create_component_instance` - Create an instance of a component

### Modification
- `set_text_content` - Update single text node
- `set_multiple_text_contents` - Batch update text (preferred)
- `move_node` - Move elements
- `resize_node` - Resize elements
- `clone_node` - Clone elements
- `delete_node` - Delete single node
- `delete_multiple_nodes` - Batch delete (preferred)

### Styling
- `set_fill_color` - Set fill color (RGBA 0-1)
- `set_stroke_color` - Set stroke color
- `set_corner_radius` - Round corners

### Auto-Layout
- `set_layout_mode` - Set layout (HORIZONTAL/VERTICAL)
- `set_padding` - Set padding
- `set_axis_align` - Align items
- `set_layout_sizing` - Control sizing
- `set_item_spacing` - Set spacing

### Components
- `get_instance_overrides` - Extract overrides
- `set_instance_overrides` - Apply overrides

### Annotations
- `get_annotations` - Get annotations
- `set_annotation` - Create/update annotation
- `set_multiple_annotations` - Batch annotations (preferred)

### Scanning
- `scan_text_nodes` - Find all text nodes
- `scan_nodes_by_types` - Find nodes by type

### Styles & Components
- `get_styles` - Get all local styles
- `get_local_components` - Get all local components

### Prototyping
- `get_reactions` - Get prototyping reactions
- `set_default_connector` - Set default connector style
- `create_connections` - Create connector lines

### Connection
- `join_channel` - Join a channel to communicate with Figma (REQUIRED FIRST)

## Setup Steps

1. **Install Dependencies**
   ```powershell
   .\scripts\setup\setup.ps1
   ```

2. **Start WebSocket Server**
   ```powershell
   .\scripts\server\start-websocket.ps1
   ```
   Keep this terminal open - the server must run on port 3055.

3. **Open Figma Plugin**
   - In Figma, go to Plugins > Development > Cursor MCP Plugin
   - Note the channel name displayed in the plugin panel

4. **Join Channel in Codex**
   - Use the `join_channel` tool with the channel name from Figma
   - Example: "Join channel abc123xyz"

5. **Verify Connection**
   - Test with: "Get document info from Figma"
   - Test with: "What is currently selected in Figma?"

## Important Notes

- **Always join channel first** - Required before any operation
- **WebSocket must be running** - Check with `netstat -ano | findstr :3055`
- **Use batch operations** - More efficient for multiple items
- **Verify changes** - Always check with `get_node_info` after modifications

## Troubleshooting

### MCP Server Not Found
- Ensure `bun` is installed and in PATH
- Check that the path to `server.ts` is correct
- Restart Codex after configuration changes

### Not Connected to Figma
- Ensure WebSocket server is running on port 3055
- Check that Figma plugin is running
- Verify you've joined a channel using `join_channel`

### Must Join a Channel
- Get the channel name from the Figma plugin panel
- Use `join_channel` with the channel name
- Channel names are case-sensitive

## Configuration Options

### Local Development (Current)
```toml
[mcp_servers.TalkToFigma]
command = "bun"
args = ["figma-mcp-server/src/talk_to_figma_mcp/server.ts"]
cwd = "d:/Figma MCP"
```

### Official NPM Package
```toml
[mcp_servers.TalkToFigma]
command = "bunx"
args = ["cursor-talk-to-figma-mcp@latest"]
```

## Reference

- **MCP Server Code:** `figma-mcp-server/src/talk_to_figma_mcp/server.ts`
- **WebSocket Server:** `figma-mcp-server/src/socket.ts`
- **Figma Plugin:** `figma-mcp-server/src/cursor_mcp_plugin/`
- **All Functions:** See `docs/reference/functions.md`

