import godot, node
import
  input,
  input_event,
  input_event_mouse_button,
  packed_scene,
  scene_tree
import ./utils/grid as grid

proc isClick(event: InputEvent, button = 1): bool =
  if not (event of InputEventMouseButton): return false
  let clickEvent = event as InputEventMouseButton
  return clickEvent.buttonIndex() == button and clickEvent.pressed()

type Movable = concept node
  node is Node2d
  node.move(Vector2)

gdobj Arena of Node2d:
  var entities: Node
  var selectedNode: Node2d

  method ready*() =
    entities = getNode("entities")

  method process(dt: float64) =
    if isActionJustPressed("quit"):
      print "process"
      getTree().quit()

  method unhandledInput(event: InputEvent) =
    if isClick(event):
      print("click")
    elif isClick(event, 2):
      print("right click")
      deselectNode()

  proc selectNode(node: Node) =
    discard

  proc deselectNode() =
    discard

  proc moveNode(node: Movable, position: Vector2) =
    if not node.hasMethod("move"): return
    let alignedPosition = grid.align(position - grid.cellDim / 2)
    node.move(alignedPosition)
