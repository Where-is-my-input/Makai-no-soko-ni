extends Node
const DEBUGGER = preload("res://system/debugger.tscn")

signal setHpBar
signal hitstop

signal debugToggleVcMode
signal debugZoomIn
signal debugZoomOut

var debugSpeed:float = 300.0
var debugJumpSpeed:float = -1400.0

var stage:Node2D = null
var combo:int = 0

enum DamageType {
	PHYSICAL,
	MAGIC
	#STAGGER
}

func _ready() -> void:
	add_child(DEBUGGER.instantiate())
	hitstop.connect(setHitstop)

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	elif event.is_action_pressed("windowMode"):
		if DisplayServer.window_get_mode() == 0:
			DisplayServer.window_set_mode(3)
		else:
			DisplayServer.window_set_mode(0)

func setHitstop(hitstopAmount:float = 10.0):
	#if stage != null:
	#stage.set_process(false)
	#stage.set_physics_process(false)
	get_tree().paused = true
	#process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(hitstopAmount).timeout
	#process_mode = Node.PROCESS_MODE_ALWAYS
	#stage.set_process(true)
	#stage.set_physics_process(true)
	get_tree().paused = false
