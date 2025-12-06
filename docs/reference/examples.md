# Usage Examples

Practical examples for using the MCP Figma server.

## Basic Examples

### Reading Document Information

```
Get information about the current Figma document
```

Returns document structure, pages, and basic metadata.

### Getting Current Selection

```
What is currently selected in Figma?
```

Returns information about selected elements.

### Reading Design Selection

```
Read the current design selection in Figma
```

Returns detailed node tree of selected elements.

## Creating Elements

### Create a Simple Button

```
Create a rectangle at position (100, 100) with size 200x50 named "Button"
```

### Create a Frame with Auto-Layout

```
Create a vertical auto-layout frame at (0, 0) with size 400x600, padding 20px, and 16px spacing
```

### Create Text Element

```
Create text "Hello World" at position (50, 50) with font size 24 and bold weight
```

## Modifying Elements

### Update Text Content

```
Update the text in node [node-id] to "New Text"
```

### Move Element

```
Move node [node-id] to position (200, 300)
```

### Resize Element

```
Resize node [node-id] to 300x200
```

## Styling

### Set Fill Color

```
Set fill color of node [id] to red (1, 0, 0, 1)
```

### Set Stroke

```
Set stroke color of node [id] to blue with weight 2
```

### Round Corners

```
Set corner radius of node [id] to 8
```

## Advanced Examples

### Bulk Text Replacement

1. Select a frame containing text nodes
2. Ask: "Replace all text in the selected frame with new content"
3. The system will:
   - Scan all text nodes using `scan_text_nodes`
   - Use `set_multiple_text_contents` to update them in batches
   - Provide progress updates

### Creating a Login Screen

```
Create a login screen with email and password fields
```

The system will:
- Create a main frame
- Add input containers
- Create text labels
- Style elements appropriately

### Converting Prototype Reactions

1. Select nodes with prototype connections
2. Ask: "Convert prototype reactions to connector lines"
3. The system will:
   - Use `get_reactions` to extract prototype flows
   - Check/set default connector with `set_default_connector`
   - Generate connections using `create_connections`

### Applying Component Overrides

1. Select a component instance with desired overrides
2. Ask: "Apply these overrides to other instances"
3. The system will:
   - Use `get_instance_overrides` to extract overrides
   - Use `set_instance_overrides` to apply to target instances

## Workflow Examples

### Design Analysis Workflow

1. Get document overview: `get_document_info`
2. Get current selection: `get_selection`
3. Read design details: `read_my_design`
4. Analyze structure and components

### Design Modification Workflow

1. Join channel: `join_channel`
2. Get document info: `get_document_info`
3. Select target elements: `set_selections`
4. Modify elements: Use appropriate modification functions
5. Verify changes: `get_node_info`

### Batch Operation Workflow

1. Scan for targets: `scan_text_nodes` or `scan_nodes_by_types`
2. Prepare batch data
3. Execute batch operation: `set_multiple_text_contents`, etc.
4. Verify results

## Best Practices

1. **Always join channel first** before any operations
2. **Start with document overview** to understand structure
3. **Use batch operations** for multiple items
4. **Verify changes** after modifications
5. **Handle errors** appropriately

## Additional Resources

- **Functions:** [Functions Reference](functions.md)
- **Tutorial:** [Complete Tutorial](../guides/tutorial.md)
- **API:** [API Documentation](api.md)

---

**Need more examples?** Check the [Complete Tutorial](../guides/tutorial.md) for detailed walkthroughs.

