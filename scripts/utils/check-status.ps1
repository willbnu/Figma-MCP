# Status Check Script for Figma MCP Server
Write-Host "=== Figma MCP Server Status Check ===" -ForegroundColor Cyan
Write-Host ""

# Check Bun
Write-Host "1. Checking Bun runtime..." -ForegroundColor Yellow
$env:Path += ";C:\Users\Admin\.bun\bin"
$bunCheck = Get-Command bun -ErrorAction SilentlyContinue
if ($bunCheck) {
    $bunVersion = bun --version
    Write-Host "   [OK] Bun installed: $bunVersion" -ForegroundColor Green
} else {
    Write-Host "   [FAIL] Bun not found" -ForegroundColor Red
}

# Check Dependencies
Write-Host ""
Write-Host "2. Checking dependencies..." -ForegroundColor Yellow
if (Test-Path "figma-mcp-server/node_modules") {
    Write-Host "   [OK] Dependencies installed" -ForegroundColor Green
} else {
    Write-Host "   [FAIL] Dependencies missing" -ForegroundColor Red
}

# Check Build
Write-Host ""
Write-Host "3. Checking build..." -ForegroundColor Yellow
if (Test-Path "figma-mcp-server/dist/server.js") {
    Write-Host "   [OK] Project built" -ForegroundColor Green
} else {
    Write-Host "   [FAIL] Build missing" -ForegroundColor Red
}

# Check MCP Config
Write-Host ""
Write-Host "4. Checking MCP configuration..." -ForegroundColor Yellow
if (Test-Path ".cursor/mcp.json") {
    Write-Host "   [OK] MCP config exists" -ForegroundColor Green
} else {
    Write-Host "   [FAIL] MCP config missing" -ForegroundColor Red
}

# Check WebSocket Server
Write-Host ""
Write-Host "5. Checking WebSocket server..." -ForegroundColor Yellow
$wsRunning = netstat -ano | findstr :3055
if ($wsRunning) {
    Write-Host "   [OK] WebSocket server running on port 3055" -ForegroundColor Green
} else {
    Write-Host "   [FAIL] WebSocket server not running" -ForegroundColor Red
    Write-Host "   Start with: .\scripts\server\start-websocket.ps1" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Status Check Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. If WebSocket not running: .\scripts\server\start-websocket.ps1" -ForegroundColor White
Write-Host "2. Install Figma plugin (see docs/getting-started/activation.md)" -ForegroundColor White
Write-Host "3. Connect to Figma using join_channel" -ForegroundColor White

