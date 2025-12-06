# Create Complete Documentation Review
# Generates comprehensive review from extracted data

param(
    [switch]$Force
)

$extractDir = "docs/design-systems/checkout/extracted-data"
$reviewFile = "docs/design-systems/checkout/COMPLETE_REVIEW.md"

Write-Host "=== Creating Complete Documentation Review ===" -ForegroundColor Cyan
Write-Host ""

# Check if data exists
if (-not (Test-Path "$extractDir/02-document-info.json")) {
    Write-Host "Error: No extracted data found" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please extract data first:" -ForegroundColor Yellow
    Write-Host "  1. Run: .\scripts\utils\extract-checkout-automated.ps1" -ForegroundColor White
    Write-Host "  2. Use MCP commands in Cursor to get data" -ForegroundColor White
    Write-Host "  3. Save JSON files to $extractDir" -ForegroundColor White
    Write-Host "  4. Run this script again" -ForegroundColor White
    exit 1
}

Write-Host "Found extracted data. Processing..." -ForegroundColor Green
Write-Host ""

# Load and process data
try {
    $docInfo = Get-Content "$extractDir/02-document-info.json" | ConvertFrom-Json
    $components = Get-Content "$extractDir/03-components.json" | ConvertFrom-Json
    $styles = Get-Content "$extractDir/04-styles.json" | ConvertFrom-Json
    
    Write-Host "Document info loaded" -ForegroundColor Green
    Write-Host "Components loaded" -ForegroundColor Green
    Write-Host "Styles loaded" -ForegroundColor Green
    Write-Host ""
    
    # Generate review content
    Write-Host "Generating review content..." -ForegroundColor Yellow
    
    # Extract document name
    $docName = if ($docInfo.name) { $docInfo.name } else { "Unknown" }
    $docId = if ($docInfo.id) { $docInfo.id } else { "Unknown" }
    
    # Count components - use array length if it's larger than count field
    $compCount = 0
    $arrayCount = 0
    if ($components.components) { $arrayCount = $components.components.Count }
    elseif ($components -is [Array]) { $arrayCount = $components.Count }
    
    # Use the larger of count field or array length
    if ($components.count -and $components.count -gt $arrayCount) { 
        $compCount = $components.count 
    } elseif ($arrayCount -gt 0) {
        $compCount = $arrayCount
    }
    
    # Count styles
    $styleCount = 0
    if ($styles.colors) { $styleCount += $styles.colors.Count }
    if ($styles.texts) { $styleCount += $styles.texts.Count }
    if ($styles.effects) { $styleCount += $styles.effects.Count }
    if ($styleCount -eq 0 -and $styles -is [Array]) { $styleCount = $styles.Count }
    
    # Extract pages if available
    $pages = @()
    if ($docInfo.pages) {
        $pages = $docInfo.pages
    } elseif ($docInfo.data -and $docInfo.data.pages) {
        $pages = $docInfo.data.pages
    }
    
    $pageCount = if ($pages -and $pages.Count -gt 0) { $pages.Count } elseif ($docInfo.pages) { $docInfo.pages.Count } else { 1 }
    
    # Get channel
    . scripts/config/channel-config.ps1 | Out-Null
    $channel = Get-FigmaChannel
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Build content array
    $content = @()
    $content += "# Complete Review - Checkout Design System"
    $content += ""
    $content += "**Generated:** $date"
    $content += "**Channel:** $channel"
    $content += ""
    $content += "## Document Overview"
    $content += ""
    $content += "### File Information"
    $content += "- **Name:** $docName"
    $content += "- **ID:** $docId"
    $content += "- **Total Pages:** $pageCount"
    $content += "- **Total Components:** $compCount"
    $content += "- **Total Styles:** $styleCount"
    $content += ""
    
    # Add pages list if available
    if ($pageCount -gt 0) {
        $content += "### Pages"
        foreach ($page in $pages) {
            $pageName = if ($page.name) { $page.name } else { "Unknown" }
            $pageId = if ($page.id) { $page.id } else { "Unknown" }
            $content += "- **$pageName** (ID: $pageId)"
        }
        $content += ""
    }
    
    $content += "## Components"
    $content += ""
    $content += "### Component Count"
    $content += "Total: $compCount"
    $content += ""
    $content += "### Component List"
    $content += "[To be populated with detailed component information]"
    $content += ""
    $content += "## Styles"
    $content += ""
    $content += "### Style Count"
    $content += "Total: $styleCount"
    $content += ""
    $content += "### Style List"
    $content += "[To be populated with detailed style information]"
    $content += ""
    $content += "## Structure"
    $content += ""
    $content += "[To be populated with structure information]"
    $content += ""
    $content += "## Relationships"
    $content += ""
    $content += "[To be populated with relationship information]"
    $content += ""
    $content += "## Patterns"
    $content += ""
    $content += "[To be populated with pattern information]"
    $content += ""
    $content += "---"
    $content += ""
    $content += "**This review is generated from extracted Figma data.**"
    $content += "**Update by re-running extraction and this script.**"
    
    # Write review file
    $content | Set-Content -Path $reviewFile
    
    Write-Host "Complete review generated: $reviewFile" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Review the generated file" -ForegroundColor White
    Write-Host "  2. Expand sections with detailed data" -ForegroundColor White
    Write-Host "  3. Add relationships and patterns" -ForegroundColor White
    
} catch {
    Write-Host "Error processing data: $_" -ForegroundColor Red
    exit 1
}
