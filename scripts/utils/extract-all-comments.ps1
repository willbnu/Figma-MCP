# Extract All Comments from Figma
# Collects all annotations/comments from all pages in the document

param(
    [string]$OutputFile = "docs/design-systems/checkout/ALL_COMMENTS.md"
)

Write-Host "=== Extracting All Comments from Figma ===" -ForegroundColor Cyan
Write-Host ""

# Import channel config
. scripts/config/channel-config.ps1 | Out-Null
$channel = Get-FigmaChannel

Write-Host "Channel: $channel" -ForegroundColor Yellow
Write-Host ""

# Get document info to find all pages
Write-Host "Getting document structure..." -ForegroundColor Yellow

# Note: This script should be run from Cursor chat with MCP tools
# For now, we'll create a template that can be populated

$content = @()
$content += "# All Comments - Checkout Design System"
$content += ""
$content += "**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$content += "**Channel:** $channel"
$content += ""
$content += "## Instructions"
$content += ""
$content += "This document collects all comments/annotations from all pages in the Figma file."
$content += ""
$content += "To populate this document, run the following MCP commands in Cursor:"
$content += ""
$content += "1. Get document info: ``get_document_info``"
$content += "2. For each page, get annotations: ``get_annotations`` (with page node ID)"
$content += "3. Save the results to JSON files in ``extracted-data/``"
$content += "4. Run this script to process the JSON files"
$content += ""
$content += "## Document Structure"
$content += ""
$content += "[To be populated with page list]"
$content += ""
$content += "## Comments by Page"
$content += ""
$content += "### Page 1: [Page Name]"
$content += ""
$content += "[Comments will be listed here]"
$content += ""
$content += "---"
$content += ""
$content += "**Note:** This document is generated from Figma annotations."
$content += "**Update:** Re-run extraction and this script to update."

# Write template
$content | Set-Content -Path $OutputFile

Write-Host "Template created: $OutputFile" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Get annotations from all pages using MCP tools" -ForegroundColor White
Write-Host "  2. Save annotation JSON files to extracted-data/" -ForegroundColor White
Write-Host "  3. Run this script again to process the data" -ForegroundColor White

