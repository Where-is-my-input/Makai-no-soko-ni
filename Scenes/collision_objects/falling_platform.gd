extends Node2D

func _on_area_2d_body_entered(body):
	if !body.is_in_group("player"): return
	get_tree().create_timer(2).connect("timeout", fall)

func fall():
	queue_free()
