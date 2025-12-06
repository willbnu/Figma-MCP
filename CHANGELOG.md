# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Progress updates for `get_reactions` now use 0–100% to match other commands
- Clarified extraction placeholder script messaging (no silent “processed” output)

### Changed
- Start scripts call `bun run socket` (aligns with package.json) and honor `PORT`/`HOST`
- Logging now follows `[Figma] [Category] [Action] ...` and goes to stderr to avoid MCP stdio pollution
- README/agent docs guidance: channel-first flow, doc/selection introspection, batch ops, verification steps

### Fixed
- WebSocket server no longer overwrites `ws.close`; close frames are sent and connections clean up
- MCP server resolves/rejects pending requests even when results are falsy or errors lack `result`
- Comments processing script labels pages from JSON `pageName`/document name/file name to avoid “[Page Name]”

## [1.0.0] - 2025-01-XX

### Added
- Initial MCP Figma server integration
- WebSocket server for Figma communication
- 40+ MCP functions for Figma interaction
- Support for official npm package and local development
- Installation and setup scripts
- Basic documentation

### Features
- Document reading and analysis
- Element creation and modification
- Styling and auto-layout configuration
- Component and style management
- Annotation support
- Prototype visualization
- Batch operations
- Export functionality

---

## Version History

- **1.0.0** - Initial release with full MCP Figma integration
- **Unreleased** - Documentation reorganization and improvements

---

**Note:** This changelog tracks changes to the project organization and documentation. For MCP server changes, see the [upstream repository](https://github.com/grab/cursor-talk-to-figma-mcp).

[Unreleased]: #unreleased
[1.0.0]: #100---2025-01-xx
