# MCP Figma Server Integration

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![MCP](https://img.shields.io/badge/MCP-Enabled-green.svg)](https://modelcontextprotocol.io/)

Professional integration of the [cursor-talk-to-figma-mcp](https://github.com/grab/cursor-talk-to-figma-mcp) MCP server, enabling Cursor AI to communicate with Figma for reading designs and modifying them programmatically.

## 🚀 Features

- **40+ MCP Functions** - Comprehensive Figma interaction capabilities
- **Document Reading** - Analyze and extract design information
- **Element Creation** - Create rectangles, frames, and text programmatically
- **Design Modification** - Update text, styles, and layouts
- **Component Management** - Work with components and instances
- **Batch Operations** - Efficient bulk operations
- **Auto-Layout Support** - Configure auto-layout properties
- **Annotation Support** - Create and manage annotations
- **Prototype Visualization** - Convert prototype reactions to connectors
- **Export Capabilities** - Export nodes as images

## 🧭 How It Works (Precise Flow)

1. **WebSocket server (port 3055)**: `./scripts/server/start-websocket.*` launches `figma-mcp-server/src/socket.ts`. Keep this terminal open.
2. **Figma plugin channel**: Run the plugin in Figma, copy the channel name, and call `join_channel` from Cursor to bind your session.
3. **MCP stdio server**: `figma-mcp-server/src/talk_to_figma_mcp/server.ts` runs under Bun and proxies MCP tools to the WebSocket bridge.
4. **Message path**: MCP tool → stdio server → WebSocket → Figma plugin → Figma, then responses return the same path.
5. **Logging**: All Figma ops log to stderr with `[Figma] [Category] [Action] …` to avoid MCP stdio pollution.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Installation](#installation)
- [Documentation](#documentation)
- [Features](#features)
- [Configuration](#configuration)
- [Usage Examples](#usage-examples)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Quick Start

### 1. Install Dependencies

**Windows:**
```powershell
.\scripts\setup\setup.ps1
```

**Linux/Mac:**
```bash
./scripts/setup/setup.sh
```

### 2. Start WebSocket Server

**Windows:**
```powershell
.\scripts\server\start-websocket.ps1
```

**Linux/Mac:**
```bash
./scripts/server/start-websocket.sh
```

**⚠️ Keep this terminal open!**

### 3. Restart Cursor

Close and reopen Cursor to load the MCP server configuration.

### 4. Connect to Figma

1. Open Figma and run the plugin: `Plugins > Cursor Talk To Figma MCP Plugin`
2. Note the channel name from the plugin panel
3. In Cursor, join the channel using `join_channel`

**See [Quick Start Guide](docs/getting-started/quick-start.md) for detailed instructions.**

## 📦 Installation

### Prerequisites

- **Bun Runtime** - [Install Bun](https://bun.sh)
- **Figma Desktop** or **Figma Web** - Access to Figma
- **Cursor IDE** - With MCP support

### Installation Steps

See [Installation Guide](docs/getting-started/installation.md) for complete installation instructions.

## 📚 Documentation

Comprehensive documentation is organized in the `docs/` directory:

### Getting Started
- **[Installation Guide](docs/getting-started/installation.md)** - Complete installation instructions
- **[Quick Start Guide](docs/getting-started/quick-start.md)** - Get up and running in 3 steps
- **[Activation Guide](docs/getting-started/activation.md)** - Connect to Figma and verify setup

### Guides
- **[Complete Tutorial](docs/guides/tutorial.md)** - Step-by-step tutorial with examples
- **[Setup Guide](docs/guides/setup.md)** - Configuration options and best practices
- **[Troubleshooting Guide](docs/guides/troubleshooting.md)** - Common issues and solutions

### Reference
- **[Functions Reference](docs/reference/functions.md)** - Complete list of all 40+ functions
- **[API Documentation](docs/reference/api.md)** - Technical API reference
- **[Usage Examples](docs/reference/examples.md)** - Code examples and use cases

### Development
- **[Local vs Official](docs/development/local-vs-official.md)** - Setup comparison
- **[Contributing Guide](docs/development/contributing.md)** - How to contribute
- **[Architecture](docs/development/architecture.md)** - System architecture

**See [Documentation Index](docs/index.md) for complete navigation.**

## ⚙️ Configuration

### MCP Server Configuration

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

**Location:** `.cursor/mcp.json`

### Environment Variables

- Copy `.env.example` to `.env` to override defaults for the WebSocket server.
- `PORT` (default `3055`) and `HOST` (default `localhost`) are read by `figma-mcp-server/src/socket.ts` and the `start-websocket` scripts.
- Use these when you need to bind to a different interface/port (e.g., WSL or shared dev VMs).

See [Setup Guide](docs/guides/setup.md) for detailed configuration options.

## ✅ Best Use: Getting Content & Creating in Figma

**Extract/Inspect**
- Join channel → `get_document_info` (overview) → `get_selection` → `read_my_design`.
- For text/comments: `scan_text_nodes`, `get_annotations`, `get_reactions` (progress is 0–100%).
- Use batch scans before bulk edits; keep logs in required format.

**Create/Modify**
- Join channel; create containers first (`create_frame`, `create_rectangle`), then text (`create_text`).
- Style (`set_fill_color`, `set_stroke_color`, `set_corner_radius`), auto-layout (`set_layout_mode`, spacing/padding).
- Verify with `get_node_info`/`get_nodes_info`; use batch ops (`set_multiple_text_contents`, `set_multiple_annotations`) to reduce round trips.

**Prototype Connectors**
- Fetch reactions (`get_reactions`), then apply `reaction_to_connector_strategy`, set default connector, and call `create_connections`.

## 💡 Usage Examples

### Reading a Design

```
Get information about the current Figma document
```

### Creating Elements

```
Create a login screen with email and password fields
```

### Bulk Text Replacement

```
Replace all text in the selected frame with new content
```

### Converting Prototypes

```
Convert prototype reactions to connector lines
```

**See [Usage Examples](docs/reference/examples.md) for more examples.**

## 📁 Project Structure

```
.
├── docs/                        # All documentation
│   ├── getting-started/         # Quick start guides
│   ├── guides/                  # Detailed guides
│   ├── reference/               # Reference documentation
│   ├── development/             # Development docs
│   └── archive/                 # Historical docs
├── scripts/                     # Utility scripts
│   ├── setup/                   # Installation scripts
│   ├── server/                  # Server scripts
│   └── utils/                   # Utility scripts
├── figma-mcp-server/            # MCP server repository
├── .cursor/                     # Cursor configuration
│   ├── mcp.json                 # MCP server config
│   └── rules/                   # Cursor rules
├── CHANGELOG.md                 # Version history
├── FUTURE_LOG.md                # Future plans
├── LICENSE                      # Apache 2.0 License
└── README.md                    # This file
```

## 🛠️ Available Functions

The MCP server provides 40+ functions organized into categories:

- **Document & Selection** (7 functions) - Read document and selection information
- **Creating Elements** (3 functions) - Create rectangles, frames, and text
- **Modifying Elements** (6 functions) - Move, resize, clone, delete nodes
- **Styling** (3 functions) - Set colors, strokes, corner radius
- **Auto Layout & Spacing** (5 functions) - Configure auto-layout properties
- **Annotations** (3 functions) - Create and manage annotations
- **Prototyping & Connections** (3 functions) - Work with prototype flows
- **Components & Styles** (5 functions) - Manage components and styles
- **Scanning & Analysis** (2 functions) - Scan for nodes and text
- **Export** (1 function) - Export nodes as images

**See [Functions Reference](docs/reference/functions.md) for complete details.**

## 🔧 Scripts

All scripts are organized in the `scripts/` directory:

- **Setup:** `scripts/setup/` - Installation scripts
- **Server:** `scripts/server/` - WebSocket server scripts
- **Utils:** `scripts/utils/` - Utility scripts

**See [Scripts README](scripts/README.md) for details.**

## 🐛 Troubleshooting

Common issues and solutions:

- **"Not connected to Figma"** - Check WebSocket server and plugin connection
- **"Must join a channel"** - Join channel using `join_channel`
- **MCP server not found** - Restart Cursor and verify configuration

**See [Troubleshooting Guide](docs/guides/troubleshooting.md) for detailed solutions.**

## 🤝 Contributing

Contributions are welcome! Please see:

- **[Contributing Guide](CONTRIBUTING.md)** - General contribution guidelines
- **[Development Guide](docs/development/contributing.md)** - Development-specific guidelines
- **[Future Log](FUTURE_LOG.md)** - Planned features and ideas

## 📖 Best Practices

1. **Always join a channel first** before sending commands
2. **Start with document overview** using `get_document_info`
3. **Use batch operations** for multiple items
4. **Verify changes** with `get_node_info` after modifications
5. **Handle errors appropriately** - all commands can throw exceptions

**See [Complete Tutorial](docs/guides/tutorial.md) for detailed best practices.**

## 🔗 Resources

- **Original Repository:** [grab/cursor-talk-to-figma-mcp](https://github.com/grab/cursor-talk-to-figma-mcp)
- **Figma Plugin:** [Figma Community Page](https://www.figma.com/community/plugin/1485687494525374295/cursor-talk-to-figma-mcp-plugin)
- **MCP Documentation:** [Model Context Protocol](https://modelcontextprotocol.io/)
- **Documentation:** [Documentation Index](docs/index.md)

## 📝 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

The MCP server (`figma-mcp-server/`) is based on [cursor-talk-to-figma-mcp](https://github.com/grab/cursor-talk-to-figma-mcp) which is licensed under MIT License.

## 📊 Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and changes.

## 🗺️ Roadmap

See [FUTURE_LOG.md](FUTURE_LOG.md) for future plans and ideas.

---

**Need help?** Check the [Documentation Index](docs/index.md) or [Troubleshooting Guide](docs/guides/troubleshooting.md).

**Ready to get started?** See the [Quick Start Guide](docs/getting-started/quick-start.md)!

## 🌐 How to Publish to GitHub (Public)

1) Prep the tree
- Verify no secrets: check `.env`, `.cursor/mcp.json`, and `docs/design-systems/checkout/extracted-data/*.json`; remove or redact if needed.
- Ensure `.gitignore` excludes `node_modules/`, `.bun/`, `dist/` (and optionally `figma-mcp-server/dist/`), plus extraction JSONs you don’t want to publish.
- Keep `LICENSE` (Apache 2.0) and `CHANGELOG.md` as-is.

2) Initialize git (from repo root)
```bash
git init
git add .
git commit -m "Initial public release"
```

3) Create a new public GitHub repo
- Create on GitHub without auto-adding README/license/gitignore.

4) Add remote and push
```bash
git remote add origin https://github.com/<your-org-or-user>/<repo-name>.git
git branch -M main
git push -u origin main
```

5) Optional polish before push
- Install deps: `(cd figma-mcp-server && bun install)`; commit `bun.lock`.
- Quick status: `./scripts/utils/check-status.ps1` (or `.sh`).
- If extraction JSONs are large/sensitive, remove or gitignore `docs/design-systems/checkout/extracted-data/*.json`.

6) Post-publish
- Tag a release (e.g., `v1.0.1`) aligned with `CHANGELOG.md`.
- Enable branch protection on `main` if desired.
