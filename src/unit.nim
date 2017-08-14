import godot, node
import polygon_2d, label
import ./utils/grid as grid

type State {.pure.} = enum
  default, selected

gdobj Unit of Polygon2D:
  var state {.gdExport.}: State = State.default
  var selectedColor {.gdExport.} = initColor(0, 255, 0)
  var nextPos {.gdExport.}: Vector2
  var maxSpeed {.gdExport.} = 4.0
  var path {.gdExport.} = PoolVector2Array()

  var defaultColor: Color

  method ready*() =
    defaultColor = self.color
    getNode("label").as(Label).text = self.getName()

  method fixedProcess*(dt: float64) =
    discard
    # if not nextPos and path.size():
    #   nextPos = path[0]
    #   path.remove(0)

  proc select*() {.gdExport.} =
    state = State.selected
    self.color = selectedColor

  proc deselect*() {.gdExport.} =
    state = State.default
    self.color = defaultColor

  proc move*(target: Vector2) {.gdExport.} =
    path.setLen(0)
    path.add(self.position)

    var lastPos = self.position
    while lastPos != target:
      lastPos = lastPos + grid.toCardinal(target - lastPos) * grid.cellSize
      path.add(lastPos)
