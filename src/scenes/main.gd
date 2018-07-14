extends Node2D

signal click
signal altClick

const utils = preload('res://src/utils.gd')

enum Mode { SELECT }

var modes = {
	SELECT: preload('res://src/modes/select.gd'),
}

var mode

func _ready():
	switchMode(SELECT)

func _input(event):
	if utils.isClick(event): emit_signal('click', event.get_position(), self)
	elif utils.isClick(event, 2): emit_signal('altClick', event.get_position(), self)
	elif Input.is_action_just_pressed('game.quit'): get_tree().quit()

func switchMode(type):
	# TODO: return if switching to the same mode
	if mode:
		if mode.has_method('onClick'): disconnect('click', mode, 'onClick')
		if mode.has_method('onAltClick'): disconnect('altClick', mode, 'onAltClick')
		mode.free()

	mode = modes[type].new()

	if mode.has_method('onClick'): connect('click', mode, 'onClick')
	if mode.has_method('onAltClick'): connect('altClick', mode, 'onAltClick')
