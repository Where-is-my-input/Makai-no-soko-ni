extends Node

func action():
	var parent = get_parent()
	parent.ap.play("lunge")

func lunge():
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	var parent = get_parent()
	parent.body.velocity.x = parent.body.facing * 500

func stop():
	set_physics_process(false)
