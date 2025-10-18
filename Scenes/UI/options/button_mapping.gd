extends Control
@onready var tmr_map: Timer = $tmrMap
@export var deviceId:int = -1
@onready var lbl_axis_value: Label = $VBoxContainer/lblAxisValue
@onready var lbl_notice: Label = $VBoxContainer/lblNotice

@export var array = ["jump", "dash", "attack", "block"]
var globalInputs = ["ui_down","ui_left","ui_up","ui_right","ui_accept","ui_cancel"]
var remapping = false
var currentAction = ""

func _ready():
	print(Input.get_connected_joypads())
	print(Input.get_joy_name(0))

func _input(event):
	if event is InputEventJoypadMotion: lbl_axis_value.text = str(event.axis_value)
	if remapping && tmr_map.is_stopped():
		if event is InputEventKey || event is InputEventJoypadButton:
			if event.pressed:
				remmapEvent(event)
				remapping = false
		elif event is InputEventJoypadMotion:
			if event.axis_value == 1:
				remmapEvent(event)
				remapping = false
		

func remmapEvent(event):
	InputMap.action_erase_events(currentAction)
	InputMap.action_add_event(currentAction, event)
	print(currentAction, " - set to - ", event)
	lbl_notice.text = str(currentAction) + " - set to - " + str(event)


func setDevice(id):
	if deviceId < 0:
		deviceId = id
	elif id < 0:
		deviceId = id

func _on_btn_jump_pressed() -> void:
	#currentAction = "jump"
	currentAction = "ui_accept"
	setRemapping()

func _on_btn_dash_pressed() -> void:
	#currentAction = "dash"
	currentAction = "ui_cancel"
	setRemapping()

func _on_btn_attack_pressed() -> void:
	currentAction = "attack"
	setRemapping()

func _on_btn_block_pressed() -> void:
	currentAction = "block"
	setRemapping()

func setRemapping():
	remapping = true
	tmr_map.start(0.5)

func _on_btn_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu/main_menu.tscn")
