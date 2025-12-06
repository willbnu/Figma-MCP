# API Documentation

Technical API reference for the MCP Figma server.

## Overview

The MCP Figma server implements the Model Context Protocol (MCP) to provide a standardized interface between Cursor AI and Figma.

## Protocol

- **Protocol:** Model Context Protocol (MCP)
- **Transport:** stdio (for MCP server), WebSocket (for Figma communication)
- **Format:** JSON-RPC 2.0

## Server Configuration

### MCP Server

**Type:** stdio-based MCP server

**Configuration:**
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

### WebSocket Server

**Port:** 3055 (default)
**Hostname:** localhost (or 0.0.0.0 for WSL)

**Purpose:** Bridges communication between MCP server and Figma plugin

## Function Categories

See [Functions Reference](functions.md) for complete function documentation.

### Document & Selection (7 functions)
- `get_document_info`
- `get_selection`
- `read_my_design`
- `get_node_info`
- `get_nodes_info`
- `set_focus`
- `set_selections`

### Creating Elements (3 functions)
- `create_rectangle`
- `create_frame`
- `create_text`

### Modifying Elements (6 functions)
- `set_text_content`
- `set_multiple_text_contents`
- `move_node`
- `resize_node`
- `clone_node`
- `delete_node`
- `delete_multiple_nodes`

### Styling (3 functions)
- `set_fill_color`
- `set_stroke_color`
- `set_corner_radius`

### Auto Layout & Spacing (5 functions)
- `set_layout_mode`
- `set_padding`
- `set_axis_align`
- `set_layout_sizing`
- `set_item_spacing`

### Annotations (3 functions)
- `get_annotations`
- `set_annotation`
- `set_multiple_annotations`

### Prototyping & Connections (3 functions)
- `get_reactions`
- `set_default_connector`
- `create_connections`

### Components & Styles (5 functions)
- `get_styles`
- `get_local_components`
- `create_component_instance`
- `get_instance_overrides`
- `set_instance_overrides`

### Scanning & Analysis (2 functions)
- `scan_text_nodes`
- `scan_nodes_by_types`

### Export (1 function)
- `export_node_as_image`

### Connection Management (1 function)
- `join_channel`

## Data Types

### Color (RGBA)
```typescript
{
  r: number;  // 0-1
  g: number;  // 0-1
  b: number;  // 0-1
  a?: number; // 0-1, optional, default: 1
}
```

### Node ID
String format: `"123:456"` (file ID:node ID)

### Layout Mode
Enum: `"NONE" | "HORIZONTAL" | "VERTICAL"`

### Alignment
Enum: `"MIN" | "MAX" | "CENTER" | "SPACE_BETWEEN" | "BASELINE"`

### Sizing
Enum: `"FIXED" | "HUG" | "FILL"`

## Error Codes

- **Connection Error:** "Not connected to Figma"
- **Channel Error:** "Must join a channel before sending commands"
- **Timeout Error:** "Request to Figma timed out"
- **Connection Lost:** "Connection closed"

## Rate Limiting

- Batch operations process in chunks of 5
- Large designs are automatically chunked
- Timeouts are extended for long-running operations

## WebSocket Protocol

The WebSocket server uses a custom protocol for communication:

1. **Channel-based:** Each Figma plugin session creates a unique channel
2. **Request-Response:** MCP server sends requests, plugin responds
3. **Error Handling:** Errors are propagated back to MCP server

## Additional Resources

- **Functions:** [Functions Reference](functions.md)
- **Examples:** [Examples](examples.md)
- **MCP Specification:** [Model Context Protocol](https://modelcontextprotocol.io/)

---

**Last Updated:** Based on cursor-talk-to-figma-mcp v0.3.5

