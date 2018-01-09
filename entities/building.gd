extends Polygon2D

onready var Menu = load('res://entities/gui/menu.tscn')
onready var menu = Menu.instance()
onready var parent = get_parent()
onready var units = $units.get_children()

func _ready():
	for unit in units:
		$units.remove_child(unit)

func spawn(unit):
	var newUnit = unit.duplicate()
	newUnit.set_visible(true)
	newUnit.position += Vector2(0, 16)
	parent.add_child(newUnit)

func openMenu():
	add_child(menu)
	menu.populate(units)

func closeMenu(): remove_child(menu)

func onSelect(): openMenu()
func onDeselect(): closeMenu()

func onMenuSelect(unit):
	spawn(unit)
	# TODO: rethink having arena manage selection state
	# $selectable.deselect()
	closeMenu()
