extends Node

signal move

export var isMoving = false

onready var parent = get_parent()
onready var selectable = parent.get_node("selectable")

func _ready():
	selectable.connect("select", self, "onSelect")
	selectable.connect("deselect", self, "onDeselect")

func move():
	emit_signal("move")

func onSelect():
	print("movable selected")
	move()

func onDeselect():
	print("movable deselected")
