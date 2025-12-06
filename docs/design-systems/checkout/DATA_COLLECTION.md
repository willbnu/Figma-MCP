# Data Collection - Checkout Design System

Use this document to collect data from Figma, then I'll help organize it into the documentation.

## Current Connection

- **Channel:** See `scripts/config/channel-config.ps1` (currently: `6g9hvye9`)
- **Port:** 3055
- **MCP Config:** Official npm package

## Commands to Run in Cursor

### Step 1: Join Channel
```
Join the Figma channel [current channel from config]
```

### Step 2: Get Document Information
```
Get information about the current Figma document
```

**Paste the result here:**
```json
[Paste document info JSON here]
```

### Step 3: Get All Components
```
Get all local components in the document
```

**Paste the result here:**
```json
[Paste components JSON here]
```

### Step 4: Get All Styles
```
Get all styles in the document
```

**Paste the result here:**
```json
[Paste styles JSON here]
```

### Step 5: Get Current Selection (if applicable)
```
What is currently selected in Figma?
```

**Paste the result here:**
```json
[Paste selection JSON here]
```

## Checkout-Specific Data

### Components to Identify
Look for components with names containing:
- checkout
- payment
- cart
- order
- billing
- shipping
- address
- card
- form

### Pages to Document
- Checkout pages
- Payment pages
- Order pages
- Form pages

### Styles to Capture
- Colors used in checkout UI
- Text styles for forms
- Effects (shadows, borders)
- Spacing tokens

## After Collecting Data

Once you've collected the data:
1. Paste it in this file or provide it to me
2. I'll organize it into the documentation files
3. Update components.md, styles.md, structure.md
4. Create usage examples

---

**Ready to collect data?** Run the commands above in Cursor and paste the results!

