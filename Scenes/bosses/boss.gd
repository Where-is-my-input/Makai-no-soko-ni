extends CharacterBody2D
@onready var moves: Node = $moves

@export var player:Node2D = null
@export var attackCooldown:float = 5.0
const SPEED:float = 300.0
@onready var tmr_cooldown: Timer = $tmrCooldown

var currentAttack = null
var previousAttack = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing:int = 1

func _physics_process(delta: float) -> void:
	if player != null && currentAttack == null: 
		if global_position.direction_to(player.body.global_position).x > 0 && facing != 1 || global_position.direction_to(player.body.global_position).x < 0 && facing != -1:
			facing *= -1
			scale.x *= -1

	if not is_on_floor():
		velocity.y += gravity * delta
	if currentAttack == null:
		currentAttack = moves.moves.pick_random()
		if currentAttack == previousAttack: currentAttack = moves.moves.pick_random()
		currentAttack.action()
	
	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_ap_animation_finished(anim_name: StringName) -> void:
	#currentAttack = null
	tmr_cooldown.start(attackCooldown)

func _on_tmr_cooldown_timeout() -> void:
	previousAttack = currentAttack
	currentAttack = null
