extends Area2D

@export var damage:int = 1

signal attackSuccessful

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("getHit"):
		attackSuccessful.emit()
		#if "facing" in get_parent():
		body.getHit(damage, true, Vector2(250, -200))
		#else:
			#body.getHit(damage)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("block"):
		disable()

func disable():
	for c in get_children():
		c.set_deferred("disabled", true)
