extends Node

signal select
signal deselect

export var selected = false

onready var utils = preload('res://scripts/utils.gd')
onready var parent = get_parent()

func _ready():
	if parent.has_method('onSelect'): self.connect('select', parent, 'onSelect')
	if parent.has_method('onDeselect'): self.connect('deselect', parent, 'onDeselect')

func select():
	if not selected:
		selected = true
		emit_signal('select')
	return selected

func deselect():
	if selected:
		selected = false
		emit_signal('deselect')
	return selected

func toggle():
	if selected == true:
		return deselect()
	else:
		return select()
