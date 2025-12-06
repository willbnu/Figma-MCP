# PowerShell script to start the WebSocket server for Figma MCP
# This server must be running for Cursor to communicate with Figma

$port = if ($Env:PORT) { $Env:PORT } else { 3055 }
$host = if ($Env:HOST) { $Env:HOST } else { "localhost" }

Write-Host "Starting Figma MCP WebSocket Server..." -ForegroundColor Green
Write-Host "Server will run on $host`:$port" -ForegroundColor Yellow
Write-Host "Keep this window open while using Figma MCP" -ForegroundColor Yellow
Write-Host ""

# Check if bun is installed
try {
    $bunVersion = bun --version
    Write-Host "Bun version: $bunVersion" -ForegroundColor Cyan
} catch {
    Write-Host "Error: Bun is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Install Bun from: https://bun.sh" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "For Windows PowerShell, run:" -ForegroundColor Yellow
    Write-Host 'powershell -c "irm bun.sh/install.ps1|iex"' -ForegroundColor Cyan
    exit 1
}

# Navigate to figma-mcp-server directory
Set-Location -Path "figma-mcp-server"

# Check if dependencies are installed
if (-not (Test-Path "node_modules")) {
    Write-Host "Installing dependencies..." -ForegroundColor Yellow
    bun install
}

# Start the WebSocket server
Write-Host ""
Write-Host "Starting WebSocket server..." -ForegroundColor Green
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

bun run socket

