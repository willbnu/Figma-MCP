# Extraction Status

Current status of Checkout Design System data extraction.

## Channel

**Current Channel:** `7bz4h1up`  
**Config Location:** `scripts/config/channel-config.ps1`

## Extraction Status

### Required Files

- [ ] `02-document-info.json` - Document information
- [ ] `03-components.json` - All components
- [ ] `04-styles.json` - All styles

### Optional Files

- [ ] `01-channel-join.json` - Channel join confirmation
- [ ] `05-selection.json` - Current selection

## Extraction Commands

Run these in Cursor chat (channel: `7bz4h1up`):

1. **Join Channel:**
   ```
   Join the Figma channel 7bz4h1up
   ```

2. **Get Document Info:**
   ```
   Get information about the current Figma document
   ```
   Save to: `extracted-data/02-document-info.json`

3. **Get All Components:**
   ```
   Get all local components in the document
   ```
   Save to: `extracted-data/03-components.json`

4. **Get All Styles:**
   ```
   Get all styles in the document
   ```
   Save to: `extracted-data/04-styles.json`

## Generate Review

Once all required files are saved, run:

```powershell
.\scripts\utils\create-complete-review.ps1
```

This will generate `COMPLETE_REVIEW.md` with all extracted data.

---

**Last Updated:** [Auto-updated when extraction runs]

