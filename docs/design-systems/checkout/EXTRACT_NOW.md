# Extract Checkout Design System - Commands

Run these commands in Cursor chat to extract all data.

## Channel

See `scripts/config/channel-config.ps1` or run:
```powershell
. scripts/config/channel-config.ps1; Get-FigmaChannel
```

Current: `6g9hvye9`

## Commands (Run in Order)

1. **Join Channel**
```
Join the Figma channel [see CHANNEL.md for current]
```

2. **Get Document Info**
```
Get information about the current Figma document
```

3. **Get All Components**
```
Get all local components in the document
```

4. **Get All Styles**
```
Get all styles in the document
```

5. **Get Selection**
```
What is currently selected in Figma?
```

## After Running Commands

Copy the JSON output from each command and provide it. I'll extract:
- All components (names, IDs, keys, variants, properties)
- All styles (colors, text styles, effects)
- Document structure (pages, sections, frames)
- Component relationships

---

**Ready to extract real data - no templates, only truth.**

