extends Area2D

@export var boss:CharacterBody2D
@export var doors:Array[CharacterBody2D]
@export var camera:Camera2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var camera_limits: Node2D = $cameraLimits

var player:CharacterBody2D

func _ready():
	if boss != null:
		boss.connect("defated", finishFight)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player.removeCamera()
		print("Boss fight fanfare")
		collision_shape_2d.set_deferred("disabled", true)
		set_camera_limits(camera)
		setDoors(false)
		boss.startFighting()
		boss.player = player

func setDoors(v = true):
	for d in doors:
		d.setOpen(v)

func set_camera_limits(playerCamera):
	playerCamera.global_position = camera_limits.global_position

func finishFight():
	setDoors()
	player.setCamera(camera)
	queue_free()
