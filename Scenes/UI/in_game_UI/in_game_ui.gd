extends CanvasLayer

@export var player:Node2D
@onready var health_bar: ProgressBar = $healthBar
@onready var xp_bar: ProgressBar = $xpBar

func _ready() -> void:
	await player.ready
	setXpBar()
	player.level_system.connect("xpGained", updateXp)
	player.level_system.connect("levelUp", setXpBar)
	health_bar.setMaxHealth(player.maxHp)
	player.connect("updateHealth", updateHealth)

func setXpBar():
	xp_bar.max_value = player.level_system.xpNeeded()
	xp_bar.value = player.level_system.xp

func updateHealth(newValue):
	health_bar.updateHealth(newValue)

func updateXp(v):
	xp_bar.value = v
