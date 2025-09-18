extends Node2D

@export var timer: float = 2
@export var direction:Vector2 = Vector2(200, 0)
const PROJECTILE = preload("uid://coto6ltakml6o")
@onready var tmr_fire_rate: Timer = $tmrFireRate

func _ready() -> void:
	tmr_fire_rate.wait_time = timer
	tmr_fire_rate.start(timer)

func fire():
	var bullet = PROJECTILE.instantiate()
	bullet.direction = direction
	bullet.global_position = global_position
	add_sibling(bullet)


func _on_tmr_fire_rate_timeout() -> void:
	fire()
