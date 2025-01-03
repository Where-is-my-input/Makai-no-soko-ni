extends Node
@export var body:CharacterBody2D
@export var ap:AnimationPlayer
@export var moves:Array[Node]

func _ready() -> void:
	for c in get_children():
		moves.push_back(c)
