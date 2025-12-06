# Process Comments from Extracted Data
# Processes annotation JSON files into a comprehensive comments document

param(
    [string]$OutputFile = "docs/design-systems/checkout/ALL_COMMENTS.md",
    [string]$DataDir = "docs/design-systems/checkout/extracted-data"
)

Write-Host "=== Processing Comments ===" -ForegroundColor Cyan
Write-Host ""

# Import channel config
. scripts/config/channel-config.ps1 | Out-Null
$channel = Get-FigmaChannel

$content = @()
$content += "# All Comments - Checkout Design System"
$content += ""
$content += "**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$content += "**Channel:** $channel"
$content += ""
$content += "## Overview"
$content += ""
$content += "This document contains all comments/annotations from all pages in the Figma design system file."
$content += ""
$content += "## Comments by Page"
$content += ""

# Check for annotation files
$annotationFiles = Get-ChildItem -Path $DataDir -Filter "*annotation*.json" -ErrorAction SilentlyContinue

if ($annotationFiles.Count -eq 0) {
    $content += "### No Annotation Data Found"
    $content += ""
    $content += "To populate this document:"
    $content += ""
    $content += "1. Get annotations from Figma using MCP tools:"
    $content += "   - Run ``get_annotations`` (without nodeId) to get all annotations from current page"
    $content += "   - Or run ``get_annotations`` with specific node IDs"
    $content += ""
    $content += "2. Save the JSON responses to:"
    $content += "   - ``$DataDir/annotations-page-1.json``"
    $content += "   - ``$DataDir/annotations-page-2.json``"
    $content += "   - etc."
    $content += ""
    $content += "3. Run this script again to process the data"
} else {
    $totalComments = 0
    $pageNum = 1
    
    foreach ($file in $annotationFiles | Sort-Object Name) {
        Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
        
        try {
            $annotations = Get-Content $file.FullName | ConvertFrom-Json
            $pageTitle = $annotations.pageName
            if (-not $pageTitle -and $annotations.document) {
                $pageTitle = $annotations.document.name
            }
            if (-not $pageTitle -and $annotations.name) {
                $pageTitle = $annotations.name
            }
            if (-not $pageTitle) {
                $pageTitle = $file.BaseName
            }
            
            # Process annotated nodes
            if ($annotations.annotatedNodes) {
                $pageComments = 0
                $content += "### Page $pageNum : $pageTitle"
                $content += ""
                
                foreach ($node in $annotations.annotatedNodes) {
                    $nodeName = $node.name
                    $nodeId = $node.nodeId
                    
                    if ($node.annotations -and $node.annotations.Count -gt 0) {
                        $content += "#### $nodeName"
                        $content += ""
                        $content += "- **Node ID:** ``$nodeId``"
                        $content += ""
                        
                        foreach ($annotation in $node.annotations) {
                            $label = if ($annotation.labelMarkdown) { $annotation.labelMarkdown } else { $annotation.label }
                            $category = ""
                            
                            if ($annotation.categoryId -and $annotations.categories) {
                                $cat = $annotations.categories | Where-Object { $_.id -eq $annotation.categoryId }
                                if ($cat) {
                                    $category = " *($($cat.label))*"
                                }
                            }
                            
                            $content += "**Comment:**$category"
                            $content += ""
                            $content += $label
                            $content += ""
                            $content += "---"
                            $content += ""
                            
                            $pageComments++
                            $totalComments++
                        }
                    }
                }
                
                if ($pageComments -eq 0) {
                    $content += "*No comments found on this page*"
                    $content += ""
                } else {
                    $content += "**Total comments on this page:** $pageComments"
                    $content += ""
                }
                
                $pageNum++
            }
        } catch {
            Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
            $content += "### Error processing $($file.Name)"
            $content += ""
            $content += "Error: $_"
            $content += ""
        }
    }
    
    $content += "## Summary"
    $content += ""
    $content += "- **Total Pages Processed:** $($pageNum - 1)"
    $content += "- **Total Comments:** $totalComments"
    $content += ""
}

$content += "---"
$content += ""
$content += "**Note:** This document is generated from Figma annotations."
$content += "**Update:** Re-run extraction and this script to update."

# Write document
$content | Set-Content -Path $OutputFile

Write-Host ""
Write-Host "Comments document created: $OutputFile" -ForegroundColor Green
if ($totalComments -gt 0) {
    Write-Host "Total comments processed: $totalComments" -ForegroundColor Cyan
}

