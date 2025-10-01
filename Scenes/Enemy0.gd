extends CharacterBody2D
class_name EnemyClass
@onready var tmr_stagger_recovery: Timer = $tmrStaggerRecovery

@export var enableGravity = false
@export var staggerResistance = 1
@export var physicalResistance = 0.75
@export var magicResistance = 0.9
@export var staggerRecoveryTime:float = 5.0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HP = 20

var xpValue = 5
var hp = 20
var facing = -1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var staggerMeter:int = 0
var isStaggered:bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() && enableGravity:
		velocity.y += gravity * delta

	if !isStaggered: 
		velocity.x = SPEED * facing
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func takeDamage(value, damageType = Global.DamageType.PHYSICAL, isStagger = false):
	match damageType:
		Global.DamageType.PHYSICAL:
			hp -= value * physicalResistance
		Global.DamageType.MAGIC:
			hp -= value * physicalResistance
	if isStagger: 
		staggerMeter += value
		verifyIfGotStaggered()
	
	Notifications.enemyGotHit("Enemy0", MAX_HP, hp)
	
	if hp <= 0:
		die()
		return true

func die():
	queue_free()

func verifyIfGotStaggered():
	if staggerMeter > staggerResistance:
		enableGravity = true
		isStaggered = true
		tmr_stagger_recovery.start(staggerRecoveryTime)

func _on_tmr_stagger_recovery_timeout() -> void:
	staggerRecoveryTime *= 0.5
	isStaggered = false
	enableGravity = false
