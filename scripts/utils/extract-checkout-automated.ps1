# Automated Checkout Design System Extraction
# This script extracts all data from Figma and saves it to files

# Import channel config
. "$PSScriptRoot\..\config\channel-config.ps1"
$channel = Get-FigmaChannel

$extractDir = "docs/design-systems/checkout/extracted-data"

Write-Host "=== Automated Checkout Design System Extraction ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Channel: $channel" -ForegroundColor Yellow
Write-Host "Extraction Directory: $extractDir" -ForegroundColor Yellow
Write-Host ""

# Create extraction directory
New-Item -ItemType Directory -Force -Path $extractDir | Out-Null

Write-Host "Extraction directory created: $extractDir" -ForegroundColor Green
Write-Host ""
Write-Host "This script will guide you through extracting data." -ForegroundColor Yellow
Write-Host ""
Write-Host "Run these commands in Cursor chat and save responses:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Join Channel:" -ForegroundColor White
Write-Host "   `"Join the Figma channel $channel`"" -ForegroundColor Gray
Write-Host "   Save response to: $extractDir/01-channel-join.json" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Get Document Info:" -ForegroundColor White
Write-Host '   "Get information about the current Figma document"' -ForegroundColor Gray
Write-Host "   Save response to: $extractDir/02-document-info.json" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Get All Components:" -ForegroundColor White
Write-Host '   "Get all local components in the document"' -ForegroundColor Gray
Write-Host "   Save response to: $extractDir/03-components.json" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Get All Styles:" -ForegroundColor White
Write-Host '   "Get all styles in the document"' -ForegroundColor Gray
Write-Host "   Save response to: $extractDir/04-styles.json" -ForegroundColor Gray
Write-Host ""
Write-Host "5. Get Selection:" -ForegroundColor White
Write-Host '   "What is currently selected in Figma?"' -ForegroundColor Gray
Write-Host "   Save response to: $extractDir/05-selection.json" -ForegroundColor Gray
Write-Host ""
Write-Host "After saving all JSON files, run:" -ForegroundColor Yellow
Write-Host "  .\scripts\utils\process-extracted-data.ps1" -ForegroundColor White
Write-Host ""


