extends Polygon2D

onready var parent = get_parent()

func onSelect():
	print('selected factory')

func onDeselect():
	print('deselected factory')
