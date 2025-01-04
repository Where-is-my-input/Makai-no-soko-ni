extends Area2D

@export var damage:int = 1

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("getHit"): 
		if "facing" in get_parent():
			print(Vector2(2500 * get_parent().facing, -2000))
			body.getHit(damage, Vector2(2500 * get_parent().facing, -2000))
		else:
			body.getHit(damage)
