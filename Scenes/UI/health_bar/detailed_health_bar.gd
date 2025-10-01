extends Control

@export var timeToDespawn:float = 5
@onready var lbl_name: Label = $VBoxContainer/HBoxContainer/lblName
@onready var health_bar: ProgressBar = $VBoxContainer/healthBar
@onready var tmr_despawn: Timer = $tmrDespawn

func _ready() -> void:
	startTimer()

func _on_tmr_despawn_timeout() -> void:
	queue_free()

func startTimer(timer:float = 0):
	tmr_despawn.start(timeToDespawn if timer == 0 else timer)

func setName(enemyName:String = "Enemy"):
	lbl_name.text = enemyName

func setHpBar(currentHp:int = 10, maxHp:int = 20):
	health_bar.setHpBar(currentHp, maxHp)
