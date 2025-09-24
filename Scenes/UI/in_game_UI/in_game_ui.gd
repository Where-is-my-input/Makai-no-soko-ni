extends CanvasLayer

@export var player:Node2D
@onready var health_bar: ProgressBar = $healthBar
@onready var xp_bar: ProgressBar = $xpBar
@onready var enemy_container: HBoxContainer = $enemyContainer
@onready var tpb_stacks: TextureProgressBar = $tpbStacks
@onready var lbl_level: Label = $lblLevel

const HEALTH_BAR = preload("res://Scenes/UI/health_bar/health_bar.tscn")

func _ready() -> void:
	#await player.ready
	Global.setHpBar.connect(setNewHealthBar)
	#Global.connect("setHpBar", setNewHealthBar)
	player.level_system.connect("setHpBar", setNewHealthBar)
	setXpBar()
	player.level_system.connect("xpGained", updateXp)
	player.level_system.connect("levelUp", levelUp)
	health_bar.setMaxHealth(player.maxHp)
	player.connect("updateHealth", updateHealth)
	player.connect("updateStacks", updateStacks)
	lbl_level.text = str(player.getLevel())

func levelUp(level):
	lbl_level.text = str(level)
	setXpBar()

func setXpBar():
	xp_bar.max_value = player.level_system.xpNeeded()
	xp_bar.value = player.level_system.xp

func updateHealth(newValue):
	health_bar.updateHealth(newValue)

func updateXp(v):
	xp_bar.value = v

func setNewHealthBar(node:CharacterBody2D):
	var newHPBar = HEALTH_BAR.instantiate()
	newHPBar.node = node
	enemy_container.add_child(newHPBar)
	node.hpBarTied = true
	
func updateStacks(value = 1):
	tpb_stacks.value = value
