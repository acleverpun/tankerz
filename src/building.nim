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
    getNode("label").as(Label).text = self.getName()

    self.addUserSignal("select", newArray())
    self.addUserSignal("deselect", newArray())

    discard self.connect("select", self, "on_select", newArray())
    discard self.connect("deselect", self, "on_deselect", newArray())

  proc onSelect*() {.gdExport.} =
    print("select")
    state = State.selected
    self.color = defaultColor

  proc onDeselect*() {.gdExport.} =
    print("deselect")
    state = State.default
    self.color = defaultColor
