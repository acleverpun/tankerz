extends Polygon2D

onready var Menu = load('res://entities/gui/menu.tscn')
onready var units = $units.get_children()

var menu

func _ready():
	for unit in units:
		$units.remove_child(unit)

func onSelect():
	menu = Menu.instance()
	add_child(menu)
	menu.populate(units)

func onDeselect():
	remove_child(menu)
	menu.free()
