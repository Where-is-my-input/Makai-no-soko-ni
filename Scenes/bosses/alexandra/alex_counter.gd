extends Node

func action():
	var parent = get_parent()
	parent.ap.play("counter")

func counter():
	#Serpent dive kick after
	print("countered")
