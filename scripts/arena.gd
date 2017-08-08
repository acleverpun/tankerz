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
			if not has_user_signal(node, "select"): continue
			var rect = (node.get_item_rect().grow(-20))
			rect.position = node.position
			if rect.has_point(event.position): return selectNode(node)
		if selectedNode and has_user_signal(selectedNode, "move"): moveNode(selectedNode, event.position)
	elif isClick(event, 2):
		deselectNode()

func deselectNode():
	if selectedNode: selectedNode.emit_signal("deselect")
	selectedNode = null

func selectNode(node):
	var isSameNode = (node == selectedNode)
	deselectNode()
	if isSameNode: return
	selectedNode = node
	node.emit_signal("select")

func moveNode(node, newPosition):
	var alignedPosition =  grid.align(newPosition - grid.cellDim / 2)
	node.emit_signal("move", alignedPosition)

static func isClick(event, button = 1):
	return (
		event is InputEventMouseButton and
		event.button_index == button and
		event.is_pressed()
	)

static func has_user_signal(node, signalName):
	return node.get_signal_connection_list(signalName).size() > 0
