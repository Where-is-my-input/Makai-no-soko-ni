extends Control

@export var vc:VirtualControllerClass = null
@onready var box: HBoxContainer = $box

func _init(virtualController):
	vc = virtualController

func _ready() -> void:
	pass
