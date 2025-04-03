extends Node
class_name VirtualControllerClass

@onready var tmr_jump: Timer = $tmrJump
@onready var tmr_attack: Timer = $tmrAttack
@onready var tmr_dash: Timer = $tmrDash
@onready var tmr_jump_release: Timer = $tmrJumpRelease
@onready var tmr_dash_release: Timer = $tmrDashRelease
@onready var tmr_block: Timer = $tmrBlock

@export var mode:int = 0

var direction:Vector2
var jump:bool
var jumpRelease:bool
var attack:bool
var block:bool
var dash:bool
var dashRelease:bool
var isDashHeld:bool

var inputBuffer:float = 0.15 #0.06 = 1f?

func _ready() -> void:
	Global.debugToggleVcMode.connect(toggleMode)

func toggleMode():
	mode = 1 if mode == 0 else 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	attack = actionPressed(attack, tmr_attack, "attack")
	block = actionPressed(block, tmr_block, "block")
	jump = actionPressed(jump, tmr_jump, "ui_accept")
	jumpRelease = actionReleased(jumpRelease, tmr_jump_release, "ui_accept")
	dash = actionPressed(dash, tmr_dash, "ui_cancel")
	isDashHeld = Input.is_action_pressed("ui_cancel")
	dashRelease = actionReleased(dashRelease, tmr_dash_release, "ui_cancel")

func actionPressed(action, timer, actionName):
	if mode == 0 && !action && Input.is_action_just_pressed(actionName) || mode == 1 && !action && Input.is_action_pressed(actionName):
		timer.start(inputBuffer)
		return true
	if !timer.is_stopped(): return true
	return false

func actionReleased(action, timer, actionName):
	if !action && Input.is_action_just_released(actionName):
		timer.start(inputBuffer)
		return true
	if !timer.is_stopped(): return true
	return false

func jumped():
	tmr_jump_release.stop()
	jumpRelease = false
	jump = false
	tmr_jump.stop()

func dashed():
	dashRelease = false
	tmr_dash_release.stop()
	dash = false
	tmr_dash.stop()
