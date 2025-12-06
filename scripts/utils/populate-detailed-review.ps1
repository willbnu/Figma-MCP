# Populate Detailed Review
# Adds detailed component and style information to the review

$extractDir = "docs/design-systems/checkout/extracted-data"
$reviewFile = "docs/design-systems/checkout/COMPLETE_REVIEW.md"

Write-Host "=== Populating Detailed Review ===" -ForegroundColor Cyan
Write-Host ""

# Load data
$docInfo = Get-Content "$extractDir/02-document-info.json" | ConvertFrom-Json
$components = Get-Content "$extractDir/03-components.json" | ConvertFrom-Json
$styles = Get-Content "$extractDir/04-styles.json" | ConvertFrom-Json

# Get component list
$compList = if ($components.components) { $components.components } else { $components }

# Get actual count - prioritize count field
$compCount = if ($components.count -and $components.count -gt 0) { $components.count } elseif ($compList -and $compList.Count -gt 0) { $compList.Count } else { 0 }

Write-Host "Processing $compCount components..." -ForegroundColor Yellow
Write-Host "Processing styles..." -ForegroundColor Yellow

# Read existing review
$reviewLines = Get-Content $reviewFile

# Find insertion points
$newContent = @()
$insertedComponents = $false
$insertedStyles = $false

foreach ($line in $reviewLines) {
    $newContent += $line
    
    # Insert component details
    if ($line -match "\[To be populated with detailed component information\]" -and -not $insertedComponents) {
        $newContent += ""
        $newContent += "### Component Details"
        $newContent += ""
        $newContent += "Total Components: **$compCount**"
        $newContent += ""
        
        # Group components by category
        $checkoutComps = @()
        $otherComps = @()
        
        foreach ($comp in $compList) {
            $name = $comp.name
            if ($name -match "checkout|payment|cart|order|billing|shipping|address|card|form|button|Checkout|Payment|Cart|Order|Billing|Shipping|Address|Card|Form|Button") {
                $checkoutComps += $comp
            } else {
                $otherComps += $comp
            }
        }
        
        if ($checkoutComps.Count -gt 0) {
            $newContent += "#### Checkout-Related Components ($($checkoutComps.Count))"
            $newContent += ""
            $shown = 0
            foreach ($comp in $checkoutComps) {
                if ($shown -lt 50) {
                    $newContent += "- **$($comp.name)**"
                    $newContent += "  - ID: ``$($comp.id)``"
                    $newContent += "  - Key: ``$($comp.key)``"
                    $newContent += ""
                    $shown++
                }
            }
            if ($checkoutComps.Count -gt 50) {
                $newContent += "*... and $($checkoutComps.Count - 50) more checkout-related components*"
                $newContent += ""
            }
        }
        
        $insertedComponents = $true
    }
    
    # Insert style details
    if ($line -match "\[To be populated with detailed style information\]" -and -not $insertedStyles) {
        $newContent += ""
        $newContent += "### Style Details"
        $newContent += ""
        
        if ($styles.colors -and $styles.colors.Count -gt 0) {
            $newContent += "#### Colors ($($styles.colors.Count))"
            $newContent += ""
            foreach ($color in $styles.colors) {
                $newContent += "- **$($color.name)**"
                $newContent += "  - ID: ``$($color.id)``"
                $newContent += "  - Key: ``$($color.key)``"
                $newContent += ""
            }
        }
        
        if ($styles.effects -and $styles.effects.Count -gt 0) {
            $newContent += "#### Effects ($($styles.effects.Count))"
            $newContent += ""
            foreach ($effect in $styles.effects) {
                $newContent += "- **$($effect.name)**"
                $newContent += "  - ID: ``$($effect.id)``"
                $newContent += "  - Key: ``$($effect.key)``"
                $newContent += ""
            }
        }
        
        if ($styles.texts -and $styles.texts.Count -gt 0) {
            $newContent += "#### Text Styles ($($styles.texts.Count))"
            $newContent += ""
            foreach ($text in $styles.texts) {
                $newContent += "- **$($text.name)**"
                $newContent += "  - ID: ``$($text.id)``"
                $newContent += "  - Key: ``$($text.key)``"
                $newContent += ""
            }
        }
        
        $insertedStyles = $true
    }
}

# Write updated review
$newContent | Set-Content -Path $reviewFile

Write-Host "Detailed review populated!" -ForegroundColor Green
Write-Host "Checkout components: $($checkoutComps.Count)" -ForegroundColor Cyan
Write-Host "Total styles documented: $($styles.colors.Count + $styles.effects.Count + $styles.texts.Count)" -ForegroundColor Cyan
