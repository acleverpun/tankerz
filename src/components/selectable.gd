extends Node

signal select
signal deselect

export var selected = false

onready var parent = get_parent()

func _ready():
	if parent.has_method('onSelect'): connect('select', parent, 'onSelect')
	if parent.has_method('onDeselect'): connect('deselect', parent, 'onDeselect')

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
	if selected == true: return deselect()
	return select()
