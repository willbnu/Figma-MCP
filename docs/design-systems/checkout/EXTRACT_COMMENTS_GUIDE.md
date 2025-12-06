# Guide: Extracting All Comments from All Pages

This guide explains how to extract all comments/annotations from all pages in the Figma design system file.

## Overview

Figma annotations (comments) are attached to specific nodes (components, frames, etc.), not to pages or sections. To get all comments from all pages, you need to collect annotations from each page.

## Method 1: Get Annotations from Current Page (Recommended)

1. **Navigate to each page in Figma**
2. **In Cursor, run the MCP command:**
   ```
   get_annotations (without nodeId parameter)
   ```
   This will return all annotations from the currently active page in Figma.

3. **Save the JSON response** to:
   ```
   docs/design-systems/checkout/extracted-data/annotations-page-[N].json
   ```
   Where `[N]` is the page number (1, 2, 3, etc.)

4. **Repeat for all pages** in the document

5. **Process all annotation files:**
   ```powershell
   .\scripts\utils\process-comments.ps1
   ```

## Method 2: Get Annotations from Specific Nodes

If you know specific nodes that have annotations:

1. **Get the node ID** from Figma (right-click → Copy ID, or use `get_selection`)

2. **In Cursor, run:**
   ```
   get_annotations with nodeId: [node-id]
   ```

3. **Save the JSON response** to an annotation file

## Current Status

**Comments Extracted:** 5 comments from current page

**Files:**
- `extracted-data/annotations-all.json` - Current annotations
- `ALL_COMMENTS.md` - Processed comments document

## Next Steps

To get comments from ALL pages:

1. Navigate to each page in Figma
2. Run `get_annotations` (without nodeId) for each page
3. Save each result to a separate JSON file
4. Run `process-comments.ps1` to generate the complete document

## Annotation File Format

Save annotation JSON files with this naming pattern:
- `annotations-page-1.json`
- `annotations-page-2.json`
- `annotations-page-3.json`
- etc.

Or use descriptive names:
- `annotations-inputs-forms.json`
- `annotations-dividers-masks.json`
- etc.

The processing script (`scripts/utils/process-comments.ps1`) uses the JSON `pageName` (when present) or the file name as the page heading, so name files clearly.

## Processing Script

The `process-comments.ps1` script will:
- Find all `*annotation*.json` files in `extracted-data/`
- Process each file
- Generate a comprehensive `ALL_COMMENTS.md` document
- Group comments by page
- Include node IDs, categories, and full comment text

## Example Workflow

```powershell
# 1. Extract annotations from Figma (in Cursor chat)
# Run: get_annotations (for each page)

# 2. Save JSON responses to extracted-data/

# 3. Process all annotations
.\scripts\utils\process-comments.ps1

# 4. View the results
code docs/design-systems/checkout/ALL_COMMENTS.md
```

---

**Note:** The `get_annotations` command without a nodeId gets all annotations from the currently active page in Figma. Make sure you're on the correct page before running the command.

