extends Node

func action():
	var parent = get_parent()
	parent.ap.play("lunge")
	#var tween = create_tween()
	#tween.tween_property(self, "position", parent.body.position, 0.2)#.set_trans(Tween.TRANS_SINE)
	#await tween.finished
	parent.body.velocity.x += 250
