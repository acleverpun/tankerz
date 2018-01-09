extends Node

signal select
signal deselect

export var selected = false
export(Color) var selectedColor

onready var utils = preload('res://scripts/utils.gd')
onready var parent = get_parent()
onready var parentColor = parent.color

func _ready():
	if not selectedColor: selectedColor = parentColor.lightened(0.3)
	if parent.has_method('onSelect'): connect('select', parent, 'onSelect')
	if parent.has_method('onDeselect'): connect('deselect', parent, 'onDeselect')

func select():
	if not selected:
		selected = true
		parentColor = parent.color
		parent.color = selectedColor
		emit_signal('select')
	return selected

func deselect():
	if selected:
		selected = false
		parent.color = parentColor
		emit_signal('deselect')
	return selected

func toggle():
	if selected == true: return deselect()
	else: return select()
