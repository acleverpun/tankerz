extends Polygon2D

func _ready():
	$selectable.connect('select', self, 'onSelect')
	$selectable.connect('deselect', self, 'onDeselect')

func onSelect():
	print(get_name() + ' selected')

func onDeselect():
	print(get_name() + ' deselected')
