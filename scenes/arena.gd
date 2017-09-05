extends Node2D

onready var utils = preload("res://scripts/utils.gd")

func _input(event):
	if utils.isClick(event):
		print(event.get_position())
		var world = get_world_2d()
		var space = world.get_direct_space_state()
		var pos = event.get_position()
		print(space.intersect_point(pos).size())
	elif Input.is_action_just_pressed("quit"):
		get_tree().quit()
