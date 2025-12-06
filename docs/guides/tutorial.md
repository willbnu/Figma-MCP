# Complete Tutorial: MCP Figma Server Setup and Usage

> **Note:** This is a comprehensive tutorial. For quick setup, see [Quick Start Guide](../getting-started/quick-start.md).

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Configuration](#configuration)
5. [Starting the Server](#starting-the-server)
6. [Connecting to Figma](#connecting-to-figma)
7. [Available Functions](#available-functions)
8. [Usage Examples](#usage-examples)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

---

## Introduction

The MCP Figma Server allows Cursor AI to communicate with Figma, enabling you to:
- Read and analyze Figma designs
- Create and modify design elements programmatically
- Automate design tasks
- Extract design information for development

This integration uses the Model Context Protocol (MCP) to bridge Cursor and Figma through a WebSocket server.

---

## Prerequisites

Before you begin, ensure you have:

1. **Bun Runtime** - Install Bun if you haven't already:
   ```bash
   # Windows (PowerShell)
   powershell -c "irm bun.sh/install.ps1|iex"
   
   # macOS/Linux
   curl -fsSL https://bun.sh/install | bash
   ```

2. **Figma Desktop App** or **Figma Web** - You'll need access to Figma

3. **Cursor IDE** - Make sure you're using Cursor with MCP support

---

## Installation

See [Installation Guide](../getting-started/installation.md) for complete installation instructions.

---

## Configuration

### MCP Server Configuration

The MCP server should be automatically configured during setup. If you need to configure it manually, see [Setup Guide](setup.md).

### WebSocket Server Configuration

The WebSocket server runs on port `3055` by default. For Windows WSL compatibility, you may need to uncomment the hostname in `figma-mcp-server/src/socket.ts`:

```typescript
hostname: "0.0.0.0",
```

---

## Starting the Server

### Step 1: Start the WebSocket Server

**Windows (PowerShell):**
```powershell
.\scripts\server\start-websocket.ps1
```

**Linux/Mac (Bash):**
```bash
./scripts/server/start-websocket.sh
```

**Manual:**
```bash
cd figma-mcp-server
bun socket
```

You should see:
```
WebSocket server running on port 3055
```

**Keep this terminal open** - the WebSocket server must be running for the MCP server to communicate with Figma.

### Step 2: Install the Figma Plugin

See [Activation Guide](../getting-started/activation.md) for plugin installation instructions.

---

## Connecting to Figma

See [Activation Guide](../getting-started/activation.md) for detailed connection instructions.

---

## Available Functions

The MCP server provides comprehensive tools for interacting with Figma. See [Functions Reference](../reference/functions.md) for complete documentation of all 40+ functions.

### Function Categories

- **Document & Selection** - Read document and selection information
- **Creating Elements** - Create rectangles, frames, and text
- **Modifying Elements** - Move, resize, clone, delete nodes
- **Styling** - Set colors, strokes, corner radius
- **Auto Layout & Spacing** - Configure auto-layout properties
- **Annotations** - Create and manage annotations
- **Prototyping & Connections** - Work with prototype flows and connectors
- **Components & Styles** - Manage components and styles
- **Scanning & Analysis** - Scan for nodes and text
- **Export** - Export nodes as images

---

## Usage Examples

### Example 1: Reading a Design

```markdown
1. Select a frame or element in Figma
2. In Cursor, ask: "Read the current design selection"
3. The AI will use `read_my_design` to get detailed information
```

### Example 2: Creating a Login Screen

```markdown
1. Join the Figma channel
2. Ask Cursor: "Create a login screen with email and password fields"
3. The AI will:
   - Create a main frame
   - Add input containers
   - Create text labels
   - Style elements appropriately
```

### Example 3: Bulk Text Replacement

```markdown
1. Select a frame containing text nodes
2. Ask: "Replace all text in the selected frame with new content"
3. The AI will:
   - Scan all text nodes using `scan_text_nodes`
   - Use `set_multiple_text_contents` to update them in batches
   - Provide progress updates
```

### Example 4: Converting Prototype Reactions to Connectors

```markdown
1. Select nodes with prototype connections
2. Ask: "Convert prototype reactions to connector lines"
3. The AI will:
   - Use `get_reactions` to extract prototype flows
   - Check/set default connector with `set_default_connector`
   - Generate connections using `create_connections`
```

### Example 5: Applying Component Overrides

```markdown
1. Select a component instance with desired overrides
2. Ask: "Apply these overrides to other instances"
3. The AI will:
   - Use `get_instance_overrides` to extract overrides
   - Use `set_instance_overrides` to apply to target instances
```

---

## Best Practices

### 1. Always Join a Channel First
Before sending any commands, ensure you've joined the channel using `join_channel`.

### 2. Start with Document Overview
Use `get_document_info` to understand the document structure before making changes.

### 3. Check Current Selection
Use `get_selection` to verify what's currently selected before modifications.

### 4. Use Batch Operations
For multiple operations, use batch functions:
- `set_multiple_text_contents` instead of multiple `set_text_content` calls
- `set_multiple_annotations` instead of multiple `set_annotation` calls
- `delete_multiple_nodes` instead of multiple `delete_node` calls

### 5. Verify Changes
After making modifications, use `get_node_info` to verify the changes were applied correctly.

### 6. Use Component Instances
When possible, use component instances for consistency rather than creating duplicate elements.

### 7. Handle Large Designs
For large designs:
- Use chunking parameters in `scan_text_nodes`
- Monitor progress through WebSocket updates
- Implement appropriate error handling

### 8. Text Operations
- Use batch operations when possible
- Consider structural relationships
- Verify changes with targeted exports

### 9. Annotation Conversion
When converting legacy annotations:
- Scan text nodes to identify markers and descriptions
- Use `scan_nodes_by_types` to find UI elements
- Match markers with targets using path, name, or proximity
- Create native annotations with `set_multiple_annotations` in batches
- Delete legacy annotation nodes after successful conversion

### 10. Prototype Visualization
To visualize prototype flows:
- Use `get_reactions` to extract prototype flows
- Set a default connector with `set_default_connector`
- Generate connector lines with `create_connections`

---

## Troubleshooting

For detailed troubleshooting, see [Troubleshooting Guide](troubleshooting.md).

### Common Issues

- **"Not connected to Figma"** - Check WebSocket server and plugin connection
- **"Must join a channel"** - Join channel using `join_channel`
- **WebSocket connection fails** - Check hostname configuration for WSL
- **Commands timeout** - Verify plugin is running and connection is active

---

## Additional Resources

- **Quick Start:** [Quick Start Guide](../getting-started/quick-start.md)
- **Functions:** [Functions Reference](../reference/functions.md)
- **Setup Options:** [Setup Guide](setup.md)
- **Troubleshooting:** [Troubleshooting Guide](troubleshooting.md)
- **GitHub Repository:** [cursor-talk-to-figma-mcp](https://github.com/grab/cursor-talk-to-figma-mcp)
- **Figma Plugin:** [Figma Community Page](https://www.figma.com/community/plugin/1485687494525374295/cursor-talk-to-figma-mcp-plugin)

---

**Happy designing with AI! 🎨**

