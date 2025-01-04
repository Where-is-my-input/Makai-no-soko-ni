extends CharacterBody2D

@export var direction:Vector2 = Vector2(20, 0)

func _physics_process(delta: float) -> void:
	velocity = direction
	move_and_slide()

func _on_a_2d_hitbox_body_entered(body: Node2D) -> void:
	queue_free()
