# Update Channel Configuration
# Changes the channel in the central config file

param(
    [Parameter(Mandatory=$true)]
    [string]$NewChannel
)

$configFile = "scripts/config/channel-config.ps1"

Write-Host "=== Updating Figma Channel ===" -ForegroundColor Cyan
Write-Host ""

# Read current config
if (Test-Path $configFile) {
    $content = Get-Content $configFile -Raw
    
    # Replace channel value
    $content = $content -replace '\$script:FigmaChannel = ".*"', "`$script:FigmaChannel = `"$NewChannel`""
    
    # Write back
    Set-Content -Path $configFile -Value $content -NoNewline
    
    Write-Host "✓ Channel updated in config: $NewChannel" -ForegroundColor Green
    Write-Host ""
    Write-Host "Channel is now: $NewChannel" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Note: Documentation files reference the config." -ForegroundColor Yellow
    Write-Host "Scripts will use the new channel automatically." -ForegroundColor Yellow
} else {
    $errorMsg = "Error: Config file not found: $configFile"
    Write-Host $errorMsg -ForegroundColor Red
    exit 1
}
