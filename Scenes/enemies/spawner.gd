extends Node2D
@onready var mobs: Node = $mobs
@onready var timer_spawn: Timer = $timerSpawn

@export var enemy:PackedScene
@export var spawnTime:float = 5.0
@export var spawnCount:int = 5

func _ready() -> void:
	timer_spawn.start(spawnTime)

func _on_timer_spawn_timeout() -> void:
	if mobs.get_child_count() < spawnCount:
		var newSpawn = enemy.instantiate()
		newSpawn.global_position = global_position
		mobs.add_child(newSpawn)
	timer_spawn.start(spawnTime)


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	timer_spawn.start(timer_spawn.time_left)


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	timer_spawn.stop()
