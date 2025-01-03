extends CharacterBody2D

@export var direction:Vector2 = Vector2(1, 1)

func _physics_process(delta: float) -> void:
	velocity = direction
	move_and_slide()
