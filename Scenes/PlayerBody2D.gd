extends CharacterBody2D

@export var vc:VirtualControllerClass = null

@onready var dash_timer = $DashTimer
@onready var hitbox = $Hitbox
@onready var animatedTree = $AnimationPlayer/AnimationTree
@onready var A_State = "parameters/Transition/transition_request"
@onready var level_system: level_system = $components/level_system
@onready var double_jump_lockout: Timer = $doubleJumpLockout
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal updateHealth

const SPEED = 300.0
const JUMP_VELOCITY = -1200.0
var facing = -1

var maxJumps = 2
var jumps = 0
var maxDashes = 1
var dashes = 0
var dashDuration = 5

#status
var stamina:int = 100
var attack:int = 10
var defense:int = 1
var maxHp:int = 10
var hp:int = 10

#states
var isDashing = false
var directionVector = Vector2()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hitstun:int = 0
var aIdle = "idle"

func _ready():
	animatedTree.set_deferred("active", true)
	updateHealth.emit(hp)
	level_system.levelUp.connect(levelUp)

func _physics_process(delta):
	if hitstun <= 0:
		var directionVector = vc.direction#.normalized()
		if vc.attack:
			aIdle = "attack"
		elif vc.block:
			aIdle = "block"
		
		if directionVector.x != 0:
			setFacing(vc.direction.x)
		
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
		if vc.jump && double_jump_lockout.is_stopped():
			jump()
		# Handle dash.
		if vc.dash && !isDashing && dash_timer.is_stopped():
			dash()
		elif (vc.isDashHeld || !is_on_floor()) && isDashing:
			velocity.x = facing * (abs(velocity.x / SPEED) + SPEED) * 4
		elif directionVector.x:
			velocity.x = directionVector.x * SPEED
			isDashing = false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		hitstun -= 1
		if hitstun <= 0:
			returnToIdle()
	move_and_slide()
	setAnimation()

func setAnimation():
		animatedTree.set(A_State, aIdle)

func dash():
	if dashes < maxDashes:
		isDashing = true
		dash_timer.start(0.5)
		if !is_on_floor():
			dashes += 1

func jump(cancelDash = true):
	if !is_on_floor() && cancelDash:
		isDashing = false
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumps += 1
		double_jump_lockout.start(0.2)
	elif maxJumps > jumps && double_jump_lockout.is_stopped():
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
		Global.hitstop.emit(0.15)
		level_system.gainXP(body.xpValue * 0.1)
		if body.takeDamage(attack):
			level_system.gainXP(body.xpValue)

func _on_block_box_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		body.queue_free()

func returnToIdle():
	stopDash()
	aIdle = "idle"
	setAnimation()

func stopDash():
	dashes = 0
	endDash()
	dash_timer.stop()

func getHit(damage = 1, knockback = true, knockbackDir = Vector2(2000, -500)):
	hitstun = 15
	if knockback: getKnockedback(knockbackDir)
	hp -= damage
	updateHealth.emit(hp)
	if hp <= 0:
		death()

func death():
	print("Dead")

func getKnockedback(knockbackDir = Vector2(20, -20)):
	velocity = Vector2(knockbackDir.x * facing * -1, knockbackDir.y)

func levelUp(newLevel):
	stamina = level_system.getStamina()
	attack = level_system.getAttack()
	defense = level_system.getDefense()
	maxHp = level_system.getHP()
	hp = maxHp
