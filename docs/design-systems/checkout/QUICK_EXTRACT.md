# Quick Extraction - Checkout Design System

Quick reference for extracting checkout design system data from Figma.

## Current Connection

- **Channel:** See `scripts/config/channel-config.ps1` (currently: `6g9hvye9`)
- **Port:** 3055
- **MCP Config:** Official npm package

## Quick Commands

Copy and paste these commands in Cursor:

### 1. Join Channel
```
Join the Figma channel [current from config]
```

### 2. Get Document Info
```
Get information about the current Figma document
```

### 3. Get All Components
```
Get all local components in the document
```

### 4. Get All Styles
```
Get all styles in the document
```

### 5. Get Current Selection
```
What is currently selected in Figma?
```

### 6. Read Current Design
```
Read the current design selection in Figma
```

## What to Look For

### In Document Info
- Pages with "Checkout" in the name
- Sections related to checkout
- Page IDs for checkout pages

### In Components
- Components with names containing:
  - "checkout"
  - "payment"
  - "cart"
  - "order"
  - "billing"
  - "shipping"

### In Styles
- Color tokens used in checkout
- Text styles for checkout forms
- Effects (shadows, borders) for checkout UI

## Documentation Files to Update

After extracting data, update:
1. `components.md` - Component details
2. `styles.md` - Style information
3. `structure.md` - Page/frame structure
4. `README.md` - Summary statistics

---

**See [EXTRACTION_GUIDE.md](EXTRACTION_GUIDE.md) for detailed steps.**

