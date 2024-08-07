extends Node2D

@export var levelComponent:Node

func _ready():
	levelComponent.connect("levelUp", levelUp)

func levelUp():
	print("Player level up")
