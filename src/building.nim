import godot, node
import polygon_2d, label
import ./utils/grid as grid

type State {.pure.} = enum
  default, selected

gdobj Building of Polygon2D:
  var state {.gdExport.}: State = State.default
  var selectedColor {.gdExport.} = initColor(0, 0, 255)

  var defaultColor: Color

  method ready*() =
    defaultColor = self.color
    cast[Label](getNode("label")).text = self.getName()

    let selfObj = cast[Object](self)

    selfObj.addUserSignal("select", newArray())
    selfObj.addUserSignal("deselect", newArray())

    discard selfObj.connect("select", selfObj, "onSelect", newArray())
    discard selfObj.connect("deselect", selfObj, "onDeselect", newArray())

  proc onSelect*() {.gdExport.} =
    print("select")
    state = State.selected
    self.color = defaultColor

  proc onDeselect*() {.gdExport.} =
    print("deselect")
    state = State.default
    self.color = defaultColor
