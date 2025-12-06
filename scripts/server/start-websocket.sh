#!/bin/bash

# Bash script to start the WebSocket server for Figma MCP
# This server must be running for Cursor to communicate with Figma

PORT_VALUE="${PORT:-3055}"
HOST_VALUE="${HOST:-localhost}"

echo "Starting Figma MCP WebSocket Server..."
echo "Server will run on ${HOST_VALUE}:${PORT_VALUE}"
echo "Keep this terminal open while using Figma MCP"
echo ""

# Check if bun is installed
if ! command -v bun &> /dev/null; then
    echo "Error: Bun is not installed or not in PATH"
    echo "Install Bun from: https://bun.sh"
    echo ""
    echo "Run: curl -fsSL https://bun.sh/install | bash"
    exit 1
fi

echo "Bun version: $(bun --version)"
echo ""

# Navigate to figma-mcp-server directory
cd figma-mcp-server

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    bun install
fi

# Start the WebSocket server
echo ""
echo "Starting WebSocket server..."
echo "Press Ctrl+C to stop the server"
echo ""

bun run socket

