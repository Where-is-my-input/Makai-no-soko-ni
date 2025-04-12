extends Node
const DEBUGGER = preload("res://system/debugger.tscn")

signal setHpBar

signal debugToggleVcMode
signal debugZoomIn
signal debugZoomOut

func _ready() -> void:
	add_child(DEBUGGER.instantiate())

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://Scenes/system/debug.tscn")
	elif event.is_action_pressed("windowMode"):
		if DisplayServer.window_get_mode() == 0:
			DisplayServer.window_set_mode(3)
		else:
			DisplayServer.window_set_mode(0)
