extends CanvasLayer

@export var player:Node2D
@onready var health_bar: ProgressBar = $healthBar

func _ready() -> void:
	player.connect("updateHealth", updateHealth)

func updateHealth(newValue):
	health_bar.updateHealth(newValue)
