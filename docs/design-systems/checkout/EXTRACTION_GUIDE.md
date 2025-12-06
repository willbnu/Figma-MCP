# Extraction Guide - Checkout Design System

Step-by-step guide to extract information from the "Checkout — Design System — Master File" in Figma.

## Prerequisites

- ✅ WebSocket server running on port 3055
- ✅ Figma plugin connected
- ✅ Channel: See `scripts/config/channel-config.ps1` (currently: `6g9hvye9`)
- ✅ Cursor with MCP Figma server loaded

## Extraction Steps

### Step 1: Join Channel

In Cursor, run:
```
Join the Figma channel [current channel from config]
```

Or use the function:
```
mcp_TalkToFigma_join_channel with channel: "[current channel from config]"
```

**Expected Log:**
```
[Figma] [Channel] Joined: [current channel]
```

### Step 2: Get Document Information

```
Get information about the current Figma document
```

**What to capture:**
- Document name
- All pages (especially "Checkout" related pages)
- Page IDs
- Section structure

**Expected Log:**
```
[Figma] [Get] Document info: {document name} ({page count} pages)
```

### Step 3: Get All Components

```
Get all local components in the document
```

**What to capture:**
- Total component count
- Component names containing "checkout", "payment", "cart", "order"
- Component keys and IDs
- Component properties and variants

**Expected Log:**
```
[Figma] [Get] Components: {count} found
```

### Step 4: Get All Styles

```
Get all styles in the document
```

**What to capture:**
- Color styles
- Text styles
- Effect styles (shadows, etc.)
- Style IDs and keys

**Expected Log:**
```
[Figma] [Get] Styles: {count} colors, {count} text styles, {count} effects
```

### Step 5: Scan for Checkout Components

If you have a specific page or frame ID, scan for components:

```
Scan for components with checkout in the name
```

Or use:
```
Scan nodes by types for checkout-related components
```

### Step 6: Get Detailed Component Information

For each checkout component found, get detailed info:

```
Get information about component [component-id]
```

**What to capture:**
- Component structure
- Variants and properties
- Usage context
- Related components

## Data to Extract

### Components
- Component name
- Component key
- Component ID
- Variants (if any)
- Properties
- Usage description

### Styles
- Color tokens (name, value, usage)
- Text styles (name, font, size, weight)
- Effects (name, type, properties)

### Structure
- Page names and IDs
- Section organization
- Frame hierarchy
- Component relationships

## Documentation Update Process

1. **Extract data** using the steps above
2. **Update components.md** with component details
3. **Update styles.md** with style information
4. **Update structure.md** with page/frame structure
5. **Update usage-examples.md** with patterns found
6. **Update README.md** with summary statistics

## Logging Format

All extractions should be logged:
```
[Figma] [Get] Document info: {name}
[Figma] [Get] Components: {count} found
[Figma] [Get] Styles: {count} found
[Figma] [Get] Component {id}: {details}
```

## Quick Commands Reference

```bash
# Join channel
Join the Figma channel [current channel from config]

# Get document info
Get information about the current Figma document

# Get components
Get all local components in the document

# Get styles
Get all styles in the document

# Get selection
What is currently selected in Figma?

# Read design
Read the current design selection in Figma
```

---

**Channel:** See `scripts/config/channel-config.ps1`
**Last Updated:** [Date]

