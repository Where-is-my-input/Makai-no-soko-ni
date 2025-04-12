extends Node

var nextFrame = false
@onready var lbl_igt: Label = $CanvasLayer/Container/VBoxContainer/lblIgt

#func _ready():
	#if Global.gameMode != Global.mode.TRAINING:
		#queue_free()

func setHUD():
	lbl_igt.text = str(InGameTimer.time)

func _process(_delta):
	setHUD()
	if Input.is_action_just_pressed("Debug"):
		Global.debugToggleVcMode.emit()
		
	if Input.is_action_just_pressed("ZoomIn"):
		Global.debugZoomIn.emit()
		
	if Input.is_action_just_pressed("ZoomOut"):
		Global.debugZoomOut.emit()
	
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
	if get_tree().paused == false and nextFrame == true:
		get_tree().paused = true

	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			get_tree().paused = true
		elif get_tree().paused == true:
			nextFrame = false
			get_tree().paused = false
	
	if Input.is_action_just_pressed("frameAdvance"):
		if get_tree().paused == false:
			get_tree().paused = true
		nextFrame = true
		get_tree().paused = false
