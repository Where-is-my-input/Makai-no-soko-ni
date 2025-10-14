extends CharacterBody2D

@export var vc:VirtualControllerClass = null

@onready var dash_timer = $DashTimer
@onready var hitbox = $Hitbox
@onready var animatedTree = $AnimationPlayer/AnimationTree
@onready var A_State = "parameters/Transition/transition_request"
@onready var level_system: level_system = $components/level_system
@onready var crest_system: Node = $components/crest_system
@onready var double_jump_lockout: Timer = $doubleJumpLockout
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal updateHealth
signal updateStacks

var SPEED = 300.0
var JUMP_VELOCITY = -1400.0
var facing = -1

var maxJumps = 2
var jumps = 0
var maxDashes = 1
var dashes = 0
var dashDuration = 5
var canRun:bool = true

#stats
var stamina:int = 100
var attack:int = 10
var defense:int = 1
var maxHp:int = 10
var hp:int = 10
var stacks:int = 0

#states
var isDashing = false
var isBlocking = false
#var directionVector = Vector2()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hitstun:int = 0
var aIdle = "idle"

#TODO Separar a animation tree com states de movimento (idle, dash), pra definir golpes

func _ready():
	maxDashes = Inventory.dashes
	maxJumps = Inventory.jumps
	animatedTree.set_deferred("active", true)
	updateHealth.emit(hp)
	level_system.levelUp.connect(levelUp)

func _physics_process(delta):
	SPEED = Global.debugSpeed
	JUMP_VELOCITY = Global.debugJumpSpeed
	if hitstun <= 0:
		var directionVector = vc.direction#.normalized()
		if vc.attack:
			aIdle = "attack"
		elif vc.block:
			block()
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
		elif vc.jumpRelease:
			jumpRelease()
		var speedModified = crest_system.speedModifier(SPEED) #TODO create a function to set the modified speed when finishing equiping the crest
		if is_on_floor() && (isBlocking && aIdle == "block"):
				velocity.x = move_toward(velocity.x, 0, speedModified)
		else:
			if vc.dash && !isDashing && dash_timer.is_stopped():
				dash()
			#elif (vc.isDashHeld || !is_on_floor()) && isDashing:
			elif !is_on_floor() || isDashing:
				velocity.x = facing * (abs(velocity.x / speedModified) + speedModified) * 4
			elif directionVector.x:
				#TODO setup run startup
				velocity.x = directionVector.x * speedModified * 3 if canRun && vc.isDashHeld else directionVector.x * speedModified
				print(velocity)
				isDashing = false
			else:
				velocity.x = move_toward(velocity.x, 0, speedModified)
			
	else:
		hitstun -= 1
		if hitstun <= 0:
			returnToIdle()
	move_and_slide()
	setAnimation()

func setAnimation():
		animatedTree.set(A_State, aIdle)

func block():
	aIdle = "block"
	isBlocking = true

func dash():
	if dashes < maxDashes:
		isDashing = true
		aIdle = "dash"
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

func jumpRelease():
	if !is_on_floor() && velocity.y < 0:
		velocity.y = 0

func endDash():
	isDashing = false
	aIdle = "idle"

func _on_dash_timer_timeout():
	aIdle = "idle"
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
		hitEffects(body)

func _on_block_box_body_entered(body) -> void:
	if body.is_in_group("Projectile"):
		stacks += 1 #TODO body.attackPower or something like this
		updateStacks.emit(stacks)
		body.queue_free()
	elif body.is_in_group("Enemy"):
		hitEffects(body, 0.2, attack * 0.25, Global.DamageType.PHYSICAL, true)

func hitEffects(body, hitstop:float = 0.15, damageDealt:float = attack, damageType = Global.DamageType.PHYSICAL, isStagger = false):
	Global.hitstop.emit(hitstop)
	level_system.gainXP(crest_system.gainXP(body.xpValue * 0.1))
	damageDealt = crest_system.returnDamageDealt(damageDealt, 0) #TODO Combo counter
	Global.combo += 1
	if body.takeDamage(damageDealt, damageType, isStagger):
		level_system.gainXP(crest_system.gainXP(body.xpValue))
	

func returnToIdle():
	stopDash()
	aIdle = "idle"
	isBlocking = false
	setAnimation()

func stopDash():
	dashes = 0
	endDash()
	dash_timer.stop()

func getHit(damage = 1, knockback = true, knockbackDir = Vector2(2000, -500)):
	Global.combo = 0
	var damageTakenCrestModified = crest_system.returnDamageTaken()
	damage = damageTakenCrestModified if damageTakenCrestModified > 0 else damage
	hitstun = 15
	if knockback: getKnockedback(knockbackDir)
	hp -= damage
	updateHealth.emit(hp)
	if hp <= 0:
		death()

func death():
	print("Dead")
	if crest_system.isHardcore(): print("Hardcore se fodeo")

func getKnockedback(knockbackDir = Vector2(20, -20)):
	velocity = Vector2(knockbackDir.x * facing * -1, knockbackDir.y)

func levelUp():
	stamina = level_system.getStamina()
	attack = level_system.getAttack()
	defense = level_system.getDefense()
	maxHp = level_system.getHP()
	hp = maxHp

func getLevel():
	return level_system.level

func _on_block_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		stacks += 1 #TODO body.attackPower or something like this
		updateStacks.emit(stacks)
		if area.has_method("emitBlocked"): 
			area.emitBlocked()
			blockEffects(.15)
		else:
			area.queue_free()

func blockEffects(hitstop):
	Global.hitstop.emit(hitstop)
