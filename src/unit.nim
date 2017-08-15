import godot, node
import polygon_2d, label
import ./utils/grid as grid

type State {.pure.} = enum
  default, selected

gdobj Unit of Polygon2D:
  var selectedColor {.gdExport.} = initColor(0, 255, 0)
  var maxSpeed {.gdExport.} = 4.0

  var defaultColor: Color
  var isMoving = false
  var nextPos: Vector2
  var path = PoolVector2Array()
  var state: State = State.default

  method ready*() =
    defaultColor = self.color
    getNode("label").as(Label).text = self.getName()

  method fixedProcess*(dt: float64) =
    if not isMoving and path.len() > 0:
      nextPos = path[0]
      path.delete(0)
      isMoving = true
    if isMoving:
      self.position = self.position + (nextPos - self.position).normalized() * maxSpeed
      if self.position == nextPos: isMoving = false

  proc select*() {.gdExport.} =
    state = State.selected
    self.color = selectedColor

  proc deselect*() {.gdExport.} =
    state = State.default
    self.color = defaultColor

  proc move*(target: Vector2) {.gdExport.} =
    path.setLen(min(path.len(), 1))
    path.add(self.position)

    var lastPos = self.position
    while lastPos != target:
      lastPos = lastPos + grid.toCardinal(target - lastPos) * grid.cellSize
      path.add(lastPos)
