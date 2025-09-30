extends Node2D
const PLAYER = preload("uid://c5euaw5jcse1y")
const VIRTUAL_CONTROLLER = preload("uid://rc3aggfpupcw")
@onready var spawn: Node2D = $spawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p = PLAYER.instantiate()
	var vc = VIRTUAL_CONTROLLER.instantiate()
	p.vc = vc
	p.global_position = spawn.global_position
	add_child(p)
	add_child(vc)
