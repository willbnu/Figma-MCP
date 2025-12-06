# MCP Figma Server - Complete Functions Reference

This document provides a quick reference for all available MCP functions.

## Quick Index

- [Document & Selection](#document--selection)
- [Creating Elements](#creating-elements)
- [Modifying Elements](#modifying-elements)
- [Styling](#styling)
- [Auto Layout & Spacing](#auto-layout--spacing)
- [Annotations](#annotations)
- [Prototyping & Connections](#prototyping--connections)
- [Components & Styles](#components--styles)
- [Scanning & Analysis](#scanning--analysis)
- [Export](#export)
- [Connection Management](#connection-management)

---

## Document & Selection

### `get_document_info`
Get detailed information about the current Figma document.

**No parameters**

**Returns:** Document information including pages, components, styles, etc.

---

### `get_selection`
Get information about the currently selected elements in Figma.

**No parameters**

**Returns:** Array of selected nodes with their IDs and basic information.

---

### `read_my_design`
Get detailed node information about the current selection without parameters.

**No parameters**

**Returns:** Complete node tree of the selected element(s).

---

### `get_node_info`
Get detailed information about a specific node.

**Parameters:**
- `nodeId` (string, required): The ID of the node

**Returns:** Complete node information including properties, children, styles, etc.

---

### `get_nodes_info`
Get detailed information about multiple nodes.

**Parameters:**
- `nodeIds` (array of strings, required): Array of node IDs

**Returns:** Array of node information objects.

---

### `set_focus`
Set focus on a specific node by selecting it and scrolling viewport to it.

**Parameters:**
- `nodeId` (string, required): The ID of the node to focus on

---

### `set_selections`
Set selection to multiple nodes and scroll viewport to show them.

**Parameters:**
- `nodeIds` (array of strings, required): Array of node IDs to select

---

## Creating Elements

### `create_rectangle`
Create a new rectangle in Figma.

**Parameters:**
- `x` (number, required): X position
- `y` (number, required): Y position
- `width` (number, required): Width
- `height` (number, required): Height
- `name` (string, optional): Name for the rectangle
- `parentId` (string, optional): Parent node ID

---

### `create_frame`
Create a new frame with optional auto-layout properties.

**Required Parameters:**
- `x`, `y`, `width`, `height` (numbers): Position and size

**Optional Parameters:**
- `name` (string): Frame name
- `parentId` (string): Parent node ID
- `fillColor` (object): `{r, g, b, a}` RGBA color (0-1)
- `strokeColor` (object): `{r, g, b, a}` RGBA color
- `strokeWeight` (number): Stroke weight
- `layoutMode` (enum): "NONE" | "HORIZONTAL" | "VERTICAL"
- `layoutWrap` (enum): "NO_WRAP" | "WRAP"
- `paddingTop`, `paddingRight`, `paddingBottom`, `paddingLeft` (numbers)
- `primaryAxisAlignItems` (enum): "MIN" | "MAX" | "CENTER" | "SPACE_BETWEEN"
- `counterAxisAlignItems` (enum): "MIN" | "MAX" | "CENTER" | "BASELINE"
- `layoutSizingHorizontal`, `layoutSizingVertical` (enum): "FIXED" | "HUG" | "FILL"
- `itemSpacing` (number): Distance between children

**Note:** When `primaryAxisAlignItems` is "SPACE_BETWEEN", `itemSpacing` is ignored.

---

### `create_text`
Create a new text element.

**Required Parameters:**
- `x`, `y` (numbers): Position
- `text` (string): Text content

**Optional Parameters:**
- `fontSize` (number): Font size (default: 14)
- `fontWeight` (number): Font weight (default: 400)
- `fontColor` (object): `{r, g, b, a}` RGBA color
- `name` (string): Semantic layer name
- `parentId` (string): Parent node ID

---

## Modifying Elements

### `set_text_content`
Set the text content of an existing text node.

**Parameters:**
- `nodeId` (string, required): The ID of the text node
- `text` (string, required): New text content

---

### `set_multiple_text_contents`
Batch update multiple text nodes efficiently.

**Parameters:**
- `nodeId` (string, required): Parent node ID containing text nodes
- `text` (array, required): Array of `{nodeId: string, text: string}` objects

**Processes in batches of 5 for large operations.**

---

### `move_node`
Move a node to a new position.

**Parameters:**
- `nodeId` (string, required): The ID of the node
- `x`, `y` (numbers, required): New position

---

### `resize_node`
Resize a node.

**Parameters:**
- `nodeId` (string, required): The ID of the node
- `width`, `height` (numbers, required): New dimensions

---

### `clone_node`
Create a copy of an existing node.

**Parameters:**
- `nodeId` (string, required): The ID of the node to clone
- `x`, `y` (numbers, optional): New position for the clone

---

### `delete_node`
Delete a node.

**Parameters:**
- `nodeId` (string, required): The ID of the node to delete

---

### `delete_multiple_nodes`
Delete multiple nodes at once.

**Parameters:**
- `nodeIds` (array of strings, required): Array of node IDs to delete

---

## Styling

### `set_fill_color`
Set the fill color of a node (works with TextNode or FrameNode).

**Parameters:**
- `nodeId` (string, required): The ID of the node
- `r`, `g`, `b` (numbers, required, 0-1): RGB components
- `a` (number, optional, 0-1): Alpha component (default: 1)

---

### `set_stroke_color`
Set the stroke color and weight of a node.

**Parameters:**
- `nodeId` (string, required): The ID of the node
- `r`, `g`, `b` (numbers, required, 0-1): RGB components
- `a` (number, optional, 0-1): Alpha component (default: 1)
- `weight` (number, optional): Stroke weight (default: 1)

---

### `set_corner_radius`
Set the corner radius of a node.

**Parameters:**
- `nodeId` (string, required): The ID of the node
- `radius` (number, required): Corner radius value
- `corners` (array of 4 booleans, optional): Which corners to round `[topLeft, topRight, bottomRight, bottomLeft]` (default: all true)

---

## Auto Layout & Spacing

### `set_layout_mode`
Set the layout mode and wrap behavior of a frame.

**Parameters:**
- `nodeId` (string, required): The ID of the frame
- `layoutMode` (enum, required): "NONE" | "HORIZONTAL" | "VERTICAL"
- `layoutWrap` (enum, optional): "NO_WRAP" | "WRAP" (default: "NO_WRAP")

---

### `set_padding`
Set padding values for an auto-layout frame.

**Parameters:**
- `nodeId` (string, required): The ID of the frame
- `paddingTop`, `paddingRight`, `paddingBottom`, `paddingLeft` (numbers, optional): Padding values

---

### `set_axis_align`
Set primary and counter axis alignment for auto-layout frames.

**Parameters:**
- `nodeId` (string, required): The ID of the frame
- `primaryAxisAlignItems` (enum, optional): "MIN" | "MAX" | "CENTER" | "SPACE_BETWEEN"
- `counterAxisAlignItems` (enum, optional): "MIN" | "MAX" | "CENTER" | "BASELINE"

**Note:** When `primaryAxisAlignItems` is "SPACE_BETWEEN", `itemSpacing` is ignored.

---

### `set_layout_sizing`
Set horizontal and vertical sizing modes for auto-layout frames.

**Parameters:**
- `nodeId` (string, required): The ID of the frame
- `layoutSizingHorizontal` (enum, optional): "FIXED" | "HUG" | "FILL"
- `layoutSizingVertical` (enum, optional): "FIXED" | "HUG" | "FILL"

**Note:** 
- HUG works for frames/text only
- FILL works for auto-layout children only

---

### `set_item_spacing`
Set distance between children in an auto-layout frame.

**Parameters:**
- `nodeId` (string, required): The ID of the frame
- `itemSpacing` (number, optional): Distance between children
- `counterAxisSpacing` (number, optional): Distance between wrapped rows/columns (only works when `layoutWrap` is "WRAP")

**Note:** `itemSpacing` is ignored when `primaryAxisAlignItems` is "SPACE_BETWEEN".

---

## Annotations

### `get_annotations`
Get all annotations in the current document or specific node.

**Parameters:**
- `nodeId` (string, optional): Node ID to get annotations for
- `includeCategories` (boolean, optional): Include category information (default: true)

---

### `set_annotation`
Create or update an annotation with markdown support.

**Required Parameters:**
- `nodeId` (string): The ID of the node to annotate
- `labelMarkdown` (string): The annotation text in markdown format

**Optional Parameters:**
- `annotationId` (string): The ID of the annotation to update (if updating)
- `categoryId` (string): The ID of the annotation category
- `properties` (array): Additional properties `[{type: string}]`

---

### `set_multiple_annotations`
Batch create/update multiple annotations efficiently.

**Parameters:**
- `nodeId` (string, required): The ID of the parent node
- `annotations` (array, required): Array of annotation objects:
  ```typescript
  {
    nodeId: string;
    labelMarkdown: string;
    categoryId?: string;
    annotationId?: string;
    properties?: Array<{type: string}>;
  }
  ```

**Processes in batches of 5.**

---

## Prototyping & Connections

### `get_reactions`
Get all prototype reactions from nodes with visual highlight animation.

**Parameters:**
- `nodeIds` (array of strings, required): Array of node IDs to get reactions from

**Important:** After using this, you MUST use the `reaction_to_connector_strategy` prompt to generate parameters for `create_connections`.

---

### `set_default_connector`
Set a copied FigJam connector as the default connector style.

**Parameters:**
- `connectorId` (string, optional): The ID of the connector node

**Note:** 
- Must be set before creating connections
- Can be called without `connectorId` to check if a default connector is already set
- If no default connector exists, user must manually copy a connector from FigJam first

---

### `create_connections`
Create FigJam connector lines between nodes.

**Parameters:**
- `connections` (array, required): Array of connection objects:
  ```typescript
  {
    startNodeId: string;
    endNodeId: string;
    text?: string;  // Optional text to display on connector
  }
  ```

**Prerequisites:**
1. Must have a default connector set (use `set_default_connector`)
2. If no default connector exists, copy a connector from FigJam, paste it, select it, then call `set_default_connector` with the connector ID

---

## Components & Styles

### `get_styles`
Get information about local styles in the document.

**No parameters**

**Returns:** Array of style information (colors, text styles, effects, etc.)

---

### `get_local_components`
Get information about local components in the document.

**No parameters**

**Returns:** Array of component information with keys, names, and properties.

---

### `create_component_instance`
Create an instance of a component.

**Parameters:**
- `componentKey` (string, required): Key of the component to instantiate
- `x`, `y` (numbers, required): Position

---

### `get_instance_overrides`
Extract override properties from a selected component instance.

**Parameters:**
- `nodeId` (string, optional): Optional ID of the component instance (if not provided, currently selected instance will be used)

**Returns:** Override information that can be applied to other instances.

---

### `set_instance_overrides`
Apply extracted overrides to target instances.

**Parameters:**
- `sourceInstanceId` (string, required): ID of the source component instance
- `targetNodeIds` (array of strings, required): Array of target instance IDs

**Note:** Target instances will be swapped to the source component and all copied override properties will be applied.

---

## Scanning & Analysis

### `scan_text_nodes`
Scan text nodes with intelligent chunking for large designs.

**Parameters:**
- `nodeId` (string, required): ID of the node to scan

**Returns:** All text nodes found in the selected node, processed in chunks for large designs.

**Features:**
- Automatic chunking for large designs
- Progress updates during scanning
- Returns complete text node information including IDs, content, and properties

---

### `scan_nodes_by_types`
Scan for nodes with specific types.

**Parameters:**
- `nodeId` (string, required): ID of the node to scan
- `types` (array of strings, required): Array of node types to find (e.g., `['COMPONENT', 'FRAME', 'INSTANCE']`)

**Returns:** Array of matching nodes with their IDs, names, types, and bounding boxes.

**Common Use Cases:**
- Finding annotation targets
- Locating component instances
- Identifying specific element types

---

## Export

### `export_node_as_image`
Export a node as an image.

**Parameters:**
- `nodeId` (string, required): The ID of the node to export
- `format` (enum, optional): "PNG" | "JPG" | "SVG" | "PDF" (default: "PNG")
- `scale` (number, optional): Export scale (default: 1)

**Returns:** Base64 encoded image data (currently returned as text).

---

## Connection Management

### `join_channel`
Join a specific channel to communicate with Figma.

**Parameters:**
- `channel` (string, required): The name of the channel to join

**Important:** 
- You MUST join a channel before using any other commands
- The channel name is displayed in the Figma plugin panel
- Each Figma plugin session creates a unique channel

---

## MCP Prompts (Helper Strategies)

The server also includes several helper prompts to guide complex design tasks:

### `design_strategy`
Best practices for working with Figma designs, including naming conventions, layout hierarchy, and element creation guidelines.

### `read_design_strategy`
Best practices for reading Figma designs, focusing on selection and analysis.

### `text_replacement_strategy`
Systematic approach for replacing text in Figma designs, including chunking strategies and verification methods.

### `annotation_conversion_strategy`
Strategy for converting manual annotations to Figma's native annotations, including matching algorithms and batch processing.

### `swap_overrides_instances`
Strategy for transferring overrides between component instances, including extraction and application steps.

### `reaction_to_connector_strategy`
Strategy for converting Figma prototype reactions to connector lines, including filtering, transformation, and connection creation.

---

## Color Format

All color parameters use RGBA format with values between 0 and 1:

```typescript
{
  r: number,  // 0-1
  g: number,  // 0-1
  b: number,  // 0-1
  a: number   // 0-1 (optional, default: 1)
}
```

**Examples:**
- Red: `{r: 1, g: 0, b: 0, a: 1}`
- Blue (50% opacity): `{r: 0, g: 0, b: 1, a: 0.5}`
- White: `{r: 1, g: 1, b: 1, a: 1}`
- Black: `{r: 0, g: 0, b: 0, a: 1}`

---

## Error Handling

All functions can throw exceptions. Common errors include:

- **"Not connected to Figma"**: WebSocket server not running or not connected
- **"Must join a channel before sending commands"**: Need to call `join_channel` first
- **"Request to Figma timed out"**: Operation took too long or connection lost
- **"Connection closed"**: WebSocket connection was lost

Always handle errors appropriately in your workflows.

---

## Performance Tips

1. **Use batch operations** for multiple items (e.g., `set_multiple_text_contents` instead of multiple `set_text_content` calls)
2. **Scan before modifying** to understand structure
3. **Use chunking** for large designs (built into `scan_text_nodes` and batch operations)
4. **Verify changes** with `get_node_info` after modifications
5. **Export selectively** - use appropriate scale values to avoid large image data

---

**Last Updated:** Based on cursor-talk-to-figma-mcp v0.3.5

