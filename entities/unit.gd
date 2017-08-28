extends Polygon2D

onready var movable = get_node("movable")

func _ready():
	movable.connect("move", self, "onMove")

func onMove():
	print("unit moved")
