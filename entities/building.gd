extends Polygon2D

onready var selectable = get_node("selectable")

func _ready():
	selectable.connect("select", self, "onSelect")
	selectable.connect("deselect", self, "onDeselect")

func onSelect():
	print("selected")

func onDeselect():
	print("deselected")
