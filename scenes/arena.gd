extends Node2D

onready var utils = preload('res://scripts/utils.gd')

var selected

func _input(event):
	if utils.isClick(event):
		var point = event.get_position()
		var nodes = get_children()

		for node in nodes:
			if not node.has_node('selectable'): break

			if utils.hasPoint(node, point):
				if selected == node: return
				if selected: selected.get_node('selectable').deselect()
				if node.get_node('selectable').toggle():
					selected = node
				break
	elif utils.isClick(event, 2):
		if selected: selected.get_node('selectable').deselect()
		selected = null
	elif Input.is_action_just_pressed('quit'):
		get_tree().quit()
