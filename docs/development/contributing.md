# Contributing Guide

Thank you for your interest in contributing to the MCP Figma Server project!

## Getting Started

1. **Fork the repository** (if contributing to upstream)
2. **Clone your fork** or the local repository
3. **Set up development environment** (see [Installation Guide](../getting-started/installation.md))
4. **Create a branch** for your changes

## Development Setup

### Local Development

Use the local MCP server configuration for development:

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

### Building

```bash
cd figma-mcp-server
bun run build
```

### Testing

1. Start WebSocket server: `bun socket`
2. Test in Cursor with local configuration
3. Verify functions work as expected

## Contribution Areas

### Documentation

- Improve existing documentation
- Add examples
- Fix typos or clarify instructions
- Translate documentation

### Code

- Fix bugs
- Add new features
- Improve performance
- Refactor code

### Testing

- Add test cases
- Improve test coverage
- Document test procedures

## Code Style

- Follow existing code style
- Use TypeScript best practices
- Add comments for complex logic
- Keep functions focused and single-purpose

## Documentation Standards

- Use clear, concise language
- Include code examples
- Add table of contents for long documents
- Cross-reference related documentation

## Pull Request Process

1. **Create a branch** from main
2. **Make your changes**
3. **Test thoroughly**
4. **Update documentation** if needed
5. **Submit pull request** with clear description

## Commit Messages

Use clear, descriptive commit messages:

```
feat: Add new function for batch operations
fix: Resolve connection timeout issue
docs: Update installation guide
```

## Questions?

- Check existing documentation
- Review [Troubleshooting Guide](../guides/troubleshooting.md)
- Open an issue for discussion

---

**Thank you for contributing!** 🎉

