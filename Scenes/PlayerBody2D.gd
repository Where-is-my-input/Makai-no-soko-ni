extends CharacterBody2D

@onready var dash_timer = $DashTimer
@onready var hitbox = $Hitbox
@onready var animatedTree = $AnimationPlayer/AnimationTree
@onready var A_State = "parameters/Transition/transition_request"

const SPEED = 300.0
const JUMP_VELOCITY = -1200.0
var facing = -1

var level = 0
var xp = 0
var stamina = 100
var maxJumps = 2
var jumps = 0
var maxDashes = 1
var dashes = 0
var dashDuration = 5

var damage = 10
var hp:int = 10

#states
var isDashing = false
var directionVector = Vector2()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animatedTree.set_deferred("active", true)

func _physics_process(delta):
	directionVector = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	directionVector = directionVector.normalized()
	
	if Input.is_action_just_pressed("attack0"):
		animatedTree.set(A_State, "attack")
	elif Input.is_action_just_pressed("block"):
		animatedTree.set(A_State, "block")
	
	if directionVector.x != 0:
		setFacing(directionVector.x)
	
	if !directionVector.x && !is_on_floor():
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
	elif (Input.get_action_strength("dash") > 0 || !is_on_floor()) && isDashing:
			#velocity.x = facing * SPEED * 4
			velocity.x = facing * (abs(velocity.x / SPEED) + SPEED) * 4
	elif directionVector.x:
		velocity.x = directionVector.x * SPEED
		isDashing = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func dash():
	if dashes < maxDashes:
		isDashing = true
		dash_timer.start(0.5)
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

func setFacing(value):
	if facing != value:
		facing = value
		scale.x = -1

func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		body.takeDamage(damage)

func _on_block_box_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		body.queue_free()

func returnToIdle():
	animatedTree.set(A_State, "idle")

func getHit(damage = 1, knockback = true, knockbackDir = Vector2(2000, -500)):
	if knockback: getKnockedback(knockbackDir)
	hp -= damage
	if hp <= 0:
		death()

func death():
	print("Dead")

func getKnockedback(knockbackDir = Vector2(20, -20)):
	velocity = Vector2(knockbackDir.x, knockbackDir.y)
