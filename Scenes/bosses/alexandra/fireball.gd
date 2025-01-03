extends Node

func action():
	var parent = get_parent()
	parent.ap.play("fireball")
	parent.body.velocity -= Vector2(4500 * parent.body.facing, 1500)
	print("Fireball")
