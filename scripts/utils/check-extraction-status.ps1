# Check Extraction Status
$extractDir = "docs/design-systems/checkout/extracted-data"

Write-Host "=== Extraction Status Check ===" -ForegroundColor Cyan
Write-Host ""

. scripts/config/channel-config.ps1 | Out-Null
$channel = Get-FigmaChannel
Write-Host "Current Channel: $channel" -ForegroundColor Yellow
Write-Host ""

$requiredFiles = @(
    @{Name="Document Info"; File="02-document-info.json"},
    @{Name="Components"; File="03-components.json"},
    @{Name="Styles"; File="04-styles.json"}
)

$optionalFiles = @(
    @{Name="Channel Join"; File="01-channel-join.json"},
    @{Name="Selection"; File="05-selection.json"}
)

Write-Host "Required Files:" -ForegroundColor Yellow
$allRequired = $true
foreach ($file in $requiredFiles) {
    $path = "$extractDir/$($file.File)"
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        Write-Host "  ✓ $($file.Name) - $size bytes" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $($file.Name) - MISSING" -ForegroundColor Red
        $allRequired = $false
    }
}

Write-Host ""
Write-Host "Optional Files:" -ForegroundColor Yellow
foreach ($file in $optionalFiles) {
    $path = "$extractDir/$($file.File)"
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        Write-Host "  ✓ $($file.Name) - $size bytes" -ForegroundColor Green
    } else {
        Write-Host "  - $($file.Name) - Not found" -ForegroundColor Gray
    }
}

Write-Host ""

if ($allRequired) {
    Write-Host "✓ All required files present!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Ready to generate review:" -ForegroundColor Cyan
    Write-Host "  .\scripts\utils\create-complete-review.ps1" -ForegroundColor White
} else {
    Write-Host "✗ Missing required files" -ForegroundColor Red
    Write-Host ""
    Write-Host "To extract data:" -ForegroundColor Yellow
    Write-Host "  1. Run MCP commands in Cursor" -ForegroundColor White
    Write-Host "  2. Save JSON responses to extracted-data folder" -ForegroundColor White
    Write-Host "  3. Run this script again to verify" -ForegroundColor White
}

Write-Host ""
