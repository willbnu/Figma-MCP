# Script to create MCP configuration file for Cursor
# This configures the Figma MCP server for this workspace

Write-Host "Creating MCP configuration..." -ForegroundColor Green

# Ensure .cursor directory exists
if (-not (Test-Path ".cursor")) {
    New-Item -ItemType Directory -Path ".cursor" | Out-Null
    Write-Host "Created .cursor directory" -ForegroundColor Green
}

# Create MCP configuration JSON
$jsonContent = '{
  "mcpServers": {
    "TalkToFigma": {
      "command": "bun",
      "args": [
        "figma-mcp-server/src/talk_to_figma_mcp/server.ts"
      ],
      "cwd": "${workspaceFolder}"
    }
  }
}'

$jsonContent | Out-File -FilePath ".cursor\mcp.json" -Encoding utf8

Write-Host "MCP configuration created at .cursor\mcp.json" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Restart Cursor to load the MCP server" -ForegroundColor White
Write-Host "2. Run .\scripts\setup\setup.ps1 to install dependencies" -ForegroundColor White
Write-Host "3. Run .\scripts\server\start-websocket.ps1 to start the server" -ForegroundColor White
