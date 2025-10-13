extends Node2D
@onready var lbl_combo: Label = $lblCombo
@onready var lbl_damage: Label = $lblDamage
@onready var tmr_despawn: Timer = $tmrDespawn

@export var combo:int = 0
@export var damage:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Notifications.enemyHit.connect(reduceTimer)
	lbl_combo.text = str(combo)
	lbl_damage.text = str(damage)

func _physics_process(_delta: float) -> void:
	position -= Vector2(-1, -1)

func _on_tmr_despawn_timeout() -> void:
	queue_free()

func reduceTimer(t:float = 0.1):
	tmr_despawn.wait_time -= t
