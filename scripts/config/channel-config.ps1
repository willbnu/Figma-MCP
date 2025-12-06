# Centralized Channel Configuration
# Change the channel here and it updates everywhere

# Current Figma Channel
$script:FigmaChannel = "7bz4h1up"

# Get channel function
function Get-FigmaChannel {
    return $script:FigmaChannel
}

# Make channel available to parent scope
Set-Variable -Name FigmaChannel -Value $script:FigmaChannel -Scope Script

