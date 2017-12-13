extends Node

signal move

export var isMoving = false

onready var utils = preload('res://scripts/utils.gd')

func _ready():
	$'../selectable'.connect('select', self, 'onSelect')
	$'../selectable'.connect('deselect', self, 'onDeselect')

func move(pos):
	emit_signal('move', pos)
	$'../selectable'.deselect()

func _unhandled_input(event):
	if $'../selectable'.selected and utils.isClick(event): move(event.get_position())

func onSelect():
	print('movable selected')

func onDeselect():
	print('movable deselected')
