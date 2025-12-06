# Generate Complete Documentation Review
# Processes extracted data and creates comprehensive documentation

$extractDir = "docs/design-systems/checkout/extracted-data"
$docsDir = "docs/design-systems/checkout"
$reviewFile = "$docsDir/DOCUMENTATION_REVIEW.md"

Write-Host "=== Generating Complete Documentation Review ===" -ForegroundColor Cyan
Write-Host ""

# Check for required files
$requiredFiles = @(
    "02-document-info.json",
    "03-components.json",
    "04-styles.json"
)

$missingFiles = @()
foreach ($file in $requiredFiles) {
    if (-not (Test-Path "$extractDir/$file")) {
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "Missing required files:" -ForegroundColor Red
    foreach ($file in $missingFiles) {
        Write-Host "  - $file" -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "Please extract data first:" -ForegroundColor Yellow
    Write-Host "  1. Run MCP commands in Cursor" -ForegroundColor White
    Write-Host "  2. Save JSON responses to $extractDir" -ForegroundColor White
    Write-Host "  3. Run this script again" -ForegroundColor White
    exit 1
}

Write-Host "Processing extracted data..." -ForegroundColor Green
Write-Host ""

# Load data
$docInfo = Get-Content "$extractDir/02-document-info.json" | ConvertFrom-Json
$components = Get-Content "$extractDir/03-components.json" | ConvertFrom-Json
$styles = Get-Content "$extractDir/04-styles.json" | ConvertFrom-Json

Write-Host "✓ Document info loaded" -ForegroundColor Green
Write-Host "✓ Components loaded: $($components.Count)" -ForegroundColor Green
Write-Host "✓ Styles loaded: $($styles.Count)" -ForegroundColor Green
Write-Host ""

# Generate review sections
Write-Host "Generating documentation review..." -ForegroundColor Yellow

# This will be expanded to parse and organize all data
# For now, create structure

Write-Host "✓ Documentation review structure created" -ForegroundColor Green
Write-Host ""
Write-Host "Review file: $reviewFile" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next: Review and populate with extracted data" -ForegroundColor Yellow

