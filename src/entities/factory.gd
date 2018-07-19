extends Polygon2D

onready var parent = get_parent()

const units = {
	unit = preload('unit.tscn')
}

func onSelect():
	print('selected: ' + name)
	spawn('unit')

func onDeselect():
	print('deselected: ', self.name)

func spawn(name):
	var unit = units[name].instance()
	unit.set_visible(true)
	unit.position = self.position + Vector2(0, 16)
	parent.add_child(unit)
