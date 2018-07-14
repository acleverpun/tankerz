const utils = preload('res://src/utils.gd')

var selected

func onClick(point, scene):
	var nodes = scene.get_children()

	for node in nodes:
		if not node.has_node('selectable'): break

		if utils.hasPoint(node, point):
			if selected == node: return
			if selected: selected.get_node('selectable').deselect()
			if node.get_node('selectable').toggle():
				selected = node
			break

func onAltClick(point, scene):
	if selected: selected.get_node('selectable').deselect()
	selected = null
