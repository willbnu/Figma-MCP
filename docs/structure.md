# Project Structure Guide

This document explains the folder organization and structure of the MCP Figma Server project.

## Folder Organization Principles

### Separation of Concerns
- **Different file types** → Different folders
- **Different purposes** → Different subfolders
- **Different categories** → Clear hierarchy
- **Scalability** → Easy to add new content

## Root Level Structure

```
.
├── AGENTS.md                    # Agent-focused instructions
├── README.md                    # Main project README
├── CHANGELOG.md                 # Version history
├── FUTURE_LOG.md                # Future plans and roadmap
├── CONTRIBUTING.md              # Contribution guidelines
├── LICENSE                      # Apache 2.0 License
├── .gitignore                   # Git ignore rules
├── .cursor/                     # Cursor IDE configuration
│   ├── mcp.json                 # MCP server configuration
│   └── rules/                   # Cursor rules
│       └── mcp-figma-rules.mdc  # MCP Figma specific rules
├── docs/                        # All documentation
├── scripts/                     # All utility scripts
└── figma-mcp-server/            # MCP server repository
```

## Documentation Structure (`docs/`)

### Organization by Purpose

```
docs/
├── index.md                     # Documentation navigation hub
├── getting-started/             # For new users
│   ├── installation.md         # Installation instructions
│   ├── quick-start.md          # Quick 3-step guide
│   └── activation.md           # Connection and activation
├── guides/                      # Detailed guides
│   ├── tutorial.md             # Complete tutorial
│   ├── setup.md                # Configuration guide
│   └── troubleshooting.md      # Problem solving
├── reference/                   # Reference documentation
│   ├── functions.md            # All 40+ functions
│   ├── api.md                  # Technical API reference
│   └── examples.md             # Usage examples
├── development/                 # For developers
│   ├── local-vs-official.md    # Setup comparison
│   ├── contributing.md         # How to contribute
│   └── architecture.md         # System architecture
└── archive/                     # Historical/test docs
    ├── README.md               # Archive index
    ├── test-results.md         # Historical test results
    ├── test-success.md         # Success test documentation
    └── connection-checks.md    # Connection diagnostics
```

### Folder Purposes

- **getting-started/** - New user onboarding
- **guides/** - Step-by-step instructions
- **reference/** - Quick lookup documentation
- **development/** - Developer-focused content
- **archive/** - Historical and test documentation

## Scripts Structure (`scripts/`)

### Organization by Function

```
scripts/
├── README.md                    # Scripts documentation
├── setup/                       # Installation and setup
│   └── setup.ps1               # Main setup script
├── server/                      # Server management
│   ├── start-websocket.ps1     # Windows WebSocket server
│   └── start-websocket.sh      # Linux/Mac WebSocket server
└── utils/                       # Utility scripts
    ├── check-status.ps1        # Status verification
    └── create-mcp-config.ps1  # MCP config creation
```

### Folder Purposes

- **setup/** - One-time setup and installation
- **server/** - Server lifecycle management
- **utils/** - Helper and utility scripts

## MCP Server Structure (`figma-mcp-server/`)

### Organization by Component

```
figma-mcp-server/
├── src/
│   ├── talk_to_figma_mcp/      # MCP server implementation
│   │   ├── server.ts           # Main MCP server
│   │   ├── package.json        # Server dependencies
│   │   └── tsconfig.json       # TypeScript config
│   ├── cursor_mcp_plugin/      # Figma plugin
│   │   ├── code.js             # Plugin logic
│   │   ├── ui.html             # Plugin UI
│   │   └── manifest.json       # Plugin manifest
│   └── socket.ts               # WebSocket server
├── dist/                        # Build output
├── scripts/                     # Server scripts
│   └── setup.sh                # Server setup
├── package.json                 # Project dependencies
└── tsconfig.json                # TypeScript configuration
```

## Configuration Structure (`.cursor/`)

```
.cursor/
├── mcp.json                     # MCP server configuration
└── rules/                       # Cursor rules
    └── mcp-figma-rules.mdc     # Figma-specific rules
```

## File Naming Conventions

### Documentation Files
- **kebab-case.md** - All documentation files
- **README.md** - Index files in folders
- **index.md** - Main navigation files

### Script Files
- **kebab-case.ps1** - PowerShell scripts
- **kebab-case.sh** - Bash scripts
- **README.md** - Documentation in script folders

### Configuration Files
- **mcp.json** - MCP configuration
- **package.json** - Node/Bun package config
- **tsconfig.json** - TypeScript configuration

## Adding New Content

### Adding Documentation

1. **Determine category:**
   - Getting started → `docs/getting-started/`
   - Guide → `docs/guides/`
   - Reference → `docs/reference/`
   - Development → `docs/development/`
   - Archive → `docs/archive/`

2. **Use kebab-case naming:**
   - `my-new-guide.md`
   - `advanced-features.md`

3. **Update index:**
   - Add link to `docs/index.md`
   - Update relevant category section

### Adding Scripts

1. **Determine function:**
   - Setup → `scripts/setup/`
   - Server → `scripts/server/`
   - Utility → `scripts/utils/`

2. **Use descriptive names:**
   - `install-dependencies.ps1`
   - `restart-server.sh`

3. **Update scripts README:**
   - Document in `scripts/README.md`
   - Include usage examples

## Best Practices

1. **One purpose per folder** - Each folder has a clear purpose
2. **Consistent naming** - Use kebab-case for files
3. **README files** - Add README.md to explain folder contents
4. **Clear hierarchy** - Maximum 3-4 levels deep
5. **Scalable structure** - Easy to add new content

## Folder Depth Guidelines

- **Maximum depth:** 3-4 levels
- **Root level:** Project-wide files only
- **First level:** Major categories (docs, scripts, etc.)
- **Second level:** Subcategories (getting-started, guides, etc.)
- **Third level:** Individual files or further categorization

## Examples

### Good Structure
```
docs/
  guides/
    tutorial.md
    setup.md
```

### Avoid
```
docs/
  guides/
    tutorial/
      part1.md
      part2.md
      part3.md
```
(Too deep - consolidate into single tutorial.md or use sections)

## Maintenance

- **Regular review** - Check folder structure quarterly
- **Consolidate** - Merge similar content when possible
- **Archive** - Move outdated content to archive/
- **Document** - Keep README files updated

---

**See Also:**
- [Documentation Index](index.md)
- [AGENTS.md](../AGENTS.md) - Agent-focused instructions

