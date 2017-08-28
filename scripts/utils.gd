static func isClick(event, button = 1):
	return (
			event is InputEventMouseButton and
			event.button_index == button and
			event.is_pressed()
	)
