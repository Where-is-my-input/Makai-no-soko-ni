extends CharacterBody2D


@export var speed = 300.0

var direction = -1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	if is_on_wall(): flip()


func _on_ground_detection_body_exited(body: Node2D) -> void:
	if is_on_floor():
		direction *= -1
		flip()

func flip():
	scale.x *= -1
