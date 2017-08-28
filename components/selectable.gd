extends Area2D

signal select
signal deselect

export var selected = false

func _input_event(viewport, event, index):
	if isClick(event): toggle()
	elif selected and isClick(event, 2): deselect()

func select():
	selected = true
	emit_signal("select")

func deselect():
	selected = false
	emit_signal("deselect")

func toggle():
	if selected == false: select()
	elif selected == true: deselect()

static func isClick(event, button = 1):
	return (
			event is InputEventMouseButton and
			event.button_index == button and
			event.is_pressed()
	)
