extends Area2D

signal select
signal deselect

export var selected = false

onready var utils = preload("res://scripts/utils.gd")

func _input_event(viewport, event, index):
	if utils.isClick(event): toggle()
	elif selected and utils.isClick(event, 2): deselect()

func select():
	selected = true
	emit_signal("select")

func deselect():
	selected = false
	emit_signal("deselect")

func toggle():
	if selected == false: select()
	elif selected == true: deselect()
