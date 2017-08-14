extends Node2D

onready var grid = preload("res://scripts/grid.gd")

onready var entities = get_node("entities")

var selectedNode

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		return self.get_tree().quit()

func _unhandled_input(event):
	if isClick(event):
		for node in entities.get_children():
			if not node.has_method("select"): continue
			var rect = (node.get_item_rect().grow(-20))
			rect.position = node.position
			if rect.has_point(event.position): return selectNode(node)
		if selectedNode: moveNode(selectedNode, event.position)
	elif isClick(event, 2):
		deselectNode()

func selectNode(node):
	if not node.has_method("select"): return
	var isSameNode = (node == selectedNode)
	deselectNode()
	if isSameNode: return
	selectedNode = node
	node.select()

func deselectNode():
	if selectedNode and selectedNode.has_method("deselect"): selectedNode.deselect()
	selectedNode = null

func moveNode(node, newPosition):
	if not node.has_method("move"): return
	var alignedPosition = grid.align(newPosition - grid.cellDim / 2)
	node.move(alignedPosition)

static func isClick(event, button = 1):
	return (
		event is InputEventMouseButton and
		event.button_index == button and
		event.is_pressed()
	)
