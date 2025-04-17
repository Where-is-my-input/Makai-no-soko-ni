extends Node
const DEBUGGER = preload("res://system/debugger.tscn")

signal setHpBar
signal hitstop

signal debugToggleVcMode
signal debugZoomIn
signal debugZoomOut

var stage:Node2D = null

func _ready() -> void:
	add_child(DEBUGGER.instantiate())
	hitstop.connect(setHitstop)

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://Scenes/system/debug.tscn")
	elif event.is_action_pressed("windowMode"):
		if DisplayServer.window_get_mode() == 0:
			DisplayServer.window_set_mode(3)
		else:
			DisplayServer.window_set_mode(0)

func setHitstop(hitstopAmount:float = 10.0):
	if stage != null:
		#stage.set_process(false)
		#stage.set_physics_process(false)
		get_tree().paused = true
		#process_mode = Node.PROCESS_MODE_DISABLED
		print(hitstopAmount)
		await get_tree().create_timer(hitstopAmount).timeout
		print("timeout")
		#process_mode = Node.PROCESS_MODE_ALWAYS
		#stage.set_process(true)
		#stage.set_physics_process(true)
		get_tree().paused = false
