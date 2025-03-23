extends Control
@onready var flow_container: FlowContainer = $FlowContainer

@export var stages:Array[PackedScene]
const STAGE_BUTTON = preload("res://Scenes/UI/stage_select/stage_button.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var currentStage = 1
	for s in stages:
		var button = STAGE_BUTTON.instantiate()
		button.stage = s.resource_path
		button.text = str(currentStage)
		button.stageId = currentStage
		#button.cleared = Global.stagesCleared[currentStage] == 1
		flow_container.add_child(button)
		#if currentStage == Global.currentStage + 1: button.grab_focus()
		currentStage += 1
