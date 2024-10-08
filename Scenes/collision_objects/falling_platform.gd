extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $cbPlatform/CollisionShape2D
@onready var sprite_2d: Sprite2D = $cbPlatform/Sprite2D

func _on_area_2d_body_entered(body):
	if !body.is_in_group("player"): return
	get_tree().create_timer(2).connect("timeout", fall)

func fall():
	setState(true)
	await get_tree().create_timer(10).timeout
	setState(false)

func setState(s):
	collision_shape_2d.disabled = s
	collision_shape_2d.set_deferred("disabled", s)
	sprite_2d.visible = !s
