# Extract All Comments from All Pages
# Comprehensive script to collect annotations from all pages

param(
    [string]$OutputFile = "docs/design-systems/checkout/ALL_COMMENTS.md"
)

Write-Host "=== Extracting All Comments from All Pages ===" -ForegroundColor Cyan
Write-Host ""

# Import channel config
. scripts/config/channel-config.ps1 | Out-Null
$channel = Get-FigmaChannel

$extractDir = "docs/design-systems/checkout/extracted-data"

Write-Host "Channel: $channel" -ForegroundColor Yellow
Write-Host ""

# Instructions for manual extraction
Write-Host "=== Instructions for Extracting All Comments ===" -ForegroundColor Yellow
Write-Host ""
Write-Host "To get ALL comments from ALL pages, follow these steps:" -ForegroundColor White
Write-Host ""
Write-Host "1. Get document info to see all pages:" -ForegroundColor Cyan
Write-Host "   - Run: get_document_info" -ForegroundColor White
Write-Host ""
Write-Host "2. For each page, get annotations:" -ForegroundColor Cyan
Write-Host "   - Get annotations from page sections (not page nodes)" -ForegroundColor White
Write-Host "   - Or get annotations without nodeId (gets current page)" -ForegroundColor White
Write-Host "   - Save each result to: $extractDir/annotations-page-[N].json" -ForegroundColor White
Write-Host ""
Write-Host "3. Run this script to process all annotation files:" -ForegroundColor Cyan
Write-Host "   .\scripts\utils\process-comments.ps1" -ForegroundColor White
Write-Host ""

# Check for existing annotation files
$annotationFiles = Get-ChildItem -Path $extractDir -Filter "*annotation*.json" -ErrorAction SilentlyContinue

if ($annotationFiles.Count -gt 0) {
    Write-Host "Found $($annotationFiles.Count) annotation file(s). Processing..." -ForegroundColor Green
    Write-Host ""
    & "$PSScriptRoot\process-comments.ps1" -OutputFile $OutputFile
} else {
    Write-Host "No annotation files found yet." -ForegroundColor Yellow
    Write-Host "Please extract annotations first using the instructions above." -ForegroundColor Yellow
}

