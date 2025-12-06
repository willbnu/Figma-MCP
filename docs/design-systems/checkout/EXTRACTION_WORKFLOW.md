# Complete Extraction Workflow - Checkout Design System

Step-by-step process to extract ALL data from the Checkout Design System file.

## Prerequisites

- ✅ WebSocket server running on port 3055
- ✅ Figma plugin connected
- ✅ Channel: See `scripts/config/channel-config.ps1` (currently: `6g9hvye9`)
- ✅ Cursor with MCP Figma server loaded

## Step 1: Join Channel

**Command in Cursor:**
```
Join the Figma channel [current channel from config]
```

**Expected Result:**
- Channel joined successfully
- Log: `[Figma] [Channel] Joined: k7z1rmsr`

**Copy the full response here:**
```
[Paste response]
```

---

## Step 2: Get Document Information

**Command in Cursor:**
```
Get information about the current Figma document
```

**What to Capture:**
- Document name
- Document ID
- All pages (names and IDs)
- Page structure
- Sections
- Total component count
- Total style count

**Copy the full JSON response here:**
```json
[Paste JSON response]
```

---

## Step 3: Get All Components

**Command in Cursor:**
```
Get all local components in the document
```

**What to Capture:**
- Component names
- Component keys
- Component IDs
- Component types
- Variants (if any)
- Properties
- Component descriptions

**Copy the full JSON response here:**
```json
[Paste JSON response]
```

---

## Step 4: Get All Styles

**Command in Cursor:**
```
Get all styles in the document
```

**What to Capture:**
- Color styles (names, values, IDs, keys)
- Text styles (names, fonts, sizes, weights, IDs, keys)
- Effect styles (shadows, blurs, IDs, keys)
- Grid styles (if any)

**Copy the full JSON response here:**
```json
[Paste JSON response]
```

---

## Step 5: Get Current Selection

**Command in Cursor:**
```
What is currently selected in Figma?
```

**What to Capture:**
- Selected node IDs
- Selected node types
- Selected node names

**Copy the full JSON response here:**
```json
[Paste JSON response]
```

---

## Step 6: Read Current Design (if selection exists)

**Command in Cursor:**
```
Read the current design selection in Figma
```

**What to Capture:**
- Node tree structure
- Component relationships
- Style usage

**Copy the full JSON response here:**
```json
[Paste JSON response]
```

---

## Step 7: Scan for Checkout-Specific Elements

If you have page or frame IDs, get detailed info:

**For each checkout-related page/frame:**
```
Get information about node [node-id]
```

**What to Look For:**
- Components with "checkout" in name
- Components with "payment" in name
- Components with "cart" in name
- Components with "order" in name
- Components with "billing" in name
- Components with "shipping" in name
- Components with "address" in name
- Components with "form" in name

---

## Data Organization

After collecting all data, I will:

1. **Extract Components:**
   - List all checkout-related components
   - Document component properties and variants
   - Map component relationships
   - Update `components.md`

2. **Extract Styles:**
   - Organize color tokens
   - Document text styles
   - List effect styles
   - Update `styles.md`

3. **Extract Structure:**
   - Document page hierarchy
   - List sections and frames
   - Map organization
   - Update `structure.md`

4. **Document Relationships:**
   - Component usage patterns
   - Style usage patterns
   - Update `usage-examples.md`

5. **Update Summary:**
   - Statistics
   - Overview
   - Update `README.md`

---

## Quick Command List

Copy and paste these commands one at a time in Cursor:

```
Join the Figma channel [current channel from config]
```

```
Get information about the current Figma document
```

```
Get all local components in the document
```

```
Get all styles in the document
```

```
What is currently selected in Figma?
```

```
Read the current design selection in Figma
```

---

**After running all commands, provide the responses and I'll create complete documentation.**

