extends CharacterBody2D

@export var enableGravity = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var hp = 20
var facing = -1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() && enableGravity:
		velocity.y += gravity * delta

	velocity.x = SPEED * facing

	move_and_slide()

func takeDamage(value):
	hp -= value
	if hp <= 0:
		die()

func die():
	queue_free()
