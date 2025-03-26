extends Node2D

@export var levelComponent:Node
@onready var body: CharacterBody2D = $body

signal updateHealth

func _ready():
	levelComponent.connect("levelUp", levelUp)

func levelUp():
	print("Player level up")
