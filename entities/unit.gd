extends Polygon2D

func _ready():
	$movable.connect('move', self, 'onMove')

func onMove(pos):
	print('unit moved: ', pos)
