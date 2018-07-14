extends Polygon2D

onready var parent = get_parent()

func onSelect():
	print('selected building')

func onDeselect():
	print('deselected building')
