import godot, node
import label, packed_scene, polygon_2d, resource_loader
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

  proc select*() {.gdExport.} =
    state = State.selected
    self.color = selectedColor

    let Unit = load("res://entities/unit.tscn") as PackedScene
    var unit = Unit.instance() as Node2d
    unit.position = self.position + grid.cellDown
    self.getParent().addChild(unit)

    self.deselect()

  proc deselect*() {.gdExport.} =
    state = State.default
    self.color = defaultColor
