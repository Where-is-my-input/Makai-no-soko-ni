extends ProgressBar

@export var node:CharacterBody2D

func _ready() -> void:
	if node != null:
		setMaxHealth(node.maxHp)
		node.connect("updateHealth", updateHealth)

func _init(maxV = 50, v = 50) -> void:
	max_value = maxV
	value = v

func updateHealth(newValue):
	value = newValue

func setMaxHealth(v):
	max_value = v
