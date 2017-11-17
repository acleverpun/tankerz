extends Node

signal select
signal deselect

export var selected = false

onready var utils = preload('res://scripts/utils.gd')

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
	if selected == false: return select()
	elif selected == true: return deselect()
