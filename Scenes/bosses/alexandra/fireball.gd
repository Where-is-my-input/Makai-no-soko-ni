extends Node
const ALEX_FIREBALL = preload("res://Scenes/bosses/alexandra/alex_fireball.tscn")

@export var speed:float = 2000

func _ready() -> void:
	set_physics_process(false)

func action():
	set_physics_process(true)
	var parent = get_parent()
	parent.ap.play("fireball")
	parent.body.velocity -= Vector2(4500 * parent.body.facing, 1500)

func fire():
	var parent = get_parent()
	var fireball = ALEX_FIREBALL.instantiate()
	add_child(fireball)
	fireball.global_position = parent.body.global_position
	fireball.direction = Vector2(200 * parent.body.facing, 0)
	var dir = (parent.body.player.global_position - fireball.global_position).normalized()
	fireball.global_rotation = dir.angle() + PI / 2.0
	fireball.global_rotation = dir.angle() + PI / 2.0
	fireball.direction = fireball.global_position.direction_to(parent.body.player.body.global_position) * Vector2(speed, speed)

func _physics_process(delta: float) -> void:
	if get_parent().body.velocity.y > 0:
		fire()
		set_physics_process(false)
