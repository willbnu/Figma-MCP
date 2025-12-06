# PowerShell setup script for Figma MCP Server
# This script installs dependencies and configures the MCP server

Write-Host "Setting up Figma MCP Server..." -ForegroundColor Green
Write-Host ""

# Check if bun is installed
try {
    $bunVersion = bun --version
    Write-Host "✓ Bun is installed (version: $bunVersion)" -ForegroundColor Green
} catch {
    Write-Host "✗ Bun is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installing Bun..." -ForegroundColor Yellow
    powershell -c "irm bun.sh/install.ps1|iex"
    
    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    # Check again
    try {
        $bunVersion = bun --version
        Write-Host "✓ Bun installed successfully (version: $bunVersion)" -ForegroundColor Green
    } catch {
        Write-Host "✗ Bun installation failed. Please install manually from https://bun.sh" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Installing dependencies..." -ForegroundColor Yellow
Set-Location -Path "figma-mcp-server"
bun install

Write-Host ""
Write-Host "✓ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Start the WebSocket server: .\scripts\server\start-websocket.ps1" -ForegroundColor Yellow
Write-Host "2. Install the Figma plugin (see docs/getting-started/activation.md)" -ForegroundColor Yellow
Write-Host "3. Restart Cursor to load the MCP server" -ForegroundColor Yellow
Write-Host ""

Set-Location -Path ".."

