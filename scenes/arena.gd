extends Node2D

var utils = preload('res://scripts/utils.gd')

enum ModeName { SELECT, MOVE, MARKET, INTROSPECT }

export(ModeName) var modeName

onready var modes = {
	'select': load('res://modes/select.gd'),
	'move': load('res://modes/move.gd'),
	'market': load('res://modes/market.gd'),
	'introspect': load('res://modes/introspect.gd')
}

signal click
signal altClick

var mode

func _ready():
	switchMode(ModeName.SELECT)

func switchMode(name):
	match name:
		SELECT: mode = modes.select
		MOVE: mode = modes.move
		MARKET: mode = modes.market
		INTROSPECT: mode = modes.introspect
	modeName = name
	mode = mode.new()

	if mode.has_method('onClick'): connect('click', mode, 'onClick')
	if mode.has_method('onAltClick'): connect('altClick', mode, 'onAltClick')

func _input(event):
	if utils.isClick(event): emit_signal('click', event.get_position(), self)
	elif utils.isClick(event, 2): emit_signal('altClick', event.get_position(), self)
	elif Input.is_action_just_pressed('quit'): get_tree().quit()
