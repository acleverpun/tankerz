import godot, node
import
  input,
  input_event,
  shape,
  canvas_item,
  polygon_2d,
  input_event_mouse_button,
  packed_scene,
  scene_tree
import ./utils/grid as grid

proc isClick(event: InputEventMouseButton, button = 1): bool =
  return event.buttonIndex() == button and event.pressed()

proc isClick(event: InputEvent, button = 1): bool =
  if not (event of InputEventMouseButton): return false
  return isClick(event as InputEventMouseButton, button)

type Selectable = concept node
  node is Node2d
  node.select()
  node.deselect()

type Movable = concept node
  node is Node2d
  node.move(Vector2)

gdobj Arena of Node2d:
  var entities: Node
  var isSelected = false
  var selectedNode: Node2d

  method ready*() =
    entities = getNode("entities")

  method unhandledInput(event: InputEvent) =
    if isActionJustPressed("quit"):
      print "process"
      getTree().quit()

    if event of InputEventMouseButton:
      let mouseEvent = event as InputEventMouseButton
      if isClick(mouseEvent):
        for node in entities.getChildren():
          if not node.hasMethod("select"): continue

          var node2d: Node2d = node.asObject(Polygon2d)
          var rect: Rect2 = node2d.getItemRect().grow(-20)
          rect.position = node2d.position

          if rect.contains(mouseEvent.position):
            selectNode(node2d)
            return
        # if isSelected and selectedNode is Movable: moveNode(selectedNode as Movable, mouseEvent.position)
      elif isClick(mouseEvent, 2):
        deselectNode()

  proc selectNode(node: Node2d) =
    if not node.hasMethod("move"): return
    var isSameNode = (node == selectedNode)
    deselectNode()
    if isSameNode: return
    selectedNode = node
    isSelected = true
    # node.select()

  proc deselectNode() =
    isSelected = false
    selectedNode = nil

  proc moveNode(node: Movable, position: Vector2) =
    if not node.hasMethod("move"): return
    let alignedPosition = grid.align(position - grid.cellDim / 2)
    node.move(alignedPosition)
