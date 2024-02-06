extends CharacterBody2D

@onready var dash_timer = $DashTimer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var level = 0
var xp = 0
var stamina = 100
var maxJumps = 2
var jumps = 0
var maxDashes = 1
var dashes = 0
var dashDuration = 5

#states
var isDashing = false
var directionVector = Vector2()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	directionVector = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	directionVector = directionVector.normalized()
	
	if !directionVector.x && is_on_floor():
		endDash()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	elif dash_timer.is_stopped():
		isDashing = false
	
	if jumps > 0 && is_on_floor():
		land()

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump()
			
	# Handle dash.
	if Input.is_action_just_pressed("dash") && !isDashing && dash_timer.is_stopped():
		dash()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	elif directionVector.x:
		if isDashing:
			velocity.x = directionVector.x * SPEED * 4
		else:
			velocity.x = directionVector.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func dash():
	if dashes < maxDashes:
		isDashing = true
		dash_timer.start(0.1)
		if !is_on_floor():
			dashes += 1

func jump():
	if !is_on_floor():
		isDashing = false
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumps += 1
	elif maxJumps > jumps:
		velocity.y = JUMP_VELOCITY / 1.2
		jumps += 1

func endDash():
	isDashing = false

func _on_dash_timer_timeout():
	if is_on_floor():
		endDash()

func land():
	jumps = 0
	dashes = 0
