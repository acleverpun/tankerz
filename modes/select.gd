var utils = preload('res://scripts/utils.gd')

var selected

func onClick(point, arena):
	var nodes = arena.get_children()

	for node in nodes:
		if not node.has_node('selectable'): break

		if utils.hasPoint(node, point):
			if selected == node: return
			if selected: selected.get_node('selectable').deselect()
			if node.get_node('selectable').toggle():
				selected = node
			break

func onAltClick(point, arena):
	if selected: selected.get_node('selectable').deselect()
	selected = null
