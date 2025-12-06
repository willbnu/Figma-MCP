# Extracted Data - Checkout Design System

This folder contains raw JSON data extracted from Figma.

## Files

Save extracted JSON responses here:

- `01-channel-join.json` - Channel join response
- `02-document-info.json` - Document information (REQUIRED)
- `03-components.json` - All components (REQUIRED)
- `04-styles.json` - All styles (REQUIRED)
- `05-selection.json` - Current selection (optional)

## How to Extract

1. Run `.\scripts\utils\extract-checkout-automated.ps1` for instructions
2. Use MCP commands in Cursor chat to get data
3. Save JSON responses to this folder
4. Run `.\scripts\utils\process-extracted-data.ps1` to process

## Processing

After saving all JSON files, the processing script will:
- Parse document structure
- Extract checkout components
- Organize styles
- Generate documentation

---

**Note:** Keep raw JSON files here for reference and re-processing.


