import godot, node
import
  area_2d,
  label,
  packed_scene,
  polygon_2d,
  resource_loader
import ./utils/grid as grid

type State {.pure.} = enum
  default, selected

gdobj Building of Area2d:
  var selectedColor {.gdExport.} = initColor(0, 0, 255)
  var state {.gdExport.}: State = State.default

  var Unit = load("res://entities/unit.tscn") as PackedScene
  var polygon: Polygon2d
  var defaultColor: Color

  method ready*() =
    polygon = self.getNode("polygon") as Polygon2d
    defaultColor = polygon.color
    getNode("label").as(Label).text = self.getName()

  proc select*() {.gdExport.} =
    state = State.selected
    polygon.color = selectedColor

    var unit = Unit.instance() as Node2d
    unit.position = self.position + grid.cellDown
    self.getParent().addChild(unit)

    self.deselect()

  proc deselect*() {.gdExport.} =
    state = State.default
    polygon.color = defaultColor
