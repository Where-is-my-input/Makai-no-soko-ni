extends CharacterBody2D
@onready var moves: Node = $moves

var currentAttack = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if currentAttack == null:
		currentAttack = moves.moves.pick_random()
		currentAttack.action()

	move_and_slide()
