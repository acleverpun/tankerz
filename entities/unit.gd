extends Polygon2D

signal select
signal deselect
signal move(targetPos)

onready var grid = preload("res://scripts/grid.gd")

enum State { DEFAULT, SELECTED }
export(int, "DEFAULT", "SELECTED") var state = "DEFAULT"
export var selectedColor = Color(0, 255, 0)
export(Vector2) var nextPos
export var maxSpeed = 4.0
export var path = PoolVector2Array()

var defaultColor

func _ready():
	defaultColor = self.get_color()
	get_node("label").set_text(self.get_name())
	connect("select", self, "onSelect")
	connect("deselect", self, "onDeselect")
	connect("move", self, "onMove")

func _fixed_process(delta):
	if not nextPos and path.size():
		nextPos = path[0]
		path.remove(0)
	if nextPos != null:
		self.position += (nextPos - self.position).normalized() * maxSpeed
		if self.position == nextPos: nextPos = null

func onSelect():
	state = SELECTED
	print("select")
	self.set_color(selectedColor)

func onDeselect():
	state = DEFAULT
	print("deselect")
	self.set_color(defaultColor)

func onMove(targetPos):
	print("move")
	if nextPos: return

	print("moving")
	path.resize(0)
	path.append(self.position)
	var lastVec = self.position

	while lastVec != targetPos:
		lastVec += grid.toCardinal(targetPos - lastVec) * grid.cellSize
		path.append(lastVec)
