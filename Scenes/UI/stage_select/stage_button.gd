extends Button

var stage:String
var stageId:int
var cleared:bool = false

func _ready() -> void:
	if cleared:
		modulate = Color.YELLOW

func _on_pressed() -> void:
	#Global.currentStage = stageId
	LoadManager.loadScene(stage)
