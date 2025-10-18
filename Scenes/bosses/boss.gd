extends CharacterBody2D
@onready var moves: Node = $moves

@export var player:CharacterBody2D = null
@export var attackCooldown:float = 5.0
const SPEED:float = 300.0
@onready var tmr_cooldown: Timer = $tmrCooldown
@onready var a_2d_hitbox: Area2D = $a2dHitbox

#stats
@export var attack:int = 5
@export var defense:int = 5
@export var maxHp:int = 25
@export var HP:int = 25
@export var xpValue:int = 80

var currentAttack = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing:int = 1

signal updateHealth
signal defated
var hpBarTied:bool = false

func _ready() -> void:
	while !hpBarTied:
		Global.setHpBar.emit(self)
		await get_tree().create_timer(0.5).timeout
	#a_2d_hitbox.attackSuccessful.connect(moves.attackSuccessful())

func _physics_process(delta: float) -> void:
	if player != null :
		if currentAttack == null: 
			if global_position.direction_to(player.global_position).x > 0 && facing != 1 || global_position.direction_to(player.global_position).x < 0 && facing != -1:
				facing *= -1
				scale.x *= -1

		if currentAttack == null:
			currentAttack = moves.nextAttack()
			currentAttack.action()
	
	velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _on_ap_animation_finished(_anim_name: StringName) -> void:
	if tmr_cooldown != null: tmr_cooldown.start(attackCooldown)

func _on_tmr_cooldown_timeout() -> void:
	currentAttack = null

func takeDamage(damageTaken = 1, damageType = Global.DamageType.PHYSICAL, isStagger = false):
	HP -= damageTaken - defense if damageTaken - defense > 0 else 1
	updateHealth.emit(HP)
	if HP <= 0:
		defated.emit()
		print("Boss is dead")
		queue_free()

func startFighting():
	moves.startMoveRolls()
