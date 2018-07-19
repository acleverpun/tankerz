extends Polygon2D

func _ready():
	print('ready: ' + self.name)

func onSelect():
	print('selected: ' + self.name)

func onDeselect():
	print('deselected: ' + self.name)
