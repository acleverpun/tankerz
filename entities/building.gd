extends Polygon2D

func _ready():
	$selectable.connect('select', self, 'onSelect')
	$selectable.connect('deselect', self, 'onDeselect')

func onSelect():
	print('building selected')

func onDeselect():
	print('building deselected')
