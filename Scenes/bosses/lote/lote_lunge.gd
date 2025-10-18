extends Node

func _ready() -> void:
	stop()

func action():
	var parent = get_parent()
	lunge()
	parent.ap.play("lunge")

func lunge():
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	var parent = get_parent()
	parent.body.velocity.x = parent.body.facing * 1100
	if parent.get_parent().is_on_wall(): stop()

func stop():
	set_physics_process(false)
	var animPlayer = get_parent().ap
	animPlayer.play("idle")
	animPlayer.get_parent()._on_ap_animation_finished("lunge")
