extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $cbPlatform/CollisionShape2D

var player:CharacterBody2D = null

func _on_area_2d_body_entered(body) -> void:
	if(!body.is_in_group("player")): return
	player = body

func _physics_process(delta: float) -> void:
	if player != null:
		#collision_shape_2d.set_deferred("disabled", player.velocity.x == 0)
		collision_shape_2d.disabled = player.velocity.x == 0

func _on_area_2d_body_exited(body) -> void:
	player = null
	#collision_shape_2d.set_deferred("disabled", false)
	collision_shape_2d.disabled = false
