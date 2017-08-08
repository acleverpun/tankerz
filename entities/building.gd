extends Polygon2D

signal select
signal deselect

onready var grid = preload("res://scripts/grid.gd")
onready var Unit = preload("res://entities/unit.tscn")

enum State { DEFAULT, SELECTED }
export(int, "DEFAULT", "SELECTED") var state = "DEFAULT"
export var selectedColor = Color(0, 255, 0)

var defaultColor

func _ready():
	defaultColor = self.get_color()
	get_node("label").set_text(self.get_name())
	connect("select", self, "onSelect")
	connect("deselect", self, "onDeselect")

func onSelect():
	state = SELECTED
	self.set_color(selectedColor)
	var unit = Unit.instance()
	unit.position = self.position + grid.cellDown
	self.get_parent().add_child(unit)
	self.emit_signal("deselect")

func onDeselect():
	state = DEFAULT
	self.set_color(defaultColor)
